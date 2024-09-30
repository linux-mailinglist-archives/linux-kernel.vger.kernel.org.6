Return-Path: <linux-kernel+bounces-343937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB07C98A196
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785942845B4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC301990CD;
	Mon, 30 Sep 2024 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HO13WMyn"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B843198E7B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697884; cv=none; b=Xro109pICRdrFB1WX2t9+DeU2DvCRmadjOJG72xbdkwU23OrI9Mngh4IgLbzPOJVZt02rVdBLwTzr+LmNl7xk9V0w0+taJ0dAzCLceTIGaosRyRbG1AwClLq18GPvxfqRMh/fgtya0Tyg7n3jD1cfZOYiTXQSLDBySI6bmpcQyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697884; c=relaxed/simple;
	bh=i9fHK42BYZRW42DIn7gTi+isZVRv8GhNgDIaA4tO6Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1GChowBYH0sOzeDRExcIOdEI4bxtXr/7pmm6lxCqBfKjrMGQrZNWF4Y5a4jECP19Bc4Z+Ihx2JD87nxqFAaTup2vqeAtXBb5eG9Ixjz+auuE/ENSJflxMW21Aqsn85W083vFai8emSn9Kgexe4rbtE/E8nlvYJd0E1KFRA120c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HO13WMyn; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e1baf317c7so1686062eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727697882; x=1728302682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JjigCj7wmiDgTIVi8lxvvE6Xnwp6vOIIL7mEoeKjLo=;
        b=HO13WMynCuv/xx8GNoI5DZ45Byv4JrnsrdWHEsJsq8cqocJN0xx08Kg4iT95qdyZXQ
         lt+Dms8deCZOFZPfpiznHhyWrbEZ0vpYuQqsfzwyeLZR8zKuJ/r1HNQ003NbY+tzclAV
         stWtBWCdu8ICeBEDOax5s7LSqpRWDh6QM8jq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697882; x=1728302682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JjigCj7wmiDgTIVi8lxvvE6Xnwp6vOIIL7mEoeKjLo=;
        b=V+R99QrCaHFJDmxKMfur9h4qxGVaonlbZRdQB15QyVi3GeZGSeV28BxecPwZARt9l+
         JnMWZHSKZ9mX6+CMSNoMfSsMQSR8LcQEEoCOaQgziLaJ8M95FPE+zWTsBEgTbNQ+oQF5
         yd5+i3F7O+yNYswUWzGKbD6cbgMyOtnhYo2b1cD4wig6TRlTKf5xHMibelg0l4dnTBxX
         oRvDuObZ1MWLQbKk0iNyfyG+irQDlVUSlGm+m7AN69k9XTjs9Y4Wxkx2o+KrRvyup7bs
         qtuRr0PlPBoiYGVxURC9QMOwVGy+2Z1RqInbV4U14a/6YFrnr3gSDj0pUjQR7pNjTpy+
         7a+w==
X-Forwarded-Encrypted: i=1; AJvYcCWRP/CauYF+WsEF5C51WKiPwCAANC1hktFj44vXwc5/3VFY2whViDTWE0CcLfjaww9PHRrgKPH8OSUDzqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQdS+nPKzM04piZDAzjq430+mwiIQJbv3RnaDg9+dQ4vj4gMsy
	CQF5XJFcP06SBq3jlRaYcEEKLBuWPZDotvHmYZVgE0qI6iLKzXqQEmZJ+2DyfQ==
X-Google-Smtp-Source: AGHT+IHorNkcL7CG7P94wqWnm5CxVPJz+Rc1wLbNEDwAbC1i2AVoPfjS6B+31QnhNxiGPZOH/d/JVQ==
X-Received: by 2002:a05:6359:4c9a:b0:1ad:10ff:341e with SMTP id e5c5f4694b2df-1becbb397e3mr239386155d.4.1727697882114;
        Mon, 30 Sep 2024 05:04:42 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b694369sm38822536d6.144.2024.09.30.05.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:04:40 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:13 +0000
Subject: [PATCH 18/45] media: xilinx: Use string_choices helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-cocci-opportunity-v1-18-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Mike Isely <isely@pobox.com>, 
 Olli Salonen <olli.salonen@iki.fi>, 
 Maxim Levitsky <maximlevitsky@gmail.com>, Sean Young <sean@mess.org>, 
 Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>, 
 Jemma Denson <jdenson@gmail.com>, 
 Patrick Boettcher <patrick.boettcher@posteo.de>, 
 Ming Qian <ming.qian@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>, 
 Andy Walls <awalls@md.metrocast.net>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Tomasz Figa <tfiga@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
 Sylvain Petinot <sylvain.petinot@foss.st.com>, 
 Jacopo Mondi <jacopo+renesas@jmondi.org>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, openbmc@lists.ozlabs.org, 
 linux-aspeed@lists.ozlabs.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The following cocci warnings are fixed:
