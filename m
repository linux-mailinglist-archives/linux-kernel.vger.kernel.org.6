Return-Path: <linux-kernel+bounces-213985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6021C907D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC4B1F25C03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B913C3D3;
	Thu, 13 Jun 2024 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+YY3Zke"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C15613B7AA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309792; cv=none; b=RCTeTKYtzJD5kxmrRCZLhAvCO0cr47b3TcEXSiC/4asMXpTb0vRJmb1+TjmneloWLy8tutdGqzZdqobL13ByQKHnZLo8C3bineg7czleRGOxY7HhnICVtSGPm1QE96w0yavTB9l/oNfF2ieytzIBiK9Wlrq4V6J0ZAVI5Zih+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309792; c=relaxed/simple;
	bh=A7Z2pNuahnQTHPxYxgbC81iuG8UWkVYNqmAEGoD+kuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bGaRfHgPkSatKP7UJfW2M1NXLKTegNLGXNrY7O0L9OA/qNUMdH/LHROjCpXjMTbznHTlUSMbDvPK0P3U6FiwC4V+gcCOATBHANLkha80RW2xDBNNY47X10F8v07j7vK6EUjiSpoXgSGEt2ApRt/FJWJBBYfs8jY3zAqq3y1rP48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+YY3Zke; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421757d217aso16169075e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718309789; x=1718914589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPaCGuMACw1TWMHFIb28HSglVp7CXEoBq/vp9txrrWI=;
        b=R+YY3ZkeH6BrDA/dztKGU1XlDUQ16XzPwXwLzobKn2K5hC9SlMH+8U8Y9YLEk47tq0
         p7+f6YgPQwKGGcDAXJNzKHDZ2qHTKCKKUkV+RhA0SDDsufB7wmi/M0vgIU5lrQd3lCIt
         FyLhalmjRrYCARBB3hcoRr2IhWMyH/3lNX7HD42WkLEasnjJQv3UU1m/Fe39hivvVjNI
         uq0r6917ArnWL58qVJvz2gcQvXkgwXJidPonGXQ8sftWgblM4FNQ5NUz6rV/sv5ImPqE
         zpZbbWV451e8oIwiHBNfxFIqgLMVeH6tB9NiFPAtxIiVlBOOjsTMTI9j2q9JO32ohcGo
         YfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309789; x=1718914589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPaCGuMACw1TWMHFIb28HSglVp7CXEoBq/vp9txrrWI=;
        b=J8cBSnL4GOQD+sR6ZrGMvQyO6P/tmZ+tiAHUkXprm/WQ6cCm+9uxmWROCI2Lu4d/s+
         WAUgEsJfXmaTWRP5fz81ZmMSRN6/CL7cj02sr8sPzzzWjUO8cx8lUrEy5NyBLAgag3cA
         hH2+ok4hOw9OVtk0K8t2ZT3m/Vw5fiA2jias/3WHIRX6HYkX7drMgle0ehttKxs+Ktty
         lCx3DlRaUfzF2DOTomlg0kqhe6r7KLlSJUJgeGStT/Zahxn1N9i/zA11JTxcryZzvzys
         hxFHG6gHn0aO1y52OzJiJ1bstPq/0ycaDpllieXdzQthzlGRYNqgMkZJmrCytjfWnmIE
         D2yg==
X-Forwarded-Encrypted: i=1; AJvYcCXwPlM7YS/HQ0/lKoh6rXUdjJj1zUaVgqumnkUZMZoawXCKvhrbT1Y9G1jyZ2h86mrfhqfy/nCg372WCyUIqOK2hHX3gEUlLA6ebvfw
X-Gm-Message-State: AOJu0YxFUyNC3Bwa8LMo+XNrBBvPh2ma7xJ/MjNuuvgL9yV8Pbzm8xYW
	790Q/i3VVeT0zn8KRc6jbK44sMfd48Exl8tAl1AfZOMqz5Iz9zx+gjlMYmAvnSk=
X-Google-Smtp-Source: AGHT+IHGJVt1LrU7R8B3h993GSRPSiYf0kLxVvIxoiBJTPpIJskHQcvzdyg9qP0q8strnZvEQsqODQ==
X-Received: by 2002:a05:600c:1d0f:b0:422:683b:df31 with SMTP id 5b1f17b1804b1-4230481bbe5mr8374605e9.7.1718309789397;
        Thu, 13 Jun 2024 13:16:29 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de618sm73817195e9.37.2024.06.13.13.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:16:28 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH v2 5/5] staging: rtl8192e: Remove unnecessary pre-declaration of struct net_device
Date: Thu, 13 Jun 2024 21:15:11 +0100
Message-Id: <bb7d1aa7b336e4d68a30fd17dae7accfd2d5a26e.1718309120.git.engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1718309120.git.engel.teddy@gmail.com>
References: <cover.1718309120.git.engel.teddy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove pre-declaration of struct.

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
index 615b84bca9b8..3a5635494385 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
@@ -11,7 +11,6 @@
 #define _RTL_CAM_H
 
 #include <linux/types.h>
-struct net_device;
 
 void rtl92e_cam_reset(struct net_device *dev);
 void rtl92e_enable_hw_security_config(struct net_device *dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
index 866e0efbc4fd..c645775b2150 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
@@ -13,7 +13,6 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 
-struct net_device;
 bool rtl92e_check_adapter(struct pci_dev *pdev, struct net_device *dev);
 
 #endif
-- 
2.39.2


