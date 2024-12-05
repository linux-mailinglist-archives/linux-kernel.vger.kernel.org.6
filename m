Return-Path: <linux-kernel+bounces-432440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA309E4B47
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3476B1674CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB70EAD7;
	Thu,  5 Dec 2024 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I86WDNOh"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB1C10E9;
	Thu,  5 Dec 2024 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359174; cv=none; b=XyplJubREUD4UdSu0wrTc94daarXHaxP/T/KwEADygOEyakcxDrcVzGyaK0fgsmGJU6aWZYFy4HkiyveuJm90gYqZIvwHdZRh7STgXplcB/rbsBVIa5rTM2UrcMwKWnhhkmUPmQOgC1WmqNnGZbM4don+C9RGTuuzFihqQVIryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359174; c=relaxed/simple;
	bh=oiDLwOSIfBhfscSAX3ujLATZAD80iLz59OcKQdAipdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFmJr2UbIHISVE8MRv9rmEmJZpGeSik01QFEyv2jCLUyqgFFp+DjAKYJPFHv8IjCFrFrCgjKjB4vAIf3YGrTfWfcwFfI/8VVYFIWob00PcA13hMnL9vopPqoKMVR6+mq8Xq3h8gODAVw1osFlhUYHW55Vw64PnjFqXzjEWAh+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I86WDNOh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215a0390925so3637015ad.0;
        Wed, 04 Dec 2024 16:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359172; x=1733963972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Chv20732mrKM1AkOSSld1MdFCLH0yzZTS/nsjg0l/bI=;
        b=I86WDNOh5zMSuUqgqoykMGSz6aAcyPfxpEWmlGueCyUs+WS4eyZlEYQdyAcgp8hPjW
         kQHKCQkscoucd4eGcyhDVy1vab5TrG6TB0CwbEALKljzjI67VVGQzxzltXjDKTAyYPfx
         no5d+wp3tIZJAfgxi/bCOGka4h8gNBPwSoR3qBBRpb+lYmIFuvi7uTWFCX/GAvIzMWZ0
         5NPLhciBHxoQs6/weaxnmDw0yGxBaWpBoxaTbNXtXdGBW884f92AaC2Bia69z8cuU2P1
         /+H0W3ucY4aF8EgGs1g4SPYRHQLUBYhJQy7cz9nZUT0yrWYFRUPTQ3qoYlTPYNfXGp07
         v87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359172; x=1733963972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Chv20732mrKM1AkOSSld1MdFCLH0yzZTS/nsjg0l/bI=;
        b=Pi69oFQD65NvLCCh+67jIKBw4TSdRx2od8B27t/zoEk/yeomqMMXO5MIA2Rv+AghMi
         zBflQ5goxt3mCI2Jx5bSjvuJkwSG+3sgKd1X/6mS08jnCK9U54WtWudX4eaaGdJbwwc0
         vXx9TtD+OeSHDD9I+ZrEaJufBklPPsvZ+hYa54ea59hC67Im2Vc+6wjH6y5B/n1R+Rjx
         ycYas8nq/43MsOSfILaVhxPG4NLYigEkKsDS7qMlJji21Gh0n2oWBY5d2HqjRKOcVwX/
         S4FwSH+q79eq2mMeGuX58hckAlMR0QJv4B4GDZcZJUCqCxHRo9jUIYOPUZakz7xZ1V4q
         DvVw==
X-Forwarded-Encrypted: i=1; AJvYcCUNfSdJsBivy7qnW3XtFfsGH5HKrZoRlyAv8aKhM9P8whU/Xs5YdpkejSUyfFG8TJ8pe6U6pTJ0eBh9Q3OE/WZvlWIfsA==@vger.kernel.org, AJvYcCXSZz9Bi8S1s4hcba01bQXQ/XbaESSPQS7xadOo6qFwoPry5e9MtquLUmuT+KuhjyxX3M5XjAPKltMpm6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLDNmZjmqGtMAM9AFcsC4I3ifx6zgBehbsz1VvfYqASTpc8eNO
	sbJL1RwHhd3/w3vE93W3Fp14vVA9XKVvAtolrHia9Rrxf/UexD/i
X-Gm-Gg: ASbGncv216FUH62WnV3hRDO3kseGnJLcB7hm2hrjRy+9pRajl//2KjLs1jf9HoWYWcX
	cOO2fSEYsfyO2aWwqJPzrr0r8VeqRvTGZm3FD6cxhP0fn/d1vIfAIeumxA6dY7ds/CRV10Nzqhh
	VoHVMmg9XBqx2Gw+KaTGq3ieZgTjxbgp2RmWCNjAHXCDK+AwF50N50zX/ruwk/KUKGVoQzZ+u64
	WfuXaHKBMWNnkS45WgZn3Uv1UeDMqr16dlCmD46ZxkEi9tx/HfugoGFaPI+zVh/RaZvIySh7diQ
	3XyiHQpoCAusjdwKRtc=
X-Google-Smtp-Source: AGHT+IE/YU3Qk1wNo1krwWt1NDU/wozjOIm2pvdy4P0U/qbQkmBfa0fvehY2lP0ZeEqOduOpX2Ve5Q==
X-Received: by 2002:a17:903:41ce:b0:215:5ea2:654b with SMTP id d9443c01a7336-215bd1b4981mr123623045ad.1.1733359172069;
        Wed, 04 Dec 2024 16:39:32 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f09167sm1285225ad.200.2024.12.04.16.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:39:31 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 03/21] alienware-wmi: Remove unnecessary check at module exit
Date: Wed,  4 Dec 2024 21:39:07 -0300
Message-ID: <20241205003906.2184657-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205002733.2183537-3-kuurtb@gmail.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Module initialization fails if platform device fails to register so it's
always not NULL at exit.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index b1ac0e393180..115b3aa5637b 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1258,13 +1258,11 @@ module_init(alienware_wmi_init);
 
 static void __exit alienware_wmi_exit(void)
 {
-	if (platform_device) {
-		alienware_zone_exit(platform_device);
-		remove_hdmi(platform_device);
-		remove_thermal_profile();
-		platform_device_unregister(platform_device);
-		platform_driver_unregister(&platform_driver);
-	}
+	alienware_zone_exit(platform_device);
+	remove_hdmi(platform_device);
+	remove_thermal_profile();
+	platform_device_unregister(platform_device);
+	platform_driver_unregister(&platform_driver);
 }
 
 module_exit(alienware_wmi_exit);
-- 
2.47.1


