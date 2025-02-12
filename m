Return-Path: <linux-kernel+bounces-510415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4511DA31C82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4ED5166D87
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71771D5146;
	Wed, 12 Feb 2025 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="PbqxVD2w"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8323D27183B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739329265; cv=none; b=R903+hdI7evDYMk8+WLh8k84gjlCqTHo6t5I6wMdL0rmSK1g2lJrpVxXvQu29Yjhgl81USJVtVQcStuq9skRkza+ddiYY517GvnhuerW+yUYp34l3pU9OqAut+XHNg48SKwCpt4jDRm3WN2JR9xPHjovgN4iEwoWtGf26yBjIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739329265; c=relaxed/simple;
	bh=XPP9kRN6kzoAOAZHknQN2SY3BFA8CtzNYCTu5ea1JwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s6HHvB/3vfCiCqhZxfDKKDz7b1xxYdxPLpmJB6O3Abx9Ppy5hTpCwzePowTFIfu48HdXnbD/hh+8SF6WjoKZIxnplYj80l81d6ib1i6rj0sUVqenlDXDLsiPWPpzwp/hVSsDbV7xtiPewekKkC9Fu5i3IblFaVy9ypy2zjNQO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=PbqxVD2w; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f61b01630so5704185ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1739329263; x=1739934063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rX+yii2dh/Nt6iZHfj27+NPFJKvRakVXL3zR3FNiPnU=;
        b=PbqxVD2wnGV9Y/QVtFTK3JnnIfruORn4vsmvKQSubIWNrrKEQbi4yLFGDkS6QbD/OA
         mxBZhfmi+pPyJojoveR+T8BPtveesaPGJ0Qr74fbBn/Kdb1EerP4Q9p9B64FNZjNmLLF
         SHXz684PWl4z5AikVtEEEoKlB7kUIVzQCNMIU/qMMTC3gN4JRWPeRBFR4Bj8L/7r9bgg
         Pojby8vN7Gg/CBwNeHqyhK2pzXGZ4pyE/5C1Ow8oqzR9SEE5BYCFcA9WN7AUUiStY0XO
         0aN673blVklybvKn5iTAGo4HeaDOq4Obr/bi3IwjnEa1eHqdJqzCqHjv6UBGUpIUKuEk
         bFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739329263; x=1739934063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rX+yii2dh/Nt6iZHfj27+NPFJKvRakVXL3zR3FNiPnU=;
        b=KF4H4g3mY/4/+ffIKQOpKtr8A9/8eP+Mruhwp0AEfBrra6BTjpnQNT8wDZWRouKWk7
         eDmBY/6B2QTrjChcUJ1qNC6RrmC16ODxCwrQqBZmDlLC3oeYEgeNnXkX0ZNQjEP1IOJ+
         szmc7XWzTkMR5hyTzI4cW07hr8mrTh6W0Km2wAhw+vJ1W/+hMSaQUYUZzUdgv+ac2jtk
         P7JHqykclEHLmQ2XMorSPcIiQvXU9+pwvrma+4HLSc3F0MRojGc8PMGwRAl36UitGv50
         m1SuqiyUj1DLKOcQWcehGgoBYnTR4MT6Im4z5Vc3w/1tcg6QCRcyikdAhHOMLK5OOV3i
         FYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvQBBTl6Fz2DgwmIhZ5ABniP0apXv6Jg9Y+s5TXUIP9xb2LeUMTUv7Yfh2Cx01XcKlWqMDuj/n77kgsaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk93Vq4huyP7kJVqXMamXFvm1bPg5bmy3ONbOzzVsU3qZ9EhAB
	HAh0cajf2vafotNSm/YxYKCqZ0tyViDwVSMHnIP+e/0NoGV2HT269VyhfTPiPsU=
X-Gm-Gg: ASbGncsjMOan7JT33CIhKyP5PmiA0hpVPTnLqXDVomR4UnfxnFz1ApIXV1C0iqZN+4U
	r24N0b49wtfevy8G3F56rOowy4pOVUK/qDylvStep1boofyg+R7ibS3rUbyOgMaUbc5LtlcvTwX
	k6hzjkrqNIcCa0aBJcUZ4by1qFmNhL3wvA4/A4yXMY88DdhW0AyKxOFJw9pn43hYO5Gk/lvWaN2
	8HH0Om5V1/Urqylzzwmsv9tvVc/hoKHYsc9SQo92kNVIO6uog0jaNrNHveaRLCE7hjRhxl+835r
X-Google-Smtp-Source: AGHT+IHYiD5282yAI56S5u6sv+uNijoJoeBldjyAL4y6gsfbUi6PiXik3/CCecp77O4OY+bdxO9OlA==
X-Received: by 2002:a05:6a00:3d03:b0:730:84e7:cc with SMTP id d2e1a72fcca58-7322bdc4f48mr2719774b3a.0.1739329262552;
        Tue, 11 Feb 2025 19:01:02 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73091f94bf9sm4170337b3a.20.2025.02.11.19.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:01:00 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH] blk-wbt: Cleanup some comments
Date: Wed, 12 Feb 2025 11:00:55 +0800
Message-Id: <20250212030055.407090-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

wbt_wait() no longer uses a spinlock as a parameter. Update the
function comments accordingly.

Additionally, revise other comments to ensure they align with the
actual implementation.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-wbt.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 6dfc659d22e2..f1754d07f7e0 100644
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
@@ -446,9 +447,9 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
 		break;
 	case LAT_UNKNOWN_WRITES:
 		/*
-		 * We started a the center step, but don't have a valid
-		 * read/write sample, but we do have writes going on.
-		 * Allow step to go negative, to increase write perf.
+		 * We don't have a valid read/write sample, but we do have
+		 * writes going on. Allow step to go negative, to increase
+		 * write performance.
 		 */
 		scale_up(rwb);
 		break;
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


