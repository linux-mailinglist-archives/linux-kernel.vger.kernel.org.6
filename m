Return-Path: <linux-kernel+bounces-359176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5DB998860
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E471288335
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9001C9DCB;
	Thu, 10 Oct 2024 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb/8ib5b"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FFE1BB6BA;
	Thu, 10 Oct 2024 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568377; cv=none; b=uLp0lWLr+Lwhjj79/hZMqigFZFbRflQ86sc7/WpFXVTUiaFbAreOot9pqjVFU38H2AofRf9ESIfQpQ+HrkpRWWPjIgFaYLzDIqXJjDYzIMWhHw1CbGTR44dVWYYYVoYtDGGldaL1KLZvFsT8EnwmskWEsD+X97EYFtqa4k+IIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568377; c=relaxed/simple;
	bh=YOeZq4gdp89ctDpF5WT2qnKvP3R2Vh4bvhExzfhY7Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsvXkGV5hGE7VPdT/semMMwboTxsmPIQUE6CjSuQ9I6PeC/hsYzCT/Y0pMpGP8J2glr09u4w/7q4EmvpEfd0OlCj+T5OEW2C6G6i5V0Tns6AMfWZm9JPfq4T1bw5+hNh8BX2utbssGyiT1e1+CyI4uNv+Jd4VNzFoy11nRqeDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb/8ib5b; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fabe5c8c26so8987161fa.2;
        Thu, 10 Oct 2024 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728568374; x=1729173174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WOrxW89AILQk3udFAERN7y6AGGLIomslxo7RvrRZ38Y=;
        b=Bb/8ib5bSm5a1CEi7+tUe2pSJAh6UbQ0ojXJJHfr1aIGpies8fhxyjWf2x8swftLAt
         ncPjGv3HyD8NwOsdPt0pacTfSbagI0o/dvXrU5lodoGGJf+DwtbYq+I/rXiSFmmKSabb
         VnvGNxNpXkvqt44HxHpPrvr39zmRPEV6M6qcQsmhmqJ0t/xC/AfRoD8bPAtP4zPcOC72
         X5+L4GD3qDwQlvdnVwpdRsXFczEarn7qMSOiYUNzx4fVbbYVPIJvViIa5s2ZgNHmbZHe
         UJPCrcFfLJvpGjsrH5LX7L97O9YbZoUzewhuLWwp4vnsSlnMVNuTm+MER3/5lifnXGPz
         swHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568374; x=1729173174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOrxW89AILQk3udFAERN7y6AGGLIomslxo7RvrRZ38Y=;
        b=p5/Zr1vFputDZ6Tr7lt1hl39bWxhhBryhwpRXYzP17ljpvE3ddQ8J7FYa9P1a9mpN/
         5J7kabF3LLSQkK2UTwYouSOammhrwdNanRMAN/OCsY/gBX3g3LhRX/OUHHNcyzUhTLR/
         OoqNNDQhDGjVIOjbswUePay01pEEaUFUgg0XKfYbTedZkfx3W029wvJjtbtlJyHBvkfa
         hzTNVB4HypJDuakzMy2CkyfCV5KU1m46GGxY3etukkJKy/j0eVeFbJ2Ow7WQW51XAH54
         yIH8YT4AYRWYeaJyLo9dPUilruPE+IUQ6+AR/EFcFPKwOSK/mQyFb4C5HSuJ2S6Hue1+
         nInA==
X-Forwarded-Encrypted: i=1; AJvYcCXNRYDN6+MevRFklrqzIZ13wCRvIBCrEzv1upZ6mnlJMsxkH98yIWLPoYjP6oRdtZ0oN37cZpycUBEmS8g=@vger.kernel.org, AJvYcCXye+oIOApHVmE60Y2ecZa0RdQZ7z6+VqCcjrnb/toFOpSHKmjqOIq9Hnd+3xx/KRki7W63EizG1V80aiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfHlqcDNduBlk4Fdk+ytMHbQ84obcD8UcjoVqZ83AAUzQkp+OX
	wvvqSjTyLudXTiyQkq4lyVlgZgZAY8aKbotT1RKbb3gG5CJ7hAU7WRZDzf1hP7WgR4sO3pFhl3W
	HwVFPjGtcqRxHzQtbwmh95ARajm0=
