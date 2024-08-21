Return-Path: <linux-kernel+bounces-295314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09756959997
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B560B283B68
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D3F20DB6E;
	Wed, 21 Aug 2024 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="acjE0Evw"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5A720DB6C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234906; cv=none; b=tp+J21VBvGDJu3uhaTL5esNrMhRwoUXDqlZJqK4I2IYg6/iP0soEzz6bEunlHbbIvuLOzlSjAIBE/PmAwVToq2u0Efr0MEEMeT4wbJ5WW3JemCHmP1agjIQEmYeZSXY1hYyfAmcwkG1uzqIvCQe/CWbWX3p+BuB548K3hVviNfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234906; c=relaxed/simple;
	bh=e/cSTFrVwMB05MYJMAq6GAYYFmQpuxJbbbVHPAj6IrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pxs+ymIK02w4syzBQ+1YQ0o9jiTo8sLZ6ixLMvztDt+90nNKHo0wr0ktKJn0SmGUicapw0sWmBjHy+jILBhuXW0ZV9DZXF4jhzbNoNl54UeBBfgJ1A8Bx4N5g6N5BJMCYTwrUm6xw13x80d1cCgMljWvnnc+yPa/htxf8H9gVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=acjE0Evw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4281c164408so51659195e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724234902; x=1724839702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUeIsnerQaorjXQFndw9qkOG9GKtYwp+MnhzTNyNwl4=;
        b=acjE0EvwzM5+1yxYQTd84dpl4lpXPpSEyzqcZ0snBm0CPTCV5NrVqJTydwsMI4FJuQ
         f84oWYL1j4oqv4fUpoWo0ancM22tgxMHW2+esUH00ARQ5a5SWTH1iVb/Tu+Ax4AYU+Sg
         tJezid5O5YQQe3VaEDjdsnpJe3kadjVlUX4WEugZzGxcKEn7lmWM+SDpVU6cz5KrTniR
         mvlJNg3dZSNlRlmib9MgeGEWUN4wVURAlfqkz8ooJ3qcjnGApmvXTCs91FYFFbclyyAs
         3eHEhVMvItPTVlYHTV0dULqa8cmBK/F0/b6bjUGRaN8isb/qzPY3UrXzzRLyrxJ9LCof
         dQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724234902; x=1724839702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUeIsnerQaorjXQFndw9qkOG9GKtYwp+MnhzTNyNwl4=;
        b=f9kD3+54abkqD4/jBDxrhgqa5co9cAajq6hhC/6GqJF9sVPYUek2emoOKz8B/Zgs3s
         It094cMAVQXuMUguNZ21iLoql2R1+boRziHUC6cPjimg6VdOv5KBkcBm5/60VvRYrwUR
         9SHDvMRh8Uwf/yhqEdCkdTQFNSEkxy8u78C4LX8tp70ho4VgEXgPrmm7FdhMxpwDaDaO
         dMZ6Zk0MpJIY/6yl3JPWhCz3vbqm9Dk+bMvqHhPCaLeZMKqwuPsJmvpfey3xTxrAA/+i
         zeG6UlXzVe74qDqXOxYLSoIn2AMb45d3qS9JO1hp9mae2xa7fi4mJTwnklt+HVVUHe2s
         TZXw==
X-Forwarded-Encrypted: i=1; AJvYcCV4b2i5laHd1mYDKXemjBX9sJ9h9tMJZtSSgxj/ehPPuyOeIyXOG1JtHDaSKzPHxA0QL5vt8jF/6nZ1pbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHctdpliUXf7iXZ8ledx7jyqG7icIXXaoSJTf+z+8Pvg5Lekq
	iODSVjqVFMID35psXGnv2ROjM89N22OKISPz0m+wj9WjkpoT776CDEqljo/NFqA=
X-Google-Smtp-Source: AGHT+IFhpK1sg/ss/0bIG2NwKsTNlLwTZWTvRAOXwus/YZwPLyDrzYlLym6NHPi/7TO58UNUO/Wduw==
X-Received: by 2002:a5d:4e45:0:b0:371:8e3c:59 with SMTP id ffacd0b85a97d-372fd5ba7a9mr992553f8f.5.1724234900998;
        Wed, 21 Aug 2024 03:08:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:42a6:b34f:6c18:3851])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefc626fsm20071325e9.31.2024.08.21.03.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 03:08:20 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] Documentation: add a driver API doc for the power sequencing subsystem
Date: Wed, 21 Aug 2024 12:08:18 +0200
Message-ID: <20240821100818.13763-1-brgl@bgdev.pl>
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
Changes since v1:
- drop unneeded :c:func: directives
- don't include linux/pwrseq/consumer.h as there are no kerneldocs in it
  which results in a sphinx warning

 Documentation/driver-api/index.rst  |  1 +
 Documentation/driver-api/pwrseq.rst | 95 +++++++++++++++++++++++++++++
 MAINTAINERS                         |  1 +
 3 files changed, 97 insertions(+)
 create mode 100644 Documentation/driver-api/pwrseq.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index f10decc2c14b6..7f83e05769b4a 100644
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
index 0000000000000..a644084ded17a
--- /dev/null
+++ b/Documentation/driver-api/pwrseq.rst
@@ -0,0 +1,95 @@
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
+getting a descriptor from the power sequencer should call pwrseq_get() and
+specify the name of the target it wants to reach in the sequence after calling
+pwrseq_power_up(). The descriptor can be released by calling pwrseq_put() and
+the consumer can request the powering down of its target with
+pwrseq_power_off(). Note that there is no guarantee that pwrseq_power_off()
+will have any effect as there may be multiple users of the underlying resources
+who may keep them active.
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
+register with the pwrseq subsystem by calling pwrseq_device_register().
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
+.. kernel-doc:: include/linux/pwrseq/provider.h
+   :internal:
+
+.. kernel-doc:: drivers/power/sequencing/core.c
+   :export:
diff --git a/MAINTAINERS b/MAINTAINERS
index a7cb909ffa1d6..6da6d8ae951a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18315,6 +18315,7 @@ M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
+F:	Documentation/driver-api/pwrseq.rst
 F:	drivers/power/sequencing/
 F:	include/linux/pwrseq/
 
-- 
2.43.0


