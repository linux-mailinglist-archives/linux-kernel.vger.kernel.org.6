Return-Path: <linux-kernel+bounces-184442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EC48CA6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21DA1C203D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447D27352F;
	Tue, 21 May 2024 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="g4nHzN4+"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407C65E20
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261457; cv=none; b=Adc7bXi2sgsY9pJ9oPcb6QIJ781VKcJaE/OXRuq+Ugk4lBAcPfRTSU8BLNHNvUVfkP6a2Czx8OFsBE188tfBDLlroCyV0iIc6hcDmBhyKPOWHMO3hQXw/L4L4SCme8n9Lsewfs2qamDvQLy/6qWzXOwG6cFlwczi2M2nSILX55Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261457; c=relaxed/simple;
	bh=iv5vtIT0B8sEKOqWsGuNVC0aO5c9WspHnf3XLIvStwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ASsxVx/fo4aN9KuRggmcr31SkZwe75yC/7cak1ZZb55aRqX0KCCsMpWBNC5cPvflzwBTmrLytPxAzELR85CDTvvv6QaPouQNjK1tnTqv705raHtyYB/Jds0H/9cqRYEt2+zACamFDwezvzLxr+8Euopn2AGcfIQ0jti6/TewDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=g4nHzN4+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f3105f3597so1965305ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261454; x=1716866254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnnNiGWOZDyrhURhTHUizVWuJYzYU9zmKFPIjPvFtcQ=;
        b=g4nHzN4+uKrN7HWhwpAI7oVY4iOzkgPcpReuK1rMgWc66FbJXCb/5p4d2d4hyCdyBB
         5+XCsuI1DbS6wHcoRzooKFw1/5cu8oChoxtUQVkfls02WG5Pz1kH5hl46w0KYanvgFSP
         Q5t/qfW5CzhyFJDEMYXXAh42dEACLtR2p+mg8AV3TOssyzc/L67uoXMj+rDkW779CaF0
         olfHexEAksgux1SrqsUl4AsoG3vLg3Ip1G2GlTJo5a57+srRrzZkYZpyA+qtLB99RODV
         nBTPQti4IiWR2TDr7owLOLgmYPafp9V9b7HhKw+j+O+qVmVxHSs5mR8SYO3NthKr0pvq
         OomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261454; x=1716866254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnnNiGWOZDyrhURhTHUizVWuJYzYU9zmKFPIjPvFtcQ=;
        b=NQgBtVXz3z+Qm/RH6aDim/7MDHQl9DYfYi4SO76lg7ngj2lZwTNYGKZJCKDuftpV+6
         LY4wBrEoWTCDoG3PUQ7ZT6/eIgOTzfQILzxIzYNTS0i0qPWTmVX2krp/PkcDPEOPpb/v
         shZZjo1E+tSLZqBst688DCtwB5jyMhdk8MtlKCDUyCRFjpyMCK7g3QLkDaMYMj2kU222
         dKncQ2+rSZRMaGfHDCptBvRhCz0RdpreegspGub4iJPK4/XuHUczq8eDKI6+c6MxvVn8
         wa1gC7gMjgwD4aDiuCLEHYq/5cj3pXNsJSff6+/qidrTb221gt80LZJSgwTba2h/eCAA
         IIZA==
X-Forwarded-Encrypted: i=1; AJvYcCVeGqOM/38cWOXvcXPzeTfXnFDprpFwyyyD6YVZPm9WWCKBObsZMUT9xKb7Vkcwd+I/enPfgZSgr6uvMtYZjI4gai9NzQNKT7lfeVVK
X-Gm-Message-State: AOJu0YwAmv2DqgPQk8oJdygBpya+V9IdPuJ1lpaDogNeyK8gYm4DW2VZ
	4Q6POFw0RvUeJ5uPfqxKJcgmBAwEc62/QcwLiUQyyXPqU9uFTmeW5I26KWtN0fo=
X-Google-Smtp-Source: AGHT+IFNOmj7w6LmZdeRnpTuqNZeDgFn5eoz7xWciHwLByvAWVY21M/4Ib9p5iHD9xbeAMtT/1Mk+w==
X-Received: by 2002:a17:902:8308:b0:1eb:3d68:fc2d with SMTP id d9443c01a7336-1ef43e25fabmr305373295ad.34.1716261454070;
        Mon, 20 May 2024 20:17:34 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:33 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 16/31] Staging: rtl8192e: Rename variable pList
Date: Mon, 20 May 2024 20:17:03 -0700
Message-Id: <20240521031718.17852-17-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240521031718.17852-1-tdavies@darkphysics.net>
References: <20240521031718.17852-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable pList to list
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Rename plist to list
 drivers/staging/rtl8192e/rtllib_rx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 30bd6f49e915..b1cb73c2177d 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -406,24 +406,24 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
 static bool add_reorder_entry(struct rx_ts_record *ts,
 			    struct rx_reorder_entry *pReorderEntry)
 {
-	struct list_head *pList = &ts->rx_pending_pkt_list;
+	struct list_head *list = &ts->rx_pending_pkt_list;
 
-	while (pList->next != &ts->rx_pending_pkt_list) {
+	while (list->next != &ts->rx_pending_pkt_list) {
 		if (SN_LESS(pReorderEntry->SeqNum, ((struct rx_reorder_entry *)
-		    list_entry(pList->next, struct rx_reorder_entry,
+		    list_entry(list->next, struct rx_reorder_entry,
 		    list))->SeqNum))
-			pList = pList->next;
+			list = list->next;
 		else if (SN_EQUAL(pReorderEntry->SeqNum,
-			((struct rx_reorder_entry *)list_entry(pList->next,
+			((struct rx_reorder_entry *)list_entry(list->next,
 			struct rx_reorder_entry, list))->SeqNum))
 			return false;
 		else
 			break;
 	}
-	pReorderEntry->list.next = pList->next;
+	pReorderEntry->list.next = list->next;
 	pReorderEntry->list.next->prev = &pReorderEntry->list;
-	pReorderEntry->list.prev = pList;
-	pList->next = &pReorderEntry->list;
+	pReorderEntry->list.prev = list;
+	list->next = &pReorderEntry->list;
 
 	return true;
 }
-- 
2.30.2


