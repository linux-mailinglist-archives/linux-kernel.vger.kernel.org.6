Return-Path: <linux-kernel+bounces-182695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060A48C8E8D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C494B213E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8C11422A4;
	Fri, 17 May 2024 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="lQD3r4zV"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79B1420A0
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715988962; cv=none; b=dcEP70C4X89O2dimsV/7GLFz+YWfvDoY32N1TEM48JfhSu3DUxFZBX6w919hOerYdJPT+TpHnVlzlvFmvZfXXgiQbNTfF8Aiot2Nyh0tl3DAE8k2kFdD+4h8sywwmVQdAf8slS9IBfwMCClXa3q8xQgJ0RAOIczQEKCWUaH56Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715988962; c=relaxed/simple;
	bh=9G6rnN8xszvwSLe14hkW/J5+0v/U9ywxGZd0hLRlpfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkgnWkhIYX5o/kKc20D7CuHvTU76RbMUSrWdx0XpgtUl4m1cut8GxbrPla8QjAwS91wvuRvo0Mzy7TysFrsL6hwvrtSK8yydUAgg7QvFzRjbOVX53m9YoUYSZoi+wRUhGp30p9S9TXu4Ht2Y+IPjpuSPlgmmPE8NPK3R1WBBIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=lQD3r4zV; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=zCEGpkp3Zmdhb06kEQRsXk9mj5wYCe5bu+6wwSjIgUA=; b=lQD3r4zVStcDT0Rz
	L3K0k99h6eTjHTq1uMj7Pb7fRpKfCatEf+J6ysrXs5czg7mR9BJRjbhrIzmlBW9/p9OPWoWBXmyvs
	jWDNZ2U0kNqhkG8sKlkIGYCCUEteDB1Jx55QdyCQVHSDw7NC9/tZT9Sot4o1LIzCTtTIZW/ZefEaC
	N2eukhCTw7S5k9Zrkky4sHQHOMIBTSKstAvIjFbDyRYnEbBan6JfO7nhW8ugvL3TEQEVZAMPo/4rm
	E1zkAc++pw6lBfvib9Q1k3BBpX8V3mp+6tsaxE7QrBUqRKHohmqtNLYOFXtErP0lWixEFkeY22x3w
	RR5dkugoATolFb0T4A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s877E-001TpV-1Y;
	Fri, 17 May 2024 23:35:57 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/3] drm/amd/display: remove unused struct 'aux_payloads'
Date: Sat, 18 May 2024 00:35:47 +0100
Message-ID: <20240517233548.231120-3-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240517233548.231120-1-linux@treblig.org>
References: <20240517233548.231120-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'aux_payloads' is unused since
commit eae5ffa9bd7b ("drm/amd/display: Switch ddc to new aux interface")
Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index c2d40979203e..d6d5bbf2108c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -51,10 +51,6 @@ struct i2c_payloads {
 	struct vector payloads;
 };
 
-struct aux_payloads {
-	struct vector payloads;
-};
-
 static bool i2c_payloads_create(
 		struct dc_context *ctx,
 		struct i2c_payloads *payloads,
-- 
2.45.1


