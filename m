Return-Path: <linux-kernel+bounces-525370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA073A3EF1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF2C16DEAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85197202F88;
	Fri, 21 Feb 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="aB/+4/3L"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3FC202F64
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127887; cv=none; b=seKpivrMtnG9Sl9wPfvB9R2PHmyUU7sYkGaQN/U2Z4tTrhwOtsfnANSFK+fXktH4qfsdYlu3zigRTMTc6iU05/xLxbsT/pDU+4FvOJkbceqKBITQdD5Xs7Y5pQeTAQ1pNTDgtZs9UfiOY5XgkF6k9HOQ6uIfFrtyKIFMOvc5dBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127887; c=relaxed/simple;
	bh=j/wOYnB67jjGhylOIqHHXdLyAsqr7kq9q2ecSsLgwdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hE3Y2Bf7l0THHaYYmADwNWOTgyjjVuDD34BgJdDFojxJN+3AJ2txjn4I++CM4qsjVMzxlPcRik+gTpy4LuyzQIJCnUaUflUXExHetT6qtTPXaamz54BWeD7IGP9/ldJ450Kr2JF9hZDFtXbNvi3vu1+uWjRIPQXCfmmyBX1+u0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=aB/+4/3L; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so2978912a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1740127885; x=1740732685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO8S0SaLHILveS4ht7ABmq8EQhy1d2PZCdXORUNN1qU=;
        b=aB/+4/3LeZY2VcBpWCSw1l76RmbN5kLS5h5DCWOocNB5ZGmuaP4Y6uEAzJiw7ny/Ri
         /w5QEa9ENrXr1lRwB7GqCKBwUYhy1h5ebdLWIgvfYh6PF+W//xT5vG75KZ3L8Qrpria3
         zpmbqKmJNLiX9CPbKqjaItqV3w8Hz/AC9jjJH6AAm3uMmy3pJ7no1DAxGudMyYKEgyal
         zvgg12RmZwfVqe3XnS3PcpxzB4JbseLQGVre65Hji1Lg6eNUMApGazNmR/RdHSC1tItb
         rcpByZRlt7WeuOK8JkQSrsW08bVsCwuJO/AzFEsC1PdN5fW6U4ScARBNWsps2vdbj/Ro
         RI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740127885; x=1740732685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XO8S0SaLHILveS4ht7ABmq8EQhy1d2PZCdXORUNN1qU=;
        b=bMkyhXhO3df7q1cBXwVaZ8x9aDuXvUyfxiGR7UhX1xsYb9oIc6uVqHLWRTKCTwtGlq
         RArSXSdL48sZXvyVr9QuF5tIeCPHEY3P2aXXhljWpHbqdNw0SyThTjwIS1Q7/W1HHvX9
         t4ZsJK1S5l+d1k602LrkEYm7VdB25VbCvGkIxLofU2mUro7rKL359Lju6Spa+4oHh365
         QS8dHtH3hEuVxep9Piog/WuT/McBG3eBiwLk7bYafZgPDJAbfbHOahVa+BxEEhXQJ4d+
         3cv061MhWH+CllUHowvMvfgSrNJ2pKftvd3ZC57qERkDasdxK24cqXhh9ShjAa6+UMRL
         IADw==
X-Forwarded-Encrypted: i=1; AJvYcCWtvMwNuRKMrX9VLPSfaWMLdedP4ktmOv7Hei6fvOEudGWf2miDXpngj7GluEGeCteA0tZx4TzNmDIJEoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLf9Oc7d1t/zB+rIxJnj8ENqrLHyZYweJ4Nby01eX0p/A4UAi
	MnnJAKxdLwzu8r+J0NYybxFtwCpJN5Lajsl3Dw/cKzbiFHKjIn0gFCvzPjzSSzL38yQm/WQmrXp
	a6vrDNVKL5pK2qVoiKP/qrnN00mUuqPj6++veVQ==
X-Gm-Gg: ASbGncsm/7uDXyHEWZmT4Rvr80C4z5gYAM3yhfYN8G9etl0HCFZZV9f8XWFCnbPOoHI
	02YGNoBnYv9HOkTeYgud1mSBqfuyKD37HLlBT8r1qap2zHoiK30xd/yaKyap9sIx2b+jaOGov1T
	RfVkmwtxs=
X-Google-Smtp-Source: AGHT+IEys1/8M/P5ptc+GdcwlwtIRcEANusxbYrUGgN9ECPEJXUzZ5K8uZ0Zj8B3SEJuEhZa535B38wLxLJpyCPHfMY=
X-Received: by 2002:a17:90b:1dcb:b0:2f8:4a3f:dd2d with SMTP id
 98e67ed59e1d1-2fce78d1b51mr4418486a91.15.1740127885545; Fri, 21 Feb 2025
 00:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104454.293283301@linuxfoundation.org>
In-Reply-To: <20250220104454.293283301@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 21 Feb 2025 17:50:49 +0900
X-Gm-Features: AWEUYZmUcCpUlvaYFgWvcXhbRnoQJXLD6KDcZQvtYu61SAoEEDpaEQOuReQ8_i8
Message-ID: <CAKL4bV7rLDPWnveigQc3ak9O5aUMNM6iQ+h7Bki39fGH31GcPA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/225] 6.12.16-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Thu, Feb 20, 2025 at 8:00=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.16 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Feb 2025 10:44:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.16-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.12.16-rc2rv tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.16-rc2rv-gc3d6b353438e
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Fri Feb 21 17:21:36 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

