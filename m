Return-Path: <linux-kernel+bounces-440857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCF19EC582
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00405167F25
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835521C5F10;
	Wed, 11 Dec 2024 07:26:45 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B3179BD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902004; cv=none; b=ub9LlkFCwYJ209jXgh+JHmQmDRLxAdjpG4b/+/wpxXx+/m/eyvWRcOda+CnFoWo0Wm9KOawszzeB45rUSFhv8UBYTRmtpl+7oMqBULJ6nQLEm0xpuZvblTvnyn0kkrmE5FEodkEUUzLXZ/gSlnDnErqrGZ6LO1pU/DtYKPSiFZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902004; c=relaxed/simple;
	bh=Uwfth/kVsHh9uEBP1j2/QhPHZL/QqLz6IsJPvfYTDOs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ItZM3Ao0Quy373eCdubZZMWrK3/T78K4Jv9Qyt3oNdAb0dOztNqNn8pjJmILEuZjfT8Z5DfMG6uJBcntt2lHYJNl2D0vG825iwA/U9AvfHIKpc8YTgFopT6wl+OsED+5BAxbTxFh7GdbdM6Zgv1h6YnZZWbZRtJRSBjPrtsVkIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3f0db582b79111efa216b1d71e6e1362-20241211
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:2d4d3f3a-fe11-4c78-b5b5-147a63612342,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:188a94398502bcf48ee9c22bda035b93,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM:-3,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3f0db582b79111efa216b1d71e6e1362-20241211
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2046970107; Wed, 11 Dec 2024 15:26:32 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 87DDDB807587;
	Wed, 11 Dec 2024 15:26:32 +0800 (CST)
X-ns-mid: postfix-67593EA8-451944370
Received: from [172.30.70.73] (unknown [172.30.70.73])
	by node2.com.cn (NSMail) with ESMTPA id 4194AB807587;
	Wed, 11 Dec 2024 07:26:29 +0000 (UTC)
Subject: Re: [PATCH v2 RESEND] mm/vmscan: Fix hard LOCKUP in function
 isolate_lru_folios
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Mel Gorman <mgorman@techsingularity.net>,
 Yang Shi <yang@os.amperecomputing.com>, Minchan Kim <minchan@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Bharata B Rao <bharata@amd.com>, Yu Zhao <yuzhao@google.com>
References: <20240919021443.9170-1-liuye@kylinos.cn>
 <20241119060842.274072-1-liuye@kylinos.cn>
 <20241129192228.6f08e74a555bedcad71d32f4@linux-foundation.org>
 <1733382994392357.312.seg@mailgw.kylinos.cn>
