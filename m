Return-Path: <linux-kernel+bounces-516950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5622AA37A15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A908188E301
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B94137C35;
	Mon, 17 Feb 2025 03:32:42 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C014A8B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739763162; cv=none; b=NHmpPXc0OrmCjBW/s1Xc+2OclK5b8zvaFe5SU7IPBx244dm7JztizMcOvkQqbxlvoMe6TOoWbWCBPCgUdw5GTzsUB/Yu1yKsSqrO1GQ/Nw7pvfnV1E7cBpReuuzwltbkZ/BD8eEqFGWUsQdLFT48gBEiSUjI3oRqpjx0bY5Fd/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739763162; c=relaxed/simple;
	bh=RtEds23YRtqlQmdwFffAb0wqedCQwQPQAqjViRQxIkM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=idcbOyAJf7xieqo3/aH/3xtRNVqSTKQ6dLNFUFWR1Ck0qaugESesPmyGtB6hSLgYqdy1hcY4iWM3HYlWoPi6sOAmRIWEhSy57ltrTZilMyHBYloFhmISqMxnX6HEaGf4ltzpHHrkJ5hs/EEBRDiLxryfywiOk+u5E6r24TOAYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Yx7RC1spNz1wn6r;
	Mon, 17 Feb 2025 11:28:39 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id AC2231401F1;
	Mon, 17 Feb 2025 11:32:31 +0800 (CST)
Received: from [10.174.178.24] (10.174.178.24) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Feb 2025 11:32:30 +0800
Message-ID: <9360c637-203a-fef8-71b3-66eee10b9490@huawei.com>
Date: Mon, 17 Feb 2025 11:32:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH mpam mpam/snapshot/v6.12-rc1 v4 3/5] arm_mpam: Provide
 conversion method for new closid/rmid pairs
Content-Language: en-US
From: Zeng Heng <zengheng4@huawei.com>
To: <Dave.Martin@arm.com>, <james.morse@arm.com>
CC: <bobo.shaobowang@huawei.com>, <jonathan.cameron@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20250104101224.873926-1-zengheng4@huawei.com>
 <20250104101224.873926-4-zengheng4@huawei.com>
In-Reply-To: <20250104101224.873926-4-zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Hi Martin,

On 2025/1/4 18:12, Zeng Heng wrote:
> The MPAM driver statically assigns all reqPARTIDs to respective intPARTIDs.
> For the new rmid allocation strategy, it will check if there is an
> available rmid of any reqPARTID which belongs to the input closid, not just
> the rmids belonging to the closid.
> 
> For a mixture of MSCs system, for MSCs that do not support narrow-partid,
> we use the PARTIDs exceeding the number of closids as reqPARTIDs for
> expanding the monitoring groups.
> 
> In order to keep the existing resctrl API interface, the rmid contains both
> req_idx and PMG information instead of PMG only under the MPAM driver. The
> req_idx represents the req_idx-th sub-monitoring group under the control
> group. The new rmid would be like:
> 
>      rmid = (req_idx << shift | pmg).

To consider future compatibility with dynamically allocated reqpartid,
should I refactor the rmid?

Instead of defining rmid.req_idx, we could place the entire reqpartid
directly within rmid. In This way, the allocation of reqpartid will no
longer be constrained by the static allocation of closid, facilitating
future compatibility with dynamic allocation mechanisms. In this way,
it needs to refactor the resctrl_arch_rmid_idx_encode() and 
resctrl_arch_rmid_idx_decode(), and we can simplify
closid_rmid2reqpartid() to rmid2reqpartid().

What are your thoughts on this idea? Thank you in advance for your
reply.

Best regards,
Zeng Heng

