Return-Path: <linux-kernel+bounces-179429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D498C5FED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98DB1F25589
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2740141C62;
	Wed, 15 May 2024 04:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="RywgRV+I"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7246214E
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748773; cv=none; b=Dz/sHdC2L4pVCR1VIyxLv3KRrJcdHxD3+038AmPNdMVIKKg7QdSy0OsbL+tnExwfRUQSaKg6odd1piyYIanZFF7naDlQnM8BfrsUDzR+tSZqhOH3lYjoGyDQRRj+5oSGORZ7XFnaSACbrB/ErSpehggA4vg1sR7h9dxWr4Bo2KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748773; c=relaxed/simple;
	bh=I5J0U/zny6sQs9MsL+pGxgC73NN87CT+gNs9eRbmy08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nUSjc+6k3B4CiC8oYo6j+baEdXjGrxInCaUxyohKSPkCGYfo+UEPIpArUgYdi+bg6FY0kxDxhKJuolohsrNx/1dAlyEyI9dL584EyqvP6wlbWD4PtzB9FJQigXCo7Z2jATf6uNPJcUVLS8aRRDPKi8KXhmSMpXPcXrKO9NKueUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=RywgRV+I; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f4603237e0so4475986b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748771; x=1716353571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5JpqU9JVapL1SoY1GYeI+tVbuXEFUb6xhtDU141SUU=;
        b=RywgRV+IpBTlYMJB9Q6oaHsHS5Ixscrxxlmbdgud63SZ8Mchnc7nEMqdtIaFpO+LHX
         5DvsIx4Gr36H90cbJkJji5fxOntxd1EFTEN7To/T0rGqRHuvV7Q/Fs6ZDphbgNqA8Ctw
         4DDkXfzUmoSCkF6QVLWKSTs0s3ej/2DU4XrFudnM8t4lKZR14HtI8qclSA63Dgpb9Xhi
         Ltm0CEwiL6zzJDQ28zEPJMAtAZEtMpBZkMZ1sCCvm66Yau0iQwcffYgP4hVsvmaXm/Ih
         d4sTWZiUUYs0LkBeKzajxeLeHrAYN5EiAiQ9j1QAgzmwD8errlyaHm9q8ENFGG916fhl
         jTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748771; x=1716353571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5JpqU9JVapL1SoY1GYeI+tVbuXEFUb6xhtDU141SUU=;
        b=bn8KQHVJMmHHPyaN0z9ybUwhFpVZHJIrHRNnaOvZgbTLAX0WndaFjKDTg/giX7y1P+
         Hmas05YznBZz62nYIgakXzLzKp1JqBIgRx3/1213PX0E3KgFO2Hh/Nj8uekfqZ3nxVs8
         LnzX530gPE7yruKbmY/QH8WK/x4pSF64HypyWLie4xDLQkAEwV7z6FDp2WU03TsQxmsI
         tpON5AiSFmFIgrj+EoCcequJJbiJykV1BWEBMgtrKL17/I4kCS/4GQGaC5eMXqhrguHI
         b8XAYxD7TlndJpqnLK212yuPlWB43YKjOu+X3cysSjrG/P2qXcraNEHlbNbWTM4ut/1c
         CmeA==
X-Forwarded-Encrypted: i=1; AJvYcCWx8rJFoypZ1z5VBvYG4Cpr+B1KWEKF7Ie8Z6u6vHtIDohmObP8xCZtvxNyydmRLQr4Xj6/I1TeQyxZWpqSGvEssxCJ+8BdXYMuAG2h
X-Gm-Message-State: AOJu0YxrxnOrS7v/y+QmcDQN52nqxSMd7FSCCFqs2aNKp+4DdBLDTo2e
	GJFz1iTd2EfOZ+qfOkAVmkVuwQSepGKdmiQl1Yi7QFSroU+FJze3QzIQYeIWUbTYVzTSq7gq7Bw
	4
X-Google-Smtp-Source: AGHT+IEVv40Dnq8ip0fudfMSrfpWy6p0OWbYK+tmnZ5++CVu+sEhT0XODfnqgBUAn/G1d4ey/TA7vA==
X-Received: by 2002:a05:6a00:a91:b0:6f3:ee23:3c39 with SMTP id d2e1a72fcca58-6f4df3d81b2mr19842221b3a.7.1715748771129;
        Tue, 14 May 2024 21:52:51 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:50 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 24/31] Staging: rtl8192e: Rename variable bMBssidValid
Date: Tue, 14 May 2024 21:52:21 -0700
Message-Id: <20240515045228.35928-25-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515045228.35928-1-tdavies@darkphysics.net>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bMBssidValid to mb_ssid_valid
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0914ba37f42f..91164a3b01aa 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -914,7 +914,7 @@ struct rtllib_network {
 	bool	ckip_supported;
 	bool	ccx_rm_enable;
 	u8	CcxRmState[2];
-	bool	bMBssidValid;
+	bool	mb_ssid_valid;
 	u8	mb_ssid_mask;
 	u8	mb_ssid[ETH_ALEN];
 	bool	bWithCcxVerNum;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index ffb1bbc01bc6..d662a12bf437 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1820,14 +1820,14 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 				network->ccx_rm_enable = false;
 			network->mb_ssid_mask = network->CcxRmState[1] & 0x07;
 			if (network->mb_ssid_mask != 0) {
-				network->bMBssidValid = true;
+				network->mb_ssid_valid = true;
 				network->mb_ssid_mask = 0xff <<
 						      (network->mb_ssid_mask);
 				ether_addr_copy(network->mb_ssid,
 						network->bssid);
 				network->mb_ssid[5] &= network->mb_ssid_mask;
 			} else {
-				network->bMBssidValid = false;
+				network->mb_ssid_valid = false;
 			}
 		} else {
 			network->ccx_rm_enable = false;
@@ -2350,7 +2350,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	memcpy(dst->CcxRmState, src->CcxRmState, 2);
 	dst->ccx_rm_enable = src->ccx_rm_enable;
 	dst->mb_ssid_mask = src->mb_ssid_mask;
-	dst->bMBssidValid = src->bMBssidValid;
+	dst->mb_ssid_valid = src->mb_ssid_valid;
 	memcpy(dst->mb_ssid, src->mb_ssid, 6);
 	dst->bWithCcxVerNum = src->bWithCcxVerNum;
 	dst->bss_ccx_ver_number = src->bss_ccx_ver_number;
-- 
2.30.2


