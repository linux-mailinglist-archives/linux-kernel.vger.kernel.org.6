Return-Path: <linux-kernel+bounces-356340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EBB995FBB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBF21C21349
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D818C178CCA;
	Wed,  9 Oct 2024 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ec4qkpFR"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD017B439
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455073; cv=none; b=jt/ihsaixMY8blpciVSWLerk43eGNyJsIdTse8DPHhtOc+pP8CkazgycxtA/6seg7tRvO7ZsXi+DX3oVzhPR0BhXKPZJQG/MMuAAlroe1Kc+GA3/y2mLjcqD1JaqEIkoN3H9CEhzGcfDEnnDKUaMyEE/bjGBrkx13663JaT8tI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455073; c=relaxed/simple;
	bh=qWz892YeKoJrS4nKN2pE68Uc5xhtWRYUGwhxmzGq5Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APJbPl721HCRHfh7VPXd9ytQ457sDM3ekjw2NFRyiQlp4qrjo2PEMh6n0OL//IEkZcJm2lJNiS/NGnEzicq91uMcIeX+ut4O0rF5JHFvQwEQNW9uy+Yz+DaaNJ4vKCckaZEBHfaT5z09JSZxc9spdFjgv1O3L6sFgZKB+vkmp/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ec4qkpFR; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-50a87472832so1717312e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728455070; x=1729059870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1K1fYPYOX1vHU5cmuw7GclgV31ArXw6XaL9jukhNp04=;
        b=Ec4qkpFRtXcH8OOWUzquitbCzMJb+BiMIS/sEH0UhwtbYGArpm/mmTHZcjevuvaEnF
         hJyyQMl0l/0H4kYjIxdDGbZa0DBUzj2ucUIZ24uvwCpuAUwaEq7xWUSjPEJLBAbpAWgu
         NQH3tnvJbYn7pa6RJUZ6j/x3koIa7XP74ioQNlDZ8T9w030ysJyJLDSJZVXQgS3PBCuX
         6tOUWXAfef0S3PyKTNOzQuJZ8C9W67P5SK3XF/GQY9T3pUECBDqspPi8lu4RdTh7/C6k
         3mDcLAlysoZYsgoom26UBFG1pMT0oV+qmnUw5llV3LB3KQscdw5ansNM7/qaZHuAu9cd
         K0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728455070; x=1729059870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1K1fYPYOX1vHU5cmuw7GclgV31ArXw6XaL9jukhNp04=;
        b=XfhdXq0xVz/+hae8A/WzuEyhP5iDDTnemJRdbpIkC0lvJHUs9+n41c6Sjgp9nXAtko
         PbZibPJKwMeZWICImbEnHGUMQtF8VDWq0J/kjxaq0XgTxhQTAwB/K0Z3Oww1DI+vP71/
         uE8oSjjYAAUX7sEQgTtOGgF266SQjqvf1k1Fh9GC/u8aJ+CFmjjOFe3tXY2NXlqG/hJB
         nIMdBQfftTjhYv6rUUKdzbk52k7XHp4cAmZfLIfbm5wb9irNIictI9gjqJX6+qMgK/IR
         /UveqxAQQjnZcxUesQYGStyNk2lX36fzuqCpXw9oVOHxpEmBSEOSwbGUVtbHcykYVfiP
         a3/g==
X-Forwarded-Encrypted: i=1; AJvYcCXjKq6k67aA+QK/BBcR/t7bp+LB8XUFqLXvtZw17alz7S2aTZGmthEo9AYgmSLwmBwA1jWZOOO2QBYvK7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGOwsLA0ASFhi/RQ1JqajM0dG+nLQbPAMclB91CBKD+DPzKCD
	P0Uusyz9v0y25JRWCb/T5NMGN515codsGKsTaAp7NchWYS/ANcGAZ2XXdqmn68yCgQjv0TzhkYK
	XxChFKZZMsVPR8TV3RYfPzV7bzgyGKGx/7wVACg==
X-Google-Smtp-Source: AGHT+IGGefmdK2gVfzZLdksZc4v9TSdXPzCoi8o8H3xFV8DF12srdbmwB1J3Xnt0YOqBOodOsk3MJVh5Bx0b9g7lKN0=
X-Received: by 2002:a05:6122:3c54:b0:507:9137:f5a7 with SMTP id
 71dfb90a1353d-50cf09d0fc4mr641100e0c.5.1728455070465; Tue, 08 Oct 2024
 23:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008115629.309157387@linuxfoundation.org>
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Oct 2024 11:54:18 +0530
Message-ID: <CA+G9fYttfwQ7s6P2RLc6QA81_DYi5WrpWtiM4gK7_RDG69=6AA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/386] 6.6.55-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 18:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.55 release.
> There are 386 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.55-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The LTP syscalls fanotify22 test failed  (broken).
This regression is noticed on linux.6.6.y, linux.6.10.y and linux.6.11.y.

We are bisecting this issue.

 ltp-syscalls
  - fanotify22

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log,
-----------
fanotify16.c:751[  452.527701] EXT4-fs error (device loop0):
__ext4_remount:6522: comm fanotify22: Abort forced by user
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1106: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.47.1 (20-May-2024)
tst_test.c:1120: TINFO: Mounting /dev/loop0 to
/scratch/ltp-6nPLv2EGcV/LTP_fanbDvQcT/test_mnt fstyp=ext4 flags=0
tst_test.c:1733: TINFO: LTP version: 20240524
tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
fanotify.h:122: TINFO: fid(test_mnt/internal_dir/bad_dir) =
6bd2dab9.86fe4716.7e82.df82837f.0...
fanotify.h:122: TINFO: fid(test_mnt/internal_dir) =
6bd2dab9.86fe4716.7e81.beaa198d.0...
fanotify22.c:278: TINFO: Umounting
/scratch/ltp-6nPLv2EGcV/LTP_fanbDvQcT/test_mnt
debugfs 1.47.1 (20-May-2024)
debugfs 1.47.1 (20-May-2024)
fanotify22.c:281: TINFO: Mounting /dev/loop0 to
/scratch/ltp-6nPLv2EGcV/LTP_fanbDvQcT/test_mnt fstyp=ext4 flags=0
fanotify.h:122: TINFO: fid(test_mnt) = 6bd2dab9.86fe4716.2.0.0...
fanotify22.c:59: TINFO: Mounting /dev/loop0 to
/scratch/ltp-6nPLv2EGcV/LTP_fanbDvQcT/test_mnt fstyp=ext4 flags=21
fanotify22.c:59: TBROK: mount(/dev/loop0, test_mnt, ext4, 33,
0x5659a1d5) failed: EROFS (30)

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=124e7c61deb2

Summary:
passed   0
failed   0
broken   1

--
Linaro LKFT
https://lkft.linaro.org

