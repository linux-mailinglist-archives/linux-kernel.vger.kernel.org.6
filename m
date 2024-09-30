Return-Path: <linux-kernel+bounces-343961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505B998A1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01ADA1F27F61
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980391A0AFE;
	Mon, 30 Sep 2024 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y3vDl3GU"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716871A0739
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697925; cv=none; b=svuyJL1b+F57CJWG+hGTEQhY3elpUYTKsm3gVi86gJWdMaMWrgdTxN9WAA5ejzydXKPfw01TgCGknod9elPAtFWzgv3foZz3cK7yYarFemRL4i6FNsIAYbuAfLoQOXfnElbam/4e6P0JEDCz48VVLyV6rRNhzZjGGehM3fXzdqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697925; c=relaxed/simple;
	bh=5Rdjy71hTF6/9CoiFrdLRSPgDrn5yL3rP0qGkbkrLQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o568HydHuCdt3P6N505vDNgHhUzN9Huyr46clQj0jWSuh8TSBhN/1zVIAj9Nt4haxK2ZQYzt7isVUFzFL8EG68efyfL8LAghoHLbdO7kRmNFpf9zJQC7D5yepR8hTeCRov2BDmIVeYKLzPYeOOFqgtQtF8aDmUD/QjkfXrsFW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y3vDl3GU; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5e5d0a80db4so2243529eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727697923; x=1728302723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dipHc0aYdmEBdS77HCaW8bxKOJhKMvnfR/ECPy5ogKA=;
        b=Y3vDl3GU2Eq8OPL4Vg71Lx3mDatTalaaLZPC6pWL5te07UNAHZxHzzOZVOoTKd39TB
         AezNuqdGKOpHUBUC6WLi1rF9s4SXyIMFooPkiUQsDxFoLatOFj1zqMcj6QsTDf/lTig7
         2u7t5nDAhSGI7tZFphkrfiqpQASrTY8jwGALI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697923; x=1728302723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dipHc0aYdmEBdS77HCaW8bxKOJhKMvnfR/ECPy5ogKA=;
        b=rL/29hgJPal0/dS8HzxfTomBUo3NgYSoFhuYvbf6dnO9a4EV99BhjlparBnZC5JMAD
         6QtuG0jmFWLxpOyW2H4cLmAw6Qe3g5tjWgbA6BYi3lp/lJIvdYoImabKA209fLmdiprJ
         w71l/rL14jpmB/RdA61qhhiST/EEkUhzWAehiOO3XdrqJ2Zaro89xdjAsGlXGKozzZV1
         7xh/inxleFWsvRBI7KIpwxAvBOaj85Vpsve+xbDwZ0aNFgS5nFfP6s8Xput3ebDdOHvJ
         cj7xpYFAO/fGlpBQz468YRZYbf2U7vY44CAa9XMt3lLgOQs/4rg/93I/lBtB2RdYbI4l
         JmXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4DIMOMn7NbBfUzzaNgQueJgnFsgBpOxK5NYZtMEmT+pvENG6PQpCanEbSFhw3N2UPRCfBK2QQeWSAi7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqcbHznmoj4EGXNV4duhPrKIK8Vwbzrt+TmIL4JcCTJHLQEH2u
	yVs2iz8fkV5Wqh2kgZejuLW4Zgkb4qb8A61O4H82kscNitbAe8pEVBC8om99Gg==
X-Google-Smtp-Source: AGHT+IFoOt4rzgvhDCZteDnFFmUKzF/AVrjX9ESZ9nyOoTWl+oHTKxHAU5l+hHb9VoTek5XVl6j96w==
X-Received: by 2002:a05:6358:784:b0:1b1:ac7f:51d5 with SMTP id e5c5f4694b2df-1becbd0145emr538282555d.22.1727697923522;
        Mon, 30 Sep 2024 05:05:23 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b694369sm38822536d6.144.2024.09.30.05.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:05:23 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:36 +0000
Subject: [PATCH 41/45] media: i2c: saa7115: Use string_choices helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-cocci-opportunity-v1-41-81e137456ce0@chromium.org>
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
drivers/media/i2c/saa7115.c:1366:3-9: opportunity for str_enable_disable(enable)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/saa7115.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/saa7115.c b/drivers/media/i2c/saa7115.c
index a1c71187e773..ff0931cf5ecf 100644
--- a/drivers/media/i2c/saa7115.c
+++ b/drivers/media/i2c/saa7115.c
@@ -1363,7 +1363,7 @@ static int saa711x_s_stream(struct v4l2_subdev *sd, int enable)
 	struct saa711x_state *state = to_state(sd);
 
 	v4l2_dbg(1, debug, sd, "%s output\n",
-			enable ? "enable" : "disable");
+			str_enable_disable(enable));
 
 	if (state->enable == enable)
 		return 0;

-- 
2.46.1.824.gd892dcdcdd-goog


