Return-Path: <linux-kernel+bounces-180923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7BA8C74E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5817B284BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07026145356;
	Thu, 16 May 2024 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TE9hf5ya"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951AC145339
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856979; cv=none; b=kQkL7US/htw2PEMGt+RmU6iFw1WCZSpS5p5mfuA5Yuf3aATSlm9GBPc/a9NZjWT2q8ndIjcXqhccMXrETjI3f9UaBCl2JtPUY2fN7oPoEnrU06VHFwyj+VoIwYRHIOb+ocuUZaY6Uo5Nds8XE5PAR5nIq/L178ONrMDg+2eMjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856979; c=relaxed/simple;
	bh=aCXY487Vxu2tav49EYVB23ecLd3zrF9qRUTgLAbSiNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYypNDEU3X8IcoQ1jEMosUYC11X3d0BKXvqqq3WvFswfAYrIIEmryhIwd6elapxSDtWW7S1hK+3Lvjhlr4zj5TE/YcuQyJdcVK46zjZMKUzb7TCyFn0lOEWJF9bbVjeAMa5t4+/Jyz10j15wa/BIiJbJM3S5COl6aM8wxzT+jMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TE9hf5ya; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4df3ad5520aso3151860e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 03:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715856975; x=1716461775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8hvYdyfxE3IpE/vm58h7LJU7ngmgeqBpo8sHkqV4Ox4=;
        b=TE9hf5yaU8iDoNze1GUkhXXHYRmW/CsFo0KDlNOoaKgQLvkdu8+fp0VRZCEnrexS8M
         SqaKYSAAf+qUQGUCcU9Aftj2o5MF+qVIgMKZ7yb4rIKCVG9QvKYyG215U+7BHYCEAEId
         IET0za4d/eN09BoBz3pkqIw1CQD4m1W6MutiY1MOYa1udQ44KFFBF2X681WgWd6Wh/GR
         pAVxcSQdlU+BbNl8qnuYBSk4apX9qn63Z83dDRaVRFzvV0n5ZuOyw9CgFDA4jarOB4Bd
         rwv/aXTaaFFWow59+p0lrmtqkWaheERUTiD/VWY4k5f9fboiDQdulPoijHctpeFU761O
         cUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715856975; x=1716461775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hvYdyfxE3IpE/vm58h7LJU7ngmgeqBpo8sHkqV4Ox4=;
        b=S3hWHptRRA06RM6mY9d6Zc08xbUGPS3AIf7UWAopzI+y0v4vK9UJIEvbkTyEGWvXwX
         OJEzb5M7SwgY0KU8FLfNKMMnVFnTNst6NvBNBFy5j6pWtzGeO3F+IIWyP0zYEMCYfBxt
         sRo5+XxxAJ7N4NSFVNTmvwSVTeVo6DI0bzDfijxqZelSBToMDvusRntY0jrPzq08kxQW
         WHeJPy+nOD5V6em13xNasyBhVqSGl6D5JYmSJlhT/2vXpm6B45NRMhOmJ+grz9qgem+s
         /Mo4RY4HY3L7pymVpdSdQq7DfMJw1tpYJc2+M7WSG+mTRGtOzHD/bEp28U6ab9mSjZ4N
         wBiw==
X-Forwarded-Encrypted: i=1; AJvYcCXsHqBhM5R76WWIg6z4rpfSNrjtmiw6J6rrPDkJ35VTrqbivYr1kfoVJzAe5vLR7wNZO36dXAEk4pABrMTjZgbgPN7sCiC6MZyQYO+M
X-Gm-Message-State: AOJu0YwFnUOF41QUUuH8XJgT8Pw2D2Y18vRJ3u7AsBMcOTvynjJRQcu8
	SR8VMPCC/xavOpTIwPowOqqMADXTPpSHe1FAbTrywpYs3JIMVV5MqgkAEWl9Vh4KVzT8BHiO16V
	bNcGwAT/qxdnF/W3tr3Pix+7yGk25LcPKmaeUlQ==
X-Google-Smtp-Source: AGHT+IHLfOcjHOyNax1qpFAJlUavmIK8GXsB4d5nnt42V8lPqyLhP6Ngp7Ge930ihPYf+AX/U/jPZnq78529h9Sa7uE=
X-Received: by 2002:a05:6122:4698:b0:4df:315a:adab with SMTP id
 71dfb90a1353d-4df882c2956mr17221080e0c.5.1715856975523; Thu, 16 May 2024
 03:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515082517.910544858@linuxfoundation.org>
In-Reply-To: <20240515082517.910544858@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 May 2024 12:56:04 +0200
Message-ID: <CA+G9fYsZ7iTr8UGyaN-FB1R8=zLWnciB_10mzk8QCRhUMLSfFQ@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/340] 6.8.10-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 10:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.10 release.
> There are 340 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.10-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As Mark Brown reported and bisected.
LKFT also noticed this test regression on 6.8 and 6.6 branches.

kselftest-ftrace test case,
ftrace_ftracetest-ktap_Test_file_and_directory_owership_changes_for_eventfs
failed on all the boards.

Looks we need to add this patch,
  d57cf30c4c07837799edec949102b0adf58bae79
  eventfs: Have "events" directory get permissions from its parent

Let me try this patch and get back to you.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
---
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.9-341-gcfe824b75b3d/testrun/23938179/suite/kselftest-ftrace/test/ftrace_ftracetest-ktap_Test_file_and_directory_owership_changes_for_eventfs/history/

- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.9-341-gcfe824b75b3d/testrun/23929234/suite/kselftest-ftrace/test/ftrace_ftracetest-ktap_Test_file_and_directory_owership_changes_for_eventfs/details/

## Build
* kernel: 6.8.10-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.8.y
* git commit: cfe824b75b3d9d13a891ad1c4a2d6fe0eceed1e9
* git describe: v6.8.9-341-gcfe824b75b3d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.9-341-gcfe824b75b3d

--
Linaro LKFT
https://lkft.linaro.org

