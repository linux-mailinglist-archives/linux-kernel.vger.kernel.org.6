Return-Path: <linux-kernel+bounces-445710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D047E9F1A2F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A7D1624CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38AC1EE7BE;
	Fri, 13 Dec 2024 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="izMDvyiz"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0061E500C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132961; cv=none; b=OVnTHFWz9f4FqHtikPsRKXbVBhJGcRvLtKykmHTNXjPIHIqtcqS+bR+GQl1yJzEyNXJRBDjg877RM7etXc1tYjx6r/9v8A2EJHns5OnMBlNDPG1OUpnn6lzy1d6zQRFITFN9nOdLVO2JcVzbaIZKgjYqwJUdVzbTuOUC5Ibaezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132961; c=relaxed/simple;
	bh=At4yxUXPC5gCISpGbj4Jh8y2nbyqYWKzXfcEq34ABtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3DPjSxbrwLejSh1fG0oqfnWQ/6qisvpqAcwsWbj5LAdxDkgXVis22FZBhi+ALvAUQ1En7Q8tkeqv6UFIDf4FoP5iB6YAp3mRaHXMO00oH95ec4ovff/iRIJ3FJuoHBJZHiV9DEdbfyAg6NQENEYYXAob9CmwhrxzYfzN2uQ4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=izMDvyiz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728f1525565so2726835b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734132958; x=1734737758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aNEDHH4018fnzzsqut871HqEVIOaY/MIH7LrGllh5I=;
        b=izMDvyizqTgy/JCX3GN/xUmStq5dYJgqnSUxZvoTk/EL8HrTI+oq0D11EVVeYQON7D
         QAyCvgCScbdMJRZh9uihMx9bahePiXq0fsF/vd76vgpOGioewLUfMohL/gUnRsoDlIIN
         GoCBpKlPgwtpprO5ycy1e+LQBp62Rr0mNoLqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132958; x=1734737758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aNEDHH4018fnzzsqut871HqEVIOaY/MIH7LrGllh5I=;
        b=RNqfumVo8+z/gbxTmyNiOq12InyvXZqNsrREDEZzcvHtLBOnPSkk6lsQhcM7EfK8Ju
         3qoOZFGpgfM4VTuhrclmvD/I55cbc7gBsE3Fhsj/BMoCEVYWp4ksjw3TEzxWsOq0ey/w
         0wF/dIXKi6pxexdF7avggfpidDW/18ifnxE4VeZS9142PMHpfhM58t0H968GdL99xr8j
         H3syd2wP3wdbB6j/GR1wtZMJ665Sbu9rBxlTtdXv25Kug3FydmlMgrtSzyhjao97E4Oo
         Daj/uGspqkGvc3JC4VDwPuDo/wVTema2Rwu2pnrBOfhPVAgQ9mX2uszlKJzDTJaZi2hT
         Bxmg==
X-Forwarded-Encrypted: i=1; AJvYcCVS64LysIS1xR5ZAC+gAfPL5vqk/tx891EfUij8U+GN/xboVsTyxw0pLPBiJYpbVjIMlNotGTxvFwRjBtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkm8V3E3JF0JKIaDamswHsRToLmwZ3zglMQOMTEsdP83pZdjJ1
	xF54c6oM4ZJU1ryo6ZGPJ0jsMdBQTg/kz159tigMQtaF4ILGkxBySRDhctZfNA==
X-Gm-Gg: ASbGncs6GJMcwINrX1BiZ3pYBK+2SL9GA8U1gMP9nPdSiuY4BAqBZJmjd3oDhDB9tBz
	jZFE1rl2plxsBp9CG5EOI7+L8QJmVHB8hR3rGXw/YICjzZLIbJLcyuoWkyBjwjZRx9QCVolEfNd
	5dF1KaRWT4KG3mc9Z8w4huJ4iUMkEpOPYIPQKHLX5JCWcjUfbzAxHFis+6tqqoC/tpC5Mn+w9si
	xsQ0KlNWs6Mp+/F+OzfG9bMNnc1LfMOO6ByEbf8IICA9tCtW73l1vqP/rTiJ+f7fQAvkVjRPKRY
	N6vgEMxP446O1xr46l9bymsHtErB9Ds=
X-Google-Smtp-Source: AGHT+IGuN3bapepIPxR4xf+sjr97DT0siePvsa4ASfkZeWVposaJaxMdiFV3aR4FrmX3VtJTvm6U/w==
X-Received: by 2002:a05:6a00:f8a:b0:724:f10b:e663 with SMTP id d2e1a72fcca58-7290be74313mr6956527b3a.0.1734132958609;
        Fri, 13 Dec 2024 15:35:58 -0800 (PST)
Received: from localhost (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72918bad896sm336267b3a.143.2024.12.13.15.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:35:58 -0800 (PST)
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
	Bill Wendling <morbo@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v5 4/8] usb: typec: Print err when displayport fails to enter
Date: Fri, 13 Dec 2024 15:35:45 -0800
Message-ID: <20241213153543.v5.4.I6cff9d767b0f8ab6458d8940941e42c920902d49@changeid>
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

Print the error reason for typec_altmode_enter so users can understand
why displayport failed to enter.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v5:
- Put dev_err on single line.
- Slip clang-format a washington to look the other way.

 drivers/usb/typec/altmodes/displayport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 3245e03d59e6..ac84a6d64c2f 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -252,7 +252,7 @@ static void dp_altmode_work(struct work_struct *work)
 	case DP_STATE_ENTER:
 		ret = typec_altmode_enter(dp->alt, NULL);
 		if (ret && ret != -EBUSY)
-			dev_err(&dp->alt->dev, "failed to enter mode\n");
+			dev_err(&dp->alt->dev, "failed to enter mode: %d\n", ret);
 		break;
 	case DP_STATE_ENTER_PRIME:
 		ret = typec_cable_altmode_enter(dp->alt, TYPEC_PLUG_SOP_P, NULL);
-- 
2.47.1.613.gc27f4b7a9f-goog


