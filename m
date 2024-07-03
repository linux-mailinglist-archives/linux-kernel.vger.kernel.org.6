Return-Path: <linux-kernel+bounces-239972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC1F92676C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46591F24A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EB618509A;
	Wed,  3 Jul 2024 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEoJGHUm"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900B817F511
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028910; cv=none; b=XqQcY1ykeNNSH8NsLXLHml2CdYnMp+JxjWg6C+yIXZxYS/mLnJouQvjXZaiJQFlztnN4Nbki4tZcCG32a68fu/UjWtdIjteNT3ogpVJ5UWN/Xr5v3YNjwMRUZG6NsVFEMPoWgSiBU8gcvCAzEuqzTUgTjxWLlhBSDlw8jjOrvao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028910; c=relaxed/simple;
	bh=N8V2R60Um4mvF/DP+2QgAWbUsTYcbkQA65824qtqEKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lsaf/dL7VyLNOn5xxYzbvL/17yXAedM8QojaqHWpCpHzxku2tcCj0C5H7w+ymj+sE/3PDMK8ph5DOHahl1kO0sEkTEMCggzp7sOj301D21Dc3cErr0GzTBG1uWusQvp7i9NxXBzn5DyHsy1L3O2I01Wjo18VGu7t1EKduL7LUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vEoJGHUm; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4e4efbc3218so2092583e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720028906; x=1720633706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SjTTtlNb0syE5KHwXFKv4dS9jF5tUNRtWjSxSGgYhH8=;
        b=vEoJGHUmZiE8r859Sd05aMMQeZp69insLmefrK2b9m0wBH3S5UKAed9BPNFxofjm8z
         039zaDIfhLi4/OEhzOGG801EcnAnzyzzX+W2+p/ybCUl0CP6AHk8Z+46nTaiuJA/J5a9
         jt1TjR4ykl3aBMyM3v2eZVwBTyeF6ZQC2vgLlTymIhOIbREPbxCHwOgfcaG/eLAAynWq
         uVeewVNge0LY5RQIqiK/88FLSqPutFjspGZfPWk60nJXCpBz0nO2+zyVQXhVBco7AxCS
         +2JUfrEOmwt/miEKpU3IC2HllL7BvUj2riL6THx/pLW6Lzu0tqzZOHBD3bm+7/BiFWfR
         vBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720028906; x=1720633706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjTTtlNb0syE5KHwXFKv4dS9jF5tUNRtWjSxSGgYhH8=;
        b=iNv9Ya0jXOp6pMS5kRn1EMcXAJy4xXegrnc437DjmhXjgX05ursr+W3rF+fVsFmZph
         6CItSLGJdiaHV2cSmHq7O6yEz82vbv53qzt2RXCKCj6hZ2FVUnQR06DrGafcjqSZE6CJ
         tDBCWPbfKZtTt/yQvgmb0SQxtWhKN1ufJ2MvysI/JPn+m+89LGBVlgzpHZ6kqmeAt9SK
         wl4aLCE71U5eFb2FsChhMty4ZPm/Fj6Rv0npwnGbzsCALfY7N9jRqXOpQricEyYRD62r
         CVEOG/wVXi/ISDqAYsJFZbt2Gjw1qDw+HuyIpjnpFzwUZas8Use1GOz4ViZhjjLFlYj/
         ovoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5ihgojuZlYRQzj62ougo/L0vM5nhPjFfbSIBURdDSSvPLLJWr8qf2QzPCpWUpoy7He085Z6Ry/CGJcsmd0PEQ5G8ND1kT+blI1ySJ
X-Gm-Message-State: AOJu0YwFa5Vy80gELrNex69RvNt8KWmo4bbPmIFlzq1HA5YoiSzfTQwu
	XK6Zv6Cf5h84aNAV2Gh/+ouWEC5zvZ3wUhVioq89IeOjd3/Ax/ms+rFtyVHGVJ0zpCy/fI+Mfp+
	MsMictzGeMJXjd69rCKPELZlwreGsMViXF5Md2A==
X-Google-Smtp-Source: AGHT+IHq4gQLLZyc40X+uhVEaroOxiBVWeM6dpArotla1mzYAwd70XY8Y0gppC8vzwEKdeysF2KmeOOv9KP+gfgSVoE=
X-Received: by 2002:a05:6122:f0b:b0:4ef:320f:9f13 with SMTP id
 71dfb90a1353d-4f2a55043e0mr15627099e0c.0.1720028906555; Wed, 03 Jul 2024
 10:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703102841.492044697@linuxfoundation.org>
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Jul 2024 23:18:15 +0530
Message-ID: <CA+G9fYvXVQ599HH3ZYfNEZrZwacR-0hzKCqrLa=+ON0hDTwwGQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/189] 5.4.279-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 16:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.279 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jul 2024 10:28:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.279-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The s390 builds failed on stable-rc 5.4.279-rc1 due to following build
warnings / errors.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on s390:

  - gcc-12-defconfig
  - gcc-8-defconfig-fe40093d


Build log:
------
arch/s390/include/asm/cpacf.h: In function 'cpacf_km':
arch/s390/include/asm/cpacf.h:320:29: error: storage size of 'd' isn't known
  320 |         union register_pair d, s;
      |                             ^
arch/s390/include/asm/cpacf.h:320:32: error: storage size of 's' isn't known
  320 |         union register_pair d, s;
      |                                ^
arch/s390/include/asm/cpacf.h:320:32: warning: unused variable 's'
[-Wunused-variable]
arch/s390/include/asm/cpacf.h:320:29: warning: unused variable 'd'
[-Wunused-variable]
  320 |         union register_pair d, s;
      |                             ^

Build log link,
 [1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.278-190-gccd91126c63d/testrun/24509933/suite/build/test/gcc-12-defconfig/log
 [2] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.278-190-gccd91126c63d/testrun/24509933/suite/build/test/gcc-12-defconfig/details/

Build config url:
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ijXtfDw1Nbem1ANR1V8mLxfNeR/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2ijXtfDw1Nbem1ANR1V8mLxfNeR/

metadata:
  git_describe: v5.4.278-190-gccd91126c63d
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_short_log: ccd91126c63d ("Linux 5.4.279-rc1")
  toolchain: gcc-12
  arch: s390

--
Linaro LKFT
https://lkft.linaro.org

