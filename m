Return-Path: <linux-kernel+bounces-547878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDDAA50E9B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E707F18828D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16954268688;
	Wed,  5 Mar 2025 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COhYSUvA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694C267B96;
	Wed,  5 Mar 2025 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213669; cv=none; b=GwoFBpmB/hHNW1ZmmhHO4vk/6z+HzefaWq+QTQutgz7Jo1E4FD/g4yg80E3jb4lIo7h1/Clsa0bjb6cd735/JjfPuOWg3nsD/Fvj+LL5syrPWDIRsF0aBbGT0zNQf26c0r4PznyePiaIorUmKXuMrhMQOEDV08bqB0t0EsiEV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213669; c=relaxed/simple;
	bh=OAEdxxcc77GPmmDMbh1z2HLH683wgymD1nDX7vY4PmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OHV2E+OdqRiu3t4JH+QU0Pvcb/v9yonCxop1NoHeugTSYrKB+++d4l02+d6Z66BtAVXYlSJrpyV6AByUQbrtuwx89PcRJWTkS4lfFzzeN5BRi81mootu5Gtl4GbD9JbLr1zN13HnjmZCYsVYu1HT25O+vy+BCCyjLah/hSSKYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COhYSUvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88FDC4CED1;
	Wed,  5 Mar 2025 22:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741213668;
	bh=OAEdxxcc77GPmmDMbh1z2HLH683wgymD1nDX7vY4PmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=COhYSUvAzM/kIrKA3AIr4Du9Hvlu5Te9LUGuEq19YnsUYn+PHUT0LxZhrJmHssQsI
	 et8zSnnECgIb7CdD5fvIWqT3R5MCm/24gFhlfqXJ6+O0McSyoQ/zQ+JX/7+K5gdDXc
	 QwQhf5D79gWHRKx5mVtzCCihKUd7L9O6MI8G9Ui6MTwscIV8FyIOhPOD8ZuUW0Z3sm
	 +cnwGnXSdSxrpWRAM7UoDPJiIRxNWMQW7CgSW1pa51z/5kKecxY2D13ySCj4WWYzgv
	 T7raOiUiRed2NbTygrroHjrA3EX035XF/A6iJyrxlBZX5Q9wZmmyAqHKaRLVRkjaBa
	 06oAFx4nWGOww==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7/8] Docs/ABI/damon: document {core,ops}_filters directories
Date: Wed,  5 Mar 2025 14:27:32 -0800
Message-Id: <20250305222733.59089-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305222733.59089-1-sj@kernel.org>
References: <20250305222733.59089-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new DAMOS filters sysfs directories on ABI doc.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 76da77d7f7b6..293197f180ad 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -409,6 +409,22 @@ Description:	Writing 'Y' or 'N' to this file sets whether to allow or reject
 		applying the scheme's action to the memory that satisfies the
 		'type' and the 'matching' of the directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/core_filters
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Directory for DAMON core layer-handled DAMOS filters.  Files
+		under this directory works same to those of
+		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters
+		directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/ops_filters
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Directory for DAMON operations set layer-handled DAMOS filters.
+		Files under this directory works same to those of
+		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters
+		directory.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_tried
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.39.5

