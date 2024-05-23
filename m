Return-Path: <linux-kernel+bounces-187562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE98CD3DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB751F25F84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E5D14AD0E;
	Thu, 23 May 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLkxJtvo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD414A4FF
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470358; cv=none; b=AVHF3ydM/NEMbCx9ZrA+7ieYvW5DGmqhOgi4ICdry8+RuKzy0UpqZrCNY1bGWX6+sRPb/dq8Ip9G9ASri1oP3WPI+u72yhcQ3qVnEqeNr4AquXD0gfGeJgmnTwJ4zBAu/RbrailUDo5uWgr86JSKqdF1EGXTMqHG3lXvQSS4+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470358; c=relaxed/simple;
	bh=rlyNd7fPriGPTL5IajyXNA7VABUSs7iWg88r86sEtto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvS9PjBq8WVPoiCJRfjgfelO62dTpS6PCZt5N56ZKSAWJiiqFYDVlL28xeAkj7gVX8/HlycH6bUUAVkCZDbZAMQX0z7OW1fTTAHpHVc8REITCfvf3o8rX6FS1yk8BeHXiLsktuUppz+YuDCZ2I5r9iZ9Rf2xao6QSk/2cA5cj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLkxJtvo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716470355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JcxfUds2ZTXha9F3BldOC6zxfU+ASImxfAJ1jj0K1VM=;
	b=aLkxJtvo4G19cHuO7zhZGY0KQnC0vbAClJ8WCmBFjGVpRWse6NQnks6j5clcGpS/9je1gr
	TWRjMZxVxKKclwq0S9AEVt48cnaMZR1yyMU/UzL0bhUU0T1Fd1aYin+yrCG+15SbDJeYjk
	kaHAWCVAxcsnEZXhLNTlfRBFNSKSREA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-h016Dk7RM6mh3UV91ig7AA-1; Thu, 23 May 2024 09:19:13 -0400
X-MC-Unique: h016Dk7RM6mh3UV91ig7AA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6ab894d8211so331216d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716470353; x=1717075153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcxfUds2ZTXha9F3BldOC6zxfU+ASImxfAJ1jj0K1VM=;
        b=KJxsAAvxR3ef3pJG7KAyndfMw6z0GMyJ+z7p30VV8xIzx+oxUGOSIBuunc368ftMPI
         +NwHx3bOrht9AQ+lKS23ibH7OX8s9i5dzeyRJJ9szE93jPKuM+JxdGl6KbVcrKL4szT8
         bQFGTnM63fNMvO9GWTWn7hZQ7Df/2vs780HLeoSnKweaDqzjyoUXRFvDp24KjTO3i+Te
         17OQsF/d7RO9ENTupOmj9Mz5tpeJejxoxyEvBiH2xnv0ohT5OXsYrpePYttNBQ8ygKNc
         5mAVtUCJRqHaX+KacOBjLC1azfM1Wa6opMubd7UYGwX0eRAZ0OI2pfdX3CqYkYi7r5oU
         rhCA==
X-Forwarded-Encrypted: i=1; AJvYcCWO0/t3in7oWc67faG8wdkJuJQ6lonoeW3h5NWR6dSZxuZJHLCoYrxObSiOPn1feZCQtnhQ0D65R9/Pa6WwEtJo+E0L6SFfgkweL+WH
X-Gm-Message-State: AOJu0Yw3vqP8qiKeAgVgOTBjzmqziDdfcZJrj5f9PenBjcwplplqseX6
	vqkm5siCoPgou0TkmSg8xH6D6MW4D0/CCB+LcAz9fAN2U7v6MpY8Gx6LARy+I9EPTjjI+7F7z8y
	XxnBHyOgT0IOqlRKp5LzJl+YSa9VYjdt/VYunJVGOU99mAVb1Un34LWdrNXTSJQ==
X-Received: by 2002:a05:622a:188a:b0:437:cc82:9c00 with SMTP id d75a77b69052e-43f9dfaf106mr46916091cf.0.1716470352875;
        Thu, 23 May 2024 06:19:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw4eysyoS9UWqsIeiBvUvLGGn6zD8CK1r2ouiO95n7HQTGLvYA1X4nwCqbsFQXEW4e47A+YQ==
X-Received: by 2002:a05:622a:188a:b0:437:cc82:9c00 with SMTP id d75a77b69052e-43f9dfaf106mr46915591cf.0.1716470351962;
        Thu, 23 May 2024 06:19:11 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43f97a6c7dfsm30169031cf.27.2024.05.23.06.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 06:19:11 -0700 (PDT)
