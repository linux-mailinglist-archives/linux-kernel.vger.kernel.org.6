Return-Path: <linux-kernel+bounces-401534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B60F9C1BDB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE781C2176B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293821E284D;
	Fri,  8 Nov 2024 11:08:13 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E881D1E22FD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064092; cv=none; b=aNyvK1N/vC6oaLdULMY3/lnaVjg6fu8OyOlOLQ5lCi0Faf+bEdSsirmOnADb3hs6ujx6lqGXG+fj1MAqXKYvgInbL9NBytzrmP+Q8YWfNrpH97hCvYaR5nTY235OcXuL6uxxUEo9hDB4Y+IjK4/duXbtjV4RG7xTr+68xpb7Odo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064092; c=relaxed/simple;
	bh=jjHzcXyyEV3sVpH8hxtDxnza8vtyLTeIgsAQncZisQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGTQAZ7SaorQQb8q49L18q2k/8F4+arGlR7XzE+uBp0GnQ0Lg3VNO556tasHcLJv7GkWsi1r+3gkQZvPvIYeZbQeeFotAlx0h6vBSOujJiGM0f4MRsOyUgY9oMczTenhIsdln8S6k+mg46umpJha5nxd92W9fmcK454WyPSY2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XlFy730gMz9v7JC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:47:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 63A89140868
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:08:00 +0800 (CST)
Received: from [10.45.149.79] (unknown [10.45.149.79])
	by APP2 (Coremail) with SMTP id GxC2BwD3XHwE8S1nl3hAAQ--.27275S2;
	Fri, 08 Nov 2024 12:07:59 +0100 (CET)
Message-ID: <f1d7a295-ad24-41c8-a431-7d6492d51097@huaweicloud.com>
Date: Fri, 8 Nov 2024 12:07:43 +0100
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
 <7542399d-87c5-4f1c-9d09-6a6f96d148da@huaweicloud.com>
 <a278c4a9-eae2-491e-8f13-5a87a25dad26@gmail.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <a278c4a9-eae2-491e-8f13-5a87a25dad26@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwD3XHwE8S1nl3hAAQ--.27275S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw4rJr47KFy7KF1UCw4xXrb_yoWkWrbE9r
	4jya4vkF4vqF1kXF4fAFsa9rZ5GFnFg3W5uryrJwn3Gr98JFyDWFWkt392v345K3ykuFsr
	GFnrJrWUAF13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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



Am 11/8/2024 um 11:12 AM schrieb Akira Yokosawa:
> On Fri, 8 Nov 2024 10:10:48 +0100, Jonas Oberhauser wrote:
>> I hadn't done that before (because I thought I should not add other people's tags
>> especially if they hadn't reviewed that specific revision), so we may be missing
>> *a lot* of reviewed-by...
>>
> 
> Section "Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:"
> of Documentation/process/submitting-patches.rst has this paragraph:
> 
>    Both Tested-by and Reviewed-by tags, once received on mailing list from tester
>    or reviewer, should be added by author to the applicable patches when sending
>    next versions.  However if the patch has changed substantially in following
>    version, these tags might not be applicable anymore and thus should be removed.
>    Usually removal of someone's Tested-by or Reviewed-by tags should be mentioned
>    in the patch changelog (after the '---' separator).
> 
> Does this help you?

Thanks so much, it does. My apologies to everyone whose reviewed-by tag 
I failed to add :(

I should have read that more document more carefully.

Best wishes,
    jonas


