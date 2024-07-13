Return-Path: <linux-kernel+bounces-251297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EBA930318
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6307F283458
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C383A125C0;
	Sat, 13 Jul 2024 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWZga/KT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A541095B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720835053; cv=none; b=CXyuKvlZdOVNZ5glEDsR75w7vJq31Cbwwa85Sr2VgNXN/feMHms1UJXNuMvxjoUwgjAcc7MHqLdtK24MnqXOiO2+2HYur2/FsGSq+QibDkNaSFhcroX2TC1LuruQgoMUOAmCFT5n9bhBJpv3xI00AHJuc1KtBm1LTBsMtJq7+uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720835053; c=relaxed/simple;
	bh=cMS132SjjkcvgUC/IbODbtO5BZHytJaOS+bcJ5C5W0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/srEzypr8Dk6OFfk0Lbn4rj7ynl1sQ9iItem6weUTsAnLPLd0HYEGTX/ckC68rTM3htu44R1ZD479UqAAwH0yuGNrp1ZmqMe/sURNkiAo7VyhcNJQYpo5TUw1Gb9Hbn2T7q8TDHP3Ig+1Tt3XZn12zQ4OcIoq0aFqBY5FDRAeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWZga/KT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720835050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/LhhK/MwVuJD8RiThdnCHgpX/mf8B6TT8D7Me4aER4=;
	b=WWZga/KT3SQPPV69K63c+r3ua3uO+zWsV0NnXHn4b4lzc4mq9+pMsyzOIopkvpi16tDg/l
	EBU0GafW3YkON5kaD/Eht3Nwnq0fJIxfuoqX8c1TBau8saSDPaEHHZ5qhCcyv4vLhyG0Rk
	0/MP97b0Ff34PNIBdQKWLjgnyVVk2xE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-SNqB-UG1Pqm3-gwrcEvPtw-1; Fri, 12 Jul 2024 21:44:08 -0400
X-MC-Unique: SNqB-UG1Pqm3-gwrcEvPtw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79f006f9f14so564676785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720835048; x=1721439848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/LhhK/MwVuJD8RiThdnCHgpX/mf8B6TT8D7Me4aER4=;
        b=OFzzqJm7vkxzq8OVYAgVNlxJAHiO5p6lpyyWmhyB5xtKA4OZXSP18XDdkT3yzxQ4IT
         XNmbf3+JdlpsjeniyZsnqAdtXU7q860MGwkIAn3QduI/k822x63sWFyIasMfGPbH/tfO
         eflJBQl8kQbOVaAtKgSGjJAijPUi7dHvqJbMFqqz/A7CQnkUHRgZ7Vv2RS+DcmGoRj6u
         fj7tdJYaC4Qcr2KtbXgTboN+mXw6tAs+XT/mxbDPdbKMA1pEJeXpjxvaKwxMNO9oRAML
         D+H32qlp0sHzUUxOKN0nf16a+/3SOhbGfVTr2hS+aMxRbBnAIWQ28GKCEqworI8Tugkl
         EX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXq0c5UHH9/tO0e4cAytDx9XUq8sPTPaTCZSJDisvjHWUKmJsqg5cdHs7jToJiehQ5bg+RsPqfUjj7FY3wDUV1BvBSD8SomzKg6rvcn
X-Gm-Message-State: AOJu0YxVWjgU7v+QCWDFXdq6DNgmE7hNb6exiLDIrkn2lhkrTVPMfiLz
	9nLged4o3l+y6Xm508vA4d/COtZ/K+uTB7EDXIty8iOLT9r7Dpu9D4CRw52upsp9uRvhKu/AZUU
	tkVc2ubwU+LgIOPXgGO8n81gsdxk6qP6v5xy0IIt3CZryWWzMT6xh05tig4VpFQ==
