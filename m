Return-Path: <linux-kernel+bounces-517865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D67E2A386B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20DD188AD1E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517E225780;
	Mon, 17 Feb 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OWnYaXgV"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198B225779
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802990; cv=none; b=FUWOjrOnxk52r4+nVLyarPdeMV38Hv1nUR5Dqc+lU15TAbn7BlHXzrybO+Cfhs1oAp7Z5+G/q8R+PPiYcXsjdDuK3qRiWiX/HmoPblr5sVvFCBQeXb1ee8iNWMOt3cTnq5bdURohROjedx/20+Humj0a/kIIRIQzFoc6G0iCMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802990; c=relaxed/simple;
	bh=5z75klJulPBK3euVFo5jCw9QXY35/qZ4NCunDCR/9Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsgHUzFniYcov5qYWgjGdjQHaGMFjRBIAKA26KWU56/Zekk/XeoJCIUxWsRm9aQ1N2C722jM3EuUTYaExDFAVRnkkmOEEZks3ifrWiQl9QJvMoew6wbPgnTCiTF9Hmg4qe1PJLieBiwpu3qzLOX2uk1wy/mLCgtbpHs46P23m+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OWnYaXgV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EBAF03F868
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739802986;
	bh=VbN0B6Oenuw6+py3+N6wdefqtqSm9CuUWAW6b8DJ97M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=OWnYaXgVeWzJsUGpq8OiHdHL99+5lGb5APfiR1EcOtj4oe/ZO/5T2nOlT28eBjTsO
	 cYOTsflXHVDWZITJbAg43+PbYRy32EhDV080skuMFVJUvyJ5saa4QLsQjkiwfVSXWi
	 9W1x2ai1fW0KZE1bmBzW7OZ4CFLQ13vxkoqLVy2HRrhJ3Ze94t2hWMWUr8sQb0gcU1
	 GAiWRqb3zlyvsNkFiNisA1er8Es7RgcNjdVF4Fls6IAH7hy++fhMtpUko1MLd+c/MK
	 LtYS/qLgeKcTGFlKcJTtK54dmn7lBImUJXz2N0926pmOS7X5zC/43nxbPfFcnJkrcN
	 giUZ3sLadqO+Q==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc1e7efe00so7672093a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739802983; x=1740407783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbN0B6Oenuw6+py3+N6wdefqtqSm9CuUWAW6b8DJ97M=;
        b=HT/J9eIryWYmgpsGqBMt5VqQBkYGl+Zgdc+5zY03//FhWAf8pFDARfItM4i7WNn3nm
         z1Un25jiWGw1WzDdRae6MY3LZ+7QkDaAPiwJ9JTs2/NXQv8OiNDwZpkc+pncx57bL9kU
         aOx6rcscEKJlCAMZeXA5gYEv45RRCmeRvPoZZIZHrG0BWFvYB5kAFRezJKxGvY2EUfLB
         tT+4VHCcVfPf1WSmFhC8VvMIEIx6ZXy9S15adLtzA6kpEApyYnmwb94tunnCxRk7txfn
         5KNTxbDKSKuzX1x43tzlC7X+tR4cMutQRaNBSzjqnsq0x6/1cYzvI7LeMPlEfNestWjc
         R/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0yduaup65321v8ERY5nuLzZ6OIY9jzrovtSui26m6IQBsnqEX7gZ0AgEZM890C9igEkAdKnD06X/gP6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlvVeSX7hMFZZRKLL0ljdAlfA8C+hvKqy6cwuJ1cE6FiKFd8YK
	38o25GVE4bWRDCty4ryZM2hPAVO+QeqyNA9AbpFoa6pFmzCQdBKUDCQGGyXDEvVQPxP1hU4fgD1
	yd4HOq9NUZdk5Bg5xHgMujAS5cwLUBZwJ2weZ8iLvRq5F9drw7YtRFYThdWoOBB2EaOi+XNY3YM
	C0DdHDfT1ASQ==
X-Gm-Gg: ASbGncunNKajC7Pr9TWVyHTfXuUOODhyk/uYWPW0ZOwZ6Py2/+jDbKsi5sBo2qwDEG5
	GpQo4Ku+tGgxwYKEE1eTEjgXMgnn7950KfSWDfxCEJb2TZGKD5FIOFV2qnRSCzeT6uX9j0oAAcm
	OC5wa2EOuSVQH11AMjQAXv34r4wyn3d50YvPQUxpUfRxtoC4iFuzD+Nl4prDb9y3qW0C+RkWC1H
	qmANpLm5Oz8n+K+HT19OIUmj61SpTnbhK7fSQN40Ef4krpCeTY18ZFqMJ0fFNB310lc1J0t/y2B
	j6iZVuOgYsZf9jnvMtGcDX0=
X-Received: by 2002:a17:90b:1651:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-2fc40f10402mr15930226a91.10.1739802983294;
        Mon, 17 Feb 2025 06:36:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGn8ODnVz5U27ivcZIXnDcIe3tj3Acy3nD1kW2qRgArMBY75CRJbzFbMz5F3/bth1Q+uY2Mow==
X-Received: by 2002:a17:90b:1651:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-2fc40f10402mr15930181a91.10.1739802982871;
        Mon, 17 Feb 2025 06:36:22 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:a6da:1fd8:6ba3:4cf3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b3305sm10057757a91.6.2025.02.17.06.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:36:22 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 9/9] Documentation: gpio: document configfs interface for gpio-aggregator
Date: Mon, 17 Feb 2025 23:35:31 +0900
Message-ID: <20250217143531.541185-10-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250217143531.541185-1-koichiro.den@canonical.com>
References: <20250217143531.541185-1-koichiro.den@canonical.com>
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


