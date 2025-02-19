Return-Path: <linux-kernel+bounces-521593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0014A3BFA9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753373A8AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039601E0084;
	Wed, 19 Feb 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGKqHnOS"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC61E00BE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971100; cv=none; b=Z+yjCAffiztfO5sVc/oBilGKCaZNVbYcNgypmGfN5QAMGhs4enYq8rHJuwovA99R9Nk3C9KcXgrBMdwEOlwoaln3BrpKoaNjh0TUkGcVnsqknF0Hv393x3MgcjQYKv3Fsm1lOV6LaLoVRveOCkJDOiz6jvbq/YJbUFkYSinaU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971100; c=relaxed/simple;
	bh=vvjONCdWAd0bONpWlbDpR4yguPyfVQgDMtTdsGyKd7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=az+VncYXZUNA61BDH01C6S04YPdj9rzdarA0WMsawuH5mUBcJX66fc+3ep+e6zmJIZnCsORmZgK5zcGHx5b3tI9OeV7sViPAiZkwIDGCpp6TxuCyFXUcNSwHc92wO6uGzAcYdDJgATDF2TbgPgpc4QOTuSvZhSJDygEgj/804PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGKqHnOS; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5452ca02bdbso4951578e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739971097; x=1740575897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvjONCdWAd0bONpWlbDpR4yguPyfVQgDMtTdsGyKd7M=;
        b=lGKqHnOS/7tCYsJN/b+W4Bw21G+OFGiJ4eD0AjX7JFP5W17qR+TIhFttg+3tGpfX/3
         1G4TOGH5TKXDhFlqCOy4vAzyJXrmMz48FfQjFHdd3cTBtaikdRVDmaULBo4sild4HsUA
         3G1gZ41La7nyJAwMRpJGHuVbbIZk3yg/z0VCSuxpQqNSsF2YZWVJvZeUtGxtoGExSf4q
         L9T8AwzmXJUSrXNeCwGLSy38xV3o344+jokyOeALzI77UIVuiuQXX1CimLcyGDxuAfDw
         HPa5TyGVPBM8kuXlm/Q8gQ1Xnhxfr48ZCZkIMcIrIO4iHog5x+cno/2wI1E3uQx3GTcv
         YmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739971097; x=1740575897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvjONCdWAd0bONpWlbDpR4yguPyfVQgDMtTdsGyKd7M=;
        b=HlrTBdhbMrb3MRw0/yp377Dr07mbA1pmPTLkz/Edaok++ZLXjTw6deE8daiSvcVIbv
         YXKQl1CrZqsCpjRnpOyEPPg9UzEYL/HhomgsktxUbq551PIsAME4gndinCHR0rjksVNu
         aajQnaZJZo6VesXYF/wUgjhvHvgI55+9moVXQntXqT+CabXq33uVL5++zxtP3VPkcuUK
         Sm7mxmtv0Ee8genJ0PPjP36r4vNsPnhRd3d0QeYBbzUi8Be8J/C79k6HwNc8nbyshrwD
         qMGBv/rcT/5epMJPFXSKm43YOGGip7hwWOaG5KUQ98KQvgfRcuUyseqsClqVDXIFxcjS
         msSA==
X-Forwarded-Encrypted: i=1; AJvYcCUtNn511ILxVLRsrkb67mOQfnFjIVhg42TtfarxfOZERBqGqe5fD9OlCG/5qDDwhh3gcR9L+CuCqcahYzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhxz0/qP7meS0hDVL9SeZJJdEHJZRlQRWcreaQiMWRAPjRB2Ht
	qFqD6U0mMmLZWa1wVvMhSJ0A1csyJBQGrqmgEaGTOZ6+tBZEM/0JcQrsOsKC9LYtrBolNsQFGRs
	h/LCdESmZfK5tiNWAAbcwrBJG/w==
X-Gm-Gg: ASbGnctPcwt3cCJjf4H0vvFnK4sidRIdISnuHX9dxT5ckWdkp8cMV6CtmejcAvdmTcS
	7Y8LekeJOji1Jot0Ymri3C7ZfWg8K7l32J2XQhleZ4vXAHr4LcwM48ySBfcP3BNg51XwdoUVAwx
	PKRTm3iiPT3ZA=
X-Google-Smtp-Source: AGHT+IEMgw/NcatHu1aOry55gR7++/jR7h8iG0U4t3o9h9gsA7E8jegA0is4HconJKrfoRV2bpHdRj9zA9aycP50lUc=
X-Received: by 2002:a05:6512:3da2:b0:545:5bd:bf42 with SMTP id
 2adb3069b0e04-5452fe86da2mr5942707e87.36.1739971096575; Wed, 19 Feb 2025
 05:18:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <Z7RRZ0jdqsrADMm0@gmail.com>
 <CAFULd4Z_QoOLKCOawyeFtRe6V4+oaaGxfQxav9dS-Di-Ne7tfw@mail.gmail.com> <Z7XE0P6ZFHxtlYXw@gmail.com>
In-Reply-To: <Z7XE0P6ZFHxtlYXw@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 19 Feb 2025 08:18:05 -0500
X-Gm-Features: AWEUYZmc2ypkeP8xo8NOp4WCqY1yPlulw7YrXObAM5XiC1xZSTyWNuWyYNpBEI0
Message-ID: <CAMzpN2gyhEnYsimxLhLNPc4HTpVdRGTiBfm9pXiFTL6_3-O=sg@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] x86-64: Stack protector and percpu improvements
To: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 6:47=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > > Thank you for doing this series - it all looks pretty good from my
> > > side and I've applied it experimentally to tip:x86/asm. I fixed up
> > > the trivial details other reviewers and me noticed.
> > >
> > > Note that the merge is tentative, it might still need a rebase if
> > > some fundamental problem comes up - but let's see how testing goes
> > > in -next.
> >
> > I wonder if there would be any benefit if stack canary is put into
> > struct pcpu_hot?
>
> It should definitely be one of the hottest data structures on x86, so
> moving it there makes sense even if it cannot be measured explicitly.
>

It would have to be done with linker tricks, since you can't make the
compiler use a struct member directly.


Brian Gerst

