Return-Path: <linux-kernel+bounces-384094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8E79B2433
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D9D1C21153
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 05:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DB618E02A;
	Mon, 28 Oct 2024 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1ueNAYsZ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601B18DF87
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093433; cv=none; b=rfGulmSzkKyC+n5gLZFiqwgre5D+TI0sp34Vgb25j+MVc+84SKxg785gr+15WJvgtrVAyv6XmI/BFKzgVwuFXt/oQ9NwvjIrim4n89qOe2qaLPEHhVDkuBLTfa3eq7+vAdTripRV2iaRFzynVowN581Qh5tcWbbpbHs5ltpP1HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093433; c=relaxed/simple;
	bh=8dgVrA01u419c7Y5AQ8A9t0dwMRALJzDlvOUroUnaqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyutt5IcDbmOuKeEMM9aHlaOCmpHKy3ozhFZYvnt3gPTG5c5jKUr7XGDa3oRg1F1fDe/qNLZ10AldkQiIcK6MbUVpigeYJvF93hbxM1fNkJCqBKZOwweZ2hpOgG2YruPA0y9uhetHCQgMP2RFWtR1PVs9Tb1G5nriOm6PpFPaDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1ueNAYsZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c714cd9c8so37245155ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 22:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1730093431; x=1730698231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1YSOeVXzEwF1sm652ZwAqo5z9JPJsNseJdyz5eSkEs=;
        b=1ueNAYsZD8FSxKy+nVfL6n71k2SGwcnWrrjo5Z4a7SA/HYSTI5jJWdcMoU8Iu590o9
         T1o8GbJM/TAZEn5Qa62No9nRaSSAYbhbjIZVM7V1b8pYiZO/A2o6lxollCJOMW6AjK5C
         xbBe0Ptw8KNlTgE4j4qxPn/tLmJEUJs8oGNjbNXxie6j4vX2rK86CkEQcNru1pMRFeIR
         fgP44QbAedU4r20A7TSxuWYCINfViYxkhv+KTo6G9p64QK99Dr+CK0WgghYw/JFKnAof
         jGpnse9PkiiIL6hc36AdeJKoXIys9Ww7D66OmoUcu7Vd7RldJrLJehPybjSEk88MeZ1F
         KeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730093431; x=1730698231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1YSOeVXzEwF1sm652ZwAqo5z9JPJsNseJdyz5eSkEs=;
        b=omwwfRrSUrJpZTc4C4zeKZYzJDCretgttjLn4xblzCo+D0AQVN+0xAKjfJQpSJPM8F
         3hoi5cKhpYxpSerA3oBWith7wZPZiWKOBS2Ld3BlhFuAgR3he9Skaro4b3hArdIrO5OC
         xcJwCT4dvbxLdApVJQUy/2BHarudeDWetEIhPvL7DoyQsnBcrwdFbzSGBCaHTryX/7cU
         gzTVVq5w+upab7sGMZA/U+0/L3qPe+Jeaus+bsYIgj/xpibJzwvtNsZcY3dXD8oPh3kD
         9QC3mMixEljOK2zMXbT5+CjRyuHv9jZBZa7QcVLXCYYVPRHhLZOdvqIoWtu4FpGJND5u
         7bwg==
X-Forwarded-Encrypted: i=1; AJvYcCVwbN0yFUfVnE6leNmHy8Lrz5fElDstq/eTtdd9RMCFr/pGvvqLc47RwGYlOsjLDRZ1FtGJgRgrOX93LJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfgiEp9FK8Je9ACjP70N1tNdu7Z/cism3y/cX+lIcCGKvvZOET
	OOtiWUtbr4yZZf5fLRZl93HzmppWj083wxQ4akxVR5Vkt4HPrm6L4BVOIqvhZbtzktGKvn4LMS5
	P
X-Google-Smtp-Source: AGHT+IE/Q+7tT9+yHYQZQbf65R5+ohgNP16VI/zt5o1urAhuVw7IbOnCCkLes/ksFMkDVDZUTrEcgA==
X-Received: by 2002:a17:903:32c4:b0:20c:a1a3:5373 with SMTP id d9443c01a7336-210c6c90e6cmr92968105ad.55.1730093430690;
        Sun, 27 Oct 2024 22:30:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc0133cdsm43303065ad.154.2024.10.27.22.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 22:30:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t5IKh-006mqT-2E;
	Mon, 28 Oct 2024 16:30:27 +1100
Date: Mon, 28 Oct 2024 16:30:27 +1100
From: Dave Chinner <david@fromorbit.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, zhengqi.arch@bytedance.com,
	roman.gushchin@linux.dev, muchun.song@linux.dev,
	anshuman.khandual@arm.com, vbabka@suse.cz, kirill@shutemov.name,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v3] mm: shrinker: avoid memleak in alloc_shrinker_info
Message-ID: <Zx8hc/KXT491V1Bz@dread.disaster.area>
References: <20241025060942.1049263-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025060942.1049263-1-chenridong@huaweicloud.com>

On Fri, Oct 25, 2024 at 06:09:42AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A memleak was found as bellow:
> 
> unreferenced object 0xffff8881010d2a80 (size 32):
>   comm "mkdir", pid 1559, jiffies 4294932666
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>   backtrace (crc 2e7ef6fa):
>     [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>     [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>     [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>     [<ffffffff81198dd9>] online_css+0x29/0xa0
>     [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>     [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>     [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>     [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>     [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>     [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>     [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>     [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> In the alloc_shrinker_info function, when shrinker_unit_alloc return
> err, the info won't be freed. Just fix it.
> 
> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

