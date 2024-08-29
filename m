Return-Path: <linux-kernel+bounces-306266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50106963C43
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C37286223
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785FA16B754;
	Thu, 29 Aug 2024 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vxTnzW0u"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC316133E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915382; cv=none; b=o2NX+qDo7clOyeZ0pdBf0KH1T/YxAAw1yEHBukyRE4E4B5lcfMoFpwsRIujEEk0dAF2k1JCLbIV5nq01rnJ3yjqHlYsv+7HmRusxBU7f9HfNuYmiJ6kmIzdN0AxfjedXE/BIf8jWbvYwCOo+5+5LdY/quVdzAqtKYpB0Da9X7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915382; c=relaxed/simple;
	bh=vAIK1SYGoXakjAz2P4zJHk1xtNQdoXTLLepvm/RlXBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/RfwtiRdjyVOyK8V4uHUx7pqnCzzNO+rVpEfMS5shUMprVkl058Qy0vguiYnV6T+SaZucWuP1eA6nMTaACb2qf23stp4Y9liGRFL1/zYrBPY+Y3wcGHeLSWGMrGh2HDfzOst/mnJbnCl7XdFnLxmPb34gJ6hoQ+yfNzgUOYzBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vxTnzW0u; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724915376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/KIxKju75uGBr00bG5k97max+QhEKp2wCZ4XqSZRGMM=;
	b=vxTnzW0u+hUe467HHxNcvB4NSvjpkh4iQiZP1GEWVtqjU4G1f/40hs4CWVdynivEEfw9ag
	vUmEQTgUO+MABZ7KbUBak/YjOauXJJIcLhJ/7ne36ole1pMKci+g8a1rnuRYnwaPV/mYFM
	hSGivR+S9w8D9w8TPQ2T1Q67Q/skmIQ=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] drm/i915/gem: Remove duplicate 'unlikely()' usage
Date: Thu, 29 Aug 2024 15:08:57 +0800
Message-ID: <20240829070857.28617-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

nested unlikely() calls, IS_ERR already uses unlikely() internally

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 01b7587dd1f8..a3b83cfe1726 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -825,7 +825,7 @@ static int eb_select_context(struct i915_execbuffer *eb)
 	struct i915_gem_context *ctx;
 
 	ctx = i915_gem_context_lookup(eb->file->driver_priv, eb->args->rsvd1);
-	if (unlikely(IS_ERR(ctx)))
+	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
 	eb->gem_context = ctx;
-- 
2.41.0


