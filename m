Return-Path: <linux-kernel+bounces-562669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE72A63032
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32FC3AE687
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793112063FA;
	Sat, 15 Mar 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HWI1g2br"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC552063C7
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742056916; cv=none; b=XkDAS0RMCIz/0RBIYUi2Wr9lL0/5mLyJugRDBUHtqgn6Veh17AG+Uk+5vi/Y6Krp4J7Dj3tfh8WbVNpYkApSuYfmKKNxDrGNV/yN8TMk3F05eqnhfmzL8Quo8/iQN8JR+qeCEE9IBNuo91IkW09PrxlQzMyBORkyxX0gAfbfxPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742056916; c=relaxed/simple;
	bh=5z75klJulPBK3euVFo5jCw9QXY35/qZ4NCunDCR/9Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXbY2BHF1B8xYd0YflndiFzmmYQhYwO/O6X2uOAmGddYRKS+KZ/bDHrb6lsatqhWdpU/+OCUjz6gvwKaTnxRWIugutXBNRGYA8E2u4zOW8WEfnw0bgS0ZE4kpnmMtDrlkmOPM7QkkwYOhR57CxtvGKiqS/a4Pg+gpHGdhssvRZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HWI1g2br; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 874983F129
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742056913;
	bh=VbN0B6Oenuw6+py3+N6wdefqtqSm9CuUWAW6b8DJ97M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=HWI1g2brrc4J1vRFF0L32zcIhwxrBpGpmZKKzEihfi6aaX+d4+96oCzP6zaIeZROK
	 yECDXyhSgHn44aGXt3ZeU/SllSE6+rtRO272nMlzPMTbEba8ZER3TVMZk2fLpnbMUM
	 /F9Ac2jz+lt5dGnRX0W5+o0uDm+rg8xTGB2QHU/kethZtpk+9GO7tbS6FdFAoggHZT
	 4C5MPpC4nIkdQGWaTPn5Q8LJHt8pUq4wrmQiR1qTISMGYWYUmLHeywR8zhfQqIRSE8
	 1p381aMn27wZbfGUaUgxjMDvwqp7EzkZ8NUsnVyBe5kWLTa/m3eQ/k4up06R0Mf/gh
	 1YmaXrrfGvedQ==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2235a1f8aadso46886615ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742056912; x=1742661712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbN0B6Oenuw6+py3+N6wdefqtqSm9CuUWAW6b8DJ97M=;
        b=DsAe1U9rlDpQcqmigBOk78u2qmHV6lXg5ScmEfwrV2crMRqoKmm2rIVyvNZEycK8hU
         Ns0C5PEUv6ImD7ElLnppMK7upvraqVBUCcGCHpHcCySftfpf2KHkJQ6UZxeO58+ZJAg2
         iPgoMa4fLzYr2OuIzXaLov0C6WdHARHOI1ZEvTvCzo1HRineozQ1ytgcD7yYrJ+0BRmW
         a7lO4mpRc+dX5ZENDkQVz8uYNx9Fm5yW9o5dhpxq4FshOyidWHTpLKESiaqUb1VH9gy6
         VxuT6fONvb6vggbuRTOTpigv9sYRR4iIStRye6qWCY/F4lflQVk3VPx68sY60gGyIfyG
         tcpg==
X-Forwarded-Encrypted: i=1; AJvYcCV+2m4sXN+04RQwqC+RAdd5cUD2xz8pV2GxhsZWeACR8Av6B7//78thByPms+/tb7avY+jvGJ3x6ig72CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGjry/IEIcr/0CS2DgTG72pPJ1PkmmE0GqI69Heri2Y1BD0NbS
	09wUupz547kpwY/Dl5vbMEzPMCjCOyogp3TGx3NlykUd6sQrMXoC631ZeOv8l9XIfQaiJSFGP4z
	Ta4HAu/mDTboo7R/CIBwrZoIwFJnDHp+hmiAlpdOxb2jf3vA3bwCliBp5Mb3/G7l9OWe1TwFvfq
	jQ0g==
X-Gm-Gg: ASbGncspmVdsuHPXEhaE67vOcrFVI8BoMdPYdojkDRdMvG2+2lw+XX/7qpChcaIEatg
	iWJafJlp9lr2wHraj5Lxn4yrZCKjx1FXCrUe14+8+iHclqEeyVfkSrDT/SIho8Pd6HatVO9P2F1
	DS0eWp1S8I3kL4REJrMAQd0I7gd4df3KkHmkuMqHTT0SqajmrJB5Lg8gyIETO6stBwJAacU6oVS
	FNAkp4M96H2gMi6h7ibzL1te4EZKq23sXFdTFphSNU4CX+S8oJgokw54L16ThonlF015+Sn5PrN
	6iiD7EZdgzRGwofI
X-Received: by 2002:a05:6a00:464f:b0:736:5f75:4a44 with SMTP id d2e1a72fcca58-737223fd0ecmr6839071b3a.22.1742056912028;
        Sat, 15 Mar 2025 09:41:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZPiPSqUBXWonM+1wni5zrfFyY061fEIcUx8VfreIK0Dp+klWcEbYSYn7e4dG+W0ARwHPvpQ==
X-Received: by 2002:a05:6a00:464f:b0:736:5f75:4a44 with SMTP id d2e1a72fcca58-737223fd0ecmr6839052b3a.22.1742056911569;
        Sat, 15 Mar 2025 09:41:51 -0700 (PDT)
