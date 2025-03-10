Return-Path: <linux-kernel+bounces-554747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AD2A59BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0E43A6038
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188E422D786;
	Mon, 10 Mar 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N+oJanIg"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D66422D7AD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626299; cv=none; b=KthT7VGyrARiscP5ive3OeqDMVaS87c0SUGahjC+fgJMr4rybJiEQerQdaim4nK3THH2wDHVpfDU1P20WKCL3JGP9oaqGYXzV8nnXLwmkgCeRvhdij9GfnsrXL3krQDVQMT6M0mbWVQ/Df/n1a7/pe0XeA9enPZQNXHFcLMbl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626299; c=relaxed/simple;
	bh=nXDpJfEVYBLWpKkKXDr0/wztF3N/rbV4yP3I2doI6lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZZsJ7fdAFwmQSk++SsN8eNdtPyKNojOEY7gA7dASr/B09fL0ai4AOi+mozC0oKq2ihd4J7Ut7l7AnEHsb/88jH1BwZSaUKByGXYBKtDbwn5sCVCTq2DWEaMKUd6yYNO9Sg8icTd5stqTmqa+aSJBpOSlISkLZdiuNnCsUrqbx5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N+oJanIg; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so26776965e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626295; x=1742231095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2HiqREuR54kxkPz3bPI9x4Ub9LuCiTlMlEcfuLYBzU=;
        b=N+oJanIgVaVaiKwbBjzThDLmvC9bc6DshuJy8xhrXbcVAOt2IVtZURNhJ1Zvo5u3/7
         R7K884DK739P6dKuNdH2viUX8jEuiHjQzWUVP8c5cpiaqVpyv7OXAy/3CSkMAMOeH7T2
         wxUNVtqSNUOmmzGzw4KDsoF2dYum2g0+cABwgveGv452quPhXsMqq1a4dAx3fIvoAnN+
         r9WCaQfF/dKQbpVXkSks6KIa/4brs+ZOTUQXVkTofmZC2ubVgrlt96U1gSPrWeHdW49n
         U5yACvudL56dyHh0FhJvUeja2m5kZQpWLpv+4YNgQVl9vxN8sgYDCPic77ugl8Ef3QHb
         OqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626295; x=1742231095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2HiqREuR54kxkPz3bPI9x4Ub9LuCiTlMlEcfuLYBzU=;
        b=rhY6sSbMq9t8EnDhm6mg1yFN4vOZPU1QoZz0bo8EiS+uCQ4Cz7YqswOcHtNCi96xBv
         MvJ5R4J9V7BcHiKVFj70TTbIKJw7P/IRcy53mj/UGrp10mv1GhW7c1zwC6VLCPVraxI6
         jopLa+uk7XWF+sXS1le42Y1l3T03oogANQtkAMmz/5kMJscfPw/J2hrDMHweE9A6humZ
         x3/PDA2WTq+A5qWNUVfBLCIGYSptcUg88Bdl7ZoU7xspUMzyWcV4lP2hOPRGuK5bhGXU
         jZLWyL4ixb8mwyc7GyFeHrmIq2+6BrVHo2mQHc/K5QGayEOe+dbCF0k83l3JWsDWwJfs
         ufLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWobN1fqSKxrcDBnp+1Hf9QstQWqzj5bKaeqcEpTgol/QB0kGsoRiedDiE38bPaHbahYZMXB3uMomm43Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh42cyXDiU2TEofVuThSzGXDy/kHSZZTooikI2mWg5oUHc7PnT
	c1fwYpt0i88QHDGkTtHQbLFkNNyrb+noslEtEfWSelsD8aVFII6wl//ZK33jRDk=
X-Gm-Gg: ASbGncsfk+JEQG+go6CFRrd+5My8ZnJLXuf/agexGqR0BcX/Z9JHN0FOS67bv9YZF9H
	CjQkAyxkIRqq0E2oyHq0sI0vLwzIuEz/3QwjhOpvmmP8FRjR44qz8zjNFX9Ig1mkUzdENw1Dukb
	svuIKXlriTKPsij9Tut2ksl7k9DS8tgKLshsrlPRZ80f/kgGt/DGt82AzFHT5h77qGO4gm/t/g+
	VGjacCN36rfy/8vWmndTBAgnWE2XD0Q2d/tdUVoZg3fLHcxGJtpziQWHSWZRs9sGrrLsV2We5ql
	MLAYuaV7jkpJHB+71HYB370TK3yW64Hmo3tEEz5H/UgbMlbzhB+kcioMsQ==
