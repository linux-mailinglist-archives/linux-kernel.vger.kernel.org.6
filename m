Return-Path: <linux-kernel+bounces-386963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9849D9B4A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E73B231E0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE65E206047;
	Tue, 29 Oct 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGNDtKTa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6EB205AD4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206500; cv=none; b=WufRNrHrJGEGVL35nYEIU2NZ6xEWiIlyGMXexZVTsOKxrmGhn8h5N3Nj19ODbaxx3ZP6hXfmj+QPWWrA86hSLK+gGVCzkqma4VDfpBeOV32FF8ugA4XQQKHBoXPsfJrP7IU5R4KooDN9WlZKY53SXApUltppbE/gtzfczSmI7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206500; c=relaxed/simple;
	bh=xeBqyUWWupzyM/TcXcUV+DS4MauYaKO2a0dTN/w+A/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGseI2LmUE7hq976YaqDo1ulmhy4qn23kzOt6NAzS6+zE1OaHuX791EbypZdeuJhlHkPRBMK0w61cVSC++yq9ZrkX32ieIxPqEl3T6CvTHvFc+2ORRKgw+whXL0Oe7RoqmZcTWe0LBJ4syXhJa2cey5C2Dj4VgbJkuyqeCabImg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGNDtKTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6ABC4CECD;
	Tue, 29 Oct 2024 12:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730206499;
	bh=xeBqyUWWupzyM/TcXcUV+DS4MauYaKO2a0dTN/w+A/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CGNDtKTaB08W2p/r8Gpx+Bpvrjc+RJ7+AbqzTT3t497ESAD+W93WrjIHrQf1cyNv0
	 LwqUEKJLtbF5CHBYlFEVH4ICNIECnfPbQjNn7QUqoAIV9ioTuLl8OTleeoB3dqD26H
	 vfo9fIgEwpJebEoqFKR3dojS5QSkn+mutNRKkAVFbsBfbNA1ib95xcOlTqGVNVNLn2
	 Xjm9SVBBfxs+ZTbId6D7EuPi/0ujck2WpHtqSnc55evYdC3IIgb2gnae0MpiAFm+1a
	 17S+0mS2M1Nu1W6nlqZgK1bUzv8ldgKzljOcAX7W6j3hcIoM3a4Q3lyEG1nBZFzhxU
	 BY4AGt7xMROAQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 01/10] clockevents: Improve clockevents_notify_released() comment
Date: Tue, 29 Oct 2024 13:54:42 +0100
Message-ID: <20241029125451.54574-2-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241029125451.54574-1-frederic@kernel.org>
References: <20241029125451.54574-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a new clockevent device is added and replaces a previous device,
the latter is put into the released list. Then the released list is
added back.

This may look counter-intuitive but the reason is that released device
might be suitable for other uses. For example a released CPU regular
clockevent can be a better replacement for the current broadcast event.
Similarly a released broadcast clockevent can be a better replacement
for the current regular clockevent of a given CPU.

Improve comments stating about these subtleties.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/clockevents.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 78c7bd64d0dd..4af27994db93 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -337,13 +337,21 @@ int clockevents_program_event(struct clock_event_device *dev, ktime_t expires,
 }
 
 /*
- * Called after a notify add to make devices available which were
- * released from the notifier call.
+ * Called after a clockevent has been added which might
+ * have replaced a current regular or broadcast device. A
+ * released normal device might be a suitable replacement
+ * for the current broadcast device. Similarly a released
+ * broadcast device might be a suitable replacement for a
+ * normal device.
  */
 static void clockevents_notify_released(void)
 {
 	struct clock_event_device *dev;
 
+	/*
+	 * Keep iterating as long as tick_check_new_device()
+	 * replaces a device.
+	 */
 	while (!list_empty(&clockevents_released)) {
 		dev = list_entry(clockevents_released.next,
 				 struct clock_event_device, list);
-- 
2.46.0


