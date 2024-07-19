Return-Path: <linux-kernel+bounces-257181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529AE93764D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103D428177F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBEE84A3F;
	Fri, 19 Jul 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/Y1NQGy"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E282C8E;
	Fri, 19 Jul 2024 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383227; cv=none; b=V2ScJrfbiGLHNkCTKV97jYLKgCysedB+1wP1mr3kUgPVkguDDVFS8jV2y2WyhqX7CvCEixF4h5i7Z2foDjAFvE6FqP6kueMQF/1gDSRl9PWWMwuryk1LDjjcbuZ+skudP9TWZB1Q/YKX4RmYCkkQ6hQJZJxsR/TTK6KS5Rp7+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383227; c=relaxed/simple;
	bh=tOlxHwQ/cxv4ssytG73xQR6ESc32vxoYe4hIBqmuyGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjrcfXXv7dw9szJJUhpBGYLTiL8XisnAuuygk7YEG6Y2WA1fG3jIVdgtp/8KH6ifjZHLl/iLrAWjrq3WBI3XWPI1E7I/NZiti4bKHyEyv9t2Fi6xOJsViS+wiEgN5Ka2z5B1JYB7SoGmmyGPodpKqWigbVhsImvM3mtHkkT6bbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/Y1NQGy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-427b4c621b9so9539485e9.1;
        Fri, 19 Jul 2024 03:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721383224; x=1721988024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiIkuYnUkLq/OuiwZsBYHekuAUatgI2Jk8Ly4F7sODI=;
        b=E/Y1NQGySBoqBFIpXlMIJH3z/wC3Rhe00idA1Z2E6zBjzQtwUCN80W/sQMguX2I5Yo
         yO0Onf+0nVeYtsFdL2JUJ4a8dpiqtdinlRulwQano5mlDTd2+48gj8Hm5aJMEoWyHhWr
         O2Qc1bXvq3wyPBVEHdnEOftQvTdbagjWRonuudf3+KAZRuFfLNbr6rYFaM5Y9Rezm7XY
         pxaI+Uv2TFiTpmglR/XuuXxXrWmkfUFfSjoXxoc6VbNvfaXJygyaCwSKF6Zg/DcSxlH6
         JhjpRo1sD0GCEW0yu6T4QsWHDHFzMWB1fWZXGbi/5fUcd6vFOpGiXrHuY2ne7VtDhd7s
         L2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721383224; x=1721988024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiIkuYnUkLq/OuiwZsBYHekuAUatgI2Jk8Ly4F7sODI=;
        b=rLHTjdYbm4Hvhydgkvnv6KL9/FqM2VEyri48QMcjItQz2twMOCWdXPkLZadCs98D6Z
         BkBXJ4M4DXbBHH0xXkEWuF1/8Tsgq+jA3Kor+54AvAQVwm1eK5XqFQD1RZ1Sijn5z3Oj
         euME1oyrHayRwL3l0IhrRZyM8cbzSQet+0Z9jUzmQ6UdGt1XJPtZqjyPjSoUR4U8+8wj
         OoEpj3lWzqp7Z3lzPS9VCauE62yTvgZfikvA9vHfGOIpZU/mIi8UfP66W4O16tSTSM3S
         do3j/wSuRcZ6mx2FKkmc0ZoIn3hfmrFpIl0QySSU/UmM8qLzffx2MsUrvuiDcDvI3saB
         YkVA==
X-Forwarded-Encrypted: i=1; AJvYcCWRk/8o6ADo6kQLx3p255mpec/kJP+4uFqVA3LQfQkNHi/nS8siZLVf/YrZqwZORJAzORJRNgPiQequqjqpAUQXZst4MX8ILNYjCQcN5qd0QDbTTtL5d6ulXJJi7lGuh+gInuW7YP+RxAu+P7BYIErb2Q==
X-Gm-Message-State: AOJu0Yz06NIgy5T8dKe60+sUWXI061U56kIXwwQc/a25H3MZDu92S+OB
	xkkvZWlsZ144nlbVeSGPb/MLwrey/+gdmCxfG0KaJH9qAcgEVPQe
X-Google-Smtp-Source: AGHT+IH96iI184CIWCTZyAJaRLPCmvSLkilS8LZhgnyd77NRXPCcA1mmirLwA/wFrzeXmbMsXor9GA==
X-Received: by 2002:a05:6000:154e:b0:368:7883:d14a with SMTP id ffacd0b85a97d-3687883d2e0mr1409150f8f.33.1721383223876;
        Fri, 19 Jul 2024 03:00:23 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:ed72:2800:17de:b512:9f9e:464b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ec979sm1134359f8f.94.2024.07.19.03.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 03:00:23 -0700 (PDT)
From: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: mustafa.eskieksi@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
Subject: [PATCH v4 2/2] HP: wmi: Add documentation for the LED API naming scheme
Date: Fri, 19 Jul 2024 10:59:46 +0100
Message-ID: <20240719100011.16656-3-carlosmiguelferreira.2003@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240719100011.16656-1-carlosmiguelferreira.2003@gmail.com>
References: <20240719100011.16656-1-carlosmiguelferreira.2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds documentation for the LED API class-device naming
scheme practice.

Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
---
 Documentation/leds/leds-class.rst | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/leds/leds-class.rst b/Documentation/leds/leds-class.rst
index 5db620ed27aa..8e74a436ca9b 100644
--- a/Documentation/leds/leds-class.rst
+++ b/Documentation/leds/leds-class.rst
@@ -116,6 +116,46 @@ above leaves scope for further attributes should they be needed. If sections
 of the name don't apply, just leave that section blank.
 
 
+Keyboard backlight control
+==========================
+
+For backlit keyboards with a single brightness / color settings a
+single (multicolor) LED device should be used to allow userspace
+to change the backlight brightness (and if possible the color).
+This LED device must have a name ending in ':kbd_backlight'.
+
+For RGB backlit keyboards with multiple control zones, one multicolor
+LED device should be used per zone. These LED devices' name
+must follow the following form:
+
+	"<devicename>:rgb:kbd_zoned_backlight-<zone_name>"
+
+and <devicename> must be the same for all zones of the same keyboard.
+
+Where possible <zone_name> should be a value already used by other
+zoned keyboards with a similar or identical zone layout, e.g.:
+
+<devicename>:rgb:kbd_zoned_backlight-right
+<devicename>:rgb:kbd_zoned_backlight-middle
+<devicename>:rgb:kbd_zoned_backlight-left
+<devicename>:rgb:kbd_zoned_backlight-corners
+<devicename>:rgb:kbd_zoned_backlight-wasd
+
+or:
+
+<devicename>:rgb:kbd_zoned_backlight-main
+<devicename>:rgb:kbd_zoned_backlight-cursor
+<devicename>:rgb:kbd_zoned_backlight-numpad
+<devicename>:rgb:kbd_zoned_backlight-corners
+<devicename>:rgb:kbd_zoned_backlight-wasd
+
+Note that this is intended for keyboards with a limited number of zones,
+keyboards with per key addressable backlighting must not use LED
+class devices since the sysfs API is not suitable for rapidly change
+multiple LEDs in one "commit" as is necessary to do animations /
+special effects on such keyboards.
+
+
 Brightness setting API
 ======================
 
-- 
2.45.2


