Return-Path: <linux-kernel+bounces-512240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE285A3365B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 04:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8843A79A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACE820766A;
	Thu, 13 Feb 2025 03:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qF1BLvgP"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D4206F38
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418259; cv=none; b=QDaRPAzpPOQW7HcwRrqXBlwRwPI8+tZ+s23D1zrf8+hNNJ62UqyVg8YZEN1ZM+zqGgbMfhHi0Soe7M9AF6b4RajQpUBhEfbvY+KzwsUA1EnXLSwbv2cao+CGKGe89MtdUAi+Wl4vJNlVXaREE4dhSE0lFNtFZq2BWLW0ZJsZxL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418259; c=relaxed/simple;
	bh=od5zF6RFzeyKpgxI5ZP9SeTWKynffEDu42jhzpqYPLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QMN+Xgrs4PLZARtyaF0aKJuaO1JpOFBi2BOdL0P5kJiQSRvGltqOzgsDjH4CdWhPnfP/OAWOHNk/3pZp2oV16EW6/DfmaUkixkywwkr4XQ4qmROdH6OAra7O6ay2YMWHiOnClA/eIJpRUlLuRMIjsj7SVx7HcPvbLssDH0wi7bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qF1BLvgP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220bf94cb40so7807435ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 19:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739418257; x=1740023057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bYmShVUdbXc98ckeys6I9ZF5IJTdzAju6Vcl01yeoE=;
        b=qF1BLvgPrjA6o8SW5cwEnd5us+muxxgkMTiG4ysuVuLHf3uVYC8oicbNrVHAJ8P0qv
         1L+LZVVXmKYtTyNQjA/cYxNqy9RegertbMn/6zL4MfyXi1zFhARPQqmDdXMgDUKI1qXy
         R2x2T/sxDuzKDx0hRLwGyjlYaoU/HhQicVRgE8dofMdpwrwPdKf18KR50E48JXr/bJeq
         S5HRJ7h5ZaqhFG/MXK2gvEtaOzD44Rt34DHHKXyhnv4OZQUsKvR2nANBkTqCIs1HcXyI
         plRraHQotTKSk37K0f2wwagpL9HkOZCojX6ng/uTLUzE6x/SV51pbO4oFYYcehOV2+uF
         bmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739418257; x=1740023057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bYmShVUdbXc98ckeys6I9ZF5IJTdzAju6Vcl01yeoE=;
        b=SdJ7Z1pSL0v+2p6bVOfO4DfMsNQk2tehT7X2hyNa3u2UUpcxbIY/Xu41+vULv3De21
         gyEva3ZCKs/QbZ/l1gQ9FpTacCq7uXzaV2laNk3ZNc//AOphGRItpvFzeNkev/rFFCgU
         7gf/BdXN+ws6sU4Fh8vZvii9Q9bhDbvrnJ33XVEkxGBdERY2J2sgTnocdNMi9OHQ7MTs
         KFJtQbmo22VFdEU7HFYCGEyBYc8aDgJHGsCDKSMzjyhkpKqtbgb/bvxitNAHZHrleXXP
         L9SND3L7GXHTUYwqM6p3VosBe7NnWIaI8dsbHnwFR8/eFI7WEl4FcspD36VBjJZ27VYs
         gcBA==
X-Forwarded-Encrypted: i=1; AJvYcCUwG6ajpTHONQIiGoXRXyJMi+0x5m+oMVWRE/j3cEPW9NDZ6goCeJ1chvDRPIbsGXcatio5oxt4LsV24c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFuFpg43zzgCIV4mpk0TAO3aK3s1/vV9ms5qml1nI+NwcwkZ0j
	MrkQUice7N/HL1P5V2FK3RbwtfkHZYJSAF/V7KqhdZUM1nqfB0m5qsTAr8FPDwgOQUJ1oYipzWZ
	1Kt8+wA==
X-Google-Smtp-Source: AGHT+IHjT223ixHPtlZ867Co3VaNK/iTGuMXNSGTjzbxKrcxp2k7fEhUUPZbWnem80Goj7dZlF6cMPfNoxwr
X-Received: from plha13.prod.google.com ([2002:a17:902:eccd:b0:220:dd43:9b34])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0b:b0:21f:683d:de0f
 with SMTP id d9443c01a7336-220bbb086b7mr106840115ad.22.1739418257162; Wed, 12
 Feb 2025 19:44:17 -0800 (PST)
Date: Thu, 13 Feb 2025 11:44:01 +0800
In-Reply-To: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250213034413.3808375-1-chharry@google.com>
Subject: [PATCH v4 3/3] Bluetooth: Add ABI doc for sysfs isoc_alt
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	gregkh@linuxfoundation.org
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

The functionality was completed in commit c04f2e4f4ea1 ("Bluetooth: Fix
possible race with userspace of sysfs isoc_alt")

Fixes: c04f2e4f4ea1 ("Bluetooth: Fix possible race with userspace of sysfs isoc_alt")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

(no changes since v1)

 Documentation/ABI/stable/sysfs-class-bluetooth | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentation/ABI/stable/sysfs-class-bluetooth
index 36be02471174..c1024c7c4634 100644
--- a/Documentation/ABI/stable/sysfs-class-bluetooth
+++ b/Documentation/ABI/stable/sysfs-class-bluetooth
@@ -7,3 +7,16 @@ Description: 	This write-only attribute allows users to trigger the vendor reset
 		The reset may or may not be done through the device transport
 		(e.g., UART/USB), and can also be done through an out-of-band
 		approach such as GPIO.
+
+What:		/sys/class/bluetooth/btusb<usb-intf>/isoc_alt
+Date:		13-Feb-2025
+KernelVersion:	6.13
+Contact:	linux-bluetooth@vger.kernel.org
+Description:	This attribute allows users to configure the USB Alternate setting
+		for the specific HCI device. Reading this attribute returns the
+		current setting, and writing any supported numbers would change
+		the setting. See the USB Alternate setting definition in Bluetooth
+		core spec 5, vol 4, part B, table 2.1.
+		If the HCI device is not yet init-ed, the write fails with -ENODEV.
+		If the data is not a valid number, the write fails with -EINVAL.
+		The other failures are vendor specific.
-- 
2.48.1.502.g6dc24dfdaf-goog


