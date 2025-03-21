Return-Path: <linux-kernel+bounces-570904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E00A6B613
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E577A553C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306D51EE7DF;
	Fri, 21 Mar 2025 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY0PUfwh"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE71EEA47;
	Fri, 21 Mar 2025 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742545822; cv=none; b=PsrU/8OKYk3dl4AQBCXVUqaUCjnGtLr4dE5r92je+PHAYgCd/aNkkU0IpOgptyfFL70LhKEgbjgLRq71YdQqLyFajY1yOz5kiT1xjIHy0cPEVHQQBA3VFSrvDcxvQ5mCG098HS9QWrox7DtwlfOsM01Rz/lA/I71gny+fxOL4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742545822; c=relaxed/simple;
	bh=20ntTnSxBTYlOfH3SOzTPYFdSiJFquWr9w7esxYqKeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=b8rTvLm+9WFKADoAHcP0M8vTMTfcDPIX3wCGX0LjLU/oM1yh/n0xnYlZ1Aq3sNHFlYY48L0XRwViZBswT7FNXBSvgSifVgo7MaeXjdi8jWHdVrwo3p735TBhiyAoIps4gwvT3p46qlglDyAGFOK1IlY4zVYjVd6jfyIfySDm3Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eY0PUfwh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d0782d787so11907055e9.0;
        Fri, 21 Mar 2025 01:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742545819; x=1743150619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oOx84blwgw6z93U5khVjxGdj11xiT8ylUeWTTvHcXRw=;
        b=eY0PUfwhSsVbXgOEKltYZwhObn9XZ2j14cj9cM/eN5Fj4P35ttix0dRLwD1YT0ukEU
         W1qN/leibv6H6ZMReKgsQ8SHLYmk+/0bvMOBAGBvp2wj0E5WPwZ/gGaMUDcHrLoTgOMM
         GsuD3GBN3Ty4gQ79ESxP4ggRcbjmsiNJvYYVqpovO4DhVV9RRTAbQfCP3HUv01NyRK/i
         zLnTXKssjoin/9BSfVL+5FAXJrV+f24S2VdAH8rHkP+CytzsvnGOLTCReSRJ0LhSZhf1
         efx6Caz57hXS2cTP8VUP5NRolkzNQlqZOexKU+RAB2RcvOAxwhtyAeTKzm5bWMdjj/id
         QPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742545819; x=1743150619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOx84blwgw6z93U5khVjxGdj11xiT8ylUeWTTvHcXRw=;
        b=fTc2iSooS9+D137drYs6w+Cx4642a4x/ERKsQbJVb2i0iRFPqpiltxOn4gkeW5fZj3
         vWANoAJYIYAyAD8vmYLrlpkGPU7MoJeWCAN4TLexXdyf6G+PpRVoktJPF/IrpqQh+BK9
         2lbJQTc1ha2/LXm9ieBaWFFqLp7n4rvy5qL/qDvFpPPrVwHkUX7BEpbGt4hIo5t8RPGx
         PkEXs3N3rKHRns8g34UjMg7J6/kfjfzDm//1LmAwFWxQfm7/dcjeudSW6oH3AbUHrMhL
         5bngwezWNMhFDnJvFwnzO8KYH726ARfILQgersbBdtRiyu+Mk9lLk772ahUPVWShfld6
         c0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVguGNcJ+ztqG2lzVYlt84Q4QVYiZIhlHqDfHHD2O0h7nk/A69bMqNmlvfVh+xeRF3LAmg51SGo6sFvO1o=@vger.kernel.org, AJvYcCWeF/0JkNkGU1PDNOHJx8GyjIVmDZ2VBYvmZ1XDK6klwczG+LfbifO0WoZLbw/W5WGDtlTHvMaXlmn806ZIePcdisb0qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEk8pEiOL+rsqq6gSrkVNvwa+OOCDTGFXHkK3jQptNwpA9UbwD
	E1D9Yuy4v4onrm7uY2cF57G90Tar4+tNY8ipJu4mcs3ot+mdTkTH
