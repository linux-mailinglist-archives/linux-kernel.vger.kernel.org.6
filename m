Return-Path: <linux-kernel+bounces-300610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8651195E601
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C59A8B20D03
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DD01FBA;
	Mon, 26 Aug 2024 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="GsU5oksr"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DA12913
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724631450; cv=none; b=TA9g9tH9ArW9la5dWNswxwa0+ZzVKEVa/y3+Aapnnlzg0QMUBrJA7w7XVXs+jn1bUs+2AQG8QxH4prHa/iKtNhftTOocsld159F549qAx+aTOFSveTA2nY8dRo6mwkthoe0KFzvA9EYtsZy+tArZjIx0fh5V82055ahaNMHv5xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724631450; c=relaxed/simple;
	bh=h/pmg8LUsT8ycegCUf7sWEuMzRhBHVTMnNYn3LAuREk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dr2ecQtuauCLoeiO6AAPW1RGfrCUZ4e/zK27cQv0cmi1doAu5o/EL96ALkUGfz7J3nFF4NpqZdmgyOIYf0P+gzLyJ62o5rg+2LqSDvpPy93DbfKz94bWFCS9ebnGrsZx04n0C4xCCNkyysVXTbWtAKd9vJTEnKUaEjiDk8jNwAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=GsU5oksr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20208830de8so29678845ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 17:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724631448; x=1725236248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZtBxOsTWvnnsjgp2ET9l+XUHkm7CYnC/EJsQtXJxes=;
        b=GsU5oksrcag3QOyJOPgQNlhH0NeVI7n/gSLbehmHm/Yvt8+MSAGO5M8ekTtNU9MqBc
         NDF9wE+xngB6F/Oz4xyR/z6Fgpgp9VYXM0E3Ow8AXs/5tob0QmhB4BD+FKi91n5Q/z8U
         OcRDObkrRX1igFzPTRUAbXkjJV4w7s4YhB4PBHNW9aOqqFma/u0koiBZ+UWGp0ytmmHS
         Lps4IpI6rAwpqQA3PtIlqDZSA0eWaPLzmMuLtLrZIBB/zdDGNEg1pIedWScEBG/7cvHU
         gRxtKRqSRhYzZr9zlaYC1OKW2hggBF9qVhAmrx7iWkI67fs7w6mMYlGryl+ZzvKLqQy2
         doDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724631448; x=1725236248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZtBxOsTWvnnsjgp2ET9l+XUHkm7CYnC/EJsQtXJxes=;
        b=Xmjy+xZQ+7gM3NIiv8HvVUIE0uRqjt4sQ6+ezNBnVN1zNvRz4cXXnirSqfjs9car6D
         p4j3n7HX1tyGtnfr+DgpK4VM9mzbxN9BSSfiKijvZUq+Moul8kZh+A4eNqbtY2qUMPwQ
         DoMyaNzZf4fod83wY9ljHfeZa01bD/YjFlR46YcapYBTZJ2+qUBDuZ5ld65lB6wz8z6A
         cFcy1plGcXcHMNEFsHPyZxBxaGRfYTWchHjW3dgFKjC7CpVOtEQtE+6+KnCpnAQNDuqD
         /4z9p0fQwTcLS/sL6zlTea4hfs+dwL1qrQCq7e9kvr4p8aEfbGUgorhSdYJXPTpP6zxz
         kF7w==
X-Forwarded-Encrypted: i=1; AJvYcCXpYmL7DOqkK2C4xVkRlALf/fif+YQ7vqcvh7EF9m01HJh8YMS6Rz6o4qp2eo/dQy41iiQXFTGfi9Mx3Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VdxwAd08IBKI4XfPB6qrHad3L3NMLnFeiiQeG535gdgDqnjF
	gqAjpdgD1Q1N8q/4NlmAttbNPnn4lYkuCCecResmIVrLhq2O5X0fQZve/fV7KjU=
X-Google-Smtp-Source: AGHT+IE65Pj227dZDpU9K1kQRxll85DZkyJsRnnsWMYyCw12XMX6xgBNc80X1neDYMEB/yplijOrtg==
X-Received: by 2002:a17:902:d203:b0:1fd:a1d2:c035 with SMTP id d9443c01a7336-2039e4adf24mr71182805ad.31.1724631448509;
        Sun, 25 Aug 2024 17:17:28 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203857051b9sm58695955ad.234.2024.08.25.17.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 17:17:28 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 1/6] Staging: rtl8192e: Rename variable CurPsLevel
Date: Sun, 25 Aug 2024 17:17:19 -0700
Message-Id: <20240826001724.274811-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240826001724.274811-1-tdavies@darkphysics.net>
References: <20240826001724.274811-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CurPsLevel to cur_ps_level
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index a332759367ec..4e72fa65a559 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -93,9 +93,9 @@ static inline void *netdev_priv_rsl(struct net_device *dev)
 #define SUPPORT_CKIP_PK			0x10
 #define	RT_RF_OFF_LEVL_HALT_NIC		BIT(3)
 #define	RT_IN_PS_LEVEL(psc, _PS_FLAG)		\
-	((psc->CurPsLevel & _PS_FLAG) ? true : false)
+	((psc->cur_ps_level & _PS_FLAG) ? true : false)
 #define	RT_CLEAR_PS_LEVEL(psc, _PS_FLAG)	\
-	(psc->CurPsLevel &= (~(_PS_FLAG)))
+	(psc->cur_ps_level &= (~(_PS_FLAG)))
 
 /* defined for skb cb field */
 /* At most 28 byte */
@@ -1046,7 +1046,7 @@ struct rt_pwr_save_ctrl {
 	u8				lps_idle_count;
 	u8				lps_awake_intvl;
 
-	u32				CurPsLevel;
+	u32				cur_ps_level;
 };
 
 #define RT_RF_CHANGE_SOURCE u32
-- 
2.30.2


