Return-Path: <linux-kernel+bounces-179417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA6C8C5FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDCA1C22229
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418CB4EB3D;
	Wed, 15 May 2024 04:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="bBPoCQrC"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469B4594C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748765; cv=none; b=bqqLW6NJl77I3P8dwr+r7sDpgQSmfYfwLxBXVSKGDD/agDlzZ+WZpxgwEauwIN82cQklVekZDf9NXMqrZg5FVH3qiWjJ58cs5G+Zzhak69dL1X96eS5I9SVasNCxSOz+MOLn7q6KV/Ow2+YVDt6Nfn6VfYf74MgGGNGKFWOtuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748765; c=relaxed/simple;
	bh=DmObfZNzwdYgt04bsxgzsoK/GbrzelmZCNjUcQcSOcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YvRjYySMHA7q3gt9mHV3UsA7hIn31ofg7XGe/FgJMO66kVXaJPwK5RrmCN3ds777gQDtFIl9GZr1YIh8flUQU49/mopdtQo2R4JnOdoJn5MpliVBm420Oyd8XdsG5PuOuT/lg543WZKNfQOUYC1Ptz80JN9YL3aNIrtGyiNYelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=bBPoCQrC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f4603237e0so4475936b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748763; x=1716353563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cyl0QsC5Ap3g+wagqtAYIpo5rRqxsaw1p1+//Gi2eH8=;
        b=bBPoCQrCmntVKkpjsaaYeAmNKK/MnX0y8hxFPYP/loEd/KFlzuQAv+ZX1TzLaecygB
         A7ZMt9SvKDySR6cd2ES4rjABr6EwMrIXAOH5lUG4JVPuBWFoYagDGONwp3laUib9SY0i
         9LsB/+YEIvoHU8TedaH9yJQN7xSEGxoRuSv5pVt85+jriRc7WAnJR3iRiZHrpCRb6MQq
         FzDavuJQahk18ZX6ktQr6rZZFSJHKlEOUhbbc7HMJecE2iTYOCHZkhVOcHvRunwfrVFn
         iMoTLctiDBZ3hAGoo9GtJP60d8AmDh5WHTvbGQ9yaLiyWrp3Tf2d938Y8WbWq1mYX8ub
         IAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748763; x=1716353563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cyl0QsC5Ap3g+wagqtAYIpo5rRqxsaw1p1+//Gi2eH8=;
        b=BpkV2o9mBWJw43HFR+ZlG7stVEsX7U48O21ZcloR9Y4U4CPK97sGOkkVOd8KpLuVLE
         0R59+HPmxo0qpcabcVJ87tMuSevvN3NcZKIj87nntTKyQ7ioah0DZcGC8lKtvCBpLEMK
         u733lfSnTFYqlx0UdHyjBanwMf7Yb4xPZZh0EsptonZBImZyQiLw5yAN2M2+a081nWS3
         VjFHmxaUS//JEvzPjgoValhJO5r4qDAJ12YdsrFGpNqsZwz9DFTMN7nyJxaxFccWkp2S
         T/IuK3eFBER6X0lMLaoTMbjwzqOGYdI996UJVy11NhnTGEbTWCJwTJ2e2RpbeRUgH7nJ
         RlCg==
X-Forwarded-Encrypted: i=1; AJvYcCX5aok6fmv9LDXmdNjXNdoP2Y7fhmasvcfFFp4zdnYN63lEPdfS4WGoBJxkZzoScyGx70DX9zkJdqr/kabMrTsgPaCLsroGMeDlMXFC
X-Gm-Message-State: AOJu0YxGFn8Pma5M2pM5pgf5HPl59TQZViyBUravoG+2KMXDB3GqZDP6
	CGzAgMGOhFRDh247q+HqtmeZ545b/rdn/4Cdg1DbrbC8hshk0FzQvZLeDO1LROY=
X-Google-Smtp-Source: AGHT+IEsbfwWMrJu0U0a4gTnEe47UNpTiErx0Pirv7+nv+dGZhrMoATrgi71M6lulaQqn9azCX2O2A==
X-Received: by 2002:a05:6a00:9288:b0:6f4:b54b:e4fe with SMTP id d2e1a72fcca58-6f4c908aee4mr28858539b3a.2.1715748763181;
        Tue, 14 May 2024 21:52:43 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:42 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 12/31] Staging: rtl8192e: Rename variable RxReorderIndicatePacket
Date: Tue, 14 May 2024 21:52:09 -0700
Message-Id: <20240515045228.35928-13-tdavies@darkphysics.net>
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

Rename variable RxReorderIndicatePacket to
rx_reorder_indicate_packet to fix checkpatch warning
Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 24136bba64b6..a30945f30e14 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -520,7 +520,7 @@ void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
 	ts->rx_indicate_seq = 0xffff;
 }
 
-static void RxReorderIndicatePacket(struct rtllib_device *ieee,
+static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 				    struct rtllib_rxb *prxb,
 				    struct rx_ts_record *ts, u16 SeqNum)
 {
@@ -1366,7 +1366,7 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buff *skb
 	if (!ieee->ht_info->cur_rx_reorder_enable || !ts)
 		rtllib_rx_indicate_pkt_legacy(ieee, rx_stats, rxb, dst, src);
 	else
-		RxReorderIndicatePacket(ieee, rxb, ts, SeqNum);
+		rx_reorder_indicate_packet(ieee, rxb, ts, SeqNum);
 
 	dev_kfree_skb(skb);
 
-- 
2.30.2


