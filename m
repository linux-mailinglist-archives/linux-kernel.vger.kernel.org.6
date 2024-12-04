Return-Path: <linux-kernel+bounces-432093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3B29E4502
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53E7165EE8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B8A1A8F7D;
	Wed,  4 Dec 2024 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bCzKpt32"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC513154433
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733341690; cv=none; b=U0jxptsqjJe3Mn3Q0WBPkokS3w99rwaEAxDsIIjdPwrMjshyhs9YZ7oEOo3dgE04uC8iCvjN6bpnGvx+ie61r0F7dslmm9UpHq6XZrSL98pEj6fJtZtdSCiKMJPr/bZASTZnNYbTKjxrmzNHsaCkbaBGF0vOz0jEekfYKhudWAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733341690; c=relaxed/simple;
	bh=q7JXgsd9lm7WjrZOIsZzvR9UT80iuPtsmbmChSe9FoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NDsf6RXw7kDwiIBO5UdyWozisiybkyXToQf9rrhlEq8w0RGsUfSjOo6yy5rLmKdd/EHPvsGqAQcFYYiJPUcg7Gi7KafO4tD1zqy6VoUdV/z7RL9Y5wXpY/tW+tmdkDI3ahgs+V5Vt4AinvQNoqK6V9eIYsIcgsXNZRybTD87lTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bCzKpt32; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724e1742d0dso191139b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 11:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733341688; x=1733946488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ch5dOO0x4WGkBLvzcx+h/YLN0SfrSosFkimPazJD86Q=;
        b=bCzKpt32MQ4i79zGiQvHOBlCSiHYMXI/o46Y/vJagI9k5pcokZHScCffOCHsa5jR6T
         biyTvITsuv6FiuDJHKsldVM1PTWJ6/7bUxe2fEjD5herDuS9DQEZfdVhx1T45RUwkqUX
         QmxRAg56+yG8RqWCHXCfzyNOJsTDcsrFw/p+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733341688; x=1733946488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ch5dOO0x4WGkBLvzcx+h/YLN0SfrSosFkimPazJD86Q=;
        b=TCBxD+o9FPEmgkGr28XSIVuoPAJKhYa1qbzGTlc3DG97AbWBYJnvSa56+Jmk3vrQgk
         lxlBuPWgMV4ngdyh7gVFmdizrYH8HBU5wWh9PQKf0/+AJPwY7FBA6Z+YLramfkxNm3n2
         yW7cAAhmxGyaaNYG+cicZis4YsqX/4K6k/plLq8FY9+sCYsCcEmrpH5YxxHshL40eK+a
         BcPIEBqONum+hq9VSJFRvulIleNw3ArKtcEYSoIdynN4006vNz/DBUr4imlgf62z8Re2
         lclSFOqZk0mIIKYpQi+8hqq2yhWoXMk8kH+o96A+FXJK+5OY+YZftLZUU4jRojy7SqNX
         htUQ==
X-Gm-Message-State: AOJu0YwSvYquD64rnlmbZxFvX5WbGXWr7SQwYhpmP7VulVvc9HQ8s495
	+LXBEWgJ9jFivpBkAzfU5Fiz1Xz1b5xFWCixon1iDqRwMi7FK5g9xcGImk19YQ==
X-Gm-Gg: ASbGnctk91P4cGk/JBXUdfbggMrInvGQMU7ii5lCFky1L7yr2DdNyocnfP64Moi3wTF
	oi9orVFC5jQYpGEhUJVc3SKrYY+ps0dd1EMpdzCK/e1rpxb+yUb4TpTl1q8zTso+2rdjYs9O1mM
	BzZmCFtvVThxKoasnVidU56FCCnED809aCrwB6heVaQHGC654659C3FwcsaquAKVuBQpZKTXUne
	o/Lc47iS8JQ/ZL+39ta4vjsyfDzwO6N6jYKXNmEKjBnlBrxRjDkKF5+qSR2GcVXgGtfqxomdc0D
	Z+Ejo0hrvDTQLA==
X-Google-Smtp-Source: AGHT+IGILSlTnkkdJXjpUeU7Jq5yUV8aGe7A7pj7PQfhAd5EJruxK5hvz9fCHF1b+UJK7pbGQjQY9Q==
X-Received: by 2002:a17:90b:380c:b0:2ea:356f:51b4 with SMTP id 98e67ed59e1d1-2ef011fc89emr9494845a91.13.1733341688296;
        Wed, 04 Dec 2024 11:48:08 -0800 (PST)
Received: from localhost (188.139.125.34.bc.googleusercontent.com. [34.125.139.188])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7254176fc40sm12709672b3a.71.2024.12.04.11.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 11:48:07 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH v2] of: Hide of_default_bus_match_table[]
Date: Wed,  4 Dec 2024 11:48:05 -0800
Message-ID: <20241204194806.2665589-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This isn't used outside this file. Hide the array in the C file.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1 https://lore.kernel.org/r/20241204000415.2404264-1-swboyd@chromium.org
 * Move of_default_bus_match_table into function so it isn't unused in
   different configs

 drivers/of/platform.c       | 23 +++++++++++------------
 include/linux/of_platform.h |  2 --
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 9bafcff3e628..c6d8afb284e8 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -24,16 +24,6 @@
 
 #include "of_private.h"
 
-const struct of_device_id of_default_bus_match_table[] = {
-	{ .compatible = "simple-bus", },
-	{ .compatible = "simple-mfd", },
-	{ .compatible = "isa", },
-#ifdef CONFIG_ARM_AMBA
-	{ .compatible = "arm,amba-bus", },
-#endif /* CONFIG_ARM_AMBA */
-	{} /* Empty terminated list */
-};
-
 /**
  * of_find_device_by_node - Find the platform_device associated with a node
  * @np: Pointer to device tree node
@@ -484,8 +474,17 @@ int of_platform_default_populate(struct device_node *root,
 				 const struct of_dev_auxdata *lookup,
 				 struct device *parent)
 {
-	return of_platform_populate(root, of_default_bus_match_table, lookup,
-				    parent);
+	static const struct of_device_id match_table[] = {
+		{ .compatible = "simple-bus", },
+		{ .compatible = "simple-mfd", },
+		{ .compatible = "isa", },
+#ifdef CONFIG_ARM_AMBA
+		{ .compatible = "arm,amba-bus", },
+#endif /* CONFIG_ARM_AMBA */
+		{} /* Empty terminated list */
+	};
+
+	return of_platform_populate(root, match_table, lookup, parent);
 }
 EXPORT_SYMBOL_GPL(of_platform_default_populate);
 
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index a2ff1ad48f7f..17471ef8e092 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -47,8 +47,6 @@ struct of_dev_auxdata {
 	{ .compatible = _compat, .phys_addr = _phys, .name = _name, \
 	  .platform_data = _pdata }
 
-extern const struct of_device_id of_default_bus_match_table[];
-
 /* Platform drivers register/unregister */
 extern struct platform_device *of_device_alloc(struct device_node *np,
 					 const char *bus_id,

base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
https://chromeos.dev


