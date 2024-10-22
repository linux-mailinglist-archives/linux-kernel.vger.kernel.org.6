Return-Path: <linux-kernel+bounces-376201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65EA9AA17B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE17D1F23D75
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6F019CCF5;
	Tue, 22 Oct 2024 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MXJW+9T8"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C4612D1EA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598053; cv=none; b=A9fPBW2dCr1ODPd1gUTmlhn/GeAU6/trKJGUbB/3YZ0WrToEdJF/ogVN/Z1hZN8eet6EqGx7o54RhqjT7oDcyVxY9IaFnWrt8zw2lNdhKBsoB1y/vi5w6e6dFFZqs7EHuN8xEURZ/8Q4Ldl7HzuJ9dfuQdlSBkYGZZ+J55xZBAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598053; c=relaxed/simple;
	bh=ZCAGte7sVnaXSK6lOe4TTdNpFwLorRzdhUoqhpd0eys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kiEXVVZ+iBK2Y1fJnmbZQK/YGv8kXfeGXOrlUiXPY3jWt9Yw3p9suzfqftp7wIUNqRlLTayDHTTC33hFOoLKkZCiGd+IEAXDgn/TJoDyPFeUYNuVefGfC2zlGGk0ULrAn552COd1RzlEqrOghBVWaQ7wsLk7J1OzqTiOIuNjCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MXJW+9T8; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241022115403euoutp016176efe2657cb334628b613458dce960~AxEGffms12669626696euoutp01M
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:54:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241022115403euoutp016176efe2657cb334628b613458dce960~AxEGffms12669626696euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729598043;
	bh=we51Gd39C+n51gR4UL6qW0OeOqu7qn1FtrotZ0HEIG8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=MXJW+9T8jtCQ4vrJm2Davp/sl2sQqqNLUzbgxLY7kdZmDeVRk63yzDSK9XanH0uF4
	 Baj/AqmO/mHsVM0Gv6lA45C1Junq5jS4CKhocG3AS1ZcxKuxGt5xd10LlGRmfH8GPY
	 VKUeuoJbcS6T8dZqD9CmvLdmF/gETapX/c2Sh4M4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241022115402eucas1p1a10e76f1cf693f880154a82c85627ab6~AxEF-Mz4p3250732507eucas1p1H;
	Tue, 22 Oct 2024 11:54:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 47.E8.20397.A5297176; Tue, 22
	Oct 2024 12:54:02 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241022115401eucas1p156631990783f36c8d0153e23753bd627~AxEFgXbeS3249832498eucas1p1O;
	Tue, 22 Oct 2024 11:54:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241022115401eusmtrp12623784d8b2f7c12e040baf5785a656a~AxEFfNPWA1304713047eusmtrp1F;
	Tue, 22 Oct 2024 11:54:01 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-46-6717925acfb6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.6D.19654.95297176; Tue, 22
	Oct 2024 12:54:01 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241022115401eusmtip190f713af4cd56b5eacda8e7f0754d787~AxEEv9O3a0269702697eusmtip1f;
	Tue, 22 Oct 2024 11:54:01 +0000 (GMT)
