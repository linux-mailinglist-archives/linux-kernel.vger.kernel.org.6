Return-Path: <linux-kernel+bounces-387067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B2C9B4B60
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3D91F2427A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366520694A;
	Tue, 29 Oct 2024 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfcZ2YZN"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C0179BF;
	Tue, 29 Oct 2024 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210074; cv=none; b=sI+oqa/LUQu+GHTvShhnyGhba89+la/gecRcoTq8bSuNh1NFCTEtl6DdXTtZYJFL32rJp+OK8H7UE5w1+ZfceaVeeKmUFNv8sTrRZwFGLef5dqUyOMqGqA4fQblwVgSfuv2HhdmTDwwtvKEmMeeSoVbGghEheblp0CohPeC5jaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210074; c=relaxed/simple;
	bh=W+iNPjpvPWfyl0+zY3OA1YT2b+2i4yk71fEIytlFvRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EODpUHMsqPxDJE3Feu5Wt1f3mRp1Im5hj67KLxnTNY6vcw3qsUwf1+qr6QTI3GtBj4lp6K9+3m7wMSDA0cYzm0HRQwN4o5DzmjPHdduRfCFPreXzZdyTNiafYcKVhjGJGBLiB7ji2kGBkhshzNMUbdbAjrlypj5uV98byAl/S0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfcZ2YZN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so3617455b3a.1;
        Tue, 29 Oct 2024 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730210072; x=1730814872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lSsiuNW6fS5fQddyh4vk69g60M3lKY7TU73kd7oAAY=;
        b=IfcZ2YZNJeIbsyGexsO8pLmXdp7e5BylKleAKk7lQfhbTGwrClIxaS4DPKXjNiP9qY
         WBKmNDLLeY/UK4leNqpNvVuHDTZY0uQ5wrjfncBg/QFRE2UGfYUjo1KKBZpgM7oQyN7T
         nSfLI1igyOVlklLxn2VjaKfN10D87vfOXu51ZujjMwqgb5FOmlo5HZNwLU6u4AQhmpkR
         LOYClbKrQBpqdEmiIVs3vykLb5O6E8/cCFhC/5tlBgiszpFn9BVrI6m+YRbeV2mb1R28
         MIDNL708bCt6c0jqMLONHbBYfb1XN+thmxmP2wcpMAW4x6fFfbDqLEEWEvpORK8XLjWy
         /vXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730210072; x=1730814872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lSsiuNW6fS5fQddyh4vk69g60M3lKY7TU73kd7oAAY=;
        b=q5l3WlAGGEQqnjwnOdKoNi6W/CTEajfQHniGZTrohj2uMSQHIHZdzY/3ZzQJGmHemV
         T8f8s42YrvYbbYdh2Hd1Ach/e+mY4vZDewp9zYniN9VpsQvjKYjF1et8tnVCStvi316H
         8qh17qkEXO14g9sov5OqESP8hK4Aq3ANF/2KogyTZbgIVVLpinnGbenh9LdlyVOYSeTO
         bmnI2gjve4Tm+q61GOEGkX6QAwMD31ge+FsKT/yE1PCzGF0PkwUs9ctetUTY1GP3vFug
         q79uoeNBJjpCjwDp459aQ6odDxnMXlT19e905fSzd6qnIACbrZC+NsJM+V8aAWzHu26G
         rf5w==
X-Forwarded-Encrypted: i=1; AJvYcCVFPA99JDt6V3PWbubndBiczRibwn2a525xCQDKmgEQPUe5fKvfsYuRbT2QOYbuTlutAcz2vmHTpL+irL7ar0ApxvMulQ==@vger.kernel.org, AJvYcCVV7Ddr75iQfK/kDW8qOKOeKVR7+3wbGsMXfga3thv9Y5zDqXRYq/jCdeuJjVUp4PmWoigzjiV4Mt/iqLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ffe+OAkcVMqNNKPF055BYpdfMPU7BStiLxnBAThVZ2vhB8t0
	70Oc85fYq6xv2uY8jy3RLP9g+2dzWwbjksFjmm/ifwhzZlgh1C6n
X-Google-Smtp-Source: AGHT+IFlczKwJF0lUpkHEfHggs5loOOW4Fwu4K7U+1o9Q6bfy1IppTBlCxDUDxyvgr6OobET7vyOzQ==
X-Received: by 2002:a05:6a00:4616:b0:71e:7887:81ac with SMTP id d2e1a72fcca58-72062fdb76bmr16309367b3a.16.1730210072308;
        Tue, 29 Oct 2024 06:54:32 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205793272bsm7524726b3a.69.2024.10.29.06.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:54:32 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v10 4/5] alienware-wmi: added force module parameters
Date: Tue, 29 Oct 2024 10:53:55 -0300
Message-ID: <20241029135354.5937-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029135107.5582-2-kuurtb@gmail.com>
References: <20241029135107.5582-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added force_platform_profile and force_gmode unsafe module parameters,
allowing users to force `thermal` and `gmode` quirks respectively.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v10:
 - Introduced
---
 drivers/platform/x86/dell/alienware-wmi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 1d62c2ce7..91f0e09d0 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -42,6 +42,14 @@ MODULE_LICENSE("GPL");
 MODULE_ALIAS("wmi:" LEGACY_CONTROL_GUID);
 MODULE_ALIAS("wmi:" WMAX_CONTROL_GUID);
 
+static bool force_platform_profile;
+module_param_unsafe(force_platform_profile, bool, 0);
+MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting thermal profiles without checking if WMI thermal backend is available");
+
+static bool force_gmode;
+module_param_unsafe(force_gmode, bool, 0);
+MODULE_PARM_DESC(force_gmode, "Forces G-Mode when performance profile is selected");
+
 enum INTERFACE_FLAGS {
 	LEGACY,
 	WMAX,
@@ -1075,6 +1083,16 @@ static int __init alienware_wmi_init(void)
 	if (quirks == NULL)
 		quirks = &quirk_unknown;
 
+	if (force_platform_profile)
+		quirks->thermal = true;
+
+	if (force_gmode) {
+		if (quirks->thermal)
+			quirks->gmode = true;
+		else
+			pr_warn("alienware-wmi: force_gmode requieres platform profile support");
+	}
+
 	ret = platform_driver_register(&platform_driver);
 	if (ret)
 		goto fail_platform_driver;
-- 
2.47.0


