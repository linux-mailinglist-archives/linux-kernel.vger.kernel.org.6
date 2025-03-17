Return-Path: <linux-kernel+bounces-563928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DA0A64AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B81C3A3C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D143F22CBE3;
	Mon, 17 Mar 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHkK/MUv"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CED133987
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208188; cv=none; b=qAzyhNanF6yKM0ZdKGydK68tHp1d9zekFBk+8+J81Hp7GqkKXIFv7651Hg4UYjGpDFJoCu/lZlu6VrZcSxOTLZ7YDRQXTxQyempGzzQV0oTDEg5S56n3uTeYZJFWpmJ92liU6pKDF+IbqvuG3HpXaatPWOBGpDdqaRCdSeEWb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208188; c=relaxed/simple;
	bh=oBneh01OD9nQkCn0xQByE5GfqFCASo86TSWKd0L8Pzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3lBu73VNIc6ejdyb6Mtpwlyehrt1q2NTRtzHIQxBdW1IkBrr/eJMpNVree/E3U2/QjN9mpJ43rm4YAaqKsxTGQicWczVQn4I9vrwNjx+2FhZ1O8dw7xwFJTPYcpyzBY1Pjj7tle7ipluZj/EuzEDI2k8x4QBos4Wj6LidTtInQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHkK/MUv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39133f709f5so2525959f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742208184; x=1742812984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kKvinO1udxeRxG38CMWHp9vAg/XMzNaXaYB390fHlq0=;
        b=dHkK/MUvHItenqB1XkWC/ODnVM3pACqKHgDLstRfoVSh0k2f6tJGU0TGlrqE2nKFNX
         o7T0+Mywscld4+n6WAVNQDywnOiwVgZA7ie8OrQeH1z1QnU2mYx2Tl2iZ4DBVfxStFmb
         KUNakEwRFi/pqHWfZWEjsq6TzzGRd5WkbfMta1qF1aneBYQEsQUOi4f2Mtp0yCAesVZd
         ptAWaWEeewZrAd4X9o6NBTud7GBQA2+D/nVJ6l69tlcA45c1YVhtAtAw1J+x968M+jAI
         wUKiaG7N5up0hQgJS/VGm90b3y+7Ru2opNtuVexHUWvjJilMzaAXPo8BWdLO9uRiUG0r
         jZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208184; x=1742812984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKvinO1udxeRxG38CMWHp9vAg/XMzNaXaYB390fHlq0=;
        b=IQZmkeIfYhYsmO+C4Ro0glGO7cnMbksPcqaqsSpQdtSkXpoz1OZZrQ4kxP7F86KvPz
         pcVZ5Efn/ffYTvhA9H8JRMcAxGzAvhahWtl0clwhtoKUlWQzx7fJ/zVOVHXg/VkSCTgW
         itcRf7xE6UxZC1wC1zvnOfBrY51i0wb+Mwl2xfCnUD9Eo8DUkcFci/beDbXJUmtEauc6
         nVWwOncbZg9y5Qm4+toD1PCMqOtItYyHJld4IqK9ZKohUma4Uoty2JGHvU3oZipb330X
         hzb102vzC58qD6vyeUxV+1pJFvnDBRI8TxGjTg0WcauHGmAfEe6juqEMhh/4M0p8f3zJ
         5h7w==
X-Gm-Message-State: AOJu0YxjwEOgkm0h8qeIDAnPIJdby+3rrWCqGfLnikgqCqTGksVB/PH3
	NQEtZvYJETkD6mvDd65wiVKmOpkpp+Qwm6zWF9RqIx/qu3u5NfrShntzx6lj