From: liuye <liuye@kylinos.cn>
Message-ID: <1826c705-fc5b-ab58-9205-b5d35bac1cba@kylinos.cn>
Date: Wed, 11 Dec 2024 15:26:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1733382994392357.312.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2024/12/5 =E4=B8=8A=E5=8D=8811:55, Hugh Dickins wrote:
> On Fri, 29 Nov 2024, Andrew Morton wrote:
>> On Tue, 19 Nov 2024 14:08:42 +0800 liuye <liuye@kylinos.cn> wrote:
>>
>>> This fixes the following hard lockup in function isolate_lru_folios
>>> when memory reclaim.If the LRU mostly contains ineligible folios
>>> May trigger watchdog.
>>>
>>> watchdog: Watchdog detected hard LOCKUP on cpu 173
>>> RIP: 0010:native_queued_spin_lock_slowpath+0x255/0x2a0
>>> Call Trace:
>>> 	_raw_spin_lock_irqsave+0x31/0x40
>>> 	folio_lruvec_lock_irqsave+0x5f/0x90
>>> 	folio_batch_move_lru+0x91/0x150
>>> 	lru_add_drain_per_cpu+0x1c/0x40
>>> 	process_one_work+0x17d/0x350
>>> 	worker_thread+0x27b/0x3a0
>>> 	kthread+0xe8/0x120
>>> 	ret_from_fork+0x34/0x50
>>> 	ret_from_fork_asm+0x1b/0x30
>>>
>>> lruvec->lru_lock owner=EF=BC=9A
>>>
>>> PID: 2865     TASK: ffff888139214d40  CPU: 40   COMMAND: "kswapd0"
>>>  #0 [fffffe0000945e60] crash_nmi_callback at ffffffffa567a555
>>>  #1 [fffffe0000945e68] nmi_handle at ffffffffa563b171
>>>  #2 [fffffe0000945eb0] default_do_nmi at ffffffffa6575920
>>>  #3 [fffffe0000945ed0] exc_nmi at ffffffffa6575af4
>>>  #4 [fffffe0000945ef0] end_repeat_nmi at ffffffffa6601dde
>>>     [exception RIP: isolate_lru_folios+403]
>>>     RIP: ffffffffa597df53  RSP: ffffc90006fb7c28  RFLAGS: 00000002
>>>     RAX: 0000000000000001  RBX: ffffc90006fb7c60  RCX: ffffea04a2196f=
88
>>>     RDX: ffffc90006fb7c60  RSI: ffffc90006fb7c60  RDI: ffffea04a21970=
48
>>>     RBP: ffff88812cbd3010   R8: ffffea04a2197008   R9: 00000000000000=
01
>>>     R10: 0000000000000000  R11: 0000000000000001  R12: ffffea04a21970=
08
>>>     R13: ffffea04a2197048  R14: ffffc90006fb7de8  R15: 0000000003e3e9=
37
>>>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>>>     <NMI exception stack>
>>>  #5 [ffffc90006fb7c28] isolate_lru_folios at ffffffffa597df53
>>>  #6 [ffffc90006fb7cf8] shrink_active_list at ffffffffa597f788
>>>  #7 [ffffc90006fb7da8] balance_pgdat at ffffffffa5986db0
>>>  #8 [ffffc90006fb7ec0] kswapd at ffffffffa5987354
>>>  #9 [ffffc90006fb7ef8] kthread at ffffffffa5748238
>>> crash>
>>>
>>> Scenario:
>>> User processe are requesting a large amount of memory and keep page a=
ctive.
>>> Then a module continuously requests memory from ZONE_DMA32 area.
>>> Memory reclaim will be triggered due to ZONE_DMA32 watermark alarm re=
ached.
>>> However pages in the LRU(active_anon) list are mostly from
>>> the ZONE_NORMAL area.
>>>
>>> Reproduce:
>>> Terminal 1: Construct to continuously increase pages active(anon).
>>> mkdir /tmp/memory
>>> mount -t tmpfs -o size=3D1024000M tmpfs /tmp/memory
>>> dd if=3D/dev/zero of=3D/tmp/memory/block bs=3D4M
>>> tail /tmp/memory/block
>>>
>>> Terminal 2:
>>> vmstat -a 1
>>> active will increase.
>>> procs ---memory--- ---swap-- ---io---- -system-- ---cpu--- ...
>>>  r  b   swpd   free  inact active   si   so    bi    bo
>>>  1  0   0 1445623076 45898836 83646008    0    0     0
>>>  1  0   0 1445623076 43450228 86094616    0    0     0
>>>  1  0   0 1445623076 41003480 88541364    0    0     0
>>>  1  0   0 1445623076 38557088 90987756    0    0     0
>>>  1  0   0 1445623076 36109688 93435156    0    0     0
>>>  1  0   0 1445619552 33663256 95881632    0    0     0
>>>  1  0   0 1445619804 31217140 98327792    0    0     0
>>>  1  0   0 1445619804 28769988 100774944    0    0     0
>>>  1  0   0 1445619804 26322348 103222584    0    0     0
>>>  1  0   0 1445619804 23875592 105669340    0    0     0
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
>>> Active(anon):   115345744 kB
>>> Inactive(anon):   945292 kB
>>>
>>> When the Active(anon) is 115345744 kB, insmod module triggers
>>> the ZONE_DMA32 watermark.
>>>
>>> perf record -e vmscan:mm_vmscan_lru_isolate -aR
>>> perf script
>>> isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=
=3D2
>>> nr_skipped=3D2 nr_taken=3D0 lru=3Dactive_anon
>>> isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=
=3D0
>>> nr_skipped=3D0 nr_taken=3D0 lru=3Dactive_anon
>>> isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=
=3D28835844
>>> nr_skipped=3D28835844 nr_taken=3D0 lru=3Dactive_anon
>>> isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=
=3D28835844
>>> nr_skipped=3D28835844 nr_taken=3D0 lru=3Dactive_anon
>>> isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=
=3D29
>>> nr_skipped=3D29 nr_taken=3D0 lru=3Dactive_anon
>>> isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=
=3D0
>>> nr_skipped=3D0 nr_taken=3D0 lru=3Dactive_anon
>>>
>>> See nr_scanned=3D28835844.
>>> 28835844 * 4k =3D 115343376KB approximately equal to 115345744 kB.
>>>
>>> If increase Active(anon) to 1000G then insmod module triggers
>>> the ZONE_DMA32 watermark. hard lockup will occur.
>>>
>>> In my device nr_scanned =3D 0000000003e3e937 when hard lockup.
>>> Convert to memory size 0x0000000003e3e937 * 4KB =3D 261072092 KB.
>>>
>>>    [ffffc90006fb7c28] isolate_lru_folios at ffffffffa597df53
>>>     ffffc90006fb7c30: 0000000000000020 0000000000000000
>>>     ffffc90006fb7c40: ffffc90006fb7d40 ffff88812cbd3000
>>>     ffffc90006fb7c50: ffffc90006fb7d30 0000000106fb7de8
>>>     ffffc90006fb7c60: ffffea04a2197008 ffffea0006ed4a48
>>>     ffffc90006fb7c70: 0000000000000000 0000000000000000
>>>     ffffc90006fb7c80: 0000000000000000 0000000000000000
>>>     ffffc90006fb7c90: 0000000000000000 0000000000000000
>>>     ffffc90006fb7ca0: 0000000000000000 0000000003e3e937
>>>     ffffc90006fb7cb0: 0000000000000000 0000000000000000
>>>     ffffc90006fb7cc0: 8d7c0b56b7874b00 ffff88812cbd3000
>>>
>>> About the Fixes:
>>> Why did it take eight years to be discovered?
>=20
> I don't think it took eight years to be discovered: it was long known
> as a potential issue, but awkward to solve properly, and most of us hav=
e
> survived well enough in practice that we've never given the time to it.
>=20
Are there any discussions about this? URL?

