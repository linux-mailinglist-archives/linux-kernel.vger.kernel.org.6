Return-Path: <linux-kernel+bounces-389353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9919B6BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6E528128B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BE21C7B85;
	Wed, 30 Oct 2024 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4cLZCA2"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC45782899;
	Wed, 30 Oct 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312045; cv=none; b=JCTW+2rNq8bTrPsdK3kROBKcGyUlxkJI2CVtyvWurk2zHolwujPjXpcwKTIKJxmZ7aTTnXJFsi1qbMkHUfsfhBZX1QqNQIof2dkd5XXcxTRydQWhIPzl+K8AzVRIaYJIVaWX/j2UcxovZcQ0HPRQVq6j6NYMZy2Y9BiE2zItyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312045; c=relaxed/simple;
	bh=vQGLDvC//5UuLZbwpNz4mLj0QnQoieLrUg1Mu9HqxcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUxfbaiL4RQjMnbT3DJd02aRj2e0dS3qVr+nF7yO9KnJYl3BiEZa4vk7pFppTan1eqpFbCYLxE1i7wgVrZW1z12E1suprGs1qmM5MQIz3F5+v2FN//b/z6aLpMNdPRnCt9nV/AG0sxwgIwTQE1noarvt3/XpGyOiIfWLfkbQXpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4cLZCA2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-207115e3056so1572705ad.2;
        Wed, 30 Oct 2024 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730312043; x=1730916843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul+Pl/Ozs6/5C7BWBiHw1ape364+5ol2TGx5LB/4/YM=;
        b=H4cLZCA2JiE9r/hO68VDdSUBZuIHvJmbZRkwolmD3w+g8BXjvdnmglC1LM+R3dm11G
         WRdURLoAeIQC+tvI9YwWMgymrZngb/lc0zWDsfV82BTi0ZfJAAzCXGYsCyK6sj1eRHDW
         sJFWPOBBW+Zbru9Hjg10Jw7Yt2xz0r//S5tmUaH+SI2rbHJSmyE8kH3qONy2iCJPsSYt
         1LUYenjGVHdRUH/wMU0xZxfUkZ4m8h/jrjHuSTSGb3y2OgLGQxyQYcvvLEItZeTUxvsn
         6j+t0B/b53Jr0CtTLk7sTxWmy8idpWAfVGQNcZ9lCEqlLmmI3kpF7/lGfUQJYwp4usii
         cWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730312043; x=1730916843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ul+Pl/Ozs6/5C7BWBiHw1ape364+5ol2TGx5LB/4/YM=;
        b=nGwxJdIWGkAKlNrzMZbRPdr9Q3vsRZk2ATiQheMGm2Sg1CpAfYTeJm47nATZXxzInu
         QOkMHRUKvhSs7BSCu1mncTXUvzG7yqFjY2shG9t5IFzdoWMZF6R46VBrthCgsxKH3TLc
         m0wvj9LKMr9FQT+jq8DNVjMlMw64OTsiZRd2Pfk0TC7Uk+D3YwCOyD6deojabBYxk9ZN
         a5/BCzgFP89Le3NPbzyhxrZAifo7iLLaNp8MUN0uV00mSs5nBJRr8mA4lU4Zg/4WI5FF
         Ddkyb6TTxs1m40XWUbQm4pKoPBm/kS9KxPiVv6C2q98i2GAin6/gIVUi013HBvhENjtd
         pprg==
X-Forwarded-Encrypted: i=1; AJvYcCVWMTvqRFwOiDQ9LkyQiqFBMgYCMF1v0IK5noJEFjHqxfTtgAbKu2XStV1BCL9NHi42JYhMd4sbhACJ9FtQGla1+gC1UQ==@vger.kernel.org, AJvYcCXEWXnK4WKpmhwFPX/HKVhirXQepyA3/q/RSeN9RwzbakklvAhQlHoE4nSd38xR6kJl7dtDdcg982zQ230=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/PrFeM8u4LfZi3HFfwZd5eP8LVPhNHPKIpmHmK6Jr8V6H56g
	O6MEH9YcdBJRkmu1HG1oIRVIcuBviBXqeJNANyZKrQBXBzVXr5s0j+1Q4tGC
X-Google-Smtp-Source: AGHT+IHgE0ywhJTY9zhWwvJY8jXxHbSPMZdLGZz7bNASiTOqjHI5h5BUD68Flfm6Yaa7QXnMylCOVw==
X-Received: by 2002:a17:902:f547:b0:20d:2848:2bee with SMTP id d9443c01a7336-210c6892da8mr225121135ad.16.1730312043205;
        Wed, 30 Oct 2024 11:14:03 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d2b1sm83605455ad.85.2024.10.30.11.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 11:14:02 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	w_armin@gmx.de,
	pali@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH 1/2] dell-smbios-base: Extends support to Alienware products
Date: Wed, 30 Oct 2024 15:12:45 -0300
Message-ID: <20241030181244.3272-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following error:

dell_smbios: Unable to run on non-Dell system

Which is triggered after dell-wmi driver fails to initialize on
Alienware systems, as it depends on dell-smbios.

This effectively adds dell-wmi and dell-smbios support to Alienware
products.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/dell-smbios-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index 73e41eb69..01c72b91a 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -576,6 +576,7 @@ static int __init dell_smbios_init(void)
 	int ret, wmi, smm;
 
 	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
+	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
 	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
-- 
2.47.0


