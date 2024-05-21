Return-Path: <linux-kernel+bounces-185169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A787F8CB181
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E36B23961
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66639146A92;
	Tue, 21 May 2024 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="NeLnc5xi"
Received: from out187-24.us.a.mail.aliyun.com (out187-24.us.a.mail.aliyun.com [47.90.187.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E823446B4
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305817; cv=none; b=ukhTvAKlZNPwGqUGtTHVTrU5IxtunGE+QvE/kxGDTyqMVvkeT+VnJiPguvVMiCw9brSd/pvxiHiwJIIJD0vrWmkqQ2Oa7EQiwUo1AqkLAv1mT9+3WgtlJx57TZzk1HWKbJVHKv+wfPziFT3bgiU/MURhNOCigl4EaekpmtIFy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305817; c=relaxed/simple;
	bh=hhAiEHhq/+IVLuhBoxRZN0I/2XRvsWbz5OZ17hmIP3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a88bURwV64XrtNC7OTdQwbaL6PIIVs6sAOJQFZo8/eCJsGwaUFLCmXCUt7lfy7x5jjWwae4n0pWk0ePfRWup7dNNYVyJJenieHpD/xFZUgC0Tz10ZvndHosBmaVMFS9b1q2wK4nyeEu84RN2dRWswiU7hvRHpbcyOJDgKbTipRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=NeLnc5xi; arc=none smtp.client-ip=47.90.187.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716305797; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BsUOCl1wZm20I4sMYgfdQkLnm5pLpgfzJ1P84WVKH8k=;
	b=NeLnc5xi7JQWW0zvPfktDPaYQa3TByKwliCOjY94VEn7jtsXQc7FAL1PRwuLVpfw3zgFzELGxP6jBiuwgFnT9PUw+P6MpCoIOOCbzfZ4HK4pO/pfGduBmHqQ1U2tdp1DEx8QnXrmmhlNg6o7zkDEnI8dlgi1gcamun+N6lXRg9I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033055230028;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---.XjOK41._1716305793;
Received: from 30.236.49.195(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XjOK41._1716305793)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 23:36:35 +0800
Message-ID: <e2646fa8-5f34-4114-b3b4-a6f2ea17d811@antgroup.com>
Date: Tue, 21 May 2024 23:36:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm: Add update_mmu_tlb_range()
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 chenhuacai@kernel.org, tsbogend@alpha.franken.de, paul.walmsley@sifive.com,
 palmer@dabbelt.com, chris@zankel.net, jcmvbkbc@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 ryan.roberts@arm.com, ioworker0@gmail.com, libang.linux@gmail.com
References: <20240518074914.52170-1-libang.li@antgroup.com>
 <20240518074914.52170-2-libang.li@antgroup.com>
 <b356b558-d327-4bbc-9290-4e296877d145@redhat.com>
Content-Language: en-US
From: "Bang Li" <libang.li@antgroup.com>
In-Reply-To: <b356b558-d327-4bbc-9290-4e296877d145@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

Thanks for you review!

On 2024/5/21 17:32, David Hildenbrand wrote:
> On 18.05.24 09:49, Bang Li wrote:
>> Added update_mmu_tlb_range(), we can batch update tlb of an
>> address range.
>>
>> Signed-off-by: Bang Li <libang.li@antgroup.com>
>> ---
> 
> The generic variant that is a NOP from patch #2 should go into this 
> patch as well.

Good point. Thanks for pointing this out.

Thanks,
Bang

> 
> Apart from that LGTM
> 

