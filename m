Return-Path: <linux-kernel+bounces-199170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3908D8366
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23EFB26E93
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E4E12D775;
	Mon,  3 Jun 2024 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bgu26WdS"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB1B1EEE0;
	Mon,  3 Jun 2024 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419750; cv=none; b=VO3werMtRYsPhAXUAkZ07mZIxUgYQfIu5SHQCizQ9d8LbbTfNu7Lx8XZeBVmr5f3pPIkH/tyxAPk4JXumNKHEj4EM3/Gu8kKTrJLwzYf4V6Ls1JdPPxB/6qEhf9/muafb2qWg4Dc2LC1wB2urfoftjoMXn0sCACB6idbDZoa8/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419750; c=relaxed/simple;
	bh=8qeuq/9NyK9dd0k3Ody3dB9SOCFgZ5HrBOGAyz4hQwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=htmHxbtwgo2IXyppJB58nsJhy0GWF4xDGTgs6aBDHYd4Xpwq1QsDFo28BRVw+WDBfxjIov1xOUR+M3003gq2tXl0kfpi8DhKU3p2lhTgbK8WNoZimYfUJVY1TLmXaH4Ob4BpZ07FigneTeoXysSUeuJaPdlLuI5/w4/BlKM2cxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bgu26WdS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f63642ab8aso22840425ad.3;
        Mon, 03 Jun 2024 06:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717419748; x=1718024548; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WfDan29VxVHZmK0WASWdz2aN4PE4yQZdFHSJZf8M3Io=;
        b=Bgu26WdSaMqMScaT2jf9YRcYSolDtrcKRAZeV3CuvyJnLeLGiX0+9KPpJAKVRuZuLN
         zMGZTqcHmSMvSd3c/VHmZ2QGdcRJ56H00WUKuHnO7tok0i6l5fV8Nfoqg/tTGwCGl0ZX
         Rbk4KRdCpTh2oTfZg8RFZzlsK68NWuUHGMhLS3B7NQ+7oz2wubD+aXwxNv9iZQ9NXII0
         zXMz4fd8ViyFUFwRRjxluPDk5rgdizVUxa7x246qD+M1KpNsPDM+pTljpXZyUhSwLFjH
         zgwNO3sIoa21jciOZkSIqrn/Wgpl6LjlnxoRvEWTHCwkpC04wxBuhOPmeyGX0yO6qZgF
         evgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419748; x=1718024548;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfDan29VxVHZmK0WASWdz2aN4PE4yQZdFHSJZf8M3Io=;
        b=dZk1aZTNU7XEAVU0V1FMR+GvJl6jM4rsDqfRNjMb8/D2VkH2ijdumwZ+IPOkpX7f6d
         X0SAT+MkxuMftVsYgoVucnmH0mITwqvjozEQDYb2mMqhrJK0fgoxlbhlGBfEON18baLq
         9WeqvC6FasfxtrJOzZqSWShK76dDjTka5GIoCJcwQEZfQevKde0sxpgmLtkr/tjVyoZA
         Y6FFooNEoM5iccoaAlEES4HzK616XB3AOLHuaE5ShXtmXZwUmxqXUZqtJQ8Nm166oRAG
         Ds7Ow/2vFtXLWUdsy90x2Iu10OVsHPS2+kkZwLp/BSCppJGnfRgW93dR1Imn43npp7Zd
         4//Q==
X-Forwarded-Encrypted: i=1; AJvYcCU74hV84UxgkJd96K7tfONdhndi7WUyaIiimp4Cy1RCyab77O6DWJQc81hyWYnxdENEImpBEbqCFQXZLdoOl2I605+5z4Zz7DJAAjo4TfZFzuA1Twk8vISieRujB1Y+acPAxRcwIuj+DUsJkPyAzVuWosmJBDEF1dFgbbYnE0GEr41GWw==
X-Gm-Message-State: AOJu0YzS4ycJwIqVwHVq6DvmzZ8uCF61wRNeVd3Z7/km9S6L4PjxSoWx
	Y7Ck6oGMND+y6h7/eSCvBJbA5mlMj35aSnzJty218yX5pZXiZFeeMWtH0sHBjrVEBw==
X-Google-Smtp-Source: AGHT+IHOlKr3d9LO/AOMATC82M447LUkw7Mhco3t5RbwmqJ6g3qoaOWdObh8M8yMMASXhnb9XdnC1Q==
X-Received: by 2002:a17:902:cf10:b0:1f6:1a86:37e6 with SMTP id d9443c01a7336-1f63701eba7mr103357395ad.23.1717419748357;
        Mon, 03 Jun 2024 06:02:28 -0700 (PDT)
Received: from localhost ([36.45.244.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f681a8b8c1sm14211685ad.253.2024.06.03.06.02.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2024 06:02:28 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: Thinh.Nguyen@synopsys.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	balbi@kernel.org,
	devicetree@vger.kernel.org,
	joswang <joswang@lenovo.com>
Subject: [PATCH v2, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Date: Mon,  3 Jun 2024 21:02:19 +0800
Message-Id: <20240603130219.25825-1-joswang1221@gmail.com>
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