Message-ID: <c8513bdb-1180-470b-a664-a8d526a12e5b@samsung.com>
Date: Tue, 22 Oct 2024 13:54:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Introduce support for T-head TH1520 Mailbox
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <ZxABCCJcoTmxiRXB@x1>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djP87pRk8TTDZbvk7TY+nsWu8WaveeY
	LOYfOcdqcWBPicW9S1uYLF7sbWSxuLZiLrvFy1n32Cwu75rDZrHtcwubxdojd4Fil3uYLdpm
	8Vv837OD3aJl/xQWB36PNy9fsngc7vjC7rFz1l12j02rOtk8Ni+p92hZe4zJ4/2+q2wefVtW
	MXpcar7O7jG94xm7x+dNcgHcUVw2Kak5mWWpRfp2CVwZr67cYiq4rlpx4fQqxgbG6fJdjJwc
	EgImEscX3mfrYuTiEBJYwSjRcuwQK4TzhVHi8sOvUM5nRonnizawwLSsX3gWKrGcUeL0khXs
	IAkhgbeMErc+M3UxcnDwCthJvPpcDmKyCKhKrJlYDlLBKyAocXLmE7AxogLyEvdvzQDrFBZw
	l/h18hFYXERAW2Ln6cUsIOOZBc4ySaydsA2siFlAXOLWk/lMIDabgJHEg+XzWUFsTgElibsn
	e9kgauQlmrfOZgZplhA4zClxdO0qqKNdJHZM+sQKYQtLvDq+hR3ClpE4PbkHqiZf4sHWT8wQ
	do3Ezp7jULa1xJ1zv9hAnmEW0JRYv0sfIuwosWTGbLB3JQT4JG68FYQ4gU9i0rbpzBBhXomO
	NiGIajWJqT29cEvPrdjGNIFRaRZSqMxC8uQsJM/MQti7gJFlFaN4amlxbnpqsXFearlecWJu
	cWleul5yfu4mRmASPP3v+NcdjCtefdQ7xMjEwXiIUYKDWUmEV6lENF2INyWxsiq1KD++qDQn
	tfgQozQHi5I4r2qKfKqQQHpiSWp2ampBahFMlomDU6qBifkvr0PBf8az3R0z9edwzAipj8uN
	sNniuOSKV63n0l18uXfss62NN/G8m9Jysvql/z3xxfesM+dvtt3y8qed29zj6S7nzswwqlLv
	2MSpbPyB26vy49rMg9+TvW4+7TTxPRf9PvukHmPcBn8Zl3OrAjmaHrPdWmlpmPBSl+nXgcUR
	G4PfFzFamPi1PeDNX5kewqtp+eWCS5pdr9myJOb8N1evbvz7VmDO4arznvdnZeZrWWzQ9Myo
	qDh85qVLaafZ9pfCkRdTGrjTpQ7Neez/4fq7fn8VxbxFj3YW3on+9Fhpeu/M7ylyDxamqfQb
	BMjf2Tbx1+ci5WX5vOrH/v8qvBt3QTv3+aKzxfwlP21nKLEUZyQaajEXFScCAAVD1KHxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xu7qRk8TTDY79NbPY+nsWu8WaveeY
	LOYfOcdqcWBPicW9S1uYLF7sbWSxuLZiLrvFy1n32Cwu75rDZrHtcwubxdojd4Fil3uYLdpm
	8Vv837OD3aJl/xQWB36PNy9fsngc7vjC7rFz1l12j02rOtk8Ni+p92hZe4zJ4/2+q2wefVtW
	MXpcar7O7jG94xm7x+dNcgHcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK
	+nY2Kak5mWWpRfp2CXoZr67cYiq4rlpx4fQqxgbG6fJdjJwcEgImEusXnmXtYuTiEBJYyijx
	4twrZoiEjMS17pcsELawxJ9rXWwQRa8ZJe4+vg+U4ODgFbCTePW5HMRkEVCVWDOxHKScV0BQ
	4uTMJ2CtogLyEvdvzWAHsYUF3CV+nXwEFhcR0JbYeXoxC8hIZoGzTBLbNr9lgZj/hVGiYfkb
	VpAqZgFxiVtP5jOB2GwCRhIPls8Hi3MKKEncPdnLBrKYWUBdYv08IYhyeYnmrbOZJzAKzUJy
	xywkk2YhdMxC0rGAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYNxvO/Zzyw7Gla8+6h1i
	ZOJgPMQowcGsJMKrVCKaLsSbklhZlVqUH19UmpNafIjRFBgUE5mlRJPzgYknryTe0MzA1NDE
	zNLA1NLMWEmcl+3K+TQhgfTEktTs1NSC1CKYPiYOTqkGpop5R+PEPxs9l9hy6vRKt95rvXk1
	c6uKDi1L2TN5/gbDBSuf9h/72zqh39alt8hkXVPAo0szq08tEQjZHcLk3v6sN+KVpMYdTXG7
	tbmRUVVi79yvhEbLF/MLnLTbKyF75IpXxizZRF+pxPP3ig2SWhYZK0QK9Lx+F/VNKD711ul9
	8/cpll/dFvpxbcjH4Gfh0f5OCoqHZq4MuyxbZjGxr/jk1f4QRdZ6I7u98ilv/r0JT1yyT4vD
	nP9d+KyTjDM5n/vdfmXUrFsgcGL++bcaDY8Xrs56HWa9+Y2SujNbjETXbSkX+zbW8AfZx+xM
	8zu8nz7zMHin1Hg3dc/yBcvVdsgrSvRo3FC7dyluivlbJZbijERDLeai4kQAH2gB5IQDAAA=
X-CMS-MailID: 20241022115401eucas1p156631990783f36c8d0153e23753bd627
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241014123409eucas1p2a3a3f085c0630073326ca299a870f3ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241014123409eucas1p2a3a3f085c0630073326ca299a870f3ee
References: <CGME20241014123409eucas1p2a3a3f085c0630073326ca299a870f3ee@eucas1p2.samsung.com>
	<20241014123314.1231517-1-m.wilczynski@samsung.com> <Zw1jdl64f5l8N+Km@x1>
	<431e98cd-6c53-4478-86a6-e532be4ed58e@samsung.com> <ZxABCCJcoTmxiRXB@x1>



