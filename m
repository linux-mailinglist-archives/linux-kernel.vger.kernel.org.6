Return-Path: <linux-kernel+bounces-528955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E618A41E65
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4AA9161CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CEF1853;
	Mon, 24 Feb 2025 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6+TNPRH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747E2192E2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398483; cv=none; b=nBMDmcx/AWhj2PbRWSLg3LcnwyxEGgF8Pa9duvmsAvtfp96RDsWehvv8SGPGS8JDo1i0pAnTM2JjpN6F2PoLCQhTrTMq+97T7vvNtbrCfZm8EbvSGXPY3dmhrB1PHgwkTemzz9LFJ+qiSzHo4vrp6xlNEybJuVCb/TMpuFwGUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398483; c=relaxed/simple;
	bh=fxMiXEwvEYtpygJ1ij157KpxsIg2tEqjLIfXNpOnxj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nX9dHotPqI4T8XezdaTMPPUlUGoWnjrgh14JuFQvXLUxqwuo8rZxMPUHKsHQisVTabBLK7KEkc9o+iCGWmVcaNKUJ6x9WTFbofrELXwnHa1ooELMJaYk9y87enECDfEz+LvOAgosjnuHAqsw4prtwlwOapJ827on/U5KwKOlKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6+TNPRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094C9C4CEE6;
	Mon, 24 Feb 2025 12:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398482;
	bh=fxMiXEwvEYtpygJ1ij157KpxsIg2tEqjLIfXNpOnxj8=;
	h=From:To:Cc:Subject:Date:From;
	b=a6+TNPRHFW3AUCIpwqNipO3TEPDmxa5Dufr2Nj0qRQd0FQ5fapvP8yxwFCjePT97M
	 mn/KyxqDIcw6kuYj5nagUmvNI8EPYMYvAfZkDLwoKTxCd/mf2MYQif/i1h0ElDX4su
	 HZQamevhAIsFu4TMSFV0K6x0T4H7WKaSXlhkk5bHuquKlTLszYz/yz/VvxJ8h7H3NO
	 9fg5SuQd6QewtgEyKDo39HBFSTQT8DbscpekrzTBUIWqvh3wxE8SN/F1jWK0dFjoRL
	 +2odQLIU1d2QqoBBfrJuXrqKkRLP5vVYdBJxTlXek3DB7tngoZnJbxqXChVJGxmlIn
	 QLjiIMoKmiYtA==
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
Subject: [PATCH v6 0/3] drm/sched: Documentation and refcount improvements
Date: Mon, 24 Feb 2025 13:01:02 +0100
Message-ID: <20250224120104.26211-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 include/drm/gpu_scheduler.h            | 110 +++++++++++++++++--------
 2 files changed, 81 insertions(+), 38 deletions(-)

-- 
2.48.1


