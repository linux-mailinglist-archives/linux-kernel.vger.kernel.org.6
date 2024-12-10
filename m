Return-Path: <linux-kernel+bounces-440021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 658479EB806
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E94164381
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB8423A58A;
	Tue, 10 Dec 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="EGQjxsQc"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1646223A56B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850626; cv=none; b=h4+3XbwQM2rFdMc/PNO3v27RYZGFLci+4vt4kFA8O61jPIdjbCGeHmI99IoKXsFak0daCzJZZ7/ahvxS6StalWqn02hihaXbL5GzbSre7o1Ni359d7iMqakSmRpccNcb6nqzJHa3xutLlk2CQ74/L7wVUNdxqZNC2s9n/SP7zrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850626; c=relaxed/simple;
	bh=RalPxCPilUWbjYvZHpa4B7ebOphri7Uk5DSwxD2axvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LS0cqxXXokkz5ZLMGjh3JL2BLiG2rtVOV7NLK5Cuwqoa6fa8JwzvnymcsT7mAASMS/7/tJPDYCyv9R7Xg4H2H7RfM2z69ELaf9732xlWcsLQNiFUcp2pXrae7fGxzii3DuXSxaWvJzQT9qA07KaO43hI/NmeVh3m11TLlBulWcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=EGQjxsQc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so8533287a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733850622; x=1734455422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quo1xBiWZKYYPo7MUB0R0AMbPr7YypV5dW0W8isrnRE=;
        b=EGQjxsQcO50WGgYmy6Zfh/+57aYcCdg7phDM3bX4pHrdJ37AUoYs2w6rYlD3P/XnRK
         vbL4L65+v1Vs8/KJ6KMpaAyDEC3qzyhLAgeaE8b3jPpr5Sp0/bkbIKVdJwAWc8tRUM2s
         e176Of272Zl/+1F40fo8kkusiwXkwbrKNL/BAsJiIYuXe2GcdgzbDM1m0h0F6nroiCsZ
         joj7pJLA3cycvZ3GPh0FWXDgEcNH1zATjoJsy/jd3R4HboJBtquK5AAXIz78ftY6qrsr
         gOFAOI3bx1NzbuB8EsLg2Q/0peDZCDQLDozqftozXP4vufrfhcgScr5Var4YdT3at6Xq
         Qu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850622; x=1734455422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quo1xBiWZKYYPo7MUB0R0AMbPr7YypV5dW0W8isrnRE=;
        b=Np3fPo0SPSh5d6x7KquG9HdZocXoLp6o5BUDU4nUzrSO/xZWWsr+NToXjejuG9UgII
         xTFj1LliqRDY8uYUFun752jnfh5mLTIXKQi4Uu/3F7DXGMiBf8C6OOn26mK2ToRWPTor
         49oLAVnP1+i802GbhCmfns+TWxfrxl68ISwoHkBbbwjFaqG4Sp6PNdCE7vAkVICeDpB8
         w97k2zwEt8/14pK1NRNMtHAVuJI9m5TU3rMomBX7KrFwAD4Ia9iyCukfeyMS+uBBd441
         OJ5EvkUDVC237Sk30JQYcd24kcX1cWF2vA0THAacXYCAH7Fxvd+pPYc7bZZ0W+IQIac0
         UAKw==
X-Forwarded-Encrypted: i=1; AJvYcCVrFTLKtAXxyf3uyZenVyPwpVOfG+ofaBEgj7uKxYZT6lEqnJv5yU25diJ4ysFYz3bwzTD3onF4GmHm0VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyruTYXI5afuUJ+jw6P/amq7fY+13vc4J3+z26DrH9yGjNeSTvI
	KMwp2EpPe+QtEWL9CY8kbIIRVtre8PsrYTlBdp0nRk5svEj5n391QAx5MtctRoE=
X-Gm-Gg: ASbGncvdrjgmb16RhkHMI6/FLic1ngTtWSoviZ3QUZx0J8fVGL6p4YkB9eZB5Yearz5
	DiTx77mBe5iGBRdgHHymLzgM2jdNXVfSRLwCUyEVM0AyyvWlT3G5Ah4AgKkFhsrAlIh26Tg44Jp
	MU7Gse8ggXQnqORUyU097zvL3KkSmiaIAv96O92awGN/dMWfkLRPI1nug/oy2GWD0dpHj8CxlwW
	QUSvPy+seCP5XZWRSGjV94ujlcP8rOk9wli5H+bVIcaZXsCrrmLVmv1zml+GVbPHzBGaY/Ed5qs
	nHGEdLX1
X-Google-Smtp-Source: AGHT+IEVq5G+gawrHiPzQYVclV2UevSYSlAdxNYl7RmLq5d6hxx+eXzeCUIVNOyKC/W4oWQ1f5HO/Q==
X-Received: by 2002:a05:6402:1cc1:b0:5d0:ee52:353e with SMTP id 4fb4d7f45d1cf-5d41862ed58mr5867285a12.29.1733850622148;
        Tue, 10 Dec 2024 09:10:22 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm4853124a12.56.2024.12.10.09.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:10:20 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	magnus.damm@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 07/24] ASoC: renesas: rz-ssi: Remove pdev member of struct rz_ssi_priv
Date: Tue, 10 Dec 2024 19:09:36 +0200
Message-Id: <20241210170953.2936724-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241210170953.2936724-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Remove the pdev member of struct rz_ssi_priv as it is not used.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- collected tags

Changes in v3:
- s/sh/renesas in patch title

Changes in v2:
- none

 sound/soc/renesas/rz-ssi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 35929160a8a5..b24c323ee05f 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -99,7 +99,6 @@ struct rz_ssi_stream {
 
 struct rz_ssi_priv {
 	void __iomem *base;
-	struct platform_device *pdev;
 	struct reset_control *rstc;
 	struct device *dev;
 	struct clk *sfr_clk;
@@ -1043,7 +1042,6 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	if (!ssi)
 		return -ENOMEM;
 
-	ssi->pdev = pdev;
 	ssi->dev = &pdev->dev;
 	ssi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ssi->base))
-- 
2.39.2


