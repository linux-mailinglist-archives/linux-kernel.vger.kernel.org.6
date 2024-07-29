Return-Path: <linux-kernel+bounces-265265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE693EEA3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F38C1F21F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B29C12BEBE;
	Mon, 29 Jul 2024 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qa3Yh7/k"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774A2F46
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238840; cv=none; b=Z2+/xxVQUapiRWHRv4lyQjN3V+2rtLGn2KcMV/HLOCK43AbQXhi4o1RkBKPTAsY3NnbBJpoFyBrgchqZgNfbAi/JV2NVwpBT8tp/klD9jd+sYTXv9lJBa88ponjeUckTkH4165fFMnxX21tqobzrIr5BujAaytozG9a0jm5XOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238840; c=relaxed/simple;
	bh=/0uL/c+pxQ4R8yPnHxFe+/Yd9xYsFXgm7LYuqeMXglQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubgGfW+AuLVaV0qhAsX5poBW4SMPzsZiau9GlwWROPlt1Mv+UDXDCgU9q22WyOsL7P22XMQXlDcs917pSNPSzKKQ+J6p4L+1TfMENN3HjknsBVSYs5gsP4kwgDbIpCa6ENRXNDXz+Ru+Cdg2urQDi14VVPCrnkSqRJkZvwyMQ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qa3Yh7/k; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so5484286a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722238836; x=1722843636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rANL9TJSB3Fpx7nAqfRHmEbXSkWemFpxQeAwLCHkla0=;
        b=Qa3Yh7/k4Q/BBL1xevZ1Fj6YK5oEBc+ntg9ymcLs8dRoexRuLlasR+uYkd5KXGbFNj
         Td0EyHJ54fWYaHAV77J90GCADDigp7t+NWnWOKwVcrv62o7GSDKOKkPQE1PiwYc63VJ4
         5FAmX76LzVhvIjJybbuGBO/xbrYgCqhswyJ1sqj1QHAkm7yOW2FCt2/Uou2OgrXIN3Jd
         ti8ZKDomkQ7PoZcslEPzmTRHYYW1csImgbZBOL0W9m3nZ6XYLRkebpgTUteN+OZ77rb4
         x45ujlJwjHkp3VnyWBdfu5q/VuUB9kGeKwVVkI36WKGmcbDXcuGSqtOJEAP9Tc0BFck4
         yhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722238836; x=1722843636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rANL9TJSB3Fpx7nAqfRHmEbXSkWemFpxQeAwLCHkla0=;
        b=qUqBy+JAXTaBxqS27dC4LwcKb+jAu7HzlJ904GXFibqqKsVtYGXkvVBfPpAgHEtvQo
         ZaN55JgstRGxxU9Wo27Iewl0JvKiFGEC1WvmBaCnuaUCdsBAeNMolTa8t3hJMhXHRA0S
         9EOd2Zr0/zYft/qEKjm4/DZNbMNJYxHvNCQFYZntjJJtXq5xP8lzr8v/1SOQtJxiRWfL
         24V4Ps/qHcU0r2HoV30Z21ZE2ZNaO85EPgRzW2AoqO10nyvYbL31bhGr+8hzEmvhg0+b
         U0/JiTviBs4QXYquIP2woMsCKXvtVotVSjg8jVmdz08GtVJgTPMCq4gTVw9114ZzLDEe
         hExQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5JgundzJclY0Y0FKhccGFB+eFPmvhONWTY+qO1M4Tk4ckSmS2iffT3+76cJ7EmiuCERP3AHjTTpXhkyDAtWOkldgwRcaLqKilKJ94
X-Gm-Message-State: AOJu0YxUsbpfW48hVFEAnZVL6ttzZTHYEKqNARA5Ec7kro7/iSJeFqUS
	nBZSJBsH2C5/0cPg7Mw6SKMsKCt6+WFEi/CwVwGWExxxs+tIQmPw55qiOGVXZGM=
X-Google-Smtp-Source: AGHT+IFEWFStZWo1Jwc99HeMBDE1DwCRCXVANwtrKUYTSP1waeWqQWjPODDSJhQrjApN8n9kSZgAUg==
X-Received: by 2002:a05:6402:1ece:b0:5a2:68a2:ae52 with SMTP id 4fb4d7f45d1cf-5b01d37c1fdmr4942090a12.0.1722238835828;
        Mon, 29 Jul 2024 00:40:35 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3aacsm5327830a12.64.2024.07.29.00.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 00:40:35 -0700 (PDT)
Date: Mon, 29 Jul 2024 09:40:34 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [PATCH RFC] mm: Avoid triggering oom-killer during memory
 hot-remove operations
Message-ID: <ZqdHch4VZG9UC2yM@tiehlicka>
References: <20240726084456.1309928-1-lizhijian@fujitsu.com>
 <ZqNpwz5UW44WOdHr@tiehlicka>
 <fd6e84d5-9dba-47fb-a39e-1f7f0995fdf5@fujitsu.com>
 <2ab277af-06ed-41a9-a2b4-91dd1ffce733@fujitsu.com>
 <ZqczDQ_qAjOGmBk0@tiehlicka>
 <264840d7-d770-29a0-7c36-6ede9063d06f@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <264840d7-d770-29a0-7c36-6ede9063d06f@fujitsu.com>

