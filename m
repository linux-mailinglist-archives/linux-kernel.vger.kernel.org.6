Return-Path: <linux-kernel+bounces-184447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE94F8CA6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C7BB232B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0618423775;
	Tue, 21 May 2024 03:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="K2wDY6Q9"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D0757F3
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261462; cv=none; b=L0VRyC2A0WTs8hGeOYh77RlI5mbXyv67J1/F9qUTT2xlpFmn675P47NWzWUiYWvw1qSfECdh8m6nzJ7G4egHe/JAucCKT47k0HlyY13nwp3/crr/j7SVcTjtKrXPhDqCCS6kLHd/gycEI8BtLTqsy0G9UQkDcFgMTyl97/3ITx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261462; c=relaxed/simple;
	bh=BH5PhLOzGabd2LyORxMioicNxfmFgwW/JLD24nQfeWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LCZX3ZpQ498vJ5PJZTZ2mBG3+yIt/F6OXzLM8WLH3Fj1HTk0D/nxZiGaFhHzvV/I+Ewnr1kwbBoPEidv4UfsJ28T34KO3kjom5caEX7PF/ZXnGgInkJ5bZN6lTjOG+gl9+yI4aY8gNHEGjfZtt756BeBTStQ8rInCAAgMuEvnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=K2wDY6Q9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f2f566a7c7so64565815ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261459; x=1716866259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlLPLUi/5OI3lQ5UEAOn0I+EJPj8lQ3+XMJGXZAx7Bk=;
        b=K2wDY6Q9P0MzS92PHIHr6TwbRQ3eZWlzVVB1BUFbEgtB5nA2n+ZqyqDRFeZAtQpxcX
         aRMnmhSg5su5d75uy60gkGYrgKinzcLp6YD0/ZyNH/iUJSMwZnnrQ8BsCuBOdf/gYAr9
         gHQ451I184x5pNvfHizGBCNPuBNyt7G9wH5ligfH3jHZgy6zw/Za14RIOI2B12SloBg5
         MbstKahx00gsZ7FlQSm/MkB0Qh7+L1b7n5ego+1OMNcJu4T7Uz1VnBeW3zSk9kqjo9M8
         cJHn04kycIdl0pfqBfWH1rm3QNXM/bJM9l319sNqYOxR4lvN8pcx7c+SCJL8aMuPUBST
         bi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261459; x=1716866259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlLPLUi/5OI3lQ5UEAOn0I+EJPj8lQ3+XMJGXZAx7Bk=;
        b=jw6Cuayq35p/VLE+Er4TyWifPWCUn0QEOkZM24EWzCYN6aDgjJ2rxlq0bIiJULvLmq
         idl0M6sZ6YTT6AWUsD/5zP6p9jDBQucbWt1csq6n/4MyMO2GCBYXIKwf2wb2mhob6uHc
         8pbqrBwGszC/kdp26jNreomq1xHG/60rALh1LmpfXqbkvHm1t8w7dAFrk/XzqhRClmzn
         FEqv2ibOP1h2HMprm6sOixBub+nElsvIZyR+ia0V0woOu830iQV/xnYO0oBHzr/OcNTs
         v0b1RSdFaytrAiHm3wyjh2Vubi+lY7qcVP+DXMhFpW2fuQi9vee89CtZf7vvxyZn2cg9
         mcwg==
X-Forwarded-Encrypted: i=1; AJvYcCXkmr9GmqvltB2DkbQtqMyHls2pgbJEZFgzbG4jgE5HzM+tSjQ2GXnWA4BuJdgx7ZtQxLvLAkWi9ueum2fOPS7z0g7TXXHak8yt67w/
X-Gm-Message-State: AOJu0YzDh5wdfpULm9+2ONY9tPllFYIZU66z+u9bXPErhLJ08ksBYCBQ
	3q4+k/HkYhwHsLSNCz1k7B+c+4olrt8qKHpcAwfRNIIwaQCYW4C9/qZugVqo3Qc=
X-Google-Smtp-Source: AGHT+IHUOS9oJ3E6Jg97TDaSZcbDD/AcLxwy5/zgEhM+cTaRxpX3PTrAhC1Svqtwfb7MaS7uMDKFvg==
X-Received: by 2002:a17:903:184:b0:1f3:704:8304 with SMTP id d9443c01a7336-1f307048b69mr32619435ad.9.1716261459338;
        Mon, 20 May 2024 20:17:39 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:39 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 23/31] Staging: rtl8192e: Rename variable bMatchWinStart
Date: Mon, 20 May 2024 20:17:10 -0700
Message-Id: <20240521031718.17852-24-tdavies@darkphysics.net>
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

Rename variable bMatchWinStart to match_win_start
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib_rx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 9741d351363e..7e41519d997a 100644
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


