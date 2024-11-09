Return-Path: <linux-kernel+bounces-403001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BED99C2F68
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 20:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0591F219E1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107421A2567;
	Sat,  9 Nov 2024 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="PQNoDjXO"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49861A0BFA
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731181931; cv=none; b=rJLUYyn5IRmuvlxeWUyLpYtrE8NRlqJQ5CgewyJR+0ipNxXgn9aAD/XIegf4ipFnPy2iFM5XJx9RMSzMUJmNBWNG5YHdyueG5Sx52QgtboxaXhcNARXzckhV9LklToH2sp0h5CaxDn/eGwjtfRGB8rSBX4vqaY+GLAM4DSlmisE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731181931; c=relaxed/simple;
	bh=SV+CBISDRcceKmAV7UBfCAiWuL09kGw2rD7YZrf5BkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1dJgySPAsi1hTlL1CtY5o2M5Q82hfodlWbsGEiM1RpSaBXDyHfU5mdiGO0OLLYtyvgD0XS+8f7AUE0DWn5tC1oHhYZQLSgNrtal8fcsYMqjkuD012fKvNX7HnTLU1y3t4xJB4Zse5j0Ku3/D7KdiAaSCGPA/TQC5hY4P79D8ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=PQNoDjXO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720b2d8bb8dso2396867b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 11:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1731181929; x=1731786729; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5LNGQE4gBDVRfeiKZcltb/2gOhU4SNw+NWSVQDaKIM=;
        b=PQNoDjXOr+awPxw3gH/7cWd7d+e23FwMRKkNML0RkSaExFY496Nw54LPXNrcFdw38B
         jnp/ei17Fh46PEDhP1gj2ZPFUo16Hhdg0tAZ7KXWuZrjmBvAq9jy9iSV6CVaOO4u85aq
         +hynGVxsZ+ycXRQBUt/LVvtqFJwnyrRcZA1R7wUSpY0JPxfHOFsqO6dGuAdq70flZYR/
         T/ZqOjPddFwZFPHygnAa1upPvWOyKeJ2WwRjbV/bOZaPEuKtuFYCjeHM1jbVSOocZGLV
         GD6C5xBVyfA5ZwtAakl77BXk6YsmBboG+exl/ywooeOB8s2R3Lm5edJttaArC+lxAzb9
         +oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731181929; x=1731786729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5LNGQE4gBDVRfeiKZcltb/2gOhU4SNw+NWSVQDaKIM=;
        b=siMiqsNl61PmzRH46IFgWk9aP537SdQfcXASoC49VKtlQ8mHGZ4iFYupWKP3f2D4op
         pNbCGCFcAv+jFLvVH+vcx4m+loFfNxI4L3sHhEFKn5lfHX/FUph2Uw8p1m4KCJnSpb8Z
         QbUlpLZAK25N2fPeEqV1xkr1UuTVMdSo3xxPvwJf+xU82rQNWWKAH8JGn2Kls6LxqtI6
         YIbkkyrl73hZm+wVI/t1obxzGKEkN4AD3vp8GBp2cKeXLaYtRONRPbjHbH8lgzPRLhop
         g+kdk/lXG5ny9BvhpuNYcgCvREDX6dM+zMd9fWxupLW1AEdSu9NIOf7aBA1SS7YziSgf
         zqWw==
X-Forwarded-Encrypted: i=1; AJvYcCXUcQs65HZhV9XWFSdxwbjHBpL8cWkOk52/EG9iObqtlwMycKI1Mtz7wjeAYnPO+CJSV80vOdRHehUqOdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjC9CTDvBZx4tEDszgTtEAieJBL41xmNJhQLTouuePeI322Gri
	uX7/e81XQ1bVwxBTItI2gs0WJBSxPbzWN3HkCRtIFPSPRaO+jpYe6ESvvfsLyQ==
X-Google-Smtp-Source: AGHT+IHeFKHHtNFnXGTeAvs5Hms+wGtkixhFXyshXKlIfVKXHm+IQB5p/sN1qLQ3nVaF7nXsOxBzug==
X-Received: by 2002:a05:6a21:339b:b0:1dc:154a:b8d8 with SMTP id adf61e73a8af0-1dc22b61288mr10478061637.35.1731181929076;
        Sat, 09 Nov 2024 11:52:09 -0800 (PST)
