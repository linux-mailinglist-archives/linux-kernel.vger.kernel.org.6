Return-Path: <linux-kernel+bounces-523580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9A6A3D8AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB133AA8BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59581F3BBE;
	Thu, 20 Feb 2025 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="g+Az0dN4";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="OpdFy3BB"
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021751F236C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050908; cv=none; b=uxfGh/mGNZVnAEzTksEzehXx5bsB+Vauk996DhL4Wc7FxpipVk5wvcKeQ8giO/agjZV1EShDqUCCrPtN4Qj07R8mDL/7NQf4HiyNjBrHOhRkp1lxeSta/FVgCn1DreZ+LGxLhKJ0x9JJh9B/jIu9i890YbE3KI936kpHTH0GQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050908; c=relaxed/simple;
	bh=YkiHPumBN8nAiPNaHtyQooOU01tx/EZ1O8QxZuFIQAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IY4AiVRRbLbiJEyvuIz9i0kir5sEZsADTh7LwB91IphxKxg770JpzjaIVfS4brenf3GajJ0aulf/JKRsJww3lAri2Jt/A5FdIsEWisyGzsAMtDbSycf8vCviAK4nUqAmzxw572NE571inBnKh8gXJJ1rwqI69sX394J8uQql2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=g+Az0dN4; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=OpdFy3BB; arc=none smtp.client-ip=158.120.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1740050898; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=M1W1nn58NLGVj+eWLt6EtKwldWjGNarRyKe0cNviRKI=;
 b=g+Az0dN4XhCXVz/4c4Ms1zjv28DcJNw34A1vpLjtoisd9PsUccqG06h9WCTR9Gla6ykRq
 q0aCDwdSCNeSUEhkqa6NlhERyE4X/meWxKX3rnoFiXGkKToj6LUIaclD0TlX72L9/zq7YqO
 SU532AbZL0i09hoQOmTwNbF5T0n9P2lYiniPaV5+6sS7Mb4tkjAyUhjvWoamMvjmFHE74tz
 waczQntZewOGhjBjNMSJ7HWDTnY/l5wBAgIL6EjBMCgz91AuKqWZrbjhRhFGvV2sJFlUMe9
 RtKxnBabG4YAockUhFaJAdTNqDpx/Hdo+73U506FIjz2t7ar0BLkZkwqMInA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1740050898; h=from : subject
 : to : message-id : date;
 bh=M1W1nn58NLGVj+eWLt6EtKwldWjGNarRyKe0cNviRKI=;
 b=OpdFy3BBaxZ8UI0awjqzV1J0+LICnF+4LcfH/6is6QFsrqXm5m9HvFkEPx2XQM3Skvc43
 YxbuQEswpDpyn2jqNCkjd0v+ufJsvXHrvPkZ/tIa/S53XY9qB6i/g6EelkQDwgoP+khWhMk
 PROl0qtsxNtocJyXytqpHcZT+TUxgK2o8CudgwyIX1l7nfO166835z1RPkuffnpqdRypyM4
 ZsQLykowZO96A99sbkSDLFlZQD/ZIWQbQPBHMMG30yTyfq1WJDyaV7TbbUWJUhjEia8zTqM
 D72mzfiRKDvqsksm+HL5sqyDor0e2vfKOharqal5mrgJAHBT/y7Oj7CggJEA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1tl4iv-4o5NDgrvJ0D-lp0j;
	Thu, 20 Feb 2025 11:28:09 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2] leds: Fix LED_OFF brightness race
Date: Thu, 20 Feb 2025 12:23:17 +0100
Message-Id: <19c81177059dab7b656c42063958011a8e4d1a66.1740050412.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sDHMaHdAgA
X-smtpcorp-track: zcFvao-w_nmC.ipaOdkftC_MT.921AGQ20SmT

While commit fa15d8c69238 ("leds: Fix set_brightness_delayed() race")
successfully forces led_set_brightness() to be called with LED_OFF at
least once when switching from blinking to LED on state so that
hw-blinking can be disabled, another race remains. Indeed in
led_set_brightness(LED_OFF) followed by led_set_brightness(any)
scenario the following CPU scheduling can happen:

    CPU0                                     CPU1
    ----                                     ----
 set_brightness_delayed() {
   test_and_clear_bit(BRIGHTNESS_OFF)
                                         led_set_brightness(LED_OFF) {
                                           set_bit(BRIGHTNESS_OFF)
					   queue_work()
                                         }
                                         led_set_brightness(any) {
                                           set_bit(BRIGHTNESS)
					   queue_work() //already queued
                                         }
   test_and_clear_bit(BRIGHTNESS)
     /* LED set with brightness any */
 }

 /* From previous CPU1 queue_work() */
 set_brightness_delayed() {
   test_and_clear_bit(BRIGHTNESS_OFF)
     /* LED turned off */
   test_and_clear_bit(BRIGHTNESS)
     /* Clear from previous run, LED remains off */

In that case the led_set_brightness(LED_OFF)/led_set_brightness(any)
sequence will be effectively executed in reverse order and LED will
remain off.

With the introduction of commit 32360bf6a5d4 ("leds: Introduce ordered
workqueue for LEDs events instead of system_wq") the race is easier to
trigger as sysfs brightness configuration does not wait for
set_brightness_delayed() work to finish (flush_work() removal).

Use delayed_set_value to optionnally re-configure brightness after a
LED_OFF. That way a LED state could be configured more that once but
final state will always be as expected. Ensure that delayed_set_value
modification is seen before set_bit() using smp_mb__before_atomic().

Fixes: fa15d8c69238 ("leds: Fix set_brightness_delayed() race")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
Changes for v1 to v2:
  - Use smp_mb__before_atomic().
---
 drivers/leds/led-core.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index f6c46d2e5276..e3d8ddcff567 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -159,8 +159,19 @@ static void set_brightness_delayed(struct work_struct *ws)
 	 * before this work item runs once. To make sure this works properly
 	 * handle LED_SET_BRIGHTNESS_OFF first.
 	 */
-	if (test_and_clear_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags))
+	if (test_and_clear_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags)) {
 		set_brightness_delayed_set_brightness(led_cdev, LED_OFF);
+		/*
+		 * The consecutives led_set_brightness(LED_OFF),
+		 * led_set_brightness(LED_FULL) could have been executed out of
+		 * order (LED_FULL first), if the work_flags has been set
+		 * between LED_SET_BRIGHTNESS_OFF and LED_SET_BRIGHTNESS of this
+		 * work. To avoid ending with the LED turned off, turn the LED
+		 * on again.
+		 */
+		if (led_cdev->delayed_set_value != LED_OFF)
+			set_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags);
+	}
 
 	if (test_and_clear_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags))
 		set_brightness_delayed_set_brightness(led_cdev, led_cdev->delayed_set_value);
@@ -331,10 +342,13 @@ void led_set_brightness_nopm(struct led_classdev *led_cdev, unsigned int value)
 	 * change is done immediately afterwards (before the work runs),
 	 * it uses a separate work_flag.
 	 */
-	if (value) {
-		led_cdev->delayed_set_value = value;
+	led_cdev->delayed_set_value = value;
+	/* Ensure delayed_set_value is seen before work_flags modification */
+	smp_mb__before_atomic();
+
+	if (value)
 		set_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags);
-	} else {
+	else {
 		clear_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags);
 		clear_bit(LED_SET_BLINK, &led_cdev->work_flags);
 		set_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags);
-- 
2.40.0


