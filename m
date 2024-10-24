Return-Path: <linux-kernel+bounces-379687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 389DA9AE24C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC71D28218A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332D21C07F8;
	Thu, 24 Oct 2024 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZzrWqlZ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E01C07CE;
	Thu, 24 Oct 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764993; cv=none; b=Bp0U8eg18HoEqZ7EvfgdVaOfS4qnqwT/xFTL6/FU0DdjnFOI7COX7cIyoVD+hF99my5SOmdpBYXiE1ZsTlAaze+g1vrXEGsnk/QLel9vtAqI9Zu32CKH6UJAjlKuMp0yZWHRymIQ9113psXetJbJmPuTJil1vKTQxfYLulglC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764993; c=relaxed/simple;
	bh=prDuoEvRrgVoG8NR5+RJGRrWU4jn+L4AE+H+VIiOJwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FNveBG/YqZzLK414bc1s5+UTmciILcnwvyhHhIvdC5RvXmNDRYjw2Qq9V5g+LrM6RX3mFQdGsAlZZLXbeQIr5apjM9Fk0MVbMdiUVtRVDSpxdYj7YyjnC8juNXwsLSmUnc9mE/7eToLQwCplj2a5JYbzZICZEFbKauF4ioBR9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZzrWqlZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20caea61132so5093395ad.2;
        Thu, 24 Oct 2024 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729764991; x=1730369791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADaRPP2N6eMb9N9MQ8ISB17ihorm+QRS3v9Yoij6m80=;
        b=VZzrWqlZbznUbonhBkNN3IPJtDTSRC0Cl7LGW7ckjoIvIGlDRDQkyWCdRMH+YtOCfw
         rIo+qrp7mvGOKatETSJykHPlx5tdPjPipH20qLLPfrBBG+3CRHmDuBa8aGaPlh4LnIdG
         j7dPkyQQAdEDs2eYNNhEVjTKMectoJDpjDPqss7vnjW75yJFm0dxvQ4/wOAVBmp8gUq4
         HTYdYyb8YOJ2j3H1j2Rc/V48CioLj1ws81E5DVO4vzMKzUvfQqc+/KVSDtZRZRj1S06X
         UmcT/DYvbfqHFRQvG17nzXjkWpBw5rBuVTiLI9KNs8tFnHsGpIW0i03I/GBeQ3JUDM3j
         j4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729764991; x=1730369791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADaRPP2N6eMb9N9MQ8ISB17ihorm+QRS3v9Yoij6m80=;
        b=q2yqQIkYe2TponXpea8jDEAbtG+8vNci86PGY/PhWz7snl8m2bNWJXaubIOsyVymj0
         DG5qgAhQLx8b6oun/E7z2JNhMUo5DfrMRB/bXbkg0m11NmW4ss2Ng4N69HW3fRi/74ze
         m1I18t1BLHB4AiWbI7Q3/C2xVWhHrlfLrG+UcJimcQf4eUdxgp2z5NYdHBK4dyX4RoHZ
         0jmH9HbBrGM9IqenbHo4NovEoNshf1P0kgZc8jF6iHkWpmQ3bMx1u8Zta/QQMTNdu5cU
         bzxbYdzB/gH2oknVH/uPxjQHgakmBp1qM5Vv0OOZohfZ4glrcvziLwSIPx+Eafl4ER7Q
         D63g==
X-Forwarded-Encrypted: i=1; AJvYcCVzTr7s3PmmcBSOtLT/xCvO9q31d0mceQClXj6w9mS6L1nH/JBtYiO3OIhbrYHru5Ms5n+L9KEA4oy3E7g=@vger.kernel.org, AJvYcCWteex8FvlaDSLagiP7L8JZ493Dy1El4/p0IRfG0fmTJmO2+SUumbM7vzfSVBDvGOlsSSpbLeYFvxZ8@vger.kernel.org
X-Gm-Message-State: AOJu0YzK26dEqz+tej1bpMpMqv9qaxjvhBEoKZtld4Oo2MR/xglotEbQ
	WgE3JoohUsiEGdaemBigvHqBAKn+izN4hkZnlvSlmfrhfYgIrUBo
X-Google-Smtp-Source: AGHT+IGwbM87/SOguzDFw1X6H7yv2QvfQTwEzTsWVx7fqscA4rMpbpeQCWxfMi8q3DCe0M+2WfsZNg==
X-Received: by 2002:a17:902:e54a:b0:20c:8907:902 with SMTP id d9443c01a7336-20fa9eb5a9bmr70736545ad.49.1729764990945;
        Thu, 24 Oct 2024 03:16:30 -0700 (PDT)
Received: from asix-MS-7816.. ([2403:c300:5606:d914:fec1:9dc9:d21d:9b02])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd376sm69782065ad.132.2024.10.24.03.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:16:30 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: [PATCH 1/3] drivers: usb: serial: mos7840: Add defines for clock select register offset
Date: Thu, 24 Oct 2024 18:09:01 +0800
Message-Id: <20241024100901.69883-2-tony467913@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024100901.69883-1-tony467913@gmail.com>
References: <20241024100901.69883-1-tony467913@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds define for CLOCK_SELECT_REG1 & CLOCK_SELECT_REG2 offsets.
These two registers can select clock source between 30M/96M/External.

Signed-off-by: Tony Chung <tony467913@gmail.com>
---
 drivers/usb/serial/mos7840.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index ca3da79af..362875a53 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -144,6 +144,9 @@
 
 #define SERIAL_LCR_DLAB            ((__u16)(0x0080))
 
+#define CLOCK_SELECT_REG1          ((__u16)(0x13))
+#define CLOCK_SELECT_REG2          ((__u16)(0x14))
+
 /*
  * URB POOL related defines
  */
-- 
2.34.1


