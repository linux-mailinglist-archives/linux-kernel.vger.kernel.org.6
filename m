Return-Path: <linux-kernel+bounces-176160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A1E8C2AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 22:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA401F24DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149374D11D;
	Fri, 10 May 2024 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3hc1OM+7"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC114CB4E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372001; cv=none; b=SJbutzGDQd3tmWjC9kYdIbK2fT4CVK1mGJZJKiv0Cmgj6IXC942J+T7A6wqXG6MgrWDAgCYmnxBPc8djWyM4xCG2xmPDHcZNEfTeztsaE9W+4OWR7hn9SjkUxkulc6L6oKwcSB6rYbF9ci+J1MtxGcza1028VwrjwLFFCXHUQXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372001; c=relaxed/simple;
	bh=xQ2rEgQNzAAGgb7mqu13QJRWKCJLNrN/kv/VNptS1jg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EGXbcsty+8oVc8/nTxpP5gQZxW6wXBkx/JK1IUf8DeloJ1lmRFyw7fNP9Gr2wiWiNYnPmux9i4V1HyxzhbmI2Kjnokvf/L3Fwi1Zvl94/8tqXRGK2W3ibxsV+Ei8WRbb9d4JTdp7A6eYmICVV5Kjqkkjnre+zlUwJchQmTQjxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3hc1OM+7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de60cd96bf3so5192050276.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715371997; x=1715976797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSLd4C6RWuRDc53VYjutUDg53I6/Zy/8sBQNs3K9WZo=;
        b=3hc1OM+7SaX/wGre2uA9snQ9GWdp08+vioF0MXI96Ee1wzU0E7FNqDiEcXvMC1+cbY
         5v7ddYzaxF3ep6fnzWmYGpvOrcPJuYPaV7++86nQ6V7DXonYBTuQDQgt7aPsnYCLaWIz
         80QDoSMiGFOLkDtZgRUrscyfzPNBQgfnMncpNps6YXj2wnDLxj5rfBGlwNnVypkF72jl
         fxvkVvNUCfB+DVv3mHOU59HbPkl5+EIv8RuclWw5KyTV7QRsSpRFDZ9qLGLTGGgcKq0m
         GAwj6FuSBCt0fDui56SmFUTILwr/sRzvzq0fOMY6gDaG6YtJ4csORezGZQSwjSsQ+iaz
         NNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715371997; x=1715976797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSLd4C6RWuRDc53VYjutUDg53I6/Zy/8sBQNs3K9WZo=;
        b=HfXpwIQeTBfqI58bOrs8HoxTj4mRqaLHgZBXnRbET+6oCDd2hoTrocfBiyYWOXsa7X
         2r3tI6yvqWABHgq3TNqt/QuIqfWHAwfDqQqStTQHTQokjJg2aiKpwFxqMpWlHezX/arl
         vkuh28MR3Tmhs72Sh4PiZjBk00domcjzCSCjUNo2D7v3GlVMWQjY0mSd6N2rcN4mtsSP
         Jjc7AbLdiwPzbRsruTJCEZaAEN04yGsvn2Hw/fhKGEo3AAAnOIQYxO/hBuNWBvB6Am2u
         mUfhGq2/ZXUOER98It7NMVWL/jFb2/KscAQWI2Mc2H8q80gK0jwu4cVf96MCBEqDHmYN
         LiUg==
X-Forwarded-Encrypted: i=1; AJvYcCWmcrK7rUVjdwqMFhPGqJffYgWtMtZDwHeAjzAVg5Wuv/D0NEI/UsgVILEVlctt7AoLqG35yrAS4fWBeKu7QReJoLWQsG6vEKPZNbip
X-Gm-Message-State: AOJu0Yxd4Dgqb5OYuRDTg8Oe/XJmdd5HsT9OUvI5/d0L96hr386DlTi3
	9aTr87It4yaoXcrRHHtOgTtxSpw5bal0wNdbbFiUdtSE6NfgQK8o0QxI75AoHgT6OQgKk/2NAxW
	fZw==
