Return-Path: <linux-kernel+bounces-326319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E44897667C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CF61F22A89
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56DC1A3A99;
	Thu, 12 Sep 2024 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xNsm4s59"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEA61A0716
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135716; cv=none; b=STN+9FOG4limIF/It6LyY0DPBbEe6tEhTdatiyYCWc5sKx9qbPTxIqD27zdHHr1lSiGvE6L2UQBbvVI6SVD75uwOa9YoXzcey+9sJaxolkf18sCv70YDmvqVBGVrzBl61bDaREPgjARYx2DwiO5FubGbJrTTg1C1py8x/BwdUGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135716; c=relaxed/simple;
	bh=5OCb+7uKyLbZrs1Mj/coxUQ/9iBoUAlSrVa6LuBsIZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYXLal3A6ClQWX55UermKh4MwMhFw3J5URSYtlRv/pPusc5KcXSdPBHgDN+L/4o5LdTvBntlmzYCsrpk1wpf8zNkqM2hGbM5sZSP5uGTPSt2HMHben5FFG1G7MYOWGBTlJrFFx2yia+I5naqrgm8m/8wNSqHTh9UPXUWH2xfqH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xNsm4s59; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2053a0bd0a6so8462525ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726135715; x=1726740515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vZGBy03W9oJlJ/9i6GWdkzO4slhCr2TSdIbx3y7tGw=;
        b=xNsm4s5992Mg0YPU/I3voTMDELYF9IitwiYLBnMLFUfGYUNvbCT27GE+6oH0lsA6of
         4SV58yYVZ92XxAyu10iv/ahaWlJwkjoj1Sb0G+nLFs3slnA1YG/2izfsqcTD++W7lGVB
         bLf9mfjWljRkv46sCaMZU8jq3IWMbl0aZRM6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135715; x=1726740515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vZGBy03W9oJlJ/9i6GWdkzO4slhCr2TSdIbx3y7tGw=;
        b=AqLw9bBY1sqQIku9VUDRUiZVx+YRHC7jK9Hf5muUE0S/dKXtOlC3HHXYABMQhA2H2K
         o/z92huEeDogqDwJP1ygh02B8WEbcrWl+eqifawOCjCJeT8UTuQfqdElxZk/eec3wvev
         YbIzfQrvBh85qHyzTdUJBwNaJaBjon2buIMOZ9ydqWI64Di49aRVnIUvJugQT3mH2uCs
         gfcaOw9/D7wWqG0QA+fRTpHtsTgr+cr1NVUQuJHU0Oy9ssFZ55F1BAdX/3Cu0vwtyWnM
         lmgqWRWmTYCIDb9mqKjEn1gXS5Fe5aJbHoiNaUMuQJMWcxuz7Zs9RqPPaQQ9F7azIbuo
         qNmA==
X-Forwarded-Encrypted: i=1; AJvYcCWHVYmHLAVKbj0FEnYcFNF37IN+pVuTpA5NYvXmA8AVVwI4gFIMZWc6W5C6LECNkJmZIRzOMaijn/qfcaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqUmmvVtt9+9aKPG/EZywaVVu7+w91lRZSsZfux84BG61ZFFMB
	JY/i2dpMNF93/V19BiGOSy93gb3el514o9ps0dfiArCqHrzeij3wHBNBCOo1OV0=
X-Google-Smtp-Source: AGHT+IGLql27bdRi5FlHr3ibf1RMiPqxAUiDsI9pQMEbvnCn7/LufTMCuEPbZL7jU6f3P6G3MlmXDw==
X-Received: by 2002:a17:902:f684:b0:207:1828:82fd with SMTP id d9443c01a7336-2076e37abf5mr30678565ad.28.1726135714688;
        Thu, 12 Sep 2024 03:08:34 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9da3sm11583795ad.239.2024.09.12.03.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:08:34 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 7/9] bnxt: Add support for napi storage
Date: Thu, 12 Sep 2024 10:07:15 +0000
Message-Id: <20240912100738.16567-8-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912100738.16567-1-jdamato@fastly.com>
References: <20240912100738.16567-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_storage to assign per-NAPI storage when initializing
NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..44fc38efff33 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10986,7 +10986,8 @@ static void bnxt_init_napi(struct bnxt *bp)
 		cp_nr_rings--;
 	for (i = 0; i < cp_nr_rings; i++) {
 		bnapi = bp->bnapi[i];
-		netif_napi_add(bp->dev, &bnapi->napi, poll_fn);
+		netif_napi_add_storage(bp->dev, &bnapi->napi, poll_fn,
+				       bnapi->index);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bnapi = bp->bnapi[cp_nr_rings];
-- 
2.25.1


