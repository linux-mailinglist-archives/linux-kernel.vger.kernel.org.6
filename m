Return-Path: <linux-kernel+bounces-546859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5812A4FFA9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD97817650F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F0E24A076;
	Wed,  5 Mar 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5XF2zMK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F62F24A070
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179962; cv=none; b=QDQfZQO6dImwW/qEgTpEc8QGuaLEqFkNeORQzkp7CVFwGV+tLT9tKXqPJVQXy+WXr+lzBVvihOXKC4blQA4YhVuwaszrq5Wfhj8nujZfBkXkWjUf8SbzRa1b0AVtjC6UQ6TGnp2tUfHoGKlOrbkArDHFad07LU9lNgKVZqHigF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179962; c=relaxed/simple;
	bh=LRCjF4OfWgUdrLVSHUh/AiNipL4Jl4BHFHjUmsczaPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUnvBEVuLFQ3M8KAOZoWtEBCllaoDC5PFZxrum0xvBBcCmu9oZMIw/EL+9yiVcPBcGENeLTV62CzuXTg93kgJAO6VkCHuYBvyM3vvQdFbM/aQNJ1WpMqpObhL9FxOfw48nAAdX1dNW+oydVUurhaM3ZDKeAJVdjbwPwDpjEtv7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5XF2zMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91318C4CEE2;
	Wed,  5 Mar 2025 13:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741179962;
	bh=LRCjF4OfWgUdrLVSHUh/AiNipL4Jl4BHFHjUmsczaPc=;
	h=From:To:Cc:Subject:Date:From;
	b=V5XF2zMKMXEtPOdlVG7l7pd12VGChbIQNQ5AB5iEyS+tHuTnHqnjeiqbcCAXikmNu
	 gyXxqunjIf6fq1tDfRtjCtu64Zl2cuc0n+RZdRhODtQsxqWlf+ye8GliRJUn0z0dBI
	 sTaWbdVoKHA0UuG+KQKl3FFecJQVi24DiKEAUYFkdYB3/9iBjvOWdExKg9LSK6IJz/
	 e6Iw+y6VGsbVMwAqb4U+x8we0SgXWrEqcgvnBeN//AJzi5Cf1UVFzehkqdF7Xl/nGX
	 smA8zlr+LH53gXy/LtkAw8I9VnfskSaRkdhO1av+M8nKi6FylC/LM6R2AqlVvNvEjd
	 cEOzc2mjJiPDg==
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
	Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] drm/sched: Documentation and refcount improvements
Date: Wed,  5 Mar 2025 14:05:49 +0100
Message-ID: <20250305130551.136682-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v7:
  - Add Christian's info about violated dma_fence rules. (Christian)
  - Fix some typos

Changes in v6:
  - Switch patches 1 and 2. (Maira)
  - Move section related to run_job() out of timedout_job() patch.
    (Maira).
  - Fix some places for correct crosslink references.
  - Add comment to inform about run_job() incrementing the refcount.
    (Danilo)

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
  drm/sched: Adjust outdated docu for run_job()
  drm/sched: Document run_job() refcount hazard
  drm/sched: Update timedout_job()'s documentation

 drivers/gpu/drm/scheduler/sched_main.c |   9 +-
 include/drm/gpu_scheduler.h            | 112 +++++++++++++++++--------
 2 files changed, 83 insertions(+), 38 deletions(-)

-- 
2.48.1


