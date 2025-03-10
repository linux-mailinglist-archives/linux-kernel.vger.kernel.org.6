Return-Path: <linux-kernel+bounces-553511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8373FA58AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 04:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464B53AC707
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 03:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6840189B8C;
	Mon, 10 Mar 2025 03:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="3GbTcvbx"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3C5184F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741575622; cv=none; b=W8BQUBzMAH0lG50+4a8r2iR/Hefk5xvO6MwtU/Xgx0aixpeeqc0D0HheDZAg2aQHo5RfZKXl8+kOKABkcuV4BO3Mkg1CW6Dhi/IzsoLdBYL83kUrNZzelNplz6G2s4EcZ2dIECc25YclFioYYKT7JUe7nLPZ94JgXe3N0Yx2E5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741575622; c=relaxed/simple;
	bh=hBx1Gz2StHcPvEa5HNig06dZLy3zDu6fAmDgCL6PcQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AtXe4R102snWVGKvdKceuI1ZJtI34NP7UwOjRqcwS99xrGaigMy0bqsU8VwwGImh0J2uIvhC1y6gnGl2hk5AE/0BuyhgCniIEWjtz56NUPM5QSCWCDQw07iaDHlaYtU6UiTkphjtbImEfRFstdk+lLP4Infw/sYJcVj6Uh1Y3nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=3GbTcvbx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-225477548e1so19198905ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 20:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1741575619; x=1742180419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZURtJBGMcbFFYH+strzONLA5Vczogwh/5hX0jmuWKyw=;
        b=3GbTcvbxhgOIbKyKqLObMcycjr9/10/fTr8IVwcu9fYrRlnYxv4fpkgI6JX3AQLpnG
         emUpVxLwhS+XYua0VTvoEB/VHqzL21q+RF0rzZK3MY6HwDswTAO+txsKDaOwVGm5tlih
         11wDAbbhu0UtP4PCHBpNOFiEtpTePJJEt0KbkpKw0EN523PrEk7/PdGa/x5LrQVrhCYb
         biHfyLw6JsuOUc0GAZL9JPv3V/oyYC6pQzqNLyNh8I+inxIZr8/iq0AF675zDAC4LAwG
         XpOI4T5xkTkJ/y9lgmuwITb77WLG1tYuroUUHd8ML3QerM3iFZ9oOD6KOcyM/P+qHZzp
         qVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741575619; x=1742180419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZURtJBGMcbFFYH+strzONLA5Vczogwh/5hX0jmuWKyw=;
        b=Hl28TqJz4j0oCqkGuuNRA7ZlwXyYC2c207oJEQYWq7nvLaGTvsTQ9Xxs3UrJ2UmPnX
         Lx2GbMoXQHyahe+B4ei+X4jRUjaDLV0YXhK4Boonp2ILF2QRX5maM0n5TfYgjW90vUhl
         vwdLrXHtjO7fChqq/UQOuyqNC6GzYVTaCoIV+bQTEacvsxatF6PpF++XVXoa/85Y686O
         olXW6nlLBfSl7JUkn0lnVI/L7dmEk8L3tWj6gUykL8iJhXoatSVmaBAADRbfQakW9eSR
         odd37FFVREcGy6JR+COm+Kc+l0yeIqdlb2NVgL+037mIwO2FWJRKBRKErBqF/aXu6AMX
         m11A==
X-Forwarded-Encrypted: i=1; AJvYcCVmrwJnQbfI2k1NZ6U3iZbv5H2z5r2yTLalQUFhaYD7JDwztvFBnxK6trG0bLFawTk2774uVVtJOq1ocTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf8tx9auYm4LtrmwwvEl+FroFzCPc4qWzG3MWyPneyUjOqkhXm
	eG0ISafa5/vH0M2NLu1GMa3Fi4PBxot8dQs7FtiY9r3AYNM9aDIdUIbKb14wfL0=
X-Gm-Gg: ASbGncs8smg4tWRyFMwASGIBAaZmV4rLIIzTcEXwQr4FR01N6mYbK4gQgW7I/pbVQJ2
	iX7mkFzEwRrzUCbEA63AqcMRG3T40EuHI+92xvuNEW7dw3oFwXJviX4kr6b47iU9Ojct0ttaYgt
	32x+4P61LBsbW3TzBQSe0zhiP6H4oVkvzEuMoS5dv07ahehA5h3U8MFIL++N8sBmYctehi/0jKk
	jdTOdSJZUu0XL+Jmww/iAvTMQc2DK+M7OTy+5unod1d+tw7wdEkuMF4h4R9lIHNm9B9d+s5ln6o
	Mn3ri4PMjW9kqxdb4iddJ4O36/0QGZWQQ6pshVcybio5i5j641csob/4pe7XpvGw36XSmtyLG7+
	k5IMvTLOlMXmH+jvkQmygDc36t5ySPimmlENZdA+aYVYPfnRdOdc=
