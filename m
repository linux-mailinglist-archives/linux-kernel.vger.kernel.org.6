Return-Path: <linux-kernel+bounces-197788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBBF8D6F27
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 11:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68E0283670
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 09:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86F614EC42;
	Sat,  1 Jun 2024 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHOLZ8D/"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85AD6AAD;
	Sat,  1 Jun 2024 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717234359; cv=none; b=hpaZ/ws3gYK4y8t8H41TI04PrXvhydju5dTPG++UIHbQRcHK+RN+6AsuKP7AC0LHH7C1hBldC2j748TgGCKrv2kfs7MFaBRXz8+FziW2OsHnhf5ixvlCG+ihuLSBFh/KN/1aAogLj9wQTTei7Bed/4DEUolYmeAEknXPid7pj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717234359; c=relaxed/simple;
	bh=8qeuq/9NyK9dd0k3Ody3dB9SOCFgZ5HrBOGAyz4hQwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=e15RouO2EVSVxKGZ2XqhXIok4YKQbcFeCQRGxueUhniUR1u/TExvAsQVAdBRc/5wFFM9C80hW67Nn+r/KvlgdJ03sxJcfQzTzY2Ah75IRX8LvmmoHKFFWpCyJnSuP5C6zHYG1+YBaT8cR2idxcEMePkLDDQsWbZ+PT694NMybR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHOLZ8D/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f62fae8c3cso17325205ad.3;
        Sat, 01 Jun 2024 02:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717234357; x=1717839157; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WfDan29VxVHZmK0WASWdz2aN4PE4yQZdFHSJZf8M3Io=;
        b=VHOLZ8D/0MKfMb5/9DzrnPU4zL+fMrFJPRGS0Y6qh4JeOtR2cJMjwtDR2x16H52DuB
         LgZuzG+IX0/awRRIBFQhoHO5lzI8zpClqokIZBFUcCW9CsTZu/cHJnnrxWaaIjnXoS2B
         kCK8M/tSVqQ+buIRmE4aydUALXc8Mi/szGmrJnDAqAYgRSfS47WgtuxheWDBYt7Is380
         RqplniEn1zRs4TVbP3vEnmcdEFJq9uiyQgO42d71NLuH38z3m7Xtu27Ee9VIJh+E908x
         rvZSoQEuKQwzZRiG0FFqiWadXD79YfsmCs6LhpnGM6r8FQhY+sCt/Tx22KPg6IdASiTB
         UVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717234357; x=1717839157;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfDan29VxVHZmK0WASWdz2aN4PE4yQZdFHSJZf8M3Io=;
        b=sMfo8sAEXFtVhj84AfQWvwOpIrxBRQD18wlDsb1zSMtklMtNstNvOFjjtGLNG1STQi
         7D2uxDRq45df/zH9RGs1ryBTHM5FIWap/4vHngaWZ7WeGYbP5f3ghFvdqMtvd1kFjA4a
         6ZQGFDkE9sQPXbJS5uWPfpoqqEiPHVtIccbsaydyhWEcbR0ue6vE4l8pA/OmsYTll5p5
         RyYaelWP8pZyMdTAyM92YrhV3kys++d0ZR7Or9qYmmRFoYLanWPXfwUMhGifQGHg+Trf
         dee7OEe/rkKrNrQ0/NP0rBaVjYY7Om0l6MkfnKVMxQAPIYxf14Dl3VEsMV5VOtAUnzkP
         jLwg==
X-Forwarded-Encrypted: i=1; AJvYcCUtU2kTDp4c+Sw7TqLvf43Qu2g0ZjmVHg6top6oaoXPCHFxvhK0OSTRnVOMOCAAVUsJdCDHFDgxqqgHh+IXUz/FQfkvUzCaOQuclTkCq+npgIb1x493s+xClBGIgpeESjknEn/uzg7N
X-Gm-Message-State: AOJu0Ywqz+ENoMp4T0cGj1FkXEQl92OgLZEoHVXi9jr7h0KK42kis88N
	uYPdApCrZjD4meKulfLo/HFDYymOc/XtX9Dhe8yL45WJySoG51lt
X-Google-Smtp-Source: AGHT+IF2Y/lvJC2CHSbJ8VM+i+/4AWA1oMbbO9ctIjt+vHM9XrZrC5hZywfN/zjx0YrFt+wiVtSrww==
X-Received: by 2002:a17:903:22c3:b0:1f4:bb5c:b7bd with SMTP id d9443c01a7336-1f6370b8aa1mr45185795ad.61.1717234357015;
        Sat, 01 Jun 2024 02:32:37 -0700 (PDT)
Received: from localhost ([219.144.1.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323feaa0sm30271675ad.230.2024.06.01.02.32.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2024 02:32:36 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joswang <joswang@lenovo.com>
Subject: [PATCH 2/2] usb: dwc3: core: Workaround for CSR read timeout
Date: Sat,  1 Jun 2024 17:32:32 +0800
Message-Id: <20240601093232.52319-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240601092646.52139-1-joswang1221@gmail.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: joswang <joswang@lenovo.com>

DWC31 version 2.00a have an issue that would cause
a CSR read timeout When CSR read coincides with RAM
Clock Gating Entry.

This workaround solution disable Clock Gating, sacrificing
power consumption for normal operation.

Signed-off-by: joswang <joswang@lenovo.com>
---
 drivers/usb/dwc3/core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3a8fbc2d6b99..1df85c505c9e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -978,11 +978,22 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 		 *
 		 * STAR#9000588375: Clock Gating, SOF Issues when ref_clk-Based
 		 * SOF/ITP Mode Used
+		 *
+		 * WORKAROUND: DWC31 version 2.00a have an issue that would
+		 * cause a CSR read timeout When CSR read coincides with RAM
+		 * Clock Gating Entry.
+		 *
+		 * This workaround solution disable Clock Gating, sacrificing
+		 * power consumption for normal operation.
 		 */
 		if ((dwc->dr_mode == USB_DR_MODE_HOST ||
 				dwc->dr_mode == USB_DR_MODE_OTG) &&
 				DWC3_VER_IS_WITHIN(DWC3, 210A, 250A))
 			reg |= DWC3_GCTL_DSBLCLKGTNG | DWC3_GCTL_SOFITPSYNC;
+		else if ((dwc->dr_mode == USB_DR_MODE_HOST ||
+				dwc->dr_mode == USB_DR_MODE_OTG) &&
+				DWC3_VER_IS(DWC31, 200A))
+			reg |= DWC3_GCTL_DSBLCLKGTNG;
 		else
 			reg &= ~DWC3_GCTL_DSBLCLKGTNG;
 		break;
@@ -992,6 +1003,18 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 		 * will work. Device-mode hibernation is not yet implemented.
 		 */
 		reg |= DWC3_GCTL_GBLHIBERNATIONEN;
+
+		/*
+		 * WORKAROUND: DWC31 version 2.00a have an issue that would
+		 * cause a CSR read timeout When CSR read coincides with RAM
+		 * Clock Gating Entry.
+		 *
+		 * This workaround solution disable Clock Gating, sacrificing
+		 * power consumption for normal operation.
+		 */
+		if ((dwc->dr_mode == USB_DR_MODE_HOST ||
+		     dwc->dr_mode == USB_DR_MODE_OTG) && DWC3_VER_IS(DWC31, 200A))
+			reg |= DWC3_GCTL_DSBLCLKGTNG;
 		break;
 	default:
 		/* nothing */
-- 
2.17.1


