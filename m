Return-Path: <linux-kernel+bounces-239974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20920926773
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D7528202F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1786A185E4F;
	Wed,  3 Jul 2024 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vsssUqfH"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8532B1849E0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029121; cv=none; b=lRy8xfC25QMebXHcNiXwDv2ozKPQQp7erIS0OemC/wpymliLPPYhgPFtP+iiN6SZmpC/BtSnHPxuFgYN8j8vb3Bud5OTLJBSqel5AynsrJtswBRdOn4JAIZdpHlHaQSmYRXZBgYwy1Lrj+Ie+lpWasjp+j5F+BlT2hemOOMG1BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029121; c=relaxed/simple;
	bh=I/SyeQYOGfLQAUSaryB4epiEujHxOBhpHqyBsKYQnmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKpAJklI/AmONk2Qs8kUs0vJ1w9tp41s0Y09C0Kt07ce1JmYG1/NT30SxCw4oNluhOmtvrXqpHrzEAeL1/LzPMEecK1TNSssi2wAhX4pwkCA7AOU2qRcM5/GvzpcoaNweyYF+CQzOX9qxxYsHccKJGfoNXHj+G5e0547xuvyvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vsssUqfH; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48f48ab80e3so2120645137.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720029118; x=1720633918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i8jcvDGwHGDOUPj1r3ad1ZdHqvoFYLPPd5l4l3bI77w=;
        b=vsssUqfH9ffgsx3yjTvNTWTN5YxgiyP0EO0n6BcdTHelomytRQavfMYdDosTo+DkIg
         slq2uc+0JAAvN082Z4Uet6rzEeE/7W0/bQ+lE7ix4rwI4PugwtabNJcc3BPIKSQqH93u
         J9+72jM3ECC96zFkTkqHb4bUhP5yM9xhoBk+N7kKVzZY+PDE2oiwgDLjZzSCWEjdtBxO
         z1hVkJvDaAyNX9CCZnyfueChL+HHpX81M9G1+/7vfdA25Vw0SzB1/TBdzOONKPgVFZl3
         xqSQJQGxe0i/PBMwZv60j8bxaFymgSJhWAAjpBsdikcgfNxWqBOlUxzaLE9K19WR+0rF
         mX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029118; x=1720633918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8jcvDGwHGDOUPj1r3ad1ZdHqvoFYLPPd5l4l3bI77w=;
        b=IXwFWMSJhOJdn6mr8VmDmOHCbQ1uatsjrZtZFkTIyJcrL1l5vpzWMY4LmrwUsLpKCO
         gNYMCG0Ec1VIzgzdhm1K6wzGnUv7utzFQegolGS+2kKjAf+mpxc6QB5cpXXwkP+BlW9u
         pBImVHMaszpAPUaQb1e11dqx0eiYIlQcqCiG6MZf6fc9yfsaoGbI6gBd+/uppYgN/PQn
         +dO7pM6FUzJRdejA5uT9EcOSx687VS/MActUI8BPlUPPI01ysihaaopARnvDZly6uElO
         hsMivxbDnUyTBovh2fyNfyV+8buY6QkJ7LY6Gk8Yl+6oC78ThQKD/f0hJSA8azJuwkEU
         Z02w==
X-Forwarded-Encrypted: i=1; AJvYcCVhqB8h+BhbCSpa08V5cKyHfAlM02kIYYqacUF4yXS1WdHKHRmO3Q64gqPUBSTsKsWgmlmYRtK6TDB2eE35aYoWhlwHC/2Xex0qxbB0
X-Gm-Message-State: AOJu0YzOqpu199E7+eAqh+p4w6xYgZIajBOd56vLc5sVEjkkvmqYqHI6
	yNsShd3ZJfG9rUgY7/uqTbgQsGrPKELJf6jGLsnNT69gc89XO0H+yepNbTA700wfsTcsd/xv0uK
	a0ezLVhF8RW08W4oTYZiO5vQkJfblNeMkEYtoOw==
X-Google-Smtp-Source: AGHT+IHhubxatrzSaA5HKwryk/uHLQRo61FC6EY73fx40maWnrKKGtHLfWp7my6T+SlQSv0KB+ZvBb6CauO9auPbwxg=
X-Received: by 2002:a05:6102:e14:b0:48f:9751:198b with SMTP id
 ada2fe7eead31-48faf12de8cmr14916609137.23.1720029118386; Wed, 03 Jul 2024
 10:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702170243.963426416@linuxfoundation.org> <CA+G9fYuK+dFrz3dcuUkxbP3R-5NUiSVNJ3tAcRc=Wn=Hs0C5ng@mail.gmail.com>
 <c440be12-3c22-4bb6-9a10-e3fd03b87974@app.fastmail.com>
In-Reply-To: <c440be12-3c22-4bb6-9a10-e3fd03b87974@app.fastmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Jul 2024 23:21:47 +0530
Message-ID: <CA+G9fYtuiiV0FDFoSZOaKQbKiQYw+SphhWZDjK8R-bH7dBfs5w@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/222] 6.9.8-rc1 review
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, shuah <shuah@kernel.org>, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>, 
	Jon Hunter <jonathanh@nvidia.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>, srw@sladewatkins.net, rwarsow@gmx.de, 
	Conor Dooley <conor@kernel.org>, Allen <allen.lkml@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Can Guo <quic_cang@quicinc.com>, Ziqi Chen <quic_ziqichen@quicinc.com>, 
	Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 14:55, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jul 3, 2024, at 11:08, Naresh Kamboju wrote:
> > On Tue, 2 Jul 2024 at 22:36, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> This is the start of the stable review cycle for the 6.9.8 release.
> >> There are 222 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> >>
> >> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.8-rc1.gz
> >> or in the git tree and branch at:
> >>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> >> and the diffstat can be found below.
> >>
> >> thanks,
> >>
> >> greg k-h
> >>
> >
> > The following kernel warning was noticed on arm64 Qualcomm db845c device while
> > booting stable-rc 6.9.8-rc1.
> >
> > This is not always a reproducible warning.
>
> I see that commit 77691af484e2 ("scsi: ufs: core: Quiesce request
> queues before checking pending cmds") got backported, and
> this adds direct calls to the function that warns, so this
> is my first suspicion without having done a detailed analysis.
>
> Adding everyone from that commit to Cc.
>
> Naresh, could you try reverting that commit?

I have reverted the above patch and boot tested and it works.
Since the reported problem is not easy to reproduce It is hard
to  confirm that the issue has been fixed.

However, I have submitted jobs with and without the patch and
running tests in a loop.

>
>       Arnd

- Naresh

