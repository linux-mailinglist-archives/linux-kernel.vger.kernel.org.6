Return-Path: <linux-kernel+bounces-386366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDD89B4278
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F6F283843
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EC1201259;
	Tue, 29 Oct 2024 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7zBb87i"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973218B48C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730183954; cv=none; b=QfpexjE3JGZLgsQIqxJDj3p+0AlZqRy+BD+vbI2fr2QCep6xj4qJGtZV1YKLY0IFGCku+Uyf0xg+st73Nm3VzM4qv55asrdIu1+8IL83VZt4cLt/7ELkBEuXdkE1UZHPV1S31gdbAXbIpxZmMOpA7fqtmEMzexkJUxYx9BIFedE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730183954; c=relaxed/simple;
	bh=e9APVLVM0O9XL0qjKgr8gnAp9m7xUzTv4X256LpfKtE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FwIruYx0+yGFQaLARlLYAMYzLyYWM2alUtEAjvEydDWGJJ1N+XN/8QXXY6CJMdYknwHY8Uqv8u9KzjrkazqHBKflmUYAjiyK8tVwNsMIBiKG3LraTCfZossVK4O+/KJjzqAZBn+ziplqvK/nM2nyCxDH55Caj+rf6CinWIXAzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7zBb87i; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cf3e36a76so50384885ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 23:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730183952; x=1730788752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NoTHtDAF6ws44F47OVjGKPN9wXynxJNwGjXwFS8SeTg=;
        b=k7zBb87iNtlnxTav05TblpkIzrtm3fBKQcJmgnMUbzPo0osE2HCylF+haCooqq0uIa
         HBhp7hBF2GUar+GdLJT8rOSmeJjEETX9MBToz54j2dch8rSHmN1sqzhtyRx1bBbN1hJ4
         I7lfnDwUQor2elpF9u7PhJcTmq2lniNL5wD+3UUp9znBRN13ouhZM5jdXZMlgoDmQjjC
         57nYZ7PdLAtUHMgHl5o1MQZKElG9K597AZoON5LTK/j7wRh3GG5ofo7Yo5yUwren9qqw
         PMegkz0xXeCwzpbRnHWeUb2NgIn6C8dzjXUDjti/Dfh1Wb5ZLvvroe4NM/R48OJaV5GT
         UTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730183952; x=1730788752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NoTHtDAF6ws44F47OVjGKPN9wXynxJNwGjXwFS8SeTg=;
        b=SdwviXN6AKRsymxF3uqs7KYrleZ6DTAOfHJloIVK4ASHU6+lSeH8efQ4Vvqq4ymWii
         lAO7+WnoHyK83OpHRorkMFxgyE9Mu1kOLoh8pLosAQG6MToE1UyjA0XrU1MJ4F7kVzK0
         tr+u/nNXZYzmqAIFoBgW9Dlu9k8myuYMu0pvJYr9BdilliHiM6rgTiAUeb6+GgGQuXwz
         Xr3quywLTNZ7oP8wbkfrxJljYBgBEJYm6Z+zCXj8fOKIwY3bqU+l13oiXlYbCwwehSt2
         ky7n+rur0o9v5hJzAsYwC0Lm1eVOzi8j9I6IFuBwA0WMCs5y1/Fau/OYlh/KyPDEdTx7
         +ggw==
X-Forwarded-Encrypted: i=1; AJvYcCULSq6blIN5fHUCb+0JsFTcZwMl/t5iE1AIa2OuKX+dVU+STl9aWPo/vwj7tYqYAT8wVra0O6td+Fv4Br0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3SluxZPKUdBduxGr4UUL4lEDpvpCxQzwfj4f2PXfXzaoFFOY5
	zkya+rNGRmnm3lPsaSceBZXxajGIl4S5xg2iZYKOWeK6dSKDvBdbaBq3Xr6x
X-Google-Smtp-Source: AGHT+IGgiP7oIWXuGp9Me5fkVVdBioimX2YIYTbB7y0RxwXTtVz3gXwarihKlTlWpugpq7ix+Xj/5g==
X-Received: by 2002:a17:902:d48b:b0:20c:bff7:2e5f with SMTP id d9443c01a7336-210c6893180mr145648635ad.13.1730183951697;
        Mon, 28 Oct 2024 23:39:11 -0700 (PDT)
Received: from dev.. ([129.41.59.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02f16csm60340365ad.209.2024.10.28.23.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 23:39:11 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] staging: vchiq_core: Remove unnecessary blank lines
Date: Tue, 29 Oct 2024 12:09:01 +0530
Message-Id: <20241029063901.1857067-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit cleans up the formatting in by removing extraneous
blank lines, improving code readability without changing functionality.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 9e56e34ca4d9..da18c77f3cab 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3486,7 +3486,6 @@ vchiq_bulk_xfer_blocking(struct vchiq_instance *instance, unsigned int handle,
 	if (vchiq_check_service(service))
 		goto error_exit;
 
-
 	status = vchiq_bulk_xfer_queue_msg_killable(service, bulk_params);
 
 error_exit:
@@ -3624,7 +3623,6 @@ vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 int vchiq_queue_kernel_message(struct vchiq_instance *instance, unsigned int handle, void *data,
 			       unsigned int size)
 {
-
 	return vchiq_queue_message(instance, handle, memcpy_copy_callback,
 				   data, size);
 }
-- 
2.34.1


