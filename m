Return-Path: <linux-kernel+bounces-297819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3A295BE17
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACF61F25A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA961CFEA5;
	Thu, 22 Aug 2024 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLkRc2nM"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E56D38F9A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350782; cv=none; b=JYhl5ndn/rBxC/h7Q7XO2+kJabxYJS/3D5zLObwtP+xsFA1fSKy/rI2/C+A/ZyOM5jUqOnLBCOlno4ywLrssMDR6MUnmXrwJGixWCCN7timywHT9Ymhd7PHKc788K/8iTE74oAq8u25wZ02p/bBSNcL7IKYdzbIr7d8WJHtn94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350782; c=relaxed/simple;
	bh=utMDmTbX1/LidnSzDyHrA8dZFqyO95ZnxKXD+vRAYH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXP/OauecuYvdicE3p/NWPn6KJwD14FMMYaVcKH7PInPKCwiivHE+lBI0u4X+SOooaCePu4Ea3p+c+L5mjaJyLAv432b0s+/1JK7gbGKsFr/dEcQye0if/Enjlh7CwNrp7NFtuY8i3Uga/Sb0iK//+6CawDxoAI4XpgjvhzjCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLkRc2nM; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso1900860a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724350778; x=1724955578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNLLVZZpLxZWh2dHAkGEpD5DarfqjR8a+UwpDgaaask=;
        b=RLkRc2nMpb3LBpUDC25kgJhffA8VrIQ4ry2DxfG55DmH61p1iYVbykZjj7/oEi+fGE
         OyEtqmRQyhbgCpL0ErwmL8v6x2BxFWrCe0kkM9SvFmjzjF3wtYorOy4DYAMyOBvUiifi
         LNYT/372TvohayooBHhfmMMicnmTNWIHYEbOh5RtWXdiM11XQIap8UKfeUGpg1eCaB/M
         dVxAHXDSLBPkQHC1Nj5109KFmIdpkPv2U1EINmG84DYOYFb0ZxqJ6VFk3att0iXBNuAs
         PvFueHZaXeuixhIRpd2pRVPHKOo0SpVAb/wwZdVPDv13EQGT8zpDIj+3zrGnxx8f8DF7
         NVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724350778; x=1724955578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNLLVZZpLxZWh2dHAkGEpD5DarfqjR8a+UwpDgaaask=;
        b=OzNitZNnaCNiZ0elPJUMOi/XOEpX8Mrwq288QcbBFVkXaTl2bLGk06uN2dizv9cD30
         b/RSAuIwsVpfRkNGxtOXtQkSwmHGHaEPXpUOYr9pZUxjsxgsQWUKEz+XPKlK1VjBuVq7
         rtCTvP1DuAcUY3UZ//r1TsTxbtSTVduruEjweCkqIjO88oQ93OhD3b3vzvGuTQC00y60
         VwNfzTc8N5fFRY1k7jWmEgtZiNFx41IMMo0H5q7d8pVc+sWsmw7Jbz80OfqImKf4tBzw
         raY0rGm+3Rvk703Ih4NRaWbG0CaO3imQuWwdiCftzHpqUgToSgA15FL8aDHF2j6S/MYV
         wv1A==
X-Forwarded-Encrypted: i=1; AJvYcCWYT/mEPgl5NaJPHtX6yOOzGGw+XmE9cocY1rcV3BQ9qHVhbH2gxgFxo/ER0lB0RKBr65iI+V6ImFRnIYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+shi2axSn/pW6lpjfrdVTIdN2JeFtm/lY8e3RB49r6BakCr5
	Fr26xFaWMlyBeXa3NxZ31RSo1UMRxdNRKASuwGwi7CGLafVYq3GM
X-Google-Smtp-Source: AGHT+IFcRHsyiimrgW0dgblDDhP/odLIbjcyN7K2AHf50Myrbes0N15kXf6XZtLz/oDERNeyKA45Ig==
X-Received: by 2002:a05:6402:278e:b0:5bf:9c3:8dd4 with SMTP id 4fb4d7f45d1cf-5bf1f289a5amr4963198a12.34.1724350778006;
        Thu, 22 Aug 2024 11:19:38 -0700 (PDT)
