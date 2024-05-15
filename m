Return-Path: <linux-kernel+bounces-179413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07D48C5FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE791F231C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36F544C71;
	Wed, 15 May 2024 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="DfF5Z0Wb"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB283D3BF
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748762; cv=none; b=FtXsbAvCFllV73Cb3wK1OUZjT/eZ3Tb4uc+/dLDBB4V+8p+hV7+a/xu5V8LmDVYrm/UhPJF8zbSm8jCsogiuMiJa40iauaWZlpYY0Enr3B3EzWhEuiq3Xar029a5iO+kgtn/Nah0uV6dkmNjEkanB1ouKmKPpkZuSO1ttcsGBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748762; c=relaxed/simple;
	bh=IiCfIcPfdct1tRc1QEwBDItQrFk8/iTPGsEHpxX+aug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+OvMsyawPzg7z/MAuY90dXjdcs78RxvKDM1YFCRCoQF5GviwZtb/jhg1NTI7603LA9Q92Akjtmas6NA6pk8CGaa6bpJ4xzDDWoJudiEeGAz1kdfAHrnSdZGtojkeF178STuzIDmDaLqsG5QmK/UaK8dAmwOr/wr2l+D4gbJ9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=DfF5Z0Wb; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c9b94951d5so589738b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748760; x=1716353560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3J9d19BBdCUNbsHdCNFFy7/2dgsskyle09cVkBE7Rg=;
        b=DfF5Z0Wb1tliOM2kbzfIXu2IRElYhv/eiK11csoSTmCp07oNd6BUSA5et8sdyu6hp/
         03mgLSA9YsigpRG1Xr33+8owUFHZsGzPeV5a6vo0LBDOa8QAkIt1ABMHPtam/bKSLTJa
         FoEkRpDueKbfiXUVP9wJwDfn/NF+/JZ/JlpXUmCBL/9Ln0eEpvzWiHmFvJw0QryQ4l4a
         edxWmbUmX/8adixplFPxpLrw/u3SljDYi6dTfROK0ZlOSQDed3AMEw/HFmhGHt8BXzLr
         jN2QuHGifJpgal17mRwAbRvY9/DKxrpVM7hUb1XkYcjIBkd5nYTEdsIq68d5qbWKpBKE
         XAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748760; x=1716353560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3J9d19BBdCUNbsHdCNFFy7/2dgsskyle09cVkBE7Rg=;
        b=DzbzzGvw3tL10bDRDmaBJX9yF6n3hE7de7x90aJ65TDfWuPD+II3f5KqTXLPyL8sbF
         mL0DNpvekVUCm6oARi6wsVpHGxoMDWvVWsVdpnjPkiT64q0psjxeendO7p4tYVhZoLIL
         DTNpBZ6N9ZAIOo5ruJIoyJURM9h125lTTfiPYzYismqW2fWBu4oAPqNybvCIovU9J03j
         ztbe1P7DkUWK8GoiqduEjhnRnS5qih6J7259TV0ojhZJ7iO+Q4U9OVRQTySfEP5iAFWs
         +r810RDMfbL0LD485UMW/wb90kNb5va9da40lptRGImSkQrKae3OcTayZQSL7SOW3kH6
         MfEg==
X-Forwarded-Encrypted: i=1; AJvYcCWDxjxDidofAT+UXGEJN/0qWGJMGODjYcpmVozHaeJuVdA+8H+60f1bWlrZ/rxehg294C8D3gI0Z/b1pgVO0CtAmR9YL3IeJXwabiXj
X-Gm-Message-State: AOJu0YyElC5JTGXH9y1s5EYTEh7FqlSKJiPNmYxOIC7tyo3AteORVcOx
	VbuUsDATihaZJQ6k4xg14xkF15YdzoCVDQRZ4cy3SXKzWQzf+hiGrQKYWCgIfne3dx1/KPjaPcX
	n
X-Google-Smtp-Source: AGHT+IHA8WlMRLFaio5MReMR2UzSmY2IeFqtsVVmmSP4eZkT7ywqMi0MQpyya3/ZXC/g7YVyl/2hQA==
X-Received: by 2002:a54:4484:0:b0:3c8:2c20:718c with SMTP id 5614622812f47-3c99702a852mr14038489b6e.2.1715748760241;
        Tue, 14 May 2024 21:52:40 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:39 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 08/31] Staging: rtl8192e: Rename variable elementID
Date: Tue, 14 May 2024 21:52:05 -0700
Message-Id: <20240515045228.35928-9-tdavies@darkphysics.net>
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

Rename variable elementID to element_id
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 3722fc0cae1d..4645fe803a15 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -728,7 +728,7 @@ union frameqos {
 #define QOS_VERSION_1		   1
 
 struct rtllib_qos_information_element {
-	u8 elementID;
+	u8 element_id;
 	u8 length;
 	u8 qui[QOS_OUI_LEN];
 	u8 qui_type;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 19cb717df3bb..76389aef53ee 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1456,7 +1456,7 @@ static u8 qos_oui[QOS_OUI_LEN] = { 0x00, 0x50, 0xF2 };
 static int rtllib_verify_qos_info(struct rtllib_qos_information_element
 				     *info_element, int sub_type)
 {
-	if (info_element->elementID != QOS_ELEMENT_ID)
+	if (info_element->element_id != QOS_ELEMENT_ID)
 		return -1;
 	if (info_element->qui_subtype != sub_type)
 		return -1;
-- 
2.30.2


