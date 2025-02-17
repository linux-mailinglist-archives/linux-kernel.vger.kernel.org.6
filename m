Return-Path: <linux-kernel+bounces-514573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9807A358B7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A11188C249
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87084224B00;
	Fri, 14 Feb 2025 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkW5UjGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB06622256C;
	Fri, 14 Feb 2025 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521116; cv=none; b=OBexoukCh8wtCBbIXh/lS8aOmgPdoyAOdU+7EWkI2R1+FfRkX/Dw9fmo2hi81M3qmKkH9jL+J0QTSFbHpwRu8jVGg5XlkjG1oUVblTzwkzAvegZZnDfG/8VC2xDF7ntnyxvSi4vUgFs/1d+cHifUkwXq2TNLpl7usQrLqB2UzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521116; c=relaxed/simple;
	bh=xl1RxIPlL8WV/QUkGzOzNrCPqAGUw2t+vphKlojUgdE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TCcAvoG1vOj7gI5SBQQ3GmokhkYomqtu9qQv44/pUCA+kJC/qdh4LFeJy1PMJ3dej+6PAruqHUY/iUAe5LrBbfxoXh7e5Wc+aPsYocP8Xq9i4BzxdHUPC8ayFVKtJ3MYlSajLIpZfYKEmbC9K2ZqF4gBHc8frIXybhtLp2bH/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkW5UjGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D16CC4CEE2;
	Fri, 14 Feb 2025 08:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739521116;
	bh=xl1RxIPlL8WV/QUkGzOzNrCPqAGUw2t+vphKlojUgdE=;
	h=Date:From:To:Cc:Subject:From;
	b=QkW5UjGNu6QsrKnL+dkqcKsg61pKX5DaCoV2sCMWkHssVlGqsFp/Jk9utxirp4rOR
	 tIL8V0DLTPQIa+OMH6eFSpXCaL4KRcSv3OQ6KvXgx+F7GD4DfzrkYi5SZzCgj8srNq
	 K4SX10MjQLNPT6FvBvLWip0sNHr/MnTTLdT3q4COjqgO2Lp7JhY40LAnCkxePZaTgz
	 UOvtqOQ8EFMMF5eCG2+yyF76tiexYgHuwlShKArDwjEgq9QPVsYHcYskZVUm3p9VkW
	 XesTAaglJ7J7yK0lqk+RYJAyHr5lEo9RkLh2khShk8UW4qucl8OwpLACN2kKVfNZK6
	 CezKxhufqBZ4g==
Date: Fri, 14 Feb 2025 18:48:20 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/amd/pm: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z678TNhCbTk363Tw@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

So, in order to avoid ending up with a flexible-array member in the
middle of other structs, we use the `struct_group_tagged()` helper
to create a new tagged `struct NISLANDS_SMC_SWSTATE_HDR` (and `struct
SISLANDS_SMC_SWSTATE_HDR`). This structures group together all the
members of the flexible `struct NISLANDS_SMC_SWSTATE` (and `struct
SISLANDS_SMC_SWSTATE`) except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct members currently causing
trouble from `struct NISLANDS_SMC_SWSTATE` to `struct
NISLANDS_SMC_SWSTATE_HDR` (and from `struct SISLANDS_SMC_SWSTATE` to
`struct SISLANDS_SMC_SWSTATE_HDR`).

We also want to ensure that when new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that
the memory layout for both the flexible structure and the new tagged
struct is the same after any changes.

This approach avoids having to implement `struct NISLANDS_SMC_SWSTATE_HDR`
(and `struct SISLANDS_SMC_SWSTATE_HDR`) as a completely separate structure,
thus preventing having to maintain two independent but basically identical
structures, closing the door to potential bugs in the future.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which we can access the flexible-array
member, if necessary.

So, with this changes, fix the following warnings:

drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/sislands_smc.h:218:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.h:819:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.h:818:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.h:817:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.h:816:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  7 ++++--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h    | 23 +++++++++++--------
 .../gpu/drm/amd/pm/legacy-dpm/sislands_smc.h  | 15 ++++++++----
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index a87dcf0974bc..2c9d473d122f 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -5234,7 +5234,8 @@ static int si_init_smc_table(struct amdgpu_device *adev)
 
 	table->driverState.flags = table->initialState.flags;
 	table->driverState.levelCount = table->initialState.levelCount;
-	table->driverState.levels[0] = table->initialState.level;
+	container_of(&table->driverState, SISLANDS_SMC_SWSTATE, __hdr)->levels[0] =
+								table->initialState.level;
 
 	ret = si_do_program_memory_timing_parameters(adev, amdgpu_boot_state,
 						     SISLANDS_INITIAL_STATE_ARB_INDEX);
