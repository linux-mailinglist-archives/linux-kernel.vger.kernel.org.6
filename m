Return-Path: <linux-kernel+bounces-230100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E1F91785E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0EF281F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA09714A0B8;
	Wed, 26 Jun 2024 05:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ1JBFYw"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C1C139D10;
	Wed, 26 Jun 2024 05:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719381119; cv=none; b=Ke96aYxA8UekLW90mYBqz1Y0IUnnDlubJFhtEspPzdOv1MHPeEbs8uIt3W4wIZKuUJ2iuiTZewAsA6PRIuuYuOxFUXCibs7pnbpHGQpG7OQipB1mJGWG6JEE2piFICuq/Sse8eUXIJHE+pBdlWr8iW969npJ8E8Cd5aWL1FyiJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719381119; c=relaxed/simple;
	bh=RZbQOA04bhfvkbu/mx7/Gn30PPNmYv8v2kY5zf8+V0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IcwlYfIAVFk9iMnvNQpFItV9uUg4h7SiLpNWrwxPE5Of5jNB0b/FobZfxMiQyT675rg5MA3zDor/cWMbztZPY201eyKeoHSIcpSqPoKYOFB5oDgYP+LR/Ek4/q8lxTT9OBz56MOsE8rRk7R2VqOajPO9QQzEQ60zoMkujrdkwYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQ1JBFYw; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso7638882a12.2;
        Tue, 25 Jun 2024 22:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719381116; x=1719985916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKPiA3sKCe6sikc24f5hVtHibI9zAf2GgTR3+FT2Jlc=;
        b=lQ1JBFYwhwd/XlWQ4LzGXu3x5jxvY5Lyj+enfrqeCF3b1A9EeLm+YGlVX/S2D2Zp0C
         ujrTZfxQ7Cxl30k5qo+gIsv+VptTXNFoJp/VGphatLe/i3yEho+USyAjTxKzTwQr5DVg
         N0oMb1uFBHW8C8uzz1OFZr4kvnqpnlJMtmBqlN2p12i2H1hyH5f3PfCbS4HPU/XNO0wy
         Lwz6hTd9AZVugaeUHK3/L+sUgtR4ED/sxPGYlVaPmA3Mm5t5xFA4MFGg8SNyC0bumWPe
         EvW8z2sjiNHiupvIKTdQjD4XXfyJaI7vOmsYkQdWtSHZzbKZDm0Rqj1IC3o9h2HyNOVF
         TZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719381116; x=1719985916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKPiA3sKCe6sikc24f5hVtHibI9zAf2GgTR3+FT2Jlc=;
        b=X/2UJ8UjUh08vhs2caE3lZuPDQfX+4hf3fmclB5m+QKNXH226p0lYX667rPuchwNDd
         IhdJDLH9+nDk5DenCEvbVgsPvnc1swbLB08LsB1xP2nXicaZSPSjlbs4PZZ5720DKK2Q
         kjLTerHDkUaUsWdcLA3Mw9E4Lk8+D787A5bxzFwSRuzCMhzFQQGnmzdsgpsztPqa84yA
         ZxbIMRn4CnnBTtWQQ0c6+R1VenXrGN2uwTJ4UhpT/I80OVUXfCp+wLPof1GtOYEaDNY8
         JwGFDLWd0ZNUKYyuAH82bYa7Kc8fBY0OhSN3skHn8f3ZIYazNxh8e5rm4l7Knym+D6ou
         abHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2xadGwP32i5eCB4bVNwo2D9nw7JC9UlXug0AuRMWncGViUw6Du5giVFEvTQ3av8BNsxKN/jdBUS3hnNE534PWOERJ9mqWQrI8oXVT
X-Gm-Message-State: AOJu0YyKAbT6QgHizopmjfe2/quGexaClSN6USzi3rgf8kjuxYX13pEg
	rLeMdF82O2JkKYYTEHpAokZ0ZYFSqQ57O43r42O/ob7Yh/LS6N7cV4aIbcx3JAw=
X-Google-Smtp-Source: AGHT+IEd3J7cgQ/xsugrtw0j9RaO/nsubxCo2OWKT16wOlFeBsJP1K+7pi05ZhCq1ZjY/EHPWI4pNw==
X-Received: by 2002:a50:a6d9:0:b0:579:e6ff:c61f with SMTP id 4fb4d7f45d1cf-57d4bd79eb6mr7345081a12.25.1719381115588;
        Tue, 25 Jun 2024 22:51:55 -0700 (PDT)
Received: from localhost.localdomain ([95.67.7.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303d80f7sm6795316a12.8.2024.06.25.22.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 22:51:55 -0700 (PDT)
From: Vyacheslav Frantsishko <itmymaill@gmail.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org
Cc: Vyacheslav Frantsishko <itmymaill@gmail.com>,
	perex@perex.cz,
	lgirdwood@gmail.com,
	mario.limonciello@amd.com
Subject: [PATCH] ASoC: amd: yc: Fix non-functional mic on ASUS M5602RA
Date: Wed, 26 Jun 2024 08:51:25 +0300
Message-ID: <20240626055131.44014-1-itmymaill@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Vyacheslav Frantsishko <itmymaill@gmail.com>

The Vivobook S 16X IPS needs a quirks-table entry for the internal microphone to function properly.
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1760b5d42460..4e3a8ce690a4 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -283,6 +283,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M5402RA"),
 		}
 	},
+        {
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M5602RA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.45.1


