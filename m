Return-Path: <linux-kernel+bounces-432437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0676F9E4B40
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FE91881364
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2638CE56C;
	Thu,  5 Dec 2024 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFmsIKhk"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E12B10E9;
	Thu,  5 Dec 2024 00:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359111; cv=none; b=hwEb1Aevajc6Q+WccHYTQS8o+FMz94Y8y0Huizg2lqhT+kHTyCgpECga1J+c7/jzMmTntHL7G4RDpflmeq26VQXykEYKVKeSZfTl2NJJTNDABJFrmEtQC/zVz2pXawR10yGtUhHdR0tnFgS0W2VIwMpK0eJXu+1YXMtWcHndEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359111; c=relaxed/simple;
	bh=CVtGeYGQ2lsIhDmByOC3VmZ9h8mcsqIVHwZTa60EnLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rs7PbZtkJ1fhS7cTnPrVmiFL6iq8sWMLP3gr+aWOTtWdkHC7fiPsIRi9gtc45JiknPN4lGbVOreodTyBHcJeEHVf9QMGhg5fOu+TKxCt2Zx/bv8iaUrDNmfUhzNT6591uNo1orkMu6JS6d3AUXf3K4SWKR1eQkXgcf1VYn7B+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFmsIKhk; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd10cd5b10so336105a12.2;
        Wed, 04 Dec 2024 16:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359109; x=1733963909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TaqAnQ9e84EfyCGFY27XE5cu/57VweM6gLIO9TxviE=;
        b=CFmsIKhkOCPqeS98oKWoFO5zo2feDy75fr+q34YeV7lDVwctX2/rbRKW1N9QZvJNAU
         o4VgW2wK+Aos2a+wPEexI53Og5Svtl/ByWavl8QQCgqXW3dkMME0yQRSPgBNMgDNg5Bk
         Yv9W3TiSer00ljVvI7pArE4YjjumtM7PAVOucmaMX4by5YvhKJV90/cGhj+Idwx6eJBE
         b7ZKv/ke+1YaU6A8VCIJ+UOBkLRKxXqecpn+9zO+E6pay0TW0YqZT95jQ/zxtHbCM3EG
         FH4cwihynyfx3U1RGJfa950YlkaoTuWveNxVsPBSO4UtQ38oqsASGkuvRlk4n3zXgW5p
         WREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359109; x=1733963909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TaqAnQ9e84EfyCGFY27XE5cu/57VweM6gLIO9TxviE=;
        b=EnZDwCfKZVhJYMrGbJQF3/086rpPYP6q/zMnz1Y2svQM3b90fYcJq8kHpd9ezCcW6D
         mZnKioc7CPVPLQFdPXqi2p4vEsBs2Bp+joRlSaej9y375XuhjUK97aXDcF0kE7KfLp2w
         GxrrGalxkm32zFziKXL80KZ7lCAP83x2pp/zFOiCTwiUYWSPuyPh6/ZHeGGjZz3ddIGL
         g/YhQ+wv4kD8+FpRlS3UHR270U4yitCubvKjYRmKeY+cKxayJOxjDnj2Cs6X8ifO0Yj4
         EYexVoJCasi6TM1+5PB0jsgxft3lfuVxW/UUZF8yNYRC3sEaGqcNFCbdMGJySBAmLrqT
         GiLw==
X-Forwarded-Encrypted: i=1; AJvYcCV7dUDNnitaAfD3Q3GFFe5rf3XS99ueSLyDdtxxcM/OXjsq3PEKIqaLfww2XrPSKTDSTDqS70XO1RVscwgKVaK3Dod84w==@vger.kernel.org, AJvYcCWmhQl0vbWEg84C3LoDgttxhjsXjn4qQeuiAQrFCmUOm8U3BQ1cn+jm/KxUK6+JTxic7MjIKkR+EzZnEQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPjdQ6Hh30DVZxVTLOoe5wDnTPdX6250YdXy4erHr2RprTYTBk
	Gez2iKn/SPkSv1umGUgidj9bKtht6I1lmC9Ps6BlsoQKtos2veO6
X-Gm-Gg: ASbGncuZlp7LKYd3teQeKhccpm/w+PUhSaGbfEwWjTAzWNlPoXhheTYhirA4unuKuej
	lfcQR5Dro8xzgEl0Qap8R6B0EhuLm9M8590nsQobujoL4pRawHSxLEAmVbvAKWlq0sUHYwcfHxJ
	fMvXQh1rwQDopcrQChI41Ey0EwbOqQKt2dS6dOd/1TaJF+XEP8NcWtQfTUnXikd0TB58yfvBZQn
	8y9jeNWFH3VgfX0At1ffYD+WQGeqm07eGnlwu+5KRhduk48KsPg5F/63cBBSrKIGnp34q+XFGR9
	j5PXK4HUoR1MDIPyNd0=
X-Google-Smtp-Source: AGHT+IHGZoXQtkdzn9gcelz/RSchyTX6Ifra/ExRIUhpX7+I/4rIt6Gijq0x5nMiHxPzojX3/Q283w==
X-Received: by 2002:a05:6a21:339c:b0:1e0:f05b:e727 with SMTP id adf61e73a8af0-1e1653a7977mr12494551637.2.1733359109229;
        Wed, 04 Dec 2024 16:38:29 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2cc9311sm94243b3a.182.2024.12.04.16.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:38:28 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 01/21] alienware-wmi: Modify parse_rgb() signature
Date: Wed,  4 Dec 2024 21:38:03 -0300
Message-ID: <20241205003802.2184367-2-kuurtb@gmail.com>
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

parse_rgb() now takes struct color_platform instead of struct
platform_zone to support upcoming refactor.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 77465ed9b449..b3a73fc43b3c 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -434,7 +434,7 @@ static u8 global_brightness;
 /*
  * Helpers used for zone control
  */
-static int parse_rgb(const char *buf, struct platform_zone *zone)
+static int parse_rgb(const char *buf, struct color_platform *colors)
 {
 	long unsigned int rgb;
 	int ret;
@@ -454,7 +454,7 @@ static int parse_rgb(const char *buf, struct platform_zone *zone)
 	repackager.package = rgb & 0x0f0f0f0f;
 	pr_debug("alienware-wmi: r: %d g:%d b: %d\n",
 		 repackager.cp.red, repackager.cp.green, repackager.cp.blue);
-	zone->colors = repackager.cp;
+	*colors = repackager.cp;
 	return 0;
 }
 
@@ -538,7 +538,7 @@ static ssize_t zone_set(struct device *dev, struct device_attribute *attr,
 		pr_err("alienware-wmi: invalid target zone\n");
 		return 1;
 	}
-	ret = parse_rgb(buf, target_zone);
+	ret = parse_rgb(buf, &target_zone->colors);
 	if (ret)
 		return ret;
 	ret = alienware_update_led(target_zone);
-- 
2.47.1


