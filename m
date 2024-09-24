Return-Path: <linux-kernel+bounces-336914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3FF984294
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A42AB26692
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE85171088;
	Tue, 24 Sep 2024 09:44:44 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057A16E886
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171084; cv=none; b=KMLzjeIikM899BE5GbrtThQDZd/Ik5lnEKG1l2KssoaDroir2wp0wSDgWN5hs24RDMGOD2VkT5ZF/w92J6/rov4PmJuc9rO3PY+geG5151aKRvdNFah46Ls2TX1uidH0iAoTYBFGOy0kLWs3l1PzFZFCOS9/MurTVT5IO0+K8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171084; c=relaxed/simple;
	bh=BAVooXLq1vIW08Zl52jAB4wSo1wTAyOdrjRAK0kYf9Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uz/+4b+eo631qkhyFnGJE+7R4+l8WFk7i9wPyFq/wJr2IZ/c78UhiKt0YbjCJmSuyKwQ056RCzKa05O0Jn3JTr+nFMhf47lSekvR8rlGG5xsWLcrPrgoZg+ukCkXFSrPC+qwUG5in2Y5Jc5u4YC6l6CnZ0Bl7JcP10kZXFL6epE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XCZgz5j5Jz4f3jXJ
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:44:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EE1B81A08DC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:44:31 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCXysb+ifJm5nnYCA--.7147S3;
	Tue, 24 Sep 2024 17:44:31 +0800 (CST)
Subject: Re: CVE-2024-46701: libfs: fix infinite directory reads for offset
 dir
To: Greg KH <gregkh@linuxfoundation.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: yangerkun@huawei.com, chuck.lever@oracle.com, brauner@kernel.org,
 sashal@kernel.org, Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org,
 cve@kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <b378c634-102f-e115-e925-0a20dc450ff7@huaweicloud.com>
 <2024092400-appointee-sensation-ddb1@gregkh>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8d0582ae-30f5-aa98-2778-423e81520507@huaweicloud.com>
Date: Tue, 24 Sep 2024 17:44:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024092400-appointee-sensation-ddb1@gregkh>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysb+ifJm5nnYCA--.7147S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WryxXw1xWFWDKFy8uw17Wrg_yoW8GFW7pr
	Z8J3W3trsrCr1fC3Z7Aw1xt3W0krWFvFW5tF98JrWkC345Z3s5Jr4ft39093sFgrs5tw4a
	va90grZ5GF45Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/09/24 17:03, Greg KH Ð´µÀ:
> On Tue, Sep 24, 2024 at 03:35:33PM +0800, Yu Kuai wrote:
>> Hi, all!
>>
>> This is a request to close this CVE.
>>
>> First of all, I think this really is not a kernel BUG, the deadloop
>> only exist in user side and user must rename between each readdir
>> syscall:
>>
>> while (readdr() > 0)
>> 	rename()
> 
> Sounds like a real thing that users can do, so why does this not fit the
> definition of "vulnerability" as documented by cve.org?

If user want to trigger the deadloop that readdir never return 0, then
user must keep rename inside this dir asynchronously and *never stop*,
this looks like shooting oneself in the foot for me.
> 
>> On the other hand, v6.6 is affected by this CVE, and this fix can't
>> be backported to v6.6 because the patchset [1] must be backported first
>> to expand offset from 32-bit to 64-bit.(This kind of refactor will
>> break kabi, hence it's not acceptable in our downstream kernels)
> 
> That's your business decision, and does not affect if we do, or do not,
> assign a CVE at all.  Go work with your management if you wish to change
> this as it does not pertain to the community in any way.

Yes, I understand, This is just the reason why I tried to close this
CVE, please ignore this.

BTW, if you still think this CVE is valid, can we bakport the refactor
patchset to v6.6 as well? I can sent the patches to 6.6 lts, just let me
know.

Thanks,
Kuai

> 
> thanks,
> 
> greg k-h
> .
> 


