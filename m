Return-Path: <linux-kernel+bounces-170190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8777A8BD30D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC481C2114E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BA0156C62;
	Mon,  6 May 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RD7iEJN7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B8156960
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014111; cv=none; b=OC3hx7QNiinQlP8A7khn10bYWGR7A+brStlx4slCbH+1TUQg9KstxTG8Fo7mupoYrAqhqp8ksEglmhJT6QvacZOvyGNDNMQbfwRmBaij53LRAlqCcylXT0fSJln1CYIXCth4lWYrnfUk91CmFBK5oDAp6bDruf91SzLrxDTlzaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014111; c=relaxed/simple;
	bh=kP6NGaRYgrSE0QhFBjiJtMvuWvrK8Tsknf/C6p4ofYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kgJWT2K4pu2lvBRiP0ZoRYv5gfOTczqhxKY3dsIym4vxoQ+qXeJ3pEFanZ+57/uBwiEXjp9aascnUQWCfdWvE9oioqMQ7ogXs4CEtaUoo9bGVNOEwB6gu72et82EK9dPdQX+pSMQuuW5LXIwmrWJRWyCUTD12W03r6cvMYd+26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RD7iEJN7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715014109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pV60bk7MZRaPMf5SburH/KO5Udmwu+vDVJu5cC1oaZ8=;
	b=RD7iEJN7G9RgK+WK07ZIheuguQv4BCbZE4Mn/kzwLRMJrtUktf34XC9yKGwjW82IZWUnUP
	sjjRPOzzSjEz0myVUpeR0e0vc5oLPDfa2SMU6LHbTT9WHzkL39jc7yIwf+qdIktl3WtKvQ
	ZzxNzTYivsYATkZk1XQtMGP/EByhxLA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-wPRPOGjFM3KAcUFMAidScQ-1; Mon, 06 May 2024 12:48:28 -0400
X-MC-Unique: wPRPOGjFM3KAcUFMAidScQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7928e064fe9so346866185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715014107; x=1715618907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pV60bk7MZRaPMf5SburH/KO5Udmwu+vDVJu5cC1oaZ8=;
        b=dEQf1z/m4t7nTKnkZ9pLAJ3fkewbJkdrGMUjeCJRDZ8nUgV7RuPBnsR9o8FOLmEXE8
         NhJ/EqkawKp+Sa7dzwK/2Zxg0FzLDAz1c8al68CCSzT1GFs3oVF4Cb1uJqBG0/n/utua
         ob1pGY4FqwHh8GkIlSlTTAg9FOQW6XGAIdkGalnTO085d6lZWj6EgUCQ/pRN00woHyTz
         MT5Lbl12cSjUDd5cc5OTR6DmmbakBa9A5hMyJj/GjZX4Ap2CRXJ+VS786nX4Y33Kwn22
         kXEaSq9UDK1/PD34yei121uCpvmzkXgXrD8GLdrQ6GS9HNVmH6qRIwE16k87/NJa/Ebt
         qjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWKNRcAOMzM6YOK9PYVqPO99tHNkTK7aMSMlKqivE/hGjsQDCb39FVh8zaxMUJw2KYrnuqIrJ2IB3shxEtBwdl1PwMLVmb9o1L0xsT
X-Gm-Message-State: AOJu0YzMy1kdB4aSEOWADtkNiMPWv7vq7ajvRJ5QUmJXIJBXjx8lm82G
	O5NgR0eGOsClNKtm/gCG+Ou661rGGnH5oBM9/i9u+m2o2FXrGd/AmSHWn/agL3665ZYy53anW8I
	44gqxZjS2RQGMASWnlH1cSqGL+JPI9nuujYya+cZznuhE26HdkKwX6XdQzWJu
X-Received: by 2002:a05:620a:24d2:b0:790:9b2c:fdb7 with SMTP id m18-20020a05620a24d200b007909b2cfdb7mr15426084qkn.23.1715014107709;
        Mon, 06 May 2024 09:48:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5fMd6KfjPHxQnMUGoDLrgb49or4FLR1tEmn0ACMub0QftRG1DDtyxUkhyXaByZdYaK7khiQ==
X-Received: by 2002:a05:620a:24d2:b0:790:9b2c:fdb7 with SMTP id m18-20020a05620a24d200b007909b2cfdb7mr15426057qkn.23.1715014107272;
        Mon, 06 May 2024 09:48:27 -0700 (PDT)
Received: from klayman.redhat.com (host-82-62-247-97.business.telecomitalia.it. [82.62.247.97])
        by smtp.gmail.com with ESMTPSA id b4-20020a05620a0f8400b00792a2036346sm471237qkn.63.2024.05.06.09.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 09:48:26 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Revert "fpga: disable KUnit test suites when module support is enabled"
Date: Mon,  6 May 2024 18:48:14 +0200
Message-ID: <20240506164815.31134-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a3fad2e92c76587fe262a1a4a122045b29885354.

The core components of the subsystem no longer assume that low-level
modules register a driver for the parent device and rely on its owner
pointer to take the module's refcount. KUnit test suites can now be safely
re-enabled with loadable module support.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
index d4e55204c092..e4a64815f16d 100644
--- a/drivers/fpga/tests/Kconfig
+++ b/drivers/fpga/tests/Kconfig
@@ -1,6 +1,6 @@
 config FPGA_KUNIT_TESTS
-	bool "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
-	depends on FPGA=y && FPGA_REGION=y && FPGA_BRIDGE=y && KUNIT=y && MODULES=n
+	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
+	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT=y
 	default KUNIT_ALL_TESTS
         help
           This builds unit tests for the FPGA subsystem

base-commit: b7c0e1ecee403a43abc89eb3e75672b01ff2ece9
-- 
2.44.0


