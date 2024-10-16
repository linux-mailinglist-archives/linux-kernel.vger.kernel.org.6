Return-Path: <linux-kernel+bounces-367060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B382A99FE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F5A1C232C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4677213635E;
	Wed, 16 Oct 2024 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSFTIpZb"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B0884D13
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041791; cv=none; b=f8vmMfVE98CRyOtVE4U/9RsjyQh3VEtyCVv6yjF1DwXv5H9pzOOPmq0byzgyWdk4Wl3T4byq/VieuVXosgy3ekUfcrDipBkkQ6+D7sCQFdm4Hr1P/Z52ddnZpOmGDfqbESm316/3/vtRTmLVBYTgoRQQUUf9mn+vyz0ZZhPVF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041791; c=relaxed/simple;
	bh=aKMOa2lsMcZ+PzeFhDC9/s5MDDTvDylmgOWrFIZX/mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cG1mBCEsjLD0P/YDp5zyhebXmZcCLXqpSUAcXR7tYT2VoS2TMBHIhL2XQse9TmE80GK9wito37/USKsaQp/f9+kfbbIJ56JCP4jFhLoiJLZb6NLM9ipiedOMReR7Beflss5KNJPn/NmsopglyfYOlSlNZWFkBk/GvkuQ/uD6QOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSFTIpZb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso183596966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729041788; x=1729646588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKMOa2lsMcZ+PzeFhDC9/s5MDDTvDylmgOWrFIZX/mc=;
        b=MSFTIpZb2HNKhOW7IY+Mal7DtWGSFphZFEbUqc8O1ALbn6XUbKAmQrLfKAoJJJZXcR
         HHjkfXpHK1dW75rtDd8OPNZO6kWdq8pDpzk0Yu3GXFly7jt/9XofjP6p5amIgYacnGsr
         OYN/egF9ZoFKOXijHxyDIOw29I637Bmi14/UjGb1YpKNhbrjiP24/NGkU54xqSZ9w+ai
         hS050iPK5X3ecAhWmeJJBjMRo5AG4McD/4et3ITfOFlwYsfajoNf9Z5A0cOBdI/JzM0x
         bgG7Yfn37NkMEv4OTyZCuPOuLjyxh23sUJKFfqOpAo8yxkmCMP5nQ+bEOJyM0h4FvzT1
         X7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729041788; x=1729646588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKMOa2lsMcZ+PzeFhDC9/s5MDDTvDylmgOWrFIZX/mc=;
        b=YroYjGXDD7N2I/NaVJRJL2s6IdFWDJrE5i9adZFMu/5cT1ZlyWCRVO8wZAe3tT7H/4
         gsN/9lrRLh5RCZup/q5XfGcOZLwT1tDlqLIAEbvhfShUr9GZB8GMThb3hpDONa1P2NMP
         hFyojd/xWIs8AVp2fBHRwMKvmmphNBsflk32BEvq3LBjqhr1BbxUV3M6G1EamI+b3rI1
         MJIuTVSjoSbjE1SpQNloCXPOrqVG+wl4MFvwmsER2+g1YDgYDda0EJMbHaceSGkf6mFE
         4hh2lEzCWnk9iySlW2yeR+49J5u1StK6Zvz/HpTcAfeP/cELltoe4seyiQG5TqmA4+r7
         7zaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXId4Ox17Awbl7Tm+iq5amPRvspO1SMrDX35bql2AEuZ9+wTjiIdKjwHx0w9kGXJig9QI4ZQ6+Aalg1Ldw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ1zqPx9S/nVqt+cz94EU0artBiX0RDTjbcm67X8bS0v4KtiwH
	AiRMJAgGkH2wxzMKQb0oP1rcvscb1Nmufd/2gwjhIiAOarVRxSgzskYZfiblQ33UvMkkfc3YX+T
	1XNvuvDBxyOYdja2j6cyY40UIWHXui6sQR/XdavRljNjWy2whQAw=
X-Google-Smtp-Source: AGHT+IHdkfklJ4F1OwuM1/1DqBmbkhdk3WE3vsIugWlT33b5VzThcJq7LfO9xnbbLXiMKZS361OAmCHXw1jqbZb5Hjo=
X-Received: by 2002:a17:907:9709:b0:a9a:4d1:460 with SMTP id
 a640c23a62f3a-a9a04d10662mr910288566b.63.1729041788043; Tue, 15 Oct 2024
 18:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZvV6X5FPBBW7CO1f@archlinux> <3E304FB2-799D-478F-889A-CDFC1A52DCD8@toblux.com>
 <A499F119-5F0C-43FC-9058-7AB92057F9B3@toblux.com> <Zvg-mDsvvOueGpzs@archlinux>
 <202409281331.1F04259@keescook> <21D2A2BB-F442-480D-8B66-229E8C4A63D3@toblux.com>
 <Zv6BEO-1Y0oJ3krr@archlinux>
In-Reply-To: <Zv6BEO-1Y0oJ3krr@archlinux>
From: Bill Wendling <morbo@google.com>
Date: Tue, 15 Oct 2024 18:22:50 -0700
Message-ID: <CAGG=3QVecaZfoRrjToToq8=Azh8M0vQ5Q=V8dfhdBnDR8GWy5A@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] erroneous buffer overflow detected in bch2_xattr_validate
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Thorsten Blum <thorsten.blum@toblux.com>, Kees Cook <kees@kernel.org>, kent.overstreet@linux.dev, 
	regressions@lists.linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 4:33=E2=80=AFAM Jan Hendrik Farr <kernel@jfarr.cc> w=
rote:
> On 02 11:18:57, Thorsten Blum wrote:
> > On 28. Sep 2024, at 22:34, Kees Cook <kees@kernel.org> wrote:
> > > [...]
> > >
> > > Sorry, I've been out of commission with covid. Globally disabling thi=
s
> > > macro for clang is not the right solution (way too big a hammer).
> > >
> > > Until Bill has a fix, we can revert commit
> > > 86e92eeeb23741a072fe7532db663250ff2e726a, as the problem is limited t=
o
> > > certain situations where 'counted_by' is in use.
> >
> > I already encountered two other related __counted_by() issues [1][2]
> > that are now being reverted. Would it be an option to disable it
> > globally, but only for Clang < v19 (where it looks like it'll be fixed)=
?
> >
> > Otherwise adding __counted_by() might be a slippery slope for a long
> > time and the edge cases don't seem to be that rare anymore.
> >
> > Thanks,
> > Thorsten
> >
> > [1] https://lore.kernel.org/all/20240909162725.1805-2-thorsten.blum@tob=
lux.com/
> > [2] https://lore.kernel.org/all/20240923213809.235128-2-thorsten.blum@l=
inux.dev/
>
> This issue is now fixed on the llvm main branch:
> https://github.com/llvm/llvm-project/commit/882457a2eedbe6d53161b2f78fcf7=
69fc9a93e8a
>
> So presumably this will go into 19.1.2, not sure what this means for
> distros that ship clang 18. Will they have to be notified to backport
> this?
>
FYI, Clang 19.1.2 shipped with your fix in it.

-bw

