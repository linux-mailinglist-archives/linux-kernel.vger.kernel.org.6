Return-Path: <linux-kernel+bounces-335446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704397E5D4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3D02814AA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBC310A3E;
	Mon, 23 Sep 2024 06:04:09 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC91747F
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727071448; cv=none; b=W1VCTG+XLTXuusc8eQBs3SOvIW+t0MUB2XLTFTL+0pZFmqi700r8cds1wyLxhqSVCdN8S82DD9Wwj6EPXdP4Vtm5mA+iXpyXb079j0aHs9rrzus9tYBvWx/cfYpcJizQI477bntFZ482GFtZBRv591lTwmX+DEbkW01MDrWXT0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727071448; c=relaxed/simple;
	bh=TlbhfQs49SpFdGvBlI/yE0zz9ZMDLh3wJfOp+MsX8Hs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EGC6EYOxhOiLxJ64VOEpi6IryeyEacc49FtHFgvkz/cZ98aGGDxg8lAc6+tJLJfyX0s/M6ovv2NoF4Xjp1rJDcB/sck1fN7OXQewHAvFwsz9ktQKEgiMBDL/vAXu25Sh7Rn3699wKaWLtRzNK/JH1zFagO2QEHG11KBCU3+rjyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9a3d574a797111efa216b1d71e6e1362-20240923
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:120c2f61-aa16-4eec-85f4-da0ff71b04e3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:e844e0157a94cd5d9eafa5d4822609bc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:nil,UR
	L:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 9a3d574a797111efa216b1d71e6e1362-20240923
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 356476908; Mon, 23 Sep 2024 14:03:49 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 94013B8075B2;
	Mon, 23 Sep 2024 14:03:49 +0800 (CST)
X-ns-mid: postfix-66F104C5-514459568
Received: from [172.30.70.71] (unknown [172.30.70.71])
	by node2.com.cn (NSMail) with ESMTPA id EDBB0B8075B2;
	Mon, 23 Sep 2024 06:03:46 +0000 (UTC)
Subject: Re: [PATCH v2] mm/vmscan: Fix hard LOCKUP in function
 isolate_lru_folios
To: Bharata B Rao <bharata@amd.com>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Dadhania, Nikunj" <nikunj.dadhania@amd.com>,
 Usama Arif <usamaarif642@gmail.com>, Yu Zhao <yuzhao@google.com>,
 Zhaoyang Huang <huangzhaoyang@gmail.com>, Breno Leitao <leitao@debian.org>
References: <20240814142743.c8227d72be4c5fd9777a4717@linux-foundation.org>
 <20240919021443.9170-1-liuye@kylinos.cn>
 <1727070383769353.48.seg@mailgw.kylinos.cn>
