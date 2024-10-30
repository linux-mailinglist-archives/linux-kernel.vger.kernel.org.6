Return-Path: <linux-kernel+bounces-389599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5437B9B6ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D371F22C06
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92ED21503D;
	Wed, 30 Oct 2024 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XAlGnXJa"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE12178FD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323754; cv=none; b=VOxqRCWlljC0pX6YG3UaT+6vBxieh3/jZe8mCb5ZiRMaytmKeQTypvmRzJFiaS7ojG9eg5PPWkne3IA/kwtVtuwv0kiX1v6mtw+X9/5AwAVTCmEeMt1T3Wkk6z/u932a0TkCFo+Xr7g2q9odXDIjpwJ10/CJZEgDWM7B1UVGoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323754; c=relaxed/simple;
	bh=0F0599rOKHxfQvf7XtskB5Mt/xYLB1cPEJKxRmRO258=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TB/mzZkiAvPuKPMXBJ8cUPC9xRAeJKqLSjKjWDyJ5nMUrPzDPvjG558YKqPYhlXykrDKUaw7w8wRTyc7UcjprKlRu7ppHG6DbVNEhCg5huN4QkansIGTmwLhwJjY0WMNVAkx7sTwlBzkspEl0IretKkFtJIFPZCTqMzU+KuCtng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XAlGnXJa; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2e2d09decso1092678a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730323751; x=1730928551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCXmBmJO0w4Chs93Xm3BeF6wgI3Tb8Gd24Xh4PooSyo=;
        b=XAlGnXJaz2B2u2uBBL2Q66lBVA+GuGGlDQ/1nTaCdzAlGXPjluXtYbWs542W2smDXq
         MjxyKgWrCxihXAwRi3bExtyknkClOcfEJwrukXnBh/nuKjIc5jV+LJFRtmtnIhvHJS0O
         TmQrKbjTXFyom9abMo1zoPiBHn4+FQT95yCeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323751; x=1730928551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCXmBmJO0w4Chs93Xm3BeF6wgI3Tb8Gd24Xh4PooSyo=;
        b=bKHs+humsTP2snW5ogXtlQeOXsu7MV5j6TMLOA6eY8AjuXfkLhPsPclKKoOCTAW364
         htxROqVQPZ7+ZsH5u9Ee2j38Sf2cVvJuyD4Y52R8fc3uQjPteXJYVjAKRwL0wka/Agim
         y42LGPk5dzF6NVb7d+jd+zKD9PZX4VbPdMmlOSE8ETl9gWTccL59D+sQH4w1ozAtyKoF
         S8RuMYj6KAlgnekCzqydj1/4MKZhBGL5bQLUCPV2oTc+BMqcsvQ6XI3FGNisdiFWBov1
         iEoJyF6wct9EJalFesX7qWKtye8EnWLIz//G/chVL/UKyO4CSlUl1d7PWdrItievpf1R
         F7UA==
X-Forwarded-Encrypted: i=1; AJvYcCUCnGze6Yzm8gyVaM4JjHcFawSyJgDFpPjtY02zXJvJlN03UKyfHG8HhdzMvtEnBnwFdG7HPKGMDoiRXAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYZFgYv1jBEeF5pjwb/tGjB8eo2RNNvppo+w/VH8K0sTlXwS89
	shgjVorLRkIx+oio+Jf7Qsvs/vE1mnt4lUpjaVZKBB/anH6Ks3cM0n/ZVID4UQ==
X-Google-Smtp-Source: AGHT+IHBRIrLXFaaBv6UUOjhdIM7tK6tsQj3oOcxvxYkMmGaYVMHAjdBu/AmhHynbAxlaCZw2kdHoQ==
X-Received: by 2002:a17:90b:1b4a:b0:2e9:20d8:414c with SMTP id 98e67ed59e1d1-2e93e0139a2mr257317a91.5.1730323751676;
        Wed, 30 Oct 2024 14:29:11 -0700 (PDT)
Received: from localhost (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e93daac455sm141073a91.19.2024.10.30.14.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 14:29:11 -0700 (PDT)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: dmitry.baryshkov@linaro.org,
	jthies@google.com,
	akuchynski@google.com,
	pmalani@chromium.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] platform/chrome: cros_ec_typec: Update partner altmode active
Date: Wed, 30 Oct 2024 14:28:35 -0700
Message-ID: <20241030142833.v2.4.I083bf9188947be8cb7460211cfdf3233370a28f6@changeid>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241030212854.998318-1-abhishekpandit@chromium.org>
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mux configuration is often the final piece of mode entry and can be used
to determine whether a partner altmode is active. When mux configuration
is done, use the active port altmode's SVID to set the partner active
field for all partner alt modes.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

(no changes since v1)

 drivers/platform/chrome/cros_ec_typec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 53d93baa36a8..0c8db11bd8a4 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -618,6 +618,7 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	};
 	struct ec_params_usb_pd_mux_ack mux_ack;
 	enum typec_orientation orientation;
+	struct cros_typec_altmode_node *node, *n;
 	int ret;
 
 	ret = cros_ec_cmd(typec->ec, 0, EC_CMD_USB_PD_MUX_INFO,
@@ -676,6 +677,16 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 			port->mux_flags);
 	}
 
+	/* Iterate all partner alt-modes and set the active alternate mode. */
+	list_for_each_entry_safe(node, n, &port->partner_mode_list, list) {
+		if (port->state.alt != NULL &&
+		    node->amode->svid == port->state.alt->svid) {
+			typec_altmode_update_active(node->amode, true);
+		} else {
+			typec_altmode_update_active(node->amode, false);
+		}
+	}
+
 mux_ack:
 	if (!typec->needs_mux_ack)
 		return ret;
-- 
2.47.0.163.g1226f6d8fa-goog


