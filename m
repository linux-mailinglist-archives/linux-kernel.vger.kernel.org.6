Return-Path: <linux-kernel+bounces-276823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E851E9498D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17EE285071
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A0F13A26F;
	Tue,  6 Aug 2024 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gtN6Zawz"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5EB7580A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722974941; cv=none; b=K2bkZ1layuF3IwmyqXEq26gqVIQs/lliquaDKTXZeaCkUAKPUx/uaZwCUc1LRq1RTkcR6VBehDGryinekc2VcYsT4Iad5tWR4Tb8g2Q0hhRjkYAyCfsetpVriMQParAYeEqDTljnEmtyZakEmpC2RqWZWpKdxKeTOw9bpnfHSMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722974941; c=relaxed/simple;
	bh=HA5MIyAq3K4wBmGAXx7kvjvMbEMdBSz1eDV3WE70Kl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NLlJDmQ5fmNYbdl9DAwgoL2rDzWI5cR9/Q+eLu8kQEz6o49o2+nNwcavXHMYbPIYJIA2GPJVwoDh4K99kSB/oxEAR7uMrwJanNDcW8fyIBedtqpAkrW6qBpogwoneMGbw0F/AncvrLEFwPJchVVY+Z0ynR5BFeOhedRcqpOPMbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gtN6Zawz; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-49299323d71so425885137.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 13:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722974939; x=1723579739; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XUkvCg+RsxL9ebqULPF0t5iB+5m6NBdGn9KgAoU3S/s=;
        b=gtN6Zawza9ctKvg+NnhdNddtUaqWEkLLosr4TQ7xrkIAOfflDczAsDlanvY7d9FArr
         SOEyHaAooajef5EIyVXrts0hxKjKztc2ZTcmR1KsfIr0N/lpJDW3CUhJfH3Qi+xivUVE
         //jVnRzzBrTXfmBzi/pVcNxTkFJVvXe6o6J+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722974939; x=1723579739;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUkvCg+RsxL9ebqULPF0t5iB+5m6NBdGn9KgAoU3S/s=;
        b=fZHH8lqLvVogehyeuURBcvTr32gkrlN3PLx1uDmY/JNipC8WNp76Pnh5NlHcbLpKvW
         shUN1V282YKdaRYDa2sr6drFdiF5OEQrT1gmHlwoMQCIi2soqCr7Kc+nDzYwjUVjb8LY
         tMzh1XVkSD2Q6YTcj7+3oeqrDzIw2ZyT2PhQA4Bu4hQfos4QYLZHlyiydY7LSq3U6k6H
         HuJPEFg+MwtNXFQIbwCQ075Y6fHqLuPLCePrmRqd71zs8KeGt5XKH0FiuV7AXt6Q0oWy
         TUY1k3ex2dtulwzD29Qqihp6Y9Q3O0s0S1rbyN4gtvzVqydYkEr+vd2wthl1lQTtDbWf
         R+zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpQ4F9Prf/1ij0XdqxiiynJxvds/Rl/EfChzSGnA/rTSs/IC4mHio0QXxlYM5dcy0I3xBBroI+Z5aWHCiM6KqEGS42x8PaTdFqwBnw
X-Gm-Message-State: AOJu0YzyS0zENZAfaw8+dxdUaBSXj/LFwgzqRU9CWgT+jk1g0JQ2jVL0
	UYyLEw5OJn15/eysFv4H6mqO9Mb042O/wgE4CJVIjLqgCp9iLP/K2qtDZZlK7A==
X-Google-Smtp-Source: AGHT+IFfSWZW6P76X9v61/mj/6S3tRRSFE21DqG896oRSD41MC2S4TF4vbAu8H9XY+BIhrwTHBOFVQ==
X-Received: by 2002:a05:6102:3049:b0:493:ddd1:d7fc with SMTP id ada2fe7eead31-4945bdf7cf9mr20304623137.11.1722974939132;
        Tue, 06 Aug 2024 13:08:59 -0700 (PDT)
Received: from spinny.c.googlers.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4945da8b74asm1830562137.7.2024.08.06.13.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 13:08:58 -0700 (PDT)
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Tue, 06 Aug 2024 20:08:47 +0000
Subject: [PATCH] acpi video: force native for Apple MacbookPro9,2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-acpi-video-quirk-v1-1-369d8f7abc59@chromium.org>
X-B4-Tracking: v=1; b=H4sIAM6CsmYC/x3MywqAIBBA0V+RWTcwSvT6lWgROtYQ9FCSIPz3p
 OVZ3PtC5CAcYVAvBE4S5dgLdKXArvO+MIorBkOmpo4anO0pmMTxgdctYUOvbe9Je2pdDyU7A3t
 5/uU45fwBlAHqomIAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Esther Shimanovich <eshimanovich@chromium.org>
X-Mailer: b4 0.13.0

It used to be that the MacbookPro9,2 used its native intel backlight
device until the following commit was introduced:
commit b1d36e73cc1c ("drm/i915: Don't register backlight when another
backlight should be used (v2)")
This commit forced this model to use its firmware acpi_video backlight
device instead.

That worked fine until an additional commit was added:
commit 92714006eb4d ("drm/i915/backlight: Do not bump min brightness
to max on enable")
That commit uncovered a bug in the MacbookPro 9,2's acpi_video
backlight firmware; the backlight does not come back up after resume.

Add DMI quirk to select the working native intel interface instead
so that the backlight successfully comes back up after resume.

Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index c11cbe5b6eaa..2d377414f873 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -547,6 +547,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir9,1"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple MacBook Pro 9,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro9,2"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,

---
base-commit: d9ef02e56f0fd3668b6d7cb17f9399ea53f12edd
change-id: 20240806-acpi-video-quirk-f1c9f01f07d9

Best regards,
-- 
Esther Shimanovich <eshimanovich@chromium.org>