>>>
>>> The problem requires the following conditions to occur:
>>> 1. The device memory should be large enough.
>>> 2. Pages in the LRU(active_anon) list are mostly from the ZONE_NORMAL=
 area.
>>> 3. The memory in ZONE_DMA32 needs to reach the watermark.
>>>
>>> If the memory is not large enough, or if the usage design of ZONE_DMA=
32
>>> area memory is reasonable, this problem is difficult to detect.
>>>
>>> notes:
>>> The problem is most likely to occur in ZONE_DMA32 and ZONE_NORMAL,
>>> but other suitable scenarios may also trigger the problem.
>>>
>>> Fixes: b2e18757f2c9 ("mm, vmscan: begin reclaiming pages on a per-nod=
e basis")
>>>
>>
>> Thanks.
>>
>> This is old code.  I agree on b2e18757f2c9 and thanks for digging that
>> out.
>=20
> I disagree.  Although that commit is the root cause of what led to this
> hard lockup problem, I believe there was no such hard lockup in it:
> if I thought that this patch were a good fix, I would say
>=20
> Fixes: 791b48b64232 ("mm: vmscan: scan until it finds eligible pages")
>=20
> which allowed the previously SWAP_CLUSTER_MAX-limited scan to go
> skipping indefinitely while holding spinlock with interrupts disabled;
> which this patch here now limits to 32k, but that still seems way too
> many to me.
>=20
> And then after its 32k skips, it gives up and reclaims a few unsuitable
> folios instead, just so that it can return a non-0 number to the caller=
.
> Unlikely to find and reclaim the suitable folios that it's looking for:
> which, despite its faults, the unpatched code does manage to do.
>=20

This value should not be too large, the earliest value is 32,=20
before b2e18757f2c9.

 #define SWAP_CLUSTER_MAX 32UL
+#define SWAP_CLUSTER_MAX_SKIPPED (SWAP_CLUSTER_MAX << 10)

To prevent lock contention and lockup, this value should be neither too
small nor too large. Depending on the CPU frequency, the time to trigger=20
the lockup will vary. Not sure if this value of SWAP_CLUSTER_MAX_SKIPPED=20
is the most appropriate, but it does work.

>>
>> I'll add a cc:stable and shall queue it for testing, pending review
>> from others (please).  It may be that the -stable tree maintainers ask
>> for a backport of this change into pre-folio-conversion kernels.  But
>> given the obscurity of the workload, I'm not sure this would be worth
>> doing.  Opinions are sought?
>=20
> I think I've been Cc'ed because git blame fingered some nearby isolatio=
n
> cleanups from me: I'm not the best person to comment, but I would give
> this patch a NAK.  If we are going to worry about this after seven year=
s
> (and with MGLRU approaching), I'd say the issue needs a better approach=
.
>=20
> Liuye, please start by reverting 791b48b64232 (which seems to have been
> implemented at the wrong level, inviting this hard lockup), and then
> studying its commit message and fixing the OOM kills which it was tryin=
g
> to fix - if they still exist after all the intervening years of tweaks.
>=20

Memory reclaim skips a large number of ineligible zones's pages, causing =
OOM.=20
The memory reclaim mechanism needs to be optimized. But I think this=20
optimization should not be triggered by "mm/vmscan: fix hard lock in=20
function isolate_lru_folios". I suggest fixing the current issue first.

Thanks,
Liuye

> Perhaps it's just a matter of adjusting get_scan_count() or shrink_lruv=
ec(),
> to be more persistent in the reclaim_idx high-skipping case.
>=20
> I'd have liked to suggest an actual patch, but that's beyond me.
>=20
> Thanks,
> Hugh
>=20
>>
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -223,6 +223,7 @@ enum {
>>>  };
>>> =20
>>>  #define SWAP_CLUSTER_MAX 32UL
>>> +#define SWAP_CLUSTER_MAX_SKIPPED (SWAP_CLUSTER_MAX << 10)
>>>  #define COMPACT_CLUSTER_MAX SWAP_CLUSTER_MAX
>>> =20
>>>  /* Bit flag in swap_map */
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 28ba2b06fc7d..0bdfae413b4c 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -1657,6 +1657,7 @@ static unsigned long isolate_lru_folios(unsigne=
d long nr_to_scan,
>>>  	unsigned long nr_skipped[MAX_NR_ZONES] =3D { 0, };
>>>  	unsigned long skipped =3D 0;
>>>  	unsigned long scan, total_scan, nr_pages;
>>> +	unsigned long max_nr_skipped =3D 0;
>>>  	LIST_HEAD(folios_skipped);
>>> =20
>>>  	total_scan =3D 0;
>>> @@ -1671,9 +1672,12 @@ static unsigned long isolate_lru_folios(unsign=
ed long nr_to_scan,
>>>  		nr_pages =3D folio_nr_pages(folio);
>>>  		total_scan +=3D nr_pages;
>>> =20
>>> -		if (folio_zonenum(folio) > sc->reclaim_idx) {
>>> +		/* Using max_nr_skipped to prevent hard LOCKUP*/
>>> +		if (max_nr_skipped < SWAP_CLUSTER_MAX_SKIPPED &&
>>> +		    (folio_zonenum(folio) > sc->reclaim_idx)) {
>>>  			nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
>>>  			move_to =3D &folios_skipped;
>>> +			max_nr_skipped++;
>>>  			goto move;
>>>  		}
>>> =20
>>> --=20
>>> 2.25.1

