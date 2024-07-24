Return-Path: <linux-kernel+bounces-261479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EEF93B7D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA001F25243
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333BB16F26C;
	Wed, 24 Jul 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1v0sk6ek"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0816A38B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721851946; cv=none; b=HGCiLfMmZZBevALZbIyNRvjTCsrI1tKbeCt68w8vCpP3XpwCsipQJqG8lAy5yfimNAXRl+tfrKJCPlivR9cuRzCyg2TsGo549hTAeCNU11yjOBW/hPMNLVuMAd93jhKZFNnJBiQgYolNdrkxsSaSsgjlFElqfOWQwufFJlTQxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721851946; c=relaxed/simple;
	bh=aFQShb42bii3mGm0qbjwREOyaZHeVjKuehp0xxMT8bw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g0vIOvy0dRMzgvafJgLnWX6h82PPXtmzX65PGrIv1lg39P7a8vQNVGOytmQCtVif6z9aPrWz0WakEtlz+HXMeDFWDfq8PGtMMM6XAqUm8GwiOc0fEBJFns0rJp3aD+NsJ6rz5hNo6asSXU6YCNaO3xFY4r3Ht7CL/uACUawjTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1v0sk6ek; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6507e2f0615so176641a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721851944; x=1722456744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9Pvb4jluH5jBI5txkxQ7mbZedDOA5ya44uq5vX5vPk=;
        b=1v0sk6eknOAFyKUqpVjAHwibptR4OqYhBoYlyw7X2o1hy/VKAgobPhiaEDOsdncE6a
         yySsnb55CXRuViTSTEw1exlXZl+rw1sIduPT9jOjzpN5HbnF/IyNxsWgv3r+xWtfUS+y
         N/2OmDEEK1sHwW2cqk2/o/FTeAKizJo4n6L7Mg78US4EgJB6BRhPgg+531MdthnKrTvd
         3gi1OvEbwcSkIIm76mjnOw7+wbbkb43ZrpVoGxbmC9U6jraNqh3ohjspVggPMWTjKPlg
         5+cbdMH/RVsp6xRZdOiFJl6DrGcI4LWhB+m6j20ONWHq30fuiQPIDWSiMd2bPe+aD6el
         kdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721851944; x=1722456744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9Pvb4jluH5jBI5txkxQ7mbZedDOA5ya44uq5vX5vPk=;
        b=JXN4qppdmLUXgE8rda5nRTxYAdSGRnq1QhnAqxvgtBzBeVliVSpoXDnUyn9NldzsiJ
         6vsyVjCqJFnBX4+qTykw7++CUdzf4hx6fh9IZz89CXp2JyTD0HLkOzpzU7ISzciD4DZd
         tqNXPw4QVR1idMirFArBGOfmzY7BVAiWKlrN0ORfmHVlL52VgbEw0YbkVDuZg2FAFxjO
         m3LHUousSJLA0/AMvuF0eg7jWmqivvx2NW814VKAebFYFnSA8RMGM+YSPeRw99E1z4JR
         2h6qEbXu82FfkKPzNHKOjM2g4lhbjj3nqloqjHDIBqDH20YH31K+Mqr7cLkmTXRSsTGO
         p5Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXEXvv2Tq/mCWLCeAY278vxds0aJXEDpER4DSBdWi/6SHBEqZ0WmdcVuV4x8y94wmoJRH3DPsztsHvGWq1yOYe/CbNn2YFWEqRQu3kN
X-Gm-Message-State: AOJu0Ywt2FELv52cpWXuH0ejFGWLvobBcViMkinDcGbX7Y6Hlc5iaGgV
	UZk5OwfIxfRzkVAtUVZua+Gq5ret4d1VRdJcKOeXwgf9PNj73DiYUZ5t9Se1JMEmr/f8Ppj9eB0
	ZIg==
X-Google-Smtp-Source: AGHT+IG2uh8fFLHM5G69rObhox/F6sVJL7/iLS8kFtx31VwkwYk0HuYXoE4wEWN3ZqM2ESVQPytGnOYuX5I=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a63:da43:0:b0:635:62f6:d5ea with SMTP id
 41be03b00d2f7-7a9c7c98e9bmr1234a12.4.1721851943753; Wed, 24 Jul 2024 13:12:23
 -0700 (PDT)
Date: Wed, 24 Jul 2024 20:11:15 +0000
In-Reply-To: <20240724201116.2094059-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240724201116.2094059-1-jthies@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240724201116.2094059-4-jthies@google.com>
Subject: [PATCH v2 3/4] usb: typec: ucsi: Set sink path based on UCSI charge control
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX as a property to the UCSI
power supply driver. When set to a positive value, enable the
connector's sink path. When set to a negative value, disable the
connector's sink path.

