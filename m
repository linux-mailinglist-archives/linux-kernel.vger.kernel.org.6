Return-Path: <linux-kernel+bounces-370225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BFA9A2992
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7582C1F21687
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103721DF994;
	Thu, 17 Oct 2024 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9pywovj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736671DF969
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183849; cv=none; b=ZPj5bnz7YR0LWeeT5NbYCf5W5sEVv3X/lIh4pbmCif9qYeHgYQ4GrHo8nZgZz/YY/AHFnsp2TQpjLWYzZq5f/0a5aszJMs2PcvcIsXuC7ZDMEv513spLqbXv8ldnvUrnzyWIetCWVo+PMKVL0ftnRtuumioikWnMQWtRbuLXt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183849; c=relaxed/simple;
	bh=xeBqyUWWupzyM/TcXcUV+DS4MauYaKO2a0dTN/w+A/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5Kv5XS8VDB3Wvjw/ABdaBi5woU8okYHLwemoIpU7+6p6fdnfNVkd7poN3MuWBxHhSlhlRnyoOzJ7C5F6bCoEa1PEEjEdTYAlJ8X88FV9vPzhvbh6TvuFsa+M4nDNjT6U3FJsHuv9AJFQ1kOCws1EX/UW+aZp9MtfmkxqCFgf58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9pywovj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73E9C4CECD;
	Thu, 17 Oct 2024 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183849;
	bh=xeBqyUWWupzyM/TcXcUV+DS4MauYaKO2a0dTN/w+A/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U9pywovjwGu8ETQqlUbElaekqiq0LDPsFi+xdIkH7Neal/nSJARDKrZU6BKW20lTy
	 v6ELSRthrW7x2LHh0JzQpnfrqriNPYn87ZPSrRT0LhVVIdDqDl8MvvkHAz9CE+iUef
	 mDTE0lwLCQwTwu766RQlw1xvdW5+SzNQvQjNrgu/olCuCRLry/ylDwsOlN5SNc0S4+
	 1G1W4MVbfIkSNENqyysIO3EK4wsdQO6R0L2+tbvHg7EG26R/yXbgZpSSI4OkIbC5QA
	 9NhKRfbzROv4l1JExErbDdH0XgdfWLDADr2X2WQmF9z6Zdxf90h14RBQK2t8kXoIZY
	 jOng5X9NPoayw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 01/10] clockevents: Improve clockevents_notify_released() comment
Date: Thu, 17 Oct 2024 18:50:32 +0200
Message-ID: <20241017165041.6954-2-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017165041.6954-1-frederic@kernel.org>
References: <20241017165041.6954-1-frederic@kernel.org>
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


