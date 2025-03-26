Return-Path: <linux-kernel+bounces-576851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2662AA71530
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFF8188BCFF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494D91D5CE5;
	Wed, 26 Mar 2025 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="ybCwoLqf"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316C51B412B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986761; cv=none; b=Di9wwD4KjMmYF62JfcO8Lv5YSZEJRsCwxtL8TvsUPX3nyxkoA8KYNqQ2W7X54AfKiUXLxc5bX2ToQwLA7jJOifw4lBSS7yd64ta/c76jXaiTL2M64pp9v6nk6CMLJtYLvAFWdgPNyEw5WY3oOYkQ4NAnGnHDCgIyRb9/E2VPKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986761; c=relaxed/simple;
	bh=uN1vr/Fb0iYszlHwQ7A2qkr2YXVD6KSqZVcwTPfuI+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OlRlT0cMqiSGQHwEX3iBkGfVa862o2MkQ4Jmvimm1va9t7GRXAj32MZvTpdEZ91xJqdE4yo4L1fErn1y5+lKxi/8Px8VgZQMy20QBwp1gMrIWKJelgKHWTyJ/Pl6eTwuy3YOZTIubg7oNC9GvsGrjcS8F9+SE0ZRfNglDcd9nOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=ybCwoLqf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso42005635e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1742986757; x=1743591557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkYrvJH8MLboZJYN3SET+tKv3pjaS9s/Q33mAFg+/Ks=;
        b=ybCwoLqfgz9r8ysTBw7NmfiRIHD5TC4BJGuoq3IVFmNOnEY012oZArULW5cake8jFK
         po4G+HZSz3Mh/74Y2FPDQ1NYVTOqvbm2ZU2IhnUhdRO4AlDiXtaV2pJSjGZsi2OfTEX+
         Dm0imzxUO78R7nE89UEivoMYLQCsbicet8CMlts2+f5ri4/76yngat11BkqPp5uwnmEy
         BlnFZvrS6eGOwqgi0LQiT+YfIoeApuQYOV7pOTk9nOmFOraSR4cxVk0uOShRXqyWLbTr
         H1SqcDmZcKrCVt45Aiv/1C6FeWZc5vTqghmLaGi0lCrdffev1H2wWgNhYn4ZXfXcrRKe
         v/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742986757; x=1743591557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkYrvJH8MLboZJYN3SET+tKv3pjaS9s/Q33mAFg+/Ks=;
        b=MoHa+pg9w+nD3Co3TVUcjISpiQ0Ru+F+7EODyoqlSJQ8Aadj86xwDmf7kLA4M8M1WU
         J60MYe/NB8KcI5WxOjOECU9dYJ6Ujt2Ond0TsWzWmwiefOu63r7UVbPXr7hrNXBZk0ee
         lhhya2LnjX2S/9iEflCchTYyEp3SfspxKWjxNvVUgrSgMX2M5beMZAupuUFx62CO8Y1z
         5XuEjECFgx3jyGC7p21aLDybXBQ0UOE8lU1js/5q/uefvvo5bJkaV7E3sUJPAc0kUETg
         kmFwDNrwCYaVshF6lUPIeNz9jaH23u1esXa8HVNJkHQ+xcXfi0Bm+j1OZ7iKoxPdZdhs
         w9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVeFuStM6y/JdUZMXe3wIRH+W8BMuLm34iTqeTqm1O6Ry9zTpTev3pUWSZzbv0bfx79VH2u1esAVIHOLtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/Cdo42+8m+EZ8sHwnsE7DYq+JgJidVwj17rp8rqCIdgNd6li
	+EXyVxAkMPsRfCBHWtOK7onaohWF34ItGTE1hxlh8oUFencHY6RsXckIq4a++SU=
X-Gm-Gg: ASbGncvhbG1XyqNwrWKuEURsjHfFVqXZv1uHRvmr9OMxVBQlzsMO8+ODcJE/VpuufeX
	fJeqys+Nv9BpvAafkJORUlXOwX9ckR5ZHggZb5CaUMhcROfMMvRfTR3b20OHoClA6eGi0vXWDy/
	+kyrzmV6AXI8dC/5ff48yJ7PIFgx1GtcgQPsDcDBeE/ZDdL2iPr3diqss7LWMYU1/cy59AuOy02
	eO8A7+toRq/CwVS8U1GmVnnrjZbQJiVsKNUzAmlRiBnATDdLKMBudmdfKkTCF/IbKXh8QVA0zcx
	8J7ZOXgt1lkIp/kfGywPu0qEoWMoJ1q7ny4QoUqqu8/+gh3f
X-Google-Smtp-Source: AGHT+IGsynMjLeM6MvbAOiFyQWhOSUi+GKcc6H4q6k5SLyMO29JdoL407k9GE1BOdU9b67T9vRhDlw==
X-Received: by 2002:a5d:6d86:0:b0:38d:d701:419c with SMTP id ffacd0b85a97d-3997f92da9amr21706605f8f.41.1742986757289;
        Wed, 26 Mar 2025 03:59:17 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:28e0:840::179:137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f99540bsm16374900f8f.2.2025.03.26.03.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 03:59:16 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: willy@infradead.org
Cc: adilger.kernel@dilger.ca,
	akpm@linux-foundation.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	luka.2016.cs@gmail.com,
	tytso@mit.edu,
	Barry Song <baohua@kernel.org>,
	kernel-team@cloudflare.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: Potential Linux Crash: WARNING in ext4_dirty_folio in Linux kernel v6.13-rc5
Date: Wed, 26 Mar 2025 10:59:14 +0000
Message-Id: <20250326105914.3803197-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z8kvDz70Wjh5By7c@casper.infradead.org>
References: <Z8kvDz70Wjh5By7c@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Mar 06, 2025 at 05:13:51 +0000, Matthew wrote:
> This is the exact same problem I just analysed for you.  Except this
> time it's ext4 rather than FAT.
>
> https://lore.kernel.org/linux-mm/Z8kuWyqj8cS-stKA@casper.infradead.org/
> for the benefit of the ext4 people who're just finding out about this.

Hi there,

I'm also seeing this PF_MEMALLOC WARN triggered from kswapd in 6.12.19.

Does overlayfs need some kind of background inode reclaim support?

  Call Trace:
   <TASK>
   __alloc_pages_noprof+0x31c/0x330
   alloc_pages_mpol_noprof+0xe3/0x1d0
   folio_alloc_noprof+0x5b/0xa0
   __filemap_get_folio+0x1f3/0x380
   __getblk_slow+0xa3/0x1e0
   __ext4_get_inode_loc+0x121/0x4b0
   ext4_get_inode_loc+0x40/0xa0
   ext4_reserve_inode_write+0x39/0xc0
   __ext4_mark_inode_dirty+0x5b/0x220
   ext4_evict_inode+0x26d/0x690
   evict+0x112/0x2a0
   __dentry_kill+0x71/0x180
   dput+0xeb/0x1b0
   ovl_stack_put+0x2e/0x50 [overlay]
   ovl_destroy_inode+0x3a/0x60 [overlay]
   destroy_inode+0x3b/0x70
   __dentry_kill+0x71/0x180
   shrink_dentry_list+0x6b/0xe0
   prune_dcache_sb+0x56/0x80
   super_cache_scan+0x12c/0x1e0
   do_shrink_slab+0x13b/0x350
   shrink_slab+0x278/0x3a0
   shrink_node+0x328/0x880
   balance_pgdat+0x36d/0x740
   kswapd+0x1f0/0x380
   kthread+0xd2/0x100
   ret_from_fork+0x34/0x50
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Thanks,
Matt

