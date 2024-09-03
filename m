Return-Path: <linux-kernel+bounces-313996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7AF96AD76
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1A81C2343F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8870710E3;
	Wed,  4 Sep 2024 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfFMDC0B"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6138939B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725410945; cv=none; b=f/aGOknZR9SRCUWScgokSsDlCXOKfKAGYVdnuoxlxEpS3Rp59dThXhw3b3OJyh6SDdEnxHwEE1vd6UOHuZB+Mq8Dt8TAP8da4C9w3HlcC3nlvu0gQVqQUWqppYGqzpaaBsn5VxNTWYtLJyYm++/wOPpoB4Lv3lpTQj21oof7oqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725410945; c=relaxed/simple;
	bh=wX8iRpFfa2vx3mQFLRV5mxCi8Y6GcE/JHO1hOh3nn+0=;
	h=From:Date:Subject:To:Cc:Message-ID:MIME-Version; b=pPrDWycC9nyr3/xPN6UDuVpM4p6a/SZREyn/XdzN7MgmOHqey7IDjhwS4TTKHe3zAGN9E1vcQC2DcW6B9VB1N2DRbhict2/cld7xcutpOdJcaJpBaDZpLlzrDd1GTf5iLmSJFf+xl/CoV4KFBGzSwJrFhy6I1/eJEgyFXJsIhXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfFMDC0B; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso51307155e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 17:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725410942; x=1726015742; darn=vger.kernel.org;
        h=user-agent:mime-version:message-id:cc:to:subject:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MI2VD9V3HSMHAEsHid7UqFpfCx71vZJu73a+V6jxQIc=;
        b=gfFMDC0B9JRDbp0NwqxNhCv6FAM9Wy2r5ilAV0fJYHeiId21RsxOpam9lj6jgig1cs
         StNTZogKHkN6/IKF+8rknMroO31Ef+lduNuUmCkJpu43aRl2UR/OFd4LBRtKYghYKJHI
         nErriaGBIi6e15baSUNdzo7PNDbt9/CAX9JF60MaiXPIm2rQ0dlccUb55nmP6tK/xJa4
         5fH0qca3oFLxMCqSu9Kv2DJQ7yvXAUAlR4xOmxGfaI6VgnrM3/IzrpXnSwp5RjOKVDMJ
         I+MYp9cHhACF2LcMempujpeRLD6SDgH3xBxHE4Tr6JYGjREzR19V52+Y/eLFzJL+VAh/
         mgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725410942; x=1726015742;
        h=user-agent:mime-version:message-id:cc:to:subject:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MI2VD9V3HSMHAEsHid7UqFpfCx71vZJu73a+V6jxQIc=;
        b=S8QIaswh0d6UJSj1ZSjrRoybDP01JYN182Nif/T/ntk4Hbo69k3x15oQce2dNOjSCK
         JFSFv8N/CC5viIpDd2Dbkv92obqlmTaXr67WzhxYY6NQyS4CTeJuQOMuqKfaVl4R8u6X
         P66LE/vPx24mRrIeGWsvXVkTZR9XzyljLNBBvNsiiN6fmUoN+KKi6384IW6lscmaDiGW
         TofJvK9K5ATYXU3oaAqOUrC1z+3cnck722FBLkVinv4Vu8lK8xCm28PnQlUDL68F/VWg
         L5+iw5Bf6/mfXxSse+8J8IrDfCaxhBWziMuO3APpmoaxly/vWqqN2jhikNbzKymLd9sg
         63RQ==
X-Gm-Message-State: AOJu0YxOXN3DU66g4OvgteiPziOFEWc36psVKEwpheSkkkUNW0moovdn
	nE22ooPcO1CuOthH+YJYkhx5eRwU2gWgnCE+WX5KAom/I5nD03CwNYc68f+N
X-Google-Smtp-Source: AGHT+IF/dT9moCjMlTPpV1LF79HsX4lZi1lQZyE6VNTQ8vBAlwqecX7lrCGqmEOe3DjJR3wrDhVrhg==
X-Received: by 2002:a5d:5269:0:b0:368:420e:b790 with SMTP id ffacd0b85a97d-376dd15a8cemr1591613f8f.14.1725410941339;
        Tue, 03 Sep 2024 17:49:01 -0700 (PDT)
Received: from [10.33.80.43] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a399sm6976144a12.8.2024.09.03.17.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 17:49:00 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Wed, 4 Sep 2024 00:50:56 +0200
Subject: [PATCH] drm/amd/display: Fix debugfs dmub_fw_state read
To: Harry Wentland <harry.wentland@amd.com>,
    Leo Li <sunpeng.li@amd.com>,
    Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
    Alex Deucher <alexander.deucher@amd.com>,
    "Christian König" <christian.koenig@amd.com>,
    Xinhui Pan <Xinhui.Pan@amd.com>,
    David Airlie <airlied@gmail.com>,
    Daniel Vetter <daniel@ffwll.ch>,
    amd-gfx@lists.freedesktop.org,
    dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <d02c033c6f4411be31a9439f33de2c593b51d8fc.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.52.4 

When the FW state is too large to fit in initial seq_file buffer,
seq_write returns -1, which is subsequently returned from
dmub_fw_state_show. This causes the read operation to fail.

Return instead always 0 and let the seq_file handling retry the read
with a larger buffer if the initial buffer overflows.

Fixes: 2364076772b1 ("drm/amd/display: Add DMUB firmware state debugfs")
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index db56b0aa545..ecda44789b4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -958,7 +958,8 @@ static int dmub_fw_state_show(struct seq_file *m, void *data)
 
 	state_size = fb_info->fb[DMUB_WINDOW_6_FW_STATE].size;
 
-	return seq_write(m, state_base, state_size);
+	seq_write(m, state_base, state_size);
+	return 0;
 }
 
 /* replay_capability_show() - show eDP panel replay capability

base-commit: 96a5152075c0424e9bda551d00ab850c815e309c
-- 
2.46.0

