Return-Path: <linux-kernel+bounces-436092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EDC9E8113
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454F2281ADF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A878B4644E;
	Sat,  7 Dec 2024 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="X77fXsbg"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D3A286A9
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733590208; cv=none; b=AR81jTpqv+Dgp95YNGKwyeIVBYzDj4CvLnuTURmi7R9vJEjQpxPXFOdX/v2pdEKFF8Bvdgjxdqjdo7Vakytk2EEx38B2MoWcBpPZ8qU42t7Mu/ZNfqO16wOw/r2RbgHdDYd4pfKUBN6PgCBpl/gslzDwy9xPwxrsnwOHtiF76xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733590208; c=relaxed/simple;
	bh=U06rFhpkNfCc9pLoevZcrZmzd0Xd1eaf8HHLvhffnRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMk03kOX4JXfFG57ANqQNA2rAR967FWo3MnPHfZUoWdsCvswQccaLVdt/9s1nPnFNNH+A49g5CdoGTP7oNDlYDUzso0CfUbDG6NRJqALFuI/4I4Qmynceiaae3deaeQQ7aoGMX1FgoHVJa5eDu6ahUcSlc+WHrvthIl08jcBAso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=X77fXsbg; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-29e842cb9b4so996801fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 08:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1733590205; x=1734195005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+graIh8bTs4uTD4AnHRNHowCXGHt/BdzED1MZIGg418=;
        b=X77fXsbgQ4HtZJkVTb5m2UhN047JxAwrNBCNPeiPKkZEcVZvLy7L/llZIIskQuczQ3
         pSg3OSbxu/qw0gAjr09BHdATyBslK3S9Nc0Oi9MpArFylOtiTvMyf1VzdOFOZLGCAyh8
         HNaBtPbWHLvGe3+5pn6V39T9ROybB/I2wCv9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733590205; x=1734195005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+graIh8bTs4uTD4AnHRNHowCXGHt/BdzED1MZIGg418=;
        b=rJCyqKKYD1tLCroyPJkIRO5MJWIr3ccAzrf1s1JkQSvNNxjZLGCPQadbh1kyq1waL6
         cqU4ddDM6cu+VzoM8pdt87mWLW0ALkkhic2rc3PKXG+WHmJCZxDIqJJoyVt4G3iEaPD6
         zDa+NL1FuFwpiMpzmJylf1gfwAo/N4TtovIKJ3rOeMS/giTco1EoA9dsDSCizsP886Un
         8XWpSVoqkbGJenJtVTMcWsWKXel3deDjz3laWXQZHxOtVWJsiHmtFChOwMZ3GGTfzRaT
         Qpk3WGY9782KgziLFarRG+cHrKiPGIaGa/6KC3F8jMznpAwEPUzILvIrDQLNarDW3Awl
         JvhA==
X-Gm-Message-State: AOJu0Yw1suMv9nbHNjeLjFTAZdjmQfNWlDqnHcTD6ECzUtgkz2X/KDyP
	6FiDtp0+aa5N1Dw/9ul8TCJaUSFmMpuaq4g6nqDnUmTqYrv6ao39dF/cWJkBjA==
X-Gm-Gg: ASbGncsluKrtouc+tlrDYrxyzjAqerlW7TxU1OjUQ1igniY6EMZwvKPrOgpEsFPl4TQ
	r39B+HAHEo+F5l0BxJjq3/VY38TuW6n3lhOBPCnfA7I95BzqLe83C1U5DExosRa+AZItwn6sb3c
	l9cV0Pt1OYK4CyLAZX3eq/z9ZwUeAFAs7eEyhv5RnQUqfUXDaKU91F8SrwM5UPpHkGN2g2iXKGf
	rrYHyQD4U+knU4q6B1+/sa1j5KIU0s4pgSGreyvzuSAD6/Sft6vnCYbJbIQU6N6+JhP76eMqskx
	ye81qZkz
X-Google-Smtp-Source: AGHT+IHwcHnxh1E5DZIOy3xY1Bop1D5fvZYCe+FfGq4yMBY3MN788CYSkaVzOvpOk8e+DToZ8V/hLw==
X-Received: by 2002:a05:6870:2b11:b0:29e:5897:e9d1 with SMTP id 586e51a60fabf-29f7376b81fmr3632601fac.39.1733590204934;
        Sat, 07 Dec 2024 08:50:04 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm590951fac.24.2024.12.07.08.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 08:50:03 -0800 (PST)
Message-ID: <1f597801-62b7-4fb1-9ffe-1b9554c4e23c@ieee.org>
Date: Sat, 7 Dec 2024 10:50:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] soc: hisilicon: Add power control support for kunpeng
 HBM
To: Zhang Zekun <zhangzekun11@huawei.com>, xuwei5@hisilicon.com,
 lihuisong@huawei.com, Jonathan.Cameron@huawei.com
Cc: linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com
References: <20241206112812.32618-1-zhangzekun11@huawei.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20241206112812.32618-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/6/24 5:28 AM, Zhang Zekun wrote:
> Add power control support for High Bandwidth Memory (HBM) for Kunpeng SoC
> platform. HBM devices on Kunpeng SoC can provide higher bandwidth at the
> cost of higher power consumption. Providing power control methods can help
> reducing the power when the workload does not need use HBM.

Could you explain a little more here how HBM is represented in the
system?  When it's powered on, it seems like it's "just memory".
And what you're doing here is enabling a power optimization to
allow this type of memory to be powered off when not in use.
How do you know whether it is in use?  What entity is meant to
be able to power this memory on and off?

In addition, it looks like there can be more than one instance of
an HBM device, and each is available to be used only for certain
CPUs.  Can you provide more information about that sort of
architectural detail?

Finally, the second patch enables "cache" functionality.  Maybe
this is something defined by ACPI and is well understood by others
but it's not clear to me what this even means.  How is an HBM
used, and how does its cache enabled/disabled state interact
with the device enabled/disabled state?

Is an HBM device something completely different from an HBM cache
device?  I guess I just lack a big-picture overview of how this
HBM fits into a system.

					-Alex

> 
> Zhang Zekun (2):
>    soc: hisilicon: kunpeng_hbmdev: Add support for controling the power
>      of hbm memory
>    soc: hisilicon: kunpeng_hbmcache: Add support for online and offline
>      the hbm cache
> 
>   MAINTAINERS                              |   7 +
>   drivers/soc/hisilicon/Kconfig            |  23 +++
>   drivers/soc/hisilicon/Makefile           |   2 +
>   drivers/soc/hisilicon/kunpeng_hbm.h      |  31 ++++
>   drivers/soc/hisilicon/kunpeng_hbmcache.c | 136 +++++++++++++++
>   drivers/soc/hisilicon/kunpeng_hbmdev.c   | 210 +++++++++++++++++++++++
>   6 files changed, 409 insertions(+)
>   create mode 100644 drivers/soc/hisilicon/kunpeng_hbm.h
>   create mode 100644 drivers/soc/hisilicon/kunpeng_hbmcache.c
>   create mode 100644 drivers/soc/hisilicon/kunpeng_hbmdev.c
> 


