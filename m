Return-Path: <linux-kernel+bounces-435801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38569E7CB7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0421188791B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41FC215067;
	Fri,  6 Dec 2024 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QBfg9eJs"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BB3214818
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733528332; cv=none; b=ZEKNUfO7gwJbFk63OTp6gAhKetfM90YM/KSuXNMi/U5CWB7UMINRQj0mDTFUV5PInCMGHVJsn41FhibscJdIfVrlx97AzzAVVVsziuMPYda5jFXXr8/8DlNb42kMxrQtOmqNvxJ3z43TUuSVrEelzRyk37MAuZ4VtSxhr2Ah06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733528332; c=relaxed/simple;
	bh=mSbImJ4dzWme04JaRICj6xcOiMD+Em1Pq6oCKRsC+SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bkod9wOzBm/mRKVU+DK9msRJ9msMcbyX3bPmQT645tb04vLnQ7Rk15/rpzDwhCrR66ys3YLpTLlj7NGWNtHYSYmqrPR1BQGnsk++58IMuWanzdmyIB0moJTJ/JhX7jP/Wph31gZcm7hT8foGb9n8Fq9hmQC6jcs9h3SBo89MKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QBfg9eJs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-215b45a40d8so22734665ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 15:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733528330; x=1734133130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcArLAGlc9DQDoWi6KCdvmZsVO2iZiC3gTAsa+lsHVQ=;
        b=QBfg9eJsFfMm2MCqnNjPWey35dGy4Q4Gn10RNRp5un54nhonw2bgAlC/r/i8Mr8FtL
         hS4dmV+5RQ+z8Znt+jxKnh5IPbHeZUoRIEhHYM4RnZYsWPtq769WlUWaEgTA+n6T/Vm/
         C74em7f1Ec7GxhNz0AjLDLurIJ5ZuM5jxOt5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733528330; x=1734133130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcArLAGlc9DQDoWi6KCdvmZsVO2iZiC3gTAsa+lsHVQ=;
        b=JEdn4PPJ9UeK0CrlE64xDnRJo68WE03gY9RJsBRP0fVi67quk8EBTcemoTzz5D5vtY
         Ol9bE/GC91NW2wWRNV50OkmCi63XU+rUVJWQS6c745KmyN718aTNkr1YwsDs75BfQR+9
         Batcod7Tq48bhKdexxHZc7Lqpq4YdQxzz7U+WPqKVtQkqyy+/jrOsUFB+rspk2PinaUM
         XAt/oLYpFr9loaewSxfNhnou0MuMxkOGEgAo7zz2e6vDgw4Ea3uOVmAD7pLdp1KHONuP
         12bIXALo0/d7WN0kqD9/ntizvLgaoKjvcVCEAR4Yj8QieX/vVulZ4zCg8UeRbQSOIITM
         jzBg==
X-Forwarded-Encrypted: i=1; AJvYcCX+Bg998fEfySykKAQWQ+A0gKfv3qfuxyGCh0vodsYLPdtQ9uwTseTn97Lt2RbMSBukm5xt1C/HioUOfGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywLq0nu0TpLYB3rJx6e27iU8m3XoFNmQWjrvTuycMJFTUu+iKB
	V+r6yxATN6uomrZddqBdDTO44qLtuLV+9rmvvQJt0jUeFNG833PEGIvUsFAfXw==
X-Gm-Gg: ASbGncsKc4aRWiKpAyeapjZ4zZxPjyfMlpfgBhvr65hYtab2a0zQwhuEcn2/7cWvq7B
	47+osQwDOt+OeB/QJYdBYOiIkT3jZjXFpWaLml+3ekRy2MPSQyYHhh9nt1pYSDoUS07mGECZbrU
	bdyZTlBsxGjIoNeqlQsg71VZzrtW6arDZQxK2ijJuzTYNXMXrid0+Uo2LvJAPnjarK037bx6Qey
	rGR6RwLTVKyeytPrYzU07082wHqldUNDwFgbuN3TH7q47LpwhLTt+IWovEV/0EGvIwzyjhYeGKa
	1x5b4Xgz8KbmJUkGzxJn2/zq
X-Google-Smtp-Source: AGHT+IFfLFsxeaCP6JpA4wv/h1BK8Dgjnc9khGWbX2GJzIK3a3OtB6TO5+qcZX4naTvJeWS7CY8AWQ==
X-Received: by 2002:a17:902:d2cc:b0:215:94c0:f6ea with SMTP id d9443c01a7336-21614ddb7b8mr57867325ad.56.1733528330015;
        Fri, 06 Dec 2024 15:38:50 -0800 (PST)
Received: from localhost (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-215f8e3e452sm33980235ad.43.2024.12.06.15.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 15:38:49 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: akuchynski@google.com,
	pmalani@chromium.org,
	jthies@google.com,
	dmitry.baryshkov@linaro.org,
	badhri@google.com,
	rdbabiera@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] platform/chrome: cros_ec_typec: Update partner altmode active
Date: Fri,  6 Dec 2024 15:38:15 -0800
Message-ID: <20241206153813.v4.4.I083bf9188947be8cb7460211cfdf3233370a28f6@changeid>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241206233830.2401638-1-abhishekpandit@chromium.org>
References: <20241206233830.2401638-1-abhishekpandit@chromium.org>
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
index c7781aea0b88..e3eabe5e42ac 100644
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
2.47.0.338.g60cca15819-goog