From: liuye <liuye@kylinos.cn>
Message-ID: <e878653e-d380-81c2-90a8-fd2d1d4e7287@kylinos.cn>
Date: Mon, 23 Sep 2024 14:03:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1727070383769353.48.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2024/9/20 =E4=B8=8B=E5=8D=882:31, Bharata B Rao wrote:
> On 19-Sep-24 7:44 AM, liuye wrote:
>> This fixes the following hard lockup in function isolate_lru_folios
>> when memory reclaim.If the LRU mostly contains ineligible folios
>> May trigger watchdog.
>>
>> watchdog: Watchdog detected hard LOCKUP on cpu 173
>> RIP: 0010:native_queued_spin_lock_slowpath+0x255/0x2a0
>> Call Trace:
>> =C2=A0=C2=A0=C2=A0=C2=A0_raw_spin_lock_irqsave+0x31/0x40
>> =C2=A0=C2=A0=C2=A0=C2=A0folio_lruvec_lock_irqsave+0x5f/0x90
>> =C2=A0=C2=A0=C2=A0=C2=A0folio_batch_move_lru+0x91/0x150
>> =C2=A0=C2=A0=C2=A0=C2=A0lru_add_drain_per_cpu+0x1c/0x40
>> =C2=A0=C2=A0=C2=A0=C2=A0process_one_work+0x17d/0x350
>> =C2=A0=C2=A0=C2=A0=C2=A0worker_thread+0x27b/0x3a0
>> =C2=A0=C2=A0=C2=A0=C2=A0kthread+0xe8/0x120
>> =C2=A0=C2=A0=C2=A0=C2=A0ret_from_fork+0x34/0x50
>> =C2=A0=C2=A0=C2=A0=C2=A0ret_from_fork_asm+0x1b/0x30
>>
>> lruvec->lru_lock owner=EF=BC=9A
>>
>> PID: 2865=C2=A0=C2=A0=C2=A0=C2=A0 TASK: ffff888139214d40=C2=A0 CPU: 40=
=C2=A0=C2=A0 COMMAND: "kswapd0"
>> =C2=A0 #0 [fffffe0000945e60] crash_nmi_callback at ffffffffa567a555
>> =C2=A0 #1 [fffffe0000945e68] nmi_handle at ffffffffa563b171
>> =C2=A0 #2 [fffffe0000945eb0] default_do_nmi at ffffffffa6575920
>> =C2=A0 #3 [fffffe0000945ed0] exc_nmi at ffffffffa6575af4
>> =C2=A0 #4 [fffffe0000945ef0] end_repeat_nmi at ffffffffa6601dde
>> =C2=A0=C2=A0=C2=A0=C2=A0 [exception RIP: isolate_lru_folios+403]
>> =C2=A0=C2=A0=C2=A0=C2=A0 RIP: ffffffffa597df53=C2=A0 RSP: ffffc90006fb=
7c28=C2=A0 RFLAGS: 00000002
>> =C2=A0=C2=A0=C2=A0=C2=A0 RAX: 0000000000000001=C2=A0 RBX: ffffc90006fb=
7c60=C2=A0 RCX: ffffea04a2196f88
>> =C2=A0=C2=A0=C2=A0=C2=A0 RDX: ffffc90006fb7c60=C2=A0 RSI: ffffc90006fb=
7c60=C2=A0 RDI: ffffea04a2197048
>> =C2=A0=C2=A0=C2=A0=C2=A0 RBP: ffff88812cbd3010=C2=A0=C2=A0 R8: ffffea0=
4a2197008=C2=A0=C2=A0 R9: 0000000000000001
>> =C2=A0=C2=A0=C2=A0=C2=A0 R10: 0000000000000000=C2=A0 R11: 000000000000=
0001=C2=A0 R12: ffffea04a2197008
>> =C2=A0=C2=A0=C2=A0=C2=A0 R13: ffffea04a2197048=C2=A0 R14: ffffc90006fb=
7de8=C2=A0 R15: 0000000003e3e937
>> =C2=A0=C2=A0=C2=A0=C2=A0 ORIG_RAX: ffffffffffffffff=C2=A0 CS: 0010=C2=A0=
 SS: 0018
