Return-Path: <linux-kernel+bounces-393833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872849BA5FD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 15:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB94281B66
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E73B17085A;
	Sun,  3 Nov 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="K3/cR13p"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E2BE6C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730645392; cv=none; b=dQx41QBrUc/78P3qaS8vMmvwNFV73gWZXKpGMA4dRpYtKwTAHJxT+81T68pVP0Uoi4Z6PA3kRx5p4iX6ztIXQmrPYjj1sBZ9lOOeL9dGDbmkKq7ron/1dQGlAM76iNz8H16E+7ZtE3Hah4HNNbLmxvXpUe+ZaloUA750TVG0LVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730645392; c=relaxed/simple;
	bh=uABXwV59MV32aWcXwfesQBDS5fLvsJ7uii9Pje9rE6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSf3SFs+PZTIKwy9KCKPGJlFBvg0oujDjFX1hPNqg1i3BGcR27+xPJRCajkv4CeoPU0+Jj9vDBE/uhH+e+vjJqfBDbfbLhRH9BEienqxcbuPKrXcCoDYpezKhiv5Ga1mEzy+d6hjF20YaiAUkLjUPTnQNHbbM3kE9ycj/B4emXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=K3/cR13p; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Lb2ng7/SixEzOHLmaoTedF/AVYgSm6k/zzQSWP85gl8=; b=K3/cR13pAWd0yOw7
	sdLeIVszlvV+fbSKXFtUPUa4Z1mNRU/1VcnyxXwIsGsjn8iNLFd5yhv/IhMuTt5F2QjA1oWVhcwWv
	kg9RgDX+VXYtjZ0jsqOjVw5Y8Xt9fFRYisxT5AkmB7D46pOXUePaPcxkD+WSOh1hH4B6kZR/xSMcA
	7nJy+WOo0UqjecwcLM29oL8rKVIB1cOeJtQudZlyjYYJFarMq+paDAqP1vLpDlt0V0sJuJKeK667r
	71zPlvajXbK7P+xzKIJ5cwzOwGnypaRa9EeIgm5eb7B1Ure/R5R+6v0NUDwXZuj1rn0Wi/GIp5eEX
	G89wurU1zmtaYrpZAg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7bv7-00FAyz-1F;
	Sun, 03 Nov 2024 14:49:37 +0000
From: linux@treblig.org
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drm/i915/gt: Remove unused execlists_unwind_incomplete_requests
Date: Sun,  3 Nov 2024 14:49:36 +0000
Message-ID: <20241103144936.238116-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

execlists_unwind_incomplete_requests() is unused since 2021's
commit eb5e7da736f3 ("drm/i915/guc: Reset implementation for new GuC
interface")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/i915/gt/intel_engine.h               | 3 ---
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine.h b/drivers/gpu/drm/i915/gt/intel_engine.h
index 40269e4c1e31..325da0414d94 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine.h
+++ b/drivers/gpu/drm/i915/gt/intel_engine.h
@@ -126,9 +126,6 @@ execlists_active(const struct intel_engine_execlists *execlists)
 	return active;
 }
 
-struct i915_request *
-execlists_unwind_incomplete_requests(struct intel_engine_execlists *execlists);
-
 static inline u32
 intel_read_status_page(const struct intel_engine_cs *engine, int reg)
 {
diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index 72090f52fb85..4a80ffa1b962 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -405,15 +405,6 @@ __unwind_incomplete_requests(struct intel_engine_cs *engine)
 	return active;
 }
 
-struct i915_request *
-execlists_unwind_incomplete_requests(struct intel_engine_execlists *execlists)
-{
-	struct intel_engine_cs *engine =
-		container_of(execlists, typeof(*engine), execlists);
-
-	return __unwind_incomplete_requests(engine);
-}
-
 static void
 execlists_context_status_change(struct i915_request *rq, unsigned long status)
 {
-- 
2.47.0


