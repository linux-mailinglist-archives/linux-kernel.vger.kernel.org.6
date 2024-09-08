Return-Path: <linux-kernel+bounces-320377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2429A970976
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C300E1F21234
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C99180A6A;
	Sun,  8 Sep 2024 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Dtq5986z"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E851417B507
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823604; cv=none; b=uX4IIei5AnL8mS4zUA4vYDg6OjJQA7rjjw3cKYHaFhsD1jAIR+CFTGyt/4SIitRB+7RHBzjeXWyWjuyMHhRwQ6WYQWjQ6oBRU17E5UTYzkrcrQ7eAD9OhXjRVPaxueDnUfZfrx4Lm3yICzWcX3JoseCOJoZ1gv0TIU/3nZ/c6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823604; c=relaxed/simple;
	bh=MH6aGyjyCR3+hd4QwFcOX19n1eDoWHGgClfqbba9mJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VOxLFGgwDdo/4yRua9ffgBqmHRXdVUCPHZmuGGyANLGDmZCzt7gCfw/Bj5lO71PNoHiPPYmnqucA5Xsv4osdeiS3xfzgjKvWst/EFPtEHFafzDPfbeIOziWYa2xm9iUKTXuUyDnTLCQYAddwstk4O76pozmBzkbc2gyX9huad2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Dtq5986z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-206aee40676so29933085ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823602; x=1726428402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ftqolyz8gWWGPvTvx6N+frI8E1w5G5SfE2BkdB0MfNU=;
        b=Dtq5986zn5qXHdE8DWwBZTjNJhb0AYI74mbp1xETq0uziPI7AU53yFMF4bdz3N/3bA
         FYYMPQvhDK4cEaM9RaJUJ4tKXYgLWjDYv71Rl7xFykE4K0HiJskFuxKPV5NOjyAF/tlC
         vjC86BTJioc2JgUgd3R4XfcB3LcYQIVVlqp5gD5uwxEXa5UjKxV9YXq7DXOz7GqedfKJ
         dGUgXxHjVthj772e6fpaJ2hrxaIrbjfbzq4cLes33XOPbGIpTU5pWZ7G9JPCBzqx+NWX
         xEbbJ5caLQ22fucGqIsHmjIPPgha7KNVQAx2p+elI7+BeLX7JMPi6qE8zPtgKONHbKS1
         OayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823602; x=1726428402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ftqolyz8gWWGPvTvx6N+frI8E1w5G5SfE2BkdB0MfNU=;
        b=aQwYMrKpIsGRyc4Dhk71x+8oJCkFDOLdmi+CjcyuMCdVtVnY+fv7ys7575IiNHNs9V
         T+bX/5eyKVHLP3cqgRNEAPEKUBBd2ExavAX5JWJu5wTZSyZEdcvdW8VGtPmAgLdUEweR
         D/N50orfGPzYenddVeAmT9bo4jQ70FLtu4jk2TIMLYBAsZ0rr8ndxpKbKXhwMZYA2Kf8
         RYtrpyYqd44ChTIsWp2Qi8cUg8LWL/Y2FRONbYECxJ5fSIEUawjTXHlh+KWgR0m9BEpa
         eORC8Pv4iY1oBsOEfNX5WrRQ32zQtX6EvaKpkR61JDaDRZPvPkt9f4NQZ42woLZTQgo9
         Am8g==
X-Forwarded-Encrypted: i=1; AJvYcCVXEvnl3FIOpeyJKLunSK1qNKFB0MC01ivqa0SrVVFZWx4feKfByjgHNt5DIjnK0EK4lYixR4aekHNw6pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxo3KDk0UPE2rFRMujWSYvMXiVgAWnc/kh/o6OekDYwDV3Et8O
	WWSlxW0Qz4U+zZUda94lM162562bCifP90znYLtHIOYzX4JW8JXwpBFs+hxxNWo=
X-Google-Smtp-Source: AGHT+IGeZ7nGmva47T5cynSPkefa4WBJUMwXsmqFnSfY/ZmN9V9xEJjArTMrOHW5UbRafO+3C6POGA==
X-Received: by 2002:a17:902:e811:b0:206:9536:9778 with SMTP id d9443c01a7336-20706f2e3e7mr57113045ad.19.1725823602240;
        Sun, 08 Sep 2024 12:26:42 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:41 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 07/16] Staging: rtl8192e: Rename variable Para2
Date: Sun,  8 Sep 2024 12:26:24 -0700
Message-Id: <20240908192633.94144-8-tdavies@darkphysics.net>
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

Rename variable Para2 to para2
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 12 ++++++------
 drivers/staging/rtl8192e/rtllib.h              |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 797ae6896d62..fbe624e235df 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -510,7 +510,7 @@ static u8 _rtl92e_phy_set_sw_chnl_cmd_array(struct net_device *dev,
 					    struct sw_chnl_cmd *CmdTable,
 					    u32 CmdTableIdx, u32 CmdTableSz,
 					    enum sw_chnl_cmd_id cmd_id,
-					    u32 para1, u32 Para2, u32 ms_delay)
+					    u32 para1, u32 para2, u32 ms_delay)
 {
 	struct sw_chnl_cmd *pCmd;
 
@@ -526,7 +526,7 @@ static u8 _rtl92e_phy_set_sw_chnl_cmd_array(struct net_device *dev,
 	pCmd = CmdTable + CmdTableIdx;
 	pCmd->cmd_id = cmd_id;
 	pCmd->para1 = para1;
-	pCmd->Para2 = Para2;
+	pCmd->para2 = para2;
 	pCmd->ms_delay = ms_delay;
 
 	return true;
@@ -619,15 +619,15 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 				break;
 			case cmd_id_write_port_ulong:
 				rtl92e_writel(dev, CurrentCmd->para1,
-					      CurrentCmd->Para2);
+					      CurrentCmd->para2);
 				break;
 			case cmd_id_write_port_ushort:
 				rtl92e_writew(dev, CurrentCmd->para1,
-					      CurrentCmd->Para2);
+					      CurrentCmd->para2);
 				break;
 			case cmd_id_write_port_uchar:
 				rtl92e_writeb(dev, CurrentCmd->para1,
-					      CurrentCmd->Para2);
+					      CurrentCmd->para2);
 				break;
 			case cmd_id_rf_write_reg:
 				for (eRFPath = 0; eRFPath <
@@ -635,7 +635,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 					rtl92e_set_rf_reg(dev,
 						 (enum rf90_radio_path)eRFPath,
 						 CurrentCmd->para1, bMask12Bits,
-						 CurrentCmd->Para2 << 7);
+						 CurrentCmd->para2 << 7);
 				break;
 			default:
 				break;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 1e119192ad38..d63044607fb5 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -165,7 +165,7 @@ enum sw_chnl_cmd_id {
 struct sw_chnl_cmd {
 	enum sw_chnl_cmd_id cmd_id;
 	u32			para1;
-	u32			Para2;
+	u32			para2;
 	u32			ms_delay;
 };
 
-- 
2.30.2


