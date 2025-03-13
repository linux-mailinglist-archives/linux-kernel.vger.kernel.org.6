Return-Path: <linux-kernel+bounces-558756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 761C8A5EAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA27C1774FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CFE1F4167;
	Thu, 13 Mar 2025 04:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="go2wVPv/"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A2B1F3FD9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741841286; cv=none; b=ndFufZDxd5AUgK85yg/Cu7HAmgtywk5lXjcmbbfwgQyUPG0GuEHWupbyAZmuKo0sV9cpXg2dDpgb8153NNJAL3I+rAbh5shJ31KTxhzNp06dDdu2vlxdpda8PdZqr8E72T/ap+9o3faZ543GcVZ2cHQQ1/8LggYPNf5m93TpvY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741841286; c=relaxed/simple;
	bh=Y0Td/sWdH+knvqeBCTi/FRD4AvDH3lbDPwadbtlNZfE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XYs0wotY0FgCnp2woMgLZkSGzDGV7ZAytZYMZMrk7pigA/ud1myc9AyXImlHzK+yZuucqO2bhgTt1//uyMifKlB5yG1nMDMsR6+/1H5FinBRSK6BDV9fjq7Go7pSl74nJ9cDlrTPvTPkMpcDc/vMmlPf4fCFeSxt/lFX+yhJqSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=go2wVPv/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22580c9ee0aso9414525ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741841284; x=1742446084; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=REcOQ3NimKP7+/Ghwgmby8IZ78g2GtCKzkTqzXtjVyU=;
        b=go2wVPv/A4p4GOOQPYJW3ZiemYurgGkCM4P6pw4PSTTlo2H6yKzpwxjOOQ4o5udSPd
         mLrV8i8/QxMKyKdOqKF9JdX5rT+o6dXwkvQnAls0aspDMIw33iUgi8YM2Dd8FaplqS3v
         KBmXC6GfC+oJoSiX/rqjFdq7O9DGhUMfMVWTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741841284; x=1742446084;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REcOQ3NimKP7+/Ghwgmby8IZ78g2GtCKzkTqzXtjVyU=;
        b=QIdPRQKptRU0caOE3Z6uFcPNL1eUhLW4Uj3Widiq7gNmWcuSgCuIymikuuH2QrDJpL
         CbOsh0AcNAEgeq14U6h5VjV+pa0PSi9rc4ebN6S1TmuoCoIlaLb6gh2liTi6ijupP4Xy
         z8WB+Q/Iw72X5hFIL3kO2mFKUA/1BaGj+qr2W7WFmrBoXt6zeVQUwTowcd01aa518k7c
         JX2/861bs+LY4+UoPSr88HVEmzKY5XIeJ1EVDU3mA+rGVpnN1P1iqefXQ554VOIM6Kmc
         i58OLk/pOQaW3uWEE2NukFGFjSeQsLsBzMJdS5BBLInu4gCeqsz3+ctRKam8RyoCvbXE
         4Wvg==
X-Forwarded-Encrypted: i=1; AJvYcCUbky8rDiuY0e4TLlW/ViJbORzO+PeMHAbJJgRclLbYz16IA6Hb1sgBE69ZKY25bz0D7NoIGRk6JKZrxEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWV/y8aD6uybZU1NrENADUtJ409e80CeurtiHxlLLzUfSD3fgw
	6LNGvymeirFoX+TEIQV9DjfCG5vJLsp6SP4kKgedLPvaMPn0qE1Bv0RTDLZXOg==
X-Gm-Gg: ASbGncv+nWNaRzwSX2G958KEymtYUK20JpwdoLIALYTVPvEhpk6kvh2yzKuDxlMPS5M
	4wu95PXT11sl+tmufUBcSpdbO3/Un/nWcgiGoxa+kPryUp66k9Dlj9eyum/7+GFjthsqJL6Kdx8
	eww9Vc1SM2zm9VGyriumi8t4IM9PNIDoA2tCK5GEEFXTVQzlMF7RD7eL4Urn7WY7e/zVI3xOy8T
	XbkouxY0Rj7Uvtsf7IiBCJnE0ivq0EaX3iNl3No66hz4DZP8WgpPnVSJVEMm706IkM28OqZ/1DT
	GgQQZohPOS/xBRXRWm/NMu/aJFsKfsPXaJB4UmRvZ9sJePMWbClDXGqTZU9oD2aE8O0=
X-Google-Smtp-Source: AGHT+IFivHliX3YVhdxncqv12rrqQ3yO7uTaNUb3Gnhhii9egYkYfMhfwC4Ns2bXiI/Sc861z4Cx7g==
X-Received: by 2002:a17:902:ccc5:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-22428a9d152mr344857145ad.29.1741841284353;
        Wed, 12 Mar 2025 21:48:04 -0700 (PDT)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:1872:6051:5c24:509e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5c03sm4188025ad.249.2025.03.12.21.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 21:48:04 -0700 (PDT)
From: Sung-Chi Li <lschyi@chromium.org>
Subject: [PATCH 0/3] Export the target RPM fan control by ChromeOS EC under
 hwmon
Date: Thu, 13 Mar 2025 12:47:41 +0800
Message-Id: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG1j0mcC/x3MQQqAIBBA0avErBNKcVFXiZDJxppFU2iUEN09a
 fkW/z+QKDIl6KsHIl2ceJeCtq7ArygLKZ6LQTfaNqY1ivJJMjvybr23XVxAUWiD7RAn7ScDpTw
 iBc7/dRjf9wNxGYvyZQAAAA==
X-Change-ID: 20250313-extend_ec_hwmon_fan-a5f59aab2cb3
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, 
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741841282; l=847;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=Y0Td/sWdH+knvqeBCTi/FRD4AvDH3lbDPwadbtlNZfE=;
 b=6crJeFwDT8h8Rk+m2OeKexaNtQbX5DfEuIIILaDCnFdUl2qZRkUR2HWQEJBeTDc0KSkaDvwpF
 lcKNjE6CRHeBxUNV3+8QlRLnzLCaFg1kXTyCaoIVGAoUQQaXP69v0Lf
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

ChromeOS embedded controller (EC) supports closed-loop fan control. We
anticipate to have the fan related control from the kernel side, so this
series register the HWMON_F_TARGET attribute, and implement the read and
write function for setting/reading the target fan RPM from the EC side.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
---
Sung-Chi Li (3):
      hwmon: (cros_ec) Add setting target fan RPM function
      hwmon: (cros_ec) Add reading target fan RPM function
      hwmon: (cros_ec) Register fan target attribute

 drivers/hwmon/cros_ec_hwmon.c | 69 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 5 deletions(-)
---
base-commit: 9fbcd7b32bf7c0a5bda0f22c25df29d00a872017
change-id: 20250313-extend_ec_hwmon_fan-a5f59aab2cb3

Best regards,
-- 
Sung-Chi Li <lschyi@chromium.org>


