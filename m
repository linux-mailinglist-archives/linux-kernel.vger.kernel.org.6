Return-Path: <linux-kernel+bounces-192423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CE08D1D12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D6E1F2617D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E0916F82F;
	Tue, 28 May 2024 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tyc6h+vy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2894A17C7F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903178; cv=none; b=H77ZkDz05O7C3zf5yVEF8IQ7zI+m73UZM+1+NdjQhd0q33C6bDw6RquBU9IqogYu0CAR+NN/q+qzvP6DhdKhu/+cA+IrD8j6lMSy/ggGmiGMWTTmn9qDL1qTu9/G+62tuIimuSr2jAILbjZkSBjYvzK1fwbHwyE5LFSt2cdKzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903178; c=relaxed/simple;
	bh=Dz+CC+JZWQtuG8vRgbBmaJAyi+jOVLXABQMl0q6O1kM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sg7kmU0Pi3QJoH4hhc9aj7i4/VqaKRYORoGibWbS3n2z5iw9iAKPDQ/KRkiHcW3QBL1wcLvo2hToYRbEBR86O0t8p+eUohLV2rQLVL61g4LqJHW8CmBl1PGjtmVtB8j7U1fwjVNXJuc2zWet4hpB4B7kzgvMKWTWv9BiaEqw/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tyc6h+vy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E656C3277B;
	Tue, 28 May 2024 13:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716903177;
	bh=Dz+CC+JZWQtuG8vRgbBmaJAyi+jOVLXABQMl0q6O1kM=;
	h=From:To:Cc:Subject:Date:From;
	b=Tyc6h+vyN/0ZtgmqlBVQivGgvzaHDwhnURTNTqAzCNT1CAUF4+XoAWWP9zIVozyWh
	 JaEUiYWPKRClmYh7/hg8fx0BhqsyfmzRPFKrsIlNebfX4kyQkuA7VP1suJrYUwfiuq
	 FcB2RZi/cn6mo1q8HsxG5a3nOV89f6WZN6sQpi1HI2LOy+ifhc8MWSrxO/X90ljkgR
	 DRKZuzwiwHV3WpPXA4HWBW720Xyhrk/4Nmw+tB/JG4BNOGbFmsuo7HSMYxoN1j3tjG
	 CjQgVM3G606etOfuHQc1B+i8n96rmS5SmhLVIR596pmD4YIGfOrWwc0cUs5Y2BclbN
	 ujPRZU2Cl+dEQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/xe: replace format-less snprintf() with strscpy()
Date: Tue, 28 May 2024 15:32:36 +0200
Message-Id: <20240528133251.2310868-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Using snprintf() with a format string from task->comm is a bit
dangerous since the string may be controlled by unprivileged
userspace:

drivers/gpu/drm/xe/xe_devcoredump.c: In function 'devcoredump_snapshot':
drivers/gpu/drm/xe/xe_devcoredump.c:184:9: error: format not a string literal and no format arguments [-Werror=format-security]
  184 |         snprintf(ss->process_name, sizeof(ss->process_name), process_name);
      |         ^~~~~~~~

In this case there is no reason for an snprintf(), so use a simpler
string copy.

Fixes: b10d0c5e9df7 ("drm/xe: Add process name to devcoredump")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/xe/xe_devcoredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 1643d44f8bc4..1973bfaece40 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -181,7 +181,7 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
 		if (task)
 			process_name = task->comm;
 	}
-	snprintf(ss->process_name, sizeof(ss->process_name), process_name);
+	strscpy(ss->process_name, process_name);
 	if (task)
 		put_task_struct(task);
 
-- 
2.39.2


