Return-Path: <linux-kernel+bounces-432457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E707B9E4B6E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5969F1880519
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF15168B1;
	Thu,  5 Dec 2024 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGwSyzbq"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457E10A1E;
	Thu,  5 Dec 2024 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359564; cv=none; b=ULU369maJbVUz+L1PJuWa2PbvaaRHRtlHfTXcH1pXXqsyNq0yfvLpfiZmFgDuY2Hr5sB0w5aMHVgHE8WYdPiWKB+pO7XMCaj8QtkC4wwLYu/uQABnQEVIAp3XfL8zU1WXTkPCnWGzkv+FJyGAQgwCI+gSWQ/9lwRa4Km85kJcu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359564; c=relaxed/simple;
	bh=DDSnkLRx/hpCsj0oZsDNoPzwOrYYZ9lCtPony0GX3+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHr3QfWcw2/n53K55mWCs4PuX0QwuFM//COqUwp5cRHSNSeNiISjE2kqoZssrMln1GPDYO0HUaeDRvr3RajabWot93ZqGSUhP48Jkv8qbGxPKUnCaxR1UJHHHrMOaJsDi7y110ngl2auBjq9b29P54XRbGxb18FOH5hg8gSr0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGwSyzbq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21572ca3cccso2774515ad.2;
        Wed, 04 Dec 2024 16:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359562; x=1733964362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfA05tZFHk4htG1XoeZapn1ays+eOzOi9+0JezvQoOE=;
        b=mGwSyzbqNkZs9VjTLc4K+aL4ds6as7e4NddSO+lCPdUQjc1Fb7NrPVmRkiBGI/lRBm
         rzEc15z8Q3+z4pIqzb9pMd6Z/dP0TfeLLxanQDaR+jA1SF+khqAFdUTLHqy0Ln6mmZQI
         1CGYG6iB/syqExX7D8amLO9TdJv6Ks4U4Dn6CWvsk7vVYaw69W7McnAZHZI5z2V2MGvt
         BVn2dAZzdxK8c6tKQEJjWSy8uu5tlwSX2oI6qg4pbmdqPQOl9HIFoauCGNZw3fG8uoST
         WJ2/Fy5gajhVGMv00F0mo00Lz+gmm3F4ygLJKzWgzwY1p9Bjpb7GDhIRHOLm1hfz4S8O
         UHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359562; x=1733964362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfA05tZFHk4htG1XoeZapn1ays+eOzOi9+0JezvQoOE=;
        b=V2PIestjfzLekU9C7wP3BAJfAfzZdDXGgO/JpFF1ZaDnQ91FYL9JwDS/cIESYVQODT
         pslwKGxYm5/YI/BvCQxX5SbpLF3zDxdSuH6Crq53PJn6CfEoqrV2lVt3CBFn7qjtR9Xp
         vRUHJk5U/T0irjn7SyVY/l5TNRN3lk2G/IKmnGmlk+CFDoi+E52Dk1JDJqKbQUtjW0Nx
         iqyOlGjYkIaB1gG5/pnQ1o720whuVrBwY/C0Q0XtmxdszdgmAj9Upxf4dhFUM4W7Z7Nv
         e6XcWuq2tXANaCGwxEf42gtlD3GxOBPGxu8IWfwfD2c6Airjvqf5z7Z2d9mJFvrSczPM
         SwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3GVg61b96W7FdKgs8HZw0bTQomjA7tyZDxO9qveBde38+bl2TrlWTbFyi0lU8pI9GrC+VmvmKHLkB3arUmVxX9S6dDw==@vger.kernel.org, AJvYcCWlTDleyTPVaigc94zSz1wpAKHh+WZPE1P+QGVLsaM8zS5W9v6iJTeTW9n38KvDJZEIpiMOr+8/OnU58Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsyqAMhChCE4MdzukkYf1HDzS9ngFiDUdrj9+wSXk1AQCm7xC+
	sKh84VmWi6TDcnzl07fCEseCpNzadnC1WJyjlus2xp5qNZL+uTuLYXgrsP1u
X-Gm-Gg: ASbGnct8ubNtsEpJrBGNSC8MkAOBejXLntKqSUZHK7ON3dS0A1J7MkEz/MDWPNV//Hk
	WccSTs/4RQ+X1KVyw6n27u4PZbFIrz7DSlyz+XnQYz03S4WJsSjavhOuubUBVMpywZfERmkr9DC
	De1yc/6aAfpnll1YzKsUcvjc528/K3oEWz9sVZIpl9flFYsvhRgMAPXRuF8soPxqN0dOA6h+sGx
	A/9fFFnEl34uPzv8QJ/okl5bqvZI1QCFiB2jE5g+JvxihNI4g97lyt8bqaf6yMjYLYomyVNaDaD
	qF31e4W2Wcf4AXV3fSo=
X-Google-Smtp-Source: AGHT+IE026MuLGTKCZJ0jm1xys3jatnyTlrx3pVvJs3ZKKoA0jNN+3LgUZmcuXKx7xSr8NPb/UvMMw==
X-Received: by 2002:a17:902:e841:b0:215:4e40:e4b0 with SMTP id d9443c01a7336-215bd1b46bbmr122689305ad.9.1733359561975;
        Wed, 04 Dec 2024 16:46:01 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a9050asm102329b3a.123.2024.12.04.16.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:46:01 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 16/21] alienware-wmi: Make running control state part of platdata
Date: Wed,  4 Dec 2024 21:45:35 -0300
Message-ID: <20241205004534.2186539-2-kuurtb@gmail.com>
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

Both WMI devices have a different "RUNNING" control state code. Make the
WMI drivers decide which code to use, and refactor sysfs methods
accordingly.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 25e0139ed78c..fa21a50d66bd 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -431,6 +431,7 @@ struct alienfx_platdata {
 	bool hdmi_mux;
 	bool amplifier;
 	bool deepslp;
+	u8 running_code;
 };
 
 static u8 interface;
@@ -576,18 +577,18 @@ static ssize_t lighting_control_state_store(struct device *dev,
 					    const char *buf, size_t count)
 {
 	struct alienfx_priv *priv;
+	struct alienfx_platdata *pdata;
 	u8 val;
 
 	priv = dev_get_drvdata(dev);
+	pdata = dev_get_platdata(dev);
 
 	if (strcmp(buf, "booting\n") == 0)
 		val = LEGACY_BOOTING;
 	else if (strcmp(buf, "suspend\n") == 0)
 		val = LEGACY_SUSPEND;
-	else if (interface == LEGACY)
-		val = LEGACY_RUNNING;
 	else
-		val = WMAX_RUNNING;
+		val = pdata->running_code;
 
 	priv->lighting_control_state = val;
 	pr_debug("alienware-wmi: updated control state to %d\n",
@@ -1249,6 +1250,7 @@ static int legacy_wmi_probe(struct wmi_device *wdev, const void *context)
 		.hdmi_mux = quirks->hdmi_mux,
 		.amplifier = quirks->amplifier,
 		.deepslp = quirks->deepslp,
+		.running_code = LEGACY_RUNNING,
 	};
 
 	if (quirks->num_zones > 0)
@@ -1333,6 +1335,7 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
 		.hdmi_mux = quirks->hdmi_mux,
 		.amplifier = quirks->amplifier,
 		.deepslp = quirks->deepslp,
+		.running_code = WMAX_RUNNING,
 	};
 
 	if (quirks->thermal)
-- 
2.47.1


