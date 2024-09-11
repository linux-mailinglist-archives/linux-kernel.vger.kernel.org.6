Return-Path: <linux-kernel+bounces-324145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BABFD974863
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF64C1C2143F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AE73BBEB;
	Wed, 11 Sep 2024 02:56:40 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9A3BBC9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023399; cv=none; b=UaoYNPzTWzYnVUBQWeuXZvDyy8iWc0CFLNYp/Q1uz+WzMQpV1Ma+Y2wBbJrYlNgnOUk12TnGcsHUB2j78xk+aLGcfusEaawjPnc1vP0kfvPLm+Wtf428ok+xEPMkBNM+if0oLezE1Cq9FvOi6XHqag1ZsPjKCVm0l4pzTRmUYNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023399; c=relaxed/simple;
	bh=LyFk8bWV+0/71pUT9183lsfTtSllVtNWBhL7KkW1yUE=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=e3FBdLbyXPj2qNpsRLSdpfk2gyFkko7TboURXzLPmDgViPYVqvcCjo4fzeVdo+t0uc5DSuI96ixpKZZWxe8hlxDjuLTrtZMb5fbKLqaGwR+j+WFkoH7sQkHlxJ5j/I8yYVWTJ2Ru1cdNG77QciGDCb0V+CCEtVhFtxM5cHIHqJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 721990d06fe911efa216b1d71e6e1362-20240911
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:d91a7388-59d8-449b-bf5f-56cbfeb3efb0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:13e232e019dc0f319d65303b3dfb5d0e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 721990d06fe911efa216b1d71e6e1362-20240911
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1610315782; Wed, 11 Sep 2024 10:56:30 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 41186B8075B2;
	Wed, 11 Sep 2024 10:56:30 +0800 (CST)
X-ns-mid: postfix-66E106DE-149549471
Received: from [172.30.70.72] (unknown [172.30.70.72])
	by node2.com.cn (NSMail) with ESMTPA id 319BEB8075B2;
	Wed, 11 Sep 2024 02:56:29 +0000 (UTC)
Subject: Re: [PATCH] mm/vmscan: Fix hard LOCKUP in function isolate_lru_folios
From: liuye <liuye@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240815025226.8973-1-liuye@kylinos.cn>
 <20240823020443.7379-1-liuye@kylinos.cn>
 <d199d796-3c9b-cba5-e0c7-ce2b798362b1@kylinos.cn>
Message-ID: <cc60dff6-7561-ed60-532a-8862bc4a9914@kylinos.cn>
Date: Wed, 11 Sep 2024 10:56:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d199d796-3c9b-cba5-e0c7-ce2b798362b1@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


Friendly ping. =20

Thanks.


