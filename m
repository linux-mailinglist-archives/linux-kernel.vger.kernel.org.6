Return-Path: <linux-kernel+bounces-406404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8B49C5E96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7901F21B45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EE520A5C7;
	Tue, 12 Nov 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2hn4gktA"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963821500E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431599; cv=none; b=drujGcvoHg92KFslI4T8ow3+QxB740OjH0pmPBSYg9Col6COnDfOEaePvIxGMlyuKwC0Zo33HrPDMIygOnIbYhw0wszT00Nordi/EoDc4UMxgLd9M29UAOxHnWGYbBzm8AHPSom4SvzwmvYjIKSCFHGLPxgFqhNKF8d6xgInCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431599; c=relaxed/simple;
	bh=OaIUNL4wDulYBWCeL52yflc/neDWNsACf3HqYi4lxlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/mzlBVR+qj1vecgopGUc2DRjXDQZSRhQ625rQr4KDR8IuKzbZKuR6fo8fuEZPEhHiBrDK2AFjHxZPNZjVx7cO0jFRUjNk3zF5a7A6nCLw8MMcLAjWMDHN89JOTz8dcT30fo74CtaqSWsY0ueQqdp3Q0UYC6aFRMVAXHF2OOztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2hn4gktA; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e601b6a33aso3468845b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731431595; x=1732036395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hhFc34QUIUtRmxEJib4/H+5a4T4gZgtNawOMUenBu5s=;
        b=2hn4gktAu2bXg6QIK5HzUibtinBzYRFPoxDow1f3UmHelR9UGv5coMHakweqRMRIym
         kp3Ga015gohmr3A+IxrgVH8dnCo2csTaFvWUMf81Ti2IrCbc/yMHzg5YN6HLaaj5a1X8
         uznE2I9ayKEqXMbOkk4WKO+VkjGNDtd/OMJO64X6kiWttBuYwnCbBZ9F8g9YJRdr8Nz3
         5yEy6F+lSNbK591sinNhYy6uUXmevNJLAvuMtADMuYMdCLGyeQBNsEua/OiHiT8VjBI0
         BPdne/u4wIOZgLshPcZj9bHOYCn0Oj5an4xIpV3/yo0Yjz5h63XMyTXfGrRHxR5wUuaS
         QIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731431595; x=1732036395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhFc34QUIUtRmxEJib4/H+5a4T4gZgtNawOMUenBu5s=;
        b=FN4bh7MRo7hrqfZVNR/BG7W/t0Hcl47kAunSD+r2vyeWNWES/n3d+rRDLKDqAH8DEs
         EYNmkqkeAjHVjcpuHb+LQr63ZvcXP7djdFDPqKtTps9QCbcvdfpz52lDIWL+sru5pPo/
         s9vtLuRygtttyMWbsCqArDSjzbbl+Vo7y+w5uC+5qJBFPqLV1+z5Si6NknemSUe1TZXS
         Knt+/CninwRaGT0XE3XYhAO+jYI6x5rrR0TGXYY1oEoaje+PN+HcrdvfDQU092MZgab8
         pNrPB3KZcQIOsuc2CXBdAdnImjUGGCUcCxgk3tjMbyI/DevkbKbEQJc/k0MjhTSiYyTh
         0lAw==
X-Forwarded-Encrypted: i=1; AJvYcCV1ZAIDrNNI795foMfP/GZrOC42I7HPM4bkJ0+n5WoBqgCsaDn+GEBIXI6q52U9ruq2InSdDUMsfouADb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9H3I5j9OLz0/sPYTDsCji/A8s66RBBVNvcZL/zcghJW2f/+Y8
	zOdfpq0j5C051YGRoZrNpiXAsfMWeiMzSRTucZB1/pqWk3OcZvdd+S8jGp1/sAA=
