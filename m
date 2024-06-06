Return-Path: <linux-kernel+bounces-203966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E3A8FE25C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2111C225AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF7C143752;
	Thu,  6 Jun 2024 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM9cT3/5"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38A13DDA9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665281; cv=none; b=UXlPi8QGJlKJ7d0pJinOasL1x1aCwXZHku0xyhJmA9B5d+5cMkTq5VK4dys8saSxZhPdyu35//x6g6KW9sa2kq7C06HUZ8XaZys+Eqvx3VxLH486DhgRF3J6avLdGxyQ/OUgcrRl+l9d+LEBqoOXoMucRnT60xprdCTKjEIxThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665281; c=relaxed/simple;
	bh=El7wMREA9FAs2uCVxPiuxz5mLkNbj4M7DKAj+YhaJGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YYYzsKUB9E/xxrRhgx1oJr3FaQEereEQ4M6jDxReOdvZAkz7/y1Qbeqxc++lwIcXFgKKGZNaufhPJhNlTWY3GDLxSXf2MVoc/GdoItV5xSZWlEQx7WTmGg9MYJbEKfUCgW1I0AZigfCTGZ03/rBZrHDQUKGxs2I9MEnEDFYLWCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KM9cT3/5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f61f775738so6568675ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717665279; x=1718270079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fhIeaRcCMzGBPpV19PrfDc05zFokc/RSIlEBIMrrrQ=;
        b=KM9cT3/5V4Nt86loSL9PYnxsdlcQlEl2Mpb4NdKa1V0pEhdrPx1sTzs3OufqVdkMIn
         cvERub6I8ySETDpsaLQC/0tGMCh6RFft/46kyNJbxvlH765AlygxGwOtNy8AT1HIjPVZ
         KZ5V6B8+GOsAxcxGj5ecDDijKGCSH0M8gNYunq9w7TG+vnxgttUPGsfRFNyH41WgQStE
         C3negasS+RCl/fDwfVje0R8uNXTNJDYE5TNGPHOD7h/Sc6M7mlaUGjEMKspQ4yCEdHrB
         uyyZr61ar/5ySv/gubE/wR69S0z500e0a3zY2AP+3nDm3QwJsvuI8xzHmCZX/4QxwvZF
         3hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717665279; x=1718270079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fhIeaRcCMzGBPpV19PrfDc05zFokc/RSIlEBIMrrrQ=;
        b=KX0ANe1Cz7o1EWBcfxMqGfHHWw0zhZFdddEFGAUneV4KvKdzwRx9bjZgnmS+pVd4Sj
         SihC0Wh06dKb62eFFrcjS/axpKjcJEXgij5DHTTLIAuIVC8G1w3dAe9sqb9dK+IrE7xJ
         OK5bAWtyFFwPNRBHDsLvXnlA9IMgZONXoITx33m7lncwloWXjWr43LCI+X7wUNEZOKeH
         W6gpMi9NkqYPnXonB7S8ugvlnW+vauYD3HNjo7LRotCBdehnQi8MJcbD6e7D3tbCCVhA
         XvakImjWaXK6rQWxJqnhcCt7aVsTgMjnFV/vixBAsLsLkFoDbzIi4HDhd/b8y6nx+V56
         V/hw==
X-Forwarded-Encrypted: i=1; AJvYcCXyN8YgltPBE308KvEElB4V31KqxMGQpFEEKc7oQ9biMfA72e5ES1cbvCAwocGxjUBJpwxNcUIFrl3PGxwbhAQtqVcqh6Mtu7WOs/bH
X-Gm-Message-State: AOJu0Yx3jmYJGFJn1Eo3Ln/T7cU6nfpKn3wafyoyljMCOXU4yMjMQ5g9
	C1U5JUXjGZ4RwnSOHo4ZX2YlOLbxOabMbTbN5jxpXARrFUOJkBHFH6cKFVRLNJq1FQ==
X-Google-Smtp-Source: AGHT+IF5k9Bai4WGe3KRzNcciXc4oO2u9bq1QeLo5v+D1JkD45EnEox6Het6L88N1X9bGqyVh8JoiQ==
X-Received: by 2002:a17:902:d4c2:b0:1f6:20f4:196a with SMTP id d9443c01a7336-1f6a5a161admr58883265ad.32.1717665278794;
        Thu, 06 Jun 2024 02:14:38 -0700 (PDT)
Received: from localhost (97.64.23.41.16clouds.com. [97.64.23.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f210sm9885505ad.48.2024.06.06.02.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:14:38 -0700 (PDT)
From: Wenchao Hao <haowenchao22@gmail.com>
To: Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Wenchao Hao <haowenchao22@gmail.com>
Subject: [PATCH] crash: Remove header files which are included more than once
Date: Thu,  6 Jun 2024 17:14:27 +0800
Message-Id: <20240606091427.3512314-1-haowenchao22@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following warning is reported, so remove these duplicated header
including:

./kernel/crash_reserve.c: linux/kexec.h is included more than once.

This is just a clean code, no logic changed.

Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
---
 kernel/crash_reserve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..d3b4cd12bdd1 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.38.1