On 2024/9/6 =E4=B8=8A=E5=8D=889:16, liuye wrote:
>=20
>=20
> On 2024/8/23 =E4=B8=8A=E5=8D=8810:04, liuye wrote:
>> I'm sorry to bother you about that, but it looks like the following em=
ail send 7 days ago,=20
>> did not receive a response from you. Do you mind having a look at this=
=20
>> when you have a bit of free time please?
>>
>>>>> Fixes: b2e18757f2c9 ("mm, vmscan: begin reclaiming pages on a per-n=
ode basis")
>>>>
>>>> Merged in 2016.
>>>>
>>>> Under what circumstances does it occur? =20
>>>
>>> User processe are requesting a large amount of memory and keep page a=
ctive.
>>> Then a module continuously requests memory from ZONE_DMA32 area.
>>> Memory reclaim will be triggered due to ZONE_DMA32 watermark alarm re=
ached.
>>> However pages in the LRU(active_anon) list are mostly from=20
>>> the ZONE_NORMAL area.
>>>
>>>> Can you please describe how to reproduce this? =20
>>>
>>> Terminal 1: Construct to continuously increase pages active(anon).=20
>>> mkdir /tmp/memory
>>> mount -t tmpfs -o size=3D1024000M tmpfs /tmp/memory
>>> dd if=3D/dev/zero of=3D/tmp/memory/block bs=3D4M
>>> tail /tmp/memory/block
>>>
>>> Terminal 2:
>>> vmstat -a 1
>>> active will increase.
>>> procs -----------memory---------- ---swap-- -----io---- -system-- ---=
----cpu-------
>>>  r  b   swpd   free  inact active   si   so    bi    bo   in   cs us =
sy id wa st gu
>>>  1  0      0 1445623076 45898836 83646008    0    0     0     0 1807 =
1682  0  0 100  0  0  0
>>>  1  0      0 1445623076 43450228 86094616    0    0     0     0 1677 =
1468  0  0 100  0  0  0
>>>  1  0      0 1445623076 41003480 88541364    0    0     0     0 1985 =
2022  0  0 100  0  0  0
>>>  1  0      0 1445623076 38557088 90987756    0    0     0     4 1731 =
1544  0  0 100  0  0  0
>>>  1  0      0 1445623076 36109688 93435156    0    0     0     0 1755 =
1501  0  0 100  0  0  0
>>>  1  0      0 1445619552 33663256 95881632    0    0     0     0 2015 =
1678  0  0 100  0  0  0
>>>  1  0      0 1445619804 31217140 98327792    0    0     0     0 2058 =
2212  0  0 100  0  0  0
>>>  1  0      0 1445619804 28769988 100774944    0    0     0     0 1729=
 1585  0  0 100  0  0  0
>>>  1  0      0 1445619804 26322348 103222584    0    0     0     0 1774=
 1575  0  0 100  0  0  0
>>>  1  0      0 1445619804 23875592 105669340    0    0     0     4 1738=
 1604  0  0 100  0  0  0
>>>
>>> cat /proc/meminfo | head
>>> Active(anon) increase.
>>> MemTotal:       1579941036 kB
>>> MemFree:        1445618500 kB
>>> MemAvailable:   1453013224 kB
>>> Buffers:            6516 kB
>>> Cached:         128653956 kB
>>> SwapCached:            0 kB
>>> Active:         118110812 kB
>>> Inactive:       11436620 kB
>>> Active(anon):   115345744 kB  =20
>>> Inactive(anon):   945292 kB
>>>
>>> When the Active(anon) is 115345744 kB, insmod module triggers the ZON=
E_DMA32 watermark.
>>>
>>> perf show nr_scanned=3D28835844.=20
>>> 28835844 * 4k =3D 115343376KB approximately equal to 115345744 kB.
>>>
>>> perf record -e vmscan:mm_vmscan_lru_isolate -aR
>>> perf script
>>> isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=
=3D2 nr_skipped=3D2 nr_taken=3D0 lru=3Dactive_anon
>>> isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=
=3D0 nr_skipped=3D0 nr_taken=3D0 lru=3Dactive_anon
>>> isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=
=3D28835844 nr_skipped=3D28835844 nr_taken=3D0 lru=3Dactive_anon
>>> isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=
=3D28835844 nr_skipped=3D28835844 nr_taken=3D0 lru=3Dactive_anon
>>> isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=
=3D29 nr_skipped=3D29 nr_taken=3D0 lru=3Dactive_anon
>>> isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=
=3D0 nr_skipped=3D0 nr_taken=3D0 lru=3Dactive_anon
>>>
>>> If increase Active(anon) to 1000G then insmod module triggers the ZON=
E_DMA32 watermark. hard lockup will occur.
>>>
>>> In my device nr_scanned =3D 0000000003e3e937 when hard lockup. Conver=
t to memory size 0x0000000003e3e937 * 4KB =3D 261072092 KB.
>>>
>>> #5 [ffffc90006fb7c28] isolate_lru_folios at ffffffffa597df53
>>>     ffffc90006fb7c30: 0000000000000020 0000000000000000=20
>>>     ffffc90006fb7c40: ffffc90006fb7d40 ffff88812cbd3000=20
>>>     ffffc90006fb7c50: ffffc90006fb7d30 0000000106fb7de8=20
>>>     ffffc90006fb7c60: ffffea04a2197008 ffffea0006ed4a48=20
>>>     ffffc90006fb7c70: 0000000000000000 0000000000000000=20
>>>     ffffc90006fb7c80: 0000000000000000 0000000000000000=20
>>>     ffffc90006fb7c90: 0000000000000000 0000000000000000=20
>>>     ffffc90006fb7ca0: 0000000000000000 0000000003e3e937=20
>>>     ffffc90006fb7cb0: 0000000000000000 0000000000000000=20
>>>     ffffc90006fb7cc0: 8d7c0b56b7874b00 ffff88812cbd3000=20
>>>
>>>> Why do you think it took eight years to be discovered?
>>>
>>> The problem requires the following conditions to occur:
>>> 1. The device memory should be large enough.
>>> 2. Pages in the LRU(active_anon) list are mostly from the ZONE_NORMAL=
 area.
>>> 3. The memory in ZONE_DMA32 needs to reach the watermark.
>>>
>>> If the memory is not large enough, or if the usage design of ZONE_DMA=
32 area memory is reasonable, this problem is difficult to detect.
>>>
>>> notes:
>>> The problem is most likely to occur in ZONE_DMA32 and ZONE_NORMAL, bu=
t other suitable scenarios may also trigger the problem.
>>>
>>>> It looks like that will fix, but perhaps something more fundamental
>>>> needs to be done - we're doing a tremendous amount of pretty pointle=
ss
>>>> work here.  Answers to my above questions will help us resolve this.
>>>>
>>>> Thanks.
>>>
>>> Please refer to the above explanation for details.
>>>
>>> Thanks.
>>
>> Thanks.
>>
> Friendly ping.=20
>=20

