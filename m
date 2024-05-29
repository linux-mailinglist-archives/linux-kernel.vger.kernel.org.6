Return-Path: <linux-kernel+bounces-194155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF4F8D377D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65981F26A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B3911CAB;
	Wed, 29 May 2024 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzSHFS/0"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFEA17BA0
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988929; cv=none; b=RJXulkyIktRK8j6JWZU6dsZGjZzAuf65rTYH4jWf7gTJOJV17MFwgJul5JRQkBzCk6cuV19WEm2aINMwyl07NDmTUWIBivHfmu97MdKz1xgMnRL5sJh57xfCiDaSJEE/8G+Jvi7aMqUwR7CQrcgxD4teHpJn+gNlIpTAl5eubJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988929; c=relaxed/simple;
	bh=LmG0Zbh1S2hp91Sn/hvYhhZTKcmSBk443WWO2UHQ6UA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Re6i07Dq5VuOoIcOF4jEotmUbzckux9UiUCV02xV5reLZdb9QiFt5kZq9tGREiFOzt7gLGq5AWIg1k/ONnNx2gZoyE6rsybvSHYoUTkvCw3IN+mESJ1rso4n7P2aSkB27qrS36VTB48NPm+sLArjLbAV9/ofTUEEMnSKqPmGA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzSHFS/0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f4a52b94c3so18163505ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716988928; x=1717593728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Kur8IddoyK7auUB0DpsJfjxMjtBncw932qUbr08xEk=;
        b=fzSHFS/03V9O8i8d5AwbAsBVfHmg3EWS2p6P8+/E4jK50I1uNue0PvcFBeSplWRvqJ
         +sixaJI8XCHcT9W4P+hnHZ1Y7VzdMMbpagWLGa7IaZ6UrGrWylum3qAzFbYx1Ej6QOgM
         43OQqg+uLIwDj0ZF1f9xXqQ0d8B4RTzw7LntQtaubmp44yf28M3V70vRXipdktrDp5fb
         PAaEC5CQNbNmnUQRa3OIWp6P/SCVzF7oJ6ZWO2E/m6gD/uhimmOZ15Ocu6UEArBIbpPf
         ho5Y9Ys8O/94IU6yDNB7Y2pp2p0fcbAb2z4H72ZfrfDOKbpfys4+tMNvya5ucYvBHmyo
         /hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716988928; x=1717593728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Kur8IddoyK7auUB0DpsJfjxMjtBncw932qUbr08xEk=;
        b=pjcPLZ1eNPrbwvgi2U2bqJMZESJ1gxevPWrThQTxgxfuuR+0z6j0pT/Ze0v9+5w1yl
         E/YdO0/HHwe6nMbk9p5BqjOa1KIq9tyuLFWuz00K1pLNJWa1T7EHUR2UeEZZeybWW0JP
         LKeI2ouIZNfzBwDpM89rcCVQ3veXDN0wxig3DlZHwY1DrAn3d+CyDTd8bOTYcjIHDPlq
         lQhBNT4pJWYv+KQu/HbZwHwBo6D/ZpT9bCUpDrYKtx6WYX+PWM+xZ3EfUo4TC/3aQu6V
         EA4typyxdjjNggD7j3HJ+OkudLFXZJFj57Df1xVaxbqVGWwLAdJ6tzo5Jy/Qy5HHCcUB
         uqdg==
X-Forwarded-Encrypted: i=1; AJvYcCVQh6NUXbRZZ9vOCeUq4gVbOgZzfZA3FSdgX5f+EWIA13NglL62DU2Md3Fh/CbPiB/l5/Xn3nMJbjJoVhYuzvH18rQvtzBnnFwj23LG
X-Gm-Message-State: AOJu0YwF9KMoL4fvrR6KHqrTaJ1pCnRC9vx8ys8k2kEApQdGYkIpy6Xz
	gGqygWfGLEmhu6+9Kw5IxlWKpn8pgVnsgAVb1djcgJcDswYjiTAT
X-Google-Smtp-Source: AGHT+IEsBv5bIxgTY/q47JQPTYogoxqv6LI2GlfX+nm0L8UY7lG45NwaKZRAtWholBUpgq2B4dfkIg==
X-Received: by 2002:a17:902:e84f:b0:1f4:990c:5ef1 with SMTP id d9443c01a7336-1f4990c5fecmr96953905ad.31.1716988927615;
        Wed, 29 May 2024 06:22:07 -0700 (PDT)
Received: from paran-QEMU-Virtual-Machine.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c760a21sm99183205ad.4.2024.05.29.06.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 06:22:07 -0700 (PDT)
From: yskelg@gmail.com
To: Stefano Stabellini <sstabellini@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: skhan@linuxfoundation.org,
	sj@kernel.org,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH] xen/xenbus: handle pointer to NULL in alloc/free_pdev
Date: Wed, 29 May 2024 22:19:28 +0900
Message-Id: <20240529131926.29590-1-yskelg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

Modify 'alloc_pdev()' to set 'pdev->xdev' to NULL
if 'xen_pcibk_init_devices()' fails. This ensures that 'pdev->xdev' does
not point to 'xdev' when 'pdev' is freed.
And modify 'free_pdev()' to set 'pdev' to NULL.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 drivers/xen/xen-pciback/xenbus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
index b11e401f1b1e..f1709b8e284a 100644
--- a/drivers/xen/xen-pciback/xenbus.c
+++ b/drivers/xen/xen-pciback/xenbus.c
@@ -54,6 +54,7 @@ static struct xen_pcibk_device *alloc_pdev(struct xenbus_device *xdev)
 	INIT_WORK(&pdev->op_work, xen_pcibk_do_op);
 
 	if (xen_pcibk_init_devices(pdev)) {
+		pdev->xdev = NULL;
 		kfree(pdev);
 		pdev = NULL;
 	}
@@ -102,6 +103,7 @@ static void free_pdev(struct xen_pcibk_device *pdev)
 	pdev->xdev = NULL;
 
 	kfree(pdev);
+	pdev = NULL;
 }
 
 static int xen_pcibk_do_attach(struct xen_pcibk_device *pdev, int gnt_ref,
-- 
2.34.1


