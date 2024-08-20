Return-Path: <linux-kernel+bounces-294269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE068958B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318041F2288D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D0F1940B0;
	Tue, 20 Aug 2024 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tbm1oyua"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5874E125D5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168343; cv=none; b=NIVNTu2f94gG+a7tQd47UBAKuYVeNorw/FKgiOe6lv/cGWchVetMAQtog3crHLYKa6WiLNLpDBv9vg1iEeD81joTSh8ZSz9C52B5OQUwLIgL+3G348ax4EuZD4m4VYBOkidb8e5BcPExb1PnBIXEi4cdsdLIifvpd+r7yxlz5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168343; c=relaxed/simple;
	bh=3F3rVSXCrKAuNTX6oBs3ahXRw610MZ40UBdmnu7Vx+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGavJmjK02P5kdIxooQ20cyvyl2yKOHZHTjerUYDdDlPSPUNFmdM2dR49eqQUpakj66fQIh14Fj4+Jo7SdcxXNLpoYAnK85xdOaRDLLRHGSe1LG9gkneK9n89q+7466WBEPpnv3uB3dS0QRIwoyAMscBBi/LUlROAoTegBjDx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tbm1oyua; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso46802305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724168338; x=1724773138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmWrqfFuhQb126F6VuYJoB91tyorexZYrj4qScm7E4o=;
        b=tbm1oyuaZe4q83S47IUWMq/Ny4SU8cFH3j5uIv86kQZwCjr3UW8Q+v5NntMms8IRKk
         khadXoNeLHkciV0AosDOKSGtSte14vH+/9P8Ma0EcGx0Ofn7hPgv6ri3C5h5Re0KnNcc
         aHi9ypkyTZj1bQYQLrgwIvIjMiLG2M+u73F3H/1hVftyvBjI/9jeKtUa9HYssP2d6cSu
         YPmx6j8PlB61eXn/jAJlI6SoO9+1LN/4YWfyFD5RQsxYMftF2QvGekX9uPgRQ/TGGitf
         07WEJgjUKM3dbKClOhSnK3IdL46ZIQfMbq0Hfw9XZIwWXjLANimXUufs32qBWHN3XPkK
         /+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724168338; x=1724773138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmWrqfFuhQb126F6VuYJoB91tyorexZYrj4qScm7E4o=;
        b=cn9MNszN45+KxRhWD/fsJcXrp0JWSXgqmZmvHav9YBu6pM2CvRFtE6DBlVSM0sm3YR
         dleT0b/Z1nsTL29fC1FmgldJQjcR3SZhSekJs1wu8gtqpMjGC5Vj33nYEKNbpZ8RgM52
         rRCUHEzUpAhC7yq1wCatXf53EKiztUqcKY4ymWPwbQHeVAoeY8+71Y0dZpdxCBMVtwoX
         gkNRGWflNlot1GLdhjI+M/Ookhif/+W3xkF37/KM/pBYftWafobL2jX6fBw0kj1E9A6u
         L3wgsA+NeG4NwzNQYaKtyLkg8vzUSfXwpVs7RZAT5clNjMZtPnCXueg8BMH+Xzid2GGt
         CBRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvhzn1PYuJ6+4MyXpZnOPEjwxWN+C9X/+4x85P7WTStEJb+Lgniw9laFaMJO9ObcJoy16RNxlHl3AOBOEXT5Cg0DhdCeKDEOhcypvM
X-Gm-Message-State: AOJu0YyWviZNrY/vRU0HTO60Cjq/Weno43apcXoD8gSuGAgy2bxyC0fO
	zJic9yrsEYhMbsMl3i+GS8F8hfLLpzdXibY6P5NDpohVk6va5iVxm8QPUSh5WME=
X-Google-Smtp-Source: AGHT+IGWX7+eVKrGz832pmkLmKocdhlrcgIWlJERL2tWpVpaUuEH1ET2w4rlxwsOimDYeiDWDcI3yQ==
X-Received: by 2002:a05:600c:138f:b0:428:2502:75b5 with SMTP id 5b1f17b1804b1-429ed7ba9c0mr92827645e9.11.1724168337929;
        Tue, 20 Aug 2024 08:38:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ddce:8248:19a9:4bf6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed648f4asm146289025e9.5.2024.08.20.08.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:38:57 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] Documentation: add a driver API doc for the power sequencing subsystem
