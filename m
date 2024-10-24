Return-Path: <linux-kernel+bounces-379150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 307309ADAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E284B1F2276F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4DF16087B;
	Thu, 24 Oct 2024 03:54:08 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879D1EB3D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729742048; cv=none; b=GadObFEeajPRGiie7CHxeUkSXz+mEs3ACw5WVmUGsoiSni5FPIUydz1ay8cn11v8KzPccLfNfE0kEStvyLwBNZApGHzrEhEUR5Kvr8wDWDKDbb1Wkf4uLS1zAo+LsMH7VuB56rNncM8Il8IyWP/ak2YVsYkVfRYkMKOvmH+ujCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729742048; c=relaxed/simple;
	bh=G0IC9wvOn38bKdWfv1vRejCUIKdMK52OTuJPqgU89XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DQhRKLC2bziamFT5k6QJQ0IMei47MKvU2QFotOOvvxJiBl9wDLJVQWVtK8ae70cLqTjjX16I2wosqcr+/OLS21JzNBO0eXzf9nLe46uvoSNipERyXCuS78VIw9UZ7o77ow+KtLV/kkk0ND5CydN4k/5kxipmzAfXaWpQpGypOa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XYsSG3ldvzyTmd;
	Thu, 24 Oct 2024 11:52:30 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id C7A8E14011D;
	Thu, 24 Oct 2024 11:54:02 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 24 Oct 2024 11:54:02 +0800
Message-ID: <da6a0b86-4797-486c-8f02-472c9dcc01fa@huawei.com>
Date: Thu, 24 Oct 2024 11:54:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Return early when break handler is found on
 linked-list
To: Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
	<ptosi@google.com>, <oliver.upton@linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240827110046.3209679-1-liaochang1@huawei.com>
 <Zs3LnYkXL5sg2yBH@J2N7QTR9R3.cambridge.arm.com>
 <f9357dff-1f08-42ce-b6c2-93b3a2d9336f@huawei.com>
 <20241023164014.GE29251@willie-the-truck>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20241023164014.GE29251@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/10/24 0:40, Will Deacon 写道:
> On Wed, Oct 23, 2024 at 09:52:27AM +0800, Liao, Chang wrote:
>> Kindly ping.
>>
>> I'd like to get your input on the next step. Should I send a v2 patch
>> that only removes the WARN_ON() as Will suggested? Or should I push
>> forward the refactoring of calling BRK hook [1].
> 
> If you have the bandwidth to tackle Mark's refactoring idea, then please
> feel free to send a series. Otherwise, I'm happy to merge the v2. We
> could even do both.

Will, please pick the v2 from here:

  https://lore.kernel.org/all/20241024034120.3814224-1-liaochang1@huawei.com/

Meanwhile, I will discuss the refactoring patch with Mark. Thanks for your
suggestion.

> 
> Will

-- 
BR
Liao, Chang


