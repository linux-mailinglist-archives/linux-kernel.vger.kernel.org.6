Return-Path: <linux-kernel+bounces-276576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B792949584
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018882821B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EBE376E6;
	Tue,  6 Aug 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wa5eKCEQ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922BC22075
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961530; cv=none; b=fpWGYN+RyO3iqDR3k8lAMU/g19nRme2+OnLAKJZ+0gfTWr3F5zaw5W2VUa1xPPIOu89Wf8fLgHD5firD87VI4f4tmu5rKuu6/DYKX8WOKTyq87cqAY1HsF/1LQgqBcVWpoAc+y2HGG8/vLKxsa8sIHl9VABjZIeNwZ51OyD7b1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961530; c=relaxed/simple;
	bh=oTBUJJI1vQXJwS2FiaFu9Y7ojx78+JWynxOYKuntUuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bwfzgQooWoTPRrPc2kpAjWz8GLEDT5bLVdUtV4mGpmEji5XM7nAazherXPHzhCL6S6Iu4xAA4qmoNEMMXswppCNyptKM3hvQq9amAU6/ALDlFTkM8Beh2LzSUznKfX4QqOT3ih+mwBLUxVG2Mt26otnGDnfGkqn24VeUfmrqejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wa5eKCEQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so1311211a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722961527; x=1723566327; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSqafvChQzM2TrFiryU14TFj9mm+sDcQkE2XBhIKFy4=;
        b=Wa5eKCEQnuyScTls5X0tF12hHOTPa4TteE0Txn+nQUEJ2G+Jq1t+p9q7hPT1UjBWwg
         I0RW2EDZtgGa8R/2PtTPrUVNFwbk35n/V+o8khfsBBBV70hYny2IgpuaH8TdOKbQrARo
         7ryzT/NewfHlxX0xsvoPTuHNn+jHjjr/WSaYOwZP8t/KvnIuz2JXrQIu6oaWYhgqwtuU
         HB+q7P78RsuA9P9re+ICp3EInlh9wt7E4y3USr/53x2TTC0BeTTfwi7nen1Sbt7u4iGk
         bPmm2xUIz25DLJox2pYyZpclSHDDb21PjoLhj5/orQLavTbvdWDTq08KJK7GnnRwbkGX
         VTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722961527; x=1723566327;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSqafvChQzM2TrFiryU14TFj9mm+sDcQkE2XBhIKFy4=;
        b=HRBPGzKUo4bhxA4Ans8IuJSXNzUbgR2rBvFH+iJ0s48Xt/qduyjxG0xnbTUKgznKOX
         SEzXTnJaWwSGHU+rfFnm7bTJNLkI4RsjFcoC5cVDwdP+8bNC2GW54x4H5kqelmAkt9ti
         EdFEMgmdBKwHB0hFB3mSe9WhIMA/auM8cEHZYhOZZhh5P7FKqrPCJw3nAorTzx4AKGN1
         jYgp1yNC6HpivlU0AXn0d/YZ8s6Bcntj/XrVsMTr9D2bNE9Xuj1hUMw5Brkhtq+XFiYR
         M0+vvAMKFihBCgO8isJoyNCWf3dsOzUPSqiIzQaR5a7fOrFoXs81G8CxmWX3bpSR7/wE
         rO1g==
X-Forwarded-Encrypted: i=1; AJvYcCXIFrvymtcs18AeE632HvVyJ2pn6z/GbfXGQaxbcF8+AZI0Wma9jRDHc3D7CC6A4hlLCO+yYLCT6OrgY3j4X7CxrFtuyNswTRO+VOyj
X-Gm-Message-State: AOJu0YyWTJb06imRqqjZ+G7G9+hjkyDlwh3Z2uXTNMtSAkTWYW+lOzkS
	4FxjNKihsCNkhOqiIVnBMxZrvMrxyf9NHz9Fw2gsC+w5zCkz/Xrw6ZMyZRJaRl8=
X-Google-Smtp-Source: AGHT+IExHQjjHNLjNXQcuEiSFLBIDFwPwUYKIj4nFuUpNUSFLM6QMgAWLp83fPySXDgnuY/yg5WG7g==
X-Received: by 2002:aa7:d604:0:b0:5a3:4ae8:cbd3 with SMTP id 4fb4d7f45d1cf-5b7f3bcfb42mr10965870a12.11.1722961526766;
        Tue, 06 Aug 2024 09:25:26 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a552984sm6099399a12.58.2024.08.06.09.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:25:25 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 06 Aug 2024 17:25:24 +0100
Subject: [PATCH v2] usb: typec: tcpm/tcpci_maxim: fix non-contaminant CC
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240806-max33359-toggling-v2-1-a66ab37baafb@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHNOsmYC/32NSwrCMBRFt1Le2Eh+NejIfUgHIX1JH2giSQmVk
 r0buwCH58A9d4eCmbDAbdghY6VCKXaQpwHcYmNARnNnkFxqbgRnL7sppcYrW1MIT4qBOW+8wRG
 F1gr67p3R03Y0H1Pnhcqa8ue4qOJn/9WqYIL5y+yEVF5Zbu9d25zOKQeYWmtfuNYNOrMAAAA=
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 RD Babiera <rdbabiera@google.com>, 
 Badhri Jagan Sridharan <badhri@google.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

