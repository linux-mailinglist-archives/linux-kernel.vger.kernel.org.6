Return-Path: <linux-kernel+bounces-552838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3BAA57F43
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 23:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC7B3A625E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 22:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF4A21324B;
	Sat,  8 Mar 2025 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX1oKnki"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50081204C0E;
	Sat,  8 Mar 2025 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471545; cv=none; b=cPv/BJnIFPyCWdYciL3Ur4mhFFV/s1zyoUKnWHraqVssOus+49C582A28FUNN9p138AOfqrkqSGW04DQxmDn5Kn/fyTlTBJOlhyMWgbJ0wtxI/p/CTa266l6czPFS9ceaGjVx9Q6jOuLbxblvlOniyb8BdIirQBySABkdEcMG8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471545; c=relaxed/simple;
	bh=91KDpFnobQlqpXIUPvBSTVqo5BspmzSEeNNLTweH/yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmhsgoDwVU8gtR7kWOMI2YeWd9mKLeco2/p1x4eH4OSIBz778TCe6R5GwFrE/MVPoJnQmwMfsFsIQAmrBCczRZ10bNglQ9pZBEIkMdtEOYnMXnWtPwX3hmDWgO3tOVVGpEHtoiwr7qXG1Jz/QOBddN0MLRc3fDNQgLOifEsJBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX1oKnki; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e549be93d5eso2676988276.1;
        Sat, 08 Mar 2025 14:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741471542; x=1742076342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fe5HwiRfeSGS1igHNPHt1KQo9bVNCbcmOjjly6dFFsc=;
        b=gX1oKnkixB6Cb4nm9wdyN9LxdwwqL+bRDfI3DNu5P98lJhw9NKo7gJM8Blk7jAImzP
         OKQ14f5HHoUjVKzk/935sa/fpIQCXeaNFGTTj5ua9z4EdpNw14AjnygGNhiOfaRQb7Sn
         KEImqP9wgLQPaSpmL1zbcKW8uVz3sSkJgmhhD10U4PdBTljt/wzWzgPjKa41FkTkUz1R
         ZOxQWuEbn0wOBhUxCFFjmtpiPXGcTiCn4dSpgd6MtD5G46RXQha2I5lkKQB3ehD3JgLU
         CaCjdE6kRNZYPBvIiX4CfrrPxPdsbMyyjOSXI4BGP/o1v0iUKg/Nt7FaOUSU1Bc/3Xdz
         Suxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741471542; x=1742076342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fe5HwiRfeSGS1igHNPHt1KQo9bVNCbcmOjjly6dFFsc=;
        b=PfVxNdnPEGByEGAKkH6BwbR72A44rtwQN7Yn4miq1ZpVpXOh99XxYLUY/a2EFH+Z2q
         L+RHWj9djsteDLiadgmwoBlqV+LiLomapvctsGuBrIzgUWi3l6GfcSci4Ije801Zzlwv
         agMV69HsWuFIuMqqR/UhSCq6jx43/anYGBTydqpQhIjd31YGNaY8wRpKOzkh8ViKP8MR
         D4IPOuti6c5oWk+GpChVWNcdH8eK+7rJ+Y0ZDh8H/SgwZy7B9eeIXXxl1kok9JOIOALS
         3YLnpc4whVjKSW05Y0aHFmvb+kKXFsLOiyuBG17FTMgoGWpVOsn9VBZNY2td2vq2TXV3
         dHAw==
X-Forwarded-Encrypted: i=1; AJvYcCW1NKAeSvEBrXUA1JvsLxT0faBsQklSuBHfquKmi9dhKKYgVUieFh2/GwlTxsr396b/yKffFHu6vgB5jO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVogk/1Oh/ktkosLQSoaAQGbzX5xyfFqJyMhegNRhR7yulX89j
	bTkAB44BuVufPcnp3+eFxDa7ROcZzJL1GQ3c9pvERPfVOVcoC+b8IHojHJVO
X-Gm-Gg: ASbGncsKeKyXuF6aD94ua2JmtTqlobSzB+63GaoRTzh1o1DMvT5AgMicLZlp0z+bn+C
	LsSeMVKHz3GB7vrzxG0GWHwtI9sD0jTcsH3iE8rxwAyKsoB/1am60bA4lZsVKnoyQvLzvzbG0gH
	D2dVwEeFAHrlIA/qXEfvgbjP0kcu47AA1cA+mKdiBKjJkfkL6ugLZ6bb0iAEeqcsoGeQAVX1SOG
	0e/ifOK8AhBAZjfY5ZCUvwwuXGTYqarO/x0nW+bIF+U7rZ+b2zapN/mxDLPUcXWoo/95O4lBAE1
	+jUoZ7Og67ok5FJ4wtL0KfjnE9gtfmMBylwq82uMHbdBMw==
X-Google-Smtp-Source: AGHT+IEhBa/6/Dctzsb/SCt1oQzGs2l4fal8a6FwOUTsEF6X+R/4eH3+flf9JSVAFlwuOQj8tpHRCw==
X-Received: by 2002:a05:6902:2291:b0:e5b:12b4:d67 with SMTP id 3f1490d57ef6-e635c136520mr11040934276.11.1741471542147;
        Sat, 08 Mar 2025 14:05:42 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e634b8e8ef6sm1524824276.36.2025.03.08.14.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 14:05:41 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 08 Mar 2025 17:05:29 -0500
Subject: [PATCH RFC 2/2] platform/x86: alienware-wmi-wmax: Check for AWCC
 support using _UID
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-awcc-uid-v1-2-6360892d8b95@gmail.com>
References: <20250308-awcc-uid-v1-0-6360892d8b95@gmail.com>
In-Reply-To: <20250308-awcc-uid-v1-0-6360892d8b95@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dell.Client.Kernel@dell.com, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2

The WMAX _UID of all devices that support the AWCC is "AWCC". This
includes the following devices which were manually by reading their ACPI
tables:

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
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 46d11b200820cdbaa841fc97e33b339fca42104e..529041f419165aa896a5ce49f889e29901d5b80e 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -1422,6 +1422,9 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
 	};
 	int ret;
 
+	if (!awcc && !strncmp(wmidev_get_acpi_device_uid(wdev), "AWCC", 4))
+		awcc = &generic_quirks;
+
 	if (awcc)
 		ret = alienware_awcc_setup(wdev);
 	else

-- 
2.48.1