X-Gm-Gg: ASbGncvBThn1FnMfguTZMOqNdF4SuTtcvTWwQEZQFboRJhahYhXvllb0au+sJOsNj/9
	r+x7BflWap++kIoRRUQi3LtT0ZjZXNEsp7X5rl8kFL4Y2ARkf5dz9PheHbFit9JQDnOIOrYZrWq
	1YlxMjFLBBcPLAiA8E4rPnJC+K1Wdkva3DQ8Wq/pgOT5SpRbM/99IUbsRJMmwqC+VHCFNbH3Ch7
	U49C9/hi+aUn2SKIPI1FMZ/TbwjYqVq9yhCcsm0mTI8irNOBi8K1WdpM8uoLqk92wvSi4ERP74t
	Z1Qsqs9rX4Bmw95BJhl66WptWZHEuzbPL0h8xg15deqTDP95aK9N4HEAawPVHb4k4XA=
X-Google-Smtp-Source: AGHT+IGJGgiklQ70AszSCwdy1jPoQz1gmo25oFygNnJ/kYaXl7f5SlHjGxjVDYPc43ottyzUVYjj8Q==
X-Received: by 2002:a05:600c:1d92:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-43d509e3881mr18748495e9.6.1742545818824;
        Fri, 21 Mar 2025 01:30:18 -0700 (PDT)
Received: from pop-os.fri1.uni-lj.si ([2001:1470:fffd:32ff:2811:7660:dd13:7df9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceb780sm20343215e9.4.2025.03.21.01.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 01:30:18 -0700 (PDT)
From: =?UTF-8?q?Ga=C5=A1per=20Nemgar?= <gasper.nemgar@gmail.com>
To: ikepanhc@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	=?UTF-8?q?Ga=C5=A1per=20Nemgar?= <gasper.nemgar@gmail.com>
Subject: [PATCH] Added support for a some new buttons in ideapad-laptop driver Added entries to unsuported wmi codes in ideapad_keymap[] and one check in wmi_nofify in order to get wmi code 0x13d to trigger platform_profile_cycle
Date: Fri, 21 Mar 2025 09:30:03 +0100
Message-Id: <20250321083003.84661-1-gasper.nemgar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Gašper Nemgar <gasper.nemgar@gmail.com>"
---
 drivers/platform/x86/ideapad-laptop.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 30bd366d7..a03377d87 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1308,6 +1308,16 @@ static const struct key_entry ideapad_keymap[] = {
 	/* Specific to some newer models */
 	{ KE_KEY,	0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
 	{ KE_KEY,	0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
+	/* Star- (User Asignable Key) */
+	{ KE_KEY,	0x44 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
+	/* Eye */
+	{ KE_KEY,	0x45 | IDEAPAD_WMI_KEY, { KEY_BRIGHTNESS_CYCLE } },
+	/* Performance toggle also Fn+Q */
+	{ KE_KEY,	0x3d | IDEAPAD_WMI_KEY, { KEY_PROG4 } },
+	/* shift + prtsc */
+	{ KE_KEY,   0x2d | IDEAPAD_WMI_KEY, { KEY_CUT } },
+	{ KE_KEY,   0x29 | IDEAPAD_WMI_KEY, { KEY_TOUCHPAD_TOGGLE } },
+	{ KE_KEY,   0x2a | IDEAPAD_WMI_KEY, { KEY_ROOT_MENU } },
 
 	{ KE_END },
 };
@@ -2093,6 +2103,12 @@ static void ideapad_wmi_notify(struct wmi_device *wdev, union acpi_object *data)
 
 		dev_dbg(&wdev->dev, "WMI fn-key event: 0x%llx\n",
 			data->integer.value);
+				
+		/* performance button triggered by  ...  */
+		if ((data->integer.value | IDEAPAD_WMI_KEY) == 0x13d ) {
+			platform_profile_cycle();
+			break;
+		}
 
 		/* 0x02 FnLock, 0x03 Esc */
 		if (data->integer.value == 0x02 || data->integer.value == 0x03)
-- 
2.34.1


