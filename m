Return-Path: <linux-kernel+bounces-173659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4218C0387
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7037B24FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D006612BF04;
	Wed,  8 May 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0oQPbzK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4212AAE7
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190333; cv=none; b=CDMccCnZp0DKoUl9VkPyGyXBLrT7lRhyH9jF8TXG/0NhLYGgvP6oGWbuWcMIok+Sk7Bgsz4W5uAmu1GF2ZKgYLsi574sVKJH02saTqfFmU84TqcAN637YYxZ6CXGQDGXIo6TO2rz3Mx+8XO1rT4W9BfwJ/s2cgLDk/wMaTHRY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190333; c=relaxed/simple;
	bh=yJb0UW/Z5D1Dq1zjfpto41R95bckfqZzj09m1NBsDRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DUH1EepocntsyGhLIlbEx0i3KPCaveY6pJeAbGNwc32JNnoad0LMgJLrPFoBcRvwy60erwPNDgADNx8bkRGXW5py1jTv3RkuCRf17QeDU3sB7Ji0umyDOGcI/piOs74vut4sg7dDkXMM5/AYhxls8eIVTgt1iYI5DdAQK3PBV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0oQPbzK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715190329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=did4odF7PzePKvaNPVc0FG4jbg1sFJ+AYdVtGsnfGCI=;
	b=F0oQPbzKIYvDdfkzriEIXi0X5Q2Nbk9QL7ajsEpz8o2dOrlsAD9WcSngyB4JrgrXf9LhmD
	QXfQ1yhMxJWlAcoWpA/eNX487KTNzkEoERPszzSiYt3Prs9UIcqaIZmRftTB7RLqIXsMDR
	fVSCDKvgkqwvprQLwwj4tlkjy3xCpYk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-isK2K-l3M7KKyIkTB8Z9pg-1; Wed, 08 May 2024 13:45:27 -0400
X-MC-Unique: isK2K-l3M7KKyIkTB8Z9pg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41ec8ef128fso17948635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715190326; x=1715795126;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=did4odF7PzePKvaNPVc0FG4jbg1sFJ+AYdVtGsnfGCI=;
        b=eOy72CY8Y0gs1VXs4bYT+oXn3BVv4fzLyecvKP6re1UvSh/hnGOiOTLbQItUgnqzHl
         Uy6NeI6r7DO98PvQG4Vzf9X3ygXTooskgbAZM6nCQv2E1jXQRsNdsI+aYj3NX52gc/DC
         m48MiDAPNsmKjin+GWaD1j2naepO3ikuqrz54qkRNJQYZpm85yFdqcdcMURKCVVJQ4i0
         q2E/lizAcR4cpbo++vs4x5uPQsVtI1PpBcI53s5iP2jA/4OUbdH3WStn+FHnKaTmJiOT
         nYsEgPx15/DIZbOe+30eGJ30Qkt/m5ATOoooDEbm3zb4l+3yTgzAo5ZSvFXaVuS5MI+h
         ttPA==
X-Forwarded-Encrypted: i=1; AJvYcCV7sfUwpU1ARUMt4/IT5K+wHPDswSPFJ1u8+6D85IeKrqFeKB9p6v7KWUmV1bA0Ym3K5t7L42RlHalcUD9ZPm41qc9g8URVrhXnCY4m
X-Gm-Message-State: AOJu0Yx+7pow9i4rfHjlSw2Oak2oM7y1Cd7l0NDET2UjuRt7J+g/hbsA
	CL/1EroM6GSIuHPG3JterOPKEOaSbnzE5X3bmO9dTttSPgXzZqs+sAkGUQgqElkSietRNuyGrPk
	3y9iCZMfb5iVDPTAfmogcYJFGFo44jMa4el+o+crQo3gO13iv0DJedw+wMiW9FOnHXUhK3A==
X-Received: by 2002:a05:600c:3b0d:b0:41b:6dbb:52f9 with SMTP id 5b1f17b1804b1-41f723a2445mr23695995e9.39.1715190325818;
        Wed, 08 May 2024 10:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTJae2XYiJOdx4Mg4RYSDcMirgChDKQAnD9kxaHSKU7esylJDSMWH636BM+WucHGf1AmA1mQ==
