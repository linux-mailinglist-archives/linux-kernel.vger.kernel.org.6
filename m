Return-Path: <linux-kernel+bounces-401325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800709C18DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC771C23177
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4B01E0DE0;
	Fri,  8 Nov 2024 09:11:27 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3BE1E0DD0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057087; cv=none; b=TYyVDarkBdyGbpKQ8ym8OFCUFg49+UvMZLzn2V0M4ayAruVq4mNsmUkjzNtzEJKYbUl4zTo7uv9E7xy3z6r47N8ysOiMkmn6QYWCsxHHiz2JDuqmMyxCBXW0jaH5DZHhdibFGqF/mOm+dC4PkCeQznor+/J4d0p8FGEIVZF27jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057087; c=relaxed/simple;
	bh=YWAnSo4Zv/BqP+jnVGOUj4br9xaajZmDYjU7ZlVOELA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXbG72CuAdPxgbsWAgV04Dox7zDZhZWtNkHJ5Wu0/KIBhynpynJw13M30GUSOnZXhr+hE42Vl+lO5aYrDiyhdLODt6TnW1yKfiHI2VtUAGdWuSydhRH0SqLOjG3s2ykzi+N8PdpSKmcg9U14pnSJiu8lSeBGvLLUOWxiVvT5bho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XlCD80JMKz9v7JN
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:44:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 25FB7140DF8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:11:05 +0800 (CST)
Received: from [10.45.149.79] (unknown [10.45.149.79])
	by APP2 (Coremail) with SMTP id GxC2BwAnj36d1S1nCCc_AQ--.11122S2;
	Fri, 08 Nov 2024 10:11:04 +0100 (CET)
Message-ID: <7542399d-87c5-4f1c-9d09-6a6f96d148da@huaweicloud.com>
Date: Fri, 8 Nov 2024 10:10:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] tools/memory-model: Distinguish between syntactic
 and semantic tags
To: Akira Yokosawa <akiyks@gmail.com>
Cc: boqun.feng@gmail.com, dhowells@redhat.com, dlustig@nvidia.com,
 frederic@kernel.org, hernan.poncedeleon@huaweicloud.com,
 j.alglave@ucl.ac.uk, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, luc.maranget@inria.fr, npiggin@gmail.com,
 parri.andrea@gmail.com, paulmck@kernel.org, peterz@infradead.org,
 quic_neeraju@quicinc.com, stern@rowland.harvard.edu, urezki@gmail.com,
 will@kernel.org
References: <3d72b92a-4935-425c-abd5-ec4631baef2c@huaweicloud.com>
 <46d291da-ddb9-43b9-bd93-b81aacd5e29c@gmail.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <46d291da-ddb9-43b9-bd93-b81aacd5e29c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAnj36d1S1nCCc_AQ--.11122S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFWktr4fJr1UJr17KFyDKFg_yoWxZrXEkF
	4jkFWkua1UAF4UKF1SyFn0vrW0gF4vqw45Grn3Xr1fJry0kr4DAF48Jr90v347W3y7AFyU
	WF4YvF47uFy3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7sRidbbtUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 11/7/2024 um 11:51 AM schrieb Akira Yokosawa:
> Jonas, despite the CC, your message has not made my gmail mbox, not even
> the spam folder.
> I'm replying using lore's reply link. >
> As Paul mentioned elsewhere, the [v5] patch misses tags from Boqun at the moment.
>

So if I supply a new revision of a patch, should I include in all the 
reviewed-by of the previous patch?

I hadn't done that before (because I thought I should not add other 
people's tags especially if they hadn't reviewed that specific 
revision), so we may be missing *a lot* of reviewed-by...

If this is the case, I'll try to scour through the previous e-mails and 
add all the missing reviewed-by.

Best wishes,
    jonas