X-Google-Smtp-Source: AGHT+IFD1gnGHMQrq99VY43M6Y0/j9fkY40gUznD1x217Vy48vxegLfCwAslXjkIGfB/QJUUshSewOKBjGY=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:c0e:b0:dda:c4ec:7db5 with SMTP id
 3f1490d57ef6-dee4e57a059mr1072074276.4.1715371997051; Fri, 10 May 2024
 13:13:17 -0700 (PDT)
Date: Fri, 10 May 2024 20:12:42 +0000
In-Reply-To: <20240510201244.2968152-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510201244.2968152-1-jthies@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510201244.2968152-3-jthies@google.com>
Subject: [PATCH v5 2/4] usb: typec: Update sysfs when setting ops
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

When adding altmode ops, update the sysfs group so that visibility is
also recalculated.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Jameson Thies <jthies@google.com>
---
Changes in V5:
- Fixed signed off by line order.

Changes in V4:
- None.

Changes in V3:
- None.

Changes in V2:
- None.

 drivers/usb/typec/altmodes/displayport.c |  2 +-
 drivers/usb/typec/class.c                | 18 +++++++++++++++++-
 drivers/usb/typec/ucsi/displayport.c     |  2 +-
 include/linux/usb/typec.h                |  3 +++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 596cd4806018b..92cc1b1361208 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -746,7 +746,7 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	dp->alt = alt;
 
 	alt->desc = "DisplayPort";
-	alt->ops = &dp_altmode_ops;
+	typec_altmode_set_ops(alt, &dp_altmode_ops);
 
 	if (plug) {
 		plug->desc = "Displayport";
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 9610e647a8d48..9262fcd4144f8 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -467,6 +467,22 @@ static const struct attribute_group *typec_altmode_groups[] = {
 	NULL
 };
 
+/**
+ * typec_altmode_set_ops - Set ops for altmode
+ * @adev: Handle to the alternate mode
+ * @ops: Ops for the alternate mode
+ *
+ * After setting ops, attribute visiblity needs to be refreshed if the alternate
+ * mode can be activated.
+ */
+void typec_altmode_set_ops(struct typec_altmode *adev,
+			   const struct typec_altmode_ops *ops)
+{
+	adev->ops = ops;
+	sysfs_update_group(&adev->dev.kobj, &typec_altmode_group);
+}
+EXPORT_SYMBOL_GPL(typec_altmode_set_ops);
+
 static int altmode_id_get(struct device *dev)
 {
 	struct ida *ids;
@@ -2317,7 +2333,7 @@ void typec_port_register_altmodes(struct typec_port *port,
 			continue;
 		}
 
-		alt->ops = ops;
+		typec_altmode_set_ops(alt, ops);
 		typec_altmode_set_drvdata(alt, drvdata);
 		altmodes[index] = alt;
 		index++;
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index d9d3c91125ca8..eb7b8d6e47d00 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -337,7 +337,7 @@ struct typec_altmode *ucsi_register_displayport(struct ucsi_connector *con,
 	dp->con = con;
 	dp->alt = alt;
 
-	alt->ops = &ucsi_displayport_ops;
+	typec_altmode_set_ops(alt, &ucsi_displayport_ops);
 	typec_altmode_set_drvdata(alt, dp);
 
 	return alt;
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index b35b427561ab5..549275f8ac1b3 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -167,6 +167,9 @@ struct typec_port *typec_altmode2port(struct typec_altmode *alt);
 
 void typec_altmode_update_active(struct typec_altmode *alt, bool active);
 
+void typec_altmode_set_ops(struct typec_altmode *alt,
+			   const struct typec_altmode_ops *ops);
+
 enum typec_plug_index {
 	TYPEC_PLUG_SOP_P,
 	TYPEC_PLUG_SOP_PP,
-- 
2.45.0.118.g7fe29c98d7-goog


