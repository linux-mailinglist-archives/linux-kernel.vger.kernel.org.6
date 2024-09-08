Return-Path: <linux-kernel+bounces-320376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328E8970975
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D6A281AF0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8272F17C21E;
	Sun,  8 Sep 2024 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="MWFtjGyT"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEE417ADEB
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823603; cv=none; b=OZgPrvqG1ARSYhIfkifxFo3BAdEnZMHbfUBSW2G1ubbOA5c+IiNbu3OgtJTYwDUG8gP2U2Xu+8k9bGCmelSjnDT7iYB4ZOx/BDkOjEZAQNGy7KGc0HtZFShgsMBU2cGQWxYDOnRkmz/f1Arc8YBqQJE8nMIqvhDeCSwZ2XdZP+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823603; c=relaxed/simple;
	bh=Uv453XChzqhmZWRMQkqOnlFkUs+lQ3us5Ni+/tRzF+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YqCRiRY0qHU5WDepHUuxabt3n2mFu+8QovWYBDJsLbu/mwOFYmmjrHspqbBlK8yIAHU8TFRC99tR+ZmU/P/bXXR+IXPbB2482c8Li154V5kYM20w9sm455PW2b+0xWw4m/ZcK+ALBbCpItX5BFNpb7W5xV+d1p+Ur2NrHyAdZkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=MWFtjGyT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-206aee40676so29932995ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823601; x=1726428401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7XnG9e/QAF4rnhFuQuRFT1GYuJxlU3KXfTtbx67LXk=;
        b=MWFtjGyT2iEDBdgvdMv1msj8kODNi/42xnrO+04GutbpfSlevVzZMij69KoTus4+hd
         K1lWEn+bJJrM1IpZe8gFkCbGlR5dV6YxuAD+A7SQUBUECG2/z/R09y9+PKTb8/YprEgq
         mpR432fFu9gj4ZuTAkm/Bug6dXcS132wPKgtiBs9tXMkKZcFp0O6FRRLi3UVZAVrnO6P
         cxsV3sYOV1lDhaPWuTbM/nF2kchOLpMYZD0a5adeM0I7W4YLldXRoIQ1sUgKXZgrA9s/
         +F1w/oC5sA3PbxqiaF/qJxO+6pQbY8pJYV1j7mhl3kru61MBZm817jZv2+urZF9abwVN
         urUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823601; x=1726428401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7XnG9e/QAF4rnhFuQuRFT1GYuJxlU3KXfTtbx67LXk=;
        b=M/qk4Eucu99xjcJWoi4htr5KNAwfVxfuq/z/ozWcv/xaQmpw8wI+u0Jo4UrRm9bzsi
         EG567XAjbR3jSl7TpB1zCuCDTINdpzg37QW3ZPQw2EYnXCEw7wJ97G02nlJYPgt7iHId
         cuppKhV3gxXrOJ/4HcF4fSmS0PgzVp/P27ZD6e6HBHqWazzDrRFFTV++o8wRT+QfVDra
         afRYIIxSKLxWimTeRR/DqW+5V12lbWLtB3xEO4rT4VfC+AM9tMSdCeNqsnQal1ifoa1L
         fJSMTeMurx8PFPePrXpQYUgSebzTkHQ3/vTCXdRvDsJa6jKoYilcl0nWYN8btcu5AOsI
         v/zw==
X-Forwarded-Encrypted: i=1; AJvYcCXhX50/7ZPDzggmBjYGIuRStblgGnW8XsyV3P0dKZJUsSRbExje0pCk+fSi4judOXLE0UlmiTbdPWXskow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUf/3nzPdlBc5/TlYagAr/WtJPQFraFrka9nW/FH4/ASRWjJNE
	BwQSYF4E4Vnq5zhFCKSYL33xmyvYpCdtXQMx4RBipI3c2w5xHz3KnJo/CR/Nuys=
X-Google-Smtp-Source: AGHT+IHTjVvZ1RJRgf1Ym9zLzVykf3yLayQCY1X3N7JsfRGY0hhZBr6pA2fD8901J3hslv0NU1M5Ug==
X-Received: by 2002:a17:902:ecd2:b0:206:d6ac:8552 with SMTP id d9443c01a7336-20707019e1emr49683815ad.52.1725823601421;
        Sun, 08 Sep 2024 12:26:41 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:40 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 06/16] Staging: rtl8192e: Rename variable Para1
Date: Sun,  8 Sep 2024 12:26:23 -0700
Message-Id: <20240908192633.94144-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240908192633.94144-1-tdavies@darkphysics.net>
References: <20240908192633.94144-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable Para1 to para1
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 12 ++++++------
 drivers/staging/rtl8192e/rtllib.h              |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 059b1f478a6c..797ae6896d62 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -510,7 +510,7 @@ static u8 _rtl92e_phy_set_sw_chnl_cmd_array(struct net_device *dev,
 					    struct sw_chnl_cmd *CmdTable,
 					    u32 CmdTableIdx, u32 CmdTableSz,
 					    enum sw_chnl_cmd_id cmd_id,
-					    u32 Para1, u32 Para2, u32 ms_delay)
+					    u32 para1, u32 Para2, u32 ms_delay)
 {
 	struct sw_chnl_cmd *pCmd;
 
@@ -525,7 +525,7 @@ static u8 _rtl92e_phy_set_sw_chnl_cmd_array(struct net_device *dev,
 
 	pCmd = CmdTable + CmdTableIdx;
 	pCmd->cmd_id = cmd_id;
-	pCmd->Para1 = Para1;
+	pCmd->para1 = para1;
 	pCmd->Para2 = Para2;
 	pCmd->ms_delay = ms_delay;
 
@@ -618,15 +618,15 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 								   channel);
 				break;
 			case cmd_id_write_port_ulong:
-				rtl92e_writel(dev, CurrentCmd->Para1,
+				rtl92e_writel(dev, CurrentCmd->para1,
 					      CurrentCmd->Para2);
 				break;
 			case cmd_id_write_port_ushort:
-				rtl92e_writew(dev, CurrentCmd->Para1,
+				rtl92e_writew(dev, CurrentCmd->para1,
 					      CurrentCmd->Para2);
 				break;
 			case cmd_id_write_port_uchar:
-				rtl92e_writeb(dev, CurrentCmd->Para1,
+				rtl92e_writeb(dev, CurrentCmd->para1,
 					      CurrentCmd->Para2);
 				break;
 			case cmd_id_rf_write_reg:
@@ -634,7 +634,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 				     priv->num_total_rf_path; eRFPath++)
 					rtl92e_set_rf_reg(dev,
 						 (enum rf90_radio_path)eRFPath,
-						 CurrentCmd->Para1, bMask12Bits,
+						 CurrentCmd->para1, bMask12Bits,
 						 CurrentCmd->Para2 << 7);
 				break;
 			default:
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index f444e85a6264..1e119192ad38 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -164,7 +164,7 @@ enum sw_chnl_cmd_id {
 
 struct sw_chnl_cmd {
 	enum sw_chnl_cmd_id cmd_id;
-	u32			Para1;
+	u32			para1;
 	u32			Para2;
 	u32			ms_delay;
 };
-- 
2.30.2


