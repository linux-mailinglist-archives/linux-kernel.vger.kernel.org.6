Return-Path: <linux-kernel+bounces-236348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AD891E0C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C80BB22073
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029CD15ECE0;
	Mon,  1 Jul 2024 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDAyEB6N"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE361CA9C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840865; cv=none; b=hhAGaCu98Gr+m6ibt0Kk2DBtK0DnTyFNoVabFSh738K2lqmZn0M6tsJxtXi9QW4m9mH2VMT7iFw2tfecr8f9+L9gjkxAgNAFD80zeO9GfVu6ycRw+6tP+wY77rk7fEOL2EHscE5vqbf+6bq8U9NnnPGVoUrHul3cfUUt2zH3C0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840865; c=relaxed/simple;
	bh=9+9V2bXFQ9Bx9R52IP1NjXmiX1PMdyibPsUY7UTJaas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5KIN/LmcwQKnfgh+mtX+OIghU27Zamzb2tZTJXkSCURQIFTfcZI8x2k/H3EyH5YYOGQbmEeRty4SMO66oEpstLu8VvFsGMcvUs4xiudywXqjB8me4s+MAp6MK9tZZjz8DMn3TF/mlEmCxSnicuMapHdMxXjqPyOvs20KVW4Whg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IDAyEB6N; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-80fa1509989so1574887241.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 06:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719840862; x=1720445662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nF71EHXFkyHVGuCXiP4aYrq6taOjaORROM/h1AwGKLA=;
        b=IDAyEB6N5K5Li9UCwwVylUbdExPRhVeQOr+eUm9zzIZG5s+fDIGWPjAMZb1RPsdgxb
         XLFoohM4GNSYBkLiaALw801ojBDelJjjqEKENJVTZcX17cc+ZY0HcVSobQcIQQBaaCyR
         eJwwaZ1Nagc5KEuJrV5j9GZ5iz8Jiy8RjiCOcQkBYeofFG8xwztr2yEJPcPr9Q+3mNer
         ZRW+rEpxqj5I5RgnzXbySGeS8mg8/4vZueD4gppweqYznKLDexsU13EhBQ07YP/UFE1g
         LsW1cOsP21UR2vjBpLZN72KTJ9yX2seewMXzBrJBe2YIC58xDs8bb4bDHMnw0lomZPn0
         AXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719840862; x=1720445662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nF71EHXFkyHVGuCXiP4aYrq6taOjaORROM/h1AwGKLA=;
        b=pB5G+6Y8TIvZ7qwaS81FH36fQj1QCmA64Q2KuC6oylhjaQDcwJcqxC0aaPN9XcVaJs
         Ilw7xA/exNaxZ0bxhJKgXvT6p5f3Pvg9Q8ymCBnQicuCAyvCFsBuWRMYCOntKx0HeChW
         dGjR+xaYa77+Olf1UJAT0zNKb7AICH+55i3QabK9BNrKEL1eEmTZjLIWjqJ4nUnsUEV/
         /DOGhk0Ne3MxKDdR6icKZf6Worfx5AKwiHOOALwVnLAAEYNPgruCWPNs0B8KjY+muxII
         joujv6sGlY5pJ9Xygo0+8NlY3EBk3f/UtjAQ+FDiRIL+ooaGGRgD4vbHxovGZ0vGwwIn
         mieg==
X-Forwarded-Encrypted: i=1; AJvYcCVc9EWo+hvd7dPSUiJe4mkMpVIbZpuRgZSmM7SgpsPg7d7n9u5D5ObUV8aawPnVZ7HOKZPtc9BzaLYvolcS9Y7CS9ev4VOjy6+mWKfG
X-Gm-Message-State: AOJu0YwY0VIgCKw+uBE3D4SNpDnPugL6wG03fyJMsAQlpYw1MiJK1wKC
	EReSifAhoHrnfTE6Tg85Z3Wla5WUi5eUhLLL1PKiqnsPWYrYIV1t0lcC+uPZcx4yQzoe8PpholJ
	GGl1+IoUYVA+mZXW2fHmgOQv8x3th79zu+JdMpQ==
X-Google-Smtp-Source: AGHT+IEi91/OioUckML3e16qf/5FwGqwAJCndr2RrL0tA44bCDWr7zkEAKyB2e2ZdEb99op+GJlsVEiETTclvMwxUvQ=
X-Received: by 2002:a67:e291:0:b0:48c:45e3:16e0 with SMTP id
 ada2fe7eead31-48f9e890cc1mr5239072137.9.1719840861068; Mon, 01 Jul 2024
 06:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsXsbHp+0cWoTjEhkpANOav=GLSjPx5ghtUY-FjMPyoSQ@mail.gmail.com>
 <145b39a0-da05-4c60-a019-c1a6211e6c77@sirena.org.uk>
In-Reply-To: <145b39a0-da05-4c60-a019-c1a6211e6c77@sirena.org.uk>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 1 Jul 2024 19:04:09 +0530
Message-ID: <CA+G9fYs+RfnttPg7E_TAGW4sgnLOuvUQnZj6kHsXeRy=JEMOcg@mail.gmail.com>
Subject: Re: Mainline: v6.10-rc6 boot failed across all arm64 devices
To: Mark Brown <broonie@kernel.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Aishwarya TCV <Aishwarya.TCV@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 17:42, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jul 01, 2024 at 05:28:29PM +0530, Naresh Kamboju wrote:
> > The mainline kernel v6.10-rc6 boot failed across all arm64 devices and
> > qemu-arm64 and no crash log found (earlycon) did not help.
> >
> > But the defconfig builds boot PASS.
> >
> > The boot problem is with defconfig + Extra Kconfigs and builds links
> > provided in the bottom of this email.
> >
> > The boot test history shows that,
> >   GOOD: v6.10-rc5
> >   BAD:  v6.10-rc6
>
> Other CI systems aren't showing this.  I'm guessing you've updated the
> toolchain versions you're using and are running into:

Our LKFT tests saw the same bug as #31924.

BAD:
   "ar": "GNU ar (GNU Binutils for Debian) 2.42.50.20240625",
   "as": "GNU assembler (GNU Binutils for Debian) 2.42.50.20240625",
   "ld": "GNU ld (GNU Binutils for Debian) 2.42.50.20240625",
   "gcc": "gcc (Debian 13.3.0-1) 13.3.0",

Good:
   "ar": "GNU ar (GNU Binutils for Debian) 2.42",
   "as": "GNU assembler (GNU Binutils for Debian) 2.42",
    "ld": "GNU ld (GNU Binutils for Debian) 2.42",
    "gcc": "gcc (Debian 13.2.0-25) 13.2.0",


>    https://sourceware.org/bugzilla/show_bug.cgi?id=31924#c9

We are able to reproduce this bug ^.
The gcc-13 builds failed and gcc-8 builds and clang-18 builds PASS.

> and will see this with other kernels.  It's probably worth testing
> toolchains before deploying them...

While we talk, I get to see today's Linux next and also encounter the
same problem.
Thanks for the suggestion to test toolchains.

- Naresh