X-Google-Smtp-Source: AGHT+IH644V99dOVg147q96OR3GJtIRC7XpOTmFUI9LGtr4TxaaFP6x3xC1BuVau04Ao7iJOTmXH6w==
X-Received: by 2002:a05:6808:10c9:b0:3e6:60dc:5aee with SMTP id 5614622812f47-3e794654540mr13513708b6e.3.1731431594747;
        Tue, 12 Nov 2024 09:13:14 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cca37c9sm2630818b6e.21.2024.11.12.09.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 09:13:14 -0800 (PST)
Message-ID: <df2b9a81-3ebd-48fe-a205-2d4007fe73d1@kernel.dk>
Date: Tue, 12 Nov 2024 10:13:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] ext4: add RWF_UNCACHED write support
To: Brian Foster <bfoster@redhat.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-13-axboe@kernel.dk> <ZzOD_qV5tpv9nbw7@bfoster>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzOD_qV5tpv9nbw7@bfoster>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 9:36 AM, Brian Foster wrote:
> On Mon, Nov 11, 2024 at 04:37:39PM -0700, Jens Axboe wrote:
>> IOCB_UNCACHED IO needs to prune writeback regions on IO completion,
>> and hence need the worker punt that ext4 also does for unwritten
>> extents. Add an io_end flag to manage that.
>>
>> If foliop is set to foliop_uncached in ext4_write_begin(), then set
>> FGP_UNCACHED so that __filemap_get_folio() will mark newly created
>> folios as uncached. That in turn will make writeback completion drop
>> these ranges from the page cache.
>>
>> Now that ext4 supports both uncached reads and writes, add the fop_flag
>> FOP_UNCACHED to enable it.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/ext4/ext4.h    |  1 +
>>  fs/ext4/file.c    |  2 +-
>>  fs/ext4/inline.c  |  7 ++++++-
>>  fs/ext4/inode.c   | 18 ++++++++++++++++--
>>  fs/ext4/page-io.c | 28 ++++++++++++++++------------
>>  5 files changed, 40 insertions(+), 16 deletions(-)
>>
> ...
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 54bdd4884fe6..afae3ab64c9e 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -1138,6 +1138,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>>  	int ret, needed_blocks;
>>  	handle_t *handle;
>>  	int retries = 0;
>> +	fgf_t fgp_flags;
>>  	struct folio *folio;
>>  	pgoff_t index;
>>  	unsigned from, to;
>> @@ -1164,6 +1165,15 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>>  			return 0;
>>  	}
>>  
>> +	/*
>> +	 * Set FGP_WRITEBEGIN, and FGP_UNCACHED if foliop contains
>> +	 * foliop_uncached. That's how generic_perform_write() informs us
>> +	 * that this is an uncached write.
>> +	 */
>> +	fgp_flags = FGP_WRITEBEGIN;
>> +	if (*foliop == foliop_uncached)
>> +		fgp_flags |= FGP_UNCACHED;
>> +
>>  	/*
>>  	 * __filemap_get_folio() can take a long time if the
>>  	 * system is thrashing due to memory pressure, or if the folio
>> @@ -1172,7 +1182,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>>  	 * the folio (if needed) without using GFP_NOFS.
>>  	 */
>>  retry_grab:
>> -	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
>> +	folio = __filemap_get_folio(mapping, index, fgp_flags,
>>  					mapping_gfp_mask(mapping));
>>  	if (IS_ERR(folio))
>>  		return PTR_ERR(folio);
> 
> JFYI, I notice that ext4 cycles the folio lock here in this path and
> thus follows up with a couple checks presumably to accommodate that. One
> is whether i_mapping has changed, which I assume means uncached state
> would have been handled/cleared externally somewhere..? I.e., if an
> uncached folio is somehow truncated/freed without ever having been
> written back?
> 
> The next is a folio_wait_stable() call "in case writeback began ..."
> It's not immediately clear to me if that is possible here, but taking
> that at face value, is it an issue if we were to create an uncached
> folio, drop the folio lock, then have some other task dirty and
> writeback the folio (due to a sync write or something), then have
> writeback completion invalidate the folio before we relock it here?

I don't either of those are an issue. The UNCACHED flag will only be set
on a newly created folio, it does not get inherited for folios that
already exist.

-- 
Jens Axboe

