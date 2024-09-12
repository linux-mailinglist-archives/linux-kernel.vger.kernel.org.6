Return-Path: <linux-kernel+bounces-325932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD046975FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4221C22A82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E66188A3A;
	Thu, 12 Sep 2024 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOO7wbzZ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2851714BD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113873; cv=none; b=ThQzGc9YjL0g5zF3mRc3W/VVFLLkhS2r38nyiTX4nD236Cpj1jBxDnTVJrOgWbTW0sl2jAlRtU9dlVuWMzp4HXmzYLgpOlSfJvSN53XG1X6tsuzfUgVEmj/ZjNw/mHzvXkEEf51j4zNHfCOdvnLVZSVr+1x7UCzlWA9oQuwLpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113873; c=relaxed/simple;
	bh=DC9yr3m4EEGFR6WO9pMKucALZ4AVOWvk4PmIwuJCAYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=axlAdRCvKKs1aBjrZJblCkO5C1GRrk6zt8ytL4XBkLDrd1PPVCJcocdehR69vAKx7fI07LAiJt5JSXkH1VQtQTOf4/X04aBfA5U6mBFJPgO1U0WesamUzE/ClRPx4eQJ0zx36Lxw/XZUN1IZZExMiKcrDAtpSpkeihJyygnitT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOO7wbzZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so423010b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 21:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726113870; x=1726718670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yI7jF4cpO/8etoNk/Ze3jPcBLq+JHndlopVNbhxhuk=;
        b=KOO7wbzZkxZBH8taSMVHx36mYNRrcK5W2S54tLm4MqA+cQnIkorSCQfCc9f3XIwqAL
         gGIfKawNeHjH/FsVpY0l4GeCJo1mhw64esaB1Rch0rpnEh0MukMTISscLHPjQyaM9/2c
         yJmrvmfhkgOvfxW4dWXS0cv1BjOIfY7kKPGqfn9m9ToN7qgaoOabevqHn1Ty/lsldBB1
         CyyDElmfVwQ4iR6i1jObARpRqy+DVpYM0aQOMPAx3ouijIBV11SEvUfP7oeH39dcqoSN
         E77RZAQeZoET/quleu3PLYkMiPrIXoCoTNv3OL9DjX6xEQdnEavBUi6JoblObeETnt9J
         ewWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726113870; x=1726718670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yI7jF4cpO/8etoNk/Ze3jPcBLq+JHndlopVNbhxhuk=;
        b=eMTeZ6Bajrq2uYuCsrGoO3RzgLuRobJlxJbWhw9iQ2AZwuoGgjeYcK58+7Dl6QFzL/
         CmMRrlxmz8heu13gZpaGzH5hxE5xZwNcIE9KWWF3Fxjxa/cQprCPX2TGkhMz5JnXXyWZ
         0XyFsPlTxaOY1W9BUsyUZVLpdQGILQ3xz90k+pUuKHO42JVRlRA8mpYxEHtx4eT5C7MK
         OzYedA4zibV0ZhqTxuOPCU4Ze55FvnJg09DJ0tgJFOipZ85x2KOOVpBd8eTuzY1at/J3
         wzbnFK1LxW0+ZpOxc3XGghwI0FVPcxRLKrDj57N/yMrT8zaLnSCib5pBo7jw9SsR68uP
         MBSA==
X-Forwarded-Encrypted: i=1; AJvYcCWYwneNlnKuRvsmlHIALPgP6uwbN9ZvIn+RV4PiAOdH2n4sUz7dG4nhP71N+Qsi5806xFiH2CqZIrWMfeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdZ9kAmpPRYOpwGTrJ3PKVesDMkkjMqa+AhSB0K+B4eDv1BFsb
	Up4mEMRnrWQAW0VOkRkYCQySQrc1OVX5qi/6upb1WMoJMHUGShKc
X-Google-Smtp-Source: AGHT+IFydLn89r0f6WJgz3Uj1DG+bkZKzjE52wn9tyRBLoumr08TCAvGgM4lS/6zabbgp9OcFTaJ6Q==
X-Received: by 2002:a05:6a20:72a7:b0:1cf:e5e4:a24f with SMTP id adf61e73a8af0-1cfe5e4a32dmr282376637.8.1726113869805;
        Wed, 11 Sep 2024 21:04:29 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([2409:40c2:12a7:616d:eca9:534f:4e49:7c41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fba469fsm768359a12.11.2024.09.11.21.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 21:04:29 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	guilherme@puida.xyz,
	philipp.g.hortmann@gmail.com,
	linux-kernel@vger.kernel.org,
	Sayyad Abid <sayyad.abid16@gmail.com>
Subject: [PATCH v2 3/8] staging: rtl8723bs: include: Fix indent for switch block in rtw_security.h
Date: Thu, 12 Sep 2024 09:34:04 +0530
Message-Id: <20240912040409.3315067-4-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912040409.3315067-1-sayyad.abid16@gmail.com>
References: <20240912040409.3315067-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This improves code readability by ensuring consistent formatting.

Reported by `checkpatch.pl`:
WARNING: switch blocks should be indented with a single tab.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 .../staging/rtl8723bs/include/rtw_security.h  | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 74613ad9a371..ee4b5c5804fb 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -171,20 +171,20 @@ struct security_priv {
 #define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst)\
 do {\
 	switch (psecuritypriv->dot11AuthAlgrthm) {\
-		case dot11AuthAlgrthm_Open:\
-		case dot11AuthAlgrthm_Shared:\
-		case dot11AuthAlgrthm_Auto:\
-			encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
-			break;\
-		case dot11AuthAlgrthm_8021X:\
-			if (bmcst)\
-				encry_algo = (u8)psecuritypriv->dot118021XGrpPrivacy;\
-			else\
-				encry_algo = (u8)psta->dot118021XPrivacy;\
-			break;\
-	     case dot11AuthAlgrthm_WAPI:\
-		     encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
-		     break;\
+	case dot11AuthAlgrthm_Open:\
+	case dot11AuthAlgrthm_Shared:\
+	case dot11AuthAlgrthm_Auto:\
+		encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
+		break;\
+	case dot11AuthAlgrthm_8021X:\
+		if (bmcst)\
+			encry_algo = (u8)psecuritypriv->dot118021XGrpPrivacy;\
+		else\
+			encry_algo = (u8)psta->dot118021XPrivacy;\
+		break;\
+	case dot11AuthAlgrthm_WAPI:\
+		encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
+		break;\
 	} \
 } while (0)

--
2.39.2


