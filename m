Return-Path: <linux-kernel+bounces-229120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F57916B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2D41F21C38
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F56171E41;
	Tue, 25 Jun 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oJJE5Buv"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A116DEBA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327278; cv=none; b=d3l8oH7NFcCsrrrePCA6353oR5NQ8HhA4LfC6BMY/Yy3pp6+Lj8ridO+xzOWqEcwEEdpCbgOSMi/QMH1wPJ9r/S843pewdtBhcxG4x7uj8NZYl0lfXf2SioHQtSG9iobes7spXYtDQmgeM+68cXAyc+plV/1OEl40FIZP+4wAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327278; c=relaxed/simple;
	bh=mI5j32lGmh9mGgx/qR0lTHll3MYLBaGs+ozW531l430=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sDhl/kZ0kouOA1dGS/0lH3ZYyf8rrb+JKpZaqxHJ7K5kMbyUBkJpGZm45QKVu4SaY4gYY6WidEyCy//FPNzbh5iT8vayNBiXaUqfgkJ/aIJVimPGh27rnQjH4g6THtjTKr6VsFT7f4fqZi6JFT3bVNFaIAlKiHgagP0bEq1dD+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oJJE5Buv; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cd628f21cso4817286e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719327274; x=1719932074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cd2X10zVjMn+EpTL9h3lm0rs/LnmaQV9sjYCW3W4aNs=;
        b=oJJE5BuvahRP12naSnUVYs4rslHdKo4HnnqhN73N4g6GDK2lxvJ9HdM6q6SrN/XMQy
         i8Bj9dJtlESIzpniA6Y+1R0jzXkcKi5pfI5aKm265ItfIZh8U0uSwUtgmx5P/lbR01Ou
         lTKblWXAXqvpfPC+Np6ee5TxjoVpWfai+9n4lQECZ+75TYSHwAn08FxPhUCEhmIanuOm
         H87ZtthKNM5KnjXUJ7mYk0tnTP31OMYGtDoHaiXEmS0gsYdZizl8BVAXKimJTtRVrWnN
         fHj8bzQPMiDeK6Zo73ki3FwYZV/1IomZAam1L5rd+bdJmnYCWpGJ0dvFf9UHfpzVl3mb
         Y0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719327274; x=1719932074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cd2X10zVjMn+EpTL9h3lm0rs/LnmaQV9sjYCW3W4aNs=;
        b=EHgnr2d79Oc9SRqWaxCycuvA2JnFLG0173mL7yUJR5gdrzIV59DuOFW3sKbNLAhYcE
         KchzWeNchNqcEeC20X4ysvnSxrZzMI4qXmYAJlabwMlgmCfWQ0KSMhoyMWIBQJXbuuqD
         /0wtBmdFDqKEjR/mtKbzqWnnMcUx/aYpMY1vs1042//2d7OVC3detrgwN4M0BXketqqZ
         go/LtJt2ArcYmSa06eNOl5HiOX5WC8rusOwL9UB5O3dlhFjJWFMQs4PoPmR0ILImuXii
         vnARQP5SLtfLMET9Qfuj7UrFOGajhwlUd85xycfNmMKYXweog48uXwjejwRFMNsCs+RB
         uCAw==
X-Forwarded-Encrypted: i=1; AJvYcCV5XIfAbU+Y5NaEMiEkOKuk5OD8RWlMtd9wOvCLwnUI7drHVWr3utDNgyueS7WpmGqcTi4K3Ka5XDtLjfajCJpyLUrlAmimhSwgczve
X-Gm-Message-State: AOJu0YxwvrJf6oI5vNRZVKBdTm7IIP+WgmFchD8JR8yr8jBMnbNEpJbL
	NKwvxJXsNlVJOqmx5EA8sWVx2Ze+C0pVjT9Bgg4AdoV/J5gHvhd2rUkdrxBF98Q=
X-Google-Smtp-Source: AGHT+IFBU/FqlV1rlHFm7VcDP7TI1En+d6tYg9faOguYFxQeaenBL0P/drueNcNZbM5bdmNqJCDT6w==
X-Received: by 2002:a05:6512:2394:b0:52c:d84c:1182 with SMTP id 2adb3069b0e04-52ce1862c12mr5311099e87.64.1719327274126;
        Tue, 25 Jun 2024 07:54:34 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd64328b7sm1251877e87.221.2024.06.25.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:54:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 17:54:30 +0300
Subject: [PATCH v3 5/7] usb: typec: ucsi: inline ucsi_read_message_in
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-ucsi-rework-interface-v3-5-7a6c8e17be3a@linaro.org>
References: <20240625-ucsi-rework-interface-v3-0-7a6c8e17be3a@linaro.org>
In-Reply-To: <20240625-ucsi-rework-interface-v3-0-7a6c8e17be3a@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Nikita Travkin <nikita@trvn.ru>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=mI5j32lGmh9mGgx/qR0lTHll3MYLBaGs+ozW531l430=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmetojhmAknU4eETQ/0OVEnR93dwpzXwqv4zv11
 DBDhLbs1XGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZnraIwAKCRCLPIo+Aiko
 1Zv3B/9UujGkolgkJQLF8DrUxTo7LuRVr+QOZJVWx5Y+Qqj2Vrktn20TdD10r17dEMR4lI7w1VC
 UMrX64IlrvWdR72wijPKPH6uafW5wUnCh3PNSBQgh+/03iBS8LwLJHaACH8JzISR8VnV8dh6Cya
 Xn2x+c9iwslIG6VPuSj+cxfyP1RPp+XY24Um3N7VOqS9MpeuJ54FtBQ9SwcEq/lf33MRf/+Vxv+
 WwdlSitm/UoP2YJG99Fmg4nhaSNFDyyuKOvwrwC8TVZlSnhgehx4ekDRPW/4pQEtyC2R6/PNpN5
 9FXIu8GWZ1DIn1Pb30kNSGbmuqxjMWkVwcYgoe6MFIjYwGMf
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There is no need to have a separate wrapper for reading MESSAGE_IN data,
inline it to ucsi_run_command().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 5f8e5ed9e0f9..e14366e20cd5 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -36,19 +36,6 @@
  */
 #define UCSI_SWAP_TIMEOUT_MS	5000
 
-static int ucsi_read_message_in(struct ucsi *ucsi, void *buf,
-					  size_t buf_size)
-{
-	/*
-	 * Below UCSI 2.0, MESSAGE_IN was limited to 16 bytes. Truncate the
-	 * reads here.
-	 */
-	if (ucsi->version <= UCSI_VERSION_1_2)
-		buf_size = clamp(buf_size, 0, 16);
-
-	return ucsi->ops->read_message_in(ucsi, buf, buf_size);
-}
-
 static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 {
 	u64 ctrl;
@@ -70,6 +57,13 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 
 	*cci = 0;
 
+	/*
+	 * Below UCSI 2.0, MESSAGE_IN was limited to 16 bytes. Truncate the
+	 * reads here.
+	 */
+	if (ucsi->version <= UCSI_VERSION_1_2)
+		size = clamp(size, 0, 16);
+
 	ret = ucsi->ops->sync_control(ucsi, command);
 	if (ret)
 		return ret;
@@ -98,7 +92,7 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 	}
 
 	if (data) {
-		ret = ucsi_read_message_in(ucsi, data, size);
+		ret = ucsi->ops->read_message_in(ucsi, data, size);
 		if (ret)
 			return ret;
 	}

-- 
2.39.2


