Return-Path: <linux-kernel+bounces-343934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA8898A191
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E6284AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A194196C86;
	Mon, 30 Sep 2024 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LMnufsHP"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16594194AC7
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697877; cv=none; b=SNvlHwpqb/lmF6MI0nPJmrqDIMlfdNZ8MUisoI9R2o4/H62xaikGsL7o3gOZmBy0idgI7Bt0KSsp4k4cM8apYJEF57SkprRwcX0cn7lz1QbrNcCrJ+qVVqKg5byiksSN/qfhhoFeCd/WzaPmqm6aP51Mfs8yZ1Yc7fFuavfes4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697877; c=relaxed/simple;
	bh=27dEbLYS3PRjKxWaJp2KRsfAuUa8ZpRAboFGn7TSbcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c6TYGvj5UFAQpn201ZbchtEM8pCx0jzaJBN+RYnbFOtW8lv2IkiwGt9qapNeYLkRMSs8Ap09WcE9IP3YcwsRY2WRA7OFktDvxiOCLzTbDiULXlE5RirEkJXa2xsHLTXdMIZM6cDjwAkdpVnKQThq2oN3N563GIviGs2s6ekGs+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LMnufsHP; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5e1baf0f764so1288343eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727697875; x=1728302675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpVUYLeo0hSTOfKt30J/ldl6oRGhulqCfi0QX1kLeY0=;
        b=LMnufsHPbHZ5u+KvlbDxBakA6qFgMx6oXCBDtbmOuTMtw7jjB6lsIXyOlfXwZywswI
         HZcpJDTHlUhivGlX+H5TQz5sq5w+nI3CasLvqZg1C3f1f/bqoVmukHAhQVCFb1fDOR8o
         ax0dsJp8qDn0qyB97QDiTOOZ9NHYoTiDPN8FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697875; x=1728302675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpVUYLeo0hSTOfKt30J/ldl6oRGhulqCfi0QX1kLeY0=;
        b=gf9r44LoWcWNASHwvapA/PqgjTlPdmJuwl5zfBNoBgBbyUbqkDXkEEtI/YRAVSNiAN
         v7EootjxQVwFHe/PF3YQxUPOKtddO6q0eTjEEnlpnqoSxctbLZGO//cZ8Y6OErVxEFIf
         DBp2LpQIh3ow3Q8upcyZMN6y0E62Cf6E4qp5X5kCc+lu/XgiVozt358tCHmbjGpBGT6h
         Dl1bVXHW1MezXYAFJfyQLc2cHnQdiRvlztuls2E/nFh7yfOswGjMBhMNeOxA4f190C7Q
         Rss9jQ/mqLWh7qg6ZCnn1D0zyVP70CrlYfeLaq3XNOchCIFAdLJpF5JjVbfdmf3KBGjA
         SFHg==
X-Forwarded-Encrypted: i=1; AJvYcCVqUCmLhnlUE1gTymojSkrDJpsSdhMANFyxyXrqRTupPfUIdqmX+uGamIA6aBiKv2zrKAxPGFLGqj64vIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4Q/KAxdF1e9D7z0zzAJBV6FW4X6pvZqU5hjxpGVBSj8L7m3v
	VdDTjKL30LyG24dLVWNUJhPCXwkj1eP5gVe6nzisVKhR309MhrXk5f8HttSKhA==
X-Google-Smtp-Source: AGHT+IGd3K8vbb6GyQdRKaZnKoS5TA6gIcUfCdqxCm9K5gJfl06dGrwyNT5yGfSWCEUO0kuvQMkCfQ==
X-Received: by 2002:a05:6358:e4a9:b0:1b5:968f:e221 with SMTP id e5c5f4694b2df-1becbb39bb4mr326693155d.2.1727697875191;
        Mon, 30 Sep 2024 05:04:35 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b694369sm38822536d6.144.2024.09.30.05.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:04:33 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:10 +0000
Subject: [PATCH 15/45] media: amphion: Use string_choices helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-cocci-opportunity-v1-15-81e137456ce0@chromium.org>
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
drivers/media/platform/amphion/venc.c:1206:4-26: opportunity for str_enable_disable(venc -> params . rc_enable)
drivers/media/platform/amphion/vpu_dbg.c:259:3-34: opportunity for str_on_off(vpu_iface_get_power_state ( core ))

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/amphion/venc.c    | 2 +-
 drivers/media/platform/amphion/vpu_dbg.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 351b4edc8742..789c8fca3d31 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -1203,7 +1203,7 @@ static int venc_get_debug_info(struct vpu_inst *inst, char *str, u32 size, u32 i
 		break;
 	case 8:
 		num = scnprintf(str, size, "rc: %s, mode = %d, bitrate = %d(%d), qp = %d\n",
-				venc->params.rc_enable ? "enable" : "disable",
+				str_enable_disable(venc->params.rc_enable),
 				venc->params.rc_mode,
 				venc->params.bitrate,
 				venc->params.bitrate_max,
diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index 940e5bda5fa3..2dbcef4e83ef 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -256,7 +256,7 @@ static int vpu_dbg_core(struct seq_file *s, void *data)
 		return 0;
 
 	num = scnprintf(str, sizeof(str), "power %s\n",
-			vpu_iface_get_power_state(core) ? "on" : "off");
+			str_on_off(vpu_iface_get_power_state(core)));
 	if (seq_write(s, str, num))
 		return 0;
 	num = scnprintf(str, sizeof(str), "state = %d\n", core->state);

-- 
2.46.1.824.gd892dcdcdd-goog