drivers/media/platform/xilinx/xilinx-csi2rxss.c:415:3-27: opportunity for str_true_false(data & XCSI_CLKINFR_STOP)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:409:3-24: opportunity for str_true_false(data & XCSI_CSR_RIPCD)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:407:3-23: opportunity for str_true_false(data & XCSI_CSR_SLBF)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:403:3-29: opportunity for str_true_false(data & XCSI_CSR_SPFIFOFULL)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:405:3-27: opportunity for str_true_false(data & XCSI_CSR_SPFIFONE)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:424:4-30: opportunity for str_true_false(data & XCSI_DLXINFR_SOTERR)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:425:4-34: opportunity for str_true_false(data & XCSI_DLXINFR_SOTSYNCERR)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:426:4-28: opportunity for str_true_false(data & XCSI_DLXINFR_STOP)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:892:2-19: opportunity for str_enabled_disabled(xcsi2rxss -> en_vcx)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/xilinx/xilinx-csi2rxss.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/xilinx/xilinx-csi2rxss.c b/drivers/media/platform/xilinx/xilinx-csi2rxss.c
index f953d5474ae0..7ddd9b265162 100644
--- a/drivers/media/platform/xilinx/xilinx-csi2rxss.c
+++ b/drivers/media/platform/xilinx/xilinx-csi2rxss.c
@@ -400,19 +400,19 @@ static int xcsi2rxss_log_status(struct v4l2_subdev *sd)
 	dev_info(dev, "***** Core Status *****\n");
 	data = xcsi2rxss_read(xcsi2rxss, XCSI_CSR_OFFSET);
 	dev_info(dev, "Short Packet FIFO Full = %s\n",
-		 data & XCSI_CSR_SPFIFOFULL ? "true" : "false");
+		 str_true_false(data & XCSI_CSR_SPFIFOFULL));
 	dev_info(dev, "Short Packet FIFO Not Empty = %s\n",
-		 data & XCSI_CSR_SPFIFONE ? "true" : "false");
+		 str_true_false(data & XCSI_CSR_SPFIFONE));
 	dev_info(dev, "Stream line buffer full = %s\n",
-		 data & XCSI_CSR_SLBF ? "true" : "false");
+		 str_true_false(data & XCSI_CSR_SLBF));
 	dev_info(dev, "Soft reset/Core disable in progress = %s\n",
-		 data & XCSI_CSR_RIPCD ? "true" : "false");
+		 str_true_false(data & XCSI_CSR_RIPCD));
 
 	/* Clk & Lane Info  */
 	dev_info(dev, "******** Clock Lane Info *********\n");
 	data = xcsi2rxss_read(xcsi2rxss, XCSI_CLKINFR_OFFSET);
 	dev_info(dev, "Clock Lane in Stop State = %s\n",
-		 data & XCSI_CLKINFR_STOP ? "true" : "false");
+		 str_true_false(data & XCSI_CLKINFR_STOP));
 
 	dev_info(dev, "******** Data Lane Info *********\n");
 	dev_info(dev, "Lane\tSoT Error\tSoT Sync Error\tStop State\n");
@@ -421,9 +421,9 @@ static int xcsi2rxss_log_status(struct v4l2_subdev *sd)
 		data = xcsi2rxss_read(xcsi2rxss, reg);
 
 		dev_info(dev, "%d\t%s\t\t%s\t\t%s\n", i,
-			 data & XCSI_DLXINFR_SOTERR ? "true" : "false",
-			 data & XCSI_DLXINFR_SOTSYNCERR ? "true" : "false",
-			 data & XCSI_DLXINFR_STOP ? "true" : "false");
+			 str_true_false(data & XCSI_DLXINFR_SOTERR),
+			 str_true_false(data & XCSI_DLXINFR_SOTSYNCERR),
+			 str_true_false(data & XCSI_DLXINFR_STOP));
 
 		reg += XCSI_NEXTREG_OFFSET;
 	}
@@ -889,7 +889,7 @@ static int xcsi2rxss_parse_of(struct xcsi2rxss_state *xcsi2rxss)
 	fwnode_handle_put(ep);
 
 	dev_dbg(dev, "vcx %s, %u data lanes (%s), data type 0x%02x\n",
-		xcsi2rxss->en_vcx ? "enabled" : "disabled",
+		str_enabled_disabled(xcsi2rxss->en_vcx),
 		xcsi2rxss->max_num_lanes,
 		xcsi2rxss->enable_active_lanes ? "dynamic" : "static",
 		xcsi2rxss->datatype);

-- 
2.46.1.824.gd892dcdcdd-goog