Received: from shift.daheim (p200300d5ff191e0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff19:1e00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddbb8fsm1180914a12.1.2024.08.22.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:19:37 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.98)
	(envelope-from <chunkeey@gmail.com>)
	id 1shCPE-00000001DyZ-0UfP;
	Thu, 22 Aug 2024 20:19:36 +0200
Message-ID: <b039012c-1b04-40cb-a760-b1ef942fe23c@gmail.com>
Date: Thu, 22 Aug 2024 20:19:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc: warn on emulation of dcbz instruction in
 kernel mode
To: Christoph Hellwig <hch@lst.de>,
 LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Stan Johnson <userm57@yahoo.com>, Finn Thain <fthain@linux-m68k.org>
References: <2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu>
 <17fa6450-6613-4c34-804b-e47246e7b39c@isd.uni-stuttgart.de>
 <9dbf73fe-a459-4956-8dbc-e919d9728f5e@cs-soprasteria.com>
 <20240822053238.GA2028@lst.de>
 <e6acf664-5ebd-4273-9330-cbec283ede23@cs-soprasteria.com>
 <20240822071443.GA6395@lst.de>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20240822071443.GA6395@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!

Thank you all for your insightful insights :-) .
... and derp, used the wrong mail.

On 8/22/24 9:14 AM, Christoph Hellwig wrote:
> On Thu, Aug 22, 2024 at 06:39:33AM +0000, LEROY Christophe wrote:
>> powerpc has a magic instruction 'dcbz' which clears a full cacheline in
>> one go. It is far more efficient than a loop to store zeros, and since
>> 2015 memset(0) has been implemented with that instruction (commit
>> 5b2a32e80634 ("powerpc/32: memset(0): use cacheable_memzero"))
>>
>> But that instruction generates an alignment exception when used on
>> non-cached memory (whether it is RAM or not doesn't matter). It is then
>> emulated by the kernel but it of course leads to a serious performance
>> degradation, hence the warning added by commit cbe654c77961 ("powerpc:
>> warn on emulation of dcbz instruction in kernel mode"). Until now it
>> helped identify and fix use of memset() on IO memory.
>>
>> But if memset() is expected to be used with non-cached RAM, then I don't
>> know what to do. Any suggestion ?
> 
> I'd suggest two things:
> 
>   1) remove the warning.  The use case is perfectly valid and everything
>      using uncached memory is already slow, so people will just have to
>      deal with it.  Maybe offer a trace point instead if people care about
>      it.
>   2) figure out a way to avoid this case in the dma-coherent allocator,
>      which is probably the only case where it happens frequently
>      (a few drivers also zero or re-zero coherent memory, but most of the
>       time that is cargo cult programming and not actually needed)

I tested your patch below and got the next warning. This time from
dma_alloc_from_pool about a similar memset in:
https://elixir.bootlin.com/linux/v6.6.47/source/kernel/dma/pool.c#L261

it triggers for the sata_dwc_ex460 driver when it access the harddrive.
For anyone interested, please look below for the full warning splat.

(I switched to the MyBook Live, it's easier to disassemble+reassemble
than the MX60... but with similar results).