On Mon 29-07-24 06:34:21, Zhijian Li (Fujitsu) wrote:
> 
> 
> on 7/29/2024 2:13 PM, Michal Hocko wrote:
> > On Mon 29-07-24 02:14:13, Zhijian Li (Fujitsu) wrote:
> >>
> >> On 29/07/2024 08:37, Li Zhijian wrote:
> >>> Michal,
> >>>
> >>> Sorry to the late reply.
> >>>
> >>>
> >>> On 26/07/2024 17:17, Michal Hocko wrote:
> >>>> On Fri 26-07-24 16:44:56, Li Zhijian wrote:
> >>>>> When a process is bound to a node that is being hot-removed, any memory
> >>>>> allocation attempts from that node should fail gracefully without
> >>>>> triggering the OOM-killer. However, the current behavior can cause the
> >>>>> oom-killer to be invoked, leading to the termination of processes on other
> >>>>> nodes, even when there is sufficient memory available in the system.
> >>>> But you said they are bound to the node that is offlined.
> >>>>> Prevent the oom-killer from being triggered by processes bound to a
> >>>>> node undergoing hot-remove operations. Instead, the allocation attempts
> >>>>> from the offlining node will simply fail, allowing the process to handle
> >>>>> the failure appropriately without causing disruption to the system.
> >>>> NAK.
> >>>>
> >>>> Also it is not really clear why process of offlining should behave any
> >>>> different from after the node is offlined. Could you describe an actual
> >>>> problem you are facing with much more details please?
> >>> We encountered that some processes(including some system critical services, for example sshd, rsyslogd, login)
> >>> were killed during our memory hot-remove testing. Our test program are described previous mail[1]
> >>>
> >>> In short, we have 3 memory nodes, node0 and node1 are DRAM, while node2 is CXL volatile memory that is onlined
> >>> to ZONE_MOVABLE. When we attempted to remove the node2, oom-killed was invoked to kill other processes
> >>> (sshd, rsyslogd, login) even though there is enough memory on node0+node1.
> > What are sizes of those nodes, how much memory does the testing program
> > consumes and do you have oom report without the patch applied?
> >
> node0: 4G, node1: 4G, node2: 2G
> 
> my testing program will consume 64M memory. It's running on an *IDEL* 
> system.
> 
> [root@localhost guest]# numactl -H
> 
> available: 3 nodes (0-2)
> node 0 cpus: 0 1
> node 0 size: 3927 MB
> node 0 free: 3449 MB
> node 1 cpus: 2 3
> node 1 size: 4028 MB
> node 1 free: 3614 MB
> node 2 cpus:
> node 2 size: 2048 MB
> node 2 free: 2048 MB
> node distances:
> node   0   1   2
>     0:  10  20  20
>     1:  20  10  20
>     2:  20  20  10
> 
> 
> An oom report is as following:
> [13853.707626] consume_std_pag invoked oom-killer: 
> gfp_mask=0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), order=0, 
> oom_score_adj=0
> [13853.708400] CPU: 1 PID: 274746 Comm: consume_std_pag Not tainted 
> 6.10.0-rc2+ #160
> [13853.708745] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [13853.709161] Call Trace:
> [13853.709161] <TASK>
> [13853.709161] dump_stack_lvl+0x64/0x80
> [13853.709161] dump_header+0x44/0x1a0
> [13853.709161] oom_kill_process+0xf8/0x200
> [13853.709161] out_of_memory+0x110/0x590
> [13853.709161] __alloc_pages_slowpath.constprop.92+0xb5f/0xd80
> [13853.709161] __alloc_pages_noprof+0x354/0x380
> [13853.709161] alloc_pages_mpol_noprof+0xe3/0x1f0
> [13853.709161] vma_alloc_folio_noprof+0x5c/0xb0
> [13853.709161] folio_prealloc+0x21/0x80
> [13853.709161] do_pte_missing+0x695/0xa20
> [13853.709161] ? __pte_offset_map+0x1b/0x180
> [13853.709161] __handle_mm_fault+0x65f/0xc10
> [13853.709161] ? sched_tick+0xd7/0x2b0
> [13853.709161] handle_mm_fault+0x128/0x360
> [13853.709161] do_user_addr_fault+0x309/0x810
> [13853.709161] exc_page_fault+0x7e/0x180
> [13853.709161] asm_exc_page_fault+0x26/0x30
> [13853.709161] RIP: 0033:0x7f1d3ae2428a
> [13853.709161] Code: c5 fe 7f 07 c5 fe 7f 47 20 c5 fe 7f 47 40 c5 fe 7f 
> 47 60 c5 f8 77 c3 66 0f 1f 84 00 00 00 00 00 40 0f b6 c6 48 89 d1 48 89 
> fa <f3> aa 48 89 d0 c5 f8 77 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90
> [13853.712991] RSP: 002b:00007ffe083a2388 EFLAGS: 00000206
> [13853.712991] RAX: 0000000000000000 RBX: 00007ffe083a24d8 RCX: 
> 0000000007eb8010
> [13853.713915] Fallback order for Node 0: 0 1
> [13853.713987] Fallback order for Node 1: 1 0
> [13853.714006] Fallback order for Node 2: 0 1
> [13853.714175] Built 3 zonelists, mobility grouping on. Total pages: 2002419
> [13853.712991] RDX: 00007f1d32c00010 RSI: 0000000000000000 RDI: 
> 00007f1d32d48000
> [13853.712991] RBP: 00007ffe083a23b0 R08: 00000000ffffffff R09: 
> 0000000000000000
> [13853.714439] Policy zone: Normal
> [13853.712991] R10: 00007f1d3acd5200 R11: 00007f1d3ae241c0 R12: 
> 0000000000000002
> [13853.712991] R13: 0000000000000000 R14: 00007f1d3aeea000 R15: 
> 0000000000403e00
> [13853.712991] </TASK>
> [13853.716564] Mem-Info:
> [13853.716688] active_anon:17939 inactive_anon:0 isolated_anon:0
> [13853.716688] active_file:132347 inactive_file:109560 isolated_file:0
> [13853.716688] unevictable:0 dirty:2021 writeback:0
> [13853.716688] slab_reclaimable:5876 slab_unreclaimable:18566
> [13853.716688] mapped:35589 shmem:251 pagetables:1809
> [13853.716688] sec_pagetables:0 bounce:0
> [13853.716688] kernel_misc_reclaimable:0
> [13853.716688] free:1694176 free_pcp:0 free_cma:0
> [13853.718420] Node 2 hugepages_total=0 hugepages_free=0 
> hugepages_surp=0 hugepages_size=1048576kB
> [13853.718730] Node 2 hugepages_total=0 hugepages_free=0 
> hugepages_surp=0 hugepages_size=2048kB
> [13853.719127] 242158 total pagecache pages
> [13853.719310] 0 pages in swap cache
> [13853.719441] Free swap = 8142844kB
> [13853.719583] Total swap = 8143868kB
> [13853.719731] 2097019 pages RAM
> [13853.719890] 0 pages HighMem/MovableOnly
> [13853.720155] 60814 pages reserved
> [13853.720278] 0 pages cma reserved
> [13853.720393] 0 pages hwpoisoned
> [13853.720494] Tasks state (memory values in pages):
> [13853.720686] [ pid ] uid tgid total_vm rss rss_anon rss_file rss_shmem 
> pgtables_bytes swapents oom_score_adj name
> [13853.721214] [ 718] 0 718 40965 29598 256 29342 0 368640 0 -250 
> systemd-journal
> <...snip...>
> [13853.747190] [ 274715] 0 274715 8520 1731 879 852 0 73728 0 0 
> (udev-worker)
> [13853.747561] [ 274743] 0 274743 617 384 0 384 0 45056 0 0 consume_activit
> [13853.748099] [ 274744] 0 274744 617 281 0 281 0 45056 0 0 consume_activit
> [13853.748479] [ 274745] 0 274745 2369 954 128 826 0 61440 0 0 daxctl
> [13853.748885] [ 274746] 0 274746 33386 667 320 347 0 49152 0 0 
> consume_std_pag
> <...snip...>
> [13853.755653] [ 274808] 0 274808 3534 251 32 219 0 61440 0 0 systemctl
> [13853.756151] 
> oom-kill:constraint=CONSTRAINT_MEMORY_POLICY,nodemask=2,cpuset=/,mems_allowed=0-2,global_oom,task_memcg=/system.slice/rsyslog.service,task=rsyslogd,pid=274557,uid=0
> [13853.756791] Out of memory: Killed process 274557 (rsyslogd) 
> total-vm:957964kB, anon-rss:640kB, file-rss:46496kB, shmem-rss:0kB, 
> UID:0 pgtables:1512kB oom_score_adj:0

OK, I guess I can see what is going on now. You are binding your memory
allocating task to the node you are offlining completely. This obviously
triggers OOM on that node. The oom killer is not really great at
handling memory policy OOMs because it is lacking per-node memory
consumption data for processes. That means that rather than killing the
test program which continues consuming memory - and not much of it - it
keeps killing other tasks with a higher memory consumption.

This is really unfortunate but not something that should be handled by
special casing memory offlining but rather handling the mempolicy OOMs
better. There were some attempts in the past but never made it to a
mergable state. Maybe you want to pick up on that.

> [13853.758192] pagefault_out_of_memory: 4055 callbacks suppressed
> [13853.758243] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF

This shouldn't really happen and it indicates that some memory
allocation in the pagefault path has failed.

> [13853.758865] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [13853.759319] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [13853.759564] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [13853.759779] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [13853.760128] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [13853.760361] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [13853.760588] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [13853.760794] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [13853.761187] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [13853.774166] Demotion targets for Node 0: null
> [13853.774478] Demotion targets for Node 1: null
> 

-- 
Michal Hocko
SUSE Labs

