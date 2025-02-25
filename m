Return-Path: <linux-kernel+bounces-531980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD30AA44783
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F773A5B00
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D7018DB29;
	Tue, 25 Feb 2025 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc+ZHKeB"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EAC2943F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503017; cv=none; b=e5xwRpFKuWrPfonrfVv+WLHtDqky9hM68hShrBtoRHGLAR2H82+5gxjl2QG60Be/YsCsLbWO5ZKnqEhIHwI0h1739DsGHja266azMIzzQ3KC09h7HlDXb2ylEQSKUxkrPhSDzFgywa3PsBq8vf3CRrsjB9Mex1qMg8R5rRnfm8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503017; c=relaxed/simple;
	bh=pEwPIBOrYbxB7Rq5ja5IYwSN/PGHtEIZW94pp3lYxl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UTV2JxzkyQo7z0NNLQorIocjRJfEVip7Mmb9mRI0bkTQshpxblaa9cwzGbojlrh09wnReKctKEVYtXvBaDyVY8JecJzMJhlBgOtlj0bZ+pkk4hUIadif8GupkU07u280Te03Bo1zfbg/vTOJdAn+Ls+VQnPsXSJT5KZF5C/w99k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dc+ZHKeB; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e5dc37f1991so5096424276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740503015; x=1741107815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VrOHMOhsLxv2VRcODb+YImwGCZbwNqaxvflM/hQEhoc=;
        b=dc+ZHKeBGR8LhPA4NRSB8sdo45yBXN2Y1m5UN1G0WW2rdWJQDDkjC+VNB+Ct/5LRKG
         crGZj/SyTXsF3yrw7nLwnl0ZM4GAFksP6WcJKG3F7wJYvM6le0z53r/ok5xaam4XpzDP
         bkcCkIkJldrTbEIJZhKtIXIdYPgd7A3GXNuHhqTUQ6vhPK3IApmIFrGryiNWEIbmNlRj
         jwARHgU9mqX/MWXW7EfcWqFWhlLzy3C10TYzQPOsBHospnIEpRSJChKifudBjp7qfk6t
         PqnrimMSF+enue35D5QnwyG6xD01xoLEEidG4CkB7cdmMlxEpflNpFtKofG+SDiLRbEV
         VsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503015; x=1741107815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrOHMOhsLxv2VRcODb+YImwGCZbwNqaxvflM/hQEhoc=;
        b=ZimRttju8W2T7OfXDmQE9DhGfJVfRBoV2Tvl7ad5QGyxGogYnIAGsppBbfYtGFpiDO
         RDqNXcc47PtcB8171P4r6Gzsr4twj2sxlc87IssiApWrmfofaRKhd+ompe9trPTly48y
         8O2zc013Ko7wRE1JRBCFI9u5TOA6T1JaBdBuQVUzny92i1W667hKnYpoTzbbzfL2wNr6
         1qxm3bYwzyUaCibSHgdYd8MCa+gCBM9L+WlnWRdCyv0OuhNjZOjj58epcoTrV0D+jjWI
         LdTHSAHUW0Tazykci2jzxPF5W3kfRCBL9VvxCqrQ2wcGCyJIhGfyGvXpF5acqrDwUaJN
         9KRw==
X-Forwarded-Encrypted: i=1; AJvYcCXeBKI7wMZDIhr8L1adIpLJt+O/5Gx8KjZHhW4tnzk/tyP5W0kKVoOyXHecx3VBcXUOLjcSfKFVzFOx230=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRbtU3LXe17tDZU4vbPS8xSrQ6aiy6SWAljapJCof3U6ssCdgq
	P355O+V4e15F8fG6vIvvjUXT1ldvZJh+YEL7GMveXaJknhFc8bJW
