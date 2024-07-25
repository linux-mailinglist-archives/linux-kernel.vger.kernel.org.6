Return-Path: <linux-kernel+bounces-262130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E02D893C127
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE4AB221F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8BE1993A4;
	Thu, 25 Jul 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="J/aPHdLR"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02219938D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908387; cv=none; b=ELnG3GGgBDbit2yyywexnszFL+6+7m2/HuQVAiBUd+ILLDP6aLHoELKOzZyX14QtCrPqwkMr9mHtdk17jJU9ahKxyPDr7OE/I4J2qw4YlywFb5elaSwQP34ULl8tK5QYoXyfID3RXbviToClKmCQ51s0MnZNe/7LZ4zt+Wnz++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908387; c=relaxed/simple;
	bh=amr5smjtyhatmyU8o76edtz3D+3beEVD5s8uL4/sfys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mHzbMHJZ1V23/g+ejrZzAVPa/lqZkT7CI26C5LPwwtMfEhTyWsKVSheyTqTst4PZr+Me6W9NgxV9vj1v4FbmxxCp/WbXd/UeIKJWm3rp1AouXYvLEN/QRm+vpMDAxUZppxwTajsfOCbS0KVOLkpfC2gNxUm6N6TQr4Pi56ErutY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=J/aPHdLR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc5239faebso5893485ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721908385; x=1722513185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Da9MD3yGrxppGawk4m4OKKJj1T6AyG9yHhHZjp6mLsk=;
        b=J/aPHdLRTies6Bo9Eueen/Q98vltOsX7+FjMXcBDkK4S6b9U8L3tqNeKklwWVElPsE
         qCR7YioHH2aq/mdoNjkHdLEzadROX/hBBvVdP8Fv9BEzU2Sqj+ztMAiMBZqMSiMLLou5
         9ES2VkTocXTfgA0rkfnTiYvaHy5wauDr3RaHepz26SRy88Wtj5gkU5Omwrq5As2WefhE
         inszsn43s/IggayZpfaxEVTaAx0x8MMZRdepaBRtt7CBL17GDsPjiQWqFAN9gmQHhY1V
         euDcnffwxOSyUlLwzYzGa3hWLqMc8iQ+LH3nPVjvnL1tYPdI7Yl5+9EpFScg95m4Yq15
         x51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721908385; x=1722513185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Da9MD3yGrxppGawk4m4OKKJj1T6AyG9yHhHZjp6mLsk=;
        b=Jz06Mv6Dbh2RrVIyB3Zijnf6BgBRKo2yyz+mExk+KcbsrrWFt0E6TVd/b9d6STQinJ
         58RJdDCTubnnPXoPyMJriZkEwWxu1pjxLtS13Z+sdP+bBzFPqPSc4fEabi8dA0uOaszL
         1E9UTmyTJKjE8cnysFrcnKLKpU8ldxgCpNy/rtVEM3sVZEVpBOC/ZxHgxVmDoFUcbvnS
         QvXkp/LB07W8r3ZHAlrPOXL0Pb9h+RuwwUJoD2wL4QAJiPVsm6lbCYM/zx3rhBrb9Kop
         oT/3dIWApVn+xTjKRSd6OsMC2UaD2L7WFDepg576remJgtvmbb1pqVWe7ST+iVrv5c3D
         XxQg==
X-Forwarded-Encrypted: i=1; AJvYcCU3NJjCcbbglYKvahH4GcJPlt1bPvHg43tdAbWzumSvFCG+4lJaYiE5adjXWenXWpPKELBM53QDFXVa0HPtbq2o95TxT1+tVZ515dYE
X-Gm-Message-State: AOJu0Yx/3thF9Fps1TVufBzSZSPrTED3JD6riVAUMsvp53k1J/fB1NDs
	zdreobXk+Y2c5gMFvWLo+mcoSB0lLOsbTSSp0+MgXORDytD8t+86+yOPWPCwo5k=
X-Google-Smtp-Source: AGHT+IFIYgitRVGazUR81RmstH/QOKj9UwOXu5EeZn/74vAZhpeAwGZaQ6Tn8uFAPEX0Z6o9khmv7A==
X-Received: by 2002:a17:902:f681:b0:1fd:6766:6848 with SMTP id d9443c01a7336-1fed9202ec2mr17180365ad.17.1721908384898;
        Thu, 25 Jul 2024 04:53:04 -0700 (PDT)
Received: from zhk-CBG100025892.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f3efdcsm12322795ad.217.2024.07.25.04.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 04:53:04 -0700 (PDT)
From: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add CSW MNB601LS1-4
Date: Thu, 25 Jul 2024 19:52:29 +0800
Message-Id: <20240725115229.3416028-1-zhouhaikun5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the CSW MNB601LS1-4, pleace the EDID here for
subsequent reference.
00 ff ff ff ff ff ff 00 0e 77 04 11 00 00 00 00
00 22 01 04 a5 1a 0e 78 03 a1 35 9b 5e 58 91 25
1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
36 00 00 90 10 00 00 1a 00 00 00 fd 00 28 3c 30
30 08 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
53 4f 54 20 54 39 0a 20 20 20 20 20 00 00 00 fe
00 4d 4e 42 36 30 31 4c 53 31 2d 34 0a 20 00 20

Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 9cfa05c7d193..2ef9a96f5527 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2079,6 +2079,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50_p2e200, "MNC207QS1-1"),
 
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1100, &delay_200_500_e80_d50, "MNB601LS1-1"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50, "MNB601LS1-4"),
 
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d51, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5b, &delay_200_500_e200, "Unknown"),
-- 
2.34.1


