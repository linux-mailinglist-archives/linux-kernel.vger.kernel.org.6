Return-Path: <linux-kernel+bounces-552898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F03A580A0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 937D57A643C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 05:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB4415B971;
	Sun,  9 Mar 2025 05:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4a68J8c"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D901B1552FD;
	Sun,  9 Mar 2025 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741497238; cv=none; b=pewzLeYhbS8lCgABTT3GFRG9gMWyUc6tvxYvoUhWSlVytEZuYEocxzBbu+ZriPkyf1TH0wrvCHIp0xIH4QQS4XLL0KM0Ir/AHpBTB//ZYS1bSlgVtTb27kYuh72aC1neoRBn9W1VammURHpU5LcUUc6MpbZh4HO5xGV+4U++E+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741497238; c=relaxed/simple;
	bh=s4dWCCcW1SUcdWfAao3aZ2riD6vvtcWPAEIb9+C06P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GeqzGt8JMmRC+NwBmO4za9LnUC1YD5m6/k1F+xWykaMPzNHEZGw9rcxqRpb9JDDVz7z8uAPCylpzH98hD6DLXHCLF8I9R2vwnOacflAmU6UpXMP0LD9ONtqggBjDqjeXXg51ihoBlZIWJmCjtZojQlwEGEL9O2UzFTPcKggkReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4a68J8c; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fb2a0e4125so21872017b3.1;
        Sat, 08 Mar 2025 21:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741497236; x=1742102036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7AMD6B4K+2sdmmck6S5/MfQ988ecaOuF1ddzeVodgi0=;
        b=U4a68J8capQqRCL3d5iN8oxqov0Lp9rPTbWQ459PFWCup+G1VJGzjH42xsJx/cwiUE
         AGNchlWovt+MB/tM2BtD4CA9pZZX0GsYtW/aa48qrCIH57/5okj55fPavXVyOM7oDNLN
         BIJo2PLERd6UTRFeFg5usRdJVN7zwT39AqQkxJoF5HPwYDxjllo48k+HnTNB+OzcQ2sO
         cIhkdAXqTuq/mHlaj2omr0fS6oe4d9s1TEvGIjKWfbf/wu6RQXHTTroHMO8jcztV8A6J
         3luDPCPUPOLs/d6SHEOIuJ7K4kkQkmMoQJl9jomo5PUBFDkYWPOzNMd0tvcZTNvsf1IG
         lOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741497236; x=1742102036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AMD6B4K+2sdmmck6S5/MfQ988ecaOuF1ddzeVodgi0=;
        b=lgtZyQhgDVJuoZkp2iE9yU/FjwkNNLJADdpIgY36e/kzo4cs+GaXyh/pIpmCKYhKHX
         Tq3cStPzqPJ6hcfiBAOTb9j9nZKfWm370chEQkNR7yy5mBT7f350s9akj9QXcaOg1rVx
         W1+GfeTmZLmTHK7fx7/ItbODwlWtsX9fMmJQEygTMHMO8wLT6wNO4sdlvKfMACM+IqOy
         c7+VF9GXkuQc5Ab/u1D0+0CqjF7355qIFF2MfhNGMOtKP+3ywmM4a7xS6ph8tDqpLDzb
         Tj2JGm3hZHjLeQ94+igWVWZ3PqwwwoUyVP9NIgoJK3ldA9U3MwQDHhqEJ1oP7F7U7szG
         Vftg==
X-Forwarded-Encrypted: i=1; AJvYcCUFpSFTh+NdJdvL/zD4Cl8NPuwbjpLgy7owbcggff8aiBggO0QMOInqR/5F1j2pFebfB0H83c+5Mdrp0Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzymOg5zv2X67Zzu25GSDuonYP3OCZ5ML/5oLJLdxv2ZB4aCXSy
	O5hmUlKpbhC1viG7uI/FuHpr5mmmEESJeRv/bbDLSufgB4lnkN0E
X-Gm-Gg: ASbGncsO2N9DQG5hi8chaQPXCKEJdl88aavkyKl+4F2+e4ozdEGOGKg1J8L25DQFAm+
	aokWQtCa89lGYv3UnfPr3ZkFEWTL7jNjlbkz6LSuhYN+QPwvIlfzlkeOg/q9ge5fHWAXdR7owEp
	Pe2nW4uQYqywrVccN3f0VNoSUg2ftmROQmSWrBZCsFMCf+IN4ghG1in6MLq7cd2FmSXv4mDHYwp
	Vv1uXnB0Xok5vXxrEH1VOiDIAmGgtsgkwxFoKQcir9qSQf5J86xdPQEPNePquwGyA3UZI9Iv12s
	3RXL+IJyfB/R28y1Nc6A98xg4vi+qmYbZzzPVmZUQf2PJg==
X-Google-Smtp-Source: AGHT+IGGJ9meGRfI1w2PfT8lSxiRVjEztsUkAxWNS6zKiL9ZJRgJmfytJgNET5f4eEMonpRR9ItkGg==
X-Received: by 2002:a05:690c:700d:b0:6f9:97f7:a5c3 with SMTP id 00721157ae682-6febf319c11mr133526167b3.18.1741497235669;
        Sat, 08 Mar 2025 21:13:55 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2a1bfc5sm15232747b3.24.2025.03.08.21.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 21:13:54 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 09 Mar 2025 00:13:41 -0500
Subject: [PATCH RFC v2 2/2] platform/x86: alienware-wmi-wmax: Check for
 AWCC support using _UID
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-awcc-uid-v2-2-5338c6380b2f@gmail.com>
References: <20250309-awcc-uid-v2-0-5338c6380b2f@gmail.com>
In-Reply-To: <20250309-awcc-uid-v2-0-5338c6380b2f@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dell.Client.Kernel@dell.com, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2

The WMAX _UID of all devices that support the AWCC interface is "AWCC".
This includes the following devices which were manually verified by
reading their ACPI tables:

  - Dell G16 7630
  - Dell G5 5505 SE
  - Alienware m16 R1
  - Alienware m17 R5 AMD
  - Alienware x15 R2
  - Alienware 17 R5
  - Alienware Aurora R12
  - Alienware Aurora Ryzen Edition

And possibly many more, if not all devices with this interface.

Add a check for "AWCC" _UID in wmax_wmi_probe() as a last resort test
for support.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 46d11b200820cdbaa841fc97e33b339fca42104e..1a81373a9d5937b4ff5511ad2061b6dc6e40b810 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -1420,14 +1420,17 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
 			.upd_brightness = wmax_wmi_update_brightness,
 		},
 	};
-	int ret;
+	char *uid;
 
-	if (awcc)
-		ret = alienware_awcc_setup(wdev);
-	else
-		ret = alienware_alienfx_setup(&pdata);
+	if (!awcc) {
+		uid = wmidev_get_acpi_device_uid(wdev);
+		if (!uid || strncmp(uid, "AWCC", 4))
+			return alienware_alienfx_setup(&pdata);
 
-	return ret;
+		awcc = &generic_quirks;
+	}
+
+	return alienware_awcc_setup(wdev);
 }
 
 static int wmax_wmi_suspend(struct device *dev)

-- 
2.48.1