X-Google-Smtp-Source: AGHT+IFiV/oe6ftCSnrY7kyWamWo9/1u8Pum4SDAuMad0lrhvAfaM6nzggC3GCxiMPa8Ad+RAUbPvZr6tKLhuZDF7Vk=
X-Received: by 2002:a2e:a545:0:b0:2fa:be5c:8ae8 with SMTP id
 38308e7fff4ca-2fb187d2818mr41048491fa.41.1728568373219; Thu, 10 Oct 2024
 06:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009101807.1473-1-shenghao-ding@ti.com> <d1941b10-0549-4a0e-a3fe-a8d7c50c175b@gmail.com>
 <7e138a1c8b6d4ace8c759bb2266216da@ti.com> <3ef8a82f-5e71-4386-90e1-f34222a60bdf@gmail.com>
 <50daaa7a-d590-4ae5-b33f-8f51d0c2f457@gmail.com>
In-Reply-To: <50daaa7a-d590-4ae5-b33f-8f51d0c2f457@gmail.com>
From: Antheas Kapenekakis <antheas.dk@gmail.com>
Date: Thu, 10 Oct 2024 15:52:41 +0200
Message-ID: <CAGwozwFAK_8HVgfNok_6jcsNq2OVdNzTc+KotxF0vhPd+PJTHQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1] Upload dsp firmware for ASUS laptop
 1EB30 & 1EB31 and Update WHENCE for both
To: Mario Limonciello <superm1@gmail.com>
Cc: "Ding, Shenghao" <shenghao-ding@ti.com>, 
	"linux-firmware@kernel.org" <linux-firmware@kernel.org>, "Xu, Baojun" <baojun.xu@ti.com>, 
	"derekjohn.clark@gmail.com" <derekjohn.clark@gmail.com>, "13916275206@139.com" <13916275206@139.com>, 
	"romangg@manjaro.org" <romangg@manjaro.org>, 
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "Chen, Robin" <robinchen@ti.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yi, Ken" <k-yi@ti.com>, 
	"philm@manjaro.org" <philm@manjaro.org>, "jlobue10@gmail.com" <jlobue10@gmail.com>, 
	"luke@ljones.dev" <luke@ljones.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Mario,
as I am not logged in, kindly close
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/272

Then, while consulting it and
https://gitlab.com/kernel-firmware/linux-firmware/-/commit/d65613ab8c480dec6d63733d3286451aa8b3795f
, modify the whence so that 1EB3 points to 1EB30.

Otherwise, your merge will not work with the current TAS driver, and
we will have to do a second round of workarounds while it is the case.
We have had that symlink for over 3 months now, and as Chen said,
while not ideal, it will do for the time being.

You may add me as suggested-by using my lkml email signature

Antheas

