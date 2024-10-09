Return-Path: <linux-kernel+bounces-356111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D585995C90
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1531C20C72
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27320126C17;
	Wed,  9 Oct 2024 00:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="B/iFlElN"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9ED29429
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435374; cv=none; b=TVpc2J07YdVkHM/044K3iZvCnHEOiVnO5SNLTIfCq3dhGhS1/wSF+cnWOeNGwu4O7A9PjeCNYZgAVhn3jK0ohr7JB7PeJRgbXbwj4bVs4QwZwRBIx/keZPHoOwaXTwhyhkiwsJXYH4PqP2cEogwQGYNPUYJ2g32Rtk0QppX9JbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435374; c=relaxed/simple;
	bh=DHbZfeA6zp3c1SN+4z3kVAiT7+/abWBwPzDqDLUbUl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jZ9d93FE9jO+f8VFTmVb8WJPtkBOFpPXd2zUgoBs/K0vEkIx7l7OINLFsZKeJV10OsniRNJA6YVvp+sLk3kPHS5TWxT4fEKjnpP7jJs/WlqPvmA6rcrtPFzEXdqAvjGUzrwyABn5+u9LbcbjS1zwAzXQ893RSazjCB9zkxvibLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=B/iFlElN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b1335e4e4so61774935ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 17:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728435373; x=1729040173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJVHwUgMs+rfxIOK3S7MBwjWGHZYDl++VcT9JOMBFYY=;
        b=B/iFlElNjQqlitvIAzQdGEII/NxNoQTxFDK8+tRzr/cL5p6C7zXg1vCB4XU/95RUXw
         G5BBaeNAP5wa8SlZgXYCgmRRvXlSbqiR7+qydpO58PSifQaCrl257q2VyRSoUxQS68/b
         hNtvOI+KIxeTjvC+yAKP4+pmmsP9hAc1c78cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435373; x=1729040173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJVHwUgMs+rfxIOK3S7MBwjWGHZYDl++VcT9JOMBFYY=;
        b=JZBMzcDiGDjmwJSpTSQtuBS5JFj6bbxg8VRa/xPA92ieZfgNsohVJNL8+mg/8YwTfF
         G/phPr/q2r/meMXXDQfJznl0oug34woYhNrhYKYzy6iAG5t1D9FcypjYVpRIpFE90PCz
         GYJ/yjbBmeresTKoPmaNSnBEg58JtCVrU+ief/gA9oPTfjsFeoN8WwtCO8s+MX9CzYNL
         aa/d7cxTV4VUClVrglHCd/I1PFsLwldxceCPnaGIv8hhJ0nIPh2ZhYwDf9FYqLA30NYY
         k0yp8H0Lx4XA2lS63McGIHBLM2Q9eR5z3/mzb3NUjF2z/ziwPPwT9SIceqb5OwlD7THh
         ZBGA==
X-Forwarded-Encrypted: i=1; AJvYcCVkg8h9BDK5MF7geLlfS7jf7+FDHXtg9sIIGpt/hizOiRCQsawXRH+/jyLDj3gDUTZFFfwWVlyQbyLuhss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLTIGk94dq2s218K0D5ASGAcANmCP+EoWBTXqfw9m0J68fbAQ
	zorprfoDWw+wn4cav4Dbr2rk/E3e+F7J4nzEIJiSFILbWUrlP6jKgR43YYeS6bA=
X-Google-Smtp-Source: AGHT+IE+Jy6YzaCczW12PcHPToB8Qp5/Tm1AJJplbGlk9QLna4eYrt4cJ6UOiJ/ettHxwkoxAnC7Gw==
X-Received: by 2002:a17:902:e802:b0:20b:8924:3a89 with SMTP id d9443c01a7336-20c6375b2b8mr14141655ad.12.1728435372708;
        Tue, 08 Oct 2024 17:56:12 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cec92sm60996045ad.101.2024.10.08.17.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:56:12 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v5 7/9] bnxt: Add support for persistent NAPI config
Date: Wed,  9 Oct 2024 00:55:01 +0000
Message-Id: <20241009005525.13651-8-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009005525.13651-1-jdamato@fastly.com>
References: <20241009005525.13651-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_config to assign persistent per-NAPI config when
initializing NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..f5da2dace982 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10986,7 +10986,8 @@ static void bnxt_init_napi(struct bnxt *bp)
 		cp_nr_rings--;
 	for (i = 0; i < cp_nr_rings; i++) {
 		bnapi = bp->bnapi[i];
-		netif_napi_add(bp->dev, &bnapi->napi, poll_fn);
+		netif_napi_add_config(bp->dev, &bnapi->napi, poll_fn,
+				      bnapi->index);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bnapi = bp->bnapi[cp_nr_rings];
-- 
2.34.1