X-Gm-Gg: ASbGnctn3J5jD3NzjLe1CgysmUs6uzBH8kkZ9cZzg1UFPsYK8ZPpowafYYjx9ib3pr/
	bPPR0wGyfpnzex78KrVuTeH06myucU3n9hlQIf4bM9T5vFyI/HYaegdZyRduCLq+LavReQP2wER
	tQVARBg8WiJXtCcLHwwAH4Jb3oT8Wl4PBoXe47ckHiL+eaq5pfHxQvYxgowdOh5gpigwSL3XmSZ
	fFiFihdJGvOzOZ5sXdvXq9e9YpXo2A0InhrRTjztSbnCcApj4Mi+OD8TNYhKOBpkUxF7cPCVDsy
	1wHRkVKYr9h3+IoVLu08AADtj+MeObs3Hlt/CqbeR9IJDUXr1yrLH67khQgOgNtZvA==
X-Google-Smtp-Source: AGHT+IHcfi5l4xXp1Y6e7u14pWQ6+erZfvW5ZycHmChs+7Ft02hx8lGPWRLx3KA2S4r58hyd76TejQ==
X-Received: by 2002:a5d:64e3:0:b0:391:2f2f:836 with SMTP id ffacd0b85a97d-3971d336b00mr11105229f8f.17.1742208183586;
        Mon, 17 Mar 2025 03:43:03 -0700 (PDT)
Received: from starship.. (1F2EF046.nat.pool.telekom.hu. [31.46.240.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb3189absm14807262f8f.71.2025.03.17.03.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:43:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/5] sched: Make CONFIG_SCHED_DEBUG features unconditional
Date: Mon, 17 Mar 2025 11:42:51 +0100
Message-ID: <20250317104257.3496611-1-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For more than a decade, CONFIG_SCHED_DEBUG=y has been enabled
in all the major Linux distributions:

   /boot/config-6.11.0-19-generic:CONFIG_SCHED_DEBUG=y

The reason is that while originally CONFIG_SCHED_DEBUG started
out as a debugging feature, over the years (decades ...) it has
grown various bits of statistics, instrumentation and
control knobs that are useful for sysadmin and general software
development purposes as well.

But within the kernel we still pretend that there's a choice,
and sometimes code that is seemingly 'debug only' creates overhead
that should be optimized in reality.

So make it all official and make CONFIG_SCHED_DEBUG unconditional.
This gets rid of a large amount of #ifdefs, so good riddance ...

Ingo Molnar (5):
  sched/debug: Change SCHED_WARN_ON() to WARN_ON_ONCE()
  sched/debug: Make 'const_debug' tunables unconditional __read_mostly
  sched/debug: Make CONFIG_SCHED_DEBUG functionality unconditional
  sched/debug, Documentation: Remove (most) CONFIG_SCHED_DEBUG references from documentation
  sched/debug: Remove CONFIG_SCHED_DEBUG

 Documentation/scheduler/sched-debug.rst                         |  2 +-
 Documentation/scheduler/sched-design-CFS.rst                    |  2 +-
 Documentation/scheduler/sched-domains.rst                       |  5 +-
 Documentation/scheduler/sched-ext.rst                           |  3 +-
 Documentation/scheduler/sched-stats.rst                         |  2 +-
 Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst |  2 +-
 fs/proc/base.c                                                  |  7 ---
 include/linux/energy_model.h                                    |  2 -
 include/linux/sched/debug.h                                     |  2 -
 include/linux/sched/topology.h                                  |  4 --
 include/trace/events/sched.h                                    |  2 -
 kernel/sched/build_utility.c                                    |  4 +-
 kernel/sched/core.c                                             | 46 ++++++----------
 kernel/sched/core_sched.c                                       |  2 +-
 kernel/sched/deadline.c                                         | 14 +++--
 kernel/sched/ext.c                                              |  2 +-
 kernel/sched/fair.c                                             | 64 +++++++++++-----------
 kernel/sched/rt.c                                               |  7 +--
 kernel/sched/sched.h                                            | 83 +++++------------------------
 kernel/sched/stats.h                                            |  2 +-
 kernel/sched/topology.c                                         | 13 -----
 lib/Kconfig.debug                                               |  9 ----
 22 files changed, 79 insertions(+), 200 deletions(-)

-- 
2.45.2


