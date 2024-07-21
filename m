Return-Path: <linux-kernel+bounces-258149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAEF938468
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF281C20A0B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 11:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB8C14F9F9;
	Sun, 21 Jul 2024 11:03:49 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC30256E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721559829; cv=none; b=nsZIpqCD8Ea7/nX8JyTRWbzGEy42F7E9YNy6CpORo/CeGWLwj83mvtMGD6F3HDcaN2ZH6Wquqg2rcd/V3YMrngEdwZt5YKPoKfmMIPNt/BaivcIrxr0qj3Z8or1HfZ27DLsG8aR2fTTNOvF25r3cBqNZ8D7/3x8YWBemQ7hy99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721559829; c=relaxed/simple;
	bh=xNOcvyYXEPrYrexkegss4X3Il2aiOvlJJq5PM9vSbsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLv0YnQS8/ZHptGMG29/CqGs7teCGNONe+Msj2kPSY5F4maFsBjgfGmv6R70TeNKpp5wAVwaA2t4V9DdkzTLOD/Fa+Ejt8Ymy4jgclG59hKuv7WdDnQS3SXv+hG9x+B102K5aJvkCEIMwtDzs4OPLxl2MrkW66NUXY32AzQI1ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-427b9fca517so2985035e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 04:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721559826; x=1722164626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRTNVA0hrrTGGlNMnedMlTjxgz8134922UjhxbdxbXI=;
        b=suKvx6s9RslCPUB88/wBz6pMrgaqCuilrFRzcyeqEwpih2yLycDhhd9g5CBokmS2JO
         XfqgqR62xzAFjL25U3PcPFc+x+jLiG4nScHOiN5iywzjAsTe5kZPaHvTChbllDpk5yo3
         tlZht5GXCm/OEceOnViepIT5HCy0li60+dwP3MDGBQzUY46BATcngPek6Niqo7M5lp0b
         2Fco1cpIAS+MWVsN/VRHf10XbBkncCK+JS3T3D+H/SWrz1h/fN5eTcUmjH3+KICeSNLC
         n/F/3YLKVlhp3XwS49gfsDbD+o+BsmDDtMOqPnIayVyBRDGCnHFGZUUnOxgqBOH6nTLH
         ZgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWON/J+xK8hG4C0bSRVEXJsnJ8eHG2VFmz2bcvfoTI/JIEFsGS/uP6WwtX31pGN5ZAhoYmSdBGlZPLgCerDYYVNWYrDJJIG68Ij/HxJ
X-Gm-Message-State: AOJu0YyGQh+ZR/V6hoiHw0w4PYmstgFfAneTSYbMjns+THzWM1FUVmQH
	FSSbbynC6pi7npciHvBdmmg4HrQ0QUFnDfPwKvbqgEPsrE2Wc5M7
X-Google-Smtp-Source: AGHT+IHBdD8Pzny25jyW1tkHaPWCBvyiMEds++6BdmSyMQpzQ0KW5gFznV0rwpP85kwO4sgqmwwf8w==
X-Received: by 2002:a05:600c:3542:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-427daa683eamr20436505e9.4.1721559825450;
        Sun, 21 Jul 2024 04:03:45 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d292077dsm115652825e9.0.2024.07.21.04.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 04:03:44 -0700 (PDT)
Message-ID: <196a9f11-ba97-4c9c-9815-0ddd0cb50808@grimberg.me>
Date: Sun, 21 Jul 2024 14:03:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvmet: use unbound_wq for RDMA and TCP by default
To: Ping Gan <jacky_gam_2001@163.com>, hare@suse.de, hch@lst.de,
 kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <20240719091959.17163-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240719091959.17163-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 19/07/2024 12:19, Ping Gan wrote:
> When running nvmf on SMP platform, current nvme target's RDMA and
> TCP use bounded workqueue to handle IO, but when there is other high
> workload on the system(eg: kubernetes), the competition between the
> bounded kworker and other workload is very radical. To decrease the
> resource race of OS among them, this patchset will switch to unbounded
> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
> get some performance improvement. And this patchset bases on previous
> discussion from below session.
>
> https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/

Hold your horses.

This cannot be just switched without a thorough testing and actual 
justification/proof of
a benefit beyond just a narrow use-case brought initially by Ping Gan.

If the ask is to universally use an unbound workqueue, please provide 
detailed
benchmarking convincing us that this makes sense.