Received: from [172.22.58.163] ([117.250.76.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a4177sm5972288b3a.99.2024.11.09.11.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 11:52:08 -0800 (PST)
From: Ayush Singh <ayush@beagleboard.org>
Date: Sun, 10 Nov 2024 01:21:33 +0530
Subject: [PATCH v2 1/3] of: Extract of_alias_create()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241110-of-alias-v2-1-16da9844a93e@beagleboard.org>
References: <20241110-of-alias-v2-0-16da9844a93e@beagleboard.org>
In-Reply-To: <20241110-of-alias-v2-0-16da9844a93e@beagleboard.org>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 d-gole@ti.com, jkridner@beagleboard.org, lorforlinux@beagleboard.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Davis <afd@ti.com>, 
 robertcnelson@beagleboard.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3656; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=SV+CBISDRcceKmAV7UBfCAiWuL09kGw2rD7YZrf5BkY=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBnL71fWT488AKGi2xOmM+WIweUfCnHdsBbch7hS
 szcbDKg6yWJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZy+9XwAKCRAFzvXHieVa
 dCggEACb1+omj5FCGSylnXwbd+oSopkKcCUnpk7tef9ku+DI8iMvAgHmjAICEKp340HKSigZE7u
 NB4R+99LZ2hBL39+UJVrM4/fdbF4BUAS57jPBxsL1a8xhrdmUBtOK/I8qBG7e9BehgS62GWA9aF
 +oKSgG/aMb9ax+91f2rpxxrqc8yqXrJwssrgVZpyT1ToskkdVJ/wuGrU3VnW2k5TFM2IWD/7hfi
 SA6O2+P7dYXf1l/Zz6aq2oXvhQcCIEICk6/IBEJj045TFAS6K3FDwhvc82JhM3F9erE6CGliDAm
 egEIQ3FF/LiMwgc9qCL1ldaMkoST/38BJdPbjHHFM44pDZxZrIHvT/FeIpK0Y+XFONFssiEZm3y
 kKA8Ig4lXZ+Xw7EDDnZ+iASlCo5ciuq65QQruZNUKr77wqfSMyvgNdnzW31/LRwbjSjJMSKuivZ
 IRnWig+ZYztGBtagu6zM+1km8vMyBBpQ73JfJdvm0oUGNfJO6T4JGTe/svj/BA2DgT/tjuG2h7h
 0Ck5woFx0KNsgs7SA7Oq6dNMsO1fNQ6xzabQR8Iz3hgbFbZUnj7KZpwB8JU3KlE+QvyJprxrs82
 S3JP8B893GyARMQA3JyqazXOwLxGZUAhLqq58HEJ098eLFsqf4+GZxp9HFKBMwQBoFggvH7UlGe
 C6OvpQZ8PhtaJ+A==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Extract the code to create and add an alias from of_alias_scan() into
its own function of_alias_create().

Co-developed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 drivers/of/base.c | 79 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index a8b0c42bdc8e9c352b0af9f9a8540aa6a3afd771..e5cd75fca95132060334aa8547c58951d2132cfb 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -180,6 +180,47 @@ void __of_phandle_cache_inv_entry(phandle handle)
 		phandle_cache[handle_hash] = NULL;
 }
 
+static void of_alias_add(struct alias_prop *ap, struct device_node *np,
+			 int id, const char *stem, int stem_len)
+{
+	ap->np = np;
+	ap->id = id;
+	strscpy(ap->stem, stem, stem_len + 1);
+	list_add_tail(&ap->link, &aliases_lookup);
+	pr_debug("adding DT alias:%s: stem=%s id=%i node=%pOF\n",
+		 ap->alias, ap->stem, ap->id, np);
+}
+
+static void of_alias_create(const struct property *pp,
+			    void *(*dt_alloc)(u64 size, u64 align))
+{
+	const char *start = pp->name;
+	const char *end = start + strlen(start);
+	struct device_node *np;
+	struct alias_prop *ap;
+	int id, len;
+
+	np = of_find_node_by_path(pp->value);
+	if (!np)
+		return;
+
+	/* walk the alias backwards to extract the id and work out the 'stem' string */
+	while (isdigit(*(end - 1)) && end > start)
+		end--;
+	len = end - start;
+
+	if (kstrtoint(end, 10, &id) < 0)
+		return;
+
+	/* Allocate an alias_prop with enough space for the stem */
+	ap = dt_alloc(sizeof(*ap) + len + 1, 4);
+	if (!ap)
+		return;
+	memset(ap, 0, sizeof(*ap) + len + 1);
+	ap->alias = start;
+	of_alias_add(ap, np, id, start, len);
+}
+
 void __init of_core_init(void)
 {
 	struct device_node *np;
@@ -1763,17 +1804,6 @@ int of_update_property(struct device_node *np, struct property *newprop)
 	return rc;
 }
 
-static void of_alias_add(struct alias_prop *ap, struct device_node *np,
-			 int id, const char *stem, int stem_len)
-{
-	ap->np = np;
-	ap->id = id;
-	strscpy(ap->stem, stem, stem_len + 1);
-	list_add_tail(&ap->link, &aliases_lookup);
-	pr_debug("adding DT alias:%s: stem=%s id=%i node=%pOF\n",
-		 ap->alias, ap->stem, ap->id, np);
-}
-
 /**
  * of_alias_scan - Scan all properties of the 'aliases' node
  * @dt_alloc:	An allocator that provides a virtual address to memory
@@ -1811,38 +1841,13 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 		return;
 
 	for_each_property_of_node(of_aliases, pp) {
-		const char *start = pp->name;
-		const char *end = start + strlen(start);
-		struct device_node *np;
-		struct alias_prop *ap;
-		int id, len;
-
 		/* Skip those we do not want to proceed */
 		if (!strcmp(pp->name, "name") ||
 		    !strcmp(pp->name, "phandle") ||
 		    !strcmp(pp->name, "linux,phandle"))
 			continue;
 
-		np = of_find_node_by_path(pp->value);
-		if (!np)
-			continue;
-
-		/* walk the alias backwards to extract the id and work out
-		 * the 'stem' string */
-		while (isdigit(*(end-1)) && end > start)
-			end--;
-		len = end - start;
-
-		if (kstrtoint(end, 10, &id) < 0)
-			continue;
-
-		/* Allocate an alias_prop with enough space for the stem */
-		ap = dt_alloc(sizeof(*ap) + len + 1, __alignof__(*ap));
-		if (!ap)
-			continue;
-		memset(ap, 0, sizeof(*ap) + len + 1);
-		ap->alias = start;
-		of_alias_add(ap, np, id, start, len);
+		of_alias_create(pp, dt_alloc);
 	}
 }
 

-- 
2.47.0


