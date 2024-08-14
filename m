Return-Path: <linux-kernel+bounces-286206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2E6951801
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4341C225A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021D19DFA6;
	Wed, 14 Aug 2024 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxNKte0K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DC619DF46
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628732; cv=none; b=LVpHjkARavtkODpFsiVVuh13i6/JpIgnMFwAPIbXreKbzyz4V+1NpfvpUcSDoP3h3VEaZ+org+VmJ9hf8zHJ2pIYDsx/lgK7lQW9OMRW74RIxnxP0DCUGFAREmYG1I6ZS8m06Djc/REs8pi2k8/dnr0qtzhtIW3EJV3+mMKsGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628732; c=relaxed/simple;
	bh=/BgaJP6WapcEf9rydblBMqZUtT/XctjPETVl77uUu/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=no8j0nAQrgE1ZA8gBGfDUzQwAMAJhbU1CkdINuTy1zVSLpvgUxnhBycoY2Nk2KEGV0/Z4RKKFqiQDZCGYL6Fl+U3J1csYHrUJrXU3DS/hCGa9SSbYhoHP2eiL3Wy3m6OuDp862XsVLP1fs8umvF2Ac/4STzrCBsjOjItZynul28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxNKte0K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723628729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XIV40pjoBgrM0L4JQn8D72THXqwu6l+YptiJOPXQPCU=;
	b=VxNKte0K/z6XkWfI9+I4M+QakgCMwG388wkBMN4Hm1VAUuVrwveevkLxXsGpcgqENOX4i+
	P1wv0B0QpCrdakIp1xYf4y7GIKiCAP3jOcleQxPslonhF3Ly2omF893Z69AO84223wmy4O
	Q9OEgFVh/kHUJeqjUOUCFW5rngrauD8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-NILPYzIKMK2vnn_SXOBniQ-1; Wed, 14 Aug 2024 05:45:27 -0400
X-MC-Unique: NILPYzIKMK2vnn_SXOBniQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a25d0755f3so5260751a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723628727; x=1724233527;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XIV40pjoBgrM0L4JQn8D72THXqwu6l+YptiJOPXQPCU=;
        b=Q6FCeMnWfbdpe4dLabV1RjKSD3ea9hhGXppAWYraNbJJ1PmXP61UtSSlGsR/VJdjpl
         iBB9RARSHpFQXZ9ULXp9aoGhLYkdFELfjMz2ZlEBl8ZU0HyQBx8m3+mh1rIBKWGBm8dd
         H65uflpLuIanzDHDwtv3xS9HSLwL3jbw2CwItZRSI1lEfrWLiOXHuNJTIDJjhYVMWjzi
         Bjo7sAbfHBEB0Q8hBG69TQUM+WkIaIH9AxpQvpQtPHxAOlcaIo63okFykgUXG2yVNF+/
         UUCqyaVwd6Cta4b1Mc1LyzZwu22ujuon3scGBilSg/CE0WafeOeSt7kf6RAke5WQDfRq
         pNlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVffXBChsD5UHa6ZUZQb0Bu0GaeDACczUgQoAqs8pmZmvq33ayGgG6R3Z+QkhYg6Y1wlrROGUF2nfNNO00aEsaRRcCcLZcuK354qOJS
X-Gm-Message-State: AOJu0YwWWsgHVgzVnV4MRRlqxYIWV2XEl8NCVw+F6JERzbv5xu3zT3PK
	3PCkGd6VpIskwYVU2HQKBrrBZMCfAbR28IAqUvYVhGn3ROfs8DXDSgwjmCPGjo9N0joOuMLaTvT
	tCGHjObhe+baSRVL08mehXq6cqsK7VqEoYlvwKFCMySLuDfKsY5NAeW6JmBZvqw==
X-Received: by 2002:a17:907:f7a4:b0:a80:c130:f72 with SMTP id a640c23a62f3a-a8366d3f3a8mr143255866b.16.1723628726502;
        Wed, 14 Aug 2024 02:45:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENbB95zXl/lRCKl31/6JH96lDVvT/712eOgjEc2h0ynG02yzULVpaHuvZxkhj780JZp5R8Qg==
X-Received: by 2002:a17:907:f7a4:b0:a80:c130:f72 with SMTP id a640c23a62f3a-a8366d3f3a8mr143253166b.16.1723628725927;
        Wed, 14 Aug 2024 02:45:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414e069sm152958866b.178.2024.08.14.02.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 02:45:25 -0700 (PDT)
