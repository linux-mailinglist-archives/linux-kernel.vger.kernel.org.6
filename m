Return-Path: <linux-kernel+bounces-558759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DE6A5EACD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EF4D7AA0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8B81F460D;
	Thu, 13 Mar 2025 04:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d1j28/+P"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640261F4285
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741841292; cv=none; b=atS4wcUZe1787agIcP9DfGiL9IY+LReNxR9Qm/Ed0Fr3ft3pn9sFuGVSLk6EBDhpLMrF79OaGLoEqoMwiEGCHdWUsnpjrCtjhapWJxMK3ZxjoGHLlf3Yia8CCd90z6ppkL234olVZYrUlKCyv6TuQBvvLz5LYj+ysKqwzOov9n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741841292; c=relaxed/simple;
	bh=6YZPbCIstrkFIBq12YFEFEcPE+av42I+9yZpNMwYV10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEzSB3baPsHE1wbGA1A7vQEusxi4Qq1HFKhK0oTyU0JIqmoFDXJGak8i3ulHdB2sOtPkfYrNx8J076ZbYX12HwUXMRTyChvjUfl1BcHhkX+5bPpbgIhP3eosNc4LDYLcAa9lsLsamoIAycfsX4PGlMiSirIK5Pwt1sqiunLYO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d1j28/+P; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223fd89d036so10080515ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741841290; x=1742446090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+gtVH5q1IVL2N3KNRKRTyNZRjmajO4WtYbaLiekdyM=;
        b=d1j28/+PWwXggRJEerxJ8uv9XGJXiifIENRLWIg5mh1IWwveyxq35dm59UlTcOWkTq
         1jqOm1jdiiJM7yrEYK02vVGFvc4lrG2i7FZZjpjBwvcJCpf3hMQ3XJB6xYtpkERyAVoh
         TiGMipo+q7toJgaJ+wwxLQo/PS56nz4zXQXqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741841290; x=1742446090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+gtVH5q1IVL2N3KNRKRTyNZRjmajO4WtYbaLiekdyM=;
        b=TWkQ2Tec75sKLmYmwgy/Nkg6f7h8GDlvQSpuKqRIoJtk9PtTktVx+2ssB5aok2SH13
         U3uP6RRFYfGznKKHoMDd8G8V8Ff3Uixxx1CsGmqPolcAvH0xIU64799kxpfwGVcRLIyf
         V5Mf6mgZHEd2rb4xuPCADNQabgrRmr5cCcnJg/HZT7wERCqbJqCTt3GI8fwZu9X1NfIM
         6TCLFlX6jzEnkcxQRbrcuBVyWBrBma4Izx3N6Y/1VM5oAlVDrM3dkmvNgsVbZTunj395
         V0becbM9DzworWq1Ozl96WyGEApqjDO49C16QiUkZdYi7Vthfk4bB94nQV1Jx7ZK2TCO
         xOHA==
X-Forwarded-Encrypted: i=1; AJvYcCWlmyP7hPz22FAboiPwW0NR8NRQCRpgRy4hHAWgnGYVdfuFU7FtXKmn1HjT+2oPLjRA1uEkkoN/Ygs1c6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGHYgQblJzaUQ9Tqhj1GlU+O8iclKyMtmr54TXvDsIuoLSxne
	Fgmoxas79cOn557DT129QhNUpAWXinReeIdU8szmtLgMCbYm5luj+DCwFqXexg==
X-Gm-Gg: ASbGnct/oCOdYvf47rumZBqh6er2hSIP8fbi/xZjFVmIanwVh9Woi+1CQlRr5aqNQ5T
	pF7a93uqrwrVlgZrZb73pMuQrKBxW7uHxXcgbT7vgY+qxPDQmkhpkOO73cyKzviPUL8FsWSa7E/
	BT9gxf3psaZjbWQ9V2MiUpnFYsI/s/5W6Dm5Y0SqFWao3j20AOZFKcxVkd1VxOBUsZypoem8wJc
	DahlKQHQV8kDpnjmSkcl1c4kZ+As3R4OK4SkrDDf89F6h1xoivOUL0NO0i1BPjTQjXOeq0UEAFC
	Q8aZYdfdHDO9BFlcCMIMTiUPn5EYjEu3+7fG7wym+OQWz3Rp3MQ5naHCsHZ2KXsCuRg=
X-Google-Smtp-Source: AGHT+IEaZ5AffNlbpnnWajl9IqcugOB73K+75CMHqeDiaMOSmLOQz2lLmmj4CJcymfMhLCNoiy1i9w==
X-Received: by 2002:a17:903:2281:b0:215:8d49:e2a7 with SMTP id d9443c01a7336-22428c1908amr341875375ad.50.1741841290572;
        Wed, 12 Mar 2025 21:48:10 -0700 (PDT)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:1872:6051:5c24:509e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5c03sm4188025ad.249.2025.03.12.21.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 21:48:10 -0700 (PDT)
From: Sung-Chi Li <lschyi@chromium.org>
Date: Thu, 13 Mar 2025 12:47:44 +0800
Subject: [PATCH 3/3] hwmon: (cros_ec) Register fan target attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-extend_ec_hwmon_fan-v1-3-5c566776f2c4@chromium.org>
References: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
In-Reply-To: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, 
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741841282; l=1917;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=6YZPbCIstrkFIBq12YFEFEcPE+av42I+9yZpNMwYV10=;
 b=JhUhhxTRkvnPU2ov79FmQS4td92jVH4sj9+r0KoSiXE2Sg7nvJ8UWqERzYXiXc47oPttOjo78
 tc+qyXZb9F1AjCgrfx1CFLpQ/fMpFl1pTwbrfgNiaVXvLnhUkahlThK
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

The ChromeOS embedded controller (EC) supports closed loop fan speed
control, so add this attribute under hwmon framework such that kernel
can specify the desired fan RPM for fans connected to the EC.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
---
 drivers/hwmon/cros_ec_hwmon.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index 73bfcbbaf9531be6b753cfef8045fd5dab5b2ab3..56a8ee13ec2a9f8e7127815a530d2a254a45bf55 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -168,8 +168,15 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
 	const struct cros_ec_hwmon_priv *priv = data;
 
 	if (type == hwmon_fan) {
-		if (priv->usable_fans & BIT(channel))
+		if (!(priv->usable_fans & BIT(channel)))
+			return 0;
+
+		switch (attr) {
+		case hwmon_fan_target:
+			return 0644;
+		default:
 			return 0444;
+		}
 	} else if (type == hwmon_temp) {
 		if (priv->temp_sensor_names[channel])
 			return 0444;
@@ -194,10 +201,10 @@ static int cros_ec_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT),
+			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_TARGET,
+			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_TARGET,
+			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_TARGET,
+			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_TARGET),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