Received: from z790sl.. ([240f:74:7be:1:83e6:3590:3498:db44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371155e3a9sm4637104b3a.71.2025.03.15.09.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 09:41:51 -0700 (PDT)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/9] Documentation: gpio: document configfs interface for gpio-aggregator
Date: Sun, 16 Mar 2025 01:41:22 +0900
Message-ID: <20250315164123.1855142-9-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250315164123.1855142-1-koichiro.den@canonical.com>
References: <20250315164123.1855142-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for the newly added configfs-based interface for GPIO
aggregator.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 .../admin-guide/gpio/gpio-aggregator.rst      | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/Documentation/admin-guide/gpio/gpio-aggregator.rst b/Documentation/admin-guide/gpio/gpio-aggregator.rst
index 5cd1e7221756..8374a9df9105 100644
--- a/Documentation/admin-guide/gpio/gpio-aggregator.rst
+++ b/Documentation/admin-guide/gpio/gpio-aggregator.rst
@@ -69,6 +69,113 @@ write-only attribute files in sysfs.
 		    $ echo gpio-aggregator.0 > delete_device
 
 
+Aggregating GPIOs using Configfs
+--------------------------------
+
+**Group:** ``/config/gpio-aggregator``
+
+    This is the root directory of the gpio-aggregator configfs tree.
+
+**Group:** ``/config/gpio-aggregator/<example-name>``
+
+    This directory represents a GPIO aggregator device. You can assign any
+    name to ``<example-name>`` (e.g. ``agg0``), except names starting with
+    ``_sysfs`` prefix, which are reserved for auto-generated configfs
+    entries corresponding to devices created via Sysfs.
+
+**Attribute:** ``/config/gpio-aggregator/<example-name>/live``
+
+    The ``live`` attribute allows to trigger the actual creation of the device
+    once it's fully configured. Accepted values are:
+
+    * ``1``, ``yes``, ``true`` : enable the virtual device
+    * ``0``, ``no``, ``false`` : disable the virtual device
+
+**Attribute:** ``/config/gpio-aggregator/<example-name>/dev_name``
+
+    The read-only ``dev_name`` attribute exposes the name of the device as it
+    will appear in the system on the platform bus (e.g. ``gpio-aggregator.0``).
+    This is useful for identifying a character device for the newly created
+    aggregator. If it's ``gpio-aggregator.0``,
+    ``/sys/devices/platform/gpio-aggregator.0/gpiochipX`` path tells you that the
+    GPIO device id is ``X``.
+
+You must create subdirectories for each virtual line you want to
+instantiate, named exactly as ``line0``, ``line1``, ..., ``lineY``, when
+you want to instantiate ``Y+1`` (Y >= 0) lines.  Configure all lines before
+activating the device by setting ``live`` to 1.
+
+**Group:** ``/config/gpio-aggregator/<example-name>/<lineY>/``
+
+    This directory represents a GPIO line to include in the aggregator.
+
+**Attribute:** ``/config/gpio-aggregator/<example-name>/<lineY>/key``
+
+**Attribute:** ``/config/gpio-aggregator/<example-name>/<lineY>/offset``
+
+    The default values after creating the ``<lineY>`` directory are:
+
+    * ``key`` : <empty>
+    * ``offset`` : -1
+
+    ``key`` must always be explicitly configured, while ``offset`` depends.
+    Two configuration patterns exist for each ``<lineY>``:
+
+    (a). For lookup by GPIO line name:
+
+         * Set ``key`` to the line name.
+         * Ensure ``offset`` remains -1 (the default).
+
+    (b). For lookup by GPIO chip name and the line offset within the chip:
+
+         * Set ``key`` to the chip name.
+         * Set ``offset`` to the line offset (0 <= ``offset`` < 65535).
+
+**Attribute:** ``/config/gpio-aggregator/<example-name>/<lineY>/name``
+
+    The ``name`` attribute sets a custom name for lineY. If left unset, the
+    line will remain unnamed.
+
+Once the configuration is done, the ``'live'`` attribute must be set to 1
+in order to instantiate the aggregator device. It can be set back to 0 to
+destroy the virtual device. The module will synchronously wait for the new
+aggregator device to be successfully probed and if this doesn't happen, writing
+to ``'live'`` will result in an error. This is a different behaviour from the
+case when you create it using sysfs ``new_device`` interface.
+
+.. note::
+
+   For aggregators created via Sysfs, the configfs entries are
+   auto-generated and appear as ``/config/gpio-aggregator/_sysfs.<N>/``. You
+   cannot add or remove line directories with mkdir(2)/rmdir(2). To modify
+   lines, you must use the "delete_device" interface to tear down the
+   existing device and reconfigure it from scratch. However, you can still
+   toggle the aggregator with the ``live`` attribute and adjust the
+   ``key``, ``offset``, and ``name`` attributes for each line when ``live``
+   is set to 0 by hand (i.e. it's not waiting for deferred probe).
+
+Sample configuration commands
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: sh
+
+    # Create a directory for an aggregator device
+    $ mkdir /sys/kernel/config/gpio-aggregator/agg0
+
+    # Configure each line
+    $ mkdir /sys/kernel/config/gpio-aggregator/agg0/line0
+    $ echo gpiochip0 > /sys/kernel/config/gpio-aggregator/agg0/line0/key
+    $ echo 6         > /sys/kernel/config/gpio-aggregator/agg0/line0/offset
+    $ echo test0     > /sys/kernel/config/gpio-aggregator/agg0/line0/name
+    $ mkdir /sys/kernel/config/gpio-aggregator/agg0/line1
+    $ echo gpiochip0 > /sys/kernel/config/gpio-aggregator/agg0/line1/key
+    $ echo 7         > /sys/kernel/config/gpio-aggregator/agg0/line1/offset
+    $ echo test1     > /sys/kernel/config/gpio-aggregator/agg0/line1/name
+
+    # Activate the aggregator device
+    $ echo 1         > /sys/kernel/config/gpio-aggregator/agg0/live
+
+
 Generic GPIO Driver
 -------------------
 
-- 
2.45.2


