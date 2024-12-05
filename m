Return-Path: <linux-kernel+bounces-432462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FEC9E4B7C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70931284E61
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C7636127;
	Thu,  5 Dec 2024 00:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSYCLIB0"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E548D1B59A;
	Thu,  5 Dec 2024 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359646; cv=none; b=IvJzedbQe/MzRJJ+OeZXWXEj5kGQCPPZm+B7MzY+w/MfuCfVpIvUeOlVUgHzabMc0DQR/I+TkbqE0Ndxm0xfZXRAEhuY7lPtv7CR1l7HAIMD4Xwk4AfIgMgnCa72weJQyTw45X5AJjKMKO0eTLSsMHDnPt39UtJxQWfrDAgdXPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359646; c=relaxed/simple;
	bh=4ZxeEJPY8xoRML7MMJMoHacS1hJ13w94RIiqCDy8sXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brpVcTtz2sjxm3iYrjB01cQGaaEdm3tJyT4F9sgNAIJlhm7fyryS7HNTtG2wezVhYVUhQYTCdKVP0ajhl1abaYe+7pdM9ZkBzLyfWu7wDS/ildYGC2q9+eXXhM+qqJJMcP2+0A0i6NAB294YpyiWpgJPNIyFeQUmZSXRxkOKL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSYCLIB0; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fc2dbee20fso379462a12.3;
        Wed, 04 Dec 2024 16:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359644; x=1733964444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhdIFnFtU8L6vmt7RyRfWOP3Xh8e0z4jvRasrWil8Yo=;
        b=VSYCLIB0P6jJRmdO52/HEa0Nx1L76tRGGAR3xe1osWAsq4OHcSA1UypI1vqwADTR6S
         zBtWZ5geA+C/ETl1JDwqrfDMc5lr8pBW6ryq/fP/C7Dsn8s4gQNRzW1YZ472pAGRXgj6
         EM5KwBFqSYUX+TC71fcfNCnQI5Vhc7QUYXbeGdQ0FLqwbyDMSsvPtqxryfBbYpL5Wga6
         H/d8DvWIOD7fVLWT56xD1/PuWowLT7H07zIHy5MHC7g4obrCMoL95ZtH6ZkidLAuj7Ma
         NRjZQe1bMI3hzvQP/m/uxUFNVxJ86cnlxLCQ9Sd4/EOmxCdLujN9ictk72IXltV2yEFP
         OgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359644; x=1733964444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhdIFnFtU8L6vmt7RyRfWOP3Xh8e0z4jvRasrWil8Yo=;
        b=KWBpzpnYxstgSRvXRqNlVsSUjjsWQ1EI/BStQbbKBhuMLV/4TPA4ez71Z1iEKPpXX4
         eWRJilWbKbJgW1fOSrE39Os+sLCNPkD4mtF1otOvSD6z1bvSmRTc9dD0iZxXGohpTLPi
         ACW8rsyK6GqWUdgAxI1oIZUTwwXDuqDduKPtfx0GarVe078pm79aPHdMmP3h1sGybPH7
         rnDA1MYnKUGZNB/5hXSO4mjuPv89M/MPta9OokoLt1aJNT5jYJpfhTVlR0ksi0yNzFgU
         0ZHdVccfmHsIO+YtbGpTo+Dy9080hW55xNEXAkyXXY8XBc4yi4rBZf2OkeMutFyjFk0G
         IRLA==
X-Forwarded-Encrypted: i=1; AJvYcCUGsS+/FF2ltv3EQd8X+xFXFutU4rSVqxRE6xH2QGsULOcSh9We7oxfXk8XQEgQtrSvBXqGX1H2RkeeFTZlgNdPu4am6A==@vger.kernel.org, AJvYcCWXkZEc3VM8xy45XH0vaaIp2RgNxCUKI7Wl0509ZNEyDd28N+mZmy/CfYi1RdUquD4c/1QoDmbt8WQ6GMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrgFZuM+80P6jM1pExMUpNsxKiIYwLVbNS93kPUiCyL3h5Z6hT
	SKeC/P9OGspbfcDmJa4HA8/TfoHM8KDU/hsNodAGBBnLjDNi6kFz
X-Gm-Gg: ASbGncuOd4nTaYnYJTbpYJM7Sq4eTetMZ6UA4rrq7/PIfBmndWWOrlbIOG552cG0Xvo
	dBHo/FiSWx0RLVM2krsB+EchTSsl1JgCANwiIe1PQrGZLOF9CPtQ1rFvwxyvC+174EnRUbHrP/V
	cbVUHig95wcJXqL/VEWM9UW3m0VGa6CNOW0spGuxPNwib/jPCWZLGtKWD4e0wsX6OAEkFsrxCll
	+q+5WBx5kQTGtv18ujQOBkcv+Tw19/gE1Q9lpfeZsEeGAfQbr92hjs7aL5eVMV0lWDQN45GT3F9
	D+Vqop82Ppk18ujp6ro=
X-Google-Smtp-Source: AGHT+IFT2v8ovroLfk4FV50rHj5EP/hN5gMU/u6ifXEGMiZjTQ7Xi4QrB+uJBQuIhghdD5jTrD2Fcg==
X-Received: by 2002:a05:6a20:158a:b0:1e0:f059:cd6 with SMTP id adf61e73a8af0-1e1653f23d6mr11113931637.29.1733359644219;
        Wed, 04 Dec 2024 16:47:24 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5719sm109335b3a.27.2024.12.04.16.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:47:24 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 19/21] platform-x86: Rename alienare-wmi
Date: Wed,  4 Dec 2024 21:47:10 -0300
Message-ID: <20241205004709.2186969-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205002733.2183537-3-kuurtb@gmail.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to eventually split the module:

Rename alienware-wmi.c -> alienware-wmi-base.c

And modify MAINTAINERS accordingly.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 MAINTAINERS                                                    | 3 ++-
 drivers/platform/x86/dell/Makefile                             | 1 +
 .../x86/dell/{alienware-wmi.c => alienware-wmi-base.c}         | 0
 3 files changed, 3 insertions(+), 1 deletion(-)
 rename drivers/platform/x86/dell/{alienware-wmi.c => alienware-wmi-base.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3809931b9240..a4d02074dd91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -787,7 +787,8 @@ ALIENWARE WMI DRIVER
 L:	Dell.Client.Kernel@dell.com
 S:	Maintained
 F:	Documentation/wmi/devices/alienware-wmi.rst
-F:	drivers/platform/x86/dell/alienware-wmi.c
+F:	drivers/platform/x86/dell/alienware-wmi-*
+F:	drivers/platform/x86/dell/alienware-wmi.*
 
 ALLEGRO DVT VIDEO IP CORE DRIVER
 M:	Michael Tretter <m.tretter@pengutronix.de>
diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/dell/Makefile
index 79d60f1bf4c1..5e7496aeb070 100644
--- a/drivers/platform/x86/dell/Makefile
+++ b/drivers/platform/x86/dell/Makefile
@@ -5,6 +5,7 @@
 #
 
 obj-$(CONFIG_ALIENWARE_WMI)		+= alienware-wmi.o
+alienware-wmi-objs			:= alienware-wmi-base.o
 obj-$(CONFIG_DCDBAS)			+= dcdbas.o
 obj-$(CONFIG_DELL_LAPTOP)		+= dell-laptop.o
 obj-$(CONFIG_DELL_RBTN)			+= dell-rbtn.o
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi-base.c
similarity index 100%
rename from drivers/platform/x86/dell/alienware-wmi.c
rename to drivers/platform/x86/dell/alienware-wmi-base.c
-- 
2.47.1


