Return-Path: <linux-kernel+bounces-270626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E15D944248
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2CB283E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A4713DDD5;
	Thu,  1 Aug 2024 04:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPttzup4"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8971813D283
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 04:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488091; cv=none; b=mPPAr3pXGpviRQfE1dLqs0/20+R08i18ljaclU1lRE90o7SNCIop6dUIKmjh8B0OOIeAkv5k1R2iTlkrPQZMzuB7dHp+FgG8pWrRzb/+OH1QCptdfZXpp+/3XROGOO+GA7Qxj8pw5+n+RTlLgIgQ4l4us82X41cGBE4au4I5W1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488091; c=relaxed/simple;
	bh=NJ2/aZHAvxzMyHnkQWZaOUTvxZuZNAQw31kVUhjO6Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n3nyJhZyhY6d70vJDR85km8GK8+3da4XQDPhyLkZQhKSMYNiR0kPaX67L1NaAGpSPuL4a87hIlZ/rasmGo0uTtwvai2aMUtJvbIXqSOtjPyiMWj3b5KxuTPBLO74urkaligHADnxqRg3wfPDmByOBfphNBLiFc6OBi2QV6NMwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPttzup4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a0e8b76813so4411747a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 21:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722488089; x=1723092889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sGqa7xCvNcLqwg533sIrs11rG2Jt0FPP2Ws8eQJ23PA=;
        b=kPttzup4GKlfUqk6SViK3cyC9MBJElJQmzViJD2m1SMV3YsLhmdg2qtfsFA9WWGNX3
         T/4f+khDhD3P3BrKh8it7FDW4rVD2A4UAkgMRRpi5drixBkVJx1keR8Nke3DD4uOURL5
         9Q1BUPgrNntiMXE/TxK/QMCI682kxqGFzyXgAmfYFXrSbactCjBSL/dTzCFDb8i6Iz3y
         NwpjJh96AeuwvYX2QvvS/3wfmm28dWvsX5/QAeqeFDYZhTjAZa1NFPAVVmSNvtYQK3cu
         iXFLbYsX0jkvf/1fM3Vgy/0yj7pnCIjNzlUU4PSYWVz+p6slXiFxvniP09sfw/JUV7Xl
         uOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488089; x=1723092889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGqa7xCvNcLqwg533sIrs11rG2Jt0FPP2Ws8eQJ23PA=;
        b=Tq5P+Ob8CTcvIE3Ch6GLDd9X/W5ntLWhX1wfjneITpKzEBRDLuBJ3qNH4xCxEO+54Q
         NLkltlCp1blPsiEZkn1oEwwTiF4TvjzOSbQMwbAxLTUxNVeLs5Oac2bGAk1to3xuaGVa
         KwsgjrhqqK+8HTBPTgM3MFGxYphl6uDhlrQLiZQMYnKMeiPwnhFgHtb6cYKuiO9XWUYM
         09jqcQk1okse5koiOYBRv6lxkljuUL7jUa1l6zRWWQfJn4KZi+XBvhXbFX9YV3j72r+V
         XXfi7Ozi7bGWgbCnHA29RFnojTDvAY8XGEBSMgzVFQ4ybZtnkqYLafhqQK/P9lhTW98N
         rR/w==
X-Forwarded-Encrypted: i=1; AJvYcCUajNgRH2dHI7/h6Fb7KmftywGZ/sfiIvhQ89TocH0x4/3XBjosluaUfGO4TsBpIiieYbNBg8NjosMNn69AVjaXwRrB8zumhostMraq
X-Gm-Message-State: AOJu0Yx+D0T8zJPDJYIubdxVkjawUgHGXQvekHZs81D9skL2UmrfgHXO
	xfl7VHB92QqWaRBe8+c4M2eCz17k5qp436PnFOGZl//5v8WQzMzg