X-Gm-Gg: ASbGncsdOmCxEQUzGZmJgt4h6Z+ZA0gQpgBDDHKZ42UmRbi6Q8010RizE6EQW2PK6qg
	IKs5CvaE/Cfqbr2v6b6ulWFsfFi+9ghcFQ50heJFptcg6HsGGpQpK7fEqFs79RcuwwpAO2pPiwe
	SO9S9JiFNoFMfeQbIarsiE/AsY8/RYeqOVX4EMzCsdzRQ0mGKXIcphA68w5mgB45gxuK8qtqb9I
	L2eBTUqmFwEdMeIy7uCMguFhhuultP0c5oHVwzY47JP2KUGRq4uN3jqSMqWOPxvbw154Drv3rA2
	xPz3k6z4LA6H8ngcW/JG3QDl9mm0bgXQXQ==
X-Google-Smtp-Source: AGHT+IFeCSYsFA8EEMyS5+OZ1uj4NcAbn7Hu8i+f5HezrXNtuZzNXf96gcIEQUeYyioag+Z5WoswYg==
X-Received: by 2002:a05:6902:200d:b0:e5b:240a:ccdb with SMTP id 3f1490d57ef6-e607a5036c2mr3064650276.20.1740503014787;
        Tue, 25 Feb 2025 09:03:34 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e607b3c3cddsm469478276.6.2025.02.25.09.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:03:34 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kurt Borja <kuurtb@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v1 1/1] driver core: faux: Add sysfs groups after probing
Date: Tue, 25 Feb 2025 12:03:18 -0500
Message-ID: <20250225170318.3826-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move sysfs group adding to the bus_type's probe. Specifically after the
user's probe callback succeeds. Removal is also done in the bus_type's
remove callback.

This approach approximates the order in which the driver core adds and
removes driver .dev_groups of a device to avoid lifetime issues, which
can't be used in this case because the faux_bus is a single driver bus.

This effectively lets consumers of this API initialize resources on the
.probe callback and then use them inside is_visible/show/store methods,
through faux_device_get_drvdata() without races.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/base/faux.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index 407c1d1aad50..9054d346bd7f 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -25,6 +25,7 @@
 struct faux_object {
 	struct faux_device faux_dev;
 	const struct faux_device_ops *faux_ops;
+	const struct attribute_group **groups;
 };
 #define to_faux_object(dev) container_of_const(dev, struct faux_object, faux_dev.dev)
 
@@ -43,10 +44,21 @@ static int faux_probe(struct device *dev)
 	struct faux_object *faux_obj = to_faux_object(dev);
 	struct faux_device *faux_dev = &faux_obj->faux_dev;
 	const struct faux_device_ops *faux_ops = faux_obj->faux_ops;
-	int ret = 0;
+	int ret;
 
-	if (faux_ops && faux_ops->probe)
+	if (faux_ops && faux_ops->probe) {
 		ret = faux_ops->probe(faux_dev);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Add groups after the probe succeeds to ensure resources are
+	 * initialized correctly
+	 */
+	ret = device_add_groups(dev, faux_obj->groups);
+	if (ret && faux_ops && faux_ops->remove)
+		faux_ops->remove(faux_dev);
 
 	return ret;
 }
@@ -57,6 +69,8 @@ static void faux_remove(struct device *dev)
 	struct faux_device *faux_dev = &faux_obj->faux_dev;
 	const struct faux_device_ops *faux_ops = faux_obj->faux_ops;
 
+	device_remove_groups(dev, faux_obj->groups);
+
 	if (faux_ops && faux_ops->remove)
 		faux_ops->remove(faux_dev);
 }
@@ -124,8 +138,9 @@ struct faux_device *faux_device_create_with_groups(const char *name,
 	if (!faux_obj)
 		return NULL;
 
-	/* Save off the callbacks so we can use them in the future */
+	/* Save off the callbacks and groups so we can use them in the future */
 	faux_obj->faux_ops = faux_ops;
+	faux_obj->groups = groups;
 
 	/* Initialize the device portion and register it with the driver core */
 	faux_dev = &faux_obj->faux_dev;
@@ -138,7 +153,6 @@ struct faux_device *faux_device_create_with_groups(const char *name,
 	else
 		dev->parent = &faux_bus_root;
 	dev->bus = &faux_bus_type;
-	dev->groups = groups;
 	dev_set_name(dev, "%s", name);
 
 	ret = device_add(dev);

base-commit: c5e4c8c07a734bd9365876b1eecc3931d5a68101
-- 
2.48.1


