Return-Path: <linux-kernel+bounces-179428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B52868C5FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CA32856E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43203A1BC;
	Wed, 15 May 2024 04:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="eCp56DOR"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60895605C6
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748772; cv=none; b=VK52LOsJ/cBvGOv8GkTIvqRbaZdlgUh42sTY5wKlhtZ/y5fca5J3akI9LcNpYMuENKWg4SgfpgTK4dcAcYbu0lXNoFIFtFm4pLdeR7QF0g9DYo7Pu45iqCYR6Uh0/gl9paBKIjKCHy09EHXcxWPj7jTVizFnG8B0tlDou3vg1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748772; c=relaxed/simple;
	bh=GixOz/jvSyY1xGeu+wIuKGXcSU1AOkbQd0Sx22xBEsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iqEwOIwGMiYamYs1VwQ5q5DGjMdyiplZn5BT5ZArH+UjpEV2xIqvOg7z0SvFd1x9adr6W/HtvQ3FF/tCKJDxc4DSPCDltbcUE3sFGV2jy4BauhFkV3+myr644DWq+K92YNeEaihGpLZdqo76mTugzrONfyDJQLb0jWJ5xvnIA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=eCp56DOR; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9a39dc36bso2069731b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748770; x=1716353570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uDJtT8U3aIB/5/8PG05/CwnNng1VTLjEW2PdQdEd1g=;
        b=eCp56DORrdV2+hSy/VIXmerU8j0sfkTLhd50k2DEOTerUCbIriAZA87HecmHQRQAoQ
         +18bd7qhGSa8Qobt3UcuQ4Ubl59T2dT8Ri+YYfFNHXslQXgGKvJfY+aIyZy74hE5A7gE
         zML2smhM9TofT6EqIkEfHA/dyv9ofwBEEJOyjsoDdPMzusCsi1yfisehbjVT6DDMXUGM
         szSrO2/ygnpru9dpVXo9gt3p0fiOQhS4LifnQmi70d7Kxcz06U9iGCnsMuQYcydtP4vh
         fD0cb5Kt1pLeWXyqDJUy+mZiPcolE2aHS8j+ZgdB0E2gsFE3NIQWq9aPuFBx1NOoBSkp
         5rdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748770; x=1716353570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uDJtT8U3aIB/5/8PG05/CwnNng1VTLjEW2PdQdEd1g=;
        b=if0rxdy3TlJ3PfRRA+YYxhhcW+csx/zjRa2ZsetiOx6bkst1SWaECO31OJ3l++DG7y
         +un5GQVDMYJZ8Vb7HXtnqw2d82tr3/HjM7DknLp5X9Q5km5LiteypMNgMhCEaOpBZp9N
         AX/4jOTz3ZgTsNcLFT8CMhxFxWjDwKUbZFkevpTu9SNEL77eb9vRgfNVBnzaeswe2Tf2
         kpgpp1PrgkdomAfJqB/4WIu1IKXB25hhsBaoz6xbpD7sQwYklk8Lrjv4LCg74UFOyh3D
         e+dEsbcGN2kvmyW0HOzKr26buZ0HG+QLIWr4EyJ6TVU5liQ8EQtSgIWxko4Tapsh6HCE
         koIw==
X-Forwarded-Encrypted: i=1; AJvYcCWVV2FHz+R83d+3eIMaqovZo48fOsUFeSCRdIpj0eejFKvSr5XNKKqoxbqbVirnsQlMWsGvDcAntYvGM0m8RWmX3RwcxxcHL8VYSbJV
X-Gm-Message-State: AOJu0YyZ1jcXKcUOD1BXB9sFdJw8uUxI+iR5U4mXWTgb0WVrjySMAdtU
	ahYiLezr2664jECUbJeGhf+Z8x+4Zeenog7jFtWNyuChFvAkFcTdCyWPbco+TayNvu/asNTYxsN
	m
X-Google-Smtp-Source: AGHT+IGfgfDCeXzcG8iJkutFsBwkZ0a/02CQos8BCVqID1u3eOEBZBqu8PGwzUeaNpNc6ZT3IgA9ew==
X-Received: by 2002:aca:230d:0:b0:3c9:6ef4:346d with SMTP id 5614622812f47-3c9971d531emr16043643b6e.49.1715748770502;
        Tue, 14 May 2024 21:52:50 -0700 (PDT)
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
Subject: [PATCH 23/31] Staging: rtl8192e: Rename variable bMatchWinStart
Date: Tue, 14 May 2024 21:52:20 -0700
Message-Id: <20240515045228.35928-24-tdavies@darkphysics.net>
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

Rename variable bMatchWinStart to match_win_start
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index d4714e193df4..ffb1bbc01bc6 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -529,7 +529,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 	u8 win_size = ht_info->rx_reorder_win_size;
 	u16 win_end = 0;
 	u8 index = 0;
-	bool bMatchWinStart = false, bPktInBuf = false;
+	bool match_win_start = false, bPktInBuf = false;
 	unsigned long flags;
 
 	netdev_dbg(ieee->dev,
@@ -567,7 +567,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 	 */
 	if (SN_EQUAL(SeqNum, ts->rx_indicate_seq)) {
 		ts->rx_indicate_seq = (ts->rx_indicate_seq + 1) % 4096;
-		bMatchWinStart = true;
+		match_win_start = true;
 	} else if (SN_LESS(win_end, SeqNum)) {
 		if (SeqNum >= (win_size - 1))
 			ts->rx_indicate_seq = SeqNum + 1 - win_size;
@@ -589,7 +589,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 	 * 2. All packets with SeqNum larger than or equal to
 	 *	 WinStart => Buffer it.
 	 */
-	if (bMatchWinStart) {
+	if (match_win_start) {
 		/* Current packet is going to be indicated.*/
 		netdev_dbg(ieee->dev,
 			   "Packets indication! IndicateSeq: %d, NewSeq: %d\n",
-- 
2.30.2


