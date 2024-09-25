Return-Path: <linux-kernel+bounces-339410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BE79864CF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 096ADB25CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2876B13BC18;
	Wed, 25 Sep 2024 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WRuEj+Rl"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8CF82499
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281522; cv=none; b=N8PpPAO3mISXJ8oTSYftdnfxOuQG8fwyNcm2bICwnKsK30gVruONN4x1OL+MV84TJgDJP9+Xl2lcJjFhv+HSUZdsk6rqSe0FQeGy2NS2brw/3gh9pa9YXD7uW5Md3HeR8BPl+/YkuvLEi3FqnNl1qmVZd23giuo86sztZ/wsHbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281522; c=relaxed/simple;
	bh=5KNMEDZa878kPVqTQYAgt5rJ1bRAcDhbeuuRaAZ6pXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uw+ZLfFB6Ffke1DwIkLw1YwQ+Q4keo6iQAaMPgZdKclsj9H7g4sQbt3ib84iMXAkJXiphzwcum+Cr1QThTxAK+VJ6ijHxkZU6VBeT3LyQTeSASHT2Hmy2oYj5eaZh2Q7+Bcop2tjszlbHSdFSCFBWR82mjkt7+MchfgN9ab01H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WRuEj+Rl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718e285544fso85496b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727281520; x=1727886320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUxUAUbV9VGCkZrJxGOz2FTlolmwHOuBYZDZ/Je7+jc=;
        b=WRuEj+Rlt6NjnPbOC7JFbZTUaxcPjkRfxM5odadzg5rQ8tbYlPYcihsf7LqOji8fKe
         jORq+U3RbGqhuLJ8Yo3CVmFDfYekk6M/zlEikb2JGvVQrgvoM8WLRaTSnuZLXKG2HYS1
         LjA5ls5M8YbNCPm9tOKMmgc3yIZzH3yMmueUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281520; x=1727886320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUxUAUbV9VGCkZrJxGOz2FTlolmwHOuBYZDZ/Je7+jc=;
        b=LeIWPKDxZw1EgxztvYBaJMItmd8EcDCCDOFtTKeaSaBemAYISSu9OdpFtJd61blUdO
         XKoUvifVgSHmv0gOiPQqQt169bmkiXyC3uN8V1OUqTl5eTY9RLqOnHWVVsigBl2jaUT5
         fFOEfZVFs/PEO+LPMfKKzJfODyFF3kxvsQjq5BDwomzYV4VsUYXE7QFYWXD8b3gVnTVP
         sQfdRVdCqO2WIZ6JQXCPtFpkBdzOHe2Rgu3l604Uix0A7YXgnk6JIZNA90fU6J3OcIVZ
         j0QGxeGobQQgR58oxSwTESnxOuGiNyVJBnDkZSnb8KPAjcIf9A1ECsfVV9XCmIvVn0vS
         XsoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsB/hbRYoglQb5jnpWjI+osHQcpnPu7JheSInAHaM9toCDqqdJb00HI+FRhDHmhQAUiKFexMygLnB1W3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPQhGAWpWuEWgyKV3leQTHs+6Hvyeo+RxsCj9aKjA6eQ49y3n
	moTc8hGrRhuWxUJRp1U3RgRTbJsk0uvx8fL9qF6SPPhnWr9pTvw+n8an8F2YPg==
X-Google-Smtp-Source: AGHT+IGe9zjfGh22fxAYaBDNZiLrvl1zf40GR5xv1xmX2iPdogkak7P63JpyCmzW9gYeMq4h5sj9ZA==
X-Received: by 2002:a05:6a00:802:b0:714:1bd8:35f7 with SMTP id d2e1a72fcca58-71b0aae9a98mr4345517b3a.15.1727281520057;
        Wed, 25 Sep 2024 09:25:20 -0700 (PDT)
Received: from localhost (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71afc9c7a14sm2923078b3a.218.2024.09.25.09.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:25:19 -0700 (PDT)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org
Cc: jthies@google.com,
	pmalani@chromium.org,
	akuchynski@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] platform/chrome: cros_ec_typec: Update partner altmode active
Date: Wed, 25 Sep 2024 09:25:06 -0700
Message-ID: <20240925092505.5.I083bf9188947be8cb7460211cfdf3233370a28f6@changeid>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240925162513.435177-1-abhishekpandit@chromium.org>
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
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

 drivers/platform/chrome/cros_ec_typec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 4d305876ec08..6c0228981627 100644
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
2.46.0.792.g87dc391469-goog


