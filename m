Return-Path: <linux-kernel+bounces-370131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB0D9A2827
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A9E1C21730
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58741DBB13;
	Thu, 17 Oct 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dASKvPGW"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6F01D95B5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181535; cv=none; b=uDfv3/Dpv8M7p0xGLAuvaDi75x3DoZhvRYIjMaE3JBazZz+FNZXhtxlSnf8RVDTC6zRB7sjdh/AsjwbqPxhO6qGQQsZLpRMZ6Vnaow+wVVCZUCyLi2zi69ACjZyKeIMv+L88jczCK8B4LApPpyRyERQCwFjOpZfeHuEeOpMOH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181535; c=relaxed/simple;
	bh=H7ByblHhvfkTHAIRxWG1YEC5DM7h3FKQHs+hFBtx9oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAdNR831pQ+HdXsgVK/1O0lg/rKRTKiVPpbW4jv5W63bU9A7rkbOqa4KVOMtjzbg7YQ7hn6jrz81AzaChi3jd1Cx6Vk9/4m8g5Ph/59LFf9YpSfkmma+JKmAehOWTD8WZIIw6IC8wR90ukfhE/EB98Q2MNP6h681DSJPwrdiAlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dASKvPGW; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2888bcc0f15so129380fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729181533; x=1729786333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mnd/uBBD+EEhRp8rXkoooYzQt3SSgVvcLoqmhOm8/d8=;
        b=dASKvPGWaniZmm18Hd1P0kQ2CIt68k+/G89RHhzkfTD1GNiGS+n5+8SAd7+aLVYp69
         g59jIywJNrsiSrfdMxaf2CuGl5CtzyDPO+DFoPw/TxyaYtFyagXk/HJXV5VBgL6owtSq
         VddsEf7VjH8OcP7Yn4ko9+Av3jR0XFV8AHYhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181533; x=1729786333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mnd/uBBD+EEhRp8rXkoooYzQt3SSgVvcLoqmhOm8/d8=;
        b=lrDEmO55aoHXlyuGSjnCEVyYKH7iHOa02N3SGC6rH2Ewq4ASjMkMqJy1pXSr/92/1X
         U4LchHoJIOVCoG+nsJ6mSYgAjdB+UzAQc9G2dfMcOGrrFrwNQMJyyPzSoFgNJVuOjKjo
         BJ3hNFxSoSp+2Yq6alBl13YNdIv1sDBVNveo9i5eow5aG1CiCYdBkoJe76akQjjCE2Jw
         yHuULFyx5DGYr/jmh50Wd/lKz3nweRxAb03QcTZ3t/EOZMRK1ImmYWvoanfOryBjE/vu
         uXjr3Rt2KEa8AKApIFBCSLYJUpRsVj7suRWRTPFSNmTnuAr9fzeXgJn2J3z70ktMii0F
         vD/A==
X-Forwarded-Encrypted: i=1; AJvYcCWkBgBi+xoD4waCuxNPK9V1Wc/YUjZDtwAPbw1LA6M+ll34VNVaTxjLMLMw0/aYFP0hYwabvAt8Q4NmWuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznyga0/C+ZcVJDQjMWxR40XX1DWtlGDUg/apsqVPdlL1ydOvH5
	yVry7b80xAdzOYB8Esfo6Qv+LahtHMm91b+z3zy9r3dmqh4TswjsXlFLZwR7PgPkxEcVlrIDu8N
	NMnITxAWN6wb1s0eBqPNIiLCkNtTBRHZWDYDi
X-Google-Smtp-Source: AGHT+IE3Fsi07N7Rh0MbMb6DVuEVuZxfPPNrlyT9dYEiNnKn8vIax41O2lEbT4g3Cv65s3OSySkf3Zds0w4WBJKsjCg=
X-Received: by 2002:a05:6870:568b:b0:27b:9f8b:277d with SMTP id
 586e51a60fabf-2890c8619a8mr1002074fac.12.1729181532946; Thu, 17 Oct 2024
 09:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014215022.68530-1-jeffxu@google.com> <20241014215022.68530-2-jeffxu@google.com>
 <6r5sxlhfujr2expiscsfpdjtraqlvy6k3cznmv25lo6usmyw7x@igmuywngc5xi>
 <CABi2SkUfXrRLg7+ZrLjMEQzh4FtU0EAfckdiDuza1mFKzi0SAg@mail.gmail.com> <20241017083752.GA15167@redhat.com>
In-Reply-To: <20241017083752.GA15167@redhat.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 17 Oct 2024 09:12:00 -0700
Message-ID: <CABi2SkVAXhqb+r5HzD5fWnHs1g2tjg8CShXX0+xnagqeVXrttA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] exec: seal system mappings
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	adhemerval.zanella@linaro.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:38=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 10/16, Jeff Xu wrote:
> >
> > On Wed, Oct 16, 2024 at 6:10=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > > +     exec.seal_system_mappings =3D [KNL]
> > > > +                     Format: { never | always }
> > > > +                     Seal system mappings: vdso, vvar, sigpage, up=
robes,
> > > > +                     vsyscall.
> > > > +                     This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MA=
PPINGS_*
> > > > +                     - 'never':  never seal system mappings.
> > >
> > > Not true, uprobes are sealed when 'never' is selected.
> > >
> > Thanks. I forgot to uprobes from the description in Kconfig and
> > kernel-parameters.txt, will update.
>
> Jeff, I am sorry for confusion.
>
> No need to make uprobes "special" and complicate the logic/documentation.
>
> I just meant that, unlike vdso, it is always safe/good to mseal the "[upr=
obes]"
> vma, regardless of config/boot options.
>
> Please do what you think is right, I am fine either way.
>
OK, in that case, V1 is a better approach, using the same config to
control all system mappings.
I will send V1 to revert that.

Thanks for clarifying.
-Jeff

> Oleg.
>

