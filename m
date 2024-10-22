Return-Path: <linux-kernel+bounces-376908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3E19AB74D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1DBBB22C48
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9351CBEA6;
	Tue, 22 Oct 2024 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/f9cgDb"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ACC1CB530;
	Tue, 22 Oct 2024 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627200; cv=none; b=JAg8XyOpLlYHgeUkJen2wOeer2qfPhHUiDfCW9O+ibcXOBf6DTp07KytP/cHNP+wbdxt2fG/vRcSvJVLjmcPEId7nvzXAYHu+AU4DrEZtkaeIL4QfxSEnYeOkdPMfjrONTMjujsEwp6B7Xg/MD1IEwMmXukTGJq0Iedd5sWDaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627200; c=relaxed/simple;
	bh=YPIZ3W+laQWvpI07qkwlRXeqDcxk4BzLhdx9x+k8pHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uxt8PunkZr+G/nu23yjF9BkIscvjX5epQ7fwIA82ZABV8Vz87wQdx0s9HdglEfL7Mc/RJbokle/SC8PoAXImGSg7tr1MGvbtCcIwzBJTQmNOeqnSgEiMrSMnWIg7+6xNcFIU+4MkbZ4TaEjKB8e/yM2r87uKi5NteAzb7ibZWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/f9cgDb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4314b316495so58611515e9.2;
        Tue, 22 Oct 2024 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729627197; x=1730231997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4kBt06lhUeipS/LMIshLw3pcUoTtwKaBiCXECp7O7Q=;
        b=k/f9cgDbEVlr5SG4SLQZ9iyysVCqTCI5+uhjcRYGAkKOpcMYlfJL9Fbk61M+LfwhJZ
         GS4F9vyY+QVo12Mu04L1FpkdJmHXTOpa+DQDRDvKa6IUmPDZc2eTfD9s51vD6Xp/rGJq
         /79HPGIw/gbZh7bipbM+oPnUSronCU6Y0DTnEmwyE0FoL7qEQyc3rJVXA+RUnsi7FQri
         SkVXSrlRWrgF7I5ebe56IDnQk8e0q7FR4KNKSxZ2lN/YoYdAYivEsxMrOjGTMLVir3hf
         fiAygbVGoTj9aKcoBAwdV4cMvCE68fRf50y/0mAuVopoogpUNq8F2iKLQV84FkMjYDA3
         k3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729627197; x=1730231997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4kBt06lhUeipS/LMIshLw3pcUoTtwKaBiCXECp7O7Q=;
        b=YtddXRhOAZDPXlohBkvWvELVQiVPEWeuQA7NiUr82yu2Umm+PXZyEq1NRirzZnrmi9
         6O8pTM15FY7zg5LY/EJasKh9k/8m0Eh2dz9YnBkrawDTdYD2L2k9UjMvTg8+Pdsgxrbj
         lGDBQ3Vm6owuQKKISFZMco5H1v7v8qyq0DZl1zgQBlew+bP1BrEe4igFLaghgV/60H5V
         oAC9t9sHPW2rpqd/JpiT66JLPhnZFLNiyg+jb2SxNBZv3zwUfRdrHn9HUHm748pGPaMu
         yEBcoxFWkir+apm4OqgcqCJTLSUxv1DnqFAD9ABALc/MsrGhox3UT6QDv+XMEr35WxF8
         E7iw==
X-Forwarded-Encrypted: i=1; AJvYcCW31F+4Rx/oVxO/N3+3qslIdroWJ3x6JNGgEVl6mdNLCn6cgSV+hZAMlbRxo3poNXW0EDGLG+d1x54=@vger.kernel.org, AJvYcCWVRqry3KLAw3R5MOKko2k6Qw3wqgBIU1CdvSPwpIPESFXmr2aC9l/qyptioyvcILEr3/Rbs3KEw9U1lsz/@vger.kernel.org
X-Gm-Message-State: AOJu0YwxloaHHmnaoMrY/9qymH/VglHAPQpxmHXk6bDddYx/tq5SNr86
	Exww45mRr7nFsxEFuHYKneZKw8xoRXtrrYXGLMbUk2yk+9WS+8jA
X-Google-Smtp-Source: AGHT+IGAW4t75sJ+rtcFiYbJrn2Rl54abvsjjNHNXrYXQfB3PbwEfQSIMdSPP4VR5jAc3O4fwlEN7g==
X-Received: by 2002:a05:600c:1c95:b0:42c:bd4d:e8ba with SMTP id 5b1f17b1804b1-4318413e532mr2527555e9.8.1729627197001;
        Tue, 22 Oct 2024 12:59:57 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c311bsm95896925e9.29.2024.10.22.12.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 12:59:56 -0700 (PDT)
