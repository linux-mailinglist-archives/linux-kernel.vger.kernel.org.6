Return-Path: <linux-kernel+bounces-354132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB31799382D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B6EB22B0A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F30D1DE4FC;
	Mon,  7 Oct 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojFeN/iT"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955D1DE4DC
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332648; cv=none; b=kQ7oRnIyeA/0Q4dM0dpuDDJiEPbxiN8SPVj109noKp2McbcK2yab8g4qYfUJUa2hUiSg4bbZ/ZzwlrtmW0qS2AasMBZF2yyRnSaEME6qYWmRxqmHs2qgdM9wRRM1tQxH6pj3rwlCfReRJ6SQMS0ahjkvwtRPJOkCMb27oqqn21U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332648; c=relaxed/simple;
	bh=rm2osUWB4IgyVq8ykVYBpG6R1/gpKjI5PBwVzeViHPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNy6NXwccqatNbWSCNdvdd/NpYoxPuk37yK1QIEpLq4JN0WnRGNwH1SQAbXyH3jTwbQ2H5VZ2pVtgWAH0e4PbjRO/Ja2booF1k0xDjb4WSSv31ldfHeBKSp1Kg2kgetSC5jS6qZKm2sutIwTq+QKlwOpnUowylCzr29lvLh7dEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ojFeN/iT; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2facf48166bso55508181fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728332645; x=1728937445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFvl/yEangr8owxbos5zhVtsni37SUgFVrliUsmDQcc=;
        b=ojFeN/iTC1jCx4gLp6rdSa3WwRnYoY6JGDPsmb0XVmO9vhqMqTdoG5bCVvDiGzw0Yo
         2Ai+5GRaduOC4hj9K5uevZt9n6/mCf8vWDNl7LqhVihYNBELGC/DvjemtptS99F7ZU+Z
         g72vgDJcZ7GVqD71IjO00dSyERDWsi4XFnSDIefX41UvQTVMMVm4TVgtm6xyJD8KeGjS
         lh4xC6eN/gEF6PUBfrDA0LHsLB0ktaBjD6cVcjp81pOCk39EuD5Vd5e+fzvz7z5pLgkF
         pjfIOq8kzpgxFl9e+iQcdYcBsrRlme2FBh5bkbei/CcU7NmfooqyrJ7iT4djH+CieiJM
         q22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332645; x=1728937445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFvl/yEangr8owxbos5zhVtsni37SUgFVrliUsmDQcc=;
        b=ogy2/pAJjVRXV6IG2NeZjwgcGyeeM3hEgJscSd3SgTjdPg1LaNTePp2bLETRwuB6Ic
         aMIVhpukyxYVYaYOzTJXuPLFFdwib9EPr6jDgTbFtjKbw/nPecS1S0KDQzuLE1sbhivJ
         ZjcA5EqZDyEstKOX68Wv1TLZciWPmyLDr2hcTveiygYhA7hW5uOrjkCSmj8Zpri+6TWb
         /rXP3gbSAC9oEqNLs/apKFBByc+PeFDULtKz4hUjbPsTGY7T0W4GfM0T0ZRz+CMJcgeJ
         aEAiKmjsLQdi8cVLogs7pM+H0Os6JkSIIgPQQQiSVQf/7WX9Jwuzo0AJpwQVsKexlzq5
         ViDA==
X-Forwarded-Encrypted: i=1; AJvYcCUN/u2QIH6zn7vPBbWrk7dRFHTE0zjcfu+IwkLMRWgOVrm7/hHn6yox/N8H5gzdT79RpQtDLeZlo5VKzz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0LrfcEx3kA0XVyZaRKPUcAuunQLsJNw0mgLmWo/akC6bCBMFT
	8tSvAYZfupZyOpBhBvztOb95M35KI960GDcjY9F/p5gkNlO6dTvYeiHIOEatF0KsjNvACzqNEHY
	cTNK1Olq57aV8hoFyOgacUCJhpaLQhmAsHnNnuQ==
X-Google-Smtp-Source: AGHT+IF2J2KtODAOg6E0IGOtSHekx3v4Zat7hWdd2giyI0z5Dhlv+dq60y4SCVzsX3JaLj0NPvweMQR6zXmaZGoQZbk=
X-Received: by 2002:a2e:a545:0:b0:2fa:c913:936 with SMTP id
 38308e7fff4ca-2faf3c0184emr72904611fa.1.1728332644356; Mon, 07 Oct 2024
 13:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007163414.32458-1-exxxxkc@getgoogleoff.me>
In-Reply-To: <20241007163414.32458-1-exxxxkc@getgoogleoff.me>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 7 Oct 2024 22:23:52 +0200
Message-ID: <CACRpkdbj8fkQf38n0t-==cFZj55TPgoTGM-dzESWgeRGfPHofQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Initial Support for Linksys EA9350 V3 (linksys-jamaica)
To: Karl Chan <exxxxkc@getgoogleoff.me>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 6:35=E2=80=AFPM Karl Chan <exxxxkc@getgoogleoff.me> =
wrote:

> Also The original firmware from Linksys can only boot ARM32 kernels.
>
> As of now There seems to be no way to boot ARM64 kernels on those device.

So this is a Cortex-A53 Aarch64 system running in ARM32 mode.

So I got this interactive U-boot log from Karl showing how the attempt
to boot an Aarch64 kernel manifests:

CBT U-Boot ver: 3.2.08  ([IPQ5018].[SPF11.3].[CSU2])

## Loading kernel from FIT Image at 44000000 ...
   Using 'standard' configuration
   Trying 'kernel' kernel subimage
     Description:  Kernel
     Type:         Kernel Image
     Compression:  uncompressed
     Data Start:   0x440000a8
     Data Size:    8249289 Bytes =3D 7.9 MiB
     Architecture: AArch64
     OS:           Linux
     Load Address: 0x41208000
     Entry Point:  0x41208000
   Verifying Hash Integrity ... OK
(...)
## Loading ramdisk from FIT Image at 44000000 ...
(...)
## Loading fdt from FIT Image at 44000000 ...
(...)
fdt_fixup_qpic: QPIC: unable to find node '/soc/qpic-nand@79b0000'
Could not find PCI in device tree
Using machid 0x8040001 from environment

Starting kernel ...

undefined instruction
pc : [<41208004>]          lr : [<4a921f8f>]
reloc pc : [<41208004>]    lr : [<4a921f8f>]
sp : 4a822838  ip : 00000001     fp : 00000000
r10: 4a83b914  r9 : 4a822ea0     r8 : 00000000
r7 : 00000000  r6 : 41208000     r5 : 4a97d848  r4 : 00000000
r3 : 644d5241  r2 : 4a0ae000     r1 : 08040001  r0 : 00000000
Flags: nzCV  IRQs off  FIQs off  Mode SVC_32
Resetting CPU ...

resetting ...

So perhaps someone knows how we can get around this.

It seems to me the U-Boot is in 32bit mode and tries to just
execute an Aarch64 binary and that doesn't work.

What we need is a 32bit mode preamble that can switch
the machine to Aarch64 and continue.

I don't know *how* to do that, but I would *guess* a botched
return from exception where you provide your own stack
with the Aarch64 state hardcoded on it should do the job?

The Aarch64 maintainers will know what to do.

Surely it should be possible to add a little code snippet
to do this somewhere in memory, and that in turn jumps
to execute the actual Aarch64 kernel in Aarch64 mode?

Yours,
Linus Walleij

