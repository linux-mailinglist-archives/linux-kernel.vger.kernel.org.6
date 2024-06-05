Return-Path: <linux-kernel+bounces-203130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E738FD6D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CF52841BF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1622515534D;
	Wed,  5 Jun 2024 19:57:09 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403CE15533F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617428; cv=none; b=rcdutkQG+NjY8SQugnjVwx8QTQhlfIB1P2/6LStGgplFUC8Kego8NDPqcTPFSzVMo/pqTTDFZsuRILxugi9xj+Uv7a3ieUmLVgSC0hQkgkAF+Z4O/uz7EXNUAOjhMEdIl6nakEcuFgn1fF9jv3vwBdEsEIKCPfrZAb0+0vFxDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617428; c=relaxed/simple;
	bh=sM9zCmAOcCQhPm+eD27qIhnuXgIcxV/Y1JO2HIcW+kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gN9s3nPWjONbGq6WPK9R2bzyLR9OkpOR2a6xMkALObBR26H0i/U5CdZf0GWNoGhYerA4V4AVdENCoQ1/VCGgFTzpwmTBquIrBrVcXJfxVhumV7QN3JAllJFiR7viqdeES/JIjm3ViBZWPGcpKcLwtlA6vYtQYsziKdHws4ocx6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vvd7y6sZXz9v7Hk
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 03:39:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id CA2F3140A2F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 03:56:48 +0800 (CST)
Received: from [10.81.202.105] (unknown [10.81.202.105])
	by APP2 (Coremail) with SMTP id GxC2BwDXESbywmBmNyOaCQ--.2850S2;
	Wed, 05 Jun 2024 20:56:48 +0100 (CET)
Message-ID: <5be2fcc0-0fd7-49d8-bc4b-12bf3e90a677@huaweicloud.com>
Date: Wed, 5 Jun 2024 21:56:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/4] tools/memory-model: Define effect of Mb tags on
 RMWs in tools/...
To: Boqun Feng <boqun.feng@gmail.com>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
 will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, Viktor Vafeiadis <viktor@mpi-sws.org>
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
 <20240604160440.498332-1-jonas.oberhauser@huaweicloud.com>
 <Zl_pehpjHVt2z95p@Boquns-Mac-mini.home>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Zl_pehpjHVt2z95p@Boquns-Mac-mini.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwDXESbywmBmNyOaCQ--.2850S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWUJFyrGrWUtw1kGr1rWFg_yoW8KFy5pr
	Z0g3W5Kr4vqry7u3Z7Z3ZxXFyrWayfKF43GF1fJr93urW3urW7ZFyag3ZYqF9Ivw42ka4j
	yr4jq3Wvk34kAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 6/5/2024 um 6:28 AM schrieb Boqun Feng:
> On Tue, Jun 04, 2024 at 06:04:40PM +0200, Jonas Oberhauser wrote:
>> Herd7 transforms successful RMW with Mb tags by inserting smp_mb() fences
>> around them. We emulate this by considering imaginary po-edges before the
>> RMW read and before the RMW write, and extending the smp_mb() ordering
>> rule, which currently only applies to real po edges that would be found
>> around a really inserted smp_mb(), also to cases of the only imagined po
>> edges.
>>
>> Reported-by: Viktor Vafeiadis <viktor@mpi-sws.org>
>> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
>> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
>> ---
>>   tools/memory-model/linux-kernel.cat | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
>> index adf3c4f41229..d7e7bf13c831 100644
>> --- a/tools/memory-model/linux-kernel.cat
>> +++ b/tools/memory-model/linux-kernel.cat
>> @@ -34,6 +34,16 @@ let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
>>   let rmb = [R4rmb] ; fencerel(Rmb) ; [R4rmb]
>>   let wmb = [W] ; fencerel(Wmb) ; [W]
>>   let mb = ([M] ; fencerel(Mb) ; [M]) |
>> +	(*
>> +	 * full-barrier RMWs (successful cmpxchg(), xchg(), etc.) act as
>> +	 * though there were enclosed by smp_mb().
>> +	 * The effect of these virtual smp_mb() is formalized by adding
>> +	 * Mb tags to the read and write of the operation, and providing
>> +	 * the same ordering as though there were additional po edges
>> +	 * between the Mb tag and the read resp. write.
>> +	 *)
>> +	([M] ; po ; [Mb & R]) |
>> +	([Mb & W] ; po ; [M]) |
> 
> I couldn't help suggestting:
> 
> 	([M] ; po ; [Mb & domain(rmw)]) |
> 	([Mb & range(rmw)] ; po ; [M]) |
> 
> , it's a bit more clear to me, but maybe the comment above is good
> enough?

Hm, maybe clarity is in the eye of the beholder in this case.

Actually looking at your suggestion makes me think of smp_store_mb(), 
which although represented as Once;F[Mb] could be (mis)understood also 
as Mb&W. And it indeed does the same thing
   ([Mb & W] ; po ; [M])
would suggest.

(btw I think it is confusing that smp_store_mb is not strictly stronger 
than smp_store_release. Of course there are places where you want a 
relaxed store followed by an mb, but usually the mb versions are 
strictly stronger.).

Best wishes,
   jonas


