Return-Path: <linux-kernel+bounces-524430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC9EA3E2FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2175918852CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B4C213E67;
	Thu, 20 Feb 2025 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUsX/oyI"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ADC2139CF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073665; cv=none; b=WxA2yIHN7HYiOuhVJOI/FLM2vDq6gqk4DZQ2JXGk9omd4DMGfz5zyDbo0AZHA+wf1Nhxs5WwBa7LtCphhvLkZ0VVn5VHEWy0vtU/JDY+cm27WW33Tm7QWq3vn1rthPb2MAZAWhfg95ynR/j5/Kb41a415AP53TB/3cQ1wvv19q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073665; c=relaxed/simple;
	bh=0zq0dkRUGv/0HbmH52x9zyrPz4DopGwyxhsr8Xq/SzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEvaWnV5+wEo5Ri9EiOf2bxNXG14ARCf22kLGVWps4zgtKin5eAclrHtKHygKpqQGFaIKBQETQ1Dqp8O6+jShO+8a/W01FuULU95zB6S+bg/lsNelhOQkrkQagdMctnBCepZ4WqNhz9NWOGGaiTwDDyF8LfoD8v/tWSB6/mFHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUsX/oyI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54622829175so1183481e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740073661; x=1740678461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxYT0HNC4gc1Vf5gQrB7+kruw56VVSgI0SSDMrE+O84=;
        b=QUsX/oyInXF+UTgPzPHQWSLcikhI5jjTcWDlJVJk4IdDig6liGEUqjHbfVeAJf4UNF
         YJayLwKPTEdNRzQnuAWlLVzOAKgFEGRhkDMqjJ10TYHpp5mMS8LPPAevL/xRDOaHfQjh
         BEWiL6AhOmGD9JRvF5EbyaRaoxzrVi4+wr/p21vazx0J/Z+nTF6ukGdEXmvOnat3M3Pg
         aCzj4vZALeUADwMh4OZ//sXNqjBNh0KPH8pog0vd3crgv5DBjUwvOrIzKpT9zqPs8A7+
         F4/a6jCL3lfihezSekHn+Y54YMiMdOwXnZBJa4ndPkV3TvJilFtxnuRkSGrsjV2o366D
         KDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073661; x=1740678461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxYT0HNC4gc1Vf5gQrB7+kruw56VVSgI0SSDMrE+O84=;
        b=T1PdkZOQ3QECyVPOv5DeGdIdIWoBOyQ09y3wIbfpBfgAVrPslqE/NIrLFHNDYHHOm7
         5YvGOTWMWlEI+AfSKoAuEZIGScw0wvu7s1zxu33e4zNVZwh85ENFlGeP59z42Kpj7wnG
         xXH5Ms7zpSkJeBeFH4azy8ez9cldG+tp83NUrNK8U+iD4WZVSHwJCaf1guwEP+Ho81pd
         7FgpNZhuCW0m3+7oEdJsV9XKePeUD8icgJHzDq24EFzGtulbCmP+lYks5m1ctcjFU640
         FWqRIGDnr7QVqPbWLlYiPQiF/4tHTn19mxGGlU08UGoVjMbIu/wyY7eadGAp+YLyf8o9
         frsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmrB1gMtkGDOp/ZTv8dpATPXi0MFGM4eWp/EKDvQpHrmY0hASBKKdjvI6lkKR8HKuVJTWOdwsaV5Hzla8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHHDu8ox4wq3rdgxJwZR82DW6sG7B3sJ5QqFG6Oe1E3KKWz7j
	4IDSnhBVaKqvk52r3nUwWMfn3owcHUkLeznXHOLgo5ACGHR2jUBveWUjiCR+lf2tyjcEuPLkeHE
	GXP+Q86hBpcTfGPUh4BhTl87OwA==
X-Gm-Gg: ASbGnctVvSkUWp/mDMp2nhAy0LRgdnfLkHjzbHY67iAXVzvqXVxnkjw27XZ+DtzM8b8
	KByIEroYHR894TJKFvgs/MQ5rEO0e6Ip+11JC1Ns9xoOk5NBuyBuZlO2A7cAaK4zBKodaUrkz7z
	NvrycXdFTkL8Y=
X-Google-Smtp-Source: AGHT+IEosavQbvhXNziKW7CvnrJCXfzOnW++DMVALOIxRuVPDI/4cOtjJidvORCX+emlNRyJaWtt7uP5yqPld8Guy8I=
X-Received: by 2002:ac2:44d8:0:b0:545:3032:bc50 with SMTP id
 2adb3069b0e04-5453032bc53mr7158154e87.19.1740073661335; Thu, 20 Feb 2025
 09:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <Z7RRZ0jdqsrADMm0@gmail.com>
 <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com>
 <Z7XE0P6ZFHxtlYXw@gmail.com> <CAMzpN2gyhEnYsimxLhLNPc4HTpVdRGTiBfm9pXiFTL6_3-O=sg@mail.gmail.com>
 <CAFULd4ZQ8VoKvQ7aOgcfeLNROM4-rDYn=wHo=FYMO8ZkuQeSAQ@mail.gmail.com>
 <CAMj1kXFgfbLqVkcs2T8QHRKKJ0X7+mLd-bNjricfd_niY-dxRA@mail.gmail.com>
 <CAFULd4aYjnWzWaN8WA0LetN1Li7F8MY3qnxbhY8=tNFxqHCP1w@mail.gmail.com>
 <CAMj1kXGG4J76o17d=e4jv-5jjzcSGyZdKRcNNB17SkCqD6+8qQ@mail.gmail.com>
 <CAMzpN2h=Mc_7MNg5RiqxEvchV_BGAiThG4a5_Xt_HHB=0+vmEg@mail.gmail.com> <CAMj1kXHfg5gAnrnEMb-6dwN_PY3KycjY__JL=exgtWK9q3=XWA@mail.gmail.com>
In-Reply-To: <CAMj1kXHfg5gAnrnEMb-6dwN_PY3KycjY__JL=exgtWK9q3=XWA@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 20 Feb 2025 12:47:29 -0500
X-Gm-Features: AWEUYZl7qPotPxpx4OXvrmw6x6GbohqS7SGLSXI9UOYrZiSiI67FZFrspiIDjqs
Message-ID: <CAMzpN2iK97iWVH7+c2YqB_66sfXdKnmcyQN7QxtBq-HgD5KJ=A@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:36=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Thu, 20 Feb 2025 at 18:24, Brian Gerst <brgerst@gmail.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 5:52=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
> > > On Thu, 20 Feb 2025 at 11:46, Uros Bizjak <ubizjak@gmail.com> wrote:
> > > >
> > > > OTOH, we could simply do it your way and put stack canary at the
> > > > beginning of pcpu_hot structure, with
> > > >
> > > > static_assert(offsetof(struct pcpu_hot, stack_canary) =3D=3D 0));
> > > >
> > > > for good measure.
> > >
> > > I think this would be the most straight-forward if there are no other
> > > locality concerns this might interfere with.
> >
> > I'd prefer it at the end of pcpu_hot, that way the disassembler
> > doesn't latch on to the __stack_chk_guard symbol when referencing the
> > other fields of pcpu_hot.
> >
>
> __stack_chk_guard would no longer exist, only __ref_stack_chk_guard,
> which would be equal to pcpu_hot.  We could just call that
> __ref_pcpu_hot instead if it might cause confusion otherwise. (We
> can't use pcpu_hot directly in -mstack-check-guard-symbol=3D for the
> same reasons I had to add the indirection via __ref_stack_chk_guard)

That works for me.


Brian Gerst