Message-ID: <032b5d28-68bb-4fea-91f7-e4a8bc4c4bb6@gmail.com>
Date: Tue, 22 Oct 2024 20:59:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/4] mm/zswap: skip swapcache for swapping in zswap pages
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 david@redhat.com, willy@infradead.org, kanchana.p.sridhar@intel.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, ryan.roberts@arm.com,
 ying.huang@intel.com, 21cnbao@gmail.com, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <20241018105026.2521366-2-usamaarif642@gmail.com>
 <CAJD7tkYOGA2oQ=BSP3oXeV0Fh2=QRZZ=_5t2Wg6qrYZixCkZAg@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkYOGA2oQ=BSP3oXeV0Fh2=QRZZ=_5t2Wg6qrYZixCkZAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21/10/2024 22:11, Yosry Ahmed wrote:
> On Fri, Oct 18, 2024 at 3:50 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> As mentioned in [1], there is a significant improvement in no
>> readahead swapin performance for super fast devices when skipping
>> swapcache.
>>
>> With large folio zswapin support added in later patches, this will also
>> mean this path will also act as "readahead" by swapping in multiple
>> pages into large folios. further improving performance.
>>
>> [1] https://lore.kernel.org/all/1505886205-9671-5-git-send-email-minchan@kernel.org/T/#m5a792a04dfea20eb7af4c355d00503efe1c86a93
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>  include/linux/zswap.h |  6 ++++++
>>  mm/memory.c           |  3 ++-
>>  mm/page_io.c          |  1 -
>>  mm/zswap.c            | 46 +++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 54 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
>> index d961ead91bf1..e418d75db738 100644
>> --- a/include/linux/zswap.h
>> +++ b/include/linux/zswap.h
>> @@ -27,6 +27,7 @@ struct zswap_lruvec_state {
>>  unsigned long zswap_total_pages(void);
>>  bool zswap_store(struct folio *folio);
>>  bool zswap_load(struct folio *folio);
>> +bool zswap_present_test(swp_entry_t swp, int nr_pages);
>>  void zswap_invalidate(swp_entry_t swp);
>>  int zswap_swapon(int type, unsigned long nr_pages);
>>  void zswap_swapoff(int type);
>> @@ -49,6 +50,11 @@ static inline bool zswap_load(struct folio *folio)
>>         return false;
>>  }
>>
>> +static inline bool zswap_present_test(swp_entry_t swp, int nr_pages)
>> +{
>> +       return false;
>> +}
>> +
>>  static inline void zswap_invalidate(swp_entry_t swp) {}
>>  static inline int zswap_swapon(int type, unsigned long nr_pages)
>>  {
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 03e5452dd0c0..49d243131169 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4289,7 +4289,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>         swapcache = folio;
>>
>>         if (!folio) {
>> -               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>> +               if ((data_race(si->flags & SWP_SYNCHRONOUS_IO) ||
>> +                   zswap_present_test(entry, 1)) &&
>>                     __swap_count(entry) == 1) {
>>                         /* skip swapcache */
>>                         folio = alloc_swap_folio(vmf);
>> diff --git a/mm/page_io.c b/mm/page_io.c
>> index 4aa34862676f..2a15b197968a 100644
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -602,7 +602,6 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
>>         unsigned long pflags;
>>         bool in_thrashing;
>>
>> -       VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, folio);
>>         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>>         VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 7f00cc918e7c..f4b03071b2fb 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1576,6 +1576,52 @@ bool zswap_store(struct folio *folio)
>>         return ret;
>>  }
>>
>> +static bool swp_offset_in_zswap(unsigned int type, pgoff_t offset)
>> +{
>> +       return (offset >> SWAP_ADDRESS_SPACE_SHIFT) <  nr_zswap_trees[type];
>> +}
>> +
>> +/* Returns true if the entire folio is in zswap */
>> +bool zswap_present_test(swp_entry_t swp, int nr_pages)
> 
> Also, did you check how the performance changes if we bring back the
> bitmap of present entries (i.e. what used to be frontswap's bitmap)
> instead of the tree lookups here?
> 

I think the cost of tree lookup is not much and compared to zswap_decompress
can probably be ignored. zswap_present_test is essentially just xa_load for
the first entry, and then xas_next_entry for subsequent entries which is even
cheaper than xa_load.

