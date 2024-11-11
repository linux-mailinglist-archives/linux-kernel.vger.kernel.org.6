Return-Path: <linux-kernel+bounces-404555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893FF9C452E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B97EB2DB11
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2651AA1D3;
	Mon, 11 Nov 2024 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USFHa0lO"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A411A256F;
	Mon, 11 Nov 2024 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350177; cv=none; b=R8A8dOaMHVKuggp8eC27XvmqyBlYoZIpEo5W0sBoQldUD3aE4qcMbb7uHLm4dMt2g8D4EtXdaWhRJmZ6u7TTjLKxS1bCGu8yVJv/8pG0dd5a2jhwEoU8P/PuEzfQgAo1sSGrIEoae18oc7J6rIdI8kOayHL8Xtedh95Zin3J1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350177; c=relaxed/simple;
	bh=DbgYVrU1T/Jco0gW7WgvvAhR4NOMUZazw9rmf/J6xqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePhwRT/SChhlibPFUgW9u3J8dzkQEHRKpCCj5YTtNLv3wnUB0OBn0n2iJvHh0zgSLvhzpVZLM+TEKjJaOxPKEHhRCOfYAWg2KDtCfSvyXeYY+Lp3SGWORes5ojGS1S6JxQXFD+X78xdCbG0oDcqSEkyUmyGGF/KRODRNO7Y2Qcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USFHa0lO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72041ff06a0so3824218b3a.2;
        Mon, 11 Nov 2024 10:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731350175; x=1731954975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzB1/T95TNZaUk1g4DmHaqoqF0Us50Ixc5KittyVt3I=;
        b=USFHa0lOaqiZuvykQAklDdls3oYs4yCUFGDop0bVw3mjhEMm3oMkj1ezqkRS65saJ3
         x99mTkWiWD6n9YuVN2rRC/eBxc5SXLx2hU/LhBsyMA7EqZQ+yxg78Jtz4tXQrFtc9hgC
         gyBZ4GtINdxhtDKZd8OnDukdJvazjgjY8oP92HS5jXrXq+54bvWQpWhUcBJFKwLNGlFU
         IeaUdNju9ZuwngI5YBFvFiznvAdE4W/lCNBbutGzKNJThnJMwqZZwOjbRXz0+eRK0y9h
         3JIlhEE7H468pMOBuD1FyxtjlvmqIYRsKVM8wPBqCWpLeB6BDhMaglu1V2awm/6of5my
         W5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731350175; x=1731954975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzB1/T95TNZaUk1g4DmHaqoqF0Us50Ixc5KittyVt3I=;
        b=BbIoYzwXC5LqIPk4uRzjSlESYQcvd/gyE9ildWC5dIsjQZG105q2inzIsnaYuOp5LJ
         Y97lqJyLezaRZDDnlBVcvO6rY1u0OmHzyIiswUgTDuvV6KO9fsGCQCcfUzakwQbx1lY3
         3ryQt2SxV4jbiudD651PWd+Db4Mr1G5zmrOVfnGW8ynTKA5UvYBYv+urCKbtDAmEDgwD
         JZaRI2vIH6K9QJF7x6OJwgwYfJxs7VsZzG1dBkb4Vo6cAQG0cVWkU99gESE8lmkObR6K
         9En2AfbavgiFbjEcZ0ZTm/UUJDZYHWauIP/uwUclO7XnA0FKPaVNG+d+U/DWY1v4e8sS
         8u7A==
X-Forwarded-Encrypted: i=1; AJvYcCWu7P+DdrexpGb1mpfKmZEhTx1tykMiRSrZBdRsHq94vioTFgONBHsKfsteRlMM+NO3LfuOyBxoxoo1MT4=@vger.kernel.org, AJvYcCXX1+3cZqx4tdob17K+TGIQ8dgwJR/d+L2XkuqR8y8rLqp1U2QBoYIDrrchKWqenlhHiWWdjrxC0fEWT0WFL0T8LonWvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/OVjqBYw3wLd9/LIDMEG8cwyf5jNI2zX6/+aDQ9ksGzZe3Qga
	XuDKYrEhtJeOFRtsqJIZbUS6VK5oScy10HBIXvg4FpYijRuRXxYO
X-Google-Smtp-Source: AGHT+IG7pHJQb3NymywxGIf5AJDXLs7NQcLOo7hdLcX+hR5xLfwhJbLRHfxMof5cZfI/h6Ic68XN7A==
X-Received: by 2002:a05:6a20:1595:b0:1db:e884:6370 with SMTP id adf61e73a8af0-1dc228693a7mr20675279637.7.1731350175135;
        Mon, 11 Nov 2024 10:36:15 -0800 (PST)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a57210sm9737897b3a.186.2024.11.11.10.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:36:14 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: ilpo.jarvinen@linux.intel.com,
	w_armin@gmx.de,
	hdegoede@redhat.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com,
	Samith Castro <SamithNarayam@hotmail.com>
Subject: [PATCH 3/5] alienware-wmi: Adds support to Alienware x17 R2
Date: Mon, 11 Nov 2024 15:36:09 -0300
Message-ID: <20241111183609.14653-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111183308.14081-3-kuurtb@gmail.com>
References: <20241111183308.14081-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support to Alienware x17 R2

Tested-by: Samith Castro <SamithNarayam@hotmail.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index d1e72915ed4d..36d182f217e2 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -267,6 +267,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_x_series,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Alienware x17 R2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x17 R2"),
+		},
+		.driver_data = &quirk_x_series,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Alienware X51 R1",
-- 
2.47.0


