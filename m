Return-Path: <linux-kernel+bounces-183838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E528C9EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBB3B221D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949313699B;
	Mon, 20 May 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b="b6KenT8M"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3DB1DDEA
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215460; cv=none; b=b19oPlhx44kkvB6ZqZIDLnA5f+RGOy0IHom2LwNEmnjWFXkKWQstkOAak1JJvK8+Ow15OdOwQqmgNIyRZsYJ6/tHvKL4qMBwYl7vu951BddT/d9JU4SHsahOABF6fyoUYkZQ/YopEA+T3vg4bHDsMTkefGCS/mu9IDdLtr4RJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215460; c=relaxed/simple;
	bh=On9o3LYnuqveZn6sVFXBJrcrNEr4DuCBwisKbjYduqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fb7uYljam/R7ea1kvip+LM2SfXsrOdG3pYBK2C9/QCmhDPEcd2PFCxaddb7isJw2y6iAYau2rwsyYH6zzSF/U5JMUDpmqz3l0WrtkFGbGMwDGxZxbCuj9xHX91AEIO6bD79/N6gDgQCDZVLtSFLTOZ68/2mLJjbnVDVE+uVp6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr; spf=pass smtp.mailfrom=ajou.ac.kr; dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b=b6KenT8M; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ajou.ac.kr
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f44d2b3130so1234865b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google; t=1716215457; x=1716820257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O6/FTo8DypMSA2iS27jq2soJuWf60KYz1PensegxJFM=;
        b=b6KenT8MqKhSPeJ6PXptmQSS3KuXhAD321R8kcL0/FA/7b29dfB9n+nR8YMQTIF/EI
         24qQmuOwYHD5B4x3HvPrsR+tyN3JQFma+9zQD2cBxaxZZINso0WHqPnrqQEYMbCLX1bU
         X1oKrrPm4mvFIhe1cPQGeg8EWNhGU9geW/KTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716215457; x=1716820257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6/FTo8DypMSA2iS27jq2soJuWf60KYz1PensegxJFM=;
        b=Fk+sXNjsq0wwh+eAsAlUzMXkwXZmO7nINWzEeblXFegYJvyiMQWETr9d5IlAePwnLk
         X0EWAjBy1aCrIrzSXVNp0qqJT2dN97EwLOxgGbwJOPhSQ/Dze6qlO9kPTnoMyBdJ746H
         rKlO74o3YGkv+Yn7B+cxPaOEjAkpkyReyf1R1ILWaHTOmq/7Q891/Wf7Wo6DtAifGJ3q
         Wj7INrMGxk6ModmGYQI96xO7QyKGmBRdVxe7kfWshr6LenIGUrLGA+4ujyj2tVceHHk1
         p8XVJl139vM8yBajEDtNu9ybesfZG55okhZbM4EHx7GKHHB/u9+zi6K6Fj2xCWyAHfF5
         aEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu8qXx8vhAxhtgCdQUpIEDEM6sTvjtiMqy6XprJnBsoeIfTyLTMAF0dx1g4IgGQ4zTqzLEmODjSitA2YB8NX4u8/f2nbp3ePPG08SF
X-Gm-Message-State: AOJu0YyWyxJGsW/5x4g7MNHhAidqu02iE3nUGJ+76aFeDMSNvJvX0pYJ
	rTEmusEFyV0veLZ0zOpaCmm6bvGZmLkMdTZRxY323bc1VITlg6CHxe5kFUinDVWSFXtEWcTk52K
	7Thc=
X-Google-Smtp-Source: AGHT+IGh6OTBqd7LzPxRAdZQ3TGtw9oZWZ1eNfXRW7gHa0BL/LuIXVhBeDfCAYMGPVqaaE4rw+HrUQ==
X-Received: by 2002:a05:6a00:1901:b0:6ec:cec1:8fe3 with SMTP id d2e1a72fcca58-6f4e02ac5a3mr34376599b3a.11.1716215456568;
        Mon, 20 May 2024 07:30:56 -0700 (PDT)
Received: from swarm07.ajou.ac.kr ([210.107.197.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2aa017dsm19714531b3a.96.2024.05.20.07.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 07:30:56 -0700 (PDT)
From: Jonghyeon Kim <tome01@ajou.ac.kr>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Jonghyeon Kim <tome01@ajou.ac.kr>
Subject: [RFC PATCH v2 0/3] Add NUMA-aware DAMOS watermarks
Date: Mon, 20 May 2024 14:30:35 +0000
Message-Id: <20240520143038.189061-1-tome01@ajou.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current DAMOS schemes are not considered with multiple NUMA memory nodes.
For example, If we want to proactively reclaim memory of a one NUMA node,
DAMON_RECLAIM has to wake up kdamond before kswapd does reclaim memory.
However, since the DAMON watermarks are based on not a one NUMA memory
node but total system free memory, kdamond is not waked up before invoking
memory reclamation from kswapd of the target node.

These patches allow for DAMON to select monitoring target either total
memory or a specific NUMA memory node.

---
Changes from RFC PATCH v1
(https://lore.kernel.org/all/20220218102611.31895-1-tome01@ajou.ac.kr)
- Add new metric type for NUMA node, DAMOS_WMARK_NODE_FREE_MEM_RATE
- Drop commit about damon_start()
- Support DAMON_LRU_SORT

Jonghyeon Kim (3):
  mm/damon: Add new metric type and target node for watermark
  mm/damon: add module parameters for NUMA system
  mm/damon: add NUMA-awareness to DAMON modules

 include/linux/damon.h     | 11 +++++++++--
 mm/damon/core.c           | 11 ++++++++---
 mm/damon/lru_sort.c       | 14 ++++++++++++++
 mm/damon/modules-common.h |  4 +++-
 mm/damon/reclaim.c        | 14 ++++++++++++++
 mm/damon/sysfs-schemes.c  | 35 +++++++++++++++++++++++++++++++++--
 6 files changed, 81 insertions(+), 8 deletions(-)

-- 
2.34.1


