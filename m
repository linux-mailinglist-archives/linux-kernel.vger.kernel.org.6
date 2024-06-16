Return-Path: <linux-kernel+bounces-216487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F47909FF8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 23:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E721F21679
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 21:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1CE6A33F;
	Sun, 16 Jun 2024 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U1bpNWzT"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE141849
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718573457; cv=none; b=dbuadr0CnKXsICkNzaen9kDwL/vyufWe3U8CbGW3A4UN7+qOHHWfkoVT9pG+yRZib4OWj64NaEhBm3yVIOq080slkcBhul1ExU07qlpXBg5MJSxjaPjFbiHlCnYsViVKfmGVmMM0YDSwNHTkL1f8vuGSnIhmoDcoAGJgz2yi4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718573457; c=relaxed/simple;
	bh=FIKoZwBEvvITzeAEwHf9UM0IMTE3gBDTcnLA/ddszps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hLfkTotKIdWA0Y6rj7F6oPctBBZgP/T3lotXVkeQixI2z6QCz02Ubt6JSURAlEqWdc5hUPFlt4XVgL6LAFbHPCrW6WERBMPOUFebvo/jghi2cLKi6bFAIeRtzEIIsGV28mrcVdcvKKZPvIP5wzfGV7C0ZDA/X3u7iNjdyEoeBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U1bpNWzT; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c036a14583so716181a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 14:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718573453; x=1719178253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQhrXwUi+OvcUMAXue/hmuLunIoA1lw15kWxV8BcvyU=;
        b=U1bpNWzTRjLH+7/053HSeTIiTQKgbAxHVFZQP3cZMwxxjMvfSjICqkbVuZfe/aqeeq
         Q87XFw/gC5a4tWjq69/2budA0hWWTJ7xX+TuGP3u2pNXuF3pB81x8i8tE2LbfkHUjst3
         EAB4cbUfJn54h4k+qKKFkx9zwKSfG6s6QcS3iPeyqRxTw2ENdzivLjuGWI/6+dxksNM1
         A+evYltWAdUSayqu6v7Zrp/H/gzgMYeimqxkz+Le+J9bipZt994HZFT2cQ3r7SeqhdKq
         amWUILORuQtQJAnvc3F2bH3qZiUIZXFRtRM1xkm/5D+TW5iIhn1ZhDa2cHozQwvlnnpj
         LIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718573453; x=1719178253;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQhrXwUi+OvcUMAXue/hmuLunIoA1lw15kWxV8BcvyU=;
        b=acwMckVK6vvsX6Lf1lNhy/DIkZ2unFQywU/3ZMjAfjp3TU472XYuh/YmMgEuTX6dFM
         s3sjJz77zX11EL1CvMMeWUx4PxaQbGW6zJJAl3Yf8uNsdmYy++DcnLNy1chDb0CSqZz2
         OVXcKxGlKIBQEyhMWPnxABdNsVFC1beOuBu8h2wKZwr/p/mxuTYNgq4fC503L3oaigr9
         EVjF0hANfpu1AjzDJZVtS8KPvwWGjh9HCn3phZL0NOQHxPtwZg8/Zm0aPSquila39Qfg
         Lpe/o2Inr903Q24OZ6uCcsT0zLsmUW4a3NTr0exltZkGngKnJ3e3vG8X8gc6CAZM/OJW
         BuEg==
X-Forwarded-Encrypted: i=1; AJvYcCWliFzfpR8IHNlu4tv84RyX4ZBx91vIQa01Iajs608+XtBokbHUAYtvWYUWwuajZqH41olnXAg+JU0Td1GTIWolgWW7Y4feD6MGbATF
X-Gm-Message-State: AOJu0YwCi3TXYKd6Rp1/in6VZvpElB3SK9AST4ApmRryV5/HMkGXQQyX
	xvHeBON+dpVp2VVFS2MUfy62UgIMwOOUMDrHzRaD7BhgUhW3N+yB/QG2X4rfd1s=
X-Google-Smtp-Source: AGHT+IE4hzpSWBVBfSDYsNo/W5vH/86czlhT5zRgnZoFcPfJy/8xeB1f14SB8dEZkLpYN5NNo/SXEw==
X-Received: by 2002:a17:902:eccc:b0:1f7:1a37:d0b5 with SMTP id d9443c01a7336-1f862c30f6amr97176705ad.4.1718573453246;
        Sun, 16 Jun 2024 14:30:53 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e71a15sm68092885ad.83.2024.06.16.14.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 14:30:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: paolo.valente@unimore.it, John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 jiapeng.chong@linux.alibaba.com, hch@lst.de
In-Reply-To: <20240614090345.655716-1-john.g.garry@oracle.com>
References: <20240614090345.655716-1-john.g.garry@oracle.com>
Subject: Re: [PATCH 0/3] Some block sparse fixes
Message-Id: <171857345207.18332.15693298636377250623.b4-ty@kernel.dk>
Date: Sun, 16 Jun 2024 15:30:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0-rc0


On Fri, 14 Jun 2024 09:03:42 +0000, John Garry wrote:
> Branches for-6.11/block and block-6.10 both have the following sparse
> build issues:
> 
> block/bdev.c:388:17: warning: symbol 'blockdev_mnt' was not declared.
> Should it be static?
> block/blk-settings.c:266:9: warning: context imbalance in
> 'queue_limits_commit_update' - wrong count at exit
> block/blk-cgroup.c:834:5: warning: context imbalance in
> 'blkg_conf_prep' - wrong count at exit
> block/blk-cgroup.c:965:9: warning: context imbalance in
> 'blkg_conf_exit' - wrong count at exit
> block/blk-iocost.c:732:9: warning: context imbalance in 'iocg_lock' -
> wrong count at exit
> block/blk-iocost.c:743:28: warning: context imbalance in 'iocg_unlock'
> - unexpected unlock
> block/blk-zoned.c:595:30: warning: context imbalance in
> 'disk_get_and_lock_zone_wplug' - wrong count at exit
> block/blk-zoned.c: note: in included file (through include/linux/blkdev.h):
> ./include/linux/bio.h:592:9: warning: context imbalance in
> 'blk_zone_wplug_handle_write' - unexpected unlock
> block/blk-zoned.c:1747:31: warning: context imbalance in
> 'blk_revalidate_seq_zone' - unexpected unlock
> block/bfq-iosched.c:5498:9: warning: context imbalance in
> 'bfq_exit_icq' - different lock contexts for basic block
> 
> [...]

Applied, thanks!

[1/3] bdev: make blockdev_mnt static
      commit: d9c2332199d073c5edd7163d64fbdee6224d8c08
[2/3] block: Drop locking annotation for limits_lock
      commit: c3042a5403ef2be622023fcc3b11fc1aa08ba7fa
[3/3] block: BFQ: Refactor bfq_exit_icq() to silence sparse warning
      commit: 66088084fdabb6e5075cd19e8ffe15b8bc7e3708

Best regards,
-- 
Jens Axboe




