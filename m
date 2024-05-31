Return-Path: <linux-kernel+bounces-196769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 358658D61A7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DD11C2406E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722CB1586C7;
	Fri, 31 May 2024 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChR9DDyZ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2594B15821A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158315; cv=none; b=QTE66cVQ76kvThSfREnNDjIMQH/UQ/MuCBW747lano2YyZsgXEZYoUfm/7PNIkwb8kHELffgFt0K+4m5dhuZqreLF7/aRjmMLgwXnVXm31GF1K6SezeIjgzfS4HuA5Ct4PS+ihlObev8a9I/kTy5f6YWfUKLdMaML1cTZ9933Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158315; c=relaxed/simple;
	bh=Xu57Mic/VAKaleyjNmq1lGIViGbB5waeZAH4tcozFGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=py0EvAij9VC8d6Yj1Ep17mabS+nS3y7J1B4SxuwMQ8oZ9HXSBnMl0N7W2J040/bUuem2r7mfmurcC4pm3pEd/NeBKryJ67HIDPAH9T6oZF7HfLO1C8ZbBKSbI3FG2sqTtOl1KVGuws9nNFi3OaXK9wybvS4cHS9CtORFsitIK3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChR9DDyZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b78c65cadso2630959e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 05:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717158312; x=1717763112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7dB1Vaphz7QEh8gd4ZhHWs9xIKs+tgKhKDy/GfFnHg=;
        b=ChR9DDyZub9iLsWmmpJ+SB4I1qSuu73N+5aoeW902/Ci2rTqThINgjuGo27r8Xz1J3
         0xjWpVlBUN2f8u80ULhU1fyFbrU0M6uoWQpVFul3hwAC26RuESSbZxKwJT0QltB+ozK6
         HIPDRet8wpsKFcelOzOwJPDNrA4Jkp24PEJg8aSh7b24cyM031iG7lk3oBRVCDSNT2TL
         LaF1fmsPZMa/0dcuANqQs96dffw+Ft99VK1VgGgAx9xQk3FEuulNLJVJaA49MI+F2OJo
         0bdIDjGakS/SGokX1iXSc0cDPtHn90loS0MBriakmVhu7Tw5FAg1XDnA+iER5E7xGUD0
         jdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717158312; x=1717763112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7dB1Vaphz7QEh8gd4ZhHWs9xIKs+tgKhKDy/GfFnHg=;
        b=czYKqubBTjS1vkcin0t4OiMfTtP15lZ8N7zcY4c1Iu3ZuC95j6ZPqhsjA6Kzr2mxIZ
         mND5LdrqV4zKjwcVHtyDWIFy91vjT6vWiQNuTlb4bLANITgn0rM1i85ev7pOMcFqszG1
         McgI2VE95jPrfhVcm/3VpjafQfvClYq4zCUzPZEHWC3i8plrPhI1i0N7rsGasnSNAF1w
         ax8r0r3M+pUt6l/mTchVB+dZMOApTAs+z6YPYsFtUnTDz5vP0aea2siHQyR6XjSca1H9
         1d4dIkkQ+fAtpa0cPNJNXshHZ01yLRAr4Yw0IqO5UWl+tj05Odx/aNM1fjweImzkNAlL
         FYbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuJC51tRRV36b3Yvl72iByXEeMEwVor7Wtrd49giA2IOdjligZ5Qn461HLTDuLNf3c3B+r+ctBs1NIpmsEW3kDl3sAedSqC6b8xd4T
X-Gm-Message-State: AOJu0YwSpzZe1Kf6IaXd5kp3xFTl/AqMoUtnHWeZOnTDCzGmnsnuAy8j
	XN8mFwl98kTV+8AKhF+jIaQLW4qK3I9++oy8k07YkQR6+uG9EGAy
X-Google-Smtp-Source: AGHT+IFDJf8CDdfg5tectpVEIPPxxiv3USawMSYJR1CnwC0UYvEK8mgBZOpp08KjenScRFalwvicoQ==
X-Received: by 2002:ac2:4989:0:b0:52a:e2cf:b00b with SMTP id 2adb3069b0e04-52b8957ea21mr1255904e87.27.1717158311981;
        Fri, 31 May 2024 05:25:11 -0700 (PDT)
Received: from localhost.localdomain ([176.59.170.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b8ce24d60sm71688e87.290.2024.05.31.05.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 05:25:11 -0700 (PDT)
From: Alex Rusuf <yorha.op@gmail.com>
To: damon@lists.linux.dev
Cc: sj@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] DAMON multiple contexts support
Date: Fri, 31 May 2024 15:23:18 +0300
Message-ID: <20240531122320.909060-1-yorha.op@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Currently kdamond uses only one context per kthread
and most of its time it sleeps, so utilizing several
contexts can scale kdamond and allow it to use
another set of operations.

This patch-set implements support for multiple contexts
per kdamond.

In pseudo code previous versions worked like
the following:

	while (!kdamond_should_stop()) {

		/* prepare accesses for only 1 context */
		prepare_accesses(damon_context);

		sleep(sample_interval);

		/* check accesses for only 1 context */
		check_accesses(damon_context);

		...
	}

With this patch kdamond workflow will look
like the following:

	while (!kdamond_shoule_stop()) {

		/* prepare accesses for all contexts in kdamond */
		damon_for_each_context(ctx, kdamond)
			prepare_accesses(ctx);

		sleep(sample_interval);

		/* check_accesses for all contexts in kdamond */
		damon_for_each_context(ctx, kdamond)
			check_accesses(ctx);

			...
	}

To try this you can use modified kernel[1] and
damo[2]. I also have written few simple shell scripts[3]
to collect data for damo.

	[1] https://github.com/onlyoneofme/damon-multi-contexts.git
	[2] https://github.com/onlyoneofme/damo/tree/multi-contexts
	[3] https://github.com/onlyoneofme/damon-multi-contexts-tests.git

---
Changes from v1 (https://lore.kernel.org/damon/20240515152457.603724-1-yorha.op@gmail.com/)
- Compatibility for DebugFS interface is kept
- Kunit tests build/execution issues are fixed
- Patches from v1 are sqaushed, so that consistency between patches is
kept
- Added/Fixed comments about data structures/functions

Alex Rusuf (2):
  mm/damon/core: add 'struct kdamond' abstraction layer
  mm/damon/core: implement multi-context support

 include/linux/damon.h        |  80 ++++--
 include/trace/events/damon.h |  14 +-
 mm/damon/core-test.h         |   2 +-
 mm/damon/core.c              | 509 ++++++++++++++++++++++-------------
 mm/damon/dbgfs-test.h        |   4 +-
 mm/damon/dbgfs.c             | 342 ++++++++++++++---------
 mm/damon/lru_sort.c          |  31 ++-
 mm/damon/modules-common.c    |  35 ++-
 mm/damon/modules-common.h    |   3 +-
 mm/damon/reclaim.c           |  30 ++-
 mm/damon/sysfs.c             | 303 +++++++++++++--------
 11 files changed, 872 insertions(+), 481 deletions(-)

-- 
2.42.0


