Return-Path: <linux-kernel+bounces-179412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BF38C5FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C002838FF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A9840855;
	Wed, 15 May 2024 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="iUX/SpL2"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED7B3BBCE
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748761; cv=none; b=LBTkppxUIRWcYxOI46ot1Do7dP01PdQ4GyxuEJaaBU/nY8MHeOhAUp1e6lJCcl87ZqWcCodEb8h/4f8lUiIiaGbmz/20Qt1r6kKHL49vK1mb9FRAld2QbcFu75UFrGM5vTp3WA1L3XXz8Ojq4zto+4Pi7D+yP/TuuH87gksM/H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748761; c=relaxed/simple;
	bh=2vCRfNs3ZoRpdHPQTS1iVcZSbxc+pNKyzsoICvpoMhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pzQVeC7xcPdCFqpuwTr3SFzzWKYAosr9NAPkTU7kBLBaD+uv9ifUfybYctgas1bcT/u/jYDuDE08emetW8ArYph+TX/f7Bx5xHVgm1F67JYNtp/VBK1ox3egRncRvfsf/O7t8FpstiheTWE9TzUmn+1Avmlozl8STZHr02+NV5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=iUX/SpL2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f457853950so4881325b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748759; x=1716353559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NN5bUoGVMW2u4IDIB4KeRdUT7NeTKlHAi/jP0KOF3p4=;
        b=iUX/SpL2kVFCwi28ZaYYjujWhe8J935rnkFY3niLjJQPFVLY9rNXQViaCaoJ74bMic
         sd0oqowVfxSmYL0ddo/eGK4VDIFE2aCDPMj+6ApecWZAd3w2ec2k1QeaREoIWLvuO5rw
         dCu1zOf+VFsbFzKpfquvYHZ+UAsPP0b7MTfduoWk/wUbp90dDaYzA49RyZAt2AruRoMS
         /UO2S6fE79jFs0yzH3v2Z58JYkTh2nM8A8nOTvAsmI0Ooa0z43Emez263iq6lzuUIuxd
         g1t3XzBik/RJFgCtsYNLTJV4zznzmj85IXso09Xpc73J6HqAjmjwNMhlVobFWylAof+y
         F6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748759; x=1716353559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NN5bUoGVMW2u4IDIB4KeRdUT7NeTKlHAi/jP0KOF3p4=;
        b=SwT1RmaEzRZG8UMPTtXoLfgz1l4iZpb937rOCmNc/bRxz8PE6BwoO0+Qaitw8yQUWM
         ORSfNt1rbj+0a58KxJgAx7mnxF6e/WfO/6Qv3behAzVuGTlYO90hDs9+d+MODEVTM27Z
         W0fNBlOtlc94qJoFHm4y/LbUZtoRujiOgacj4WdKaJEP0vrLWw5gqcFeZlXNT7zUPPmk
         zZJPauvJrWSJ+KNLhAGvKQe0gzuRqi3Ug5iAOR2fAk1ru9o99WrxRzC+iDSdz1KQqtJ4
         Rz3/yFu3hgIr/85gQGz37nWV74dSFhVFFJtAoxPT/1xDpmyDObaqGXu3KEV7k3m3n2Qk
         AqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwnqLSsRVR88itsqgbY447z45jZExXtKWIYoAeyZs3OzwS3h50+6SkMNGF81OLvbee3vIlM4id/d3GvvHlrq6MVtqeoXiEh9GVMExx
X-Gm-Message-State: AOJu0YzVbqBJDvg/L18tTYKRiIM9RnXK63tlwTPP9LEa3dfmd94S3aBB
	ILm1luFlyrX0XGxK/Ea/e3q2fa2PlOUVjusfxkiMeo4myIl3rxMMzAqN/x45XcQ=
X-Google-Smtp-Source: AGHT+IGQ0jOhzWnhEJkBZ9+JsfxwNIe2kgVLLiItKS6Fiz/UcR/lnLFBX/tUVVgvDx6eW3f+QhA0fA==
X-Received: by 2002:a05:6a20:3d89:b0:1b0:c1:d8be with SMTP id adf61e73a8af0-1b000c1d9dbmr9274924637.1.1715748759310;
        Tue, 14 May 2024 21:52:39 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:38 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 07/31] Staging: rtl8192e: Rename variable MBssidMask
Date: Tue, 14 May 2024 21:52:04 -0700
Message-Id: <20240515045228.35928-8-tdavies@darkphysics.net>
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

Rename variable MBssidMask to mb_ssid_mask
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7f1c2f49227e..3722fc0cae1d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -915,7 +915,7 @@ struct rtllib_network {
 	bool	ccx_rm_enable;
 	u8	CcxRmState[2];
 	bool	bMBssidValid;
-	u8	MBssidMask;
+	u8	mb_ssid_mask;
 	u8	mb_ssid[ETH_ALEN];
 	bool	bWithCcxVerNum;
 	u8	bss_ccx_ver_number;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index c29efa3eef6f..19cb717df3bb 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1818,14 +1818,14 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 				network->ccx_rm_enable = true;
 			else
 				network->ccx_rm_enable = false;
-			network->MBssidMask = network->CcxRmState[1] & 0x07;
-			if (network->MBssidMask != 0) {
+			network->mb_ssid_mask = network->CcxRmState[1] & 0x07;
+			if (network->mb_ssid_mask != 0) {
 				network->bMBssidValid = true;
-				network->MBssidMask = 0xff <<
-						      (network->MBssidMask);
+				network->mb_ssid_mask = 0xff <<
+						      (network->mb_ssid_mask);
 				ether_addr_copy(network->mb_ssid,
 						network->bssid);
-				network->mb_ssid[5] &= network->MBssidMask;
+				network->mb_ssid[5] &= network->mb_ssid_mask;
 			} else {
 				network->bMBssidValid = false;
 			}
@@ -2349,7 +2349,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->ckip_supported = src->ckip_supported;
 	memcpy(dst->CcxRmState, src->CcxRmState, 2);
 	dst->ccx_rm_enable = src->ccx_rm_enable;
-	dst->MBssidMask = src->MBssidMask;
+	dst->mb_ssid_mask = src->mb_ssid_mask;
 	dst->bMBssidValid = src->bMBssidValid;
 	memcpy(dst->mb_ssid, src->mb_ssid, 6);
 	dst->bWithCcxVerNum = src->bWithCcxVerNum;
-- 
2.30.2