X-Google-Smtp-Source: AGHT+IHyoBkykGXzFkG2jWg3Bd1CqAx1te3/jtilPDZkT9O5/GqnMSo1h3Ly4n5g3i9dKxw5SX8epQ==
X-Received: by 2002:a17:902:ce0a:b0:220:cb1a:da5 with SMTP id d9443c01a7336-22428c075e3mr224409445ad.40.1741575619196;
        Sun, 09 Mar 2025 20:00:19 -0700 (PDT)
Received: from localhost.localdomain (awork062100.netvigator.com. [203.198.28.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f75dsm66678965ad.122.2025.03.09.20.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 20:00:18 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Lei Chen <lei.chen@smartx.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix rolling back of CLOCK_MONOTONIC_COARSE
Date: Mon, 10 Mar 2025 11:00:03 +0800
Message-ID: <20250310030004.3705801-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

timekeeping_apply_adjustment try to adjust tkr_mono.mult by @mult_adj.
If @mult_adj > 0, tk->tkr_mono.xtime_nsec will be decreased by @offset.
Then timekeeping_update flushes shadow_timekeeper to real tk and vdso
data region. Then rolling back happens.

The drawing below illustrates the reason why timekeeping_apply_adjustment
descreases tk->tkr_mono.xtime_nsec.

     cycle_interval       offset        clock_delta
x-----------------------x----------x---------------------------x

P0                      P1         P2                         P3

N(P) means the nano sec count at the point P.

Assume timekeeping_apply_adjustment runs at P1, with unaccumulated
cycles @offset. Then tkr_mono.mult is adjusted from M1 to M2.

Since offset happens before tkr_mono.mult adjustment, so we want to
achieve:
N(P3) == offset * M1 + clock_delta * M2 + N(P1)   -------- (1)

But at P3, the code works as following:
N(P3) := (offset + clock_delta) * M2 + N(P1)
       = offset * M2 + clock_delta * M2 + N(P1)

Apprently, N(P3) goes away from equation (1). To correct it, N(P1)
should be adjusted at P2:
N(P1) -= offset * (M2 - M1)

To fix this issue, the patch accumulates offset into tk, and export
N(P2) to real tk and vdso.

tk.tkr_mono := N(P2) = N(P1) + offset * M1

Then at P3, we calculate N(P3) based on N(P2) instead of N(P1):
N(P3) := N(P2) + clock_delta * M2

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 kernel/time/timekeeping.c | 44 +++++++++------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1e67d076f195..65647f7bbc69 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1934,15 +1934,14 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
 {
 	s64 interval = tk->cycle_interval;
 
-	if (mult_adj == 0) {
+	if (mult_adj == 0)
 		return;
-	} else if (mult_adj == -1) {
+
+	if (mult_adj == -1)
 		interval = -interval;
-		offset = -offset;
-	} else if (mult_adj != 1) {
+	else if (mult_adj != 1)
 		interval *= mult_adj;
-		offset *= mult_adj;
-	}
+
 
 	/*
 	 * So the following can be confusing.
@@ -1963,33 +1962,8 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
 	 * Which can be shortened to:
 	 *	xtime_interval += cycle_interval
 	 *
-	 * So offset stores the non-accumulated cycles. Thus the current
-	 * time (in shifted nanoseconds) is:
-	 *	now = (offset * adj) + xtime_nsec
-	 * Now, even though we're adjusting the clock frequency, we have
-	 * to keep time consistent. In other words, we can't jump back
-	 * in time, and we also want to avoid jumping forward in time.
-	 *
-	 * So given the same offset value, we need the time to be the same
-	 * both before and after the freq adjustment.
-	 *	now = (offset * adj_1) + xtime_nsec_1
-	 *	now = (offset * adj_2) + xtime_nsec_2
-	 * So:
-	 *	(offset * adj_1) + xtime_nsec_1 =
-	 *		(offset * adj_2) + xtime_nsec_2
-	 * And we know:
-	 *	adj_2 = adj_1 + 1
-	 * So:
-	 *	(offset * adj_1) + xtime_nsec_1 =
-	 *		(offset * (adj_1+1)) + xtime_nsec_2
-	 *	(offset * adj_1) + xtime_nsec_1 =
-	 *		(offset * adj_1) + offset + xtime_nsec_2
-	 * Canceling the sides:
-	 *	xtime_nsec_1 = offset + xtime_nsec_2
-	 * Which gives us:
-	 *	xtime_nsec_2 = xtime_nsec_1 - offset
-	 * Which simplifies to:
-	 *	xtime_nsec -= offset
++	 * Since mult will be changed, @offset should be accumulated with original
++	 * mult value
 	 */
 	if ((mult_adj > 0) && (tk->tkr_mono.mult + mult_adj < mult_adj)) {
 		/* NTP adjustment caused clocksource mult overflow */
@@ -1997,9 +1971,11 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
 		return;
 	}
 
+	tk->tkr_mono.xtime_nsec += offset * tk->tkr_mono.mult;
+	tk->tkr_mono.cycle_last += offset;
+
 	tk->tkr_mono.mult += mult_adj;
 	tk->xtime_interval += interval;
-	tk->tkr_mono.xtime_nsec -= offset;
 }
 
 /*
-- 
2.44.0


