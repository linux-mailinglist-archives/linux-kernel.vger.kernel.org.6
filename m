Return-Path: <linux-kernel+bounces-390805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543199B7EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F393F1F21A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BE41A2554;
	Thu, 31 Oct 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFKEd740"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E913342F;
	Thu, 31 Oct 2024 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389312; cv=none; b=k/8OjhqtXmLRgwtzFzrhN/kE+YE6tXaEs3MKLDd53LzYyRPb+F4m329JdPpk/dHHcrtZeQKXx8rov6vr6RJjQqvhU23D9omnIj0GhoCo17+Rr4Zz5SWL6C9coYo29h3ThaQ0fW7bJn2vV/0oeY5507xvnFFdMCloMlRI14LuIe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389312; c=relaxed/simple;
	bh=PmzVfunua11rD3Db47ULrY+vEbNJ2UjH9io9RnmyE9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIs46f7LMa7KQCiQK7I9u/DKtjg3KUBLQfaCyhjOa/AzuqSJbny7AT6iZkEeoSDS13VPd36o7o42NDiKcy5zrEan6Wf3MIpKnxKh1WS/eoQQBNo5a5asQHMESJOO9TcswPEicTlZ6jgT5lsgrra+gxSocU5Zeuk5JzAjUJDbQE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFKEd740; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c767a9c50so10721205ad.1;
        Thu, 31 Oct 2024 08:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730389310; x=1730994110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GiRYxZ7xEXmSUSt3r1VJDfRar6Dp6i3XxT1Xm8dQUN0=;
        b=eFKEd740drgrFvnfg3D2Ki4w6uGG7yqllEq5MCq9wU6DTy63Ojwi/2N7cdTR6uQVde
         7qm8Qb4NCdMgQ2hnyitpmOPPudNjsNmTOcbmfVGlSKnbyQZ6ZaYQDkvRrkGchIb2YeYC
         8+pK/Y2eq9LeQjhaRc4JjBjRcI/AJdpPKxrmoZDEWsBZQDontid+UXIhh6A93DBUJZc0
         ytKff9wOcfx//ldKcpqkQBjTc725ZbkgoVfpjEeFeuPMkbrV+NE3rTRg93t48FO18rcM
         wPsulQgWcEuiai4KMZTOxJZf0GME7TsDPhDw9bQYnOFV+nBMWHJCUhfa9VF2D7/LtfY6
         XGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730389310; x=1730994110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiRYxZ7xEXmSUSt3r1VJDfRar6Dp6i3XxT1Xm8dQUN0=;
        b=KzhdSssCF4NgVPRhVtPKAZjaagvpI7/hZ63B3XnAspLrJQhS6W9blRzLas0F0h7u9G
         3O3lkQJwvjR1M3kyyeP8EUURHDKNKx9xT9PCHiuor9WzdioAObaFidJaC8A3UGZdeE4C
         cmXRYuG9MPUxboLJGqv4efOyPhIkG8hUjAo3NgcWiEuvWP01n4wvuNx5xHARB+FhJvRn
         3ugYpozQEsbhlNdJkgv5wq5x1WwYWPEvezv7A8HS2W0QQm7kBzF5UykXe3oy9Y1nMwOi
         sBy7AGx4GWAKHRP/3NNc9iWmj4OQ5SKTritg5N00myg6pE4xJ1PyMfYe4fAZ3Gd4E4mt
         ejQg==
X-Forwarded-Encrypted: i=1; AJvYcCUxvQ8b71XQ/hTWWZfxp7FHozye1f7L59a8qf89DScNi+JK9KouMVE9JFj3hb1iTnTyC+Wd4NS7Qs+eCLhBl4/UG//6Yw==@vger.kernel.org, AJvYcCXZZvnO5mdoq0V3+HpzhhkIwJjwDn/YSU5bnOqGMNYeKGfrx21W0uHOIJELtn5c/+++g6mL3YfBKQZC55U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC0u9YF9vq0vLaolDC6CF1zUoVdfrR5bSf6KP+s7taJc1QbOwe
	sFr/tKlmAznWGvaAwft2ujzCK1niPAkQfL8Gww4B37d9gnp3qIKe
X-Google-Smtp-Source: AGHT+IFe24WVhIbzOIFz5j56t53mW2JYdH4+Labl9yr5hfQNEx4iRMtdK3HnW32afYHFEhfgIcchFQ==
X-Received: by 2002:a17:902:d2d0:b0:20c:e2ff:4a2e with SMTP id d9443c01a7336-2111b00690bmr357795ad.53.1730389310181;
        Thu, 31 Oct 2024 08:41:50 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c0f11sm10091135ad.200.2024.10.31.08.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:41:49 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	pali@kernel.org,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [PATCH v2 1/2] dell-smbios-base: Extends support to Alienware products
Date: Thu, 31 Oct 2024 12:40:24 -0300
Message-ID: <20241031154023.6149-2-kuurtb@gmail.com>
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

This effectively extends dell-wmi, dell-smbios and dcdbas support to
Alienware devices, that might share some features of the SMBIOS intereface
calling interface with other Dell products.

Tested on an Alienware X15 R1.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v2:
 - Commit message reflects Alienware devices may not necessarily support
   the SMBIOS interface
 - Commit message now has "Tested on"
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


