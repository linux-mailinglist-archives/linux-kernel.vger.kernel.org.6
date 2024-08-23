Return-Path: <linux-kernel+bounces-298092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F99395C200
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D421F23CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBCF4411;
	Fri, 23 Aug 2024 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhprhftd"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED423AB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371765; cv=none; b=NkFIxQDhxfNkUePVv37Z90GRhsUCYFuGmCqGgmWe73SICwU4toUta3F5AGpoR+i4jjUnqAPduB1DiPaCR/nJ17UUEtv3V1paBllg4Cx4U3Y2G9kVRVAHBPRl2z3ds9BjrZpz1k++2Tzas33hTYv7zxpaQFAq4XjKoAfh96p/wtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371765; c=relaxed/simple;
	bh=hA27Acavu2EyyJ2z4AyZaycmGEzHi0d+myJUi+8/jEU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLurZbMGlGce0EqSxfKOIrCF2lKvLv24oC1NDmUb/JOm4vApixcws+Jotf9jFa5HQmQKnRBVvUKuMRYeCXsDxLt4eY5NDmezkNXyFWXoW5B7UisjU6nzXFxcFOqI+QYEnOW2+OEKRvjeTnSXxuFGasg03jIaojW4wr59t5lixGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jhprhftd; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-202508cb8ebso10348135ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724371763; x=1724976563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vvt0ex9BegEGtLMzUiCGOFHSA3hOaJJE3WEIXWRzp1k=;
        b=JhprhftdjJwqDDllQJJ7aLCSnPfmA/oZXXvAJ40W61tqfxY01cX/2rVBBFY65AVmXo
         c2+A0MJHLV6FTtEriHR2k5G03FV1B6ZQ7yNgLK6RzjD1JdAxCPhSsOMtE7klsFJ9Ld9L
         r7UX/rdREnDHJmyjtayqggsccOBmnigKWS5lM21nngSxg2xrIwjBY0+tbHK6D9swbHuv
         gvBI1ph91jukrrOEqmOYREf9D35piW7ZXDlFEFH8U1BXO+zcl9Q/KpYUMGfZiKKT+1LV
         deS9ZeLOkoGiHqwuiqDvFhr3SJ7kpsAB6mGsxNyL66OWR+haR9SRi1SjJ7aA6o8Ks04u
         AyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724371763; x=1724976563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vvt0ex9BegEGtLMzUiCGOFHSA3hOaJJE3WEIXWRzp1k=;
        b=A2Sk2/X+/82b+gGT9uFdbG2nvkLbq196QbWmYdAPJdPTPWb2cEQTVAerkcF70BwSoX
         wwb/LEIePsrtxflXyCV89e5m4DIk6IKEv7itppB5AIVE9pXYYwhtpW1D8nUhrEk71eF4
         9/J7VGS9rdN6SM2tg3ICuvV3FArQXznlgPug25fkhaZYxaAq6zXlVaflGMdh3rhV2ieQ
         yZnDUwDn01ThsdGtsKXYmIWgFI0kqQwDfvnsp8xU/80ytrPXBwBXhqAVAH9whzWURcFC
         WYZNzhykl0oG3sbtgX+JO/JCr1EA2LpShc5g+iW5GhEig98xqlF+nftxNuMutMlSirpg
         c4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/DprjAtZcvw7AwqobAmCe5Pm4iic6idVIZwrz8jYIYUJ9NKdnaAiV2PV29Tu/+uuiBxGlSZmq3IuUmMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLbKNCISzosNe5Nl1DlmGcW1M17P5WuChP4S3+PvFnCAtb4FzD
	MNEHr4X8H4IjJ3Lun08eG/n6Zjpn+pDJEwEcuJfftejRTc1FBKiy1Ju6xRf+
X-Google-Smtp-Source: AGHT+IFR3GD/p1xWhPkLV53qi9g6xLAFAvfUm95HTxI8mb9LaOVf9w8Eu+LR2bkAB8iJkium3I0K6w==
X-Received: by 2002:a17:902:8541:b0:1fd:aa8d:ace5 with SMTP id d9443c01a7336-2039e4d7dd2mr5450775ad.23.1724371762670;
        Thu, 22 Aug 2024 17:09:22 -0700 (PDT)
Received: from localhost.localdomain (dhcp11819.ime.unicamp.br. [143.106.118.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385608eb5sm17929185ad.188.2024.08.22.17.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 17:09:22 -0700 (PDT)
From: Gabriel Maciel Raad <ffunctor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v2 1/2] Staging: rtl8192e: Fix parenthesis alignment
Date: Thu, 22 Aug 2024 21:08:37 -0300
Message-ID: <20240823000838.8207-2-ffunctor@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823000838.8207-1-ffunctor@gmail.com>
References: <20240823000838.8207-1-ffunctor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix parenthesis alingment in rtl92e_leisure_ps_enter to silence the
following checkpatch.pl warning:

CHECK: Alignment should match open parenthesis

Signed-off-by: Gabriel Maciel Raad <ffunctor@gmail.com>
---
Changes in v2:
- Split the changes in two patches
---
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 5aac9110bff6..1f881c27d4b4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -204,7 +204,7 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 					&priv->rtllib->pwr_save_ctrl;
 
 	if (!((priv->rtllib->iw_mode == IW_MODE_INFRA) &&
-	    (priv->rtllib->link_state == MAC80211_LINKED)))
+	      (priv->rtllib->link_state == MAC80211_LINKED)))
 		return;
 
 	if (psc->bLeisurePs) {
-- 
2.46.0


