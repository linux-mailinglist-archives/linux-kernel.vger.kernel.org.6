Return-Path: <linux-kernel+bounces-447309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E40C9F305D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1A41662ED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09FE204F6B;
	Mon, 16 Dec 2024 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DvIaIwKM"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E7D204681
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351606; cv=none; b=ViT6OskcXNLkA1mhK0EERphn8Dlc0QDWstSZMN9uwydeDw5fGAj0u7pvHkFaFa4HVBGhG94hsERyMMO7cAhsrViBKMCfBWtxDz1yqfcG7Z0SrM5XcjOUTzvaeCLap66WPaCqy0hWYoGXpf5yRXUWPuQyDeYjtghMANOm3cGWkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351606; c=relaxed/simple;
	bh=9UP4HQUzzJPu1A4Je2e1oDk4KEm4ECz5bNhxW4oU+SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s+BQaZksIALeQkOXg1KSL6VJaQB0h8EHWQACvkrNRLRZ8UH/Szqd4/jHTqld32hkl9dEHbupgMQet8P54dd7gyjgvyktwD9MXQm2GklKoYn5E0qoJBFwEcE/MZpyyE3PDhBq3CmGAAE2f+gHHZeNJhC5BhZ0P2zoJ6N7zZrHr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DvIaIwKM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216728b1836so27768865ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734351603; x=1734956403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjWvqlCs8qMFqAThuJZE7hZxssf7cq44rmT5+HL6yzI=;
        b=DvIaIwKMb24upDA22Hodx4RQiCZPFjvxfopl34A7I5IvgvzYBgDexONl6q+aOlVvA5
         Xjv642hEeB+BSpcYcu+85kXU9NMGsgrui/J2VRMNR2ij5LcF51XRFjRgZI57GGjmF6i4
         k7HUaR3NwoVB1q1Bld+DOoQAMRlLInVbmlwsFZUg2Nb/Zfq3JhRK2aMmqbpLNCpgRkkk
         Az4w6EF8RFlrHNk/s3/Eloj9Gw4r00l2sdZvpyotvZHW8hS1jsWIyKN0GEejmYbtwOHZ
         pwlzjBKw4GVXMWlwx9oaT2KywH2g2ZwSMrZ8q1V4TZwgy4QERxp1oK/GGeOrJ/V57QYy
         6oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734351603; x=1734956403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjWvqlCs8qMFqAThuJZE7hZxssf7cq44rmT5+HL6yzI=;
        b=SFbO/zKavEUcc8IlLbHcZ/5Es1kb+xVP3uLj8ICkY19vET3ZL7RYCBUknJLA1hSP2d
         5SQ1Dc3QbzhkbUmORvPqJh1axd4XYpQU4vuOQ+2rVPti9571cCmiLfdT7mze1F3TKKvM
         MoKWgszVwqsrkYxu3fWVwM+2iSm9jObArXFhZ65BN/539e8FgpZlM8F441WZTfI5Otw8
         XLEcNyhlrDPp59j5lhsFyOe7/q+dGIO0qk/QU9REWcoFGM0alxJ028cK66kjoUFV4+Ug
         2KBoduL6+fhzFF4RQtOCENgQxv/GmS8U+HLEM1A7Wz51/PKGQw7CVcL6jcB5OeoP8hnB
         x3nw==
X-Forwarded-Encrypted: i=1; AJvYcCWlLQIFm1c1pgePzHEv7/U3Oqov5v8RVaTRvTKE3NRj67S/IsMTiYAW6sS1aFvNJyLXNi0IaKkq9Ji1jH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuS81WDYOZcHbbI8WNyYxoTQns4XNsCoLELLXXqeKjf2XQmW62
	3THGKJxAHW8iAiX/GbasOJ2oS/P23CklAqFn4sa0piuXH03p9R8y+Y33jg3FaQTcuVWn4uF9sD6
	9
X-Gm-Gg: ASbGncueCP6TXMCqlMvDbEOuNHdJGuulUCBme3D3jOyifN+mg6455NLklaLCIHGosx6
	stqHrFzzHhePslnMJa2ORN/ydaw/vp7nF4szoKlqDDE9A161SMBpGO3spbOxPeVX76v3OJCNhVl
	PawdeUXFosCAvJ5tqoWYyKnzRxDDXlLFonQcamB0RQdkl9RzcAPXSplU/zGL3jIfDMlbEOa3SxA
	OLA4AFnA6SEC0HBivZ3Z6TW3HxLeT6Ftvzfr7O7WKqLf4crhaTHDOX4HugoF1IYfU2vlbDRNoRs
	WYlM
X-Google-Smtp-Source: AGHT+IHLH7NOnSOpMVpdoq31O1h5pYS6xIo9n3y/rxHkJ8y16JCiuEPW9aEsLgAmPQCTjVEIM6HjGA==
X-Received: by 2002:a17:902:f60c:b0:216:7c33:8994 with SMTP id d9443c01a7336-21892a7a811mr188966815ad.53.1734351602790;
        Mon, 16 Dec 2024 04:20:02 -0800 (PST)
Received: from always-zbook.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e53fe7sm41188635ad.160.2024.12.16.04.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 04:20:02 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] RDMA/rxe: Fix mismatched max_msg_sz
Date: Mon, 16 Dec 2024 20:19:53 +0800
Message-ID: <20241216121953.765331-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User mode queries max_msg_sz as 0x800000 by command 'ibv_devinfo -v',
however ibv_post_send/ibv_post_recv has a limit of 2^31. Fix this
mismatched information.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index d2f57ead78ad..003f681e5dc0 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -129,7 +129,7 @@ enum rxe_device_param {
 enum rxe_port_param {
 	RXE_PORT_GID_TBL_LEN		= 1024,
 	RXE_PORT_PORT_CAP_FLAGS		= IB_PORT_CM_SUP,
-	RXE_PORT_MAX_MSG_SZ		= 0x800000,
+	RXE_PORT_MAX_MSG_SZ		= (1UL << 31),
 	RXE_PORT_BAD_PKEY_CNTR		= 0,
 	RXE_PORT_QKEY_VIOL_CNTR		= 0,
 	RXE_PORT_LID			= 0,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 5c18f7e342f2..ffd5b07ad3e6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -688,7 +688,7 @@ static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 		for (i = 0; i < ibwr->num_sge; i++)
 			length += ibwr->sg_list[i].length;
 
-		if (length > (1UL << 31)) {
+		if (length > RXE_PORT_MAX_MSG_SZ) {
 			rxe_err_qp(qp, "message length too long\n");
 			break;
 		}
@@ -972,8 +972,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	for (i = 0; i < num_sge; i++)
 		length += ibwr->sg_list[i].length;
 
-	/* IBA max message size is 2^31 */
-	if (length >= (1UL<<31)) {
+	if (length > RXE_PORT_MAX_MSG_SZ) {
 		err = -EINVAL;
 		rxe_dbg("message length too long\n");
 		goto err_out;
-- 
2.34.1


