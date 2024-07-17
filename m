Return-Path: <linux-kernel+bounces-254572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FEC9334D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83161F2335D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC97442F;
	Wed, 17 Jul 2024 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yPxj65C2"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9548BA4B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721177495; cv=none; b=bYa69w+B0ogF3Zd/l831iiawL88/eNQR9WtYPDY5HjXUdxdaPi49kQpKTNq6ags9Gq9yc2VueaJO47lTn/g6QBKbea2XWY56xVOkOFHMKonQCxUqsaRrZqXLNeDVSf3WuiPaCtQr81r8WNzbVfXUy9ZDUH0A6qjczQAAfIJauz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721177495; c=relaxed/simple;
	bh=wj9RriCI5ML0LRKiteJKsLnz30K8rwhCkEtXmY/ViPY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GGjaAOgLwwU34VpoFx3Uy5HZZuavPxXdFIskqpUH3v/idXlIQAQeeeEEOcHMSJYtrfFyYf7U5hxjDgB9iaWx90ihhyTOWqMbaLCcnYs1QeIxcInFel66+HhLgogT8C2We4z9h0mlH5wP4zXLDeOs14QZNO80JSgAmA5ECDYYlwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yPxj65C2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-650b621f4cdso110020317b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 17:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721177493; x=1721782293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQ9sG390GoUWxGLhfPgzLiAx3nRxfoIGsKOr9STNfgY=;
        b=yPxj65C2aErZD54SikuxNB2HNoHY6vG1zf9wy+xZgQVTOennpZv2FIzSOYiuePBQwY
         CjeRpBLat6DBOF8SiSuuqJgSwX48SvfNlUQNsnQrmFTULj8Sa9i93hxJbzft5UBqSeiZ
         qZ8nTVBMjhTs2pz7rnWctwoZCvh5rifHvt/97ogpclYM0EBxSUeEcr+mpyM+wgal7LpI
         J4k3PyKl2E12dWZaB1cM8tDcR82QFGFqtoFfqYiG1DpoPqyyxnN42d1wnwhh/B0dWDNZ
         h6nbJBKrhsdRmIbaQf7dFs4cRcZwl38NFlgCZmC87HSSCglAg9I2m4sqrRYdevGHBMoQ
         8ThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721177493; x=1721782293;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQ9sG390GoUWxGLhfPgzLiAx3nRxfoIGsKOr9STNfgY=;
        b=TzTiAhdeXCk/UiTTCVt1CjjmxAJ8VSZdRXPZYv9Co7QtxVKdu8mGv07DHEMh30BBQP
         edHD5sogWoOovIaIUDiOjzmZt72kJRhRU0MLxgdF26KsvTbe/+8DoqEfcmEGgM0DT/T7
         dQTsO2mllshrkhPL9NvK/015zvaL3hrAUwL45vPOnkfKVBq2olv5rPXUgwOr98pZbRk8
         1Vogv7fLxaG7cYOvTkuLiXJ/oUbdlHYzCE+rqUlAzS5ae9vcpPnf4h9v83GIdc6H38VL
         eLGNH/P5qe+Xk2OWJxtRP4jrxoOQ+u7wic4x8L6YrA2kItU9YL4Kyndhu2nXwbawf6Mt
         bJ2g==
X-Forwarded-Encrypted: i=1; AJvYcCXl661HyzhKi8lFXaz3/THaWer2/2ORD9nRaxkML0mbegN+CC4Sy/tpnBVNA2oVQgcCl+ITWp4CXxyG8+2FCwqAtjRoApVO91c7TURb
X-Gm-Message-State: AOJu0Yyd4bkcCJcasE1T9cJd7I3ENL3UHnQlJ3VEHIai3WzNvSF9V5KB
	T4SKUQ3s4SwT3Go4JDVdc9o7zQyKlV5sx5ABgmC878jiEtwgOCVCS28TvYemkv1x8BMtUbciGNp
	+FQ==
X-Google-Smtp-Source: AGHT+IGs8b8XsKNxd1HsfadHottnqrJ+jqGljW+4HqL2Fv8S5g+1p7Dy4x97Rn7ZN/+IhNZ+4wWiwJpUb7o=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:690c:4:b0:648:3f93:68e0 with SMTP id
 00721157ae682-6650066ad75mr9087b3.6.1721177492971; Tue, 16 Jul 2024 17:51:32
 -0700 (PDT)
Date: Wed, 17 Jul 2024 00:49:48 +0000
In-Reply-To: <20240717004949.3638557-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717004949.3638557-1-jthies@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240717004949.3638557-4-jthies@google.com>
Subject: [PATCH v1 3/4] usb: typec: ucsi: Set power role based on UCSI charge control
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX as a property to the UCSI
power supply driver. When set to a negative value, set power role to
TYPEC_SOURCE, otherwise set the power role to TYPEC_SINK.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/psy.c | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 45113e013696..feb344cb7ac8 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -30,6 +30,7 @@ static enum power_supply_property ucsi_psy_props[] = {
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
 };
 
 static int ucsi_psy_get_scope(struct ucsi_connector *con,
@@ -270,11 +271,54 @@ static int ucsi_psy_get_prop(struct power_supply *psy,
 		return ucsi_psy_get_scope(con, val);
 	case POWER_SUPPLY_PROP_STATUS:
 		return ucsi_psy_get_status(con, val);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
+		val->intval = 0;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ucsi_psy_set_charge_control_limit_max(struct ucsi_connector *con,
+				 const union power_supply_propval *val)
+{
+	enum typec_role role;
+	/*
+	 * Writing a negative value to the charge control limit max implies the
+	 * port should not accept charge. Set the power role to source for a
+	 * negative charge control limit, and sink otherwise.
+	 */
+	if (val->intval < 0)
+		role = TYPEC_SOURCE;
+	else
+		role = TYPEC_SINK;
+
+	if (!con->typec_cap.ops || !con->typec_cap.ops->pr_set)
+		return -EINVAL;
+
+	return con->typec_cap.ops->pr_set(con->port, role);
+}
+
+static int ucsi_psy_set_prop(struct power_supply *psy,
+			     enum power_supply_property psp,
+			     const union power_supply_propval *val)
+{
+	struct ucsi_connector *con = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
+		return ucsi_psy_set_charge_control_limit_max(con, val);
 	default:
 		return -EINVAL;
 	}
 }
 
+static int ucsi_psy_prop_is_writeable(struct power_supply *psy,
+			     enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX;
+}
+
 static enum power_supply_usb_type ucsi_psy_usb_types[] = {
 	POWER_SUPPLY_USB_TYPE_C,
 	POWER_SUPPLY_USB_TYPE_PD,
@@ -303,6 +347,8 @@ int ucsi_register_port_psy(struct ucsi_connector *con)
 	con->psy_desc.properties = ucsi_psy_props;
 	con->psy_desc.num_properties = ARRAY_SIZE(ucsi_psy_props);
 	con->psy_desc.get_property = ucsi_psy_get_prop;
+	con->psy_desc.set_property = ucsi_psy_set_prop;
+	con->psy_desc.property_is_writeable = ucsi_psy_prop_is_writeable;
 
 	con->psy = power_supply_register(dev, &con->psy_desc, &psy_cfg);
 
-- 
2.45.2.1089.g2a221341d9-goog