>> =C2=A0=C2=A0=C2=A0=C2=A0 <NMI exception stack>
>> =C2=A0 #5 [ffffc90006fb7c28] isolate_lru_folios at ffffffffa597df53
>> =C2=A0 #6 [ffffc90006fb7cf8] shrink_active_list at ffffffffa597f788
>> =C2=A0 #7 [ffffc90006fb7da8] balance_pgdat at ffffffffa5986db0
>> =C2=A0 #8 [ffffc90006fb7ec0] kswapd at ffffffffa5987354
>> =C2=A0 #9 [ffffc90006fb7ef8] kthread at ffffffffa5748238
>> crash>
>>
>> Scenario:
>> User processe are requesting a large amount of memory and keep page ac=
tive.
>> Then a module continuously requests memory from ZONE_DMA32 area.
>> Memory reclaim will be triggered due to ZONE_DMA32 watermark alarm rea=
ched.
>> However pages in the LRU(active_anon) list are mostly from
>> the ZONE_NORMAL area.
>>
>> Reproduce:
>> Terminal 1: Construct to continuously increase pages active(anon).
>> mkdir /tmp/memory
>> mount -t tmpfs -o size=3D1024000M tmpfs /tmp/memory
>> dd if=3D/dev/zero of=3D/tmp/memory/block bs=3D4M
>> tail /tmp/memory/block
>>
>> Terminal 2:
>> vmstat -a 1
>> active will increase.
>> procs ---memory--- ---swap-- ---io---- -system-- ---cpu--- ...
>> =C2=A0 r=C2=A0 b=C2=A0=C2=A0 swpd=C2=A0=C2=A0 free=C2=A0 inact active=C2=
=A0=C2=A0 si=C2=A0=C2=A0 so=C2=A0=C2=A0=C2=A0 bi=C2=A0=C2=A0=C2=A0 bo
>> =C2=A0 1=C2=A0 0=C2=A0=C2=A0 0 1445623076 45898836 83646008=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 1=C2=A0 0=C2=A0=C2=A0 0 1445623076 43450228 86094616=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 1=C2=A0 0=C2=A0=C2=A0 0 1445623076 41003480 88541364=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 1=C2=A0 0=C2=A0=C2=A0 0 1445623076 38557088 90987756=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 1=C2=A0 0=C2=A0=C2=A0 0 1445623076 36109688 93435156=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 1=C2=A0 0=C2=A0=C2=A0 0 1445619552 33663256 95881632=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 1=C2=A0 0=C2=A0=C2=A0 0 1445619804 31217140 98327792=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 1=C2=A0 0=C2=A0=C2=A0 0 1445619804 28769988 100774944=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 1=C2=A0 0=C2=A0=C2=A0 0 1445619804 26322348 103222584=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 1=C2=A0 0=C2=A0=C2=A0 0 1445619804 23875592 105669340=C2=A0=C2=A0=
=C2=A0 0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>
>> cat /proc/meminfo | head
>> Active(anon) increase.
>> MemTotal:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1579941036 kB
>> MemFree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1445618500 kB
>> MemAvailable:=C2=A0=C2=A0 1453013224 kB
>> Buffers:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 6516 kB
>> Cached:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 128653956 kB
>> SwapCached:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0 kB
>> Active:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 118110812 kB
>> Inactive:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11436620 kB
>> Active(anon):=C2=A0=C2=A0 115345744 kB
>> Inactive(anon):=C2=A0=C2=A0 945292 kB
>>
>> When the Active(anon) is 115345744 kB, insmod module triggers
>> the ZONE_DMA32 watermark.
>>
>> perf record -e vmscan:mm_vmscan_lru_isolate -aR
>> perf script
>> isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=3D=
2
>> nr_skipped=3D2 nr_taken=3D0 lru=3Dactive_anon
>> isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=3D=
0
>> nr_skipped=3D0 nr_taken=3D0 lru=3Dactive_anon
>> isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=3D=
28835844
>> nr_skipped=3D28835844 nr_taken=3D0 lru=3Dactive_anon
>> isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=3D=
28835844
>> nr_skipped=3D28835844 nr_taken=3D0 lru=3Dactive_anon
>> isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=3D=
29
>> nr_skipped=3D29 nr_taken=3D0 lru=3Dactive_anon
>> isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=3D=
0
>> nr_skipped=3D0 nr_taken=3D0 lru=3Dactive_anon
>>
>> See nr_scanned=3D28835844.
>> 28835844 * 4k =3D 115343376KB approximately equal to 115345744 kB.
>>
>> If increase Active(anon) to 1000G then insmod module triggers
>> the ZONE_DMA32 watermark. hard lockup will occur.
>>
>> In my device nr_scanned =3D 0000000003e3e937 when hard lockup.
>> Convert to memory size 0x0000000003e3e937 * 4KB =3D 261072092 KB.
>>
>> =C2=A0=C2=A0=C2=A0 [ffffc90006fb7c28] isolate_lru_folios at ffffffffa5=
97df53
>> =C2=A0=C2=A0=C2=A0=C2=A0 ffffc90006fb7c30: 0000000000000020 0000000000=
000000
>> =C2=A0=C2=A0=C2=A0=C2=A0 ffffc90006fb7c40: ffffc90006fb7d40 ffff88812c=
bd3000
>> =C2=A0=C2=A0=C2=A0=C2=A0 ffffc90006fb7c50: ffffc90006fb7d30 0000000106=
fb7de8
>> =C2=A0=C2=A0=C2=A0=C2=A0 ffffc90006fb7c60: ffffea04a2197008 ffffea0006=
ed4a48
>> =C2=A0=C2=A0=C2=A0=C2=A0 ffffc90006fb7c70: 0000000000000000 0000000000=
000000
>> =C2=A0=C2=A0=C2=A0=C2=A0 ffffc90006fb7c80: 0000000000000000 0000000000=
000000
>> =C2=A0=C2=A0=C2=A0=C2=A0 ffffc90006fb7c90: 0000000000000000 0000000000=
000000
>> =C2=A0=C2=A0=C2=A0=C2=A0 ffffc90006fb7ca0: 0000000000000000 0000000003=
e3e937
>> =C2=A0=C2=A0=C2=A0=C2=A0 ffffc90006fb7cb0: 0000000000000000 0000000000=
000000
>> =C2=A0=C2=A0=C2=A0=C2=A0 ffffc90006fb7cc0: 8d7c0b56b7874b00 ffff88812c=
bd3000
>>
>> About the Fixes:
>> Why did it take eight years to be discovered?
>>
>> The problem requires the following conditions to occur:
>> 1. The device memory should be large enough.
>> 2. Pages in the LRU(active_anon) list are mostly from the ZONE_NORMAL =
area.
>> 3. The memory in ZONE_DMA32 needs to reach the watermark.
>>
>> If the memory is not large enough, or if the usage design of ZONE_DMA3=
2
>> area memory is reasonable, this problem is difficult to detect.
>>
>> notes:
>> The problem is most likely to occur in ZONE_DMA32 and ZONE_NORMAL,
>> but other suitable scenarios may also trigger the problem.
>=20
> This problem appears very similar to the one we reported sometime back =
at
>=20
> https://lore.kernel.org/linux-mm/d2841226-e27b-4d3d-a578-63587a3aa4f3@a=
md.com/
>=20
> where ~150 million folios were being skipped to isolate a few ZONE_DMA =
folios.
>=20

