Return-Path: <linux-kernel+bounces-375478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C8D9A9677
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBE21F233A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99AE12D766;
	Tue, 22 Oct 2024 03:00:42 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25AD26281
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566042; cv=none; b=OOwPgBgEVw3OWBCGShl05GlWWkqcip29BzCFR/sQB8DLLisHXKrJAVn27VcRUhjb86PL9j7fQHnTWI/WCgsVHFx9efP449dS8pLBEg9CjORMC07nrpBH2otWbITkJtrEcit5D5bkmYkZR4JV0h0jE/RoO8iLKwSFPehGnmfRE4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566042; c=relaxed/simple;
	bh=U2jObcSyvGOyRgTANjIeQaEm0ZW0e5p8n0NvCLcDEdA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y2//bvn6sK3ldx5J/jiCENs+vR6+HOmf6yREgPIETSdCsED6LY/z/YBXR2xBQM0yysyFZRYkBXttq70mKt9ReaGlvqmknR0xawEIPHDkBWx2aHOAvLqd/qkncOEc9bLWJHWZSVHPGPJG6yRB19oZxMlJLx5P6eaXcnlSOMHsZiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XXcNL15Flz20qjb;
	Tue, 22 Oct 2024 10:59:46 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 772A0140360;
	Tue, 22 Oct 2024 11:00:36 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Oct 2024 11:00:35 +0800
Subject: Re: [PATCH v2] coresight: trbe: Fix return value check in
 arm_trbe_register_coresight_cpu()
To: Markus Elfring <Markus.Elfring@web.de>, <coresight@lists.linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Anshuman Khandual
	<anshuman.khandual@arm.com>, James Clark <james.clark@linaro.org>, Mathieu
 Poirier <mathieu.poirier@linaro.org>, Mike Leach <mike.leach@linaro.org>,
	Suzuki Poulouse <suzuki.poulose@arm.com>
CC: LKML <linux-kernel@vger.kernel.org>
References: <20241021072120.739-1-thunder.leizhen@huawei.com>
 <d693331d-1e86-415f-8fdc-6a6b43f110a5@web.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <98933782-5e39-1cd8-8a1c-a7c2320e19d1@huawei.com>
Date: Tue, 22 Oct 2024 11:00:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d693331d-1e86-415f-8fdc-6a6b43f110a5@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/21 18:25, Markus Elfring wrote:
> …
>> memory instead of coresight_get_platform_data(), but forgot to update the
>> return value check code accordingly. Fix the incorrect return value check
>> for devm_kzalloc(), which returns NULL instead of ERR_PTR() when it fails.
> …
>> ---
>>  drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
> …
> 
> It would have been nice to add a patch version description.

Yes, I forgot the description, thanks. Only the commit message is updated in v2,
especially Fixes. But I'm not going to post v3.

> 
> See also:
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12-rc4#n321
> 
> * https://lore.kernel.org/all/?q=%22This+looks+like+a+new+version+of+a+previously+submitted+patch%22
> 
> 
> Regards,
> Markus
> .
> 

-- 
Regards,
  Zhen Lei

