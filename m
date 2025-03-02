Return-Path: <linux-kernel+bounces-540771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EC6A4B4BB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 21:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76C616AD80
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0A31EBFF8;
	Sun,  2 Mar 2025 20:54:01 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166031D514A;
	Sun,  2 Mar 2025 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740948840; cv=none; b=o1YrYp66pq3RZ4s0qqgSzO0rRyhWQVFNFV80SVTh9zjbxKZxZvhyxu/1MefcjY1wrDWGGRIdQUXHZKc+rV5q2OOV51ldoAwaHK5EZTxcvLi5sexWMWMNCM15p0TkgY5eL0sElKxzD8DJuoGdc9v0OgbPIBSauOj3xcOg/3kGgyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740948840; c=relaxed/simple;
	bh=okt66jowKnr8P1gS/V0Grkb5/i69SinqpyTkWAv2GIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgZC7WdU67W8xQAGqMDO2o1UvzxGLiAu+s+2KL47LNSwXMMdA/0VLG4QiddYBMCHe53p67eqOyQ3x0p+V+Z84LbCc909DK7cD7NuDotOM/8wcQAOSnQEKaa7RZxGGtYzYic2aMHjzD8bvIcW2sXYbvvsT/gOnoa2gd40vjYq4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54955222959so2307614e87.3;
        Sun, 02 Mar 2025 12:53:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740948837; x=1741553637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbF7SstiS81tyyQn4jYtTQz9WN4THoU5nLwkv2gXnKc=;
        b=ucVVQ+zNBKIw6XD3O0qw6BLGi2Bugb9SZomZ52cF12pu3oDThKsQRGu/UHGUOe4RAo
         2eES3Ca9Cek3rpO16XMFJZk8gJYvZvTPqWLzriXcMZjCTKXMgF/KH3RxF8ZTES9kOfGz
         N5yNsw7e7mOUiDPa9qpxVeJ+HOJdew8neepQS3ohX8YVMcXKJAexiGG+AltKbs4ThOLL
         xlJZBNQR9cwgmZAoga8o7Yyh/vPJXlGeF1IB150S6CTXqRtXJ09cmEhmrEU/X0DzGv1O
         As26dN+5PqwFuTN/Da6mWS6mBazXLnvXxEtgNPzIni0qeR9HT5yFEMDV1wn1fAGPuOSB
         DU2g==
X-Forwarded-Encrypted: i=1; AJvYcCUH2V6wFjnRGRXjwCnnrki6FNIx9XGwiCfZIMDTQyHYqF6y64mS7T9OJVAAC6qK+dBL0qx/G2pdYkpCiSK1p/7PUpy4rw==@vger.kernel.org, AJvYcCVKjkAfOH2WQuvAlWeJVNoNWjz2MHzbOt3ffcu1XsfcJxUSqUDso1Z4PufObdyqPj8vuRjyKhF24WFpG8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4c3VU7lD+da1tFgQJOUzGLK/rVAAXyD5BCvQYv3sS+h872uR0
	0iY3TUNPkec/0gY2NZYDjdU9S6lzCRODhrv5SvxAiFkmsZF6y/NHezKaE1Qq
X-Gm-Gg: ASbGncsZ93+EyubzIC/jMvG0l8VsoEjTEcbitXMj7CVbxQb5Fw9nPYa9XCAlAw4VFCU
	uGPaY7LpLoKrdYupy1D9d/rMSoiI4uN73yiaYTvAMOYjQb2A0IVY+vmNXNSxYxo/VgkwVaZAlmr
	LwvjFJ/FUzaHJ21noDgu5/XLyp09vKEDnUQ1HpUZx21gG8o6wtkG+pF2vpXZX8KFKGETB/YFpvJ
	wXA38MksClgiPjsmkkSscjc7cx33pshO6X9uRDgwuNr020ixqUtyzztbRCxFynPuQGBBxkVq7VX
	2w4ZRM2k1mkw7gpJ4dfHoOqKyeP0oR8RyCc8Y+Rf1qBB2Q8ORcpQzL62ctjLQJkwYt4sMNDjmSc
	F74jN0vcf8Q==
X-Google-Smtp-Source: AGHT+IE6MyS2pgjTJ+722X33JtSPDUm7iMNv7I9obQtZcC0fR0X87iN5u5+4hMSLd/9yV8eYH4jwzw==
X-Received: by 2002:a05:6512:3e0c:b0:545:c89:2bb7 with SMTP id 2adb3069b0e04-5494c31a0dbmr4248582e87.24.1740948836771;
        Sun, 02 Mar 2025 12:53:56 -0800 (PST)
Received: from galaxybook.local (82-183-24-76.customers.ownit.se. [82.183.24.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494a175b34sm945997e87.245.2025.03.02.12.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 12:53:56 -0800 (PST)
From: Joshua Grisham <josh@joshuagrisham.com>
To: W_Armin@gmx.de,
	thomas@t-8ch.de,
	kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joshua Grisham <josh@joshuagrisham.com>
Subject: [PATCH] platform/x86: samsung-galaxybook: Fix block_recording not supported logic
Date: Sun,  2 Mar 2025 21:53:50 +0100
Message-ID: <20250302205350.32509-1-josh@joshuagrisham.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Fixes logic error when block_recording is not supported but the fw attr is
being added anyway (reported by GitHub user bbregeault).

Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
---
 drivers/platform/x86/samsung-galaxybook.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platform/x86/samsung-galaxybook.c
index de1ed2dc6..5878a3519 100644
--- a/drivers/platform/x86/samsung-galaxybook.c
+++ b/drivers/platform/x86/samsung-galaxybook.c
@@ -1100,11 +1100,13 @@ static int galaxybook_fw_attrs_init(struct samsung_galaxybook *galaxybook)
 	}
 
 	err = galaxybook_block_recording_init(galaxybook);
-	if (!err)
-		galaxybook->has_block_recording = true;
-	else if (err != GB_NOT_SUPPORTED)
+	if (err == GB_NOT_SUPPORTED)
+		return 0;
+	else if (err)
 		return err;
 
+	galaxybook->has_block_recording = true;
+
 	return galaxybook_fw_attr_init(galaxybook,
 				       GB_ATTR_BLOCK_RECORDING,
 				       &block_recording_acpi_get,
-- 
2.45.2


