Return-Path: <linux-kernel+bounces-448221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D79F3D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F215B1885162
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F661D6188;
	Mon, 16 Dec 2024 21:55:44 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BB114A609;
	Mon, 16 Dec 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734386144; cv=none; b=sZzfkXBpHVCPaEv+3vjY4hT8yMgTbcydXa6w/WZUDfNU6rn8bI6kooLac5ddmKl05P1roJJZoXmWkxfCf9GuqCboetyFRXAFHdd3JAkck+5UPw1nPUoPF06HovdNeTIMMetqkBvSf/Bt89oiPzd+VXvizAIi+48IoHqG+8FjMPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734386144; c=relaxed/simple;
	bh=FPttELg76H49itZZAKb+r9R0kb5QpPbnyY9iXhvhav4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsDXMIJU4O0IhAR3cJYNIJFkVDifhZwLQMKEUn/BIs3qwnA4tixlaS7iBTQx2jRvjV7Hg7vXqgjvJ8DNaVNkhQqMu80MnUAMUmoMvO1M7D7lL00YcxyncVsySbmkncTLudQp8f1QPm8MTPN+120BkAn/ozdA9z4zjGiisW4e1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id A98251404E8; Mon, 16 Dec 2024 22:47:00 +0100 (CET)
Date: Mon, 16 Dec 2024 22:47:00 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org, Kenneth Crudup <kenny@panix.com>,
	Saranya Gopal <saranya.gopal@intel.com>
Subject: Re: [PATCH 5/5] usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE
 before reset
Message-ID: <Z2Cf1AI8CXao5ZAn@cae.in-ulm.de>
References: <20240320073927.1641788-1-lk@c--e.de>
 <20240320073927.1641788-6-lk@c--e.de>
 <Z18hJM55ED2hYJ6D@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z18hJM55ED2hYJ6D@lappy>


Hi,

[ CC: Saranya Gopal <saranya.gopal@intel.com> ]

On Sun, Dec 15, 2024 at 01:34:12PM -0500, Sasha Levin wrote:
> On Wed, Mar 20, 2024 at 08:39:26AM +0100, Christian A. Ehrhardt wrote:
> > Check the UCSI_CCI_RESET_COMPLETE complete flag before starting
> > another reset. Use a UCSI_SET_NOTIFICATION_ENABLE command to clear
> > the flag if it is set.
> 
> Hi Christian,
> 
> It looks like kernelci is able to trigger the warning added by this
> commit:
> 
> [   15.988528] WARNING: CPU: 0 PID: 8 at drivers/usb/typec/ucsi/ucsi.c:1377 ucsi_reset_ppm+0x1af/0x1c0 [typec_ucsi]
> [ ... ]

I think I can see what's going on.

First of all: The warning is harmless and UCSI will still work as
expected (but there is an additional delay during init).

The trigger for the warning is likely this commit (reviewed by me, so ...):

| commit fa48d7e81624efdf398b990a9049e9cd75a5aead
| Author: Saranya Gopal <saranya.gopal@intel.com>
| Date:   Fri Aug 30 14:13:42 2024 +0530
| 
|     usb: typec: ucsi: Do not call ACPI _DSM method for UCSI read
|     operations

The (compile tested) diff below should fix it and I can turn this
into a proper patch but I lost access to test hardware with UCSI,
thus this would need a "Tested-by:" from someone else before it can
be included. Maybe Saranya can do this?

     Best regards   Christian


commit b44ba223cd840e6dbab6c7f69da6203c7a8ba570
Author: Christian A. Ehrhardt <lk@c--e.de>
Date:   Mon Dec 16 21:52:46 2024 +0100

    acpi: typec: ucsi: Introduce a ->poll_cci method
    
    For the ACPI backend of UCSI the UCSI "registers" are just
    a memory copy of the register values in an opregion. The ACPI
    implementation in the BIOS ensures that the opregion contents
    are synced to the embedded controller and it ensures that the
    registers (in particular CCI) are synced back to the opregion
    on notifications. While there is an ACPI call that syncs the
    actual registers to the opregion there is rarely a need to do
    this and on some ACPI implementations it actually breaks in
    various interesting ways.
    
    The only reason to force a sync from the embedded controller
    is to poll CCI while notifications are disabled. Only the
    ucsi core knows if this is the case and guessing based on
    the current command is suboptimal.
    
    Thus introduce a ->poll_cci() method that works like
    ->read_cci() with an additional forced sync and document that
    this should be used when polling with notifications disabled.
    For all other backends that presumably don't have this issue
    use the same implementation for both methods.
    
    Fixes: fa48d7e81624 ("usb: typec: ucsi: Do not call ACPI _DSM method for UCSI read operations")
    Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index fcf499cc9458..0fe1476f4c29 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1346,7 +1346,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 
 	mutex_lock(&ucsi->ppm_lock);
 
-	ret = ucsi->ops->read_cci(ucsi, &cci);
+	ret = ucsi->ops->poll_cci(ucsi, &cci);
 	if (ret < 0)
 		goto out;
 
