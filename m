Return-Path: <linux-kernel+bounces-512645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31135A33C09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C50A188D6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4720A2135CF;
	Thu, 13 Feb 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="NdysdoV7"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39597213233
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441183; cv=none; b=YivrNItxP1yzIxEoFxyvMJHjrddWznCqVM4AGFhMgwW1vtJosGBC9oK5HXRFhxKh5ufQVdKxgfv/ZT4PvyMWjQR8MYC4ARfoRrW0g9Y8fUp6wA3F6i/SaGFIxX/BV+C1bp/QRwyYoQRkEeimgzxIPgdCMORsXuoZOiYn66MEiPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441183; c=relaxed/simple;
	bh=DJxCcTIvgxvkOcXrsiG+p2ey37S3EWiB9CRHiiel0eU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XLBxrRW6vqNSxVC7RF/0S2H5vM5bcZDlT1YcEhog71jnX7vLhc8yXLPNS1b7p4PARqxfaFJfwExE3T50c5+lspbCRLqHiYhFWWxCnspT7tDYXm6b5XnW7PZ2cZjt5pqax2PWUqi+hz7PoHZshKwCUseUH5o0K2Z8e/dMagfb64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=NdysdoV7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f40deb941so15250335ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1739441181; x=1740045981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+m8QAd9uSlaB0HjndrS8KytyCEE/0f9gjFGlCPLPPrM=;
        b=NdysdoV7NvU0DhnyJLWRI7mPN+6KTckiiGcSARvMDkMgdbMI/m+z/qBHEvWcZg5PQ+
         ruBZQOU3v5w/OgIcpm8CL+yXGCPmZ7HaMCDPVdG54si9pRzVPTHo/MEy+VQvr4G+SoRl
         ZPIHqJT+MsjDEirR/8dZOrXyB2Ei9j/Zy/9nXHey5KGfBXGTblAFm4Kiu/nOguEl/Mvs
         CFYcAs3tA2hvBrWIreBUQDY4ys8aWy8A/qNH3wacmTLAV+wa5y4fFujU/2obOSTu8k7w
         w2FHjLqThW8LrZqfytAI9+LBzV3rSEzzFeyGvHjAOS6HrT96QqlTcQd4nDxP0wMJLChA
         coEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441181; x=1740045981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+m8QAd9uSlaB0HjndrS8KytyCEE/0f9gjFGlCPLPPrM=;
        b=EbscdDbroij4vV7TYy3GrqintfqYycEo6zBEFpkbOnDinK5nNh1dZSKmwobmzRZz9m
         RmZxbzy263AP+zp+brOnBpFNJXYeuisW5DkFbQBWjbCLVLKZ/3NkAZmG3Pjeu0ZCmiTs
         KH5p5dRpeLJq1QdUxUSHXqeTZS80RAZXZUog18VtpFWGLJduxW+iQlktaxp/JSGi+V9X
         Xz4pGG5zt+cdri29urrkwUd1mfEhj1gg650grxfc6vgqtUfJIVcuz9GfZ796GtXqluP7
         wjO9oieg4/3YIfpim2z5IGBT0q4db+6/y4TTEGjDjlFnsAFPpnsIQI1L+lItG+zyxTwJ
         NB/g==
X-Forwarded-Encrypted: i=1; AJvYcCUx9jG20OWWvALr/K7rZTKSZ0g4RfqOxh413+V5UEwIv0lOfwW6rrluNl3UE5HZsWTyKjar7DZ299amlmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbw+3fO5T+9Lq9zgQ/hs23xUmHOo1WaHMYSfWGxVLKmW7Kp4zZ
	t/yvncbR9BFVL2Bfh0rGMi5PrPNHgl5ZcQBp6XXsQv2wY/e2Y8Cng9NG6noxwzw=
X-Gm-Gg: ASbGncsKAO/aZjf8bRRtJT15oQElFj/I5OMhbSFXRYWL6hy75x+q97g4AigNS9RqdXg
	HRBlmtS16vyz9BRSmGne+Eq0H8zXXLrx0DsXlOuCusnrb5rM3V9CoObOSmCKP45WFueoVnevqI+
	0cPe8gVrEyZUOq6Twk4vtYqkgDcw9o6CR7oXRvS9lTNGtG7gK2Jd60v+incRxkvkiARb9FU/ept
	780dm5hc+cjA9ESsEtzc4aNYSHU8FjpFjKOkdjLweLXya6LmrhVI+C19kIMu8AEC2J1eouqUpch
X-Google-Smtp-Source: AGHT+IGxuPtgToDHNMzvTl6E3kE57/3yPxyNqRc8cQvsoejoYG+WaIRNLunOFh4IquzPAb8kiixx+g==
X-Received: by 2002:aa7:8881:0:b0:732:2b64:1021 with SMTP id d2e1a72fcca58-7323c1056c9mr3558957b3a.1.1739441181368;
        Thu, 13 Feb 2025 02:06:21 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242761569sm937442b3a.130.2025.02.13.02.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 02:06:20 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: yukuai1@huaweicloud.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 1/2] blk-wbt: Fix some comments
Date: Thu, 13 Feb 2025 18:06:10 +0800
Message-Id: <20250213100611.209997-2-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213100611.209997-1-yizhou.tang@shopee.com>
References: <20250213100611.209997-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

wbt_wait() no longer uses a spinlock as a parameter. Update the function
comments accordingly.

RWB_UNKNOWN_BUMP is used when we gradually adjust scale_steps toward the
center state, which is a value of 0.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-wbt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 6dfc659d22e2..8b73c0c11aec 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -136,8 +136,9 @@ enum {
 	RWB_MIN_WRITE_SAMPLES	= 3,
 
 	/*
-	 * If we have this number of consecutive windows with not enough
-	 * information to scale up or down, scale up.
+	 * If we have this number of consecutive windows without enough
+	 * information to scale up or down, slowly return to center state
+	 * (step == 0).
 	 */
 	RWB_UNKNOWN_BUMP	= 5,
 };
@@ -638,11 +639,7 @@ static void wbt_cleanup(struct rq_qos *rqos, struct bio *bio)
 	__wbt_done(rqos, flags);
 }
 
-/*
- * May sleep, if we have exceeded the writeback limits. Caller can pass
- * in an irq held spinlock, if it holds one when calling this function.
- * If we do sleep, we'll release and re-grab it.
- */
+/* May sleep, if we have exceeded the writeback limits. */
 static void wbt_wait(struct rq_qos *rqos, struct bio *bio)
 {
 	struct rq_wb *rwb = RQWB(rqos);
-- 
2.25.1


