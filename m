Return-Path: <linux-kernel+bounces-204035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773F78FE33B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B268283C99
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0D017838C;
	Thu,  6 Jun 2024 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="aMaWLn/w"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26041527AA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666953; cv=none; b=YGVqRnzr4DMJ48gTt3DCxwuKw5Znhm6mRe6KktWRF4hzK0mlXlGIjixSCl9aYNtooOyPJPkFcxiPWSlxMwmdnGC4sMnmRLOZtwcyfhvZDSnVwBg0UkyTkN0bh8GwKNyHHdQgSKkbawCMJOKvAeBuO+ivDq6kjMPUmAOfzfxZ9RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666953; c=relaxed/simple;
	bh=jDmBVfK2MYsGKoNBHduFQEVdd1eqDCsRjnw4Roo+lL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jWJiJNDlDowXLC2PZYzAKQw8HxAFIWIQSX6LTmI0NJ2PK8FHzR0DAwDefqbjTqh+PxJJoN8ITy/peE7F6VIL76dQfVPaJj32z2I6J251f2njC43bFUnXvTF47WQZXUSJeRJcALyI9zu7Ag3KIF/SmZCWeFPqi+lf1hIbKEgjlYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=aMaWLn/w; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a68c8b90c85so91654366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717666949; x=1718271749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IlMHYdHpbSsMWZFdyT0K8Fjv839Jpj+HUlzJKS7Co+k=;
        b=aMaWLn/w6m2/WGInge5lgFpoR+oO2tc35JuYuU1ytz37MJgSW239HQHZIHgeMNzIha
         gJVLSBTZwZGgEMj7nIKEblznMIqlw5b3JEPT8/+PiGCsCANHIzPnKTrfzJ5ZmMZ9eics
         ydi/76Lv4y8qZtwzicoSU5mHFd9m90G++FN/6PyMuV9+sqHcotsSe3xvK2wK6ySQ2fV3
         eXao+ebzDc8h7e6J5aHnPOan97oWQp2hBGyoc1ElcxQM1+H4M1Yg8digSlx4EQEhMoDD
         ECFoYdLVbyxo104RCnIf9paKfV3SAtrEM7JJ/pVRZ+7DePzG3dVjEbf4Fz8pOLwWT2hc
         rZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717666949; x=1718271749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlMHYdHpbSsMWZFdyT0K8Fjv839Jpj+HUlzJKS7Co+k=;
        b=W3eaYRL6EbByYs6VPxBh0Dt2tfwKBeuh/vANo48eZwh9c3vwHrXb0x4t2sERHoIORr
         O0mVf6GedTc1tGuPKJnFZyB+0mWBDuEFMuaG0ry0pqaSt4e/U+f6S9vCIpgTCS4UWyrL
         t6B0NbfIWPsWYa5KdDnZmPCtvWHurgSM4PTDAjh+YLwHkUecGRtKXpYwnSObrSLgVRX2
         1FjCiJ7WWPSzZ032sF24zKyWWQ+b62AyRivNT3tvsZiiq097aAYPUi4OjnewIdiPGA9E
         l4z2eHmD5Eqze03W+xa0NEv0BTgLqlWxR9KDqMmoMk+2p4SlIKOOmJvZE1mIYO25Ns7n
         pFEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf3v4CZwYd9NLWISJB9ljeJ00r7D8xdH+M0F/Wns45ZRZm9VThc2fTkwzQVJ9OW1aVS7BtWzgDLXsn76Ty0xIdGTg88GaKoAjFGygo
X-Gm-Message-State: AOJu0YzUAeWlUDQ3Tf6HAFNLzB7uuly0Ab2/e19K4BBM25AlFhiGpeOO
	1qaIaKBLGlqpIpSmItZAmUoDNFUcNpYbIZeZhV2ab069xffX930TlxrFuUUz7I8=
X-Google-Smtp-Source: AGHT+IGCDgFyPpX9CXJQtyOL58oz+VP0Rp2sLkukB9+7fEQVCwQ5CTPZQI1cjrbmD0/ctfJw0gi2Lw==
X-Received: by 2002:a17:906:f9d7:b0:a69:65a7:420d with SMTP id a640c23a62f3a-a699f88afb4mr409714366b.35.1717666949091;
        Thu, 06 Jun 2024 02:42:29 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-164.dynamic.mnet-online.de. [82.135.80.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80728867sm71303266b.192.2024.06.06.02.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:42:28 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: stylon.wang@amd.com,
	roman.li@amd.com,
	Qingqing.Zhuo@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] drm/amd/display: Fix dml_print_mode_support() for USRRetrainingSupport
Date: Thu,  6 Jun 2024 11:39:44 +0200
Message-Id: <20240606093942.103123-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The address of a struct field is usually not NULL, making this test
always truthy. Test the boolean value instead.

Fixes the following Coccinelle/coccicheck error reported by
test_addr.cocci:

	ERROR: test of a variable/field address

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.c
index c247aee89caf..a98ec059725a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.c
@@ -404,7 +404,7 @@ void dml_print_mode_support(struct display_mode_lib_st *mode_lib, dml_uint_t j)
 	dml_print("DML: MODE SUPPORT:     Host VM or Immediate Flip Supported        : %s\n", ((mode_lib->ms.cache_display_cfg.plane.HostVMEnable == false && !mode_lib->scratch.dml_core_mode_support_locals.ImmediateFlipRequiredFinal) || mode_lib->ms.support.ImmediateFlipSupportedForState[j]) ? "Supported" : "NOT Supported");
 	dml_print("DML: MODE SUPPORT:     dram clock change support                  : %s\n", mode_lib->scratch.dml_core_mode_support_locals.dram_clock_change_support == true ? "Supported" : "NOT Supported");
 	dml_print("DML: MODE SUPPORT:     f_clock change support                     : %s\n", mode_lib->scratch.dml_core_mode_support_locals.f_clock_change_support == true ? "Supported" : "NOT Supported");
-	dml_print("DML: MODE SUPPORT:     USR Retraining Support                     : %s\n", (!mode_lib->ms.policy.USRRetrainingRequiredFinal || &mode_lib->ms.support.USRRetrainingSupport[j]) ? "Supported" : "NOT Supported");
+	dml_print("DML: MODE SUPPORT:     USR Retraining Support                     : %s\n", (!mode_lib->ms.policy.USRRetrainingRequiredFinal || mode_lib->ms.support.USRRetrainingSupport[j]) ? "Supported" : "NOT Supported");
 	dml_print("DML: MODE SUPPORT: ===============================================\n");
 }
 
-- 
2.39.2