X-Received: by 2002:a05:600c:3b0d:b0:41b:6dbb:52f9 with SMTP id 5b1f17b1804b1-41f723a2445mr23695825e9.39.1715190325296;
        Wed, 08 May 2024 10:45:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3100:35c3:fc4b:669f:9ff9? (p200300cbc707310035c3fc4b669f9ff9.dip0.t-ipconnect.de. [2003:cb:c707:3100:35c3:fc4b:669f:9ff9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f882087eesm30362785e9.44.2024.05.08.10.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 10:45:24 -0700 (PDT)
Message-ID: <0672f0b7-36f5-4322-80e6-2da0f24c101b@redhat.com>
Date: Wed, 8 May 2024 19:45:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.9/BUG: Bad page state in process kswapd0 pfn:d6e840
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>
References: <CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com>
 <CABXGCsOC2Ji7y5Qfsa33QXQ37T3vzdNPsivGoMHcVnCGFi5vKg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CABXGCsOC2Ji7y5Qfsa33QXQ37T3vzdNPsivGoMHcVnCGFi5vKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.05.24 12:16, Mikhail Gavrilov wrote:
> On Mon, Mar 18, 2024 at 2:55 PM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
>>
>> Hi,
>> Today I  saw for the first time "BUG: Bad page state in process
>> kswapd0  pfn:d6e840"
>>
>> Trace:
>> BUG: Bad page state in process kswapd0  pfn:d6e840
>> page: refcount:0 mapcount:0 mapping:000000007512f4f2 index:0x2796c2c7c
>> pfn:0xd6e840
>> aops:btree_aops ino:1
>> flags: 0x17ffffe0000008(uptodate|node=0|zone=2|lastcpupid=0x3fffff)
>> page_type: 0xffffffff()
>> raw: 0017ffffe0000008 dead000000000100 dead000000000122 ffff88826d0be4c0
>> raw: 00000002796c2c7c 0000000000000000 00000000ffffffff 0000000000000000
>> page dumped because: non-NULL mapping
>> Modules linked in: uvcvideo uvc videobuf2_vmalloc videobuf2_memops
>> videobuf2_v4l2 videobuf2_common videodev rndis_host uas cdc_ether
>> usbnet usb_storage mii overlay tun uinput snd_seq_dummy snd_hrtimer
>> rfcomm nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
>> nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
>> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
>> nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr bnep sunrpc
>> binfmt_misc snd_usb_audio snd_usbmidi_lib snd_ump snd_rawmidi mc
>> amd_atl intel_rapl_msr intel_rapl_common snd_hda_codec_hdmi mt76x2u
>> mt7921e edac_mce_amd snd_hda_intel mt76x2_common mt7921_common
>> snd_intel_dspcfg mt76x02_usb snd_intel_sdw_acpi mt76_usb mt792x_lib
>> snd_hda_codec mt76x02_lib mt76_connac_lib btusb btrtl mt76
>> snd_hda_core btintel kvm_amd btbcm btmtk snd_hwdep mac80211 snd_seq
>> kvm vfat snd_seq_device bluetooth libarc4 fat irqbypass snd_pcm rapl
>> cfg80211 snd_timer wmi_bmof pcspkr snd i2c_piix4 k10temp rfkill
>> soundcore joydev
>>   apple_mfi_fastcharge gpio_amdpt gpio_generic loop nfnetlink zram
>> amdgpu hid_apple crct10dif_pclmul crc32_pclmul crc32c_intel
>> polyval_clmulni polyval_generic amdxcp i2c_algo_bit drm_ttm_helper ttm
>> ghash_clmulni_intel drm_exec gpu_sched drm_suballoc_helper
>> sha512_ssse3 nvme drm_buddy sha256_ssse3 sha1_ssse3 drm_display_helper
>> nvme_core sp5100_tco r8169 ccp cec realtek nvme_auth video wmi
>> ip6_tables ip_tables fuse
>> CPU: 17 PID: 268 Comm: kswapd0 Tainted: G        W    L    -------
>> ---  6.9.0-0.rc0.20240315gite5eb28f6d1af.8.fc41.x86_64+debug #1
>> Hardware name: Micro-Star International Co., Ltd. MS-7D73/MPG B650I
>> EDGE WIFI (MS-7D73), BIOS 1.82 01/24/2024
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0xce/0xf0
>>   bad_page+0xd4/0x230
>>   ? __pfx_bad_page+0x10/0x10
>>   ? page_bad_reason+0x9d/0x1f0
>>   free_unref_page_prepare+0x80e/0xe00
>>   ? __pfx___mem_cgroup_uncharge_folios+0x10/0x10
>>   ? __pfx_lock_release+0x10/0x10
>>   free_unref_folios+0x26e/0x9c0
>>   ? _raw_spin_unlock_irq+0x28/0x60
>>   move_folios_to_lru+0xc0e/0xe80
>>   ? __pfx_move_folios_to_lru+0x10/0x10
>>   evict_folios+0xe5c/0x1610
>>   ? evict_folios+0x5f3/0x1610
>>   ? __pfx_lock_acquire+0x10/0x10
>>   ? __pfx_evict_folios+0x10/0x10
>>   ? rcu_is_watching+0x15/0xb0
>>   ? rcu_is_watching+0x15/0xb0
>>   ? __pfx_lock_acquire+0x10/0x10
>>   ? __pfx___might_resched+0x10/0x10
>>   ? mem_cgroup_get_nr_swap_pages+0x25/0x120
>>   try_to_shrink_lruvec+0x4d8/0x800
>>   ? rcu_is_watching+0x15/0xb0
>>   ? __pfx_try_to_shrink_lruvec+0x10/0x10
>>   ? lock_release+0x581/0xc60
>>   ? __pfx_lock_release+0x10/0x10
>>   shrink_one+0x37c/0x6f0
>>   shrink_node+0x1d60/0x3080
>>   ? shrink_node+0x1d47/0x3080
>>   ? shrink_node+0x1afa/0x3080
>>   ? __pfx_shrink_node+0x10/0x10
>>   ? pgdat_balanced+0x7b/0x1a0
>>   balance_pgdat+0x88b/0x1480
>>   ? rcu_is_watching+0x15/0xb0
>>   ? __pfx_balance_pgdat+0x10/0x10
>>   ? __switch_to+0x409/0xdd0
>>   ? __switch_to_asm+0x37/0x70
>>   ? __schedule+0x10cd/0x61d0
>>   ? __pfx_debug_object_free+0x10/0x10
>>   ? __try_to_del_timer_sync+0xe5/0x140
>>   ? __pfx_lock_release+0x10/0x10
>>   ? __pfx___might_resched+0x10/0x10
>>   ? set_pgdat_percpu_threshold+0x1c4/0x2f0
>>   ? __pfx_calculate_pressure_threshold+0x10/0x10
>>   kswapd+0x51d/0x910
>>   ? __pfx_kswapd+0x10/0x10
>>   ? __pfx_autoremove_wake_function+0x10/0x10
>>   ? lockdep_hardirqs_on+0x80/0x110
>>   ? __kthread_parkme+0xba/0x1f0
>>   ? __pfx_kswapd+0x10/0x10
>>   kthread+0x2ed/0x3c0
>>   ? _raw_spin_unlock_irq+0x28/0x60
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork+0x31/0x70
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork_asm+0x1a/0x30
>>   </TASK>
>>
>> Quick googling doesn't give a reassuring answer.
>> If it is really a hardware problem then it is unclear what is the culprit here.
>> The memory was checked a year ago by testmem86 and no errors were found.
>> Considering the absolute randomness of the appearance of this bug
>> message, it may be worth ignoring it, but an unpleasant aftertaste
>> remains.
>>
>> Machine spec: https://linux-hardware.org/?probe=24b7696f8a
>> I attached below full kernel log and build config.
>>
>> --
>> Best Regards,
>> Mike Gavrilov.
> 
> Sorry for writing again, but no one answered me.
> Of course, I checked my memory again and ensured that it was fine.
> I even changed three motherboards, but this error appears once a week.
> Every time the common phrase is "BUG: Bad page state in process" but
> the process can be different.
> kcompactd, kswapd, kworker, btrfs-transacti
> I don’t know if this will help, but usually this happens when I run
> the “docker pull” command and a huge container is being updated.

"page dumped because: non-NULL mapping"

Is the relevant bit. We are freeing a page, but page->mapping is not 
NULL. IIUC, it might happen under memory pressure when reclaiming memory.

It's weird that only you are seeing that, if it would be something 
"obvious" I would expect multiple reports :/

-- 
Cheers,

David / dhildenb


