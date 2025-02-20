Return-Path: <linux-kernel+bounces-523870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB410A3DC4E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310BA188BC98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6081FBCBC;
	Thu, 20 Feb 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="MufIqekY"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9E1FAC49
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060967; cv=none; b=ca7EuUlw9V2+udXnUmm7QlyK8wMPwEtheulnCCug2v8Y8A5nFvg6Sr4APb/d+LM1GmS9hfW+1h86aEFyDUO8ZTFBTyqR+J8a5s35Xi+9j19p+q+aJAEzSHZeGY1wS3aKTuU0w9n/mN6Ps2eoOTf2grz5lkEaCsVnh8+2X0OjVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060967; c=relaxed/simple;
	bh=FnUDn3kteGNiPrF+F00ntwEnWg8uVOcU+mbj1dX1PPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZxoK2NfNXcspRjK61Jq3RMbYuNYKB93rguMB2ZBWof4qLezh/KBC1i3sN1GphKAz78vjPl1bRnPv0k6q+w6ANdTC0Y3TvL7zkfPxTlo/m8on3+ji1FLPDFLi0GveR8lrH2UyFaZQnp6XeuTFydMrPmqg1HRx2aEWOYg6+Ph7lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=MufIqekY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so1568702a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1740060963; x=1740665763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFcRRgZ/OI8HueiYaAyTUjysgPa3NhOt5Zbu8dcMaH4=;
        b=MufIqekYgaPCtrDlYaYgHGAUiHa2oNFQDjsmWJ0UOdGEX6npQKDvwrYVarcVGt3B/V
         kWIadCJVAkIo2dFaIwrfsPne74Qw4YJHkpLvBpDkm4ssaKSnAWaeWYnU+MznzJkCaWyl
         K3bEU0WlHhCvhPuUWb+8p7Lb04GncQ3OlVnv+0JAvKJcSSxpD/oDLRO+FBPNQc7S7oEA
         JIxWbbns1dRy7Or9KW7W1VFFC8/lmwwRPcoD5RW4emWV2utr218fTpQCaitfS70QPfM5
         7dZs3aIxPDo1yXvDOjJWWBLd4vV+72p0DfuqzEjxIT8vif2R3ioUzAi5sR1ET5Htghsv
         3HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740060963; x=1740665763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFcRRgZ/OI8HueiYaAyTUjysgPa3NhOt5Zbu8dcMaH4=;
        b=YD+DJRETbYyO7ltKzE+YhW7w/v0r9n7QoBB4cvmZA3GRhsEN6sYFUJD94SZfy2j17s
         NdkNLL8nXZD/ZL3CW0gCbKAtzcJWIsjef4L/UfpHTAQ5SSq2mAqMNRkGGqlX6tqTceLo
         P/d278O9log0w2LG/9NNHH36VOWPhlIhdqiA9pn80ksL2+M9v+7VMPg4b9zGSUC8Lo2u
         c4+3dHQz+59q3fd8vtz3SexHr8TonXXifAXFNEylOYRSdKWwUNDnk4O4dqgbjI9CNO5x
         xlT5hpWsl/6pdEPJuehX5QMrSHwkaerVP0LJT9XWIFcMYwBhpSXwDS9/Q2S47Uq6fb3Q
         OyAA==
X-Forwarded-Encrypted: i=1; AJvYcCU7cgesruWbwsU/usj/1VyrUA/lNYuxauq40RYNzVoUD5FaRgWXN45Y0DE1AlZESK6V0Vf4jI/DdoDURh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywet6q8j0ahsIO5zBwQkF05UtQ89blEH5F2xOEF89GC76rq3N1j
	GIiWnS/vDkV1qDU6Hgsy2xAWY+qvXebp9B7QBA37ZBgWes/1ty20gF1pZaxty6pCZqdKBu4hRmW
	EBpFwcCT+sMV201cfTUr5bLrJL2EjLxA5hT9xaw==
X-Gm-Gg: ASbGnctM4xdFsrjtjwLToGxMptssRYyLAjbKs6b7aIsR2iZ2UdwUPBSlTzcvV0k7H/x
	TLcG1j/VElNr4SCz8vwZ3D4ioHLsQ8IeJ4az2N7QtE9aO1nGDgjTOliqD/3vsf1OeyzqXN51X
X-Google-Smtp-Source: AGHT+IEbWS89Bl3M1hawkEALiF7cs/fWjH88qNg94FJjoiQcjQaQjWu5RV+u+rnxMy7eGDtdRYuM2xTyBdXRPvgUL3Q=
X-Received: by 2002:a17:90b:1a87:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-2fc40f10271mr32024795a91.8.1740060963496; Thu, 20 Feb 2025
 06:16:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104500.178420129@linuxfoundation.org>
In-Reply-To: <20250220104500.178420129@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 20 Feb 2025 23:15:27 +0900
X-Gm-Features: AWEUYZnRaDnwS57qTXFvSLbWRSRROWyGCamNNyT6sk5HbujlvZO28fPyNcOuvaA
Message-ID: <CAKL4bV4NumjHYoKgCqnuqzQGHTM-wLnohFAPKRj5K6n+qWpbhg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/258] 6.13.4-rc2 review
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

On Thu, Feb 20, 2025 at 7:58=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.4 release.
> There are 258 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Feb 2025 10:44:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.4-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>

6.13.4-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.4-rc2rv-g191ccd3d65d1
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Thu Feb 20 22:48:41 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