Message-ID: <116e117c-2821-401d-8e62-b85cdec37f4a@redhat.com>
Date: Wed, 14 Aug 2024 11:45:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec -2.9%
 regression
To: Mateusz Guzik <mjguzik@gmail.com>, Yin Fengwei <fengwei.yin@intel.com>
Cc: kernel test robot <oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Matthew Wilcox <willy@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, WANG Xuerui <kernel@xen0n.name>,
 linux-mm@kvack.org, ying.huang@intel.com, feng.tang@intel.com
References: <202407301049.5051dc19-oliver.sang@intel.com>
 <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
 <439265d8-e71e-41db-8a46-55366fdd334e@intel.com>
 <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>
 <6uxnuf2gysgabyai2r77xrqegb7t7cc2dlzjz6upwsgwrnfk3x@cjj6on3wqm4x>
 <5a67c103-1d9d-440d-8bed-bbfa7d3ecf71@redhat.com>
 <CAGudoHH4NGgPdTe2yL33TNNFriPM9mVM=0_iuh5dLuesZXQMAQ@mail.gmail.com>
 <5c0979a2-9a56-4284-82d2-42da62bda4a5@redhat.com>
 <c7e0d029-0a64-4b27-bd62-cf9a3577d7ff@intel.com>
 <wbbieqyyjqy7ulbta6muzepxwxi6galwvhjdxpqaqbeljzpcer@dpeoqrbkl5p2>
 <817150f2-abf7-430f-9973-540bd6cdd26f@intel.com>
 <CAGudoHG1=p0GEVaSASA1C+iVYbfA5rryozAPPEoxr5uKtM=ghw@mail.gmail.com>
 <f4ddda8d-3513-4471-8609-acb3ce29219e@intel.com>
 <CAGudoHECfSYd7EcxiY+soh157m9H4xfU1en=TgX_=QkpbsOFdg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGudoHECfSYd7EcxiY+soh157m9H4xfU1en=TgX_=QkpbsOFdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.08.24 06:10, Mateusz Guzik wrote:
> On Wed, Aug 14, 2024 at 5:02 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>> On 8/13/24 03:14, Mateusz Guzik wrote:
>>> would you mind benchmarking the change which merely force-inlines _compund_page?
>>>
>>> https://lore.kernel.org/linux-mm/66c4fcc5-47f6-438c-a73a-3af6e19c3200@redhat.com/
>> This change can resolve the regression also:
> 
> Great, thanks.
> 
> David, I guess this means it would be fine to inline the entire thing
> at least from this bench standpoint. Given that this is your idea I
> guess you should do the needful(tm)? :)

Testing

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5769fe6e4950..25e25b34f4a0 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -235,7 +235,7 @@ static __always_inline int page_is_fake_head(const struct page *page)
         return page_fixed_fake_head(page) != page;
  }
  
