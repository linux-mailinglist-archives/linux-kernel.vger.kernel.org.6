Return-Path: <linux-kernel+bounces-176162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B0B8C2AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 22:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F5D1C226A8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A711252F7A;
	Fri, 10 May 2024 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PH4C1t5r"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A0F50293
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372005; cv=none; b=Dh3ITvIJ6keHxLhruI0vWd6MDsPjTrNuRJ5QD5heDMe/nbjfsOGhIDcpTSwOxzKYGaUmARmlo3e2H8+0ywgAdtikUSP5h+mhLy46oDt6WBnTjOWM2ihvBLYNB5bX7YCtvX7Z+FfxMPbd5sqzZ6TyTxAqpelpJXIyZhwndX7wc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372005; c=relaxed/simple;
	bh=hUB2oms6xp9c47rZp7BKMmLVOt10/JNv5LT/f7l1e0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GjHabghu7lIBgidV3alHw//25HvYqNOThAsQJ2u97tecwifMps1xLiZpUUFiWixh5lPCBJwfRMsIQVV7h03TbrAxaXOG/BqgAENqxZu1wvtMndOmeBYjTq5L3qvsa7pmRz83+jXce6wxf/NR6XigQFVDOx3weQRZaWPppBFIsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PH4C1t5r; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be3f082b0so39253537b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715372003; x=1715976803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YhvBEaMPWNIcwJictLHqDEbzNX1B8hMyot5dxcw8pLs=;
        b=PH4C1t5rueWpAhKXhgdxN8qSwdZbn5v0UslS8QRVWfXNKOrlwUdy8l4MPfTx3ORdgL
         2B2KmcBvNsA+GYarR1MckZvT2JnA0KRL4v0LOv/pwkGO9csHK6mB37JSgpGM+r0lYpKN
         Ui/UojmSw4SBimx/N5fzeXvZrTiS0MWcxwOP+lhMmfY9WJE9Ha31FUekHXVT/Kymkjv5
         SMTRtXwkfZLl1Z8M0+IQkqQOKVoAhQLvKwC//+IXTtNbCdgLstOPNqRme0v0tdg4iMFs
         OVjloCY23tZZGqUUIOgCSCZVFlFniHnO4JhhgSW01KUAR8qVmg38KaXU5qTrLgYEjDk4
         htEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715372003; x=1715976803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhvBEaMPWNIcwJictLHqDEbzNX1B8hMyot5dxcw8pLs=;
        b=Dt/zX+FezzG/uhFAOEdX9hVLlrZHhlHYaKLQySKZxG/Xu8IisI87tWGNNwaavBJbZJ
         qB7Bi6qGz9ejwnAICIJ2fUSWNJZTTP4bo/nb+uBnZGea3o3oWzHRqPpdqPmrSWZtrfLa
         Cn/D7KkHilhqwfHuGhmcVDHKE9X8qsaHS2lZsq/DxJAglJOBS0AX7BbCQHgRROGGoyVB
         9sdaTKMvcCwDkc61WtaReHm2+uOsd1Nv/JFddPQXjsuN5pQBSUrJN8KEE/qchoaoZq8W
         XIMGHRiXycWV0jCo9qNSokaqF1yzp2sNAhVUbkx50cs8FyNCTFhRvWWdHkv/BUVklTX8
         Ugdg==
X-Forwarded-Encrypted: i=1; AJvYcCUpezHu49Zs5gFqmwa2Qaj09LUE0qdBcvABxYuvuYQjmWLU3w2M98Ryd283AHjT3WBrubfAtdSpCRyhjZH1ASVfeAj1m9CslZY8KG4z
X-Gm-Message-State: AOJu0YzKj+2y/reQ0JCVFO1/vqUvS69nurAPa9L41pdj3n2bPcAhVpm+
	ObpxdUFRV8NTU+bfZNRx5m3QapURRsC10HnVAN2dTcE8Q3pALRMazoWozcfwWgy1Zx99DTREI5y
	o5Q==
X-Google-Smtp-Source: AGHT+IHSOagr0nWF2zL0Nd4uRaZ7DGKHXDXfOLIV5EwzElZtcmActJInDo022AlY6Ss7BHva64+9QW1t4E4=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:690c:3608:b0:61c:a9ce:3092 with SMTP id
 00721157ae682-622affea282mr8824807b3.5.1715372003063; Fri, 10 May 2024
 13:13:23 -0700 (PDT)
Date: Fri, 10 May 2024 20:12:44 +0000
In-Reply-To: <20240510201244.2968152-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510201244.2968152-1-jthies@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510201244.2968152-5-jthies@google.com>
Subject: [PATCH v5 4/4] usb: typec: ucsi: Always set number of alternate modes
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Providing the number of known alternate modes allows user space to
determine when device registration has completed. Always register a
number of known alternate modes for the partner and cable plug, even
when the number of supported alternate modes is 0.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Jameson Thies <jthies@google.com>
---
Changes in V5:
- None.

Changes in V4:
- None.

Changes in V3:
- None.

Changes in V2:
- None.

 drivers/usb/typec/ucsi/ucsi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index bb6e57064513d..52a14bfe4107e 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -812,10 +812,11 @@ static int ucsi_check_altmodes(struct ucsi_connector *con)
 	/* Ignoring the errors in this case. */
 	if (con->partner_altmode[0]) {
 		num_partner_am = ucsi_get_num_altmode(con->partner_altmode);
-		if (num_partner_am > 0)
-			typec_partner_set_num_altmodes(con->partner, num_partner_am);
+		typec_partner_set_num_altmodes(con->partner, num_partner_am);
 		ucsi_altmode_update_active(con);
 		return 0;
+	} else {
+		typec_partner_set_num_altmodes(con->partner, 0);
 	}
 
 	return ret;
@@ -1138,7 +1139,7 @@ static int ucsi_check_connection(struct ucsi_connector *con)
 static int ucsi_check_cable(struct ucsi_connector *con)
 {
 	u64 command;
-	int ret;
+	int ret, num_plug_am;
 
 	if (con->cable)
 		return 0;
@@ -1172,6 +1173,13 @@ static int ucsi_check_cable(struct ucsi_connector *con)
 			return ret;
 	}
 
+	if (con->plug_altmode[0]) {
+		num_plug_am = ucsi_get_num_altmode(con->plug_altmode);
+		typec_plug_set_num_altmodes(con->plug, num_plug_am);
+	} else {
+		typec_plug_set_num_altmodes(con->plug, 0);
+	}
+
 	return 0;
 }
 
-- 
2.45.0.118.g7fe29c98d7-goog