Date: Thu, 23 May 2024 09:19:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
	Pavel Tatashin <pasha.tatashin@soleen.com>,
	axelrasmussen@google.com, nadav.amit@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: 6.10/bisected/regression - commit 8430557fc584 cause warning at
 mm/page_table_check.c:198 __page_table_check_ptes_set+0x306
Message-ID: <Zk9CTcyAM99O8BwU@x1n>
References: <Zk0HxVODITGKqYCw@x1n>
 <CABXGCsNbcMn0Z0RudFrBW78rZPE+cDY+f9r+yKf_AZwJZUOrQg@mail.gmail.com>
 <Zk0UA6wABOB9X_Dx@x1n>
 <CABXGCsOZnxrSHd0y6QrFhzAiY-uTJiRSmo__C_P8Y2qjFV6bRA@mail.gmail.com>
 <Zk0h0V8kvZRKu6F4@x1n>
 <a3d54407-87aa-4f59-adac-c9b79fe1ecef@redhat.com>
 <Zk4MsGxhP5x5aURG@x1n>
 <03faa624-1685-4a21-81fc-cc9e8b760e97@redhat.com>
 <Zk4Y9tU7pOzU0lw1@x1n>
 <CABXGCsMSb1=4krh0d2LYNAN4BYxyuktjthuQdRQSKsANKoeOJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsMSb1=4krh0d2LYNAN4BYxyuktjthuQdRQSKsANKoeOJA@mail.gmail.com>

