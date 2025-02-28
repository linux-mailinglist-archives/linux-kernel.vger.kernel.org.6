Return-Path: <linux-kernel+bounces-539537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DC4A4A59E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A14918882DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45C91DE3A8;
	Fri, 28 Feb 2025 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwbR1DRq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3E1DE2C9;
	Fri, 28 Feb 2025 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780223; cv=none; b=PyuOjnTXX6088x32NX2LipzPntZvoeJ6LBe2+zbw91WWU8Sj81r7qYP/pkeOvCrLwPrgAplV/qaeRwRdFyuxrmVH5ZNO5MeVUyamr/dY79pFfWngPxPSbinN2CHA9JoivGMChCZSMP8aPllBKP7vRw0h6+di/BROUPpSqnjSDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780223; c=relaxed/simple;
	bh=B70HmhIJO7Eh/CP1TQGw5euMpvWBGHv7eOKxBRU5Z5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tMpi+zzxrsyxy3GtSJbUatR/nNy1khOI4AM0VHcj+3J6QJRG3pFXsf0hrxO1UeXJj8Lx/lzZAAMpNrcj0FIqU2tsp2DFnYXSwwSFZJJNNDe441CrS2TNcEr/JkqkTArhLFV7fh+uKgITReZ5CKYLgs56S+NlA2Tg0sB/AqmHcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwbR1DRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA81AC4CEE2;
	Fri, 28 Feb 2025 22:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740780222;
	bh=B70HmhIJO7Eh/CP1TQGw5euMpvWBGHv7eOKxBRU5Z5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IwbR1DRqnyn+hhaN7l8cEj7lEPg+iYG8BDSQFmBJ0uc5SgEbwpsfOS+vQ3X/N1P1R
	 FKmdUpSI67JyQy+A6WTma7/nvUtqicF4UABpFa5V2aeuOVDBdxHivm37a2hKwqw4nt
	 tKW2Qh5r9agqTfUF/0H0Setjo1SPsIUDp17vQTZC22SXxEP/XAtHHcShJhgcJhmkSd
	 bgKtbzzJEiOgwK4tdCnrNEXwkLnOfK8IGDTi4B0YG3Ayqn/eOwxQWp3rTXmT47E9yj
	 KsSbhVijI3bcFHkr6kiWd0oGvVZ+s1K/E+5J/WO78bPVdZxxbSFxfmGqL6HC0aU82H
	 7/ZFu9VMp1Tvg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 7/8] Docs/ABI/damon: document intervals auto-tuning ABI
Date: Fri, 28 Feb 2025 14:03:27 -0800
Message-Id: <20250228220328.49438-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228220328.49438-1-sj@kernel.org>
References: <20250228220328.49438-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the DAMON user-space ABI for DAMON sampling and aggregation
intervals auto-tuning.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 9666074f06f3..293197f180ad 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -91,6 +91,36 @@ Description:	Writing a value to this file sets the update interval of the
 		DAMON context in microseconds as the value.  Reading this file
 		returns the value.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/access_bp
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the monitoring intervals
+		auto-tuning target DAMON-observed access events ratio within
+		the given time interval (aggrs in same directory), in bp
+		(1/10,000).  Reading this file returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/aggrs
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the time interval to achieve
+		the monitoring intervals auto-tuning target DAMON-observed
+		access events ratio (access_bp in same directory) within.
+		Reading this file returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/min_sample_us
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the minimum value of
+		auto-tuned sampling interval in microseconds.  Reading this
+		file returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/max_sample_us
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the maximum value of
+		auto-tuned sampling interval in microseconds.  Reading this
+		file returns the value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/nr_regions/min
 
 WDate:		Mar 2022
-- 
2.39.5

