Return-Path: <linux-kernel+bounces-402567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FAF9C291D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8DCEB2289E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583DE1E885;
	Sat,  9 Nov 2024 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="WGY/IeQd"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC5853A7
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731115736; cv=none; b=YHI1XZhMmit3dlTbBHNfRkc2YAkfu3NyLAhHt/KWGCz3YZZTptu80+DZ/qTeYBcWPiRDTrQz7y57rn0lIJNOk4pWuNIjGN94qEEJy3yOkLA/syGvvkfXuL8hC829/g9qmCW1xquFbLqK4SF/ZHVRrGOaF0XTRUt/GvaLC5ChMWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731115736; c=relaxed/simple;
	bh=S7l/q9ce6B70UtagH9ZI/CwZva41DnVk8Rgp0ZOvS9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADYBk8P0kIUnlW0UhKGYIRPyGnUA4IhwqdIH1JaTSoRaTo6Eaa4+dcwrW/VtxNk85o+GJ2ZKET3YwBvHxIjdDzsX8pgRrbrpwC8c8d/tl7rLvqJWbfUuyujXzn+jtMOV5d/n4cNX4Kn1jCBCkd0S1L7CBJOGxf7PmMVx/AC7whE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=WGY/IeQd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cafd36ed0so5595ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 17:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1731115734; x=1731720534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwEl8GsKdt5LD7sdpCLGjkpMXEHijXkBuIdcnGAtpRU=;
        b=WGY/IeQd1p8jhWTaa3gd8fiBC/damkck9AV4h98cY5ySLTHVI9IastDfB4L3VChwCK
         nUEIqgUIEvFN00DUvdXZN+3OJz6sCEsW3ZHgBHozF3V40ZJ2oOmmmwPTUTBnGvu0j5rh
         YqlxZQv5OkfRGOXn5jj+18X0K3KdcAi9DrpUc+7v/xcwXeFUUJUwKjN/CPiK6to4gLjl
         d7e8pNlLeX074HT/SJEHLgTq6lFsI/j6L8JCj3F7r3eH/pwo3N4sK0Ev+Kt/nBGuMSjc
         zmsptodlhVyJU1/dFtSnJQtWFmpGwh/FA4nO6mib0wWedtCBUV3ndPovN5ldZ9BSQaYB
         rfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731115734; x=1731720534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwEl8GsKdt5LD7sdpCLGjkpMXEHijXkBuIdcnGAtpRU=;
        b=tSZqaXhX2rHNhNWXrOy/OU+xbN/xhrVJOqR/DC/bBSaX+vd/ZPOqlEgN4gEut01EQW
         nkMSbcuQeM2TTBPxoge/8OKPwavfWThHXHRtvVL5C46HXNgIHJgVq0pJIeMHxbEBAUxr
         UU6yw/67WuPFF13LWYd/iKR5AMI5TkfyWzrAZSBD1ZJC4GTxmqx9J7/kgiXKgyJeRCG3
         YIJ+BdWjPjFejMcgjw8kMvLHjy1z3lBcU4o7ofkdQh2oHXTe6f/Zqw8NRdwrylq3Ok1Q
         0bEyr6a7sM1S0sOxIFJbPwyHdF5jLMVTsYhVRs18v/P2AXiaLq2rwjutMBfRmAkmcf9i
         z3hQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4F39eU2CLY4mVNzSyT2nowEwo9t4VsEKMuBnBS49UpJVCNEjCdgRWA6KXJpZiu6ySV9hrE3yqV81D+F8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxx0OGcgh1dxmAKbtBBOG38OGD295Hq072AtiMdiPWtmmtZNhk
	2wafwL/K6uC1lzdd9fFjPhLIeem0HFs4hHSVqWtwIN1jK7HAmAbk6zUh7oHKUFU=
X-Google-Smtp-Source: AGHT+IH1C6F18P5gAn7O7mTkZhrmkAbwdmt7AndSjK8MgbU5UzBqmqb9BAA1tfKRisdS+woxT304OQ==
X-Received: by 2002:a17:902:ecd0:b0:20c:ee32:7595 with SMTP id d9443c01a7336-211834de6d9mr27902895ad.2.1731115734503;
        Fri, 08 Nov 2024 17:28:54 -0800 (PST)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::5633])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c96fsm37493355ad.255.2024.11.08.17.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 17:28:53 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: kernel-team@fb.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] proc/kcore: performance optimizations
Date: Fri,  8 Nov 2024 17:28:38 -0800
Message-ID: <cover.1731115587.git.osandov@fb.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

Hi,

The performance of /proc/kcore reads has been showing up as a bottleneck
for drgn. drgn scripts often spend ~25% of their time in the kernel
reading from /proc/kcore.

A lot of this overhead comes from silly inefficiencies. This patch
series fixes the low-hanging fruit. The fixes are all fairly small and
straightforward. The result is a 25% improvement in read latency in
micro-benchmarks (from ~235 nanoseconds to ~175) and a 15% improvement
in execution time for real-world drgn scripts.

Since I have a stake in /proc/kcore and have modified it several times,
the final patch volunteers me to maintain it.

Thanks,
Omar

Omar Sandoval (4):
  proc/kcore: mark proc entry as permanent
  proc/kcore: don't walk list on every read
  proc/kcore: use percpu_rw_semaphore for kclist_lock
  MAINTAINERS: add me as /proc/kcore maintainer

 MAINTAINERS     |  7 +++++
 fs/proc/kcore.c | 81 +++++++++++++++++++++++++------------------------
 2 files changed, 48 insertions(+), 40 deletions(-)

-- 
2.47.0


