Return-Path: <linux-kernel+bounces-517106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003F0A37C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80121887C36
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568F4197A8F;
	Mon, 17 Feb 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YCjhtPLJ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104F8F5C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777488; cv=none; b=GTdsaVaLPm9guaIXebsQbf7Jvkb6vib4RvYgJjfHcDwfxWpCjirFSJYoXzvqO7SB4SV1s/iDeKC5y8GpyMIsSj9JsB6WqoJVtjVyp3FRz6gPb9GrvShadgmNmm7TjSocNeGDkVXJ/i3vg8lx5MpliFmWAUpnMtyZOXLgmuRwam4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777488; c=relaxed/simple;
	bh=5LfAzuERriSmpQuSJeDzYhRoc6w7MgsIIf2LhY1/C1I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Oi8bzjrhDLXpYbmfMLoJ6gDjjaSWtOVA/eQFneeN274dlS/3R8phSDsfg4rhtgwkazq1x/m2TU/qJQTMcbbP2iqMPQ1NTWi4V7oaGh74H+quD/o0wfZmJ3RqqrtSkPPYqqr3MC8tqaMs9jGfdZHwNxFQstGyjuHw2JXFWtaaDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YCjhtPLJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abb999658fbso79979866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739777485; x=1740382285; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3N1F9lKBugdIVSZf0JnXa3f5AJ+PHptBaxL337Q39w=;
        b=YCjhtPLJ8c3VCtW0f/7lU7w575uDXecEJoK9/RYmdF9yX3i7UWH43dJFHLCYjDRqt3
         XfKJq9o59ldaSNBogGV4zRa+c7ZnzzOwdD1DwZvTfeGdwPvUNK8xbbZCwDGU9lrJzJio
         +hokEWi5YihR8Y7VH4n/lHv3zvX45DYFDK1KiDjm59lHjkDkApXJKLA970PiNCSm3LY9
         2y/g/9bbstz4yWgRhZgIz49fodywQ4T5nxuPDmH+0jP1r6NMyOEz3WAEMb0B7HRVu3wG
         gZ51Z9Us9SguU82050e99U/iT2CCKC/B28VBiQ4BXcn8nW9jyIMfQScVXnuUHeryHmFs
         p63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739777485; x=1740382285;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3N1F9lKBugdIVSZf0JnXa3f5AJ+PHptBaxL337Q39w=;
        b=P8kyKGRlUv1O4DC1I5zCM44xDVG8lw54f1zuboG6febzz5XqW+lHaw1GtovaN3QBl8
         U0QA99Z1ga19cvlSzDqi43YbQ/L6hlMBRhK/le4hFuRRVGPvLTkKj1/4J+FX+gp5U7xX
         fuhgi6hBjJbfpkePvGQUDmBoVjftiYHp4TJHjje8ybU1ZWN6+Nd+RXfaBvts/fPGFdRo
         AaV7hUgYfmatw1bdCWEs89Kikp+Et4O69os9tpS/w0y2e0yamzElEei8yJmsHD0yKPRj
         yNAo+sZhvuhGCOrOflX66xmN76DOHJeLnAQi0D6DW3fe3H5r7PGc38nb+4eYGilzHSUD
         UVTg==
X-Forwarded-Encrypted: i=1; AJvYcCWaOl+6SgLHIwn/0KfpWuU5Rn+S7TxWgyzIYF0OB8enco18Ts8/t6l0dxiC2w8wYx/oV7rc5s+ilBn+Vlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqDQ2GmHnhwDdVUbWDOeh7t8/0NrMsPqQR6mP1SShVGbJBSUZc
	UInSfVYs6mzAXpIXWILXH8J3ejeVlwyhUe7lp7jEoO6GWJPryVvXHWpLzpiTlg4=
X-Gm-Gg: ASbGncu53KoqdgTgH/iDlCJa77jLqki+PVEw4RlQ1EtYkTkHloYnHiyDpZ0TNszbCmk
	7hSCL6rNNBWrJIJt9ruGyrC5ZATUYR5QCVobDGYRtK+dyNRrd/vwATu+Ly4P9NO2ao3Hc/AZ0ll
	S+PMuGoM277LMXmD6nUBS925kPMaWDGmgJxlLgquJ6tA2EkQP9fTEwwZNiymln2em0k+8xs+QjQ
	169VlYRablDVL1qbQsK0D4PKXQiLgTPj9u4L2N4/i8Xb1x8xq3vnjIFZ/VouLucfBV8451DpLac
	IrercDETXg/xewYvw9yh
X-Google-Smtp-Source: AGHT+IHnHjxlo58ZzOxdeP7u7lyqoH4uJ6/5PcUK9k1FokcbI7i8gKzpjfAHODR2Y8cP+hgufV5HRA==
X-Received: by 2002:a05:6402:3589:b0:5dc:9589:9f64 with SMTP id 4fb4d7f45d1cf-5e03602f759mr19286982a12.13.1739777485351;
        Sun, 16 Feb 2025 23:31:25 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aba532322c4sm830991766b.34.2025.02.16.23.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 23:31:24 -0800 (PST)
Date: Mon, 17 Feb 2025 10:31:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhi Wang <zhiw@nvidia.com>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Timur Tabi <ttabi@nvidia.com>, Dave Airlie <airlied@redhat.com>,
	Ben Skeggs <bskeggs@nvidia.com>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/nouveau: Fix error pointer dereference in
 r535_gsp_msgq_recv()
Message-ID: <b7052ac0-98e4-433b-ad58-f563bf51858c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If "rpc" is an error pointer then return directly.  Otherwise it leads
to an error pointer dereference.

Fixes: 50f290053d79 ("drm/nouveau: support handling the return of large GSP message")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
index 2075cad63805..db2602e88006 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
@@ -348,6 +348,7 @@ r535_gsp_msgq_recv(struct nvkm_gsp *gsp, u32 gsp_rpc_len, int *retries)
 	if (IS_ERR(buf)) {
 		kvfree(info.gsp_rpc_buf);
 		info.gsp_rpc_buf = NULL;
+		return buf;
 	}
 
 	if (expected <= max_rpc_size)
-- 
2.47.2


