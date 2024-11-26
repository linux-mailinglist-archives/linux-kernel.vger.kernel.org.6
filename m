Return-Path: <linux-kernel+bounces-422071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB69B9D9422
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BD716885C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1DF1CCB20;
	Tue, 26 Nov 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FxVeUVkd"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5671BDAA1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612875; cv=none; b=pzTPyDqJJwcC9nErjYPzoQH+QmXwwdSZJ7t7y9tU66LxxQrPSUyqeHimM6szV1ktRV95v4nJbkPQNfivL+hokc+5vtuPV7aD+MMlcvtkwDVHqcUr192XTzw8jr79OJq9Caj3MDOjmx2ckyDYdUooveFU3SuScr6R0PablNKoLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612875; c=relaxed/simple;
	bh=L3W0t3Ndk3P8WFZClVN2UXeegBaVgcbm+UbE0rvxIiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rfJ8/v97RKLeiqSSozWRjF4RZOzzBn2L/B/mVYAvHhjFdqQl4V+0VZNaZ++HsooE2TNcNzNN/cnn3erXHttoLLAubp062OTl83QJhutbgp0plARzaqXZ7GzIEO05lMITJYQuYSMsaINpwdtljkntEwi00/toiQlPtP+MQ6iyLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FxVeUVkd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3824709ee03so3875893f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732612871; x=1733217671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHg/UpXu0kAmh5cmR42CQBOhisgGmi+P1vH8bY184Vc=;
        b=FxVeUVkdWtHtY+sPUI6sqE21pehNBnfcBSO5Fe1XNeyDBtjrbLY3RCNlA9/TolWQID
         Li6rQ/qS3Qh6mPiK7z9ApvT8z9JjymMMtd+NjW2aisnUHkJu/OsDe2JbsoL+qrGxcDyk
         CucYUv9Ww06tLU/VIw/gNdOyMI5aYZoAGSBuhu8/SF4RZynySUvU4YTf7CrqB/iyiGdt
         m2DnCMY/tP4KoUn3LROhr7lKQerMxxcN/EVyGCfBSGZUa1bGP329cqKM9Ijwy9eIK3Fy
         eP2rPHYrwecpEiSyGDpz6s7hEvgSOjXqhNKs51pqZBZSG+PIxckU5X50yuAjDBkpJuVm
         ue2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612871; x=1733217671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHg/UpXu0kAmh5cmR42CQBOhisgGmi+P1vH8bY184Vc=;
        b=VhmQoFeLQ0Q7yLo6cy1ppZsdTl09a8BWkJuqX79oN8SNqYWG7FkRQGDFK2KKpKiE6T
         IdlHt8fPo7nHM4eGQBxGwB1yGXqf+5wwgj9Zk0T9Vs2c7hsYujLSFrn/5q2OE5hiKjjX
         8MuomoOpnlcZfx6Abi+8ophCzpmMeIHTu2jdjuIVw4rqAyYiBvZze0t9aGb8mhQgWSNC
         u1Q7lp+SGahLxRjQx3FnPeldzaz6Ac2ZanEt4zIFjY8kbOGfbUQ9ICzgImyN9NQRrg6V
         iOMBt9WHIl63GbQHFqRgnZTm7L3ODZ5+UHC6S9jtpKBCPWojMQpM176xaynaOs03HSAK
         Z6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUsdJwgKVBE69GzSrbgeQobIlEO8qGM2FqUOkzsVnJFncIO98Zzb/fo8/PCIxh6ls/yxWpLe4S9JJVT404=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMqKfsdPFatFTEb3ESk1V3E9E41zVtutMTv4q1Ek9zbSx6NSYj
	fN8fkQ0/A0bWgX/eqZV/UykPTJVbIMjgdyeByLoC2bH5DTOj3aB+ZXN6IEIcnus=
X-Gm-Gg: ASbGncuxJqeylls3MygPS6ALN/egdAh+6j4rjKJ0zgSTj14YhG+IdL45vkrI5Lb/ZkW
	NvTMtdZvQnNklzxn6gJn733V/Hb9JHZeRzixcZnk/q4B6z5CNtZEGPqczgM/ZArLsSOxayhI5+f
	UnPbdmYeD9l6h7bb3OLsWjRACQWlnak6b8p+IjztOJe37jojBlQSJWuUGPTzI9qNNqIwRnHoq5M
	88FKMn8TLQ3j1/GxvDCEFeeRamFzJr43Dlwwns7ceEIyjz0qSQW1iJ30U0eUx5igQNKUcJ7Yr0R
	Ilg=
X-Google-Smtp-Source: AGHT+IHWio7klIaUm9lWwgg66sT0uRqFvChifk0YrFUVIwja8OlGoGemJIscbif1ZB71H5mZ9kHl7w==
X-Received: by 2002:a5d:5849:0:b0:382:4ce5:f8a4 with SMTP id ffacd0b85a97d-38260be54f9mr11141729f8f.53.1732612870798;
        Tue, 26 Nov 2024 01:21:10 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3a47sm13027694f8f.73.2024.11.26.01.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 01:21:10 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	gregkh@linuxfoundation.org,
	yoshihiro.shimoda.uh@renesas.com,
	christophe.jaillet@wanadoo.fr
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 03/15] soc: renesas: rz-sysc: Enable SYSC driver for RZ/G3S
Date: Tue, 26 Nov 2024 11:20:38 +0200
Message-Id: <20241126092050.1825607-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241126092050.1825607-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241126092050.1825607-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable SYSC driver for RZ/G3S. This is necessary for USB support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/soc/renesas/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 0686c3ad9e27..c8065f25ee53 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -334,6 +334,7 @@ config ARCH_R9A07G054
 config ARCH_R9A08G045
 	bool "ARM64 Platform support for RZ/G3S"
 	select ARCH_RZG2L
+	select SYSC_R9A08G045
 	help
 	  This enables support for the Renesas RZ/G3S SoC variants.
 
-- 
2.39.2