> For 2 I can think of two options:
> 
>   a) provide a arch hook for zeroing the dma memory that defaults to
>      memset, but which powerpc can override
>   a) figure out a way to clear the memory before marking it uncached
>      if we can
> 
> a) it obviously easier to verify, but b) is probably going to give
>     way better performance.
> 
> Below is an untested implementation of b) for dma-direct, I just need to
> find out if there is any architecture that requires the memory to be
> zeroed after it іt has been remapped.  The iommu drivers might also
> need similar treatment.
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4480a3cd92e087..66e94b32ab0081 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -275,6 +275,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   		if (force_dma_unencrypted(dev))
>   			prot = pgprot_decrypted(prot);
>   
> +		if (!PageHighMem(page))
> +			memset(page_address(page), 0, size);
> +
>   		/* remove any dirty cache lines on the kernel alias */
>   		arch_dma_prep_coherent(page, size);
>   
> @@ -283,14 +286,15 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   				__builtin_return_address(0));
>   		if (!ret)
>   			goto out_free_pages;
> +		if (PageHighMem(page))
> +			memset(ret, 0, size);
>   	} else {
>   		ret = page_address(page);
>   		if (dma_set_decrypted(dev, ret, size))
>   			goto out_leak_pages;
> +		memset(ret, 0, size);
>   	}
>   
> -	memset(ret, 0, size);
> -
>   	if (set_uncached) {
>   		arch_dma_prep_coherent(page, size);
>   		ret = arch_dma_set_uncached(ret, size);

I added a counter in fix_alignment to count the number of traps
issued by the kernel code. From what I measured in a quick test,
With this patch, the count during boot went down from ~21000
(unmodified) to 1200 (patched)... but from what I can tell, it
still triggers for the dma_direct_alloc in emac.

if there are more patches, please. I can test them during the next
few days while I'm on holiday.

Cheers,
Christian

---

[    2.596136] ------------[ cut here ]------------
[    2.600759] WARNING: CPU: 0 PID: 24 at fix_alignment+0x17c/0x1b4
[    2.606760] Modules linked in:
[    2.609813] CPU: 0 PID: 24 Comm: kworker/u2:2 Not tainted 6.6.47 #0
[    2.616057] Hardware name: MyBook Live APM821XX 0x12c41c83 PowerPC 44x Platform
[    2.623337] Workqueue: events_unbound async_run_entry_fn
[    2.628646] NIP:  c0003190 LR: c0003070 CTR: c0014744
[    2.633674] REGS: c11a94b0 TRAP: 0700   Not tainted  (6.6.47)
[    2.639402] MSR:  00021000 <CE,ME>  CR: 22008808  XER: 20000000
[    2.645312]
[    2.645312] GPR00: c0008640 c11a95a0 c10de300 00000000 00000001 00000018 01f01cdf 00000004
[    2.645312] GPR08: c0f30000 00000000 0147ae14 c11a9610 c0013abc 00000000 c004c1e4 00000002
[    2.645312] GPR16: 00000000 00000001 00000000 00000000 d1000000 c0910000 c1182010 c0f50000
[    2.645312] GPR24: c11a9774 c00804a8 c0f30000 c0910000 c0910000 00001000 c108e3a0 c11a9620
[    2.680114] NIP [c0003190] fix_alignment+0x17c/0x1b4
[    2.685065] LR [c0003070] fix_alignment+0x5c/0x1b4
[    2.689844] Call Trace:
[    2.692279] [c11a95a0] [c11a9734] 0xc11a9734 (unreliable)
[    2.697670] [c11a95f0] [c0008640] alignment_exception+0xf0/0x164
[    2.703666] [c11a9610] [c0000a30] Alignment+0x130/0x180
[    2.708877] --- interrupt: 600 at memset+0x60/0xc0
[    2.713672] NIP:  c0013abc LR: c0081df8 CTR: 0000007f
[    2.718700] REGS: c11a9620 TRAP: 0600   Not tainted  (6.6.47)
[    2.724420] MSR:  00021000 <CE,ME>  CR: 42008808  XER: 20000000
[    2.730330] DEAR: d1000020 ESR: 00000000
[    2.730330] GPR00: 00000007 c11a9710 c10de300 d1000000 00000000 00001000 d100001c 00000004
[    2.730330] GPR08: 00001000 0000007f 00000001 53c20800 28008808 00000000 c004c1e4 00000002
[    2.730330] GPR16: 00000000 00000001 00000000 00000000 d1000000 c0910000 c1182010 c0f50000
[    2.730330] GPR24: c11a9774 c00804a8 c0f30000 c0910000 c0910000 00001000 c108e3a0 000010a0
[    2.767645] NIP [c0013abc] memset+0x60/0xc0
[    2.771819] LR [c0081df8] dma_alloc_from_pool+0x118/0x204
[    2.777201] --- interrupt: 600
[    2.780242] [c11a9710] [c0081eb0] dma_alloc_from_pool+0x1d0/0x204 (unreliable)
[    2.787449] [c11a9760] [c00807e0] dma_direct_alloc+0x90/0x2a4
[    2.793178] [c11a97a0] [c007f850] dma_alloc_attrs+0xa8/0xf8
[    2.798758] [c11a97e0] [c019d180] dma_pool_alloc+0x11c/0x2ac
[    2.804409] [c11a9810] [c0434cec] dwc_desc_get+0x2c/0x98
[    2.809722] [c11a9840] [c04355cc] dwc_prep_slave_sg+0x180/0x524
[    2.815633] [c11a98b0] [c04d7938] sata_dwc_qc_issue+0x1d8/0x268
[    2.821559] [c11a9920] [c04bbfb0] ata_qc_issue+0x174/0x2b0
[    2.827046] [c11a9940] [c04c674c] __ata_scsi_queuecmd+0x200/0x4fc
[    2.833129] [c11a9960] [c04c6a84] ata_scsi_queuecmd+0x3c/0x88
[    2.838865] [c11a9980] [c04a7bb0] scsi_queue_rq+0x6fc/0xb40
[    2.844429] [c11a99c0] [c03801e8] __blk_mq_issue_directly+0x40/0xe0
[    2.850694] [c11a99f0] [c038462c] blk_mq_try_issue_directly+0xa8/0x10c
[    2.857208] [c11a9a10] [c03854e4] blk_mq_submit_bio+0x5f4/0x67c
[    2.863118] [c11a9a70] [c0374ef4] submit_bio_noacct_nocheck+0x210/0x2d0
[    2.869728] [c11a9aa0] [c0206850] block_read_full_folio+0x1f4/0x3a4
[    2.875983] [c11a9b10] [c01353d8] filemap_read_folio+0x40/0x240
[    2.881910] [c11a9b60] [c01382d0] do_read_cache_folio+0xb4/0x228
[    2.887906] [c11a9b90] [c039144c] read_part_sector+0x50/0x10c
[    2.893643] [c11a9bb0] [c0392358] read_lba+0xb8/0x198
[    2.898680] [c11a9bf0] [c0392854] efi_partition+0xd8/0xc30
[    2.904150] [c11a9cc0] [c0390be4] bdev_disk_changed+0x2ac/0x710
[    2.910051] [c11a9d30] [c036be5c] blkdev_get_whole+0xc4/0xd8
[    2.915693] [c11a9d50] [c036cb7c] blkdev_get_by_dev.part.0+0x288/0x380
[    2.922199] [c11a9d90] [c038d49c] disk_scan_partitions+0x90/0x150
[    2.928272] [c11a9dc0] [c038d9ac] device_add_disk+0x450/0x484
[    2.934001] [c11a9df0] [c04b7718] sd_probe+0x360/0x4fc
[    2.939132] [c11a9e20] [c0479db0] really_probe+0x2a0/0x370
[    2.944628] [c11a9e50] [c0479f10] __driver_probe_device+0x90/0x200
[    2.950796] [c11a9e70] [c047a0c8] driver_probe_device+0x48/0x104
[    2.956793] [c11a9ea0] [c047a268] __device_attach_driver+0xe4/0x130
[    2.963048] [c11a9ec0] [c04772e0] bus_for_each_drv+0x88/0xe4
[    2.968699] [c11a9ef0] [c047939c] __device_attach_async_helper+0xa0/0xe8
[    2.975386] [c11a9f20] [c005096c] async_run_entry_fn+0x40/0x11c
[    2.981296] [c11a9f40] [c0044b70] process_one_work+0x1bc/0x35c
[    2.987111] [c11a9f70] [c0045088] worker_thread+0x378/0x4e8
[    2.992667] [c11a9fc0] [c004c2c8] kthread+0xe4/0xe8
[    2.997548] [c11a9ff0] [c000d210] start_kernel_thread+0x10/0x14
[    3.003449] Code: 39400000 7d500ba6 4c00012c 2c090000 41a2fec4 83e1004c 3860fff2 38210050 4e800020 38a00000 3920fff2 4bffffd4 <0fe00000> 4bffff8c 80010054 7c0803a6
[    3.018138] ---[ end trace 0000000000000000 ]---