@@ -1364,7 +1364,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 
 		tmo = jiffies + msecs_to_jiffies(UCSI_TIMEOUT_MS);
 		do {
-			ret = ucsi->ops->read_cci(ucsi, &cci);
+			ret = ucsi->ops->poll_cci(ucsi, &cci);
 			if (ret < 0)
 				goto out;
 			if (cci & UCSI_CCI_COMMAND_COMPLETE)
@@ -1393,7 +1393,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 		/* Give the PPM time to process a reset before reading CCI */
 		msleep(20);
 
-		ret = ucsi->ops->read_cci(ucsi, &cci);
+		ret = ucsi->ops->poll_cci(ucsi, &cci);
 		if (ret)
 			goto out;
 
@@ -1929,8 +1929,8 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
 	struct ucsi *ucsi;
 
 	if (!ops ||
-	    !ops->read_version || !ops->read_cci || !ops->read_message_in ||
-	    !ops->sync_control || !ops->async_control)
+	    !ops->read_version || !ops->read_cci || !ops->poll_cci ||
+	    !ops->read_message_in || !ops->sync_control || !ops->async_control)
 		return ERR_PTR(-EINVAL);
 
 	ucsi = kzalloc(sizeof(*ucsi), GFP_KERNEL);
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 5ff369c24a2f..e4c563da715f 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -61,6 +61,7 @@ struct dentry;
  * struct ucsi_operations - UCSI I/O operations
  * @read_version: Read implemented UCSI version
  * @read_cci: Read CCI register
+ * @poll_cci: Read CCI register while polling with notifications disabled
  * @read_message_in: Read message data from UCSI
  * @sync_control: Blocking control operation
  * @async_control: Non-blocking control operation
@@ -75,6 +76,7 @@ struct dentry;
 struct ucsi_operations {
 	int (*read_version)(struct ucsi *ucsi, u16 *version);
 	int (*read_cci)(struct ucsi *ucsi, u32 *cci);
+	int (*poll_cci)(struct ucsi *ucsi, u32 *cci);
 	int (*read_message_in)(struct ucsi *ucsi, void *val, size_t val_len);
 	int (*sync_control)(struct ucsi *ucsi, u64 command);
 	int (*async_control)(struct ucsi *ucsi, u64 command);
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 5c5515551963..ac1ebb5d9527 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -59,19 +59,24 @@ static int ucsi_acpi_read_version(struct ucsi *ucsi, u16 *version)
 static int ucsi_acpi_read_cci(struct ucsi *ucsi, u32 *cci)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	int ret;
-
-	if (UCSI_COMMAND(ua->cmd) == UCSI_PPM_RESET) {
-		ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
-		if (ret)
-			return ret;
-	}
 
 	memcpy(cci, ua->base + UCSI_CCI, sizeof(*cci));
 
 	return 0;
 }
 
+static int ucsi_acpi_poll_cci(struct ucsi *ucsi, u32 *cci)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	int ret;
+
+	ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
+	if (ret)
+		return ret;
+
+	return ucsi_acpi_read_cci(ucsi, cci);
+}
+
 static int ucsi_acpi_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
@@ -94,6 +99,7 @@ static int ucsi_acpi_async_control(struct ucsi *ucsi, u64 command)
 static const struct ucsi_operations ucsi_acpi_ops = {
 	.read_version = ucsi_acpi_read_version,
 	.read_cci = ucsi_acpi_read_cci,
+	.poll_cci = ucsi_acpi_poll_cci,
 	.read_message_in = ucsi_acpi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = ucsi_acpi_async_control
@@ -142,6 +148,7 @@ static int ucsi_gram_sync_control(struct ucsi *ucsi, u64 command)
 static const struct ucsi_operations ucsi_gram_ops = {
 	.read_version = ucsi_acpi_read_version,
 	.read_cci = ucsi_acpi_read_cci,
+	.poll_cci = ucsi_acpi_poll_cci,
 	.read_message_in = ucsi_gram_read_message_in,
 	.sync_control = ucsi_gram_sync_control,
 	.async_control = ucsi_acpi_async_control
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index fcb8e61136cf..bb0dc2005c05 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -664,6 +664,7 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
 static const struct ucsi_operations ucsi_ccg_ops = {
 	.read_version = ucsi_ccg_read_version,
 	.read_cci = ucsi_ccg_read_cci,
+	.poll_cci = ucsi_ccg_read_cci,
 	.read_message_in = ucsi_ccg_read_message_in,
 	.sync_control = ucsi_ccg_sync_control,
 	.async_control = ucsi_ccg_async_control,
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 90948cd6d297..a78e53480875 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -201,6 +201,7 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
 static const struct ucsi_operations pmic_glink_ucsi_ops = {
 	.read_version = pmic_glink_ucsi_read_version,
 	.read_cci = pmic_glink_ucsi_read_cci,
+	.poll_cci = pmic_glink_ucsi_read_cci,
 	.read_message_in = pmic_glink_ucsi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = pmic_glink_ucsi_async_control,
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index 6923fad31d79..57ef7d83a412 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -424,6 +424,7 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 static const struct ucsi_operations ucsi_stm32g0_ops = {
 	.read_version = ucsi_stm32g0_read_version,
 	.read_cci = ucsi_stm32g0_read_cci,
+	.poll_cci = ucsi_stm32g0_read_cci,
 	.read_message_in = ucsi_stm32g0_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = ucsi_stm32g0_async_control,
diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
index f3a5e24ea84d..40e5da4fd2a4 100644
--- a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
+++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
@@ -74,6 +74,7 @@ static int yoga_c630_ucsi_async_control(struct ucsi *ucsi, u64 command)
 const struct ucsi_operations yoga_c630_ucsi_ops = {
 	.read_version = yoga_c630_ucsi_read_version,
 	.read_cci = yoga_c630_ucsi_read_cci,
+	.poll_cci = yoga_c630_ucsi_read_cci,
 	.read_message_in = yoga_c630_ucsi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = yoga_c630_ucsi_async_control,

