Return-Path: <linux-kernel+bounces-343951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CA498A1B7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D0B284B40
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5B019DF8E;
	Mon, 30 Sep 2024 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nfWGt05X"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841C19DF46
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697911; cv=none; b=L+vfkrTnSYn8D1y1iHHOw7nwQXltqdwJAHPpcEQVlghc+e4Q3S/GZf3GTSz+zE/ihFrnc0zCP20a9nrfb2V9PSGBx7ev3omNcQ3uGNT5Jy/QXwWoXNwxwfvqiFLepitqY87SdCsbIode0WHE3CNM62pmrf/c3UD/K8eayE9IHTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697911; c=relaxed/simple;
	bh=uih8QEqTTkP4DXsgDAU2UHGmO9M1hExX6/d1paS6Nuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJZj4GJk171gGWd8vA+4K+7O8DSV6QLOTm0rSJ+4utWyF/YYIEoDLNPjXNlTI0D1byvEvyNP/eShqKTqaDyOaGnGMWN7WZuRlhRuFI+dOW86HZ0b4gpAt+8QqtXv8zpW8aBFROECYU4wfoTUM24GthJ68CNzj6h5Kd/sqF6N1E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nfWGt05X; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cb2f272f8bso40066256d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727697908; x=1728302708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tASyZsxMamepS+/aqpGaV+hKbka/53sBNF0loAvAB9A=;
        b=nfWGt05XVrSbi5lofZ33E29UOKsmcef/WH9l77vFn3M2L1O8T26mX+qN7jX7csY+ew
         3itFAfh0AuE+N7b7lu0WM7YMQkDLNW5A/MY97MgKScezcs2bELouRtsYxEs2+2x+J7tR
         LUJuW9CXiuDdKEkjZ2hIutYGRtJGT/MNGbg8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697908; x=1728302708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tASyZsxMamepS+/aqpGaV+hKbka/53sBNF0loAvAB9A=;
        b=C2FZVMevAfIDeb+E0RvUF63o88XQ3MIq8TGX+TXMzJRqQRk19eveWgzsUwxv9Yl1lc
         28PsV82y8o94NvEclTsIKaHcVyJwb//rdelQPuv4+tpEtbqJqUur4mZCI/aQ0EhR5w59
         eGQsue4rrFH+s8+zUkbxhWy/Y9Knw+Q7EPp90ac+8FsAV7iuQ0UHAmS1UdXI0RS22cNV
         VAH4VOf/2lG4urdAPPLzLjHd/yb0u8v6X5Nga24Wi+guq87pP4UrntCnFnp0UZGz0Mwi
         c+ePSJ774gNwvU1hF1oNWflmIqciKwtEgdlO2/RFxEKLvXvkBxe7YVfKnxsksaIH0rh7
         dtaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVaLLyu5yGk2bclr/wYBVfWV9rxpb+3btyqsddmCadWtlLTBpdnN7JG3Mx1IW8vwdymRPEBwBUn/VbUpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZk2GT8QGY4IXa+3C/EdrHvV4xMwlooYbxWQLBqCT4NokW8upt
	lar79giaxaL5lOdX87rA0CEB9shW4SX6+TEZRiwEnjN6HMeItuZ4zyuuauvsVw==
X-Google-Smtp-Source: AGHT+IFjm/EtrgyOgYzJ6FCtv8A70AwY6h/u/nfabbLzk2VgNMjTcGoqCqNUVQwkIEHXuuvTS3xGsw==
X-Received: by 2002:a05:6214:4881:b0:6c7:c645:df60 with SMTP id 6a1803df08f44-6cb3b686f6cmr211008966d6.41.1727697908426;
        Mon, 30 Sep 2024 05:05:08 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b694369sm38822536d6.144.2024.09.30.05.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:05:08 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:27 +0000
Subject: [PATCH 32/45] media: i2c: tvp7002: Use string_choices helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-cocci-opportunity-v1-32-81e137456ce0@chromium.org>
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

The following cocci warning is fixed:
drivers/media/i2c/tvp7002.c:775:5-22: opportunity for str_yes_no(device -> streaming)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/tvp7002.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/tvp7002.c b/drivers/media/i2c/tvp7002.c
index c09a5bd71fd0..2acf93a90c34 100644
--- a/drivers/media/i2c/tvp7002.c
+++ b/drivers/media/i2c/tvp7002.c
@@ -772,7 +772,7 @@ static int tvp7002_log_status(struct v4l2_subdev *sd)
 				bt->width, bt->height);
 	}
 	v4l2_info(sd, "Streaming enabled: %s\n",
-					device->streaming ? "yes" : "no");
+					str_yes_no(device->streaming));
 
 	/* Print the current value of the gain control */
 	v4l2_ctrl_handler_log_status(&device->hdl, sd->name);

-- 
2.46.1.824.gd892dcdcdd-goog


