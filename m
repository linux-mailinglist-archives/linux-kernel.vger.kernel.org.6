Return-Path: <linux-kernel+bounces-244954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DED7392AC2F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9453D1F2224E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE5B1509B0;
	Mon,  8 Jul 2024 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="zucxvetN"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A906BA46
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720478494; cv=none; b=N57QLnR6UXb45cLbHg+ScbmT9cxPZkZ8GG2uZPLlXxc6wHab8qpUehAhAYMrBq4QP8hef1EFzEcKs3LkyfvzHWysHigKxYxDxTzOF+nIF2CufRgUCAod56sGc1BDC0eqngBwvXmzdaZi+4Tlj/IWGw4q9PHPJ80lARfjcnl6zcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720478494; c=relaxed/simple;
	bh=Y48N7OSR8DjmESgA+EvCyNmv9DMhakZODy7i5CnazZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nkEvrkA7WeKBsKEePPxcmyM2hdR88XORw9VXehLZ5m/YbjdF9zbxDOq2o97icayN5dWOcuAPsCzNUuHkMSGKaKS2zKn8ad6gSZszAdIS/Le0Oj7kelKqV2omeqr7Aes2PZHi9ReI/DEZWHXemEMwvsLBhywuv38Xn59wnZ+GFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=zucxvetN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77e392f59fso271842866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 15:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720478490; x=1721083290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ra3PVoB/sAGWIprQENyuLYZkFVofgKqgh3ZnQwvVZUM=;
        b=zucxvetNnQSmksHboGNLg962YDXmalRUjQtqpUGwJVzvRAC2pNNCXKgUHV7AExnU3C
         0IXpV4CdI2lOYECVDn1thm5Rauz1wMiQSckp699Hmhavnnp66l/J68ha5gGcWyiWrgel
         7JP02UYMGY/NhlIt3/Y0Robpa0D6U5tinB1UVjeWjKL2iY8nvX+8RbCSlEZD2fqTy0Tc
         03JKXW2wKHutUTv+AYQF6uAckiwPhpsd0/X3TFY3Je7PXXbStlBlKzWmOWlr5BtJyLQ4
         hz6r84yROxsS3beKExFvkKr5vnEowvnFAl8AlHz6O/AvWR2rcwl04DPjHFaJuJPauzR7
         cRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720478490; x=1721083290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ra3PVoB/sAGWIprQENyuLYZkFVofgKqgh3ZnQwvVZUM=;
        b=DrnH0bdZYrmbDbR4bKI+SMhF4xWZEoUro/LLLh342CB34NZ0MN/bWurNOf7lMJRGiV
         vCatFE34KWn6O1oGDDIzngaQ+7/cu3JOthzjXHd1BPq3rwMbPQbCRYvrSW3oaXRlxs4t
         rg7GYTbKqXHCrPZqwXUyrHZP70GIH3FBvf1ukqauMrfGWq63sYORyvxN0zLHajg3tgit
         hpCAOKf0Kvj5bebWqcGlXhxQu+MUGAJrHfwt1MDHKlw+pRi7oyjGt57jwR3KHraT0/1s
         JvXWWdEqVjGy+K7vocH609wqm07Hc3ebgsxtrP40Jab/2sd/RZAMN/JY5MgCDVIJP7ws
         ew5A==
X-Gm-Message-State: AOJu0Yw/pNJP2lkWeqmNafD9p0V7374KmrGM2oVwm/0bvIKoc2DqQyx6
	wSVRScmItC/GyxiaYAfTU3hGDGMN5uF6Y3OvvatnHUncT/LwwvB3zlUh1pVEbfjOniOWaJF6Ls8
	L090=
X-Google-Smtp-Source: AGHT+IG+bJE3TA+Y6D+VdZDcfGHGEbqWJrsgdl1fxxQhrJ23NMtx1TL58TCARkFpe6cdVrwzzZtQRA==
X-Received: by 2002:a17:907:3d88:b0:a77:ba92:b1d8 with SMTP id a640c23a62f3a-a780b512eb7mr68079466b.0.1720478489537;
        Mon, 08 Jul 2024 15:41:29 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-224.dynamic.mnet-online.de. [82.135.80.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc6a1sm27814566b.57.2024.07.08.15.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 15:41:29 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] lib/bch.c: Use swap() to improve code
Date: Tue,  9 Jul 2024 00:40:24 +0200
Message-ID: <20240708224023.9312-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the swap() macro to simplify the functions solve_linear_system()
and gf_poly_gcd() and improve their readability. Remove the local
variable tmp.

Fixes the following three Coccinelle/coccicheck warnings reported by
swap.cocci:

  WARNING opportunity for swap()
  WARNING opportunity for swap()
  WARNING opportunity for swap()

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 lib/bch.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/lib/bch.c b/lib/bch.c
index 5f71fd76eca8..1c0cb07cdfeb 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -479,11 +479,8 @@ static int solve_linear_system(struct bch_control *bch, unsigned int *rows,
 		/* find suitable row for elimination */
 		for (r = p; r < m; r++) {
 			if (rows[r] & mask) {
-				if (r != p) {
-					tmp = rows[r];
-					rows[r] = rows[p];
-					rows[p] = tmp;
-				}
+				if (r != p)
+					swap(rows[r], rows[p]);
 				rem = r+1;
 				break;
 			}
@@ -799,21 +796,14 @@ static void gf_poly_div(struct bch_control *bch, struct gf_poly *a,
 static struct gf_poly *gf_poly_gcd(struct bch_control *bch, struct gf_poly *a,
 				   struct gf_poly *b)
 {
-	struct gf_poly *tmp;
-
 	dbg("gcd(%s,%s)=", gf_poly_str(a), gf_poly_str(b));
 
-	if (a->deg < b->deg) {
-		tmp = b;
-		b = a;
-		a = tmp;
-	}
+	if (a->deg < b->deg)
+		swap(a, b);
 
 	while (b->deg > 0) {
 		gf_poly_mod(bch, a, b, NULL);
-		tmp = b;
-		b = a;
-		a = tmp;
+		swap(a, b);
 	}
 
 	dbg("%s\n", gf_poly_str(a));
-- 
2.45.2