@@ -5755,7 +5756,9 @@ static int si_upload_sw_state(struct amdgpu_device *adev,
 	int ret;
 	u32 address = si_pi->state_table_start +
 		offsetof(SISLANDS_SMC_STATETABLE, driverState);
-	SISLANDS_SMC_SWSTATE *smc_state = &si_pi->smc_statetable.driverState;
+	SISLANDS_SMC_SWSTATE *smc_state =
+		container_of(&si_pi->smc_statetable.driverState,
+			     SISLANDS_SMC_SWSTATE, __hdr);
 	size_t state_size = struct_size(smc_state, levels,
 					new_state->performance_level_count);
 	memset(smc_state, 0, state_size);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
index 11cb7874a6bb..62530f89ebdf 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
@@ -784,12 +784,17 @@ typedef struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL NISLANDS_SMC_HW_PERFORMANCE_LEV
 
 struct NISLANDS_SMC_SWSTATE
 {
-    uint8_t                             flags;
-    uint8_t                             levelCount;
-    uint8_t                             padding2;
-    uint8_t                             padding3;
-    NISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
+	/* New members MUST be added within the struct_group() macro below. */
+	struct_group_tagged(NISLANDS_SMC_SWSTATE_HDR, __hdr,
+		uint8_t                             flags;
+		uint8_t                             levelCount;
+		uint8_t                             padding2;
+		uint8_t                             padding3;
+	);
+	NISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
 };
+static_assert(offsetof(struct NISLANDS_SMC_SWSTATE, levels) == sizeof(struct NISLANDS_SMC_SWSTATE_HDR),
+	      "struct member likely outside of struct_group_tagged()");
 
 typedef struct NISLANDS_SMC_SWSTATE NISLANDS_SMC_SWSTATE;
 
@@ -813,10 +818,10 @@ struct NISLANDS_SMC_STATETABLE
     uint32_t                            lowSMIO[NISLANDS_MAX_NO_VREG_STEPS];
     NISLANDS_SMC_VOLTAGEMASKTABLE       voltageMaskTable;
     PP_NIslands_DPM2Parameters          dpm2Params;
-    NISLANDS_SMC_SWSTATE                initialState;
-    NISLANDS_SMC_SWSTATE                ACPIState;
-    NISLANDS_SMC_SWSTATE                ULVState;
-    NISLANDS_SMC_SWSTATE                driverState;
+    struct NISLANDS_SMC_SWSTATE_HDR		initialState;
+    struct NISLANDS_SMC_SWSTATE_HDR		ACPIState;
+    struct NISLANDS_SMC_SWSTATE_HDR		ULVState;
+    struct NISLANDS_SMC_SWSTATE_HDR		driverState;
     NISLANDS_SMC_HW_PERFORMANCE_LEVEL   dpmLevels[NISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE - 1];
 };
 
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h b/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
index 90ec411c5029..1711e3e35e80 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
@@ -172,12 +172,17 @@ struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL {
 typedef struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL SISLANDS_SMC_HW_PERFORMANCE_LEVEL;
 
 struct SISLANDS_SMC_SWSTATE {
-	uint8_t                             flags;
-	uint8_t                             levelCount;
-	uint8_t                             padding2;
-	uint8_t                             padding3;
+	/* New members MUST be added within the struct_group() macro below. */
+	struct_group_tagged(SISLANDS_SMC_SWSTATE_HDR, __hdr,
+		uint8_t                             flags;
+		uint8_t                             levelCount;
+		uint8_t                             padding2;
+		uint8_t                             padding3;
+	);
 	SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
 };
+static_assert(offsetof(struct SISLANDS_SMC_SWSTATE, levels) == sizeof(struct SISLANDS_SMC_SWSTATE_HDR),
+	      "struct member likely outside of struct_group_tagged()");
 
 typedef struct SISLANDS_SMC_SWSTATE SISLANDS_SMC_SWSTATE;
 
@@ -215,7 +220,7 @@ struct SISLANDS_SMC_STATETABLE {
 	struct SISLANDS_SMC_SWSTATE_SINGLE	initialState;
 	struct SISLANDS_SMC_SWSTATE_SINGLE	ACPIState;
 	struct SISLANDS_SMC_SWSTATE_SINGLE	ULVState;
-	SISLANDS_SMC_SWSTATE			driverState;
+	struct SISLANDS_SMC_SWSTATE_HDR		driverState;
 	SISLANDS_SMC_HW_PERFORMANCE_LEVEL	dpmLevels[SISLANDS_MAX_SMC_PERFORMANCE_LEVELS_PER_SWSTATE];
 };
 
-- 
2.43.0


