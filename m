Return-Path: <linux-kernel+bounces-445711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2389F1A31
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC1B162C64
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256D41F03D1;
	Fri, 13 Dec 2024 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B5QhcAwP"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4FB1E8835
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132962; cv=none; b=L57HMlb5/6kSqfKrO1T6h0yfC3JWf82nQoAp9NIuMTTUahQmeV+btt3LCD+JCn7eFwkpOhtq30puaHLZTvyB8/IT26E5UoXlWXsyeoeOtsuvtFqvVQx5acqaciVxidVpibesSDOUYBzuFUehWdX48LlaE5yZnyGcigGT2KCHPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132962; c=relaxed/simple;
	bh=xa7ZITbx/fKw+VP+IHzx4VpDezXjxvTI2S/mn22zsww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSCtgrkSxZGXwFtC1Tuz81SU1pgxwh6WPHUTaOZ8/467yVMAQwWLfTy/xYl45A3mNn/K1U0b3Y51Jo9D9XupwC/kWXPliM6DXOeVDu0wH4pRBSuEkw+W5SEJij9fcNDTlmjJq3DxrRr2on3BpdcprAnA+Msmw0RCYKQ39ehJfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B5QhcAwP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163bd70069so23598585ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734132959; x=1734737759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoXGk9cHKtSOQa4a6C6LkFtb9JQOG5rkseWbgU5QyPQ=;
        b=B5QhcAwPg5jqAYOui85hHiZUYhyVgqb7sIWbEoZNhrXymXXWachWwzDUuOFH2aNrbV
         i+qLl9QZC+RmS5gPo+9JAb2yDS3RF1pzwCp/phBBTCsTqM0rZDbMRzpNXe6dzvXymlcX
         jd4uRnQclj21KmM/2iA4rMT2xgIDJwBlfrqqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132959; x=1734737759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoXGk9cHKtSOQa4a6C6LkFtb9JQOG5rkseWbgU5QyPQ=;
        b=b2FhBCrdjnzkoaquMjhuJgEBkEA6VYthvoGFVVefCiAf89Fj0h+hIlCdKcSLwbDTDn
         /RVLyyG6D4AuvooyCM9J7l2uvO/UGU4UYjkieM3mhgvvlLQp1IH9ybwbkRzz0uB2FiaH
         JWjxwpBanOkV+MZADrCgYwTe/2L5y7vO7qwaokf+aag4d6ttkLNhZR/7okAb6bM/BFeQ
         ZJxwgRhwkOuOY2JOmSjlUmsMd3zCQjAuvTgdxlK/yWAxqEmPDZXshv8F/eJkjY55xWE+
         XgyaZYgL0TD47r5UhnOBYNJyft+sOm7DqhBMiMfiafntYgYVpiQsrgq6sRb/db3GAoib
         1CQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH65E7BjDsSRwLDoAPq0yVrqa2lHIAU6jcEAOpIrTmYXVK7HSBDr38vHm+Y4gs1SzJKho6aAvyK9MSY10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTv5lo/UNFJNe4T9IX+rLhfr/aFlNlmpd6+snVzRIklqvrVLB
	XNUCF6a4fBxF4N3ptoxLNDmM1AX+Yev2qAkSySibmmLHiFksU+N1K3AHYA1S0w==
X-Gm-Gg: ASbGncvdlGerWGNQClO4Dnbzz4oW2lVQimi8bHKMbYhi4uyTfG4G9h45iWvqsLrWRor
	qxn8+dT84gI/9l/8CAoFhCfpiVD955trLSqGaUG/cKEGP3ZttMTlxNqMFshCIYT3iwWnOWkNN6p
	CpHs5Svpv11CfsHHpWJ1AunU9WGS2uwzDeM9MGIzlL798GNVaY+Y+WCzFm1zuXkdPn+pZY7eg7E
	O/xhvKMNQZ8CBR80AEoMDnLqgbxvJmc+qWkvV+R50Wi9vnGS3Vz98RvRnG15LRoAXbSYPkFeAjl
	pP5wZdFZNf9YZMrCIcS3lbcdsg2br1A=
X-Google-Smtp-Source: AGHT+IGj8OoR6PcX7JFvEhC3cr+1TepLuESzGZ1SSO6zsYDlRXtgjRP76IUOq4gmFU1odsuAMpqg/A==
X-Received: by 2002:a17:902:e84f:b0:216:1543:196c with SMTP id d9443c01a7336-218929d708bmr57844975ad.27.1734132959517;
        Fri, 13 Dec 2024 15:35:59 -0800 (PST)
Received: from localhost (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-218a1e5437asm2896585ad.162.2024.12.13.15.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:35:59 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: akuchynski@google.com,
	sboyd@kernel.org,
	pmalani@chromium.org,
	badhri@google.com,
	rdbabiera@google.com,
	dmitry.baryshkov@linaro.org,
	jthies@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/8] platform/chrome: cros_ec_typec: Update partner altmode active
Date: Fri, 13 Dec 2024 15:35:46 -0800
Message-ID: <20241213153543.v5.5.I083bf9188947be8cb7460211cfdf3233370a28f6@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241213233552.451927-1-abhishekpandit@chromium.org>
References: <20241213233552.451927-1-abhishekpandit@chromium.org>
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

Changes in v5:
- Use list_for_each_entry and simplify conditional statement within

 drivers/platform/chrome/cros_ec_typec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index ae2f86296954..77f748fc8542 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -619,6 +619,7 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	};
 	struct ec_params_usb_pd_mux_ack mux_ack;
 	enum typec_orientation orientation;
+	struct cros_typec_altmode_node *node;
 	int ret;
 
 	ret = cros_ec_cmd(typec->ec, 0, EC_CMD_USB_PD_MUX_INFO,
@@ -677,6 +678,14 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 			port->mux_flags);
 	}
 
+	/* Iterate all partner alt-modes and set the active alternate mode. */
+	list_for_each_entry(node, &port->partner_mode_list, list) {
+		typec_altmode_update_active(
+			node->amode,
+			port->state.alt &&
+				node->amode->svid == port->state.alt->svid);
+	}
+
 mux_ack:
 	if (!typec->needs_mux_ack)
 		return ret;
-- 
2.47.1.613.gc27f4b7a9f-goog


