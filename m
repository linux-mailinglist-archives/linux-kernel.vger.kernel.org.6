Return-Path: <linux-kernel+bounces-259982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F185193A0CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76C828323C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C8B152504;
	Tue, 23 Jul 2024 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwwAV1kH"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D2644C97
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739871; cv=none; b=nlpqckokhxtQyWYj+LZcioL1ZqdEpf7gSxwl1QtLc62ASttZyyDpj2PEPMHYq56b93KSG50Ug3YxNvFx7VZnsbi+eUNB0bQlQQO6AcRPVUnKQ4drgoUeU49HneOfsiQZI2uCKMM4VtwWjAeUicALfdyiRZfYSt4PLm6LW9mWUNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739871; c=relaxed/simple;
	bh=K5LnO2SnxIfNSgOJ3BimH6nE44TLBrVVGmNW9+hFpog=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LPP7mNbSNNElDupiNTLZv9NjVwOV9nl1bjWuIWxGx408EuERt7oYbitkLAtAbQnHi+nDXASvqZ7VekF06jRcZ9N4edIRcchiA9tYhJT2Ow1L3UZBkU4Ax5fuBEOsnE0gcQVU3siKhJvCuy6sqBLO/5gUa1rGKlPLKGgeI+XBCpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwwAV1kH; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-447f05bfdcfso30603661cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721739869; x=1722344669; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MFhZYZKapV7FfjOORUnGM8dDqP6IBmmqJpbPyvGfHeY=;
        b=PwwAV1kHpnJUJmxAISJQiksIvdWTnwR5mhmX/aGfT1yyfSmmpT+DlDZzyh3EHBGtBU
         qjpo2jruYCUVwIs4TuDo9x7MgtYGaoQFH9rRd42BGrBeWQ0zBeVhPAdHN7eBMMCl64CU
         WB/x4YSLbaaaB+cslGuF+iKrx/KEsfvsBsuyl1n/FrQ8AS+tiCJGAxQgXmgEfwCg20dq
         s6TibpocTfBOjttHaeIJoGVXqre86Y6HZ5LCTzB57Fd2r62d939cqhBR4x8tA3pmTxhO
         W+bDDwNGffuuuzvnNhhCSQNsNCi22kqzLZN0qw8M0eFGnZ3+vuQ3J4M/iqqOc1LuYPxE
         /T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721739869; x=1722344669;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MFhZYZKapV7FfjOORUnGM8dDqP6IBmmqJpbPyvGfHeY=;
        b=SZyNqOyWLutE7EvfQdSJKYM+eQPVSxLHFCuHGbuPdlK7etVjIgHPpJiW3cenlS2h9Y
         zHcqX5B9ULNTTl3GsbgG0L/cMWKDR9oGVU1+U+JTRLDrGzsmju2y8t7AXR6qGWmWRbIS
         8fm//Bc0lTFMB4NM6ubtkU8OmaoLg4Bgh3vLqBMyK92vHfnCrR5gLkwG7U3D85DZXQvz
         kK9Dipz1LXNOrAe7D+h+r6ydcb9WrTcptSKHbxdBzeJx+7rIEVVLyu+kXt3Yu5E0V4vx
         66wACTVFESq6A41eZG/0PBb4WSqVnEXNUg6jVFPgcGm6YCYFf8P6D5TtBfcbZwHaKV+s
         mqUQ==
X-Gm-Message-State: AOJu0Yx1QDPbZPgdVraCu2vT8/sINvpxzhejiS8DQLJcU1wI8iJ+4hMS
	Ir4NEIplBPQ/IkZfkbjJ3UnttayRzESlgBXR2XUBOmb6U+gw0AKMjr4TBWFtimGo351iuK2zYv1
	/gLppvGlCM2NgZoY7Qfx0kknDy/cPWksENbQ=
X-Google-Smtp-Source: AGHT+IFWa2yO+vUY47FKQvvr9/I5oxGZqU8Lk0SmgOc/9vTIyj4W/rr+Jd2J6HhzKun9+S+k/fBIoE+AM+pm5wvq2Yc=
X-Received: by 2002:ac8:5d8f:0:b0:447:ed12:77dd with SMTP id
 d75a77b69052e-44fa5352cccmr117102381cf.52.1721739868777; Tue, 23 Jul 2024
 06:04:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Tue, 23 Jul 2024 10:03:52 -0300
Message-ID: <CAM_RzfZWcD8F+6YutbDBo7hGhFm0nbG-Wc0H7bnu4XM03W6_Tg@mail.gmail.com>
Subject: leds: remove led_brightness
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi community, I hope this email finds you well
I maked a change in kernel linux, for fulfill a TODO in
drivers/leds/TODO that say:
>* On/off LEDs should have max_brightness of 1
>* Get rid of enum led_brightness
>
>It is really an integer, as maximum is configurable. Get rid of it, or
>make it into typedef or something.

Then I removed the led_brightness. And in the files that enum
led_brightness was used I replace to "int" ... And in the file
"include/linux/leds.h" I created constants like:
+#define LED_OFF  0
+#define LED_ON   1
+#define LED_HALF 127
+#define LED_FULL 255

because in some files when has a compare like "brightness == LED_OFF"
it will work yet.

The includes/linux/leds.h diff:
-/* This is obsolete/useless. We now support variable maximum brightness. */
-enum led_brightness {
-       LED_OFF         = 0,
-       LED_ON          = 1,
-       LED_HALF        = 127,
-       LED_FULL        = 255,
-};
+// default values for leds brightness
+#define LED_OFF  0
+#define LED_ON   1
+#define LED_HALF 127
+#define LED_FULL 255

 enum led_default_state {
        LEDS_DEFSTATE_OFF       = 0,
@@ -127,15 +125,15 @@ struct led_classdev {
         * that can sleep while setting brightness.
         */
        void            (*brightness_set)(struct led_classdev *led_cdev,
-                                         enum led_brightness brightness);
+                                         int brightness);
        /*
         * Set LED brightness level immediately - it can block the caller for
         * the time required for accessing a LED device register.
         */
        int (*brightness_set_blocking)(struct led_classdev *led_cdev,
-                                      enum led_brightness brightness);
+                                      int brightness);
        /* Get LED brightness level */
-       enum led_brightness (*brightness_get)(struct led_classdev *led_cdev);
+       int (*brightness_get)(struct led_classdev *led_cdev);

        /*
         * Activate hardware accelerated blink, delays are in milliseconds
@@ -486,7 +484,7 @@ int devm_led_trigger_register(struct device *dev,
 void led_trigger_register_simple(const char *name,
                                struct led_trigger **trigger);
 void led_trigger_unregister_simple(struct led_trigger *trigger);
-void led_trigger_event(struct led_trigger *trigger,  enum
led_brightness event);
+void led_trigger_event(struct led_trigger *trigger,  int event);
 void led_trigger_blink(struct led_trigger *trigger, unsigned long delay_on,
                       unsigned long delay_off);



How the kernel has a lot of files that use this led_brightness, the
change is very very big.
I have some questions:

Does my change make sense?

How can I split the change into several patches for sending to
different email lists and still have the split change make sense in
the email lists I'm going to send it to? can I reference the commit in
which I delete the enum?

