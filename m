Return-Path: <linux-kernel+bounces-423941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01EE9DAE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4E7B210CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4C202F7F;
	Wed, 27 Nov 2024 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE4NfZCZ"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD916132F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732739774; cv=none; b=esrFCb7MbARAt2wjqN0LTAzpoYWWrhwHMsIToWywLc/bS6EID3OzwRHSyJr8U7fusUkV532Ydw2lvn+HiDgc8AC0p6JSdVa5PB8eUe1nPCVS5NOzx1tOpvhggoxInS8cl+16TsVtTawLL9p7Kt/g0cE3Sa+AB956CjU0nI5e7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732739774; c=relaxed/simple;
	bh=27PSvdCY38KZly9ooE4QVDVTEKXezCWQDV2U/I31X0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r5N2WiJhG7Mk+Fahuvd54wYB82Wa5EE7NrnlG5Q+16qwWKO1FQWk5d7B0M39D6klnxDMWNX2KDvNBORD1++dvM7zzPXO2yPAAuQvZxfPPtOx62rs0cyzxJ1tyAXQDTIEDFa0qzAk1j1wSBqNAWU8ajRKUZTY/qov3sClLlEkZgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE4NfZCZ; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2976afeb682so167239fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732739772; x=1733344572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8pcXmUZCuBPhhv9UOmrEGOEpDu8UHlHBCzJTdy/kxlo=;
        b=YE4NfZCZRmwPxe7VZ0b4fpFqMmGvAf/Psv4MkqXYTkfTyybU7RGow0+QGAezKmUwQa
         8VGATSJWRHWyHaffkjvlohL7TX/ciharXA0SFyTK6aJGG926NzzpOIrDKT4ikUEQf+Ox
         6gAMBphxq6xtUKLGE5yZA6VBejN37e2Mc6I+4jUtRTQOgB8tVhO6OksTUzpCEaXbc6AU
         7Ci+0v3jsUHoEfu1bK55NRA9X4tpu5EYIMLj53QtkAI9NchbkwSM0TZfKVPPEQFI14F+
         s6I+ZYltaGcdRt496VttxKkONY0W8OzXh45sPxIh86DOHLUNVmPhmzSbgCLx+nMamd/2
         0rtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732739772; x=1733344572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pcXmUZCuBPhhv9UOmrEGOEpDu8UHlHBCzJTdy/kxlo=;
        b=czfjYJN8cSs8M4o2CiGmnas2bdhH3ysl1QuqnfANbdXUAiNZK3ceW4vKSQMbW7ZkdF
         n9c4jPGOIg+cjKdQp3wss5qhndDSENalRuf6JCzSVOoV0XSA93jZRHuXfzvtA0hYOzfr
         /dV2EpvCFs9b87C8vyaOjlsD3/pfvmX0i+RO5gwTINB0Iu2zwYWoB1PAl8Glr0BI13dB
         0GdVIBBQG0SoVN3pV2896U3nzLLpgZ3wh0r198+KkMFhSwpKPUb9Q97QRmXJRjieq8i3
         bH0hgYHGc7Bxp4b6+k2NVRxyg43XbDr47r8PKgSZ+0mnPgvZHbf19C0nTOi7mVRm8UIg
         lnfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM+RdD4hwKue6o4ttiEaSrlKeXdRZF0tkQ4xDSlzFMqG8IY08eponRlWTe+XMJI8mxeAzPw4NJOpEwx4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/UfJQw3pfieTrPU7iQytFiqkERUnVPFIZPOBKEWSuTiKJjcMX
	tBHj0vxGjXFwoXHV5V9khzhXU5icYCOahpH7FvDqTNR1Atrr1bld+GwxQCSK
X-Gm-Gg: ASbGnct3f3KabH8i/9tRjwOdyZQSY5sf+hhlVAiWFZZxgEapK6v4tOacZPB1RX3aEby
	E9gzumEqvQ16ce7ngr0Bkqd9y1DgNoa1XgKHiUvYs0Zw5yCIHsL+fV14DuiqijspV4nOoHkUftC
	ZEltvpu8tVOY8t4UQsaBCTIT49mDNpmhdZFrCSkTwdXjq+Zr/yjyP6KZ9g6rTHsLGYJtQs/rPKc
	3vdhNEaSvUwJd9UMpZHpLqSIac86qIMIiCNcuaxdTBG9RvYfxTar6OVZpo6TCSarjluBFt+Alo=
X-Google-Smtp-Source: AGHT+IGknsZTNpYummwD6cRDXQTmOcxwkFHC7zIvyVNfVkn7FqqmuPMLFYu3uyfB6sOvhYr3Ms/Luw==
X-Received: by 2002:a05:6870:b48f:b0:296:e598:f28c with SMTP id 586e51a60fabf-29dc3f9ef1cmr3604802fac.8.1732739771227;
        Wed, 27 Nov 2024 12:36:11 -0800 (PST)
Received: from localhost.localdomain ([173.216.50.143])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de901ee76sm5532fac.21.2024.11.27.12.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 12:36:10 -0800 (PST)
From: Guy Chronister <guyc.linux.patches@gmail.com>
To: maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Guy Chronister <guyc.linux.patches@gmail.com>
Subject: [PATCH] drm:panel-orientation-quirks Added DeckHD support to panel orientation quirks for Steam Deck This commit introduces a new quirk to handle specific orientation issues for DeckHD panels on the Steam Deck. The quirk ensures the correct display orientation for these panels, enhancing the user experience on Steam Deck devices. Tested on my Steam Deck to ensure reliability. Feedback and further testing are welcome.
Date: Wed, 27 Nov 2024 14:35:45 -0600
Message-ID: <20241127203545.17475-1-guyc.linux.patches@gmail.com>
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