On 10/16/24 20:08, Drew Fustini wrote:
> On Wed, Oct 16, 2024 at 12:03:05AM +0200, Michal Wilczynski wrote:
>>
>>
>> On 10/14/24 20:31, Drew Fustini wrote:
>>> On Mon, Oct 14, 2024 at 02:33:11PM +0200, Michal Wilczynski wrote:
>>>> The T-head TH1520 SoC supports a hardware mailbox that enables two cores
>>>> within the SoC to communicate and coordinate [1]. One example of such
>>>> coordination would be cooperation with the T-Head E902 core, which is
>>>> responsible for power, clock, and resource management. For example, in
>>>> the specific case of the BXM-4-64 GPU, it needs to be powered on by the
>>>> E902 core, and the kernel running on the E910 needs to 'ask' the
>>>> firmware running on the E902 core to enable power to the GPU island.
>>>> Given recent advancements in work on the upstream GPU driver [2], there
>>>> is an emerging need to get this code in the mainline kernel.
>>>>
>>>> Link: https://protect2.fireeye.com/v1/url?k=2021d256-7fbdfb7c-20205919-000babe598f7-ca654d1a9bc866ac&q=1&e=11e97355-e6e9-4aac-a996-cc475156b3c8&u=https%3A%2F%2Fopenbeagle.org%2Fbeaglev-ahead%2Fbeaglev-ahead%2F-%2Fblob%2Fmain%2Fdocs%2FTH1520%2520System%2520User%2520Manual.pdf [1]
>>>> Link: https://gitlab.freedesktop.org/imagination/linux-firmware/-/issues/1 [2]
>>>>
>>>> Thanks, Krzysztof and Rob, for your review! Since this series is gaining
>>>> some interest, I've dropped the RFC prefix with the v3 update.
>>>
>>> I've applied this series and booted okay. I see the driver loaded:
>>>
>>>  /sys/devices/platform/soc/ffffc38000.mailbox/driver points to
>>>  /sys/bus/platform/drivers/th1520-mbox
>>>
>>> How do you test that the communication with the E902 is working
>>> correctly?
>>
>> Thank you for your interest. To test this, I've prepared a diff that
>> includes the missing drivers utilizing the mailbox and enabled the GPU
>> node in the device tree to use the drm/imagination driver.
>>
>> I've observed that when the power was turned off through the E902 core
>> using the mailbox, the drm/imagination driver would hang in
>> pvr_load_gpu_id() while attempting to read its BVNC from the register.
>> However, when the GPU was turned on via the mailbox, the BVNC could be
>> read correctly. Still, the firmware fails to boot due to some missing
>> programming in the drm/imagination driver, which is currently being
>> worked on. I've briefly explained this in the first commit of this
>> series.
>>
>> If you'd like to try this yourself, I'd be happy to push these setups to
>> a GitHub repository and provide you with a link, so you can see the
>> setup in action.
> 
> I think that would be helpful for myself and others to be able to see
> the interaction.

I’ve cleaned up the code and it’s ready to share. I’ll include this
description and the GitHub links in the cover letter for the next
revision.

I’ve created two branches. Both contain the same code, including this
patch series and some extra commits with mailbox consumers. The only
difference is that one branch has an additional commit that switches ON
calls to OFF calls (and vice versa) to observe the behavior when the GPU
is turned off via the mailbox.

To reproduce, simply clone the repository, add the following extra options
in the config:

CONFIG_DRM_POWERVR=y
CONFIG_LIGHT_AON=y
CONFIG_LIGHT_AON_PD=y

Then build and deploy on the target.

In case [1], the output should be:
[    2.478394] light_aon_probe: virtual_log_mem=0x000000005faf564a, phy base=0x33600000, size:2097152
[    2.488589] succeed to create power domain debugfs direntry
[    2.494987] powervr ffef400000.gpu: Before reading BVNC
At this point, the system will hang because the driver is trying to read
memory-mapped registers while the GPU isn’t powered on.

In case [2], the GPU powers on correctly, and the BVNC can be read
without issues. If the specific firmware file isn’t available, the
output would look like this:
root@revyos-lpi4a:~# dmesg | grep gpu
[    2.408207] powervr ffef400000.gpu: Before reading BVNC
[    2.413533] powervr ffef400000.gpu: After reading BVNC
[    2.418930] powervr ffef400000.gpu: Direct firmware load for powervr/rogue_36.52.104.182_v1.fw failed with error -2
[    2.429568] powervr ffef400000.gpu: [drm] *ERROR* failed to load firmware powervr/rogue_36.52.104.182_v1.fw (err=-2)
[    2.440403] powervr ffef400000.gpu: probe with driver powervr failed with error -2

Here are the links:
[1] - https://github.com/mwilczy/linux/tree/22_october_demonstrate_mailbox_not_working
[2] - https://github.com/mwilczy/linux/tree/22_october_demonstrate_mailbox_working

Note: U-Boot must load the AON firmware at startup to the address mapped
for AON for this to work properly.

Thanks,
Michał

> 
> Thanks,
> Drew
> 

