Return-Path: <linux-kernel+bounces-383228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FD29B18B5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 16:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0D81F21DA4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041F1CF9B;
	Sat, 26 Oct 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="Bgr+Ftoq"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB9AD24
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729954097; cv=none; b=ud+53rTZ2eDN6A/UgIcdjC8gMg3XMJyohUZ+6lIPUnEkxoRaknO2susFLbdVjotnb1g/njjlgz+Biy5U9mOV8PmcvMAOP90D1jewk/admvRvuLwX8NcwyH08/TqWOmOl1ByxZH2p3M+XIKB8V1GLAQamFiRmqOvWRWRoHyt910k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729954097; c=relaxed/simple;
	bh=MWxPZ0rd0vQSSGb1OYfWrjEcHEmLMZBNRKOr3PUqu1U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=el5umYNOnRC9bJ4I/SMNqY+Z2E1Yzs/KlIJpz7UhYGV3wb4BhGCrJZel/ir/cj9KJjAsxGi6LdUCwM3LTWx/DIkXhCffPJH1C8y51nC4DlTmvee70b7QctZGuFFu1t05tcr3JRFf2+eH3YrhZDr2agKMATak1p1F3T/XfIVxGmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=Bgr+Ftoq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so3757419a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1729954093; x=1730558893; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qC024lRJVAEmIHLuN+s83Hm+ef/1j+PPbHp473apDbA=;
        b=Bgr+FtoqNJnerTcO0wKkFHUGafd7/GJWb5Llvrz6rxduM3NbqZeqp/1Ln/YB/D7kSo
         76MWFU9Qf40cfaT0Ge1wbbjUpLYViTrkdXERKh2BfnTp00umUlarme+RZFiIOXLkJ2Ya
         9sjNiHBwqgQ+o4AFIDnvM37XpLeB+G/outCvghWxrS3wSwY9HZzkhBBkBpMXHvgGe1Rc
         oHGa38A+csgmP381YPbk76LwCBsQ4mHGeWjtkSYBiYPVcLu3IupjNEfziKDxV186n6/Q
         6PwQoVEwrSSyBf6JyRMecu4K7M2G8dWYwhgt+IpHp7oaXTPCBvB1AxrjWiPimLx4fnTl
         kkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729954093; x=1730558893;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qC024lRJVAEmIHLuN+s83Hm+ef/1j+PPbHp473apDbA=;
        b=ZbhXePPKljiRBQJ9l8Qa+NkVvbadSJlGqMbRMcsWfB+oslTbqXu7CsXzGMAIRmjU0q
         8tsNSdFFLHN0MoiC/QAkOdOcZuEq9JG3HOUrWCifR9zo+JlH4s1JhKN/0uatId6kSUkO
         ff45fC/X2P2uHHAH685evaBGQOLNwHFI8LyypojNRqcCWA+WBpMkGHansfTIP6sRPmEl
         dsCg7TfqOQZ41zLAASN7xu+w4//7vb2YqMc26r67eEB8piZr2ZwSueW94gFS38HgmcVx
         +qJndzzijicW78FghHBbbymKsgtPRjjrKUZKR7BEdRJIyJD6BsK9cG/VXCdHyyFrTct0
         rlag==
X-Forwarded-Encrypted: i=1; AJvYcCUNBCsK4M1ZHTjMvFPf8OT29NKBsbPvYCr1nrxfd21KAvbOgmbGC81+X8a5YHdE90FYKWqG+vTjEvY2cEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+Kf2EITjLVlOeMoHi4TUufyHnQhrPDcl/5hmnWa/HbRoyY5D
	eyRb6npOnq08JBWpXsbyjmk840R+DaizkHkPtbaucFJzstz06PaG+Atd+gM/8aAZDJMu8wHHlm4
	6UtRK7n8IitaTYpShfdZO5rNz3gNmElLzXOLv+Hf+Avh+CM6gWzi3jJC+psacE3XPCP0MTLbfaR
	9ec4l4WUWfFIbymFMrZbglHOxDvG4=
X-Google-Smtp-Source: AGHT+IG4PpxrQduHWvKVj7/srrfd0iKQ4sb0Q12T19VO7aaWAAlCMAAaNmGu/B9Jn4rtQnFNhOISWA==
X-Received: by 2002:a05:6402:1d50:b0:5c8:9548:f28b with SMTP id 4fb4d7f45d1cf-5cbbf8a6813mr2154556a12.11.1729954093244;
        Sat, 26 Oct 2024 07:48:13 -0700 (PDT)
Received: from admins-Air ([2a02:810d:aec0:2a54:158c:1efa:f963:7401])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb62c42c7sm1586799a12.51.2024.10.26.07.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 07:48:12 -0700 (PDT)
Date: Sat, 26 Oct 2024 16:48:10 +0200
From: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
To: pavel@ucw.cz, lee@kernel.org, corbet@lwn.net,
	linux-leds@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] Documentation:leds: Add leds-st1202.rst
Message-ID: <Zx0BKtXo55D_pCGk@admins-Air>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add usage for sysfs hw_pattern entry for leds-st1202 

Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
---
 Documentation/leds/leds-st1202.rst | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/leds/leds-st1202.rst

diff --git a/Documentation/leds/leds-st1202.rst b/Documentation/leds/leds-st1202.rst
new file mode 100644
index 000000000000..72286a512c69
--- /dev/null
+++ b/Documentation/leds/leds-st1202.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================
+Kernel driver for STMicroelectronics LED1202
+============================================
+
+/sys/class/leds/<led>/hw_pattern
+--------------------------------
+
+Specify a hardware pattern for the ST1202 LED. The LED
+controller, implements 12 low-side current generators
+with independent dimming control. Internal volatile memory
+allows the user to store up to 8 different patterns.
+Each pattern is a particular output configuration in terms
+of PWM duty-cycle and duration (ms).
+
+To be compatible with the hardware pattern
+format, maximum 8 tuples of brightness (PWM) and duration must
+be written to hw_pattern.
+
+- Min pattern duration: 22 ms
+- Max pattern duration: 5660 ms
+
+The format of the hardware pattern values should be:
+"brightness duration brightness duration ..."
+
+/sys/class/leds/<led>/repeat
+----------------------------
+
+Specify a pattern repeat number, which is common for all channels.
+Default is 1, other negative numbers and number 0 are invalid.
+
+This file will always return the originally written repeat number.
+
+When the 255 value is written to it, all patterns will repeat
+indefinitely.
-- 
2.39.3 (Apple Git-145)


