Return-Path: <linux-kernel+bounces-201027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B813F8FB856
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF1A284DCB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D856D1494C1;
	Tue,  4 Jun 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zotcbhvs"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B5148FFF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516915; cv=none; b=gOc9z4/VSRDjfz8eMlxYj5JyG7E54/gwxgzLvajSIpx+o86ww0gSpdtYpSLz2gE8RLjVxkChYxbFJ/Rl+9UKrfyvYG1il6cJpSd/6HY6loAVBuiLw7cbbAJAP+IJeQtOybZ1Y+jCfkOtqm+J6R2NttGtA1yla7VY78M9sdZVyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516915; c=relaxed/simple;
	bh=bM+CwYviE8hbC61Ao8++7cm40ioyxFsXZdRy+wbbZqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcqobCYAbdVCENllR08OZh0F6088GEUmsucfBUnvwMLr66zdPysYBx0cAenkvhlWjVnE+pykKmgk0vGsei8d/mh/b6NoD8aEbPWV9OvB8tVQzfSdzPJJURK2asUOT0GvvrCZIS60o9Ocpq5qiDI8hS/H6jvP56kRGbtlMy2hXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zotcbhvs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f62a628b4cso37845665ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717516912; x=1718121712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz1mGlcK+k8OO+Zf/s5Aw5nRh+dYCllETeWsEDeJzE8=;
        b=ZotcbhvsEHfXUHRIqQo6fCbK2+uQXYRy4Ac045qckmy6ih8EOZU1XHXBol6nE0X6xu
         zomh2Lbw3QFF8Wq2b4fBc5tEGkp/MGVlkIaNuAEaGI4uCd2iHAmBDQhVx7RL//QxySwA
         RSZSxbVdU3f3CP3q6A3Mu3ESwDyC0VhIogVs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516912; x=1718121712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tz1mGlcK+k8OO+Zf/s5Aw5nRh+dYCllETeWsEDeJzE8=;
        b=FnAv1yayRv5O8ugjbDD5EC4ojumRrUcJ7+ZKa+wYpIcijKTAIbugbHYnPs3yH3X8zf
         oN5co2K6Hi0benFtiJUWcW3ThOj5/+ClrQ9lP/ZAqvOOjfFDc6p5OXUK9GUlrgRUdAlw
         i/Ahz7Icxn92dTEjbqCKgPPQkAHhSDSahq11kHXon36Coer8hZALy3/Hu/mbE4gKNYqY
         5D4SDk3d+wyAu6MpvZyZYN6FTS/ZYzhme+5KJsOehHzihDCu1ZK4lT7ysq60mJWvQnQJ
         m/Rn7k3rk5UtBJg4OrNjeTimF5QoD7D2rnjZj47R0wD9xdhsw8il01fIhCwyw2Vjk8Qr
         EEJg==
X-Forwarded-Encrypted: i=1; AJvYcCXSmy9OtugHmFC5Dcqfbd5CRdYH72h2hJT+dNSRkOsFRHVcCR6XH1zggJzaoORMYkmb1K3v9bFwHqln/JYFQ+bdpimDjd4XCKJQ1hnW
X-Gm-Message-State: AOJu0YykMVyHncBH9ggT4+LtMS1mOV4WTF7s2uzbqXRZTa725IeZgynS
	RkEcJllGgfhOy3tGGSHqzw5w9RrbfKCs7ghUz7EDbITRwePO+HNCBqnwHv6qpw==
X-Google-Smtp-Source: AGHT+IFjFsK7b5jeJuRmXNUJeTh0/w0Lyx/zDUdM1spc/2b7tXWGJLUB/NlaOIxAnXtZTLPBHn40MA==
X-Received: by 2002:a17:903:2448:b0:1f6:74e6:1ec1 with SMTP id d9443c01a7336-1f674e62022mr75670415ad.68.1717516912287;
        Tue, 04 Jun 2024 09:01:52 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632358519sm86118385ad.82.2024.06.04.09.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:01:51 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Rob Herring <robh@kernel.org>,
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH v3 4/7] serial: qcom-geni: Introduce qcom_geni_serial_poll_bitfield()
Date: Tue,  4 Jun 2024 09:00:30 -0700
Message-ID: <20240604090028.v3.4.Ic6411eab8d9d37acc451705f583fb535cd6dadb2@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240604160123.2029413-1-dianders@chromium.org>
References: <20240604160123.2029413-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With a small modification the qcom_geni_serial_poll_bit() function
could be used to poll more than just a single bit. Let's generalize
it. We'll make the qcom_geni_serial_poll_bit() into just a wrapper of
the general function.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
The new function isn't used yet (except by the wrapper) but will be
used in a future change.

(no changes since v2)

Changes in v2:
- New

 drivers/tty/serial/qcom_geni_serial.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e5effc2f5878..c4c54359d32d 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -264,8 +264,8 @@ static bool qcom_geni_serial_secondary_active(struct uart_port *uport)
 	return readl(uport->membase + SE_GENI_STATUS) & S_GENI_CMD_ACTIVE;
 }
 
-static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
-				      unsigned int offset, u32 field, bool set)
+static bool qcom_geni_serial_poll_bitfield(struct uart_port *uport,
+					   unsigned int offset, u32 field, u32 val)
 {
 	u32 reg;
 	unsigned long timeout_us;
@@ -295,7 +295,7 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	timeout_us = DIV_ROUND_UP(timeout_us, 10) * 10;
 	while (timeout_us) {
 		reg = readl(uport->membase + offset);
-		if ((bool)(reg & field) == set)
+		if ((reg & field) == val)
 			return true;
 		udelay(10);
 		timeout_us -= 10;
@@ -303,6 +303,12 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
 	return false;
 }
 
+static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
+				      unsigned int offset, u32 field, bool set)
+{
+	return qcom_geni_serial_poll_bitfield(uport, offset, field, set ? field : 0);
+}
+
 static void qcom_geni_serial_setup_tx(struct uart_port *uport, u32 xmit_size)
 {
 	u32 m_cmd;
-- 
2.45.1.288.g0e0cd299f1-goog


