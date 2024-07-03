Return-Path: <linux-kernel+bounces-239765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5B0926517
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D2C1C2352C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEAD186285;
	Wed,  3 Jul 2024 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efVXtH2R"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677011849D7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021086; cv=none; b=eKkUXg34gDzSvbqmZEWJmYk88aarITSYaJ1jPnj4RrX3F5EV1xy3hnZhmbJJ0QwnZmGgpo7aeHqqBFWTW0HWUqlelEAApZ2YAyyAFeOa24isbIO33hOjPnHdpFk8QDF2hhMJJ6DemJbXH1Y5mKtCHvA+4DHLjaB06ffb2ZlsZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021086; c=relaxed/simple;
	bh=lzMbCVVkUhr/GXktAPjXHVvLMvpZ3CXOHHuPfAw0sE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ai0kDFPkDs2/cCt/Wt3e3SQ9J2ptBcbjtN8jy+4FpMCk9sbbQf3xztvQtPN+CMsGh7RdwhiP4YrECscOAUQ+RDmLO3Ir+kwxDSoq1OF8A2YjuBUJMISAViNEabf4ojYrOkxzhy/dm5VYt2mhQje6OHSR/zm67W+ZPZMZcddzjIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efVXtH2R; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e7693c369so7610658e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720021084; x=1720625884; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdS9SKvs4g+g+UgHFzYU/wnbS48493rr3qaG9jHxGUY=;
        b=efVXtH2R8ypYv86gLDAGApce/KygPIwmF2E8lba0RXL6xNndN0km5XhozANYNW2HgM
         SXr1/xHVwY+DDoHR5LeoSbOmosJCxK7O+9GC6l6/0NyLv3L5x6mC4mABBdaoAC3a/7lL
         wgElXYNFv3upUgvm20CtakOLY4/3Cr9x6NKi1tHY+5/fKqTy5oKWy75yZ0b61MhTIwDz
         vyGmHBTE+zidtvUy7aUrmAad13QsKCa0HxQ2bHu+XXyYhjeXo2+DPaTQZfU5JaMzuhqf
         RBsm1R+pCYwYLios7AckhKN4Emm70c3GCbpay/g2O+JJ4Nti5DOOidBVXPcdy8PT6cB5
         QcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720021084; x=1720625884;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdS9SKvs4g+g+UgHFzYU/wnbS48493rr3qaG9jHxGUY=;
        b=GRHY4kpSsTRprxLHpdzvj+FzVGRbJQDJOMDeoSpy2LVw4c7QygebB28T7jRooS5GFY
         m1i4in1WDAJ3DSUMxQTwqcmcVHXLhHrrHFR4TKAu2MDIe4cRfXDg6yGZZqmzjBgRxdQg
         gy2WvgCu/CLsJgr9t4+zwE/ZdF5jwTvstCMM2MPOWA0oYqn2ZQvUlOlk5W8c2CXvf4zn
         Fzez8UrYN7rbsN6TVqwxTmVeix5TAtX/B5YhufsllgBqB8JN9NbrvMD3pd3VpnH26Ifk
         pbIbDPNw+W9TtEGaWZlxvB2i5jzDKwe2IO76S/dvoTxwS2ozW8wxmvh0ip07iNVW4DQY
         2mSg==
X-Gm-Message-State: AOJu0YyTSdFX+SoiHBBySGbITgQSaaPtox9udSAQOEKtTQ4JumOfju+b
	v6VKlXyWFmFeWHy3xPiCvp0uA2JlQTwsYUaM+xLifpRQkf2xeu1z
X-Google-Smtp-Source: AGHT+IHwFB8TQNcdHjQ/YqR7SMzzhHpQv3iUJdREXWimGcVns7AHZAlxXifUlseUShDfFdJnperbfw==
X-Received: by 2002:a05:6512:2087:b0:52e:9765:84e8 with SMTP id 2adb3069b0e04-52e976585c6mr1154203e87.66.1720021083425;
        Wed, 03 Jul 2024 08:38:03 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861503b4c5sm7119512a12.93.2024.07.03.08.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:38:03 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 17:37:39 +0200
Subject: [PATCH 6/7] mfd: rohm-bd9576: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-mfd-const-regmap_config-v1-6-aa6cd00a03bd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720021075; l=759;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=lzMbCVVkUhr/GXktAPjXHVvLMvpZ3CXOHHuPfAw0sE0=;
 b=x2zs6xZ3C6Z3pox8EuivN4ERbo8dgh25Q6A9PVuS7nMxK4SfhF8sFveHVq4LRvLRHpmHQP5BS
 zAbnL8XwmmiCEcxswwcRZbh5GQgnBScnkI79CjELCnPg+Vx4TFsK64t
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`bd957x_regmap` is not modified and can be declared as const
to move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/mfd/rohm-bd9576.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rohm-bd9576.c b/drivers/mfd/rohm-bd9576.c
index 3a9f61961721..634c65c7d108 100644
--- a/drivers/mfd/rohm-bd9576.c
+++ b/drivers/mfd/rohm-bd9576.c
@@ -57,7 +57,7 @@ static const struct regmap_access_table volatile_regs = {
 	.n_yes_ranges = ARRAY_SIZE(volatile_ranges),
 };
 
-static struct regmap_config bd957x_regmap = {
+static const struct regmap_config bd957x_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.volatile_table = &volatile_regs,

-- 
2.40.1


