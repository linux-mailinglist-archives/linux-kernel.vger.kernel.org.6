Return-Path: <linux-kernel+bounces-367661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3E79A0510
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D69B25C16
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2E6205E04;
	Wed, 16 Oct 2024 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6YHOl+x"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286F6205125;
	Wed, 16 Oct 2024 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069697; cv=none; b=Nj1WckkFq79oWc/T7XUqSg7jiQ39A3wgZai7IcqyjnT1G6MRCBqN2dYWBCX05CrL9t1GVCTeoft/R3Bh+pBf82kGO4Xcyviy/YcW7ukPNoT4pSZOJdga5TTuaNT5xy4SOAyJZlt+pChanBjoJOoIWCMrmHhRXgEXZUJvnCDahBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069697; c=relaxed/simple;
	bh=CbyAZqMMc0gbRedEKGzjGqancCc65SQSYPTA0D/J3QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qtsc1qN0L4y/DB0xRd1C5HnwCxPptpHEB3aZe9APGJrwbGTOwVGykB438hXDKtKQi4+tFpf1xBAmjDn2xTn9UOqWZVfXFqm5XVK6C11UoWgEGQ87l2jJEzyPNvvmkTQB9Pi4zljGSR+oALgatb+QMjtOyGDMlF7Peafk6iLZuVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6YHOl+x; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d58377339so5097360f8f.1;
        Wed, 16 Oct 2024 02:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729069694; x=1729674494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pCckWqcba+fa3Shgw28lw4/flbtKS6dT3/BQMij0a0E=;
        b=f6YHOl+xB4PocYKL/ynkZYm/CkMmyHufzinKj+w1t4YAIEx7abyLTSi5legsIThhRc
         Pxn8MlpK/0GlvC19sMaPVu/t4HIZ87wCfLjCfyA39kX62dHRHKvZD22op3SLPYJF+G4s
         Y4OqB7nBVwwxvwgm1mkdEsAMkjA5epWZfNAFDuHYEmvt8c4/Pvvl+5P4VJ/9/Z/+hCZE
         Z0FA3kwpBb+TKwnzoYNciwi8xyeiAsldiGhIIKNMawC19aaOJdGw/lHkZexGW78wwCAD
         iNFAy1Da0FuBOVsQJo+K3v3lEWwGGeK44jDNAheAi7blnIeTd6oy1wjiJdUStsoooBNQ
         jU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729069694; x=1729674494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCckWqcba+fa3Shgw28lw4/flbtKS6dT3/BQMij0a0E=;
        b=U8VRh+FFyTKj5ZpzR9jG0i1Bl6noTQvf8I7NQLvHSeyyOJyTCEArtMLN2Dy9ib1a8F
         r8ojMzaZSvt2TVK0rUK9KLtPPuQeGDAKUtyn32AkHtkLUPr0wjO+KVNN8sXQa5N+WCAz
         iDvjDZwPmbhG46E6lMk22irQ4QK/YrKtIOfB9zfn7Ova2s4URKal/VVYbEnJMNeJZVz1
         9HTlJk7u95WuKe0KccV+8O+vWIUL0dfd/K9ZInwpChoYT9yyTj7R0DjWMVyNyI0bIqs9
         QPbg0kW6S1lAyijJzFbqYkVP5gjEfDNpfvYTz77Pe9BqTsSr86M+d47bB92HC7lzzsLS
         ydlw==
X-Forwarded-Encrypted: i=1; AJvYcCXz8DlWtyi7h36XEhKGBgqywZWiHrE65Ns6zeAOlNauE5rBlTNEJQf7SsyCvmrzIYRMxBs6bWsKSTj81Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi6vxRcmLVCb8PihYS4XlbrRnhuMUk8X0/T8rY3ZrZnC6szg8L
	RCis1Hn5++gRIsm1EytR1saluuFt3gSJ50AaL9G1jwSsSmW+PzZM
X-Google-Smtp-Source: AGHT+IEuoW36ECs0G3BohpHYmIuQ52zx189xfDZHUYwD27qVnNtffHsYOR71klxFyQQ5Hjzch7ywDQ==
X-Received: by 2002:adf:9bd2:0:b0:37d:51b7:5e08 with SMTP id ffacd0b85a97d-37d5ff5a4cemr13000270f8f.18.1729069694199;
        Wed, 16 Oct 2024 02:08:14 -0700 (PDT)
Received: from localhost ([194.120.133.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a04asm3780781f8f.8.2024.10.16.02.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:08:13 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: Fix spelling mistake "tunndeling" -> "tunneling"
Date: Wed, 16 Oct 2024 10:08:12 +0100
Message-Id: <20241016090812.280238-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dm_error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 518e5d1f3d90..e05b8fddf2af 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1637,7 +1637,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 	/* Read DP tunneling information. */
 	status = dpcd_get_tunneling_device_data(link);
 	if (status != DC_OK)
-		dm_error("%s: Read tunndeling device data failed.\n", __func__);
+		dm_error("%s: Read tunneling device data failed.\n", __func__);
 
 	dpcd_set_source_specific_data(link);
 	/* Sink may need to configure internals based on vendor, so allow some
-- 
2.39.5