X-Google-Smtp-Source: AGHT+IE9qi7gQazGX1QrRlMTjcR7jxSkAIG8xrW3RgBdWGxQ+Ko7k1VdDttRLTUsPb8iBba6+WwfSg==
X-Received: by 2002:a05:6a21:458b:b0:1c3:ce0f:bfb2 with SMTP id adf61e73a8af0-1c68cf82b39mr1202292637.23.1722488088574;
        Wed, 31 Jul 2024 21:54:48 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([43.129.202.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff3d64sm128325595ad.299.2024.07.31.21.54.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 31 Jul 2024 21:54:48 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: 21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	libang.li@antgroup.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [BUG] mm/cgroupv2: memory.min may lead to an OOM error
Date: Thu,  1 Aug 2024 12:54:27 +0800
Message-ID: <20240801045430.48694-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

It's possible to encounter an OOM error if both parent and child cgroups are
configured such that memory.min and memory.max are set to the same values, as
is practice in Kubernetes.

Hmm... I'm not sure that whether this behavior is a bug or an expected aspect of
the kernel design.

To reproduce the bug, we can follow these command-based steps:

1. Check Kernel Version and OS release:
    
    ```
    $ uname -r
    6.10.0-rc5+
    
    $ cat /etc/os-release
    PRETTY_NAME="Ubuntu 24.04 LTS"
    NAME="Ubuntu"
    VERSION_ID="24.04"
    VERSION="24.04 LTS (Noble Numbat)"
    VERSION_CODENAME=noble
    ID=ubuntu
    ID_LIKE=debian
    HOME_URL="<https://www.ubuntu.com/>"
    SUPPORT_URL="<https://help.ubuntu.com/>"
    BUG_REPORT_URL="<https://bugs.launchpad.net/ubuntu/>"
    PRIVACY_POLICY_URL="<https://www.ubuntu.com/legal/terms-and-policies/privacy-policy>"
    UBUNTU_CODENAME=noble
    LOGO=ubuntu-logo
    
    ```
    
2. Navigate to the cgroup v2 filesystem, create a test cgroup, and set memory settings:
    
    ```
    $ cd /sys/fs/cgroup/
    $ stat -fc %T /sys/fs/cgroup
    cgroup2fs
    $ mkdir test
    $ echo "+memory" > cgroup.subtree_control
    $ mkdir test/test-child
    $ echo 1073741824 > memory.max
    $ echo 1073741824 > memory.min
    $ cat memory.max
    1073741824
    $ cat memory.min
    1073741824
    $ cat memory.low
    0
    $ cat memory.high
    max
    ```
    
3. Set up and check memory settings in the child cgroup:
    
    ```
    $ cd test-child
    $ echo 1073741824 > memory.max
    $ echo 1073741824 > memory.min
    $ cat memory.max
    1073741824
    $ cat memory.min
    1073741824
    $ cat memory.low
    0
    $ cat memory.high
    max
    ```
    
4. Add process to the child cgroup and verify:
    
    ```
    $ echo $$ > cgroup.procs
    $ cat cgroup.procs
    1131
    1320
    $ ps -ef|grep 1131
    root        1131    1014  0 10:45 pts/0    00:00:00 -bash
    root        1321    1131 99 11:06 pts/0    00:00:00 ps -ef
    root        1322    1131  0 11:06 pts/0    00:00:00 grep --color=auto 1131
    ```
    
5. Attempt to create a large file using dd and observe the process being killed:
    
    ```
    $ dd if=/dev/zero of=/tmp/2gbfile bs=10M count=200
    Killed
    ```
    
6. Check kernel messages related to the OOM event:
    
    ```
    $ dmesg
    ...
    [ 1341.112388] oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0,oom_memcg=/test,task_memcg=/test/test-child,task=dd,pid=1324,uid=0
    [ 1341.112418] Memory cgroup out of memory: Killed process 1324 (dd) total-vm:15548kB, anon-rss:10240kB, file-rss:1764kB, shmem-rss:0kB, UID:0 pgtables:76kB oom_score_adj:0
    ```
    
7. Reduce the `memory.min` setting in the child cgroup and attempt the same large file creation, and then this issue is resolved.
    
    ```
    # echo 107374182 > memory.min
    # dd if=/dev/zero of=/tmp/2gbfile bs=10M count=200
    200+0 records in
    200+0 records out
    2097152000 bytes (2.1 GB, 2.0 GiB) copied, 1.8713 s, 1.1 GB/s
    ```

Thanks,
Lance