On Thu, May 23, 2024 at 11:34:37AM +0500, Mikhail Gavrilov wrote:
> On Wed, May 22, 2024 at 9:10 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > ===8<===
> > From c10cde00b14d2d305390dd418a8a8855d3e6437f Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Wed, 22 May 2024 12:04:33 -0400
> > Subject: [PATCH] drop RANDOM_ORVALUE bits
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/debug_vm_pgtable.c | 30 ++++--------------------------
> >  1 file changed, 4 insertions(+), 26 deletions(-)
> >
> > diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> > index f1c9a2c5abc0..b5d7be05063a 100644
> > --- a/mm/debug_vm_pgtable.c
> > +++ b/mm/debug_vm_pgtable.c
> > @@ -40,22 +40,7 @@
> >   * Please refer Documentation/mm/arch_pgtable_helpers.rst for the semantics
> >   * expectations that are being validated here. All future changes in here
> >   * or the documentation need to be in sync.
> > - *
> > - * On s390 platform, the lower 4 bits are used to identify given page table
> > - * entry type. But these bits might affect the ability to clear entries with
> > - * pxx_clear() because of how dynamic page table folding works on s390. So
> > - * while loading up the entries do not change the lower 4 bits. It does not
> > - * have affect any other platform. Also avoid the 62nd bit on ppc64 that is
> > - * used to mark a pte entry.
> >   */
> > -#define S390_SKIP_MASK         GENMASK(3, 0)
> > -#if __BITS_PER_LONG == 64
> > -#define PPC64_SKIP_MASK                GENMASK(62, 62)
> > -#else
> > -#define PPC64_SKIP_MASK                0x0
> > -#endif
> > -#define ARCH_SKIP_MASK (S390_SKIP_MASK | PPC64_SKIP_MASK)
> > -#define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
> >  #define RANDOM_NZVALUE GENMASK(7, 0)
> >
> >  struct pgtable_debug_args {
> > @@ -511,8 +496,7 @@ static void __init pud_clear_tests(struct pgtable_debug_args *args)
> >                 return;
> >
> >         pr_debug("Validating PUD clear\n");
> > -       pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
> > -       WRITE_ONCE(*args->pudp, pud);
> > +       WARN_ON(pud_none(pud));
> >         pud_clear(args->pudp);
> >         pud = READ_ONCE(*args->pudp);
> >         WARN_ON(!pud_none(pud));
> > @@ -548,8 +532,7 @@ static void __init p4d_clear_tests(struct pgtable_debug_args *args)
> >                 return;
> >
> >         pr_debug("Validating P4D clear\n");
> > -       p4d = __p4d(p4d_val(p4d) | RANDOM_ORVALUE);
> > -       WRITE_ONCE(*args->p4dp, p4d);
> > +       WARN_ON(p4d_none(p4d));
> >         p4d_clear(args->p4dp);
> >         p4d = READ_ONCE(*args->p4dp);
> >         WARN_ON(!p4d_none(p4d));
> > @@ -582,8 +565,7 @@ static void __init pgd_clear_tests(struct pgtable_debug_args *args)
> >                 return;
> >
> >         pr_debug("Validating PGD clear\n");
> > -       pgd = __pgd(pgd_val(pgd) | RANDOM_ORVALUE);
> > -       WRITE_ONCE(*args->pgdp, pgd);
> > +       WARN_ON(pgd_none(pgd));
> >         pgd_clear(args->pgdp);
> >         pgd = READ_ONCE(*args->pgdp);
> >         WARN_ON(!pgd_none(pgd));
> > @@ -634,9 +616,6 @@ static void __init pte_clear_tests(struct pgtable_debug_args *args)
> >         if (WARN_ON(!args->ptep))
> >                 return;
> >
> > -#ifndef CONFIG_RISCV
> > -       pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
> > -#endif
> >         set_pte_at(args->mm, args->vaddr, args->ptep, pte);
> >         flush_dcache_page(page);
> >         barrier();
> > @@ -650,8 +629,7 @@ static void __init pmd_clear_tests(struct pgtable_debug_args *args)
> >         pmd_t pmd = READ_ONCE(*args->pmdp);
> >
> >         pr_debug("Validating PMD clear\n");
> > -       pmd = __pmd(pmd_val(pmd) | RANDOM_ORVALUE);
> > -       WRITE_ONCE(*args->pmdp, pmd);
> > +       WARN_ON(pmd_none(pmd));
> >         pmd_clear(args->pmdp);
> >         pmd = READ_ONCE(*args->pmdp);
> >         WARN_ON(!pmd_none(pmd));
> > --
> > 2.45.0
> >
> > --
> > Peter Xu
> >
> 
> Good news the patch works and the warning at mm/page_table_check.c:198
> __page_table_check_ptes_set+0x306 is gone.
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Thanks.

> 
> Bad news the testing terminated with an old annoying problem which
> appeared during the 6.9 release cycle [1] and looks like it has not
> been fixed yet.
> [24119.281379] BUG: Bad page state in process kcompactd0  pfn:3ae37e
> [24119.281387] page: refcount:0 mapcount:0 mapping:00000000d16c2d75
> index:0x272ea3200 pfn:0x3ae37e
> [24119.281390] aops:btree_aops ino:1
> [24119.281395] flags:
> 0x17ffffc000020c(referenced|uptodate|workingset|node=0|zone=2|lastcpupid=0x1fffff)
> [24119.281400] raw: 0017ffffc000020c dead000000000100 dead000000000122
> ffff888136ecd220
> [24119.281402] raw: 0000000272ea3200 0000000000000000 00000000ffffffff
> 0000000000000000
> [24119.281403] page dumped because: non-NULL mapping
> [24119.281405] Modules linked in: overlay tun crypto_user uinput
> snd_seq_dummy snd_hrtimer rfcomm nf_conntrack_netbios_ns
> nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
> nf_tables qrtr uhid bnep sunrpc binfmt_misc amd_atl intel_rapl_msr
> intel_rapl_common mt76x2u mt76x2_common mt7921e mt7921_common
> mt76x02_usb mt76_usb mt792x_lib mt76x02_lib mt76_connac_lib vfat mt76
> fat mac80211 snd_hda_codec_hdmi snd_hda_intel edac_mce_amd
> snd_intel_dspcfg snd_intel_sdw_acpi snd_usb_audio uvcvideo
> snd_hda_codec kvm_amd btusb snd_usbmidi_lib uvc snd_hda_core snd_ump
> btrtl videobuf2_vmalloc btintel videobuf2_memops snd_rawmidi snd_hwdep
> videobuf2_v4l2 btbcm btmtk snd_seq videobuf2_common libarc4
> snd_seq_device kvm bluetooth ledtrig_netdev videodev snd_pcm cfg80211
> joydev asus_nb_wmi eeepc_wmi mc snd_timer asus_wmi sparse_keymap rapl
> apple_mfi_fastcharge snd wmi_bmof platform_profile
> [24119.281465]  pcspkr igc k10temp soundcore i2c_piix4 rfkill
> gpio_amdpt gpio_generic loop nfnetlink zram amdgpu crct10dif_pclmul
> crc32_pclmul crc32c_intel amdxcp polyval_clmulni i2c_algo_bit
> polyval_generic drm_ttm_helper ttm nvme drm_exec ghash_clmulni_intel
> gpu_sched drm_suballoc_helper sha512_ssse3 drm_buddy nvme_core ccp
> sha256_ssse3 drm_display_helper sha1_ssse3 sp5100_tco video nvme_auth
> wmi hid_apple ip6_tables ip_tables fuse
> [24119.281496] CPU: 30 PID: 221 Comm: kcompactd0 Tainted: G        W
>  L     6.9.0-test-5f16eb0549ab-with-drop-RANDOM_ORVALUE-bits+ #34
> [24119.281498] Hardware name: ASUS System Product Name/ROG STRIX
> B650E-I GAMING WIFI, BIOS 2611 04/07/2024
> [24119.281500] Call Trace:
> [24119.281502]  <TASK>
> [24119.281503]  dump_stack_lvl+0x84/0xd0
> [24119.281508]  bad_page.cold+0xbe/0xe0
> [24119.281510]  ? __pfx_bad_page+0x10/0x10
> [24119.281514]  ? page_bad_reason+0x9d/0x1f0
> [24119.281517]  free_unref_page+0x838/0x10e0
> [24119.281520]  __folio_put+0x1ba/0x2b0
> [24119.281523]  ? __pfx___folio_put+0x10/0x10
> [24119.281525]  ? __pfx___might_resched+0x10/0x10
> [24119.281528]  ? migrate_folio_done+0x1de/0x2b0
> [24119.281531]  migrate_pages_batch+0xe73/0x2880
> [24119.281534]  ? __pfx_compaction_alloc+0x10/0x10
> [24119.281536]  ? __pfx_compaction_free+0x10/0x10
> [24119.281539]  ? __pfx_migrate_pages_batch+0x10/0x10
> [24119.281543]  ? rcu_is_watching+0x12/0xc0
> [24119.281546]  migrate_pages+0x194f/0x22f0
> [24119.281548]  ? __pfx_compaction_alloc+0x10/0x10
> [24119.281550]  ? __pfx_compaction_free+0x10/0x10
> [24119.281553]  ? __pfx_migrate_pages+0x10/0x10
> [24119.281555]  ? rcu_is_watching+0x12/0xc0
> [24119.281557]  ? isolate_migratepages_block+0x2b02/0x4560
> [24119.281561]  ? __pfx_isolate_migratepages_block+0x10/0x10
> [24119.281563]  ? folio_putback_lru+0x5e/0xb0
> [24119.281566]  compact_zone+0x1a7c/0x3860
> [24119.281569]  ? rcu_is_watching+0x12/0xc0
> [24119.281571]  ? __pfx___free_object+0x10/0x10
> [24119.281575]  ? __pfx_compact_zone+0x10/0x10
> [24119.281577]  ? rcu_is_watching+0x12/0xc0
> [24119.281579]  ? lock_acquire+0x457/0x540
> [24119.281581]  ? kcompactd+0x2fa/0xc70
> [24119.281583]  ? rcu_is_watching+0x12/0xc0
> [24119.281585]  compact_node+0x144/0x240
> [24119.281588]  ? __pfx_compact_node+0x10/0x10
> [24119.281593]  ? rcu_is_watching+0x12/0xc0
> [24119.281595]  kcompactd+0x686/0xc70
> [24119.281598]  ? __pfx_kcompactd+0x10/0x10
> [24119.281600]  ? __pfx_autoremove_wake_function+0x10/0x10
> [24119.281603]  ? __kthread_parkme+0xb1/0x1d0
> [24119.281605]  ? __pfx_kcompactd+0x10/0x10
> [24119.281608]  ? __pfx_kcompactd+0x10/0x10
> [24119.281610]  kthread+0x2d2/0x3a0
> [24119.281612]  ? _raw_spin_unlock_irq+0x28/0x60
> [24119.281614]  ? __pfx_kthread+0x10/0x10
> [24119.281616]  ret_from_fork+0x31/0x70
> [24119.281618]  ? __pfx_kthread+0x10/0x10
> [24119.281620]  ret_from_fork_asm+0x1a/0x30
> [24119.281624]  </TASK>
> [24171.367867] watchdog: BUG: soft lockup - CPU#25 stuck for 26s!
> [kworker/u130:3:2474335]
> 
> I attached the full kernel log below.
> 
> [1] https://lore.kernel.org/linux-kernel/CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com/

Sorry to know that nobody is looking at this for two months.. However I
think we'll need to fix them separately anyway.  Let me post a fix for the
known first.

-- 
Peter Xu


