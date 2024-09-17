Return-Path: <linux-kernel+bounces-331293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0231997AB07
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07461F28AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1992C1531C1;
	Tue, 17 Sep 2024 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Fc67MlHT"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87C94F20C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551122; cv=none; b=RxLCO805fvzkBAKnf5e9XvlOqe27CnocH3fKxr3rDRQILoDA9898ZhP6ijQMDrcMic61aeSKqSiS6QRII9xe5SkNyl2n7R1WIIBIRZYwYutV1i5IkHKzqSiy8jr+19N6Y7E0dDJJgkiOtrZoDfByKNaLjZ99Ay+Fb9xb07tmEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551122; c=relaxed/simple;
	bh=kHUjYYobMsHP0b0GyDeuUfksbTh7OEkDLcKNPpUk88E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f+KNwo7XhQAT3NnglOGr9WXEbjgBxg0CXLApC0C0iKBvI5bYwyGYH8i0Ld+M5NcmWRS/H+xGNSSmQF+ZK3MASa4bH9+eOemivZQOAYheN7ya1TjB5jM+wgoXOg2fwqWz82Tap+lscPWYgeDBH5jzD2v/Jn7LQsRMeiKwxeUPPL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Fc67MlHT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718d6ad6050so3183170b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551120; x=1727155920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Brl9Ndwral947QcNfp3rLAEaFYQe+FUYAGB0RsF6Q94=;
        b=Fc67MlHT9qWqmxbVhG7u6MyLsMju3Ei0Hkox2gpfUGNKhnL3Ql2EQfNXivpRmz84uV
         7Kt4n6GfdYzjGhLHE4WFrjhimwavsSkQ+CUqkBd0I6UVmAVbUEeG3D11TwjbYtdfDyKD
         NSdWvF4VwDmOPKnNLnekbDn/+3xdom7NDu9I5iesNw6bGF0WUtMiUKaXp2LPFZw0qlC0
         gTN3mvwAANjfqNc/87e0WkBqWprcyIeL1GAtIClGrhbf29GOYZ7WasMx/SJVwkkwYpld
         RYpsXHxRg6poVl+rP553/joBTPbK4ZPN4uDXIvXxiZApGLf5lFtoiYTcM4VC8wZLzZSS
         B7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551120; x=1727155920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Brl9Ndwral947QcNfp3rLAEaFYQe+FUYAGB0RsF6Q94=;
        b=b5DkH/buadD1p9ilhTJnQoVjicfipv91NjEhT4Ct4AkednklnawLD95ckkW76M7mJg
         wniLJVMTfoXLkiBfZVhSuVUMcI5iuxBEd72Qpp+rTZ0IxspZ6WSiHGL3xpvk3bZJKiEZ
         twuGeOrc8HO6Fpdll/1f3zoWO6OXUnIEZMghltZc3O1Ygyq9y6fKA53+ZTfM+ewJzL2J
         gdpeG+5ngjPXPvbQHbagRaEvbj2dM5UO6K1oGD5oYdCrUQQivX5ikVsoZR6oK4MHcmop
         vwvKSuiLKFh0SrTFzzLET3Dt5heYFKmfHKdkYbEfDs2J3rUt491bumD+J4iNIbTGGD4b
         1PQg==
X-Forwarded-Encrypted: i=1; AJvYcCWPpGUg1FBX1QPpmNhjYQaB9XofuNCeqpEfuqo3Tp5Lenm59u5A71NhmPtpRI+JgrCc940i96JTiDIL2Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytRs6QqXjMSEZWkbA0IgTidX8NiAf94L5FPCmtDK+OQT8JdLxI
	Dl+Vyfp/q4QDGFtyWwCv+3eSd3K2EW/UvpOV3MmRZDrmPMsTSoULHMnSVJzfSxw=
X-Google-Smtp-Source: AGHT+IHonY/648LNu86O9zY6FRO2AqJejtMXZEGGZJ5dbGQi8MT6JF7/KxB/7Zo8xmjyO4LGKDxclQ==
X-Received: by 2002:a05:6a20:948c:b0:1d2:ba7c:e180 with SMTP id adf61e73a8af0-1d2ba7ce296mr11125404637.6.1726551119917;
        Mon, 16 Sep 2024 22:31:59 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:31:59 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 06/18] Staging: rtl8192e: Rename variable PostCommonCmd
Date: Mon, 16 Sep 2024 22:31:40 -0700
Message-Id: <20240917053152.575553-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917053152.575553-1-tdavies@darkphysics.net>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable PostCommonCmd to postcommon_cmd
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index ac9aea228276..b583ed0d7e92 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -562,7 +562,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 
 		PostCommonCmdCnt = 0;
 
-		_rtl92e_phy_set_sw_chnl_cmd_array(dev, ieee->PostCommonCmd,
+		_rtl92e_phy_set_sw_chnl_cmd_array(dev, ieee->postcommon_cmd,
 						  PostCommonCmdCnt++,
 						  MAX_POSTCMD_CNT, cmd_id_end,
 						  0, 0, 0);
@@ -597,7 +597,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 				CurrentCmd = &ieee->RfDependCmd[*step];
 				break;
 			case 2:
-				CurrentCmd = &ieee->PostCommonCmd[*step];
+				CurrentCmd = &ieee->postcommon_cmd[*step];
 				break;
 			}
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index ce36f0979294..352b79c2df2f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1401,7 +1401,7 @@ struct rtllib_device {
 		struct rtllib_rxb *prxb_indicate_array[REORDER_WIN_SIZE];
 		struct {
 			struct sw_chnl_cmd precommon_cmd[MAX_PRECMD_CNT];
-			struct sw_chnl_cmd PostCommonCmd[MAX_POSTCMD_CNT];
+			struct sw_chnl_cmd postcommon_cmd[MAX_POSTCMD_CNT];
 			struct sw_chnl_cmd RfDependCmd[MAX_RFDEPENDCMD_CNT];
 		};
 	};
-- 
2.30.2


