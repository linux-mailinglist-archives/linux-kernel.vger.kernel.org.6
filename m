Return-Path: <linux-kernel+bounces-192332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D99C68D1BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9332F2860E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED43416D335;
	Tue, 28 May 2024 12:50:13 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B83F7316E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900613; cv=none; b=rg71ZCfVDE7rK7Hf5ipI99wzYN6mrCBtBthmh8/PXlmYEhIdQek6+Tv0VuL4MvvShSKqe73WN7kvYlLmPc85acnXekjd830CTXuvZtB8CHG8BzjRgmUMTsSDbsjizdfAq8vKYeWPiG6luG0NUj6puRCX2eoHpjJoT3kWz3az1oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900613; c=relaxed/simple;
	bh=IjmXFRto6+7z1Ill5fyeKjBggFVRl5YBHK585e6b8Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgddQjZPwobMwPV0HDWYD4mjo3m7l2KYP4ymUbOtgen3J4+8Qw3y3cpFDYMtVhGgQUCxpwcO4pLeNKpuM4EtezqzanKzqoel3iaBv2uMEdyrdo7wiOl2giV44PE1ABh4YxPewV8C1jxZDUbaoL8J0d5Jg7vbPp7/PQe873XRhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VpX3J0tmFz9v7Hm
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:32:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 6A9A01404F7
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:49:55 +0800 (CST)
Received: from [10.206.134.102] (unknown [10.206.134.102])
	by APP2 (Coremail) with SMTP id GxC2BwDXwibl0lVm5WURCQ--.44389S2;
	Tue, 28 May 2024 13:49:54 +0100 (CET)
Message-ID: <dbcecf28-98e8-4f7e-957b-e73a4d811051@huaweicloud.com>
Date: Tue, 28 May 2024 14:49:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 4/4] tools/memory-model: Distinguish between
 syntactic and semantic tags
To: Alan Stern <stern@rowland.harvard.edu>
Cc: paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240527152253.195956-1-jonas.oberhauser@huaweicloud.com>
 <20240527152253.195956-5-jonas.oberhauser@huaweicloud.com>
 <5ce0c8a3-bd9c-475a-9427-7edef47a90f2@rowland.harvard.edu>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <5ce0c8a3-bd9c-475a-9427-7edef47a90f2@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwDXwibl0lVm5WURCQ--.44389S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVW5JVWrJwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUU
	UUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/

>> +let Mb = MB \ FailedRMW
>> >>   (* Compute marked and plain memory accesses *)
>> -let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
>> +let Marked = (~M) | IW | ONCE | RELEASE | ACQUIRE | MB | domain(rmw) | range(rmw) |
> 
> The new MB term isn't needed, because MB tags on memory accesses are
> filtered out unless the access also belongs to domain(rmw) | range(rmw).
> 
> Alan


Thanks for all the notes.
I think on this one is needed though under the assumption that herd7 
would no longer know internally to replace the MB with ONCE in case
of failure.


best wishes,

   jonas