Signed-off-by: Jameson Thies <jthies@google.com>
---
Changes in V2:
- Added SET_SINK_PATH call when handling charge_control_limit_max
update. Updated commit message.

 drivers/usb/typec/ucsi/psy.c  | 52 +++++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.c | 15 ++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  5 ++++
 3 files changed, 72 insertions(+)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index d708f9eb1654..28265feb9d13 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -30,6 +30,7 @@ static enum power_supply_property ucsi_psy_props[] = {
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
 };
 
 static int ucsi_psy_get_scope(struct ucsi_connector *con,
@@ -275,11 +276,60 @@ static int ucsi_psy_get_prop(struct power_supply *psy,
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
+	/*
+	 * Writing a negative value to the charge control limit max implies the
+	 * port should not accept charge. Disable the sink path for a negative
+	 * charge control limit, and enable the sink path for a positive charge
+	 * control limit. If the requested charge port is a source, update the
+	 * power role.
+	 */
+	int ret;
+	bool sink_path = false;
+
+	if (val->intval >= 0) {
+		sink_path = true;
+		if (!con->typec_cap.ops || !con->typec_cap.ops->pr_set)
+			return -EINVAL;
+
+		ret = con->typec_cap.ops->pr_set(con->port, TYPEC_SINK);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ucsi_set_sink_path(con, sink_path);
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
@@ -308,6 +358,8 @@ int ucsi_register_port_psy(struct ucsi_connector *con)
 	con->psy_desc.properties = ucsi_psy_props;
 	con->psy_desc.num_properties = ARRAY_SIZE(ucsi_psy_props);
 	con->psy_desc.get_property = ucsi_psy_get_prop;
+	con->psy_desc.set_property = ucsi_psy_set_prop;
+	con->psy_desc.property_is_writeable = ucsi_psy_prop_is_writeable;
 
 	con->psy = power_supply_register(dev, &con->psy_desc, &psy_cfg);
 
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index dcd3765cc1f5..02663fdebdd9 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1545,6 +1545,21 @@ static const struct typec_operations ucsi_ops = {
 	.pr_set = ucsi_pr_swap
 };
 
+int ucsi_set_sink_path(struct ucsi_connector *con, bool sink_path)
+{
+	struct ucsi *ucsi = con->ucsi;
+	u64 command;
+	int ret;
+
+	command = UCSI_SET_SINK_PATH | UCSI_CONNECTOR_NUMBER(con->num);
+	command |= UCSI_SET_SINK_PATH_SINK_PATH(sink_path);
+	ret = ucsi_send_command(ucsi, command, NULL, 0);
+	if (ret < 0)
+		dev_err(con->ucsi->dev, "SET_SINK_PATH failed (%d)\n", ret);
+
+	return ret;
+}
+
 /* Caller must call fwnode_handle_put() after use */
 static struct fwnode_handle *ucsi_find_fwnode(struct ucsi_connector *con)
 {
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 57129f3c0814..6a958eac5703 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -114,6 +114,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 #define UCSI_GET_CONNECTOR_STATUS	0x12
 #define UCSI_GET_ERROR_STATUS		0x13
 #define UCSI_GET_PD_MESSAGE		0x15
+#define UCSI_SET_SINK_PATH		0x1c
 
 #define UCSI_CONNECTOR_NUMBER(_num_)		((u64)(_num_) << 16)
 #define UCSI_COMMAND(_cmd_)			((_cmd_) & 0xff)
@@ -187,6 +188,9 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 #define   UCSI_GET_PD_MESSAGE_TYPE_IDENTITY	4
 #define   UCSI_GET_PD_MESSAGE_TYPE_REVISION	5
 
+/* SET_SINK_PATH command bits */
+#define UCSI_SET_SINK_PATH_SINK_PATH(_r_)	(((_r_) ? 1 : 0) << 23)
+
 /* -------------------------------------------------------------------------- */
 
 /* Error information returned by PPM in response to GET_ERROR_STATUS command. */
@@ -492,6 +496,7 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
 
 void ucsi_altmode_update_active(struct ucsi_connector *con);
 int ucsi_resume(struct ucsi *ucsi);
+int ucsi_set_sink_path(struct ucsi_connector *con, bool sink_path);
 
 void ucsi_notify_common(struct ucsi *ucsi, u32 cci);
 int ucsi_sync_control_common(struct ucsi *ucsi, u64 command);
-- 
2.45.2.1089.g2a221341d9-goog