Date: Tue, 20 Aug 2024 17:38:55 +0200
Message-ID: <20240820153855.75412-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Describe what the subsystem does, how the consumers and providers work
and add API reference generated from kerneldocs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/driver-api/index.rst  |  1 +
 Documentation/driver-api/pwrseq.rst | 98 +++++++++++++++++++++++++++++
 MAINTAINERS                         |  1 +
 3 files changed, 100 insertions(+)
 create mode 100644 Documentation/driver-api/pwrseq.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index f10decc2c14b..7f83e05769b4 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -124,6 +124,7 @@ Subsystem-specific APIs
    pps
    ptp
    pwm
+   pwrseq
    regulator
    reset
    rfkill
diff --git a/Documentation/driver-api/pwrseq.rst b/Documentation/driver-api/pwrseq.rst
new file mode 100644
index 000000000000..bf82469fcd38
--- /dev/null
+++ b/Documentation/driver-api/pwrseq.rst
@@ -0,0 +1,98 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright 2024 Linaro Ltd.
+
+====================
+Power Sequencing API
+====================
+
+:Author: Bartosz Golaszewski
+
+Introduction
+============
+
+This framework is designed to abstract complex power-up sequences that are
+shared between multiple logical devices in the linux kernel.
+
+The intention is to allow consumers to obtain a power sequencing handle
+exposed by the power sequence provider and delegate the actual requesting and
+control of the underlying resources as well as to allow the provider to
+mitigate any potential conflicts between multiple users behind the scenes.
+
+Glossary
+--------
+
+The power sequencing API uses a number of terms specific to the subsystem:
+
+Unit
+
+    A unit is a discreet chunk of a power sequence. For instance one unit may
+    enable a set of regulators, another may enable a specific GPIO. Units can
+    define dependencies in the form of other units that must be enabled before
+    it itself can be.
+
+Target
+
+    A target is a set of units (composed of the "final" unit and its
+    dependencies) that a consumer selects by its name when requesting a handle
+    to the power sequencer. Via the dependency system, multiple targets may
+    share the same parts of a power sequence but ignore parts that are
+    irrelevant.
+
+Descriptor
+
+    A handle passed by the pwrseq core to every consumer that serves as the
+    entry point to the provider layer. It ensures coherence between different
+    users and keeps reference counting consistent.
+
+Consumer interface
+==================
+
+The consumer API is aimed to be as simple as possible. The driver interested in
+getting a descriptor from the power sequencer should call :c:func:`pwrseq_get()`
+and specify the name of the target it wants to reach in the sequence after
+calling :c:func:`pwrseq_power_up()`. The descriptor can be released by calling
+:c:func:`pwrseq_put()` and the consumer can request the powering down of its
+target with :c:func:`pwrseq_power_off()`. Note that there is no guarantee that
+:c:func:`pwrseq_power_off()` will have any effect as there may be multiple users
+of the underlying resources who may keep them active.
+
+Provider interface
+==================
+
+The provider API is admittedly not nearly as straightforward as the one for
+consumers but it makes up for it in flexibility.
+
+Each provider can logically split the power-up sequence into descrete chunks
+(units) and define their dependencies. They can then expose named targets that
+consumers may use as the final point in the sequence that they wish to reach.
+
+To that end the providers fill out a set of configuration structures and
+register with the pwrseq subsystem by calling :c:func:`pwrseq_device_register`.
+
+Dynamic consumer matching
+-------------------------
+
+The main difference between pwrseq and other linux kernel providers is the
+mechanism for dynamic matching of consumers and providers. Every power sequence
+provider driver must implement the `match()` callback and pass it to the pwrseq
+core when registering with the subsystems.
+
+When a client requests a sequencer handle, the core will call this callback for
+every registered provider and let it flexibly figure out whether the proposed
+client device is indeed its consumer. For example: if the provider binds to the
+device-tree node representing a power management unit of a chipset and the
+consumer driver controls one of its modules, the provider driver may parse the
+relevant regulator supply properties in device tree and see if they lead from
+the PMU to the consumer.
+
+API reference
+=============
+
+.. kernel-doc:: include/linux/pwrseq/consumer.h
+   :internal:
+
+.. kernel-doc:: include/linux/pwrseq/provider.h
+   :internal:
+
+.. kernel-doc:: drivers/power/sequencing/core.c
+   :export:
diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..5a7500f048bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18204,6 +18204,7 @@ M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
+F:	Documentation/driver-api/pwrseq.rst
 F:	drivers/power/sequencing/
 F:	include/linux/pwrseq/
 
-- 
2.43.0