X-Google-Smtp-Source: AGHT+IEC2SmEhvEnLEv4KyZUCOW4bXKgkDgcZcZ6gL+4ji1CDp5Qw9swnbc/V9eJB42qhEh0l1CT3A==
X-Received: by 2002:a05:600c:1c04:b0:43c:f629:66f4 with SMTP id 5b1f17b1804b1-43cf62969f2mr44870395e9.0.1741626294361;
        Mon, 10 Mar 2025 10:04:54 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:04:54 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2 00/10] Add kernel cmdline option for rt_group_sched
Date: Mon, 10 Mar 2025 18:04:32 +0100
Message-ID: <20250310170442.504716-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Despite RT_GROUP_SCHED is only available on cgroup v1, there are still
some (v1-bound) users of this feature. General purpose distros (e.g.
[1][2][3][4]) cannot enable CONFIG_RT_GROUP_SCHED easily:
- since it prevents creation of RT tasks unless RT runtime is determined
  and distributed into cgroup tree,
- grouping of RT threads is not what is desired by default on such
  systems,
- it prevents use of cgroup v2 with RT tasks.

This changeset aims at deferring the decision whether to have
CONFIG_RT_GROUP_SCHED or not up until the boot time.
By default RT groups are available as originally but the user can
pass rt_group_sched=0 kernel cmdline parameter that disables the
grouping and behavior is like with !CONFIG_RT_GROUP_SCHED (with certain
runtime overhead).

The series is organized as follows:

1) generic ifdefs cleanup, no functional changes,
2) preparing root_task_group to be used in places that take shortcuts in
   the case of !CONFIG_RT_GROUP_SCHED,
3) boot cmdline option that controls cgroup (v1) attributes,
4) conditional bypass of non-root task groups,
5) checks and comments refresh.

The crux are patches:
  sched: Skip non-root task_groups with disabled RT_GROUP
  sched: Bypass bandwitdh checks with runtime disabled RT_GROUP_SCHED

Further notes:
- it is not sched_feat() flag because that can be flipped any time
- runtime disablement is not implemented as infinite per-cgroup RT limit
  since that'd still employ group scheduling which is unlike
  !CONFIG_RT_GROUP_SCHED
- there remain two variants of various functions for
  CONFIG_RT_GROUP_SCHED and !CONFIG_RT_GROUP_SCHED, those could be
  folded into one and runtime evaluated guards in the folded functions
  could be used (I haven't posted it yet due to unclear performance
  benefit)
- I noticed some lockdep issues over rt_runtime_lock but those are also
  in an unpatched kernel (and they seem to have been present since a
  long time with CONFIG_RT_GROUP_SCHED)

Changes from RFC (https://lore.kernel.org/r/20241216201305.19761-1-mkoutny@suse.com/):
- fix macro CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED invocation
- rebase on torvalds/master

Changes from v1 (https://lore.kernel.org/all/20250210151239.50055-1-mkoutny@suse.com/)
- add runtime deprecation warning

[1] Debian (https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/config/kernelarch-x86/config),
[2] ArchLinux (https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/blob/main/config),
[3] Fedora (https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/kernel-x86_64-fedora.config)
[4] openSUSE TW (https://github.com/SUSE/kernel-source/blob/stable/config/x86_64/default)

Michal Koutný (10):
  sched: Convert CONFIG_RT_GROUP_SCHED macros to code conditions
  sched: Remove unneeed macro wrap
  sched: Always initialize rt_rq's task_group
  sched: Add commadline option for RT_GROUP_SCHED toggling
  sched: Skip non-root task_groups with disabled RT_GROUP_SCHED
  sched: Bypass bandwitdh checks with runtime disabled RT_GROUP_SCHED
  sched: Do not construct nor expose RT_GROUP_SCHED structures if
    disabled
  sched: Add RT_GROUP WARN checks for non-root task_groups
  sched: Add annotations to RT_GROUP_SCHED fields
  sched: Add deprecation warning for users of RT_GROUP_SCHED

 .../admin-guide/kernel-parameters.txt         |  5 ++
 init/Kconfig                                  | 11 +++
 kernel/sched/core.c                           | 70 +++++++++++++++----
 kernel/sched/rt.c                             | 51 +++++++++-----
 kernel/sched/sched.h                          | 34 +++++++--
 kernel/sched/syscalls.c                       |  5 +-
 6 files changed, 138 insertions(+), 38 deletions(-)


base-commit: 69e858e0b8b2ea07759e995aa383e8780d9d140c
-- 
2.48.1


