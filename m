Return-Path: <linux-kernel+bounces-294833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91982959330
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48676284CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33CF16A94F;
	Wed, 21 Aug 2024 03:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="iyaM8Tka"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7915886A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724209746; cv=none; b=QEyAYuREKqAlZFVBYa1rkZUqvyNpnEZZLgABbTZISzGR1EJRxMkfscLvWR2Oxq5+ONlpxrMAooBU9itxu5Ru4ao/rHOZOQMF1umymSOXdO/UB4cIkskIQM0TwcGIMDmgGwjPfz5qCP+aw0wgQ2XNETjreYOJp/BuR2UBTtCffiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724209746; c=relaxed/simple;
	bh=nJcct0OpztddfpVdAVf6I4hnYTMXn6TsX8QZw3nz3a0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEh7R4Aq7U0q181nhtn4/PKlCyE34EIF43mE/m7OMh4TazuPnuAHraUyF3MZXeFpyCh96Mu88R8XQ3NX4Kau+q6QUKDDa38F0I0pRUBGzXxTY8WwFRsZ/y/79/F2vN1HrSRJo+pZhUFNyCrp/uBynRxI6p+dWv/F+jDCHkHkCrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=iyaM8Tka; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7142448aaf9so170776b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 20:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724209745; x=1724814545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkSShF0hrqe/gls8cgK85cQZIDu2x/vh6+l4HrmEaTo=;
        b=iyaM8TkaB+jQqFwMAFzyEtTp9dFXc7KiZNzxXu35QBiqifnNjgGFmxXsbJT6m3UFzh
         Ko7/hcvPCAPxxqxW84QO+TcFKDm43BcDYMAvoJZ0F8TXJQek3DkZq3Nvy4O4AZP+taG3
         SqBL6CKI5DzNRAjR/g/h4+/Cj3bgM44SsRCu3kfO25HJTPW20E0I5r3aRW2oblULCp2+
         eGWEFyG9wKxb4uB0dfCLHw/eleug8H2jBr78ExzUWoMzoS5oBxWkrwMYdbWruVtmfMhc
         Hb9rwOcWLgm4pljQnzyPCHTdyUukgxBPjf31VZYhyIpet+CCAEs9C7Rjx/zr28NWYRIB
         HKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724209745; x=1724814545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkSShF0hrqe/gls8cgK85cQZIDu2x/vh6+l4HrmEaTo=;
        b=SQ1zvGGWFg+c3BOL3o0/7QuL0XxlQEkaItGK+FpWxySAGayF7k+i1giWj9rm1PxL0R
         Zy3TF/v4xfyCZO6XuZVRkPuBIYglGOYJ/zHChN0Q3Vqvry3X+/JzYWh+sb1Rg+vvFOfR
         CBirDFtqhNHWzqr+y564X6pmocDml6F2ySGmf3sXd/5uD/tyFME4lDMfpc4kdkwxXS7d
         IxxXS7F6kFsDsUBHM/77c6fopW6tbtmBIpBmskblRxqHCsSwJllPuLjQAM1hagF4acZg
         FMc7ROicWGUb3wU5r5/r3nrWP5ErITueu9onKWyzs3VeCTRR7LvKZeR/N2ANLi2tuCSE
         tT8w==
X-Forwarded-Encrypted: i=1; AJvYcCW1bultAFTgysQlumrPlHeoZtVihHTYcefQAovt9F4Tg2MrVbKYRrubNBocYb2g7Kan9hb0hsyjS6COQtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc3GFICZChv99v5vMYZj4W+8QK7bR4wWXrbLcqzvy4tjMmA8IA
	HEfPL7M2QzYCBqiN0aOQP5TpLhZkMsUgKyNQlX9m8g+6F02dx1wWCAyRwMMzXsg=
X-Google-Smtp-Source: AGHT+IHyIguUDs1vlY6oUjbOZZ8tJlMryYgdm279gMIwoUwcPTFtvMaTSMFfTA7dCvSXhm0ATJV6tQ==
X-Received: by 2002:a05:6a00:2ea8:b0:70e:aa7f:2cb3 with SMTP id d2e1a72fcca58-71423e6822dmr2273756b3a.2.1724209744514;
        Tue, 20 Aug 2024 20:09:04 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add75dbsm8934404b3a.44.2024.08.20.20.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 20:09:04 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 5/6] Staging: rtl8192e: Rename variable CmdID_WritePortUshort
Date: Tue, 20 Aug 2024 20:08:55 -0700
Message-Id: <20240821030856.57423-6-tdavies@darkphysics.net>
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

Rename variable CmdID_WritePortUshort to cmd_id_write_port_ushort
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 8a1aac7e10a2..c49dd8094c7c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -620,7 +620,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 				rtl92e_writel(dev, CurrentCmd->Para1,
 					      CurrentCmd->Para2);
 				break;
-			case CmdID_WritePortUshort:
+			case cmd_id_write_port_ushort:
 				rtl92e_writew(dev, CurrentCmd->Para1,
 					      CurrentCmd->Para2);
 				break;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 65b2929b7bc4..0850ae0015d0 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -157,7 +157,7 @@ enum sw_chnl_cmd_id {
 	cmd_id_set_tx_power_level,
 	cmd_id_bbreg_write10,
 	cmd_id_write_port_ulong,
-	CmdID_WritePortUshort,
+	cmd_id_write_port_ushort,
 	CmdID_WritePortUchar,
 	CmdID_RF_WriteReg,
 };
-- 
2.30.2


