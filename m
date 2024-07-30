Return-Path: <linux-kernel+bounces-267747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8678C94150D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F651C22DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20411A2C05;
	Tue, 30 Jul 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="AV4RVppH"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109272A1C7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351725; cv=none; b=SS7mYAK+eIGvKpLEifynUmjh84j2H+6MG5v6M/mr+LmyDlQrBLzy+rzs/snLmJHc9Tm0VfsK/Ylqm0Qozo/lMPhkNx8kgZ7QFyQF0nTdZKXaU3FgXyZmrInVAIkyldjq24yoMT/6VgKjg4jHQ4YuHbg/CXbZeGhs+0qdt4aAsrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351725; c=relaxed/simple;
	bh=OAEwBcPX03M3vIGx2f+neVP2ShOaQO2lRAxm2x9CISU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QkA3q2Y1KbT4WT63s/hyzfnLjc2BTQkQqhFwAZk6LDFk7tDvkjaq/UZ9AnSa6AlMDMBvH4OGe1D2RtcTnCRtN5ORdIMf9udZztPwYhfcDmRaE5jl+mqIEfrtxUrpxZ465GMZiBRpf03IU5LvVB8U/9eGJVZVweuf9/s25ENa180=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=AV4RVppH; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1d6f47112so297272685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1722351722; x=1722956522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dmsts6TDFRmr9obeP/3FPv0YdHP8+9XGf7PVhOIlV5k=;
        b=AV4RVppHBSSsZAbOvtRPmNNS2jcvruvw9E+6ZiPCxjEf7KxfgPmhpA+oj5DvnR8U3d
         5z+uH+X1Qi2EZ5yZ5ORW+d16BkvAJHifL4jiU6xrC/ED5DkPYBDUm2HPABreVghGdk8U
         SOqPCsdYN72DRUggR4fiMaEKr9++j3Z+6MAYxaL6PMg/32XeqjY5aklNj12CURvXPkod
         44MicUMEI2V03tSpPK+18zzrhbXNOKVaPZDKpk1tr3V2fXYCdZxUGYUIQ0rjkltzeQjm
         eGkFRj7ebbz5hxQHTsBektjmN67gn6phBwpzIuTsycXtcfzWOzQBkmU9KpjJkG0vVcDs
         FQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722351722; x=1722956522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dmsts6TDFRmr9obeP/3FPv0YdHP8+9XGf7PVhOIlV5k=;
        b=uKZy9LjQmOW18Rjnh2keuE9nrFru4hNr36S55DwWuSG1lkWYWFMVXHNLdTj3tgkJRM
         5d5zPwcn35d8rwwx2W3DEhbK+JUxzonyEupEjaeLmNXFPzwt+sx36hfJ1pNTUucLBx2c
         XIHd+q982ysNoZldaUdx7wb8BJfK0RCwr95thZlYd2Whhus886YhMH9/xoC2nik2zOel
         PNfCMJz4khISryM11UC5IpQ3KQPzszHTn//a2sLqEvxhCbqe6UI4w9QXd5lhqCIHzpz+
         UvJIVixdlhtlJ918lr7uYOCFPMDY/y96j2cMyoW13w+uKsP5HnvLnPP9JRtG6GMw6MBn
         arTg==
X-Forwarded-Encrypted: i=1; AJvYcCVyNnxWGyGDusi4TDnzb0RWh/Xab1Y/SDYqmO1UWO3zEwRnIii91uBQhoM7YNVkKdnccx8K5+TkRnyNVFXrx1U6jkSfn6oTUndm9ion
X-Gm-Message-State: AOJu0YwLRRGugSV+QVgGLGonGjx4/cq4P7jkihcplVnuKOIyd0k3QVey
	or6tHPkh3KisCUMi0NFxZXmSevyb/0najeqHJZ7gwnBlp1+2l6InaP24ZVK2cyg=
X-Google-Smtp-Source: AGHT+IHWnxZNqXZ1SGo+mGVv7HNnRx0Hhmvx0BuVkUP+E5tcTPeL7ScL9H0p8kyWYeFnrqdFaetEKQ==
X-Received: by 2002:a05:620a:404b:b0:79d:6169:7ab9 with SMTP id af79cd13be357-7a1e53196bfmr1483800485a.68.1722351721635;
        Tue, 30 Jul 2024 08:02:01 -0700 (PDT)
Received: from soleen.c.googlers.com.com (197.5.86.34.bc.googleusercontent.com. [34.86.5.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73efffdsm645934285a.69.2024.07.30.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:02:01 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev,
	peterz@infradead.org,
	nphamcs@gmail.com,
	cerasuolodomenico@gmail.com,
	surenb@google.com,
	lizhijian@fujitsu.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	vbabka@suse.cz,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yosryahmed@google.com
Subject: [PATCH v5 0/3] Kernel stack usage histogram
Date: Tue, 30 Jul 2024 15:01:55 +0000
Message-ID: <20240730150158.832783-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide histogram of stack sizes for the exited threads:
Example outputs:
Intel:
$ grep kstack /proc/vmstat
kstack_1k 3
kstack_2k 188
kstack_4k 11391
kstack_8k 243
kstack_16k 0

ARM with 64K page_size:
$ grep kstack /proc/vmstat
kstack_1k 1
kstack_2k 340
kstack_4k 25212
kstack_8k 1659
kstack_16k 0
kstack_32k 0
kstack_64k 0

Changelog:
v6:
- Addressed a comment from Yosry Ahmed, renamed IS_INVALID(idx) to
  BAD_STAT_IDX(index), also made it more relaxed (>= instead of ==).
- Added Acked-bys Shakeel Butt

Pasha Tatashin (2):
  vmstat: Kernel stack usage histogram
  task_stack: uninline stack_not_used

Shakeel Butt (1):
  memcg: increase the valid index range for memcg stats

 include/linux/sched/task_stack.h | 18 ++--------
 include/linux/vm_event_item.h    | 24 ++++++++++++++
 kernel/exit.c                    | 57 ++++++++++++++++++++++++++++++++
 kernel/sched/core.c              |  4 +--
 mm/memcontrol.c                  | 50 ++++++++++++++++------------
 mm/vmstat.c                      | 24 ++++++++++++++
 6 files changed, 137 insertions(+), 40 deletions(-)

-- 
2.46.0.rc1.232.g9752f9e123-goog


