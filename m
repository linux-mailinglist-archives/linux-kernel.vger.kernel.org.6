Return-Path: <linux-kernel+bounces-556454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C5CA5C9F8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144841891A63
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B680026038C;
	Tue, 11 Mar 2025 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPRMTpVG"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD795BE67;
	Tue, 11 Mar 2025 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708638; cv=none; b=B5SiJ/yJFqxvBJoE2Y0LRJXVmxRYQH9b5FxrpBfXS++D6nTkz0FNK2Go5OXpOj/dGYdnJ1/bwba7sKkjMpQVXVXWglPTGGUotwQKjp1qEYeVhkQp7eLmuMcr3kH7P1d4BAH4r07I+kgugaBAQhigSv+cbUJsbNg0uITTuEwzUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708638; c=relaxed/simple;
	bh=QiTJDFfxLU9Gdio7K1tp3Kp5UXJzPmwHrML4jWux2sA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4oYzjA0BBFoudJq9rL9+ThCCMt2FahyvMwgyMVhXWIktiTVnJw0wD2maaSmMmTj+/S5Fapb/mjrkhMhUpXI0S31sCAsE7fSboa/Gt4TZr9AbOEv8w2yK3MGCiUAvSxVmbxv0nK0nM16F/0hDynHjjT3t2xcbTeaOCjs4mWwuT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPRMTpVG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224191d92e4so100182585ad.3;
        Tue, 11 Mar 2025 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741708635; x=1742313435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4NIRzGDOVcS6TD9kYD+mYeXE946YKDHV/XFzdUHads=;
        b=SPRMTpVG4tg/cjaUzObJ0Z4OgFnCobQQJ+kpZBHv+UlLCNPr7BRNE49t3106g00hZ2
         pW3hnUlkFRD/Tdi5OvVwH6n5mHr3ZZx6uD4WKfUk2E+RVJx9lXm81ar15nZV5q/h1/Wk
         AjgJ+q4uz1YBQwWHcr8HzZhPDrNu38XaLFkjAiL9I4iHWRHFWQwUMVTJWCexEjG3Acmv
         LIroGxQCdFVm3PWb+NJi5SxOLRxBpgIIGOv7BOrlBv0H23K+O+uNkejTYG3Viyq1ZwGq
         ZXhhwwelqX7XIcHAQBIsZc8pDWiY3uWgy+G9k865YlAk3aZky2hkJq5IcJnitKl9+xae
         rEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708635; x=1742313435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4NIRzGDOVcS6TD9kYD+mYeXE946YKDHV/XFzdUHads=;
        b=Pyau2zRfUuXAw9ckpiCZKtr/ognRtOQlCVhmExMb0Fk4ZF/gNaSN3InVAw6ZB+ikwP
         Fh29RgigVAlXVnxOyiRgb2QghTvIdWLiGFgdy21QvLrwS9XECbnORBwE2Bp6btQ+rpco
         L6FYjHTqzOk2BCENkBi4Eq99X1FuAm2PEGH9QTInwf2kWkKuohVIH25y/hjhY24iMvn1
         +jp/pZfFrsctG8j+Dt+eHVlR5YjTNZfrl8LuMyXnqOYlbWWpnIWPR2W5xNmbQko3QFuF
         cNZFmwiaQFkIYR+qQY6OiwmwwMWYpT6uYrHzzYYSrGtlXGDuqkoYbMDXBhAQAXZKmUAj
         ByGg==
X-Forwarded-Encrypted: i=1; AJvYcCUf3qhGTUZWXVG6RQehnu6GpYdPwjSml1ghPMS9vN3+NZ1cWDGmgBJvEAP7tXzg/SsnsZO8wIhTprtUYIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/IbiDHZGNWLcEX8ILDiTsSRtWxi+YP76CvJkP81drNchHsPl
	DVM1Rh0F38ejAWyDLcQ7m3KboQteyBWSpyr0r6WALBPIi05tfEJB
X-Gm-Gg: ASbGncvSWFizws0jQn9fJWQ8Z/7ipdJmH6JNRePPpOkdcrzIgxos8jOogx/borTJloE
	2/2Lrf8P2aNgxjGNU+Q6salr/qlYZjRRhtUutCwDtLKGHOExne36Zfb2UUF1j/A3pk8MMEwSa1Y
	iZdRMZuLQqM6em6YTvxuB2J0k7W21IbZTecBVc+aRpXHHOZnvOhIsEUomvTwY5Aabj6CX8BBeL1
	LYuCRa03t+kCPCj9mLsS4R9znx1MJQe4PfAQ69j95gUfPUVNQHaZHeM8dG2/mS5BMCh4IhO/ObP
	J23cCHkX10TT+wN0ijJqmuCcc9pYVQ3Zw8xdcT085aoGtIZEBdFY5lc7rZjPT7eBEQ6JXnMHbns
	SRss4QjU7+/JH4gEJf9ryZptBUwymc0Aw0yfT/hPdNKaigN3Z
X-Google-Smtp-Source: AGHT+IH5/BCCi+5l4KCxVrRlmAbA3yJymSl1EQCH67ZXG6uj4vYb9kHfwTEpsYrpesxsDeXXAPuLtg==
X-Received: by 2002:a17:902:e80f:b0:215:8809:b3b7 with SMTP id d9443c01a7336-2242888068emr218114155ad.7.1741708635418;
        Tue, 11 Mar 2025 08:57:15 -0700 (PDT)
Received: from test-suraj.qjz2hk5f2gku1a3adsvczrat5c.xx.internal.cloudapp.net ([20.9.134.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e942bsm99873325ad.71.2025.03.11.08.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:57:15 -0700 (PDT)
From: Suraj Patil <surajpatil522@gmail.com>
To: gregkh@linuxfoundation.org,
	oneukum@suse.com,
	stern@rowland.harvard.edu
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suraj Patil <surajpatil522@gmail.com>
Subject: [PATCH] usb: cdc-wdm: Fix typo in comment
Date: Tue, 11 Mar 2025 15:57:12 +0000
Message-ID: <20250311155712.467380-1-surajpatil522@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
---
 drivers/usb/class/cdc-wdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 86ee39db013f..c5123db416fa 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -1181,7 +1181,7 @@ static int wdm_probe(struct usb_interface *intf, const struct usb_device_id *id)
  *
  * The subdriver will manage the given interrupt endpoint exclusively
  * and will issue control requests referring to the given intf. It
- * will otherwise avoid interferring, and in particular not do
+ * will otherwise avoid interfering, and in particular not do
  * usb_set_intfdata/usb_get_intfdata on intf.
  *
  * The return value is a pointer to the subdriver's struct usb_driver.
-- 
2.43.0


