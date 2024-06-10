Return-Path: <linux-kernel+bounces-207684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFB7901A73
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2476C1F22781
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DDF74BF8;
	Mon, 10 Jun 2024 05:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="J0FuG2yv"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63587407D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998554; cv=none; b=QQC0IT4ytuqfZP02J0rE3ZzjhB8Dan/KMRs2jMT8L4D70C9e7tjri0RPtH8pwo4CKmYtQRXQt53fYLRToA9zMSZgAPJCPP4PaROfZZuwxf77bfg02l1JVHdTDvAfdApWcY14D6eWAfJP23X+0TEzJ1BX56PE12fAL1M2GVa6DWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998554; c=relaxed/simple;
	bh=TzS+2SyTPi+QEkE8BC594KnimsII7PaWpgUR1Ys+4gE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLt+Lvc2J34gp/FpM68xxHLoR8x9S93Xo1m9Ju+STI2qD8Ss+zl68RFHbM36OwIl705zmOLQlG4XSP1N/fhtrUMzcBrioTCvun+m1MmziDn/Eo4ufctOP4qZkyt8r00fikWsJxBg6aetrAVpVb+DPUebHHObr+HuhOPeOz0pZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=J0FuG2yv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f64ecb1766so31017345ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998552; x=1718603352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC6Tele6QaEsDWjCYka+sqSIKWFJjEBZoQF3EczNhN4=;
        b=J0FuG2yveBNqTVoUnjZjkF7Jdbrlx+LrXoamg3+DHkFb/iWALEHxvP+9NWJwA+8BLo
         7DMkJM3HmZ60GYOAbUgjymTr0bROuszRkEVVZaDklHwvsXwGELV107kIv1Y3VXLgCGdr
         Uivm8+nut/BfBrL3SX84OPsZkRxpxzUnQS3P6dlxUAcrd+4sJwd7l4KSFagWnuqNuuiJ
         AxlsbXLTLgzmygbwWQwavfsqZ1/vaIv7tS+nJ/4bpIot4uatwjyJDN6KejhBNuxgYDu2
         JzqzZfXlERc02/twuJC+cLTUIRyVHzBwEq7F9Y4EVdCrj5QeC5jzO4GWzy2VQ4kFxgbV
         FmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998552; x=1718603352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EC6Tele6QaEsDWjCYka+sqSIKWFJjEBZoQF3EczNhN4=;
        b=Ka529TG28f6DIJz5lyv5Vb1R7ZOyPgWrd23XYCUd5byeRTt3rwIQJ0qohmu3RliXY0
         Toyx4LY+d05MgcTSqinFq9J13ji+803WbGhBzEQ3yRM31i/keZfaNLPQ0HfaQHmicuYR
         zpJWnm+08uP26jKQ5KuFPzAld3yE9tXo7IMRSYHuCd3J2seU30MPzjhAvuUdB2mKDjdf
         kZdwgZ99PdqWZfpt3iS3fTnVvAnh0gib+9bsj3enhfYVNX8Q+cs37qJXPm/1sjK/el+5
         P21xQirkeRzYNZ575qWgX6VVUAg+Al/ymb4Cj/btT4xljnA60jdchOQR6aQ4Qt5Rro8M
         ivxA==
X-Forwarded-Encrypted: i=1; AJvYcCUwd16WfpxE4O3duLyypPSoFsaOpaDs4RlwQlfuCLeSnV1CjoHsdArPlUvXoJ6kR5dSjt6vBDzUTVzU8PDrSk7HkZ5WwvB+y/osmyZM
X-Gm-Message-State: AOJu0Yw+euwrLcORKvp2aZy2MUUbZwiScoGeqCRj/SVhMifnbTLS0zXf
	stvfgO3HvhMdpyq6RmZ/rKHTkOFucLi44ca6ATrPgkmK1rpNL/wSy6bi6jy1SL4=
X-Google-Smtp-Source: AGHT+IE4CP6ZfcXnVdl65DEw+FE9wqEhiS8NzeAZeTvZoxRqscmHF4lb+qQVQQqSR7fOnOicRbDt3A==
X-Received: by 2002:a17:902:ea06:b0:1f4:8a01:283e with SMTP id d9443c01a7336-1f6d02cc84fmr98180365ad.5.1717998552334;
        Sun, 09 Jun 2024 22:49:12 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:49:11 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 21/24] Remove parameter bIsAmsdu from rtllib_classify()
Date: Sun,  9 Jun 2024 22:44:46 -0700
Message-Id: <20240610054449.71316-22-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610054449.71316-1-tdavies@darkphysics.net>
References: <20240610054449.71316-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove argument, bIsAmsdu from rtllib_classify() as it is
never used.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 841d9960385b..deae90640e90 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -228,7 +228,7 @@ static struct rtllib_txb *rtllib_alloc_txb(int nr_frags, int txb_size,
 	return NULL;
 }
 
-static int rtllib_classify(struct sk_buff *skb, u8 bIsAmsdu)
+static int rtllib_classify(struct sk_buff *skb)
 {
 	struct ethhdr *eth;
 	struct iphdr *ip;
@@ -607,7 +607,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
-	skb->priority = rtllib_classify(skb, IsAmsdu);
+	skb->priority = rtllib_classify(skb);
 	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
 	encrypt = !(ether_type == ETH_P_PAE && ieee->ieee802_1x) && crypt && crypt->ops;
 	if (!encrypt && ieee->ieee802_1x &&
-- 
2.30.2


