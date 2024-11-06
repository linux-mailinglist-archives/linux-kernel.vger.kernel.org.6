Return-Path: <linux-kernel+bounces-398382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2A59BF09E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E920284E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB53202649;
	Wed,  6 Nov 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZzC7THrt"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDFD191F62
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904379; cv=none; b=ceBqctAyGXiBS2x+lDyW8JyhbfxE0hT8ds6GleEkG45Vi83lan8GwzDSydwPEJjOSt/VkhvYUb9o61AygwcXQHdVzwRFmmL8UGMkZOiGbIxpk8tmiEe015mnsGJkFSvFAlkxmRHfOWV+qDZ/3mowU2LCmL3LNl4muVlRB9QHjcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904379; c=relaxed/simple;
	bh=ZI8tqYqA/5qWxMC7iauvN1ZlEqc3lZWFob11XAkNlwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erAHrcRK/g6Xt+w1mwgVgyyaiRzFDuhbhxd0IgaQ0ssrwCnwYlsIsf214kzYqL6vsKGl1Ktc4FKB0DLZhEiAfZTIxk9mHS3CnTxQ+wKFLCFDI3rpHxTnXbiiEmeoGIJgGbzRx79TbzQI8Qt+HgdkiX6JssWDWslCalnJb1In3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZzC7THrt; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5139cd3ea31so1914176e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 06:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730904375; x=1731509175; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TFQcDGdRJv/pC4Fyxt1M1yJ9o6fC6hnhjRlfAcbSaC8=;
        b=ZzC7THrtQYmhR73KDjI/dq45OyJqYnV4J7csHe2OAoCzv6r0OaEmiQ/ubVO4XmhuAg
         hXissMbcjzqZ5kO/4YMi1JcRRBcLnOUPCL/vNieoOCzfM3IgzqxCHIix4I4wLwpGeqHE
         Vo6nc4s2S1WPeVYzO9f0Bd63QIByr1abREfqtai5C/d/PKAGRVowV5SodulML6d52+pH
         edK2g2O9IHy9jqFOC4qm0fyLuay0Z2LqgWNUBmjmXG5mKXnVB5rQQuGcQw/zW5LxnPKz
         NRi1ZyKM63nJAVisMc9DaTmtG0M7Ykh8wmkpPE7ieBaUoRjYsSo/jitOLX4KpB/3rgTw
         e9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904375; x=1731509175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFQcDGdRJv/pC4Fyxt1M1yJ9o6fC6hnhjRlfAcbSaC8=;
        b=GNZWac61D04JcRMO5GFznbhZ17Q3PzmTug0vPL4jeARk5n4JOCLuyUwnil4eBiVrIq
         gnTfFdL/kTXTXEYGP9wfWuKq58vo2GC5MLJis+zu3Z5GwAPgWjsYhr9zBht6fVkp/8v9
         pIn7GAf7HSoO18btrH1F+f++UjsEGjJiqkRRXjwMyvzIeDnTcq3cc1axjDnRsfqgXqQt
         dvqKNaCepe9aQjQHzzRNVsAf40H9kE0y2QPgTiD3dbHnk0kwp9ZxoeEdthZF41SsYqgL
         hNNg80nGg3kUH9z1rkbTmjJ3VLGtFgMWCcmjli5UTWFgxnsIuh48WTrgwZUW59jKcFxf
         Yysw==
X-Forwarded-Encrypted: i=1; AJvYcCVq5EytQ/uJGP9Ge9wY6ZZnx0OpLbpej4111tteeN6gswJDb+MEoNZgfFNJiFNfLzDttCsfVG8aKYMfpZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8/DO6D0EUIz1+dVxkYNrXOBtYedwcFQdgaJJSUFyP0Y9vCQD
	lulWKIrRTkEm2dfbzXiim/ORO6c1BOAtP8tEGDj62n0KolMSWdLaKbteo9X//ps93DMtv3eVvmd
	CEQCKU/HmOP487a7728TEOc0zfzzYGycIFmjW9g==
X-Google-Smtp-Source: AGHT+IE+bC+mXxOOV4yU15PQTzQJXdiY4kF8XY5VkBdvqe3TfXbtpkxhhgCQs3GJaaxDzX5RCa9mZTFL7EWHaFZUumI=
X-Received: by 2002:a05:6122:3d13:b0:50a:b8aa:93c3 with SMTP id
 71dfb90a1353d-512270ca839mr20179755e0c.3.1730904375506; Wed, 06 Nov 2024
 06:46:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106120320.865793091@linuxfoundation.org>
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Nov 2024 14:46:04 +0000
Message-ID: <CA+G9fYu-X4w24M9NgwWU4=vOsMxq8CzmCGo+BC-=t9e-R0NwnQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/350] 4.19.323-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, 
	broonie@kernel.org, Wang Jianzheng <wangjianzheng@vivo.com>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Nov 2024 at 12:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.323 release.
> There are 350 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.323-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The arm builds failed with gcc-8, gcc-12 on the Linux stable-rc
linux-4.19.y and linux-5.4.y.

First seen on Linux v4.19.322-351-ge024cd330026
  Good: v4.19.321-96-g00a71bfa9b89
  Bad:  v4.19.322-351-ge024cd330026

arm:
  build:
    * gcc-8-lkftconfig
    * gcc-12-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
drivers/pinctrl/mvebu/pinctrl-dove.c: In function 'dove_pinctrl_probe':
drivers/pinctrl/mvebu/pinctrl-dove.c:791:9: error: implicit
declaration of function 'devm_platform_get_and_ioremap_resource'; did
you mean 'devm_platform_ioremap_resource'?
[-Werror=implicit-function-declaration]
  base = devm_platform_get_and_ioremap_resource(pdev, 0, &mpp_res);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         devm_platform_ioremap_resource
drivers/pinctrl/mvebu/pinctrl-dove.c:791:7: warning: assignment to
'void *' from 'int' makes pointer from integer without a cast
[-Wint-conversion]
  base = devm_platform_get_and_ioremap_resource(pdev, 0, &mpp_res);
       ^
cc1: some warnings being treated as errors


Build image:
-----------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTbkOSx8FRoSUpBZX23UatyPIP/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTbkOSx8FRoSUpBZX23UatyPIP/build.log
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTbkOSx8FRoSUpBZX23UatyPIP/config
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.322-351-ge024cd330026/testrun/25686486/suite/build/test/gcc-12-lkftconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.284-463-g21641076146f/testrun/25690547/suite/build/test/gcc-12-lkftconfig/log

Steps to reproduce:
------------
   - tuxmake --runtime podman --target-arch arm --toolchain gcc-12
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTbkOSx8FRoSUpBZX23UatyPIP/config

metadata:
----
  git describe: v4.19.322-351-ge024cd330026
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: e024cd330026af478986a90829dd6ff03e3c1f92
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTbkOSx8FRoSUpBZX23UatyPIP/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTbkOSx8FRoSUpBZX23UatyPIP/
  toolchain: gcc-12 and gcc-8
  config: lkftconfig
  arch: arm

--
Linaro LKFT
https://lkft.linaro.org

