Return-Path: <linux-kernel+bounces-518275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454ABA38CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3861673C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0309B235377;
	Mon, 17 Feb 2025 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW3BwZap"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D722688C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821867; cv=none; b=diIBvCwR5WLnHmKIzX+skrxJ66kn/Oj9pp/FHd5XgruCzPWIv7NQae7QHuA+Rqboyoie77m9XIFzDs/x0jQQCeLW7u1AN3lzgT4Mx1g4dVxISoiqgkPz5YpgZHvhphX8l6OWzufUO8wqwMCVoFz7/9eHL+JgoyEAKi+2JVIGG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821867; c=relaxed/simple;
	bh=fvxc2nA5l9IF9nEr97T0t174jPkXXoOp2oMvRCWYwHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgmPxOd3VmaoCUZGCwBwDLROiLbs/FVaE524Pg2B0B6CeK/xD5q27N3SoRRHxPybY3Hzmnn05xLPUsRuXA+wzZfkBnQw58oLlL/74QMqDzoTL52CVP1Ivy5ejUNTKwcfuKatpc2NqSz5Tuc/nkCnEtM+Su2pZ4BFo1Z/3/DbTBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW3BwZap; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-220f4dd756eso56453365ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739821865; x=1740426665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuS0adcc8Fxg+8m6s8u569Uh3Sx/1Cru69GJC1Yskkg=;
        b=NW3BwZapZkUPftrQYObvogQWDrNjL7pphGUmK+B5O9S8QKXQ6leCscpcYXlfdboJ6u
         4ttL6N1W+SDdEwUKh7XGFc4USqleZB342pIbWBl6ODuysY+9x50ngNmBAEAwmNRsED7I
         XfPld9TOB08T8DjkTeb54WB8uaN+G2+IGURGGhA2UKqwYQQrWlusjntTx+jIDusPKS/K
         dyi+24OOyePp+tNLUJz5OYnp4cNpDsWH0AVOKKEEsALgaQo86ypd6Y3/IaTTqWkpClWl
         0y6Er2ktdvEst5ajtfmwhE1zx8krrRoyGzfTcoBbSgwSTacjZMOfFaN0lju/QV0uH+1x
         Rdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739821865; x=1740426665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuS0adcc8Fxg+8m6s8u569Uh3Sx/1Cru69GJC1Yskkg=;
        b=Tz7yMowuhITJSEACauOivcgPtGNIHtpXtq1Q09VSaONJPgymHUkZq0S2IJhTKVzKHQ
         1EhZUwRrWxosO4IsXiE6kTxNxvHNBIwciTXKc0Q8iUaaj1pFaQY0CmQPGDGFDUMCcET/
         4+CAarbqZPPUU78d+NT5eOuq1irLR5gVqLJeiyTE726e3NCecp89BvG3zXD0GPSY5wUe
         NJ08tr0M06X0jj5DMfJUFLgn79maRpfvV4EjlR1nEXim6mElP/lOOZl3STgz+5iGoHAl
         n8oTusDL369ShZ0GAJzx+a83IOELrxXfTSNr5Uj+C6BJMHwWXnPTUO+Ps+yfmh1dwLFr
         S1ig==
X-Forwarded-Encrypted: i=1; AJvYcCWmSd+RVpmsy103VOmmC/mQTIQn+oGG5Hhdi7MTwEnP2NGBnfLiVJ5CvsTgbCxbNftPnwSPDD79pIT+NXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSrT2fo5hlOpsvqTVzlECjMgYFmT6k86ZQfOlTBd6/rn2RKjqm
	vSdeI0quSIH6wCB1yXs7nL5PIkg3FF2BbZ4UJB413MlT200tM4aY
X-Gm-Gg: ASbGnctOV+VaorirvUKKTsCIb0T5MGPjQ6TMHUbJh6/cmV7/IRWAG8YU328dpKz+C9X
	Xn0DN3RWbI3+yca7tJfqLLqvPVHZU7QZ3tXGeSPFSxjUcNxuNb8xea5NWYTaIn7fO90WEvKJTMx
	dL8RL34+oBxJsgviV5q7h7Bs8u2OIajsHd76ztAHbet6b3PoXHtEwTxZ7Q5Ri4QBiXDYQvrEmPB
	rdZwRp2BI25J+7a5f6l0e/tkXwCnc+jBG6KXy4PJ9AiTFhIwcHzzVyC854K+D4iGO3/UYYFIQOU
	o3Svp/ZwwRoiVWsyyESR
X-Google-Smtp-Source: AGHT+IEZXTjLtFwTNfFx61i+LqglEKU3cBTh4eu1bK0kAaX4GJOeFlHPzDJQh4QCeI77CQd314ubaA==
X-Received: by 2002:a17:902:c94d:b0:21f:5cd8:c52 with SMTP id d9443c01a7336-221040eb619mr150146455ad.53.1739821865173;
        Mon, 17 Feb 2025 11:51:05 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d536698fsm74948865ad.91.2025.02.17.11.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:51:04 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH v5 1/3] staging:gpib:agilent_82350b.c: fixed a typo
Date: Tue, 18 Feb 2025 01:20:48 +0530
Message-ID: <20250217195050.117167-2-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217195050.117167-1-kumarkairiravi@gmail.com>
References: <20250217195050.117167-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

from havn't -> haven't

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 5c62ec24fc..5a74a22015 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -121,7 +121,7 @@ static int agilent_82350b_accel_read(gpib_board_t *board, uint8_t *buffer, size_
 	writeb(DIRECTION_GPIB_TO_HOST, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
 	if (retval < 0)
 		return retval;
-	// read last bytes if we havn't received an END yet
+	// read last bytes if we haven't received an END yet
 	if (*end == 0) {
 		size_t num_bytes;
 		// try to make sure we holdoff after last byte read
-- 
2.48.1