tcpci_maxim currently never triggers the TCPM state machine when CC
status has not changed due to a contaminant but due to a real
connection event, i.e. a genuine plug event, meaning the system will
stay idle and not notify any subscribers.

The reason is that the initial state of the port is 'toggling', which
causes _max_tcpci_irq() to only drive the contamination part of the
TCPM state machine (via tcpm_port_clean()).

What should happen instead is that if no contamination was detected,
the TCPM should be notified of the CC change in this case.

To fix this, we update ...is_contaminant() to also allow its caller to
determine if more CC processing is required and then call into the TCPM
as required.

While at it, add a kernel-doc for max_contaminant_is_contaminant().

Note: the code has an issue where I2C errors during contaminant
detection also cause the TCPM state machine to not be updated. This
commit doesn't change this behaviour and should be addressed by
follow-up commit(s).

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- longer line length in tcpci_maxim_core.c (Heikki)
- update kernel-doc (Badhri)
- drop now-obsolete comment for cc_handled in _max_tcpci_irq() (we have
  kernel-doc now)
- Link to v1: https://lore.kernel.org/r/20240710-max33359-toggling-v1-1-f6dc123f3a0a@linaro.org
---
 drivers/usb/typec/tcpm/maxim_contaminant.c |  7 +++++--
 drivers/usb/typec/tcpm/tcpci_maxim.h       | 16 +++++++++++++++-
 drivers/usb/typec/tcpm/tcpci_maxim_core.c  | 11 +++++++----
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
index f8504a90da26..e7fa3e36f8ae 100644
--- a/drivers/usb/typec/tcpm/maxim_contaminant.c
+++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
@@ -322,11 +322,14 @@ static int max_contaminant_enable_dry_detection(struct max_tcpci_chip *chip)
 	return 0;
 }
 
-bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce)
+bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce,
+				    bool *cc_handled)
 {
 	u8 cc_status, pwr_cntl;
 	int ret;
 
+	*cc_handled = true;
+
 	ret = max_tcpci_read8(chip, TCPC_CC_STATUS, &cc_status);
 	if (ret < 0)
 		return false;
@@ -368,7 +371,6 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
 				return true;
 			}
 		}
-		return false;
 	} else if (chip->contaminant_state == DETECTED) {
 		if (STATUS_CHECK(cc_status, TCPC_CC_STATUS_TOGGLING, 0)) {
 			chip->contaminant_state = max_contaminant_detect_contaminant(chip);
@@ -379,6 +381,7 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
 		}
 	}
 
+	*cc_handled = false;
 	return false;
 }
 
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
index 78ff3b73ee7e..7719e291132a 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.h
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
@@ -85,6 +85,20 @@ static inline int max_tcpci_write8(struct max_tcpci_chip *chip, unsigned int reg
 	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u8));
 }
 
-bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce);
+/**
+ * max_contaminant_is_contaminant - Test if CC was toggled due to contaminant
+ *
+ * @chip: Handle to a struct max_tcpci_chip
+ * @disconnect_while_debounce: Whether the disconnect was detected when CC
+ *      		       pins were debouncing
+ * @cc_handled: Returns whether or not update to CC status was handled here
+ *
+ * Determine if a contaminant was detected.
+ *
+ * Returns: true if a contaminant was detected, false otherwise. cc_handled
+ * is updated to reflect whether or not further CC handling is required.
+ */
+bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce,
+				    bool *cc_handled);
 
 #endif  // TCPCI_MAXIM_H_
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 760e2f92b958..22bc05064b3e 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -357,12 +357,14 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
 		tcpm_vbus_change(chip->port);
 
 	if (status & TCPC_ALERT_CC_STATUS) {
+		bool cc_handled = false;
+
 		if (chip->contaminant_state == DETECTED || tcpm_port_is_toggling(chip->port)) {
-			if (!max_contaminant_is_contaminant(chip, false))
+			if (!max_contaminant_is_contaminant(chip, false, &cc_handled))
 				tcpm_port_clean(chip->port);
-		} else {
-			tcpm_cc_change(chip->port);
 		}
+		if (!cc_handled)
+			tcpm_cc_change(chip->port);
 	}
 
 	if (status & TCPC_ALERT_POWER_STATUS)
@@ -455,8 +457,9 @@ static int tcpci_init(struct tcpci *tcpci, struct tcpci_data *data)
 static void max_tcpci_check_contaminant(struct tcpci *tcpci, struct tcpci_data *tdata)
 {
 	struct max_tcpci_chip *chip = tdata_to_max_tcpci(tdata);
+	bool cc_handled;
 
-	if (!max_contaminant_is_contaminant(chip, true))
+	if (!max_contaminant_is_contaminant(chip, true, &cc_handled))
 		tcpm_port_clean(chip->port);
 }
 

---
base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
change-id: 20240710-max33359-toggling-cf7f7e5e1443

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