-static inline unsigned long _compound_head(const struct page *page)
+static __always_inline unsigned long _compound_head(const struct page *page)
  {
         unsigned long head = READ_ONCE(page->compound_head);
  

With a kernel-config based on something derived from Fedora
config-6.8.9-100.fc38.x86_64 for convenience with

CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y

add/remove: 15/14 grow/shrink: 79/87 up/down: 12836/-13917 (-1081)
Function                                     old     new   delta
change_pte_range                               -    2308   +2308
iommu_put_dma_cookie                         454    1276    +822
get_hwpoison_page                           2007    2580    +573
end_bbio_data_read                          1171    1626    +455
end_bbio_meta_read                           492     934    +442
ext4_finish_bio                              773    1208    +435
fq_ring_free_locked                          128     541    +413
end_bbio_meta_write                          493     872    +379
gup_fast_fallback                           4207    4568    +361
v1_free_pgtable                              166     519    +353
iommu_v1_map_pages                          2747    3098    +351
end_bbio_data_write                          609     960    +351
fsverity_verify_bio                          334     656    +322
follow_page_mask                            3399    3719    +320
__read_end_io                                316     635    +319
btrfs_end_super_write                        494     789    +295
iommu_alloc_pages_node.constprop             286     572    +286
free_buffers.part                              -     271    +271
gup_must_unshare                               -     268    +268
smaps_pte_range                             1285    1513    +228
pagemap_pmd_range                           2189    2393    +204
iommu_alloc_pages_node                         -     193    +193
smaps_hugetlb_range                          705     897    +192
follow_page_pte                             1584    1758    +174
__migrate_device_pages                      2435    2595    +160
unpin_user_pages_dirty_lock                  205     362    +157
_compound_head                                 -     150    +150
unpin_user_pages                             143     282    +139
put_ref_page.part                              -     126    +126
iomap_finish_ioend                           866     972    +106
iomap_read_end_io                            673     763     +90
end_bbio_meta_read.cold                       42     131     +89
btrfs_do_readpage                           1759    1845     +86
extent_write_cache_pages                    2133    2212     +79
end_bbio_data_write.cold                      32     108     +76
end_bbio_meta_write.cold                      40     108     +68
__read_end_io.cold                            25      91     +66
btrfs_end_super_write.cold                    25      89     +64
ext4_finish_bio.cold                         118     178     +60
fsverity_verify_bio.cold                      25      84     +59
block_write_begin                            217     274     +57
end_bbio_data_read.cold                      378     426     +48
__pfx__compound_head                           -      48     +48
copy_hugetlb_page_range                     3050    3097     +47
lruvec_stat_mod_folio.constprop              585     630     +45
iomap_finish_ioend.cold                      163     202     +39
md_bitmap_file_unmap                         150     187     +37
free_pgd_range                              1949    1985     +36
prep_move_freepages_block                    319     349     +30
iommu_alloc_pages_node.cold                    -      25     +25
iomap_read_end_io.cold                        65      89     +24
zap_huge_pmd                                 874     897     +23
cont_write_begin.cold                        108     130     +22
skb_splice_from_iter                         822     843     +21
set_pmd_migration_entry                     1037    1058     +21
zerocopy_fill_skb_from_iter                 1321    1340     +19
pagemap_scan_pmd_entry                      3261    3279     +18
try_grab_folio_fast                          452     469     +17
change_huge_pmd                             1174    1191     +17
folio_put                                     48      64     +16
__pfx_set_p4d                                  -      16     +16
__pfx_put_ref_page.part                        -      16     +16
__pfx_lruvec_stat_mod_folio.constprop        208     224     +16
__pfx_iommu_alloc_pages_node.constprop        16      32     +16
__pfx_iommu_alloc_pages_node                   -      16     +16
__pfx_gup_must_unshare                         -      16     +16
__pfx_free_buffers.part                        -      16     +16
__pfx_folio_put                               48      64     +16
__pfx_change_pte_range                         -      16     +16
__pfx___pte                                   32      48     +16
offline_pages                               1962    1975     +13
memfd_pin_folios                            1284    1297     +13
uprobe_write_opcode                         2062    2073     +11
set_p4d                                        -      11     +11
__pte                                         22      33     +11
copy_page_from_iter_atomic                  1714    1724     +10
__migrate_device_pages.cold                   60      70     +10
try_to_unmap_one                            3355    3364      +9
try_to_migrate_one                          3310    3319      +9
stable_page_flags                           1034    1043      +9
io_sqe_buffer_register                      1404    1413      +9
dio_zero_block                               644     652      +8
add_ra_bio_pages.constprop.isra             1542    1550      +8
__add_to_kill                                969     977      +8
btrfs_writepage_fixup_worker                1199    1206      +7
write_protect_page                          1186    1192      +6
iommu_v2_map_pages.cold                      145     151      +6
gup_fast_fallback.cold                       112     117      +5
try_to_merge_one_page                       1857    1860      +3
__apply_to_page_range                       2235    2238      +3
wbc_account_cgroup_owner                     217     219      +2
change_protection.cold                       105     107      +2
can_change_pte_writable                      354     356      +2
vmf_insert_pfn_pud                           699     700      +1
split_huge_page_to_list_to_order.cold        152     151      -1
pte_pfn                                       40      39      -1
move_pages                                  5270    5269      -1
isolate_single_pageblock                    1056    1055      -1
__apply_to_page_range.cold                    92      91      -1
unmap_page_range.cold                         88      86      -2
do_huge_pmd_numa_page                       1175    1173      -2
free_pgd_range.cold                          162     159      -3
copy_page_to_iter                            329     326      -3
copy_page_range.cold                         149     146      -3
copy_page_from_iter                          307     304      -3
can_finish_ordered_extent                    551     548      -3
__replace_page                              1133    1130      -3
__reset_isolation_pfn                        645     641      -4
dio_send_cur_page                           1113    1108      -5
__access_remote_vm                          1010    1005      -5
pagemap_hugetlb_category                     468     459      -9
extent_write_locked_range                   1148    1139      -9
unuse_pte_range                             1834    1821     -13
do_migrate_range                            1935    1922     -13
__get_user_pages                            1952    1938     -14
migrate_vma_collect_pmd                     2817    2802     -15
copy_page_to_iter_nofault                   2373    2358     -15
hugetlb_fault                               4054    4038     -16
__pfx_shake_page                              16       -     -16
__pfx_put_page                                16       -     -16
__pfx_pfn_swap_entry_to_page                  32      16     -16
__pfx_gup_must_unshare.part                   16       -     -16
__pfx_gup_folio_next                          16       -     -16
__pfx_free_buffers                            16       -     -16
__pfx___get_unpoison_page                     16       -     -16
btrfs_cleanup_ordered_extents                622     604     -18
read_rdev                                    694     673     -21
isolate_migratepages_block.cold              222     197     -25
hugetlb_mfill_atomic_pte                    1869    1844     -25
folio_pte_batch.constprop                   1020     995     -25
hugetlb_reserve_pages                       1468    1441     -27
__alloc_fresh_hugetlb_folio                  676     649     -27
intel_pasid_alloc_table.cold                  83      52     -31
__pfx_iommu_put_pages_list                    48      16     -32
__pfx_PageHuge                                32       -     -32
__blockdev_direct_IO.cold                    952     920     -32
io_ctl_prepare_pages                         832     794     -38
__handle_mm_fault                           4237    4195     -42
finish_fault                                1007     962     -45
__pfx_pfn_swap_entry_folio                    64      16     -48
vm_normal_folio_pmd                           84      34     -50
vm_normal_folio                               84      34     -50
set_migratetype_isolate                     1429    1375     -54
do_set_pmd                                   618     561     -57
can_change_pmd_writable                      293     229     -64
__unmap_hugepage_range                      2389    2325     -64
do_fault                                    1187    1121     -66
fault_dirty_shared_page                      425     358     -67
madvise_free_huge_pmd                        863     792     -71
insert_page_into_pte_locked.isra             502     429     -73
restore_exclusive_pte                        539     463     -76
isolate_migratepages_block                  5436    5355     -81
__do_fault                                   366     276     -90
set_pte_range                                593     502     -91
follow_devmap_pmd                            559     468     -91
__pfx_bio_first_folio                        144      48     -96
shake_page                                   105       -    -105
hugetlb_change_protection                   2314    2204    -110
hugetlb_wp                                  2134    2017    -117
__blockdev_direct_IO                        5063    4946    -117
skb_tx_error                                 272     149    -123
put_page                                     123       -    -123
gup_must_unshare.part                        135       -    -135
PageHuge                                     136       -    -136
ksm_scan_thread                             9172    9032    -140
intel_pasid_alloc_table                      596     447    -149
copy_huge_pmd                               1539    1385    -154
skb_split                                   1534    1376    -158
split_huge_pmd_locked                       4024    3865    -159
skb_append_pagefrags                         663     504    -159
memory_failure                              2784    2624    -160
unpoison_memory                             1328    1167    -161
cont_write_begin                             959     793    -166
pfn_swap_entry_to_page                       250      82    -168
skb_pp_cow_data                             1539    1367    -172
gup_folio_next                               180       -    -180
intel_pasid_get_entry.isra                   607     425    -182
v2_alloc_pgtable                             309     126    -183
do_huge_pmd_wp_page                         1173     988    -185
bio_first_folio.cold                         315     105    -210
unmap_page_range                            6091    5873    -218
split_huge_page_to_list_to_order            4141    3905    -236
move_pages_huge_pmd                         2053    1813    -240
free_buffers                                 286       -    -286
iommu_v2_map_pages                          1722    1428    -294
soft_offline_page                           2149    1843    -306
do_wp_page                                  3340    2993    -347
do_swap_page                                4619    4265    -354
md_import_device                            1002     635    -367
copy_page_range                             7436    7040    -396
__get_unpoison_page                          415       -    -415
pfn_swap_entry_folio                         596     149    -447
iommu_put_pages_list                        1071     344    -727
bio_first_folio                             2322     774   -1548
change_protection                           5008    2790   -2218
Total: Before=32786363, After=32785282, chg -0.00%


-- 
Cheers,

David / dhildenb


