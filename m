Return-Path: <linux-kernel+bounces-416114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D939D4067
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE0A284075
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ED21B5ED2;
	Wed, 20 Nov 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip6V25f5"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C446145324;
	Wed, 20 Nov 2024 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121061; cv=none; b=FmynE3UYi49t4kpa1nVbebbSeZNjq9XE6jqD0heb9k56oXnTFyCyRoGgdgEHHouK8uwnB+DyHlxKdUmjFGzPMevluBPUl+DnfC6iEfZvmVwcaeX6R18ashDVBr9e4eCaz027GIJyntVXLfponyx9J5HuNJfNJ5ro+r4R3shDerM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121061; c=relaxed/simple;
	bh=JEpLazsZjAg5nNc1Jsdqele5JGu5yU/uzWcLgQUt3qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLAmS2PlqEa/RMkCW8ud2PuK3mjri6nVryTy+7TBHwRlW7i0ZB9gu/8TQKSYi5DhY4+OVdd0HJw/PvRaUruNYxXbXzeghr1I09bnarWKon6p/EoqXf0bwRjm6J6+7B+fkhEfuBMD7hE0OWJoVHlwmkNgiqPy+HNXuavCJuCkLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip6V25f5; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-296bff3f5e8so1183170fac.2;
        Wed, 20 Nov 2024 08:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732121058; x=1732725858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4SEWInomL306OQQOdTEh7Ay90+RuyHjfWpHiTKMYlo=;
        b=Ip6V25f5VEnyjju/rmD48VDpPjCMm2Gpfa/mP4hQXgT9hcNtqeIVzMzbolrBJadWmx
         C2bQtoK7RU/40KRNq/BP4gIYGaxch5fO/VwGJKOoY6ZBp3YmGMg4qGghovfUTqK54kdt
         wXfm61ofBkgQk0HnjH5gkXrMUSop98nrhnXhUKml7MV7ol1HvhVCFxh7hWmhS5BOsxuT
         qJ8maDp/58GbAmuDdNMsiaWlmTD6yx1dB/DCObKbRz9YOmNZSp6HXU8JedIGMAxvQE9l
         RPMvAzI92VRzHNZBk9iBFDXHz2nnkq3gtWKFlQaQCeCG7rsjMQtPDK3FDlfyX/+i687S
         +Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732121058; x=1732725858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4SEWInomL306OQQOdTEh7Ay90+RuyHjfWpHiTKMYlo=;
        b=LhPS7eRI40UWK5OD9+cggjBzXAQsSUfNZ48cWumNEbHJtMW35ifxTnHU5mpItEqkAf
         lL7iHufUlOOs0UkZyXLK/WL8l+1XGP0kuChONOY3+P7VoeVvQWigZ8wbNbDbHAeZs6Bv
         00o3iyjW9/CrG0+XzZ6gz629STLja4O6OsZIXt5/0i8v77gyCddcs5me5kOk/btHUyC1
         Gqi1+Ckl/jaCsqFOgBIRVY6DiZmbp0NLlF0qKR/dh3Sae2k4debqlR6/FtScDC3SGi1J
         qQ/Nb9XuE4H23VmV/VNG+MIOAaTHvXQp5N21a3BeVfKJfKbBRpDIKhyBjAOzzhpDkehY
         gBiA==
X-Forwarded-Encrypted: i=1; AJvYcCVYREoFArL/DoxwkjPkrLuLGs4bnOkdiu9HD8TwGDwVON0es/FFRt8/J1qNjDZdMX6Cs1DOI7QCcSZ5SOA=@vger.kernel.org, AJvYcCWwamTJlf3JqwhYtNzJpNCN4iIGx2xKHUs1Mr9O+hmQw0lO7Yn6WMupPb4O6ZH357dpfHcW1Kr6J6eSbZ+1q11tfBKtCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHN5AEnYVKW7PHFZOVPsHPi3/ykeGzAylEXomSGeLftO0zrskO
	IYGBFgHFVywKdgP6ITyhxqT1aTB1tBvqVxSVzdxFN6ryhSRTwwiV
X-Google-Smtp-Source: AGHT+IFriDItI9JE5iNNfVufzeBy/Mwq2WSUEO/UM9Bb4ULmX6zGZgRukjQkjRvw7yUqnT/Bf6KnKw==
X-Received: by 2002:a05:6870:9898:b0:296:e0f7:d690 with SMTP id 586e51a60fabf-296e0f7d91fmr2139791fac.3.1732121058567;
        Wed, 20 Nov 2024 08:44:18 -0800 (PST)
Received: from localhost.localdomain ([181.84.94.92])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c16f36sm9752101a12.17.2024.11.20.08.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:44:17 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [PATCH v2 4/4] alienware-wmi: Remove unnecessary check at module exit
Date: Wed, 20 Nov 2024 13:44:11 -0300
Message-ID: <20241120164411.7471-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120163834.6446-3-kuurtb@gmail.com>
References: <20241120163834.6446-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Module initialization fails if platform device fails to register so it's
always not NULL at exit.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v2:
 - Unchanged
---
 drivers/platform/x86/dell/alienware-wmi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 512f6b22585c..5e0acaf35952 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1197,11 +1197,9 @@ module_init(alienware_wmi_init);
 
 static void __exit alienware_wmi_exit(void)
 {
-	if (platform_device) {
-		remove_thermal_profile();
-		platform_device_unregister(platform_device);
-		platform_driver_unregister(&platform_driver);
-	}
+	remove_thermal_profile();
+	platform_device_unregister(platform_device);
+	platform_driver_unregister(&platform_driver);
 }
 
 module_exit(alienware_wmi_exit);
-- 
2.47.0


