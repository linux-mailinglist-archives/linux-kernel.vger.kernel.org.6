Return-Path: <linux-kernel+bounces-320127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C270970665
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB162824F4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B48E1537BE;
	Sun,  8 Sep 2024 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/jgDR3M"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5E1531EB
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790299; cv=none; b=QeAslpssn5l2F9S5LmuTtVh0EBTxu8wcB79Elqa5DUqXlI2x9CP4GwRilCNRgQfXo/Dfgrwkzn+O2zlzeAAVX+zAmNgt0wmkZMYzK2oWCIqUKGdBxyzQOlSUGz3+q+/TS6PfXppzx9Q349ck5AYY3RrL4d3C0oAsThV1BIBr0+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790299; c=relaxed/simple;
	bh=483x2FSxPESFFxIfnShpBoUUsKE1beMkctUgEWytKaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jD5sl+Pv87mguDCcd6WUTwRY3ahDiH8brFcDwfiNtIM1U+fosl7EmIxPMLunaHhsSRFehg87Bd320HYqvACukWKq5fZxvTvjqptz2vGH3WI8FC3jHQTtlP3W3L1AYXQDWo32RpF4Pcy5bdWSTr9SxtWFgn3YpTmN9WkgczCI3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/jgDR3M; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so2274015a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 03:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725790297; x=1726395097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS2VzpVc7dJ/AT4s9AMcRZ31HOXjijKxq9pngMXABpU=;
        b=T/jgDR3MF60X6aj+V+9R3QqpQqhalb8V4VMj4x9e+tN6vzxILJnmz2seA5P3iF76Rt
         eMCKM7gQXVE57OueJtcL0pU2DKR4uhZCrDYFOYRFUOakyLQqn3CqZB0FYSKAXgVytoy6
         2Ua2szLKe+TiV0S4A6UuEbXjmlO0bEXL1DSyybtmp/PK+2dHx/FrO+bzwZZDqOCv0KoM
         4euwsneuYX7p4qhPZUJZRYk9fTBPVsM7EGW4/A/+0a0jK2atv7Oxfs/xYgXcsv7E+KTN
         L86PGc3Ia4D5yOwV8P0h6mQFuwl5q1tuGMVGczVoNVnybyrjJEnx5y3sFqpa+Dy2BYfN
         Nwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725790297; x=1726395097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS2VzpVc7dJ/AT4s9AMcRZ31HOXjijKxq9pngMXABpU=;
        b=LwB0FrCU9NA2AFAvehxiNLmvUrWzzdyN9xeEATpQJct3YEWeiHnCzc+ylhEf8jpwvB
         c3MtYHsoLtWxH+QLMBxchggQUF32DTrWRTGXVf38p5yIx5P1XUIO5NbfpiXNCFnn/0ko
         EGMDa131Jq/P7LGXuYcRtmuephmnq5aunzK5oBg4WhFD2ao+NeqcM2W3kmJpEIszlegE
         Ru+Ecl4ncQkDPutbXXMav9t21LT+xuS8Gmaa+40Ki5Cd1YyGBXwY7jGeWqmRG2KF2uZg
         9dbCr+8v+AeX9GGhviEILZROyuq/CImwKVHl2Lrnw0aKTqCgbJLfCsSrJ4hUHlq9Bmp7
         kzDg==
X-Forwarded-Encrypted: i=1; AJvYcCVKKgzr0p7WcyoMChv1ZBUNmDH6EwwNwqJ+7BZhWSyEYmSZyEodSGe7k6u40qyrjNY85DkXFwgkwd8lMhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpf/sNvra9lu34xdWfrMh1LSKwqySUl2PzGBXOYoYcJG1/ibwy
	YC2QMMaaAUJQP0k4kc02l6Tch1s0hM3O93Ea6JUZoiLUc1zi86yKXSeLJDgSlvk=
X-Google-Smtp-Source: AGHT+IHJ7o1p0iqupb5RIo7H5GyO4HCiTFe05FSVlpTqlLviSdgV4ymj1jv4O2HjhZDxkZzc+VnpVA==
X-Received: by 2002:a17:90b:3143:b0:2ca:7636:2217 with SMTP id 98e67ed59e1d1-2dad4de1151mr9596174a91.2.1725790296990;
        Sun, 08 Sep 2024 03:11:36 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([103.57.172.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0782dfsm4589379a91.34.2024.09.08.03.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 03:11:36 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: philipp.g.hortmann@gmail.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	sayyad.abid16@gmail.com
Subject: [PATCH 6/6] staging: rtl8723bs: fix no space before tab and statement start on tabstop
Date: Sun,  8 Sep 2024 15:41:10 +0530
Message-Id: <20240908101110.1028931-7-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
References: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the space before tabs and also makes the sentences
start on a tabstop instead of spaces.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>

---
 drivers/staging/rtl8723bs/include/rtw_security.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 740c8504cba7..f005ec88d00a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -162,7 +162,7 @@ struct security_priv {
 
 	/*  For WPA2 Pre-Authentication. */
 	struct rt_pmkid_list		PMKIDList[NUM_PMKID_CACHE];	/*  Renamed from PreAuthKey[NUM_PRE_AUTH_KEY]. Annie, 2006-10-13. */
-	u8 		PMKIDIndex;
+	u8		PMKIDIndex;
 
 	u8 bWepDefaultKeyIdxSet;
 
@@ -183,8 +183,8 @@ do {\
 			encry_algo = (u8)psta->dot118021XPrivacy;\
 		break;\
 	case dot11AuthAlgrthm_WAPI:\
-	     encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
-	     break;\
+		encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;\
+		break;\
 	} \
 } while (0)
 
-- 
2.39.2