On Thu, 10 Oct 2024 at 15:39, Mario Limonciello <superm1@gmail.com> wrote:
>
>
>
> On 10/10/24 08:30, Mario Limonciello wrote:
> >> Although TAS2XXX1EB30.bin and TAS2XXX1EB31.bin are both in ti/tas2781,
> >> yet it reported "does not exist".
> >> I have no idea why the file is there while report "does not exist".
> >> After I removed the newly-merged, no such report.
> >
> > I think you forgot to git add them to the commit?
> >
> >>
> >> Following is the log.
> >>
> >> root@LAPTOP-70RJ5B8Q:/usr/local/src/fw_new# make check
> >> Check that executables have
> >> shebangs.....................................Passed
> >> Forbid new
> >> submodules....................................................Passed
> >> Check
> >> Yaml...............................................................Passed
> >> Check for broken symlinks............................(no files to
> >> check)Skipped
> >> Detect Destroyed
> >> Symlinks................................................Passed
> >> shellcheck...............................................................Passed
> >> black....................................................................Passed
> >> markdownlint.............................................................Failed
> >> - hook id: markdownlint
> >> - exit code: 1
> >>
> >> internal/modules/cjs/loader.js:818
> >>    throw err;
> >>    ^
> >>
> >> Error: Cannot find module 'node:fs'
> >> Require stack:
> >> - /root/.cache/pre-commit/repoxl59c0uz/node_env-system/lib/
> >> node_modules/markdownlint-cli/markdownlint.js
> >>      at Function.Module._resolveFilename (internal/modules/cjs/
> >> loader.js:815:15)
> >>      at Function.Module._load (internal/modules/cjs/loader.js:667:27)
> >>      at Module.require (internal/modules/cjs/loader.js:887:19)
> >>      at require (internal/modules/cjs/helpers.js:85:18)
> >>      at Object.<anonymous> (/root/.cache/pre-commit/repoxl59c0uz/
> >> node_env-system/lib/node_modules/markdownlint-cli/markdownlint.js:5:12)
> >>      at Module._compile (internal/modules/cjs/loader.js:999:30)
> >>      at Object.Module._extensions..js (internal/modules/cjs/
> >> loader.js:1027:10)
> >>      at Module.load (internal/modules/cjs/loader.js:863:32)
> >>      at Function.Module._load (internal/modules/cjs/loader.js:708:14)
> >>      at Function.executeUserEntryPoint [as runMain] (internal/modules/
> >> run_main.js:60:12) {
> >>    code: 'MODULE_NOT_FOUND',
> >>    requireStack: [
> >>      '/root/.cache/pre-commit/repoxl59c0uz/node_env-system/lib/
> >> node_modules/markdownlint-cli/markdownlint.js'
> >>    ]
> >> }
> >>
> >
> > This looks like you're missing some dependencie on you system for
> > markdownlint. You need nodejs v18.
> >
> > If you can't install this you can skip this check when you commit by
> > adding "SKIP=markdownlint" to your environment while running 'git commit'.
> >
> >> Check
> >> whence.............................................................Failed
> >> - hook id: check-whence
> >> - exit code: 1
> >>
> >> E: ti/tas2781/TAS2XXX1EB30.bin listed in WHENCE does not exist
> >> E: ti/tas2781/TAS2XXX1EB31.bin listed in WHENCE does not exist
> >> E: target ti/tas2781/TAS2XXX1EB30.bin of link TAS2XXX1EB30.bin in
> >> WHENCE does not exist
> >> E: target ti/tas2781/TAS2XXX1EB31.bin of link TAS2XXX1EB31.bin in
> >> WHENCE does not exist
> >>
> >
> > These files are missing in your commit or they have broken links. Double
> > check them.
> >
> >> make: *** [Makefile:10: check] Error 1
> >> root@LAPTOP-70RJ5B8Q:/usr/local/src/fw_new# ls ti/tas2781/TAS2XXX1* -al
> >> -rw-r--r-- 1 root root 35220 Sep 28 21:54 ti/tas2781/TAS2XXX1EB30.bin
> >> -rw-r--r-- 1 root root 35220 Sep 28 21:55 ti/tas2781/TAS2XXX1EB31.bin
> >> root@LAPTOP-70RJ5B8Q:/usr/local/src/fw_new#
> >>>
> >>> Thanks,
> >
>
> You know - as you've been having problems with git and at least I've got
> the intent and your S-o-b for the firmware I've taken your MR and
> rebased/squashed it for you here:
>
> https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/317
>
> I'll merge this and if you have any follow ups you can do them on top as
> future MR (preferred!) or patches to M/L.
>
> Thanks!
>

