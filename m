Return-Path: <linux-kernel+bounces-574775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67286A6E9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4591216C428
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5301D7E26;
	Tue, 25 Mar 2025 06:45:38 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B28635D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742885137; cv=none; b=U0Gbp0k1tETJxBvnq+RVTzRot+C0Vi2yCBY53d9tcFZ1mZpyGMJ+UeqnREaBz5xqsSqNfpGe1GkCJF8lNVYwUdl6oNJStlF2k3V0GRaj2/rFgtg5RbAXu9douhKCIpTcejKuZO7f5r1yfZQN00gSVFIAUBy8IpdIoo7qOBzQnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742885137; c=relaxed/simple;
	bh=i7sOSyFqxQ3RkzZLxPA0cjt6hIFev/ECxRLE/mRYYbs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uoZlv/1oHNAdOLCsbaHFvODQ9wtQjtlsWnszPUf5NggHPUIfQeXW9e8/F9WDmSoRiz8+u69EKLNuwmgsMKElqeexQ+nW1+1FexRurfpQnZzWcHee4c7wdxGwkkC0GzTxkhc58tCv8ckitlgR6gMxLaKgnMEwKNCC2sy0+uCJJRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZML5J2y2nz4f3jY4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:45:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 484731A0F9C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:45:31 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgAniFwJUeJnLJAFHg--.7441S2;
	Tue, 25 Mar 2025 14:45:31 +0800 (CST)
Subject: Re: [PATCH v3 0/8] Minor cleanups and improvements to swap freeing
 code
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kasong@tencent.com,
 tim.c.chen@linux.intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250320114829.25751-1-shikemeng@huaweicloud.com>
 <Z+EpL2zXWP2HM+GX@MiWiFi-R3L-srv>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <e08fa1f5-63cf-f5cb-76a4-a428d0d8f8dd@huaweicloud.com>
Date: Tue, 25 Mar 2025 14:45:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z+EpL2zXWP2HM+GX@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAniFwJUeJnLJAFHg--.7441S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtry7KF17JF1fWr13Zry8AFb_yoW3urb_Z3
	yruwn7KF42qwnrCayfKFyYvrs5GFWUGFyYvryrWw1furn5XryDXFWDCryrX3W7GaykJrZF
	9wnYvry7AwnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7
	UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/24/2025 5:43 PM, Baoquan He wrote:
> On 03/20/25 at 07:48pm, Kemeng Shi wrote:
>> v2->v3:
>> -Extent VM_BUG_ON instead of remove it
>> -Keep bracket for more readability
>> -Collect RVG from Tim for rest part
>>
>> v1->v2:
>> -Collect RVB from Tim
>> -Drop patch to factor out __swap_entry_free()
>> -Improve changelog and add more comment.
>> -Avoid unneeded lock re-aquire
>>
>> Hi All,
>> This series contains some cleanups and improvements which are made
>> during learning swapfile. Here is a summary of the changes:
> 
> Nice improvements about swapfile.c. Those kinds of swap_free_xxx
> confused me, I planned to clean up them. Thanks for great work.
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
Thank you for reviewing and pointing out the typo. We will fix
it in the next version

Thanks,
Kemeng


