Return-Path: <linux-kernel+bounces-447317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9B29F307B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA68016478E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969E7204C0A;
	Mon, 16 Dec 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T5xMC8O7"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A798202F97
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351857; cv=none; b=OdxNPh6rUIsdyPBhPRThNa1efP6pxwwXsMSHXQgmLx83F7oWyAR8jX3X+WuzZ343jX86I/LZ8hC6Wl9oVmaGMJXOSfM9tu8KAxLOUWrMBJFjIyDGV0Q71+Ocxsua9dkmUfhDU/cbAEop6LBwDcIItzQb8Or8r16K7cV6lX33eWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351857; c=relaxed/simple;
	bh=e3fD9Uu2bHGRHDCL1XRtLVXAadJD6E5B/W0M1rZ54yA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PMXYuYZWXpoEGZQB6Fy9WKPHC5gZP2MyyhzxNEBqeJJfyBSK0ZE86ctuK8lfVsH9SUu2ZM9v5mtu5jtH1PQLxaJcaPhMZjYm/Zp/x54zG5IcP4PwuaqPbYhsiqTH8HEMrreZ2u+9DQPftJtwFktGYpvfKXDV6EFHAn1JcTqiy8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T5xMC8O7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21619108a6bso29041605ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734351855; x=1734956655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yXwwiu4jqsqN1IwxG3iPAfNakfVj3D2KirisAa1dDps=;
        b=T5xMC8O7RlNylOw143Gkyp0E5RpcvFXbOr2SnSOfYXUosgTgxnt1uHWkm6r3nEdbr2
         var4gOA0z9j2qHEspoWeH03JiOc1FqSU2OY1sflwliI9q8+d/39p+PLVVzb7O8bC9Y3p
         qOBoHMhWCDLI7Qx/w98R6CR41kh0YKLmt66CqeFBLdOaCoQZdTa5JK5Ocm1+h8X1KAgq
         ZgS8OohwL6PkUQTeVZG53uG3c3lrZmA2PH4qXrLCnRBs/+f138XTkzJHk3G7XAxKJESO
         N0TG+vwIFGGDuPE1XQ1+uCSSeHrYqpsJVc9WXT0IvX0/TbHNjwv+bIWJ3Wskze6S1bfx
         HoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734351855; x=1734956655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXwwiu4jqsqN1IwxG3iPAfNakfVj3D2KirisAa1dDps=;
        b=Kf0RgyworJ41KKkZ8yPnEsZMHWPcjavlvGrdePT8O2Xm0koE7QWPdgddi8o39VCnQk
         KdI9wjw4EXs3Wor/Wbm/KmiJ2ify+mBKsJJJLZ9WGCpUHDvLKdINmav8aaXjxvybt/OK
         mJ7E+5kmPceaUWQNO1e773HxjI86njwYqQwfiJjAOFD1BfPwqh4MXeUiZlVyw3XKxQYS
         4lTgcg1ESLq6FZMxI3+On/iIpmsqtGBPxlhU++2hClsHFmXXerg6DD1RUkx2AV/ufLsI
         ppWkWY72NdDctLvAKxVr8ZMZ6mMoUFdeBUPyURucAeEP8QKGM9Xbn4YiJGOuJBHxd3nP
         jbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ47RfP7gGll0+6S4h7X8yiuTUv89ogLXEPmqOz101SDRgQS3e5LPeaRvOLloIZCO8PgQ1NX02x5unpN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjoLSi7c3l99kF4r6iiFswGf4LcKWQrp5hRjxsSfO9Qn7nY7a+
	jWVWyz+rXFXElf1C5kq2Mopsx87AVH1l3RZY4LuzCbPuCLZu+u2/28+qWon4kpg=
X-Gm-Gg: ASbGncs3hO8k2ZZ6PT4GeRDPA5zr8tpYix1a2Rkol54llrmeLAnJ/5A8jYVlASYR/eC
	Q/eYD+gugBIpPS4bwvkfW3y2Jz/pwf9l25iQ9MKgfL0TlR6RvEXZ2E7K9NiP/zMidQTrqCgvBxS
	zVLyGKtI6QxJnUTY3N6DpHBE8QMQPQGcGsbVorEtUb33swqdvfbInXAESQ+vaAHXNUTIk4sLrvK
	Ev3CD4LUFmtbuqNaX3Mqd0HwwhB5lS+gjJYnSvIZdCLRg1kTGDqKiqEdvMT2TjFhfSiBFIj23Aq
X-Google-Smtp-Source: AGHT+IHG8p306LNcNzHDH+iekhKTZsuWGSQ/aQzSUWAjDa3+M5pGj9h5OpI30iQTb1ZV9ZSMj/AIzA==
X-Received: by 2002:a17:903:284:b0:216:7cbf:9500 with SMTP id d9443c01a7336-21892982324mr156860775ad.6.1734351854772;
        Mon, 16 Dec 2024 04:24:14 -0800 (PST)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6d0e4sm41501555ad.261.2024.12.16.04.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 04:24:14 -0800 (PST)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH 0/3] Take the scheduling domain into account in numa balancing
Date: Mon, 16 Dec 2024 20:23:54 +0800
Message-Id: <20241216122357.1276382-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset tries to adjust the logic of handling isolate cpus in numa balancing.

patch#1: Clean up for task_numa_migrate().

patch#2: Skips the isolate cpus when gathering numa status and finding
idle cpus in update_numa_stats().

patch#3: Ensure that we do not select an isolated CPU in
task_numa_find_cpu(), even if it is present in the task's CPU mask.

Chuyi Zhou (3):
  sched/fair: Remove unused task_numa_migrate return value
  sched/fair: Ignore isolated cpus in update_numa_stat
  sched/fair: Ensure select housekeeping cpus in task_numa_find_cpu

 kernel/sched/fair.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

-- 
2.20.1


