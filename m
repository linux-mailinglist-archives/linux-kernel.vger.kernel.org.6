Return-Path: <linux-kernel+bounces-182804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA458C9011
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 11:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E551C20F41
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 09:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3D7134B6;
	Sat, 18 May 2024 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TanM45+J"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA36110A01
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716023029; cv=none; b=N1XWcek0TqQOv4T0wml/kVIOonTnoVsf9yTBW29TmiIQ1OcH7HQc54ShQslzcnKlM1CgQy6c6twb1erhOeSyd87g/vTbCtKgftGvaWn/g2xFbY+gT2YnC/MgXTLSPHQ/mO36UIRmA1WeR4xKOneAhtBAEczpudS4T1v57jnV8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716023029; c=relaxed/simple;
	bh=0OOFZMqR6sP/hxy/70KCs+H3XkbQIIGeImrpVTdC+Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZlsWk1oQNx71jixhYgPsvMtv9c0Va3YexaQOsRr8rryM907JyHlbgQ+skYWh2Vq8gSMtejAmS+7DFdbexUSo4x9RmCXFQucN7bDGGPVZanKwdvx44aKV6nDb+OlNNIlPjawOvSXY3Ghje7xm/NKpwtXPalXVXwYVQ4fs034e/xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TanM45+J; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so7571604a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 02:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716023026; x=1716627826; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FiTB+7Qtr+IjILLim3W6mVH1GRVNfZDnzR1wfzlYgyc=;
        b=TanM45+JNh2Ed0zU+BkhiYZ0rmu514z81TQiINWnMbkTFA0Ub9HAA+cudyQ6vxCYbu
         I2Pmu1oPivSONdttKGSZ6gE/USN+xGOXh10nvtQCElS7nyZj4VeDpRlorwdvAK84fyQm
         5jrUUxRufYUdEjpwUnUuagPcVEBO+A1GHzYb/JGVSzmnqHT3E/Qx5DQMc63WnrYKSnHn
         GvTwIftWR0Vko1BeFWBtNXhhxLt1gkneRbL2pCOGRc25QH7VvL2P8+9CuEcEHkhLLVaK
         maMhL9t6YumoDJTPB7TriAxc0ShLjmZpoQNiRfQw51z1MzR2Ni+ysrQAUI7Hdv171g8i
         6TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716023026; x=1716627826;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiTB+7Qtr+IjILLim3W6mVH1GRVNfZDnzR1wfzlYgyc=;
        b=CaNikq8lgJZgjYG8QMafAkZjmUz8npo8yoBGiL8pAmm11351N5Lqn4pgdzfeomU/YA
         pJERVrnoUeLhdWKqrtCWb2NOaJGGAdG7fKz43Y1TECAiLrVZWnIKCMUw7QgneiQMoG0Y
         4/1aZDmYXvx5aMBCsegCAisjYn6PBcV2125Tc+MNjTYF6ONPZtBXQdmKtnkeHdLufymn
         nRb9LRHNFWlXGV9Lih/xf0qlibTCZpW2oeOZ0+HMrhIILY29vd9dLRkqc7wkoB4pDhZ+
         yv5cmZIcDI4VypxYxSN/8wh3E7SEC6Rkg0OjkOQ+UG7wyV2G5ksUG7iUdrfAijuZupgG
         Tabw==
X-Forwarded-Encrypted: i=1; AJvYcCW/FINjr5NBxOSm1LcRprEeuTBnx4BiheccQJF0SkwVb/PhEGe2tbfBo9Wl64GWEO6V8Sq4XTn3VovmmBmzsdR278xbTfjw/iXwLnTx
X-Gm-Message-State: AOJu0YyXc/P51OfR9ZPZuyPVafzTShYgaSTVcPHbBKRbVCNgmbaCmjcG
	JfPFWXUNHuE6ZUppMp85+KU/IOsVOmtGG/M7wdCdRpOSP1KaMnRq
X-Google-Smtp-Source: AGHT+IE/y7OhtL8+NO/5lIRaJZvaBc0WhiDU0MMAnGEtIDfDWC6S06h50BjzDgGvWFals1wwRUlbQA==
X-Received: by 2002:a50:ccc1:0:b0:56c:1696:58a8 with SMTP id 4fb4d7f45d1cf-5734d44fe63mr23312012a12.0.1716023025737;
        Sat, 18 May 2024 02:03:45 -0700 (PDT)
Received: from gmail.com (1F2EF1AE.unconfigured.pool.telekom.hu. [31.46.241.174])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed2059sm12806946a12.56.2024.05.18.02.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 02:03:44 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 18 May 2024 11:03:42 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] scheduler fixes
Message-ID: <Zkhu7l+25+vIOJd4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest sched/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2024-05-18

   # HEAD: 49217ea147df7647cb89161b805c797487783fc0 sched/core: Fix incorrect initialization of the 'burst' parameter in cpu_max_write()

Misc fixes:

 - Fix a sched_balance_newidle setting bug

 - Fix bug in the setting of /sys/fs/cgroup/test/cpu.max.burst

 - Fix variable-shadowing build warning

 - Extend sched-domains debug output

 - Fix documentation

 - Fix comments

 Thanks,

	Ingo

------------------>
Cheng Yu (1):
      sched/core: Fix incorrect initialization of the 'burst' parameter in cpu_max_write()

Christian Loehle (1):
      sched/fair: Remove stale FREQUENCY_UTIL comment

Dawei Li (1):
      sched/fair: Fix initial util_avg calculation

Vincent Guittot (1):
      arch/topology: Fix variable naming to avoid shadowing

Vitalii Bursov (3):
      sched/fair: Allow disabling sched_balance_newidle with sched_relax_domain_level
      sched/debug: Dump domains' level
      docs: cgroup-v1: Clarify that domain levels are system-specific


 Documentation/admin-guide/cgroup-v1/cpusets.rst | 7 ++++++-
 drivers/base/arch_topology.c                    | 8 ++++----
 kernel/cgroup/cpuset.c                          | 2 +-
 kernel/sched/core.c                             | 2 +-
 kernel/sched/debug.c                            | 1 +
 kernel/sched/fair.c                             | 9 +++++----
 kernel/sched/topology.c                         | 2 +-
 7 files changed, 19 insertions(+), 12 deletions(-)

