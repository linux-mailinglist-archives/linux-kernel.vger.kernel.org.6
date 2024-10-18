Return-Path: <linux-kernel+bounces-371411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D64C99A3AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797F41F26C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068E91EF94D;
	Fri, 18 Oct 2024 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhK2w9zI"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88014E2DF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245694; cv=none; b=hm5T2u5ALr7c+raLxdX8uP2/XWO/fn92dWlvH10eWJOhrSslvw74Ib1ae32LBTOzaj6IlcaPNPT0hub2ofY2IPLVti54qYopTHJTgEwpVDQ9rw6YIS+GYBDa+/8zhvr6kVYOLYp8w07+qE4aeEF6eVS0FiguOoUK2w87NL1lGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245694; c=relaxed/simple;
	bh=ByQvZv98BC+L8p1DTuZl2zlqdFxenNAcm24+PlvMt0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WN99qauHypbdrOILNpwlmrbZ/ywewNGvxk74dY/2yJHUbafqs12uIWcHWruF1nb/ZxWpCnPBGSR885q61L6tWHOlWgFSGT6VQHSGOol4uh+XSEi6PUBbB6W3wmpFNtuIYsgqPdnSk4DWKRMcIIdo5P8bAAqIuSuFM4Rj7Ev62bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UhK2w9zI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c973697b52so2361019a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729245691; x=1729850491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EceJMD5TFFW28sEBYAnTnnk355nDba/Ev8Vf3NXQHxQ=;
        b=UhK2w9zI+RoF0YroymDbRJbS4TpLxVDayGlT4lVyDTQy+LWwo/1fijgrvMnLUfB+o6
         CtNeUnPniRYX3VruJt0HCodxCpU2l3DPDADct7DbnCru6zxQnX3WaZ+9YtvFagrAhbEe
         LKRTT9PnSD9PVa5KafVk3t8Y6GGcNtkLGl1X/AK01J5KGmP+UA9ljBuR0UGmkaQAqcUI
         dhV4UUuMjoJdQEUkLE4RWa1xv2+mWCGrBVISLCCeEuOd+kxzxHD8KqyLpuN1bdlkC2RL
         /K7Jri7h4yUixVjl9IyV6x3EFBSdgCUq1vOaAN3gVPqpfwqPVhuFOTw40tUjsJHNTV0e
         h9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729245691; x=1729850491;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EceJMD5TFFW28sEBYAnTnnk355nDba/Ev8Vf3NXQHxQ=;
        b=hrPOdr/G8DiChxOanoecyMqo/lHgQnBdSUj224AKC8yKcMgUl6vTLH8/I6Wu2+FdE3
         6UxPItD6G667K+9W6agJWZevDKN1B9LUalsu9kB+WWqNXpzjxRX7m1RuUxOLCRgOw7KA
         La+PHAFcLqD4UAKhKTDx7IXQrVSNASFIzZP64RquOH1qp3baiqRSf3EhRUEfvaTgXnL1
         WB+jX1MubFKKO23Ox9M173TYW/1Z9WeP/3JzeUJEuvu3FgSMxxWqeZhYz+TpVGfAShz9
         O0soZUnDP5CtCFCnUCGB/USjDSXPjABA93AIC9rTNwi/GQsHnlFrMcZJ5MXNPBnJt0GM
         VwBw==
X-Gm-Message-State: AOJu0YwV6ldNr9smqfrVGBvkk2VrEyekWpwOgkOIdnG5tNFj7ZbBiy8H
	f0m14tExwAHlaFKdNkxb9QJumv8hTZrgis4dGMsLq5F6UdWon4FTYPR5pbSVHiI=
X-Google-Smtp-Source: AGHT+IEDSxbCrlx25fjyK8bHdzmrM1cAxNXPz/tyNwGjzf/ZGH+OdLM0Jm8+kkTlgW5Frk6BCtFLAw==
X-Received: by 2002:a17:907:7da1:b0:a9a:2d04:b577 with SMTP id a640c23a62f3a-a9a69ba71d2mr175520566b.32.1729245691269;
        Fri, 18 Oct 2024 03:01:31 -0700 (PDT)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68a8d9e4sm73106566b.9.2024.10.18.03.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:01:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 413755F863;
	Fri, 18 Oct 2024 11:01:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,  Linux ARM
 <linux-arm-kernel@lists.infradead.org>,  lkft-triage@lists.linaro.org,
  Linux Regressions <regressions@lists.linux.dev>,  qemu-devel@nongnu.org,
  Arnd Bergmann <arnd@arndb.de>,  Mark Brown <broonie@kernel.org>,  Catalin
 Marinas <catalin.marinas@arm.com>,  Aishwarya TCV <Aishwarya.TCV@arm.com>,
  Peter Maydell <peter.maydell@linaro.org>,  Anders Roxell
 <anders.roxell@linaro.org>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
In-Reply-To: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
	(Naresh Kamboju's message of "Fri, 18 Oct 2024 12:35:13 +0530")
References: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 18 Oct 2024 11:01:29 +0100
Message-ID: <87v7xp91c6.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Naresh Kamboju <naresh.kamboju@linaro.org> writes:

> The QEMU-ARMv7 boot has failed with the Linux next-20241017 tag.
> The boot log is incomplete, and no kernel crash was detected.
> However, the system did not proceed far enough to reach the login prompt.
>
> Please find the incomplete boot log links below for your reference.
> The Qemu version is 9.0.2.
> The arm devices TI beaglebone x15 boot pass.
>
> This is always reproducible.
> First seen on Linux next-20241017 tag.
>   Good: next-20241016
>   Bad: next-20241017
>
> qemu-armv7:
>   boot:
>     * clang-19-lkftconfig
>     * gcc-13-lkftconfig
>     * clang-nightly-lkftconfig
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Boot log:
> -------
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 6.12.0-rc3-next-20241017
> (tuxmake@tuxmake) (arm-linux-gnueabihf-gcc (Debian 13.3.0-5) 13.3.0,
> GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP @1729156545
> [    0.000000] CPU: ARMv7 Processor [414fc0f0] revision 0 (ARMv7), cr=3D1=
0c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction =
cache
> [    0.000000] OF: fdt: Machine model: linux,dummy-virt
> [    0.000000] random: crng init done
> [    0.000000] earlycon: pl11 at MMIO 0x09000000 (options '')
> [    0.000000] printk: legacy bootconsole [pl11] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Size (0x04000000) of region at 0x00000000 exceeds
> limit (0x00000000)
> [    0.000000] cma: Failed to reserve 64 MiB on node -1

Is this a highmem related thing. Passing -m 2G allows it to get further
and 4G is obviously at the limit of 32 bit?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

