Return-Path: <linux-kernel+bounces-369160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED6C9A1992
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6358B288BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59D313B58C;
	Thu, 17 Oct 2024 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tldWFWjm"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B3213AA4E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729137591; cv=none; b=DzSK7vBumZLRZ8Y1t01sSM/L13jlynuq44WNYSDeDIhpxDCGDEp0JL4xOyfMAH3UmV0qC0e6xWvFOHfQeCuHhPf5Yyl6tOCkbTuPElQXs2wjdiFrjaqecVPpArmPre8lP5m2+zmGCLlIjsnWKnL5SpXR2ZXtb9aG04tyJWf6ByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729137591; c=relaxed/simple;
	bh=lwQbaNOegyMOvN5drTipZFuQYCvB1JIapRyY8eQtWow=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qf/p+RxW0t5JarC28BqjmHrXPg/hst7w+uJXJab02bLhpdygqe/3RFns6EnxSV/InRmLi+dwcT6sa5Ew8Ww8dGS9lA8SkWo2v3t7dncEvIrjyBgAvMAnexrV7bzrfpCQ2Pa7eatyn+nR5hOTyqrXd09DspX4AFRPy/WPBhlu2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--payamm.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tldWFWjm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--payamm.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35199eb2bso10632747b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729137588; x=1729742388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rn57h/Z9euT7CjXdZC6FH0+XKPxh/r1i9c2H7ox3Ihg=;
        b=tldWFWjmbWjF2LEE71mQT7eEA8zKBss/h77KjHuQOnuZsXdd8YgO1L6I0D9ZLEnYY+
         tmr4cHDzdnKHhSeGbFZ/gKmX8aceiFzrU++wd3Fb0pxTCNBpE0wCqDCel4+Ha8lXr/GF
         aJWrxtuWchxqylRI+rZ81Vh8cAejFGysO6M+8wBiaAymx4/1Gbbhqd1lUKlR/17/o1Rd
         rHyWFJWtxqIg1JISWru07zCTjPi2idkDCdBonq1CrXG78xljlGpZqC17fGjTuuvkw4gX
         YvxcckdyvyMuMJFNbXmFheU+0DD3JiL4ppZMkEoyG7aToCW2fOMzAwO0DHxfbgTc54BH
         6ztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729137588; x=1729742388;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rn57h/Z9euT7CjXdZC6FH0+XKPxh/r1i9c2H7ox3Ihg=;
        b=Um7O7cOgzVZZUaqn11dHw980WtgKXO/SMqfrb/oL1VYuNJ3a13lJppl5g2jF3PeUe3
         m7lalSpS46YzBMSM2uXNNdaEwcGsK6y3Oo890UFqSk0DQ4TjDseXFDts1RAHwOeyCenZ
         jb/O2UFgMs5OSPPHC+9ZxLcI5CzRnxcVl9gfnkuVPgQikXxscLUlhycLnIghHg6Ny1M8
         0KNeJd3bHyJ/HowuAR4JViHJzB16mZMjE4j+RRRVC+jO9IN91pRxxBO0gAlcqYe4WAdT
         H07XFDuBp0Sypx0QQRKN8xUi3KMvI1KGLAvw/FnOpSNPM7uhue6jrYvqrObukvMnfXaF
         oCjA==
X-Forwarded-Encrypted: i=1; AJvYcCUQAQTgESrL2rGB1ArtugdRdbMImONZDSC75YOstoQVminN+ZsXBxZ/b57SnRtbevfKC2MWgBWh48IqaHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqrQit2Na5hejMN5FH2oDwQbYgXZMn0VC0DDcg/O8D5ohyvfVM
	EFoOzQ/ieUtZlZ1HW35vqYy5grt+0STzo/Pc92huxbG6oGpyJe2etkshA/c+1V+LPH9LHhzCTEL
	8Sw==
X-Google-Smtp-Source: AGHT+IGpV3AhUhHi9z/xru6WW/aDXLeVgTNJbaKCTWNDG/EMBeliw4xUO/FS19voj9mJuqDjFiK0z0ouoRc=
X-Received: from payamm.svl.corp.google.com ([2620:15c:2c3:11:e5a7:e66d:af5f:9fe3])
 (user=payamm job=sendgmr) by 2002:a05:690c:6a08:b0:6e2:b263:103f with SMTP id
 00721157ae682-6e3d3be9258mr1536467b3.0.1729137588592; Wed, 16 Oct 2024
 20:59:48 -0700 (PDT)
Date: Wed, 16 Oct 2024 20:59:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017035940.4067922-1-payamm@google.com>
Subject: [PATCH] acpi: zero-initialize acpi_object union structure
From: Payam Moradshahi <payamm@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Payam Moradshahi <payamm@google.com>
Content-Type: text/plain; charset="UTF-8"

The way in which acpi_object union is being initialized varies based on
compiler type, version and flags used. Some will zero-initialize the
entire union structure and some will only initialize the first N-bytes
of the union structure. This could lead to uninitialized union members.

This bug was confirmed by observing non-zero value for object->processor
structure variables.

non-zero initialized members of acpi_object union structure causes
incorrect error reporting by the driver.

If a BIOS is using "Device" statement as opposed to "Processor"
statement, object variable may contain uninitialized members causing the
driver to report "Invalid PBLK length" incorrectly.

Using memset to zero-initialize the union structure fixes this issue and
also removes the dependency of this function on compiler versions and
flags being used.

Tested: Tested on ARM64 hardware that was printing this error and
confirmed the prints were gone.

Also confirmed this does not cause regression on ARM64 and X86
machines.

Signed-off-by: Payam Moradshahi <payamm@google.com>
---
 drivers/acpi/acpi_processor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7cf6101cb4c73..6696ad4937d21 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -275,7 +275,7 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr,
 
 static int acpi_processor_get_info(struct acpi_device *device)
 {
-	union acpi_object object = { 0 };
+	union acpi_object object;
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 	struct acpi_processor *pr = acpi_driver_data(device);
 	int device_declaration = 0;
@@ -284,6 +284,8 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	unsigned long long value;
 	int ret;
 
+	memset(&object, 0, sizeof(union acpi_object));
+
 	acpi_processor_errata();
 
 	/*
-- 
2.47.0.rc1.288.g06298d1525-goog


