Return-Path: <linux-kernel+bounces-335462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE95997E614
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEA31F2140F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D918922071;
	Mon, 23 Sep 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="macbIx5X"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738C1FDA;
	Mon, 23 Sep 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727073453; cv=none; b=FhjzPnz7by4mQ0V975zex9YAPSg6Grx/KqrMporkJTUoAVJxvF3OQMsaA5FFjm0pgOTeoxPD6jl3H7PdBWfUmOsBzFL+EE0hD37cSjnkOBxcR0E/4Xw+iszw2CoXxpvDSd3YcOS/5pRZC2Bl3VvFx3rJ3ImVGLfs7Hx5rzSP7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727073453; c=relaxed/simple;
	bh=BdUfwaShRpCIUiPX3x1kfpQwbXbbeJRSzY1aL5XhBO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Box+ISHfpK51T8J2KB967fqsYwjQ9NDOpgGvU7kI1ob7t08nMPptj3AgFpkO4nPbTz1TW5lMKPGV/TvcxUsXp2HUJnJybRHkX747YKQhwbrFjO1laikd/arIxY8wKe7GLfoWLgIoZynJSxAlv/aJjtAbrUdUBBpwyOrWGyGWtSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=macbIx5X; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2075cfaf51aso2017285ad.1;
        Sun, 22 Sep 2024 23:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727073451; x=1727678251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oo3K4ayXoJ6fQC5ULUscoZS9a7XRv1LISxLUkyqDDYA=;
        b=macbIx5X+cAmtxlxVYgdeyJr4/HvShtYmjj2EvC47/nEOxmkgkctG6mfWrtW/LQ2I2
         i8nRtXihkbOaEGZpgh9rZ8Ki22AiUITZVR3Tr2wP7YIhFPWTVVOoSVwhtqYc4vkLKyrh
         X3WQlQ3+pYeE63JxkFG9F6J3o00P4W5VwFmrOPMQZVWzD10pD9zuvKMDfIw6ECj//py8
         Qvb+j3/Ahg8qaj8GUOo+iHNoV3CAjymRrzpKQmZru5sbxD8fd2Pkrff5AXN1ngvzflC4
         GtmCw0mrACdZ4Uvk8gwUrSExXVfoRKZg7xQyJYgEDo+xGYL3Q9XvlpyyaUHHSxWTHzYI
         rmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727073451; x=1727678251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oo3K4ayXoJ6fQC5ULUscoZS9a7XRv1LISxLUkyqDDYA=;
        b=n2krvcgWZ8HvBlucSN5GKVzkc/zu5pe7XKYGHTmuek2cQ3BvtPSVqUz1M70cRhvC33
         5b0PohBK8vDO6jFczFmjZVkHW1d79Xr+qoKavfOgLpCgJ8y75WZ4JGsaqVmoKkwHO1ua
         Hod5slYZKGB+90UeGdahN4xXIPVMozJS7yO0GoSHIysOrzV2ALPBLormtFFrLh7BjGMF
         StF1pUu9VomdJ1EITaAL8mZpROHk/VH22utLBMXmaoohS9i8gFFpkycOCvH/r7lPc5T5
         ruVkAE8PuQOMPYb+g8TU0OHxiIj6Y7YII+2JhsURP1TYx2mX2VlDipSMUYB37oJ984PA
         QIvg==
X-Forwarded-Encrypted: i=1; AJvYcCWlSijPMrBdIjoloZrjU5GHnPJd3iyMypYsgBkXo51c7Rlc5uXnvRYtDU5izuU1J04H3uLTtIcRDCGenSbAlZ9V1d2A@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Vzjs66iD3ex7R68EFa8E5Th15fA9GNEoMKQlIQNJH8Imkw14
	Eb010EX+vXlFs9FkjlFeTg391vP6PyWKJ+p2cm8JtcvKnqdE7L3P
X-Google-Smtp-Source: AGHT+IHRej+xZxJY1YT8QKCP/0dXnDf6rIbDgHPxErBA3W6OSjZc1KtOezbp5UKXYwMTaKV8mg8D3g==
X-Received: by 2002:a17:903:228c:b0:207:5e6d:ae4 with SMTP id d9443c01a7336-208d8442957mr66525905ad.11.1727073451192;
        Sun, 22 Sep 2024 23:37:31 -0700 (PDT)
Received: from crlab-Precision-7670.. (2001-b400-e3fc-89df-e906-eb7e-4d7f-9cf6.emome-ip6.hinet.net. [2001:b400:e3fc:89df:e906:eb7e:4d7f:9cf6])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945da58csm126909105ad.37.2024.09.22.23.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 23:37:30 -0700 (PDT)
From: Crag Wang <crag0715@gmail.com>
X-Google-Original-From: Crag Wang <crag_wang@dell.com>
To: prasanth.ksr@dell.com,
	hdegoede@redhat.com,
	Dell.Client.Kernel@dell.com
Cc: LKML <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org,
	Crag Wang <crag_wang@dell.com>
Subject: [PATCH] platform/x86: dell-sysman: add support for alienware products
Date: Mon, 23 Sep 2024 14:36:51 +0800
Message-ID: <20240923063658.411071-1-crag_wang@dell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use SMBIOS Type 1 manfacturer instead OEM strings to verify product
compatibility. Also, add Alienware products to the support scope.

Signed-off-by: Crag Wang <crag_wang@dell.com>
---
 .../x86/dell/dell-wmi-sysman/sysman.c         | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 9def7983d7d6..2f3f7e307b29 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -516,12 +516,27 @@ static int init_bios_attributes(int attr_type, const char *guid)
 	return retval;
 }
 
+static const struct dmi_system_id sysman_dev_table[] __initconst = {
+	{
+		.ident = "Dell Inc.",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		},
+	},
+	{
+		.ident = "Alienware",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+		},
+	},
+	{}
+};
+
 static int __init sysman_init(void)
 {
 	int ret = 0;
 
-	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
-	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
+	if (!dmi_check_system(sysman_dev_table)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
 	}
-- 
2.43.0


