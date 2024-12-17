Return-Path: <linux-kernel+bounces-450041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0454A9F59F8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2024 00:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2840118930FA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29F81F9EA4;
	Tue, 17 Dec 2024 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icZ32FIO"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43B1DFE2B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476420; cv=none; b=Dwh4u0O7fEvU/AUgWXkxleOs6+1ebyR0OqOd+YV1hD/YU2d+XADDEJHQq6AY1RRGnCb3ziuoZWFPNx6SOK8BIHYPVtNIL+WeLwLU0OA6MN1Hc6i1SSP/HwDAWWRUK2ZbPIgUSicOK1Q9GBQb/CqRNZSl11+KMRQHpxHCa7m7XQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476420; c=relaxed/simple;
	bh=ttiqumb8WJ46ySnwu6s37FyvaiMOnuCO0uaSP9CwWVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lqVR3x6dEMOM4zVNlw41iwY+n2RN88kIM9wMTQHm4QeJuxAuibgXblW2clzfgbZQm9VP5Mkg5g7eCNZy5F+3wUB4OojdhwneLlZui5oIUZbhBHsikR/vXPnSgGRvTl1vn0YONBPjHfINDRjw/eWJycfVFUGT7CpAcy889aHE2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icZ32FIO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso843765966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734476417; x=1735081217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MFHlrKsNj2nTROqoaF03zdCs62Jx2PNpLmDst7mEkDA=;
        b=icZ32FIOnRKOYKluS8U8QYJjfT+fM+19wqGErQ1elFxyUTigIfEOmKkGcio2sd71uc
         gSQ7N2tivPgRNL/xK7A7ErUtnud41f3QgYbfEdSe0x7ajDp5+aPgYag5l4TgtP+s/U8g
         nkjOS4Z81xR4GHQ2i8Mu98KenLjj+8qpgekeCXkFGDDKm3oNHq79Wl+V6xI2l6U5C3Ha
         T6wxtAaN/ptfk/z0Z6SCYp367P39ZBrr4li4dPSohKIdv1DCHczI5tCRzkAqsr+16eIk
         j0u+UM5K5fEgYD6LH2owapYTdKb5nXYKZtfwOCIn3adG97ENW12S1hmfSwth31Wa6Pj1
         YofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734476417; x=1735081217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFHlrKsNj2nTROqoaF03zdCs62Jx2PNpLmDst7mEkDA=;
        b=nfTc5zb0wAC/RPZHfsTxDt6qaOvjdhkWzkfDdUe2k8kGkoN08dfFDZeLL9NwnqhT12
         m7W6SafrsZQ6/f3BIggCyLCz3jBlpok+2aYhq4KPClwPElp9QMCkN5eRUJ7pR+FnqVE8
         Y+dCXhHxuVzNCgz+b9LE+X91u+fxQCOTdwkaepJoAUXW4Pa6pZs+1z+Ry3Fxj/6ybvOH
         raYmk/iF2sjROz9OL8db6TzLCkx54HJVQLeNzjoqSUldAGce4fHql6d3HMxq1LcfEvjw
         wElXK9HzVozlsdrpKLxFfcUkk5OiQYGfOpCmjTwrLoImGq13OKdTmhI1/0ueqRggGFRE
         UtoA==
X-Forwarded-Encrypted: i=1; AJvYcCV6HJStFxZbYzQJh7hN/81Bwjy6qWALGyhB//JoMMofM1FrAkJfjw8v4+tZsFVPa9p/t9cOT+PqDszgXsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY9lf0o4uC4fV8H8j73CHMRG18Wt0dT9FiuGERT8/s+kSiDKU+
	XXCgR30e6Dr2rcuZytfp/qwMUqfIEuOTWK4djuFGVt9r8dVpbyZ5
X-Gm-Gg: ASbGncu+zusKBxzeWgay6W/AxBZeNVpvfjKmtFg0SWQ/R1hubwUlTJFfsAlvy+1MFlT
	C6/sU2ERe/xvMNzNj8LM1Dvdu+KQM/Q9LmakWoYDC/V2YmdLIHmlSqOgC/SVOcAugQxV8lzkm+N
	jx/rl7lP254PVidkTbacok+jxM9vQXN0awEyLXQu+wcq4ajfisZJAv2382jnfOpTwj+lY9hOn2R
	BPQyxPg0IJRpcQ2TY45eo1BsiOSxivHKV6rFPOWk7dqr0PxIbhfhYZzxUpbeqCQharZK3Kq
X-Google-Smtp-Source: AGHT+IGseKPOWt+FNZcwAVW2rCKFGixSzJ+XFmlitmEI87kClR53LP1fPFfQ91j/1mJmiGx0AiKAxg==
X-Received: by 2002:a17:906:30cb:b0:aa6:7c36:3423 with SMTP id a640c23a62f3a-aabf46fc8fbmr37360166b.1.1734476416434;
        Tue, 17 Dec 2024 15:00:16 -0800 (PST)
Received: from localhost (dh207-43-57.xnet.hr. [88.207.43.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9606b3a0sm487066666b.81.2024.12.17.15.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 15:00:15 -0800 (PST)
From: Mirsad Todorovac <mtodorovac69@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	Victor Skvortsov <victor.skvortsov@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	Zhigang Luo <Zhigang.Luo@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Yunxiang Li <Yunxiang.Li@amd.com>,
	Jack Xiao <Jack.Xiao@amd.com>,
	Vignesh Chander <Vignesh.Chander@amd.com>,
	Danijel Slivka <danijel.slivka@amd.com>
Subject: [PATCH v1 1/3] drm/admgpu: replace kmalloc() and memcpy() with kmemdup()
Date: Tue, 17 Dec 2024 23:58:10 +0100
Message-ID: <20241217225811.2437150-2-mtodorovac69@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The static analyser tool gave the following advice:

./drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:1266:7-14: WARNING opportunity for kmemdup

 → 1266         tmp = kmalloc(used_size, GFP_KERNEL);
   1267         if (!tmp)
   1268                 return -ENOMEM;
   1269
 → 1270         memcpy(tmp, &host_telemetry->body.error_count, used_size);

Replacing kmalloc() + memcpy() with kmemdump() doesn't change semantics.
Original code works without fault, so this is not a bug fix but proposed improvement.

Link: https://lwn.net/Articles/198928/
Fixes: 84a2947ecc85c ("drm/amdgpu: Implement virt req_ras_err_count")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Xinhui Pan <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Zhigang Luo <Zhigang.Luo@amd.com>
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Yunxiang Li <Yunxiang.Li@amd.com>
Cc: Jack Xiao <Jack.Xiao@amd.com>
Cc: Vignesh Chander <Vignesh.Chander@amd.com>
Cc: Danijel Slivka <danijel.slivka@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
---
 v1:
	initial version.

 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index c704e9803e11..0af469ec6fcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1263,12 +1263,10 @@ static int amdgpu_virt_cache_host_error_counts(struct amdgpu_device *adev,
 	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
 		return 0;
 
-	tmp = kmalloc(used_size, GFP_KERNEL);
+	tmp = kmemdup(&host_telemetry->body.error_count, used_size, GFP_KERNEL);
 	if (!tmp)
 		return -ENOMEM;
 
-	memcpy(tmp, &host_telemetry->body.error_count, used_size);
-
 	if (checksum != amd_sriov_msg_checksum(tmp, used_size, 0, 0))
 		goto out;
 
-- 
2.43.0


