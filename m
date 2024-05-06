Return-Path: <linux-kernel+bounces-170359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2F18BD5A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFDA1B2160B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BE915B546;
	Mon,  6 May 2024 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkclSpm0"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C350715B0F0;
	Mon,  6 May 2024 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024644; cv=none; b=T54FEwMLmkIXowdXVol5JWT/TFe9xVOKEt7PsRT/RNMl93Iz/Pf24io6b68Rj1WjjVPvTShSWDOylj4HsGxiuvIu4TuqCQaKJeFS1MCupucRYaW8fc9seNbCON1oq4yrbe/CvkRP5yNsZl7mF7riziGf4ii84g7NcWrEBZbKek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024644; c=relaxed/simple;
	bh=1mVwWv9KBGkg45dlhDTu4/yvnIkQ2Vcw2vs+0FLy47A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7vRr8LcASBJuhmBMugfWUoCYM3brpdSDkV7xHcVK0j/uD4MjRRFb+jCiJd2STWLvdBSry4OtpF29aTIJJi2sjjOmCi3bqquLokGD6kdDo43EFJPeg05adpsNIW4jzBd5Dzok+YOs8678ICy7gh8FlkKOHH8dyCZKykIlPsbtQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkclSpm0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a9d66a51so509214966b.2;
        Mon, 06 May 2024 12:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715024641; x=1715629441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C88NXh5dRoqqDkaBrG5x3LDrKI9aAW0uYwvaYAfrMG8=;
        b=HkclSpm0B9yjCRXQ0E1p4QnvCJF1gp8SIDYo5JPunRl7W/S+/UkeZhKl9gUKhUkw9T
         0oyIexA5Oiw/aphtUQUHrzjCqmPnSap1tja6ewnC2dALvkWDXF275MhEFd5uJxJPjb3D
         5pexRYnzQRaA6sBMY3NBGu44DoQIHMmNqSiD1eVT02f1LiHZ+eZUDLcSkC7SSv/xKMyC
         qnrJjMeZuIt84JOBqxBZTFhcG8sMfyjPfYc6I8L1ZdHuK7arKPogrR5woQjKJz+z7Zue
         MNoJuO/3UsgVXQH7t2VBXusXtA4NyeeMLqvZ77IBI2dahmip11VtUzbh+Bw/gLfaP1b8
         5VFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024641; x=1715629441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C88NXh5dRoqqDkaBrG5x3LDrKI9aAW0uYwvaYAfrMG8=;
        b=nYSDRc+lsZaio6F0lp08dHjIOZqWu6BGAFLyO9xDD3HkJtM0c2osB7d3CuyIAlwPm7
         uzDaXhb9wW2cV32FMHwOEDL7R19bOOXYdVfKeJ5WqCpX1bwiEJvVc8rs0qXwkVR5/4gw
         rgtkp3XJFfGj/YKkdvTCJvkr/KqTbKMkWHfjOBZOq+huqnt937ZioB16YbgyiQIDUjdX
         bTLylcdFSuLBvoyWXArMdFOc5H1LeR1Y4UcTjOsEv5zPb+Qk2np6gowV5mQgmEmnLY1c
         5EiHFlbUEtE06LyIp9mc4hHHEwzKu1nGf0aqWrfFMNljoFlDyJEPdsHqRT/osB+TJK+0
         Uieg==
X-Forwarded-Encrypted: i=1; AJvYcCVNQozD0c5UThfjqJm5c4FBPgLH9nRIRZPsXGup5yO6rnccVPspJdIZxaioqv5oTHCfa598uDIFdXk6Wf54NQ1Qsy5AfvX2xnua1AEOWsJ6lmQMnV7A4xFBppw5m25rXPtialMNGAnS0IPW7YX/ZF69J8zEhuZZALaGJYtN2NaIAdc46A==
X-Gm-Message-State: AOJu0YxkmiODXFrlWv6TVTnD0h688Iymab5eW+vyJ2i4L37sVWIMnncb
	dJWYzRGmct7BmRTZglRN7UfNCERql3uHfh9/fjm+SzyGXPfQkJw=
X-Google-Smtp-Source: AGHT+IGXkpTxbAh5DwLseWHJnyaH5MLqujBbL8ZKSiMVh7SfVdr7KWTIModIbwpe+SyWgj9tViY0hA==
X-Received: by 2002:a17:907:944d:b0:a59:ccc8:577a with SMTP id dl13-20020a170907944d00b00a59ccc8577amr3025674ejc.47.1715024641199;
        Mon, 06 May 2024 12:44:01 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1c62:e77:6753:5729])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709067f8d00b00a59d146f034sm1367321ejr.132.2024.05.06.12.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:44:00 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 4/7] clk: rockchip: rk3128: Add hclk_vio_h2p to critical clocks
Date: Mon,  6 May 2024 21:43:39 +0200
Message-ID: <20240506194343.282119-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506194343.282119-1-knaerzche@gmail.com>
References: <20240506194343.282119-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DSI controller needs this clock to be enabled in order to be able to
access the registers. Make it critical for that purpose.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/clk/rockchip/clk-rk3128.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index a20d1fd25e2a..d076b7971f33 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -563,6 +563,7 @@ static const char *const rk3128_critical_clocks[] __initconst = {
 	"pclk_cpu",
 	"aclk_peri",
 	"hclk_peri",
+	"hclk_vio_h2p",
 	"pclk_peri",
 	"pclk_pmu",
 	"sclk_timer5",
-- 
2.43.2


