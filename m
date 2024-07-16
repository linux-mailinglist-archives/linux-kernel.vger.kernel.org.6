Return-Path: <linux-kernel+bounces-254548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFF6933498
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF83E1F2189F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86EF13E40F;
	Tue, 16 Jul 2024 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3qBmro0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5A613DDD0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721172893; cv=none; b=GyGFXhWnRrzKV1kE9xMVYe+49tqAnS5vdfrtYkZvGYAjGs/ijuCVHCcKRiRFCUUX7tHBnlpiNjW1wIoWUYTAkB2PL43aU6A7c8uNblLmcHTIRK7KWusGLmGK+g8taG7yIFeOWANUwRUhUI4EQ8UDppPmt6bxFl+/6u53CeFPK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721172893; c=relaxed/simple;
	bh=3nB1boiG1A2kWJMubHu7Tj7tDnrXQiEKyO2QJfNF6Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2VVsxEUzPVdMo7waYVxPuyjrki0VZyfB9zJGy93iphgScd089+XbeEMiAFMdN44en1xkiTl78WXZ5CEVg9edupkk5kC4kA6zMMHUvU6Yb7ltwQONe5cy5wwkI91Riz10PBPMBLminNj8AOShmaSKJHCmebwdhT1wNOoL5tnXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i3qBmro0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721172889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce3oiwNi7t9StCHmh3dnbHVqDD34QccC4Vb0kWTpmbU=;
	b=i3qBmro0VB5N9HYG3Te8iZgQUqK5Iy/dGBK9uspSjJJ8B4PCq56Z3SEZ3j+/K2sT2IACbi
	6kua2VXsNoQya6SGP+Hy4BRY5egCq10pf+fsoUv68AJssV1r563zPb0TTDOKivsfwjgMl8
	22EhCfGk+WCTKVij/VUEtZ+8JmMVpmg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-iK6-hp9VMguDIEY7R116Zw-1; Tue, 16 Jul 2024 19:34:48 -0400
X-MC-Unique: iK6-hp9VMguDIEY7R116Zw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b772457b40so46682046d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 16:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721172888; x=1721777688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce3oiwNi7t9StCHmh3dnbHVqDD34QccC4Vb0kWTpmbU=;
        b=wG/AVyyNtKLpoRnBHAyBCHR8cbgWWUfUrx2/BF4t0r5MewXo6OMAPYiwdrrdfI+e7R
         mv23+CYe0CAjoVO7lhpZAzGgrW+14ocqiS3Px41306Pcp/Oey6KKm4O3csOf/WjfMu2m
         4fPc+iR8SXj9cpmV70wuqSzZkpdN6J45Klnti+is8vYZpkLqv9LWM4q1tvUrNCmgms4u
         ltG8VXtiYOBm8sNEWd+ErP4iF7QGOtbYiDqtv3lCOB8RkdWPfuglFIyN/qnqq64SYiX9
         uaf0SZU8wY5+wyb9jnuV3J8yoeQvPWXe0O+MNlmQpbhq88hvcD0Fqe4pBaza37hyAuKz
         ai0g==
X-Forwarded-Encrypted: i=1; AJvYcCX7vnJMzRpAe1rHc1lZTF3mumGl9UZ7w+jOcUMatiJRTY8STjEBNhqqoJn3WyXsHDkjras8NtaTiD4CYVSCQekH2BtYi+tnDmfQGKB7
X-Gm-Message-State: AOJu0YybQ3bsgXw5/diN/X1lNlNLD/s2xMPSdP7WbXnImiGjVShYOHOj
	PmFOWA2b9n+NCefpOPiibMb9SzH6sT39xwUnz9CSIh+feK6Mrb/AGFwHRfkBarJ3ZACu1/JgiMl
	8VqOHJ+UOgtyUAWERjf8+++f6OO+GapEg3vFyAEB+E8y9WBrZq6JqDz1skR3WJBlyCyoJXyQc
X-Received: by 2002:a05:620a:1a28:b0:79e:ff0a:a10d with SMTP id af79cd13be357-7a17b691168mr414899985a.39.1721172887762;
        Tue, 16 Jul 2024 16:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvak+ZP8NES87xHiJsRxARxOOUUOyrZ6LQUGOqOsy5UAFu/hUczgJ91LesooxankFVUPn2og==
X-Received: by 2002:a05:620a:1a28:b0:79e:ff0a:a10d with SMTP id af79cd13be357-7a17b691168mr414898485a.39.1721172887351;
        Tue, 16 Jul 2024 16:34:47 -0700 (PDT)
Received: from [192.168.1.152] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160ba82cdsm338674385a.4.2024.07.16.16.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 16:34:46 -0700 (PDT)
Message-ID: <2d0a578d-aa8e-be21-f80f-3ba6c62be1f5@redhat.com>
Date: Tue, 16 Jul 2024 19:34:45 -0400
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

I've prepared a patch to add correct documentation which will I will 
send out soon.

Matt Sakai

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9518
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
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
>    */
>   static void drain_slab_depot(struct vdo_completion *completion)
>   {
> @@ -656,6 +657,7 @@ static void rebuild_reference_counts(struct vdo_completion *completion)
>   
>   /**
>    * increment_recovery_point() - Move the given recovery point forward by one entry.
> + * @point: The location of the next recovery journal entry to apply.
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


