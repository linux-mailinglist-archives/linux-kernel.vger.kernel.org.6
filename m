Return-Path: <linux-kernel+bounces-239763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DD7926514
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A686F1C21863
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336271849C0;
	Wed,  3 Jul 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx5xu0ZV"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69D7181CE6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021084; cv=none; b=IvxltRd/inY8Wl3SBNqYHuGyJDp5AdazdSGLjsm72RnR1VQXdIbUJdfZnUJC+AbqbYh079Bw3jobJldII8Sbm1yrgNyCA+2lvUuUVdRU6XGCB6uF5Q3UbGnfQQD+musnZAF7W/a33AY0fdaudKpzCtc4VRfp64sfYs+3TGdjccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021084; c=relaxed/simple;
	bh=enRHrVnnv2v5OSTzZ1elKgS5KbJVuE9GP9SdZn7OqTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F6qcBhXd1e0uvtInNOMW5JgPB4rKIiusk05+oJVsg430/U+ehdNQc4XrINZtZXQgPTg5izExPKkvL+4/+dDG/UwoGNn65XA2v+VFiuw3NHCOqLikwLQZu+L/8fIZbV793Jms0+SvNbcRHrco/HnDfHdEQU1JH8XNdVr0e/JA4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx5xu0ZV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so2695327a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720021081; x=1720625881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOF3cIT6fgv4yx2bUJ2liLgQLjKC8cJY9QXkjtPW8ps=;
        b=fx5xu0ZVhJ4gAau8m8L+F4RmA9FmRDSkd2Ywjxya5ZC8ce3bd6LsPbUx7uvvzBV9xw
         EOrb93ZvU0dvUedneCuouueDIz2K7AhcCituNenNvvrAh+FBTg9BscWIK86mq7K2g4XC
         oLJFERh73PqM/SukOMeiwWZheIhgK1IapzY0hHfWFUNxJ6Tn2LlAF0nOcryaQCSEbOQB
         PzAgWv49dJTLS40KLtSlcBT0KE1NRP0L6xBBBXTVgWJtH4FoimsxOXFNxfRTeoMGDnJY
         gjnxv82pJfFl9MwfMdKJN2bVCc4gWjcW5Y8xk/WE36m33IdZDSTeC+t/Pb+t4TeDOwfN
         jwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720021081; x=1720625881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOF3cIT6fgv4yx2bUJ2liLgQLjKC8cJY9QXkjtPW8ps=;
        b=l014dBHrnzfevR6TBBcBaEeK1NA27sBtXCJtE7BKXtlSVQJKvMeb3CaIAcBbfp3D52
         ReDfJXkfeAO8Re7kfxH/FJHR0eeu/6SS17iW4N4m8dg5BjdTuak7Kdtay9xLIreOYTCF
         m+AsUUS+ZNP42VVPU/VExRM5JnL2hGBgi5vPQCRZYroSRQ1Xcl2EYbw4Q8hlKXqtC69T
         oY5VSL1o4RrsIbgfYGMgobTCeX7nX6RM8WQZ5Z4PZEz4MkvPBvZodgtGYxkjNiM66N3h
         QKfIA1HVc65dW/TiIVwFulgFnQjPsALWrRl1Iz5AZ41H03QvVDLcSMgbR6VKx1HBQJli
         /d+A==
X-Gm-Message-State: AOJu0Yyr63yYKVgID62b4TIBFP+xcX3ZmaHV5SdRIZowkX9eAe9BA+IQ
	nrRVb/WLRLg1DqFFMlguujuc3VMIac7ukMLEtyBj2pgim39GAgoW
X-Google-Smtp-Source: AGHT+IGSE4aEWfxmeppRozJV+rmVgbv6IME6lttf+K58LZUqL3dz1V1l21Nou6E9t0oENUhRbHfj0g==
X-Received: by 2002:a05:6402:2711:b0:57d:788:aaa3 with SMTP id 4fb4d7f45d1cf-5879eed8ea5mr8336189a12.8.1720021081125;
        Wed, 03 Jul 2024 08:38:01 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861503b4c5sm7119512a12.93.2024.07.03.08.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:38:00 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 17:37:37 +0200
Subject: [PATCH 4/7] mfd: wcd934x: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-mfd-const-regmap_config-v1-4-aa6cd00a03bd@gmail.com>
References: <20240703-mfd-const-regmap_config-v1-0-aa6cd00a03bd@gmail.com>
In-Reply-To: <20240703-mfd-const-regmap_config-v1-0-aa6cd00a03bd@gmail.com>
To: Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, Xu Yilun <yilun.xu@intel.com>, 
 Tom Rix <trix@redhat.com>
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720021075; l=720;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=enRHrVnnv2v5OSTzZ1elKgS5KbJVuE9GP9SdZn7OqTU=;
 b=QbgK/RJ2y1AYAvxFVQHd2CneM97DgD16f6V7hHZQ2LSL3bcRTs6LL4tfSPiuQQedys5isuUHj
 DiMaxpsYltFDLjKM0vuY1pxsrjgg9vn8yRsJjrNWK6Wn57TY+mMo+dC
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`wcd934x_regmap_config` is not modified and can be declared as const
to move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/mfd/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index 7b9873b72c37..fcd182d51981 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -109,7 +109,7 @@ static const struct regmap_range_cfg wcd934x_ranges[] = {
 	},
 };
 
-static struct regmap_config wcd934x_regmap_config = {
+static const struct regmap_config wcd934x_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
 	.cache_type = REGCACHE_MAPLE,

-- 
2.40.1


