Return-Path: <linux-kernel+bounces-213475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB939075CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E19D281FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FDF14658F;
	Thu, 13 Jun 2024 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Atz33ow2"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE213A41A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290471; cv=none; b=pdpCvLD3ZKBnskReL0gN8AcXvIKqBdDlmaLRlQBNM8K4P4ItbWqwAsXiRD0AXIeJVOT70aFucr0uYa+Qizf0ySzFm6PfzTBYrdLIccGlsEJCksskymcjm0I/z3YNYZnBpoHVxQ5EnKUMXf5ODc7+m/bTXwHbeswOFoR8KcAv6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290471; c=relaxed/simple;
	bh=+HZBDinZDCMT7Ez14OypUVVwLMkZvNTY8vfAf9qVU3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzXHtA1MT9Xhxwj//pyPIVSpkfmKA4YTvpdTCSy13woalGw0x2sgNEM6ih2QYVvNBiSTKrCOncXcB90z4jD/l33CFH21i3JxOj9wxr/o8OLemWdLk73uwH6WS7WL9naISVeShrRTWhrcj8oU6Wm4v/jbOnlqPKbWlLuC+J/X+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Atz33ow2; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-80d61a602f2so389466241.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718290469; x=1718895269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7g5SALnsdPJQWBZt0kVgnA0bB4kjPLGUDBHBwv4noI=;
        b=Atz33ow2Y46i+1Uyb90M1hD1amAg8mvabA9p0oqITmZAh0CyHmffJodCTqn3JNo1lE
         OEo9wEKfTNDSQhqxv6lg6TZwdPHXRRT7parrTc9/kHYlcpNLv9i2DGaImHR1x8Y5UMav
         0jUeTr+9EFZx/wkQxSFTZjhEWTKJN8jQti8P+RNTp7D8CQ8OwW1acu6bxSpgyIGY/LHO
         R8ACeZ8D6E0WyjukIkpkr07XXj98UaKObY2ppQi0Lk10oQ08u2UHYhbSTut85fow94bz
         2X3Q5SOLZjrYnZvcDhA859iPOm2ctT10fDp3gpiKhK+eriNo7ULrh9SCnBLPJD6/HDB3
         4o9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718290469; x=1718895269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7g5SALnsdPJQWBZt0kVgnA0bB4kjPLGUDBHBwv4noI=;
        b=hETdC2yReqGOoMc3jv/EGBC58n5oyssO03hObQb4E1ZUZEZ/KFed+NG1ayswg/Qda1
         y4Ncv+rYnFEDDHOeq9z8iMSD94/5r7z8Mr5qqb2bgchrvKRjic2aXLbP4bh5Vh1kjV/z
         /9UZ5hpETnosSPzkIW2i4ghG2OMR1bdsGzyTzIbxVXUyZ4u26yiyCNXMp+kHS1T8FtS/
         3gZa1tOy8axGU11PeohqGxibtQ21aEacG2uppSfoiH8qYFccTzIzkM4UtDYjH6vUd7Wr
         ezBCXNXQX8NFaSBM6GSf3g6QkGWhOCFqUhHWEXHGzz+gCMpehTKVKGiucdgSndSrEpzG
         8Clw==
X-Forwarded-Encrypted: i=1; AJvYcCW7fWCR93J0FQUttg/BqLBS6MS2L7cJJHmp/p5RoIGkDpUPfXid2zcJb8yNA2d+d5LwK+ZRQeLs1+tdwUeqEEJzY8PlvA1TYmZvRBff
X-Gm-Message-State: AOJu0YyoSOGDKfbxUueXEtK+1GNIug8rRPFfFTIPBW0wvgaxhn/tsSx3
	pRevPDhw3aYZnd8BncwXwxahqHx6AEQjmJFASHj3Aqk93jhrR4U18X8irqIiDUiEpEolq4PjYM7
	YccqZgOU7FT7mdCQKGGvkXnK1zB+0HACHYXwB4w==
X-Google-Smtp-Source: AGHT+IEFJBIeVpnD+lw3dEtVlaKMEXn/UPaJkQ+jBNt3IL0NdXWuc6/aVyLKENNOoHl9TZ+IQBZ2xK7qOnH1FQoGYNM=
X-Received: by 2002:a05:6122:20a1:b0:4ec:f27b:ee9c with SMTP id
 71dfb90a1353d-4ee3f1628c5mr73958e0c.5.1718290467801; Thu, 13 Jun 2024
 07:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113247.525431100@linuxfoundation.org>
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 13 Jun 2024 20:24:16 +0530
Message-ID: <CA+G9fYvS7u7seBUY36kGdJQJ4LS==ex=zzvBztYUE_X9AT5nYg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/317] 5.10.219-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 17:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.219 release.
> There are 317 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.219-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The powerpc builds failed on stable-rc 5.10 branch with gcc-12 and clang.

Powerpc:
 - maple_defconfig
 - ppc6xx_defconfig
 - tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
from /builds/linux/arch/powerpc/kernel/asm-offsets.c:14:
arch/powerpc/include/asm/uaccess.h: In function 'raw_copy_from_user':
arch/powerpc/include/asm/uaccess.h:472:25: error: implicit declaration
of function '__get_user_size'; did you mean '__get_user_bad'?
[-Werror=implicit-function-declaration]
  472 |                         __get_user_size(*(u8 *)to, from, 1, ret);
      |                         ^~~~~~~~~~~~~~~
      |                         __get_user_bad
cc1: some warnings being treated as errors

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.218-318-g853b71b570fb/testrun/24321785/suite/build/test/gcc-12-maple_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.218-318-g853b71b570fb/testrun/24321785/suite/build/test/gcc-12-maple_defconfig/history/

--
Linaro LKFT
https://lkft.linaro.org

