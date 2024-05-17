Return-Path: <linux-kernel+bounces-182696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562718C8E8E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88931F21EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDD8140E55;
	Fri, 17 May 2024 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="IZyO9295"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62041420CC
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715988963; cv=none; b=a0sNdumiCxSKld3lWXLuCSdioeu8r932hkFLQ7BI2DPkcGweRsq3GDFGDR/cnumtxt2W5q2RTacs/XtH0P8xPJc3UHEffN8nlfnTAQvv/HC7BrgRJb+FzQMDDEb3G5LZ9WDnrAjpEwjzOESnsgI+LmRKORFzDEokMCrtQQeEv5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715988963; c=relaxed/simple;
	bh=yNmYfehsDscMLd8Z5ogmfJm0uyJ4vfmW8qoucZQ9LVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBYGscmj8zErwvMot1mdCTOdJaQ9Xf2oNpjLx/w8omHgp/81XlEs9LmdC6Sjn48p0AQWxJs2MtLZg90dk1pXSICZhhfobmGSAEw5xDobTaBp9TJLYwSBHRYmTum+os8Z0yq1WVULVR8IqIOy1oYj02bTn9Pdr4f8gOM0dOJ0YDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=IZyO9295; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Q0VyvDtbmcL1dq3FHqWs/cX5D8LXTUaBhnMmbxFsZGQ=; b=IZyO9295QgLrX89a
	LkBO3bbxouDubvSE81EJbpSQ5eWvpbci6iHZro92ANhX5cJozO6QbHKsfh6spD0R3BqSQzTz218XT
	CKG4+FNUvQF47qUiU5LhLxWrmb7BMbS3NnqCtfkg2563YSzunj64b4Xv2ogeR/9t+7WYW9Rj4QBAu
	qkdvhV0mXaJd/VDIcCTpzSJ2lLCBKdhqbvqNtFoflfKBZoZPGumu8upf+q+Tjs74wokE5SzFKYc2Y
	AT7gVm9SORrPbYlIejog1BfPgLut4zI818ZRw7pLgBC39phnXSrxSAOJr/DtJ800BzO3mtuqyqROB
	06pHCpou+Fz+vf6gtA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s877F-001TpV-0n;
	Fri, 17 May 2024 23:35:57 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/3] drm/amd/display: remove unused struct 'dc_reg_sequence'
Date: Sat, 18 May 2024 00:35:48 +0100
Message-ID: <20240517233548.231120-4-linux@treblig.org>
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

'dc_reg_sequence' was added in
commit 44788bbc309b ("drm/amd/display: refactor reg_update")

but isn't actually used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/display/dc/dc_helper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index 8f9a67825615..b81419c95222 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -91,11 +91,6 @@ struct dc_reg_value_masks {
 	uint32_t mask;
 };
 
-struct dc_reg_sequence {
-	uint32_t addr;
-	struct dc_reg_value_masks value_masks;
-};
-
 static inline void set_reg_field_value_masks(
 	struct dc_reg_value_masks *field_value_mask,
 	uint32_t value,
-- 
2.45.1


