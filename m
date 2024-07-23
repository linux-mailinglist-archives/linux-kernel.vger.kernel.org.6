Return-Path: <linux-kernel+bounces-259955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9735F93A077
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4E1B2208B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB2C152199;
	Tue, 23 Jul 2024 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VauhhvO0"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4915098E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721737219; cv=none; b=VpswsNQkdA7iEYPP5ZKUQ+QHDtSPrH2gy08FxU2hqZB/9Tu3KGPbAg3QiiYwfaBXggStLVu85jiJF3rcPAUJoS9KTQBtLnwTKDulT3EabpKmYDN8+OkqPEV4EI68zqDQkQ9mcCvkj+s1fYfSo2XuQXcnsFCQte1O7wGLdY5Y83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721737219; c=relaxed/simple;
	bh=SqwuROvAZDQ6b2XkeY1BmW7YIZ2vgXpgSss/ZiKtB20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UFog1cj8dMzPteG2mtgTS1S+oWk9DuED8gB2erC7EZeFCxiFiHvrrVBD2kK85nwLJBTyRX15DSIhBGsAGdp5P0nZ2XFO8BlRvD7wAIDb3i1noz1wCaGqtFq56TmJ/RQg5cWhw6Lh+xnq8aSUF2gbrWJzOXE55jFl9WYVfD6L418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VauhhvO0; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-381f24d6bc4so20986865ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721737216; x=1722342016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh5taMbBHiXTGHoFGWWcqu98S6fanaqHrjt+x7ZlGc8=;
        b=VauhhvO08F/8ZcWCc1zW5tdqbcZRvrQN/S2Jzvpn11y9DJrNHKwWcsxpNzlAgtlDQo
         FO9QpZfIoVHl+NTHblk4lEV6nQA/4ztJgWWu8QPKxSP/YUrTFqtDtZdpoDnrbz8D6OhH
         RjUULiH+usZzz4dHPmJpjN1JxIonh/+NwsF31cy7dNR2tGhYQkv2YUGD45GiHF0EPY+z
         0R1N0FGHnLiP/WPJi5sbZM6P4VfW5jLb91do/Ll7h3iA5EpmNWnJ/4ZFFAMYVxh5/5Hd
         g9TF6XnFni7yAn+terZ/shZkLlMBwR4i9ipKGxGHa8LiaCxWO0zsqB8+eXMD15vHY15Y
         8kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721737216; x=1722342016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xh5taMbBHiXTGHoFGWWcqu98S6fanaqHrjt+x7ZlGc8=;
        b=N8F9gFs0zbkoc5LPOXH+0AaLY4NUHGjxqYLbqYYiECFk5/kxaSWg+m+7KFcto43ln7
         Ubi4Cx73tX4V+MtlS8dWCYbCwEa/c/nGlQIgkFkTVAyEB9MFy053lWjs3hXNNOodoUc0
         s54Y92pLCViKOLTVIaC9Bp1gE5+dxqOveK13/6MWVWNtdc52/ELj48nJOg/tLlWxx38O
         i6Q64i1WlC5n4JFUUhLGUVZTqfiRZNJ5nVuCyP87P9ETckAy8d/JQQd4+i/Cqpt5pkSl
         Y0SdA3+y3EaOgU83mYl2RTfcv45YjoMhq2EJyghnj8Zh7o6w+5Btu7frtt3AHe0wjqxH
         rctQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJb7QVkgMtpRzBBQEvDKu4SVUDBOXu53RqHxctr5y6N/irRN4urkQwX060r4JZwzhPaAREREyyWDQZGVPipSN2hbCw6mCFb6c4j1Pi
X-Gm-Message-State: AOJu0Ywe8UJWXkKHER5v9Mafi+MDXlBeqPD2tomI38ON6BMAA3iUd0S9
	9eebj7a11PU3ujc/WuHHUPmqkiLvo+EU4RzmHuaw+wzKxjCmAM+uNVbwRbV6tR4=
X-Google-Smtp-Source: AGHT+IFFgsx4to4MDdNJTV8+KK6G2nuTATDYJ+nITWh3mzR+m8/1X4nzeRbyt+JnHQR+PScwpgrwkA==
X-Received: by 2002:a92:c54e:0:b0:375:e93b:7c8c with SMTP id e9e14a558f8ab-399403c30b0mr126129925ab.12.1721737216084;
        Tue, 23 Jul 2024 05:20:16 -0700 (PDT)
Received: from YGFVJ29LDD.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2820a945sm3261466b3a.74.2024.07.23.05.20.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jul 2024 05:20:15 -0700 (PDT)
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
	joshdon@google.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH v2 0/2] minor cpu bandwidth control fix
Date: Tue, 23 Jul 2024 20:20:04 +0800
Message-Id: <20240723122006.47053-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patchset tries to fix the minor issues in cpu bandwidthe control.

patch#1 tries to fix the inaccurate __cfs_bandwidth_used.
patch#2 tries to reduce the unnecessary overhead in
tg_set_cfs_bandwidth() observed in our production environment.

Please see individual patches for more details, and comments are always
welcome.

---
Changes in v2:
patch#1:
- guard(cpus_read_lock) before cfs_bandwidth_usage_dec() in
destroy_cfs_bandwidth().(Benjamin)
- do cfs_bandwidth_usage_dec after __cfsb_csd_unthrottle loop.(Benjamin)
- move the call to destroy_cfs_bandwidth() to cpu_cgroup_css_free
(Benjamin)
patch#2:
- move the check under cfs_constraints_mutex.(Chengming and Benjamin)
Link to v1:https://lore.kernel.org/lkml/20240721125208.5348-1-zhouchuyi@bytedance.com/

Chuyi Zhou (2):
  sched/fair: Decrease cfs bandwidth usage in task_group destruction
  sched/core: Avoid unnecessary update in tg_set_cfs_bandwidth

 kernel/sched/core.c  |  5 +++++
 kernel/sched/fair.c  | 13 +++++++------
 kernel/sched/sched.h |  2 ++
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.20.1


