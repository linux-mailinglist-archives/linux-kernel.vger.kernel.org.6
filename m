Return-Path: <linux-kernel+bounces-363039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8D099BD33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5B9B21337
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 01:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4EC149;
	Mon, 14 Oct 2024 01:14:23 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E52F34
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728868463; cv=none; b=u0rjZlgt9mBH4JBOn3XxH1yl0BR2ZuPIkRKXitL29ewHNUtVxDaiPZ115sxPELjYrnVQi5kpWkHLbLlw7KS5CDgEVhUzl1S5h2cuwLXQCkqD6EA1yQzy+gAQ2hz+pwFlzlPFQD8j4CywnHAo8WokBT8b39bOVsAZ4EKrvfL/tvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728868463; c=relaxed/simple;
	bh=GUPY3jX9wSV6g89ncv6KVl/wQTL8oYc5UIQao9l8MiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n4QcL2MpB1oXXpPO/b5KNZJXbaclWFXF9Oq+3vn9CJW72shqmwQ70k2jgufF/YYdTe5jGk+d8XxJn0hnNZO4Ot2PL+CgKutKHhKJ/JFvETmor1JuTLu1VO3p4xkI1SwpKMYLvnjUQIGNo51kakXI9/mbfAgsN867JH+HZp1rfUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XRfMv6pk7zpWqk;
	Mon, 14 Oct 2024 09:12:11 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id CA6DB18005F;
	Mon, 14 Oct 2024 09:14:10 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Oct 2024 09:14:10 +0800
Message-ID: <178c52d9-6efb-b693-4e2c-64d2d7c3b1d3@huawei.com>
Date: Mon, 14 Oct 2024 09:14:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] misc: apds990x: Fix missing pm_runtime_disable()
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: <arnd@arndb.de>, <samu.p.onkalo@nokia.com>, <jic23@cam.ac.uk>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20240923035556.3009105-1-ruanjinjie@huawei.com>
 <0bcace87-6678-f84b-dd46-c88b33f67b73@huawei.com>
 <2024101336-finalize-drew-8f98@gregkh>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <2024101336-finalize-drew-8f98@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/10/13 23:10, Greg KH wrote:
> On Tue, Oct 08, 2024 at 10:37:23AM +0800, Jinjie Ruan wrote:
>> Ping.
> 
> For what?
> 
> If you are worried your patches are not being reviewed, please take the
> time to review other outstanding patches on the mailing list to make the
> workload be decreased for everyone.

Hi, greg

Thank you for your suggestion, I'll try to review other people's patches
 as much as I can.

> 
> thanks,
> 
> greg k-h

