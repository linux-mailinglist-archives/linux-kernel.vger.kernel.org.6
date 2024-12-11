Return-Path: <linux-kernel+bounces-441624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9E19ED0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9291685FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902FE1DDC34;
	Wed, 11 Dec 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F5Dat/X0"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2991DB365
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933246; cv=none; b=uFj7KEkixLsNOsGwdeRD1KgWenWUxzFGOJiPdivQ8uFbduo49lr0ih7X3wguTEXFBvjly55UBIJW0u6Ti6cl1F08Ou4SrHdQlJcTHvhrjipTRIARgOy3h4aB3+WZjyO2hYXNjZk+4QCoQvjq8aq0BycEgQA0DXo8QGQDYHMgSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933246; c=relaxed/simple;
	bh=Q0tZOYhuY3Ey0IPHXjXrOvps1QIhlGU9kBOlggkrfY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nLzXGOCrL9gIbVwhJ+7alp0JVsRMIHddDJN0sntVI6g5dWTLWhZgmMS0Rga8Mgs2guJKfvT0VCQs24U8hgxfQTmWncMC7aLvwM4CO32ZD+rNHtktM+nFiOk4zk8EHfvk10upa+AlPOADpZET4X0NHAEYs2O6CTYv0KbVEMtEZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F5Dat/X0; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d918f066c1so17169766d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933244; x=1734538044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aEfR/qabxahuoJOZlYtnmnLnWgQnj7Jexuo0meaq20=;
        b=F5Dat/X0wqCmvAIHzvdm2dKozxp4NjsqpyVj26QvOSwBDhlpolJCgOjhDmFhOG7OQr
         v1O68cIx9CuhilfX3HuspiJOraUOO1cOjdh+R2vJjwYzyPCoNLvf8bJDMwSlI++l8Mw0
         q65oQSNU5HovOoIk4eIM4BfOJKREMvdKA4xdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933244; x=1734538044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aEfR/qabxahuoJOZlYtnmnLnWgQnj7Jexuo0meaq20=;
        b=izciYHeyke7MyG61Vxd/Re8CJW1pGU2k5P2eo76cZE7VIjI6edfSvsxIA0RPj8SyEX
         oPveMSvZfLvkViXvlKGHcabgCJ8pVR4OnPCEITjQQrEwpvflISf0RE5j2DMrE3Peo6PF
         ifiF0K6PWx7xAlzZ+EYe6z6aF5VSCNblhxpgU9QjHw6Bky2BkUi4xR/flFLlXW1xzhws
         6s9vjZVaA/IPtuw48G+SxmqSjnRH4NCOVefJohz0qFcyvwgxYZMI1syLplg3B7jPDaZB
         JsejNkc+KdmxLREijZ53Er8TQlwWdKpbUctcvzMvPOmMBE1HI5eOTWuF6dqNnmgEqPwh
         GjsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrsEVoTjwXIb/O7pEIOTAek0ZSxMtCJTlIIQFOTY8CTcqvi5ghblPa5Qr5gQQskrIX0CzmjhzeMh+qM7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXMYH3AFK1JjSI/iKhQ6GyP5FsmyCVPd4LkzN52UKZHe1n5IJK
	pBBqwVKzMQMcSu2hhZSLTEf2VOctTSEyzWpKOWoU+iDUXV2QS34tfJGZR8uwJg==
X-Gm-Gg: ASbGncvBNEF7olNKkOIvb/mgsjmyq6As42uIqpvQSlqI+P02uYSL3MAxHu1WjJ73eiu
	YGJFjORq7Xfw5BZgXgJUusp4dV7ixTCSiZtw11SZt8yIrd1xJelNrP6geun22e/582iZJDaD303
	mDiyngg0odtKNkgkfwrkijBcftKETEitT1lfxHoz2fjW7CB6Trup7HXSr73/lC1pV9srhSEtN00
	vrWP0tUV2njwXiksEnZjxkNBl1tRKRH1NqE7hJeRH1FJcDnXl0Rnnuui/yrJp2bjYarIoZm7loL
	krjnfgVvUH/pwQX+nrecetaFPTDa
X-Google-Smtp-Source: AGHT+IF87GwFnPD41KxfMUhVnNyyBe54GEcWZX003dqF5ZJl5NACMpzgazmytTFC9qeLl+gKHOK6SA==
X-Received: by 2002:ad4:4809:0:b0:6da:dc79:a3c9 with SMTP id 6a1803df08f44-6dae29c181cmr3825226d6.9.1733933244430;
        Wed, 11 Dec 2024 08:07:24 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:24 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:21 +0000
Subject: [PATCH v4 5/6] ACPI: bus: implement acpi_device_hid when !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-5-4102e97aceb6@chromium.org>
References: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
In-Reply-To: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.13.0

Provide an implementation of acpi_device_hid that can be used when
CONFIG_ACPI is not set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 80ddd76b3a6a..b6b86acd1d9d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,11 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+static inline const char *acpi_device_hid(struct acpi_device *device)
+{
+	return "";
+}
+
 static inline acpi_status
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
 {

-- 
2.47.0.338.g60cca15819-goog


