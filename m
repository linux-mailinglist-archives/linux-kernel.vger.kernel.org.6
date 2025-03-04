Return-Path: <linux-kernel+bounces-544744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A30DBA4E459
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74CE57A62EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE4827E1C5;
	Tue,  4 Mar 2025 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eHPXFtbJ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C513259CAB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102718; cv=none; b=A1sGUeAcE/w0dGOi48+Zf95yRjRX2l6tzs8NZmxXJBwmq7CxkXWvoM4WwQkZmfnoUR2wWE2Ayav330Q70fke4mUf7qowQlGZ4vOOW8W9pE/Q8zPWO6/COjpd+Z/JEbgaTP6dEGRFM2OQcs8+l2Xk1NmWkebCeeklofPBmx9ZLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102718; c=relaxed/simple;
	bh=gPGd2SMtWSwL0Fk7C9vPkOctSj91rK9tyNIlwMh8Ou0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zhuuu0u1jdVkPjJAZ0OnlJz5Q1R1h4KBJ9K8Y/OibVGx4IDRaz2r3FsbSbLML9R3PpwvLHZC6MNeBpCXOLRGIvWGHl6Yv/2XLzx0AfZkmtmvMZn6ti6rm29GVDggY9/aWEb+O2qxO6b54/GwlAaLAhtpPGgN/iR6SQgNqKM4i5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eHPXFtbJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bc0b8520cso15601585e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102715; x=1741707515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iSd8ve04q9jkY+lejohEQNGWVY2Fdf6RaTdBEC1rDCo=;
        b=eHPXFtbJf4SnTELpuH75eqCKgXaee+YKiH9TzGShhiME20ldLqlbWsU7uRso+ugJ3J
         Fz7mhKBUijOOUtznRhRipy1oxuXm8yQSSKHcSPypT5UNIuaH3PRZnSX25uC8Ikd3e8S3
         +zyN2aY7q12Nv8U5OY95gpF27M8SYiMnpcZYD4zQLodPI+IZtd7tfB3jTh0QSe4tw1kO
         X8tnlbzZ7nWN/feBYSmSJmzOLHpGiBdoqHIUYh5+fNDEvVBA0LSVtlEl8h5Yr3bgPjS3
         KC0inlVHBmgDu9pG65k2HSmKnncML0fAOp5QbiVeI9UarCEOG+ktxcUaDXW3gLsgkT85
         T5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102715; x=1741707515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSd8ve04q9jkY+lejohEQNGWVY2Fdf6RaTdBEC1rDCo=;
        b=DirxxVdxhcKKTWeBOMxUmAwBYe7dBKGtXKBxMGtUPaP1uJgyVJADsLrTgbaOMhVxD0
         rzMbxILdPMQTp62dXSnLNHY5ACgTr5zvXER9a0jgp8aUfYUXCPSuedxxBXZnIDR1JKOV
         xR+W2nftdPb8QYV8RD7eCINb9qlsfGjA2E+Mmn54CpBw5mWCmknSOCsOSwHCQ1wSl0m7
         obJFK2W+Sv9lo8ALk76QZW+4GzMgsSLn8YJ4qT9IHJ8RXIHQsPB8LbU410rnmDUHRPbs
         UHNmZ8RmQpQN1PctqvFySu75yh21pO/J7dJubMFd8xCXJTg6zWVNM/LltWo4Rkyb8Kbm
         sq0g==
X-Forwarded-Encrypted: i=1; AJvYcCUJn9y6g/MaTPmFdgJHKyP8Nqn82T4kG4QA+/FdhhRzWsKmFUEMdikhY6XenxMSTwqPf8nJZvEAlNwR27Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YypPiZ7Jhrs9GiFuBqfwu7dUPMt/BlLdy5VxO8+uQ32hg06J8mA
	LSq3mUPe3+qOUcGuNG3heODHLJeuy2KbVLcSE/Auy4dz1KLHiQ21vGWPF6KKghrRUOC85OCxf06
	W0Cs=
X-Gm-Gg: ASbGnctLicOawnZn15fEsdnq1WlRovXMR5sq5Eoh0/Iiu92juUHvFjOz2TwX3kZHK5b
	xbb+ElHmMUNvgWJy0X1W4CQ3tuNtQRBSWzhKjnHBCImVH+OvY0JRF6ZX4VLk+v5vE0fSSHp+Mdu
	eI7lVW88tWIXTY5SMrURqUsU4cczJNwJJjPS7COdi2G23us/OcKcfI5UpJCTU7x3n1Pkfh8dTkk
	0BwPebjfWYFGTV3VY7KSDeDNUxc+XtEUD7Rn+jVzFGi9Maqq+gcbeIcJI2CC4YAHpYIbV9+DbXV
	kD97Ofp4Sj7srPHDSJbLu2K+FhZFo/msUWk/y/E60P6aXnc=
X-Google-Smtp-Source: AGHT+IFCKBTaNh1ji5VjlXmlOoDP8Ygx/PbOCIjfOjueWZr/IzcTQzEGN3dOCOuAsGpaq/YEQ/vJjA==
X-Received: by 2002:a05:600c:4fd1:b0:43b:cad8:ca87 with SMTP id 5b1f17b1804b1-43bcad8cc8dmr26424015e9.1.1741102714833;
        Tue, 04 Mar 2025 07:38:34 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:34 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/9] cgroup v1 deprecation warnings
Date: Tue,  4 Mar 2025 16:37:52 +0100
Message-ID: <20250304153801.597907-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Memory controller had begun to print warning messages when using some
attributes that do no have a counterpart in its cgroup v2
implementation. This is informative to users who run (unwittingly) on v1
or to distros that run v1 (they can learn about such users or prepare
for disabling v1 configs).

I consider the deprecated files in three categories:
  - RE) replacement exists,
  - DN) dropped as non-ideal concept (e.g. non-hierarchical resources),
  - NE) not evaluated (yet).

For RE, I added the replacement into the warning message, DN have only a
plain deprecation message and I marked the commits with NE as RFC.
Also I'd be happy if you would point out some forgotten knobs that'd
deserve similar warnings.
At the end are some cleanup patches I encountered en route.

Michal Koutný (9):
  cgroup/cpuset-v1: Add deprecation warnings to sched_load_balance and
    memory_pressure_enabled
  cgroup/cpuset-v1: Add deprecation warnings to memory_spread_page and
    memory_spread_slab
  cgroup/blkio: Add deprecation warnings to reset_stats
  cgroup: Print warning when /proc/cgroups is read on v2-only system
  RFC cgroup/cpuset-v1: Add deprecation warnings to mem_exclusive and
    mem_hardwall
  RFC cgroup/cpuset-v1: Add deprecation warnings to memory_migrate
  RFC cgroup/cpuset-v1: Add deprecation warnings to
    sched_relax_domain_level
  cgroup: Update file naming comment
  blk-cgroup: Simplify policy files registration

 block/blk-cgroup.c              |  8 ++++++--
 block/blk-ioprio.c              | 23 +++++++----------------
 include/linux/cgroup-defs.h     |  5 ++---
 include/linux/cgroup.h          |  1 +
 kernel/cgroup/cgroup-internal.h |  1 +
 kernel/cgroup/cgroup-v1.c       |  7 +++++++
 kernel/cgroup/cgroup.c          |  4 ++--
 kernel/cgroup/cpuset-v1.c       |  8 ++++++++
 8 files changed, 34 insertions(+), 23 deletions(-)


base-commit: 76544811c850a1f4c055aa182b513b7a843868ea
-- 
2.48.1