X-Received: by 2002:a05:620a:20d7:b0:79f:18f1:b6e6 with SMTP id af79cd13be357-7a1532396c7mr732063585a.10.1720835047811;
        Fri, 12 Jul 2024 18:44:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVZbfN6peH6kN+PL0CZNMjAxwclgghCFzJx1D7VF9wunqpfTLj5X0f0K+y4iKa1Tv/U9MsCQ==
X-Received: by 2002:a05:620a:20d7:b0:79f:18f1:b6e6 with SMTP id af79cd13be357-7a1532396c7mr732062385a.10.1720835047497;
        Fri, 12 Jul 2024 18:44:07 -0700 (PDT)
Received: from [192.168.1.152] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160c736d3sm8477785a.119.2024.07.12.18.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 18:44:07 -0700 (PDT)
Message-ID: <ac7a0dbe-e00f-cf61-e6fe-bf5875d4a04f@redhat.com>
Date: Fri, 12 Jul 2024 21:44:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH -next] dm: vdo: Add missing kernel-doc function comments.
Content-Language: en-US
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20240712081204.79723-1-yang.lee@linux.alibaba.com>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20240712081204.79723-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/12/24 04:12, Yang Li wrote:
> Add missing kernel-doc function comments to enhance code readability and
> maintainability in accordance with the kernel coding standards.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9518
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

I appreciate the patch, but some of these descriptions are not correct.
You can fix the patch if you'd like, or I can create a patch my self to 
add these kernel-doc comments.

Matt Sakai

> ---
>   drivers/md/dm-vdo/repair.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/md/dm-vdo/repair.c b/drivers/md/dm-vdo/repair.c
> index ff09e4a14333..8947e6092a91 100644
> --- a/drivers/md/dm-vdo/repair.c
> +++ b/drivers/md/dm-vdo/repair.c
> @@ -319,6 +319,7 @@ static bool __must_check abort_on_error(int result, struct repair_completion *re
>   /**
>    * drain_slab_depot() - Flush out all dirty refcounts blocks now that they have been rebuilt or
>    *                      recovered.
> + * @completion: The completion to convert.

This is the repair completion. There is nothing being converted here.

>    */
>   static void drain_slab_depot(struct vdo_completion *completion)
>   {
> @@ -656,6 +657,7 @@ static void rebuild_reference_counts(struct vdo_completion *completion)
>   
>   /**
>    * increment_recovery_point() - Move the given recovery point forward by one entry.
> + * @point: The location of the next recovery journal entry to apply.

This is the recovery point to increment. It is not the "next" entry, and 
this function doesn't care what the caller will use the recovery point for.

>    */
>   static void increment_recovery_point(struct recovery_point *point)
>   {
> @@ -953,6 +955,7 @@ static void abort_block_map_recovery(struct repair_completion *repair, int resul
>   /**
>    * find_entry_starting_next_page() - Find the first journal entry after a given entry which is not
>    *                                   on the same block map page.
> + * @repair: The repair completion.
>    * @current_entry: The entry to search from.
>    * @needs_sort: Whether sorting is needed to proceed.
>    *
> @@ -1219,6 +1222,7 @@ static bool __must_check is_exact_recovery_journal_block(const struct recovery_j
>   
>   /**
>    * find_recovery_journal_head_and_tail() - Find the tail and head of the journal.
> + * @repair: The repair completion.
>    *
>    * Return: True if there were valid journal blocks.
>    */
> @@ -1447,6 +1451,7 @@ static int validate_heads(struct repair_completion *repair)
>   
>   /**
>    * extract_new_mappings() - Find all valid new mappings to be applied to the block map.
> + * @repair: The repair completion.
>    *
>    * The mappings are extracted from the journal and stored in a sortable array so that all of the
>    * mappings to be applied to a given block map page can be done in a single page fetch.
> @@ -1501,6 +1506,7 @@ static int extract_new_mappings(struct repair_completion *repair)
>   /**
>    * compute_usages() - Compute the lbns in use and block map data blocks counts from the tail of
>    *                    the journal.
> + * @repair: The repair completion.
>    */
>   static noinline int compute_usages(struct repair_completion *repair)
>   {


