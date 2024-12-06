Return-Path: <linux-kernel+bounces-435234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6249E74D1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A03116CBCF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC2207E10;
	Fri,  6 Dec 2024 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYSBpqJv"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6020B807
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499960; cv=none; b=OjZapCDQD0U1mjh/hGm0d0dATq4mpaCe35Qvtq/FPj0Huc3jYyUrmo/+PXJaRhZU6eNqli5sv0p0UmUzVE019tDBuSxpMs6MvmZ+ye79nvegwjgdcN2jU58QTD9v1C6Qnm/IF1E0rUsqPHDIi1t8lgh4IDtrB9nECV7LGgL0ozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499960; c=relaxed/simple;
	bh=27PSvdCY38KZly9ooE4QVDVTEKXezCWQDV2U/I31X0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQZcmjcFiLRdtXKLr93Ys3hOeobVJTf3HvUPa+YBEYEtOfuGDmHyLB6sSmVtPQ5WPD2dAA7eLc3/alv/gq8mjwBZUbmCiMA1m7IQPsOB4mvJPGJ8STzu/MOtHSu4q8y0qN3NqoDxnoQ2J6eTMs6y3EJAwS4maLSF6SW2QirMB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYSBpqJv; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-843e9db3e65so81119339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733499957; x=1734104757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8pcXmUZCuBPhhv9UOmrEGOEpDu8UHlHBCzJTdy/kxlo=;
        b=LYSBpqJvYabpEslom3vOfQUwRJ/LrO/Qp6AO3bJwcBJkyr0t1IfAuPEQiJy5PPZeo3
         vlGayQ940GX2VGFdCYXI5qbDnf3aWOFksf6EwaMMwzcR34Cjfn5Yul25Q3xzx2iiBg0x
         u0u5e+LrFVlV9U4RRbeA/LysRjPVX729Aai8bZGB7hYoOhvg9j/hsbN65pmzOp5ROi2M
         hcQ6lbbNIUuUxwjL+GHBE8toJNSUXwNN8FTgKgTSEUble3y4W3H+iktwem036p99gVDP
         ED0nnkgIKUemSWctx0t0RRydrXrRI4mrLp8d7k4Q/t5noFhZ4XRGqwj1cU9gXR4ndrv/
         dzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499957; x=1734104757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pcXmUZCuBPhhv9UOmrEGOEpDu8UHlHBCzJTdy/kxlo=;
        b=NopjVywmelZb/RQj9/QHwkhqjHfSUwqlg+3kKnQjj34Vrz6BjQABbjiCqntXGmoDA+
         YG7LoS/lDn1NB8QFhkvy7XtKJTcB7hL/bhO93YgaH6DmNwWyAgIghNQdSVWczvaGsAvO
         6JMruF8TOaukf/bwkc+cfav/eaV7Atp2Yx6VUjZ3tPDYBEiSs3EXXoAY0/KtrT8PCMmz
         82dTc37dPYfaeGxZOYDrEYZwMhLeJN3U5JaVkZWLTCjhfxGoJCZlGTcrpqORIG2TyUhb
         L/PHljyGoBfRyP1XM8Ag0yPPeac/wlbES9Uivec/T/9Sj6Qqnt2yo9XurmchhQm+++g4
         GEiw==
X-Forwarded-Encrypted: i=1; AJvYcCVPDWSPksRDihu+eH2PxcIwRpLPqQ20aF2hAJ8z8n34GAelGqt7RqO6zNwST4kTRsW/joKvehjPsyvG0NA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu13RRlD3GDoWLAhVT4E6vlNCpV/FK3zRmbGRDrLKi6T5+3A7C
	o9dt7jkIRsuvQN7qgPvVZn6ln2G8cjUQQRBmjFZWviAmVaCgTQWG
X-Gm-Gg: ASbGncv2vt7ugrNQ4g14XP+W0Tl6dGxlCQ6g/NoG9RJEJzv2TldYkFgG+0KgXHzkZPW
	Y1FMBBtGJXM5x0xqyWy2SFwrC2Xl11SJVLxFfkVJ6cg3U58b0abuzvqQpQRuvjpHcGxxXZXTcK9
	eAL4fOf0AjZZAPGK0YQyLUGoug0PWZaDl4TPb3K08SYsqajHWF7Sy9y6Hhs2uuw6p7QPJeWLOKt
	sKyp01WAc5KBeAc5tphdB1ge3CvkT6X/H4MUXDyOYUEy2+5i4Yc9Sivc4K8uJKbR7JJ9EsTUkKq
X-Google-Smtp-Source: AGHT+IE2Uyiif0c307/vCY2Q92x95kblOc8RLzdvEsU/fgTYE7ZZRpnEaivdJZIwndEDSW8vWdJ6cw==
X-Received: by 2002:a6b:7013:0:b0:83a:943d:a280 with SMTP id ca18e2360f4ac-8447104de28mr752499339f.1.1733499957480;
        Fri, 06 Dec 2024 07:45:57 -0800 (PST)
Received: from inspiron7620plus.lan ([172.59.229.198])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e286107f16sm871317173.21.2024.12.06.07.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:45:57 -0800 (PST)
From: Guy Chronister <guyc.linux.patches@gmail.com>
To: maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	airlied@gmail.com,
	Guy Chronister <guyc.linux.patches@gmail.com>
Subject: [PATCH] drm:panel-orientation-quirks Added DeckHD support to panel orientation quirks for Steam Deck This commit introduces a new quirk to handle specific orientation issues for DeckHD panels on the Steam Deck. The quirk ensures the correct display orientation for these panels, enhancing the user experience on Steam Deck devices. Tested on my Steam Deck to ensure reliability. Feedback and further testing are welcome.
Date: Fri,  6 Dec 2024 15:45:54 -0600
Message-ID: <20241206214554.219-1-guyc.linux.patches@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Guy Chronister <guyc.linux.patches@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3f2e2b851cbc..c412273799cb 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -456,6 +456,13 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galaxy Book 10.6"),
 		},
 		.driver_data = (void *)&lcd1280x1920_rightside_up,
+	}, {	/* Valve Steam Deck (Jupiter) with DeckHD */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Valve Steam Deck (Jupiter) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
-- 
2.45.2


