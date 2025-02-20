Return-Path: <linux-kernel+bounces-523578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB33A3D8A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF58F3A4E56
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DCB1E3DCF;
	Thu, 20 Feb 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4Hq1uHr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD85223
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050903; cv=none; b=QoIlIHuLKKK6Bna7/bUqPHX1gkDVEASNSWCaRbzSjqYes82DuG4tAx0njttjYBCZZmOeJ/QhJHTETKxZNbZnUVPu0kwoCctJCgMl1L0uDD5b126gqwO/Rci1lXZECNA+U/hYuiDSV8E1QbYSC5z5lrUXpCWW5MC5ao/trCbvfQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050903; c=relaxed/simple;
	bh=JDB0yEuPVkvAyMz7TDwn8wLKPDLpB7CukMSdFDh9uKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0HWV/4QFnbL5b/L4fuac8SNLEt8pOKDjs8F/sC4gNE7MLPwpykRxj6q5xPu8aUQ/E1AY76eRSz31a5KXcfaq66y4QLsJPzif1kHCcHz6xB1uQ1cg7Hr7yMCD0B7ciOhqge7eD3cuv1vN/eFxfSxLUP3Aa/72u4jLygrFm3SLvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4Hq1uHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBFAC4CED1;
	Thu, 20 Feb 2025 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050902;
	bh=JDB0yEuPVkvAyMz7TDwn8wLKPDLpB7CukMSdFDh9uKQ=;
	h=From:To:Cc:Subject:Date:From;
	b=q4Hq1uHrh/jj9PjoUlaXaPuSrfwJpj7bckJ54hKBP/dzpToM0O29jPKXU4X08nX3e
	 qbYWs9Jfc2Kjj2jKuflhYXWFMON9WgxDbUp/I5gWH3r0DXYa5w+Htl8LpdhqSTdilo
	 AvyMYVOwbNMIlakWtsqrEPiBFBpjmHJ8AnPw+5mLkf5ze+nDezpSandxM+8/ot6Qsl
	 nnQW2eoUBp2FbbY+Ib9eyRNZBiUkOlNnf7YGsUs87YOXR3g5iAT2Kdy+WqZn2m6jH4
	 SaRKksH1QeLrDr0gHeci47kZrnroQu8Jqg+aRNceBgkLSlCGVbnJj72tfqJ+2sCjja
	 GTNmo37HcjA7w==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] drm/sched: Documentation and refcount improvements
Date: Thu, 20 Feb 2025 12:28:11 +0100
Message-ID: <20250220112813.87992-2-phasta@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v5:
  - Fix broken enumarated list in timedout_job's docu.
  - Add TODO for documenting the dma_fence rules in timedout_job one
    day.

Changes in v4:
  - Remove mention of vague "dma_fence rules" in timedout_job() again
    since I couldn't get input on what those rules precisely are.
  - Address a forgotten TODO. (Me)
  - Reposition "Return:" statements to make them congruent with the
    official kernel style. (Tvrtko)
  - Change formatting a bit because of crazy make htmldocs errors. (Me)

Changes in v3:
  - timedout_job(): various docu wording improvements. (Danilo)
  - Use the term "ring" consistently. (Danilo)
  - Add fully fledged docu for enum drm_gpu_sched_stat. (Danilo)

Changes in v2:
  - Document what run_job() is allowed to return. (Tvrtko)
  - Delete confusing comment about putting the fence. (Danilo)
  - Apply Danilo's RB to patch 1.
  - Delete info about job recovery for entities in patch 3. (Danilo, me)
  - Set the term "ring" as fix term for both HW rings and FW rings. A
    ring shall always be the thingy on the CPU ;) (Danilo)
  - Many (all) other comments improvements in patch 3. (Danilo)

This is as series succeeding my previous patch [1].

I recognized that we are still referring to a non-existing function and
a deprecated one in the callback docu. We should probably also point out
the important distinction between hardware and firmware schedulers more
cleanly.

Please give me feedback, especially on the RFC comments in patch3.

(This series still fires docu-build-warnings. I want to gather feedback
on the opion questions first and will solve them in v2.)

Thank you,
Philipp

[1] https://lore.kernel.org/all/20241220124515.93169-2-phasta@kernel.org/

Philipp Stanner (3):
  drm/sched: Document run_job() refcount hazard
  drm/sched: Adjust outdated docu for run_job()
  drm/sched: Update timedout_job()'s documentation

 drivers/gpu/drm/scheduler/sched_main.c |   5 +-
 include/drm/gpu_scheduler.h            | 109 +++++++++++++++++--------
 2 files changed, 76 insertions(+), 38 deletions(-)

-- 
2.47.1


