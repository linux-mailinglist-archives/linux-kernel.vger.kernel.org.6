Return-Path: <linux-kernel+bounces-299506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC3695D5A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9805C1F238B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321EC1922C9;
	Fri, 23 Aug 2024 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4Seqf1u"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2888018BC30
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439526; cv=none; b=m7+mmt4o84nOPwOCiSGtGk/tN1y9PjQGB0HN3/i64TqJGzj6/SpF+7xjJ5dF682ExDDJa03KW3I3I1zfp13jS0JgspiTQ0rgQW4eoEFZZ9IDzTqCJkJbG4neWwo3GeFcKh/VafIslNaYwo2d8fa63BKawUULufL+AOvZKoqUHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439526; c=relaxed/simple;
	bh=WpGn+nUlue8CN62tkoAj7w2myAtMbdkUNyknJSAJaL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQQXvZ5g3R6yoc7RPFuZCo7EH6GMBtGwXYb2AX1MADKE23My96XJOMw1vGba0zjhFgR7gnIgWRGgM3HdLlkT7wfs3JhMTG5knttYEdqXJmzp1DB9Wgaj6UuNgRhjKcrOXx85eqZHLU8GpiJFiudsrUSG+hA4rHvp/bPCrcW1CXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4Seqf1u; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d5b850d969so1668469eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724439524; x=1725044324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TNFQOMqUw2y0jiSVG8w+iRNgSmXRkQBpvRyasYR7FWw=;
        b=d4Seqf1uvDe5DiaJOdGukRRmUh9GswPN/1/z1S0yzNxp9n0LpBN7EuTGkM94EHhoV+
         zW1OJEbdobEqUX3MK8zqMd+QHRDfN7B6epecLZC59rTU2eiFY4B+ScHZsbJ5KQtA9Gdj
         fCd6mfgBcm2HO27/0/fhx3+9+XxVu7u8g5sGnS5/bD/H9LzDWcFMuzVKOEbBgsfZwHfl
         BQ9jpvQ0yJ0HyeULtcP3Mr40xRMRl9qNgCO8lsYMsLbhhzGFZfLTTIadTHnkdl+RKEkh
         sXkL9EdSZdFBLVnNzQMCxgZbwnj/mPuMb+Kjq6YHJ+OmQBLmkr5D29sUZeM8qiPntJlX
         vETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724439524; x=1725044324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNFQOMqUw2y0jiSVG8w+iRNgSmXRkQBpvRyasYR7FWw=;
        b=aii0riMgJgkgOtJU/kdD9lAnseUXWeTZmB1BaNdb7WBv5htllOLBxkNW88gLVvxL81
         jSAZlybZD5jJzZ3wkSbXLSm1/b/GnJCI+mIlsqLHMS5OPEYuDayfVkeYNp+u4QFFuqq9
         ft8hzkDQ9RMQ7id+qKCNtWuRJszBUBGOWcfYAuZj/ulAOQc9vrWuRDuw8iCOV/Jqcsxw
         PSdUUsUbI8A7j8DhZluFOuhZsTnH8SAHNXcsf0yxrDDRuMKUaoIncERTAjP/kdtZxfbQ
         jwu1TigcxjURmzTNK6r9+OA2CBwehob2/4rpvKsMMDkYmVSxauUM905GFYENXIFtuSz7
         AoLw==
X-Forwarded-Encrypted: i=1; AJvYcCUXcxQHkSIj1eLDVLLKmaxaJ08ikhziVALQyuBRWX0xfeOH+g8EHMGyx7ZSz+iZQGCeg5NyDJkR1Ys0m7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCTnEiMIcUwB2JqX4fwOhic7QQTRQ1sAKbjt8ZNeWTVlW5mDc9
	xPJBOdHGXyYaI038t1CPfrp/T0lc2wIvHZ0yNLSGqIgSfsnNpsm8
X-Google-Smtp-Source: AGHT+IGKfQ0Md5g9XP+SfpH8bxHI4r/aR1OkHXP3WYpfk2ZpHhCI5Yj4RBgJ3NNIXi8lXvJYVtdX4Q==
X-Received: by 2002:a05:6358:52c3:b0:1a8:b066:e266 with SMTP id e5c5f4694b2df-1b5c215abdfmr416416455d.13.1724439523878;
        Fri, 23 Aug 2024 11:58:43 -0700 (PDT)
Received: from localhost (fwdproxy-ash-015.fbsv.net. [2a03:2880:20ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3181a2sm205977485a.2.2024.08.23.11.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:58:43 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	david@redhat.com,
	ying.huang@intel.com,
	hughd@google.com,
	willy@infradead.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v8 0/2] mm: store zero pages to be swapped out in a bitmap
Date: Fri, 23 Aug 2024 19:57:33 +0100
Message-ID: <20240823185838.939977-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original series [1] was almost merged, but was dropped
due to a last minute bug [2]. Resending this with the fix for it,
by handling zeromap in the same way as swap_map and cluster_info in
enable_swap_info, holding swapon_mutex and si->lock, hence avoiding
a race condition between swapon and any point where the lock is held.
This is the safest way.

The series had already been reviewed and acked.

Hoping that this attempt goes better than the initial one :)

This patchseries is based on top of mm-unstable from today:
4926e8348e10 - (akpm/mm-unstable) mm: optimization on page allocation when CMA enabled

[1] https://lore.kernel.org/all/20240627105730.3110705-1-usamaarif642@gmail.com/
[2] https://lore.kernel.org/all/202407101031.c6c3c651-lkp@intel.com/

Usama Arif (2):
  mm: store zero pages to be swapped out in a bitmap
  mm: remove code to handle same filled pages

 include/linux/swap.h |   1 +
 mm/page_io.c         | 118 ++++++++++++++++++++++++++++++++++++++++++-
 mm/swapfile.c        |  38 ++++++++++++--
 mm/zswap.c           |  85 +++----------------------------
 4 files changed, 159 insertions(+), 83 deletions(-)

-- 
2.43.5