Yes, similar to this scenario.

>>
>> Fixes: b2e18757f2c9 ("mm, vmscan: begin reclaiming pages on a per-node=
 basis")
>> Signed-off-by: liuye <liuye@kylinos.cn>
>>
>> ---
>> V1->V2 : Adjust code format and add scenario description, reproduction=
 method.
>> ---
>> ---
>> =C2=A0 include/linux/swap.h | 1 +
>> =C2=A0 mm/vmscan.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 6 +++++-
>> =C2=A0 2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index ba7ea95d1c57..afb3274c90ef 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -223,6 +223,7 @@ enum {
>> =C2=A0 };
>> =C2=A0 =C2=A0 #define SWAP_CLUSTER_MAX 32UL
>> +#define SWAP_CLUSTER_MAX_SKIPPED (SWAP_CLUSTER_MAX << 10)
>> =C2=A0 #define COMPACT_CLUSTER_MAX SWAP_CLUSTER_MAX
>> =C2=A0 =C2=A0 /* Bit flag in swap_map */
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index bd489c1af228..d2e436a4f47d 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1636,6 +1636,7 @@ static unsigned long isolate_lru_folios(unsigned=
 long nr_to_scan,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long nr_skipped[MAX_NR_ZONES] =
=3D { 0, };
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long skipped =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long scan, total_scan, nr_page=
s;
>> +=C2=A0=C2=A0=C2=A0 unsigned long max_nr_skipped =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LIST_HEAD(folios_skipped);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total_scan =3D 0;
>> @@ -1650,9 +1651,12 @@ static unsigned long isolate_lru_folios(unsigne=
d long nr_to_scan,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_pages =3D fo=
lio_nr_pages(folio);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total_scan +=3D=
 nr_pages;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (folio_zonenum(f=
olio) > sc->reclaim_idx) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Using max_nr_skipped to=
 prevent hard LOCKUP*/
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (max_nr_skipped < SWAP_=
CLUSTER_MAX_SKIPPED &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (f=
olio_zonenum(folio) > sc->reclaim_idx)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 move_to =3D &folios_skipped;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
x_nr_skipped++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto move;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> I am not sure if the above would help in all scenarios as limiting the =
skipped folios list to 1 million entries couldn't fix the soft/hard locku=
p issue.
>=20

This value should not be too large, the earliest value is 32, before b2e1=
8757f2c9.

 #define SWAP_CLUSTER_MAX 32UL
+#define SWAP_CLUSTER_MAX_SKIPPED (SWAP_CLUSTER_MAX << 10)

To prevent lock contention and lockup, this value should be neither too s=
mall nor too large.=20
Depending on the CPU frequency, the time to trigger the lockup will vary.
Not sure if this value of SWAP_CLUSTER_MAX_SKIPPED is the most appropriat=
e, but it does work.
My patch works for all scenarios and does not change the earlier code log=
ic.

> In fact what helped was the fix by Yu Zhao which released the lruvec lo=
ck. This was posted for consideration at
>=20
> https://lore.kernel.org/lkml/ZsTOwBffg5xSCUbP@gmail.com/T/
>=20
> However this posting eventually resulted in the revert of
> 5da226dbfce3a2. Also some concerns about hoarding large number of folio=
s in skipped list and effect (on compaction) of releasing of lruvec spinl=
ock without clearing LRU flag were raised by Johannes.
>=20

Regarding Yu Zhao's patch, unlocking and releasing the scheduler may caus=
e changes in the lru list and more likely cause data corruption. And ther=
e are some other concerns you mentioned.
Of course, this method would be great if all the problems in all scenario=
s could be solved.

Please also let me know about other emails regarding this discussion. Cc =
me.

Thanks,
Liuye




