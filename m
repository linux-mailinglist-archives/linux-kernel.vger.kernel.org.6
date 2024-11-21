Return-Path: <linux-kernel+bounces-416496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D930E9D45DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E67283D97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E561412FB1B;
	Thu, 21 Nov 2024 02:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bs7Fb2wW"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EF5230998
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157495; cv=none; b=SbVYkV4P/2aygx2rReCLOaSR28Og6upga18fOYLeWaVe6BJFsBEoO42kibsKLNXpXG5YHvZvTVCa859HwO+n/D4qT5K+llzNjGZvthwYhrLIE7cdei3xBFmvOAJOjgtVJPBmX4Xo/zBesJ0UhxSju9fwvVo5BQKY6p5kJFb7iM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157495; c=relaxed/simple;
	bh=TspY8DGe+7sN9H6ka3N8Rn55pyh4NQIGNs6B1iMS0co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTXgNrRsHL1ELLgx4RnSS540U+/tVv6iual1l86MICyQUR4w11pg7iqpngGGRA8U1QWkL1+IQ6fnpP3w2Vlt08HfGJtqFxEHH4OfsCTTRtCbyEILywJT0iU+441Hzr5gus+/bnyw1g4vLP8nDT//SOCUbb0C6U/WMMiLocWWNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bs7Fb2wW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa3a79d4d59so52802366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732157491; x=1732762291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wBaXm0DDly5jwBjx4HhlxWKjbcFBnfpTpREoWkZ/UF8=;
        b=bs7Fb2wW4g3fbir3LWl+cHn4gVu+SBw6Cp8g2Ua7k6GOiMQvBFp3ZsdR+qn4M8UGuy
         0gtcSXjypaKhcLIszZWCgJq2r2ZS88sE0DGe4AtykHx/ydSLxKBH7cOA6S2A9glkiZst
         nvYsbaqHn0n7WeBKsETiqRKuTZs88R6ro+rNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157491; x=1732762291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBaXm0DDly5jwBjx4HhlxWKjbcFBnfpTpREoWkZ/UF8=;
        b=C8Il4VflZfQD1fKlt6JJBJycI6GjDKHJF1kl3VJtlNzlSQXi8de1WLpmw95DZykvXt
         vbuqD+8Rxg1C355+WjSf0UNURzHjNLQLgtBBxjTPPE+12VZRI/fezVFcYsDoqSw2vBdy
         MWXjVvFWxdbdhFcQsGEdnRthX4hNw/JJkcyAD8fGDw+tnegbbxkHgKX7Gg2my2A3kwqY
         jev2eRA6a4n4HStzvydWyp/l42JYl2l2EzYgOn4L3P7SwAV28tlF6L8PkQcEjOakudPv
         xrngcm/hFrqM4T1U4eGDkF2dsqWhbR0GA6/Af2YY068mw4nd7HCc73blCoG6XvAZVVYp
         PHZA==
X-Forwarded-Encrypted: i=1; AJvYcCWUi51UjeQPrpUwRAWKXyw4dJ7PVEQ2CAcjU872Pzqi5uCFEXDxUSTcEgaSjlFmEXEb5KELqfIkPtzb8Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4GE9rceKvupGxOhb9P8sVezIEM5XN0bHy1QcBI2vE+OhB9fZ+
	ULxWWETKKmESLZQM1KmbiE7SmQYRoC0OJTmhkTj1ebUXioN+R0Fmsuu/qcwD+qY2SkFyx72dq9a
	PdjA=
X-Gm-Gg: ASbGncsIYxNc/KYrimC5dVs/ORa1NAIieIBZ6ih5ES99V1KYInnwOVaYQr0LzRrxxsD
	hTF/rERBq1Ewct96ZHKI32BaUSqsWJc5tt/wSkOPbqGOgSiy1J/g/IYIrqyX516Gf6BbICdtc6N
	l7b/4yurarXDP7zWkp2u/RpKezu8ySJQ0PhInNQSSurJ++5IEIdSDgsv2YrKeRBJcnA/ATxlKS+
	ypXbCjq00qa9tqdS6Q5rRBp8J933IFt96ZtGRTZsV5wsWBF60lMPuLeoGMkSqtQqvQzjcg7nWVj
	rqKC/mBzZJqfpuDiaY0EqN7f
X-Google-Smtp-Source: AGHT+IEfcKFv2tO+cWFtX8MsWJzkua8BYRNx4didaO0AuZJbUqylm1ZQicQ9eV6CkMW3YWrOwAlszQ==
X-Received: by 2002:a17:907:9285:b0:aa4:9e02:66f1 with SMTP id a640c23a62f3a-aa4dd509ae3mr458759866b.1.1732157491415;
        Wed, 20 Nov 2024 18:51:31 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f418017asm26188066b.58.2024.11.20.18.51.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 18:51:30 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa3a79d4d59so52798966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:51:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfpTYguPEGy0IJNBI7ysl1JlYPD/ly2gc6MPJMHlNfRKzBAvubuVE0h1nYVxOKMwyP0x6Oszsn8jeYcEw=@vger.kernel.org
X-Received: by 2002:a17:906:fd89:b0:a9a:17f5:79a8 with SMTP id
 a640c23a62f3a-aa4dd54835dmr410001366b.13.1732157489010; Wed, 20 Nov 2024
 18:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411190900.FE40FA5@keescook> <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <CAHk-=wjPpuThc4Wbtk-aUz4buUSH9-gvsmjT5P3=2tU_Kz8oVA@mail.gmail.com>
 <CAHk-=wh4k8ks_oq4v=LXxidXZ+r-_er7cORjNzySjDaD8Xc9ng@mail.gmail.com> <20241121023619.GM3387508@ZenIV>
In-Reply-To: <20241121023619.GM3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Nov 2024 18:51:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj6kh-N4n1zZEzJx+eCO_Wf2JGOGqb_Ndi6oo2QiEMmCQ@mail.gmail.com>
Message-ID: <CAHk-=wj6kh-N4n1zZEzJx+eCO_Wf2JGOGqb_Ndi6oo2QiEMmCQ@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dan Carpenter <dan.carpenter@linaro.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Nir Lichtman <nir@lichtman.org>, 
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, 
	Tycho Andersen <tandersen@netflix.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 18:36, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > If you want to be extra careful, you might surround it with a
> >
> >         read_seqbegin_or_lock(&rename_lock, &seq);
>
> What for?

Yeah, probably no good reason.

>         char name[something];
>
>         sprintf(name, "%*pD", sizeof(name) - 1, file);
>
> and be done with that...

I think you might as well just do the much cheaper

        rcu_read_lock();
        strscpy_pad(tsk->comm, sizeof(tsk->comm),
                smp_read_acquire(&dentry->d_name.name);
        rcu_read_unlock();

and be done with it. Using snprintf() on tsk->comm[] violates all the
rules we have for it, and while our rules aren't great, *that* one we
shouldn't do.

                 Linus

