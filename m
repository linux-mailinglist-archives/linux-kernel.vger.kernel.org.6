Return-Path: <linux-kernel+bounces-294832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C71295932E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1721C21C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5D5161326;
	Wed, 21 Aug 2024 03:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="YBom/pzn"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664EA14C585
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724209745; cv=none; b=D04IS5wp+JDrOHIY31RXBI7RWTbW7TByOcthBihq7FL0iTilHogV3CALN9c2TDtRej6SMAWFVTG8AUMQQ+uPCi2w34fweLdmWMGG3pBCdHCvqsCsJZ4N9paXbQngSb1E/+CdrSCc7u6GrBO6HxArgPsICjnYosedLwPXEnUvbpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724209745; c=relaxed/simple;
	bh=OgupjbwZxJtwbKs8uwIgnJXa3XgsICYOxW25vliQ/JI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XGf1OsHCZYn/lWnBRbG89N8Xr6rbhnGqEaZXFGKraRIVCNHUQidi6zYbBpj7MbctX8r6JfC9LE3EngifLMjrEi1cBFDkBXVwdZBCc/ELBb9gcWhjIbUe1vEiH07RJ2LgfeqWQ2DQN5EkxPAdEYZJ+NQi0HeuPWfzgzgBmtbFYqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=YBom/pzn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7141d7b270dso759002b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 20:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724209744; x=1724814544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMswoQdcQDB+68kNQFHdjIqBsXKdVKD5NmR3GsOvbvI=;
        b=YBom/pznddHtuUeo2zm+jeAbtOdC0DlUXHBV0hyKQ6S6Rq+Ja5PAdW5/9OM1a92azF
         zX4CSMugSKVR+uYl+R9TYhj06SVGbUEliFwYQwdl5Ec3LEXY37ygvZHhlPoUS9871otP
         ai70CGd9PifQnPxr0C9LvJ8obndyWyJF9JRH+bhjAfXDxOhLlTATeEf53h0AblYg43t5
         W2mqqWAEep/AWmsen1qb6Zezix/bG3U4kTR8MHNDyVMsuS49pqv2ac5h4FN7C8eS6HQP
         bSO2jIWOvcZbcjqWZqE93UprvwbMYnuShDuZV37+agxozxpI/1PD3mWxpSo8kPRdlNkK
         OT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724209744; x=1724814544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMswoQdcQDB+68kNQFHdjIqBsXKdVKD5NmR3GsOvbvI=;
        b=wzNXH3q24uMVLdq6XE7dlinlMnA0Bk4HsclP3YCOoi3Xdch0RDYRtNDsqlXh0gXaf2
         SjFXNAU009Y/1M1/LE60QRjf41/swN14uO/IzNwA4F1Vs+mo5Dqo9GqiVuaEiEGyrVIl
         JE12ft6f9OZ1WQJbMvZz2gE2fIXY8mDlkvHtTM4sbvW+85rpb2govfTXjpEhxQg2QD9S
         vMDAVwSgTSiIM1Y2NL1c2WNzNJK5E+lIUH0AFLbMuQiwGXrko/GSOq9G9a9qu02Gzce8
         k+514p49d3pkcpjNpVAE9kFXC8xxVlvpSIatNGmrx9vFJKcaP0EfPQCwVN3lqtvLcdBf
         KHrA==
X-Forwarded-Encrypted: i=1; AJvYcCU03IAMahKyhB8W2Y1JiQuXAueMqX+5np0CS6fShn4RvcFN1Xo1gndnpigMWXr0gp5S39ZG48we9Mv3ES0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk5SBPmlqpU0r5bYy4sK+vohWFiC40MaEGpY2kTWJxHuQDCBJ0
	EYkeN3z7VqAQZUBOi6L6x+ab36BRM2ixfLcDknhn/JoGielrQjemzV5BV5KsqKk=
X-Google-Smtp-Source: AGHT+IEacPOhcvQcCJ0bbOFyFdborzVEZdw5GH+A7eKbynNMSnx4cscTCzOKbeAk6wNWl+ekKes5OQ==
X-Received: by 2002:a05:6a00:1788:b0:713:e3f9:b58e with SMTP id d2e1a72fcca58-714234b1550mr1460422b3a.17.1724209743649;
        Tue, 20 Aug 2024 20:09:03 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add75dbsm8934404b3a.44.2024.08.20.20.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 20:09:03 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 4/6] Staging: rtl8192e: Rename variable CmdID_WritePortUlong
Date: Tue, 20 Aug 2024 20:08:54 -0700
Message-Id: <20240821030856.57423-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240821030856.57423-1-tdavies@darkphysics.net>
References: <20240821030856.57423-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CmdID_WritePortUlong to cmd_id_write_port_ulong
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index e82e992dd139..8a1aac7e10a2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -616,7 +616,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 					_rtl92e_set_tx_power_level(dev,
 								   channel);
 				break;
-			case CmdID_WritePortUlong:
+			case cmd_id_write_port_ulong:
 				rtl92e_writel(dev, CurrentCmd->Para1,
 					      CurrentCmd->Para2);
 				break;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0eaca4be4f15..65b2929b7bc4 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -156,7 +156,7 @@ enum sw_chnl_cmd_id {
 	cmd_id_end,
 	cmd_id_set_tx_power_level,
 	cmd_id_bbreg_write10,
-	CmdID_WritePortUlong,
+	cmd_id_write_port_ulong,
 	CmdID_WritePortUshort,
 	CmdID_WritePortUchar,
 	CmdID_RF_WriteReg,
-- 
2.30.2


