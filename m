Return-Path: <linux-kernel+bounces-210881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17D890499B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E63C286885
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213FB82D8E;
	Wed, 12 Jun 2024 03:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Cgq47L+r"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65FA82C76
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162574; cv=none; b=hkqbjLhLk/BSGrWK9EPh5Dm+gbO0KY2TiLhxr4/OtPLIBt8LXxs9CY/4nqigPWB3E6SaNrnf9OrLIBfPDUlTx0ONM7WmvxMb0UXaoAPKgItJioRLvGIbYHWX6bDxCwTkXliDVWPQGPEclR8EvPTmJLclxsBaclLEWBypckq87c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162574; c=relaxed/simple;
	bh=a0AR5YGMHIOP52fU6nssMemSeg/SfHbIA2c8V//RH98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIBKrzofjuKUpWXceL7dKaTVLZGZhz/ZyI76/JUBvC1BwzAhrMAYCBQY1NqI+KwIStPlNzcxuyeyw0pLTcTxh3EOZyk+O/FOMNlnKVVfdmdTeDaIPWcw4re/w8mH14B+fhoDUa9VlHeWcIXvOBuzjf6mB86XDuj+Swo6ntuPgyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Cgq47L+r; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-254c56efe06so1416897fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162572; x=1718767372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbK3BP5tI5o4/49SrdtlAw9SnoV1ioIONkhc+yAhOBo=;
        b=Cgq47L+r0SrwzxrDGuaHBdUzsXlfKMulF+dBkRvibVpTumI0iUrI3BG9Piv+OGI5Ou
         IFiq0SkWSMA0K/TqIWBhOO7wgKpZHPN5HVG3QoJuuOaiWI+6/DNR4D2Z7+OJT7oUzTIA
         j5K2eEyZ5EVXIhYopzKMOVSzjnzvInXlDGBR9RbTBBKs8FBLRNk1xM13dQnX+/4j4Yo9
         nZjXF+bNK8sdC8dI3TjlMM2cz9YbrEUfsEYwesUbyh7FANiebEEUzi/Tr0It0h/01/I6
         HtpgMonNnCZqIbCvNKD9LeKNRe5PwHQalj2Sgj94Muq5WwSo2sMfFz6KgAZiZgR/QbNP
         PnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162572; x=1718767372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbK3BP5tI5o4/49SrdtlAw9SnoV1ioIONkhc+yAhOBo=;
        b=BxzT19d78fiCoeoBs7KzcMMB4zABgsmP0G6vVbCdcAYqVit6nLFGOA2Zr1vwsnp2N7
         wyYMnyIJfaW3WQXWk5Ncv1nXbOcOtRecSmbsSisoACeJ2nuE6hhDRsgIFbitf2awo53m
         lBvwrzxGvQcf1YUH/4zyJBhl96opNTDGC4shSt6IpiGd8qOdpUQ143ZcfrqRfS8tyOCk
         4CiFDld9hMzP0kQG4SUAtRRCARi94e6dYYHIySP1Fey1s9C34/oMfHH9exBKCs9YK17v
         S0S71ItCdfohWEkgZxxyp3X9kKL7jQ8csRMHnPJv3+hck3qU2oFe7Y6PXIfECET5QlpG
         40CA==
X-Forwarded-Encrypted: i=1; AJvYcCUD2c1/T7NMILHvkO2eW97lE75MLQt6JoUXtg3BX1ZnM3P2vm6RNOenMXntYVBKNnevvLnTvlOpEvwOZKY2Dz20fC37wEgrVvyflODR
X-Gm-Message-State: AOJu0Yx2eywr4+zDavMBxvZ4bIKjZEZNHOUWQNflQhkYwCt1h2sbU4Z5
	XGznsbT2xSgGTGycnIypPB9QLX76gGW9W3wj+adsnMCWlOI1EoaQPydhc0Lcw8FPRzwAqbKIKzg
	WFVw=
X-Google-Smtp-Source: AGHT+IGS438Lm1LZwydy3UhOIIMDpANz2Yfv5F5W81izEj3Zx99F0lRsPMzouhO+ihHx5LfZroGGdg==
X-Received: by 2002:a05:6870:7248:b0:254:930c:fa08 with SMTP id 586e51a60fabf-25514c03a65mr735213fac.12.1718162571800;
        Tue, 11 Jun 2024 20:22:51 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:51 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 22/24] Staging: rtl8192e: Remove variable IsAmsdu from rtllib_xmit_inter()
Date: Tue, 11 Jun 2024 20:22:28 -0700
Message-Id: <20240612032230.9738-23-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240612032230.9738-1-tdavies@darkphysics.net>
References: <20240612032230.9738-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove boolean variable, IsAmsdu, and code which does not
execute because it is never set to true.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Update subject prefix with 'Staging: rtl8192e:'
 drivers/staging/rtl8192e/rtllib_tx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 9a9bd8450354..2f5005689a36 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -539,7 +539,6 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 	struct lib80211_crypt_data *crypt = NULL;
 	struct cb_desc *tcb_desc;
 	u8 is_multicast = false;
-	u8 IsAmsdu = false;
 	bool	bdhcp = false;
 
 	spin_lock_irqsave(&ieee->lock, flags);
@@ -648,11 +647,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		ether_addr_copy(header.addr1,
 				ieee->current_network.bssid);
 		ether_addr_copy(header.addr2, src);
-		if (IsAmsdu)
-			ether_addr_copy(header.addr3,
-					ieee->current_network.bssid);
-		else
-			ether_addr_copy(header.addr3, dest);
+		ether_addr_copy(header.addr3, dest);
 	}
 
 	is_multicast = is_multicast_ether_addr(header.addr1);
-- 
2.30.2


