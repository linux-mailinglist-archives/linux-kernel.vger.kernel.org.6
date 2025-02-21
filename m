Return-Path: <linux-kernel+bounces-525913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AA7A3F750
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC05816750E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7901D5146;
	Fri, 21 Feb 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hda2ig/y"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406A11A270
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148415; cv=none; b=FofVE0RqDCzJP0LwBqbgtVLV6GSintGv6VqSk6pn2Z+zEBLV9vTzRWGbX46jecid8IkfphcEBaXj4WOTx/42jkGsNzUriHJ1aSDDV/m2hr21YMubGUgoh4vrHAshFkj9709nQHXWhSTL6U4eddMJErVd0i6UzIAXxGr+kPsu0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148415; c=relaxed/simple;
	bh=qu7p0tM/KNop1/PFZo5L2X5zg7rcBNTSSiqhv1kg5Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ma3hyqE+Fmrnz48VFxErXcYy5HjOZVGn8EYYXuiNQroUFcQlFGyAJxYPNvH4bncG2/v9a16nIPX5L62Eyh/Kiutk9AYOWjew285Y6uhlXFQFTGAEsWBD4WK/BZMSQ6SurGo0P/9fOz0t6M4XZxwqxyt3cht4wTd/115MpmwUPW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hda2ig/y; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-307bc125e2eso20635251fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740148412; x=1740753212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmFRVsnSYBI7qD/L0z8mIvT334WHClqVgRQbXrWUiFs=;
        b=Hda2ig/y314ALebI8h/Cso4lDc/RKI522NDMZQv67ZtBxOdgnpKNlvJo3eUVU8OC2e
         bIpxX6oQxzkgRwBq+lvu53zbfhLq/2uRP48Sx/pDYCTr3Exoo9+kaQ+2S1pB+CD7VQsB
         T0D+dBKXfD15lgZCWWTO+g1FZ/fz8Gf8beDKHM6zpbJciGz7Sk9ohf+CBcbhSvAgqUNv
         vZbMZ2E1AhbBiBczE7UexhL3oKSk0E+ioxlfRWvzEE3uryvlWyyY4cyRO53p8alzchdB
         H6r3CG/gjt7YW1Hsm/62k36YcsCd/E5RucQE96TXE80aTXndnMK3aoaDB+oUDhgjQFAg
         U4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740148412; x=1740753212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmFRVsnSYBI7qD/L0z8mIvT334WHClqVgRQbXrWUiFs=;
        b=IdvCu/9rRPdgHFcass8ltdqLy5zvUqH3q5gWgwxZ3ymr/PsF1WI+uAwHg44xaPvnxw
         7RDjM8Z1nG4lZixqkqfHw8JHzaDCqyqc/lswHQ4ln8G2OZu3jW2w5qO0Ie5gWjeNLsc8
         0SNMf0C8Qd4j0agm8T5XtxIwB5gWRvpi6y18j+RBkWg/UxV2WGIqyLAnV3ErKgtOjRxJ
         /tlbDcl5ctm2bNmSXeqsRrbYh3TEc+3GKlyp+tzTFWXH3kuVDGBC5/r5lMkkSKi3kjUB
         nrki73WLDYiXi+7u4o3sXKFVAKxknbDYm3DnaowJh17Gy2i1l5F4IREsmstRh/xfY2Uw
         sCWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdk65xhIJO+s7CKe8kJokYAwRSlYvl5tzsadIxG2ooNw06jtjSl22QQxEbS+PlKsKNRpj7gC+1zprZDMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1IVCEBjpt/w05NU4B8DiTzd2olLHi1fgH+dfOi19zAaj2Gow5
	yKUMGVm/HPlFhtVuVp1qoVOzAs1FzDUCTn2DWU4yLlnGSDGBMIboiw03bN172SCQE9p1I0ZDZSo
	2Lgp3KmjTSzRCFKBP59RI/sEHl3U=
X-Gm-Gg: ASbGncs1fSsU2eLbslYCcGiZsSxj9ujT27LQIJLpDVxz56v7yTKrpNbPtvu1u0sRpRQ
	qNLp8fJQMs66dylK9LE492F5PcE5OTU5BLxJww/5VAryrajjwPAbvuETLK810bf3DNcmgXpnN5I
	ZDkNgzHcs=
X-Google-Smtp-Source: AGHT+IEt3NAOveHShM6QMghpcvvbzOciw+0p8FD/o5Mhg1SV5NcGuMQk392yOKVK9bzUjlwuBHqZ9GTwfKs/gKCdT3s=
X-Received: by 2002:a05:6512:3186:b0:546:2f44:ee99 with SMTP id
 2adb3069b0e04-54838eeb268mr1512962e87.17.1740148412057; Fri, 21 Feb 2025
 06:33:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220200439.4458-1-ubizjak@gmail.com> <CAMzpN2i8uR7L9DmL1AX1R9p__x5KwAtdey_4iJ5ZP_frTqu9vQ@mail.gmail.com>
 <CAFULd4b8kgXfr1QcWud-n7PyuKKVUGTNd00GSZU=6va6Gr65EA@mail.gmail.com>
 <CAMzpN2hHb_T3gZfueeVRbOxUFt8+syWsm8iWQxF4PaUOQA-k=w@mail.gmail.com>
 <CAFULd4ZGW-FYtEe-BJ53QVjHMLr1jyj_6vJhNEwqqwW6Z77+Tg@mail.gmail.com> <CAMj1kXGKDtWxcuWbPP+o=6_pwhOHKJF_NnOL8F95y0tXt-dQQg@mail.gmail.com>
In-Reply-To: <CAMj1kXGKDtWxcuWbPP+o=6_pwhOHKJF_NnOL8F95y0tXt-dQQg@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 21 Feb 2025 15:33:19 +0100
X-Gm-Features: AWEUYZkMlmsj2rFBwNaugj440WgxgdGY0YHNvi5JoK1sNmB59_105YG2V7qu_zs
Message-ID: <CAFULd4YuL9DCOs23Ev+iXooirLfKT3O_9poSUM7JeW_dO34o9A@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/stackprotector: Move stack canary to struct pcpu_hot
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 3:13=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:

> > > I got a warning from the relocs tool, but not a hard error.  What
> > > compiler/linker are you using?
> > >
> > > Does the attached patch build in your configuration?
> >
> > Ah, the attached patch is similar to my previous approach, where the
> > build system *warned* on an offset (the patch was abandoned due to
> > Ard's request to put stack_canary to the *beginning* of struct
> > pcpu_hot, and this allowed for a simplified patch).
> >
> > The attached patch builds for me without warning/error for both, SMP
> > and !SMP build.
> >
>
> Did you try building modules too?

make -j 24 olddefconfig prepare modules_prepare bzImage modules

for defconfig, SMP and !SMP.

Uros.

