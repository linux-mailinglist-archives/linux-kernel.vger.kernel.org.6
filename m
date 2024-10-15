Return-Path: <linux-kernel+bounces-365066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 690CE99DD09
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 064C5B21E70
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C4D1714CC;
	Tue, 15 Oct 2024 03:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tTiMym2h"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833EE46B8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728964397; cv=none; b=IAmxplUhQ+ocRAdCNkQrYIrQzD1M2nC1KOzOquJJHFF69mV5+pooAMDOkzaeCwr4GZ65gIe2MXA9RhEhu20VpiWMCewjKuK2ArZy1uXaW7M2YMESbsciOnko1CqdV1uRxPxdZ1SYJ1L4CprtgCkctngLfudbLAlgDQTGAfIjhOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728964397; c=relaxed/simple;
	bh=GyoFiN/rXaMe/m+aaklpP07LqfN1T2+8ThFonOV2jgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nbl+Jr0B44MNkCc2zfgkHEP+YOgy8kP9uP4RJJxcAxFYuaZr5CZ+JPdjHRrYpb8HUCEVYijUnZCAgoNIt8TgOBV+AMzOxDgyE615MJydI4A/3hrlcXEluL7j3KcVuZWJ8eeA0TzkWy06DrQzKASWkWuVQ5kbSMXisLBO2jjJwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tTiMym2h; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728964393; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GyoFiN/rXaMe/m+aaklpP07LqfN1T2+8ThFonOV2jgk=;
	b=tTiMym2hn0MQy3Ob3PPAInrEeTIWU4H3OFtbWtr2rJJOVvPArMXO8F0oprqJap0G1r3eW6wGpY0q5w4UAeO5PKTgBOngwBE4BDngjR0SfImf/zj2Ja/n2D9z982KjiF/0ILBGbYQSbXe/y9H1vlr7hfVjTCfmgT5uw5Hul6mVS0=
Received: from 30.221.131.163(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WHBoCoP_1728964391 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 11:53:12 +0800
Message-ID: <2d76e36c-95d5-4eb2-9825-fa5e739ae139@linux.alibaba.com>
Date: Tue, 15 Oct 2024 11:53:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix unsupported blksize in fileio mode
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
References: <20241015033601.3206952-1-hongzhen@linux.alibaba.com>
 <231e17e3-82c1-49f4-9cc1-b376b89205b3@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <231e17e3-82c1-49f4-9cc1-b376b89205b3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/10/15 11:47, Gao Xiang wrote:
> Hi Hongzhen,
>
> On 2024/10/15 11:36, Hongzhen Luo wrote:
>> In fileio mode, when blcksize is not equal to PAGE_SIZE,
>> erofs will attempt to set the block size of sb->s_bdev,
>> which will trigger a panic. This patch fixes this.
>>
>> Fixes: fb176750266a ("erofs: add file-backed mount support")
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>
> File-backed mounts should support < PAGE_SIZE sizes.
> You should just fix these cases instead.
>
> Thanks,
> Gao Xiang


Okay, I will fix it later.

---

Thanks,

Hongzhen


