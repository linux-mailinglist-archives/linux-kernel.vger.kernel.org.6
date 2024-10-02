Return-Path: <linux-kernel+bounces-348205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588BD98E410
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0F41C2228C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEABB216A29;
	Wed,  2 Oct 2024 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEYSZcnV"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716C61D0E3F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900521; cv=none; b=PM57ijJ8LRlrIx5CLeGDQGLAQ2DPylqIP7h8stE5GApqwmKdR8sBcHBlj+o7agGWA0/KmwDrdl52XWeEVLORVN9O09jU02/8sJZ+He1p1RUtCkgMYWeITaoAxir1y/9zoro3xlUq62Z3YOmLAxl36gNMRHRJbJZSXjlFzURDMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900521; c=relaxed/simple;
	bh=rKJz0hao9xUpcsffGX5ZoN2ju/z7QmSDWhPXF7YCt+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dU84YGjhfSvERd1R4+WQwKmS301rJGvB3SNx0IngPDtHsh+ThE1RGOb8LfZZBE/iLDG0n1PPvLFc3dbKF8xt/E7ohJWRzhQJQH3qxSWOrjYQOiCWiSMgky6zINkASco/ibYSmgGHacv1NOZtFdmASVf8VF/nYGq4AzCeaFMLJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEYSZcnV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so155916f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727900518; x=1728505318; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=10Ete0eASbyrDKTfZvxGKRPjMfOwNNJQDe6fYsjfOVs=;
        b=mEYSZcnVU2nVBbnF7HUeWaryqcM+OTeqSeAeWH/c1zBLSTI9/Tiw8+50UEiSz0BQ/5
         Mwj81cTPuLWKdqR9+rZVfrKzTQhjpKmpz6iBWLO0UuZFbHR9FOfve3Jk9YEieecrj4LO
         RiYDNWYWGDQezRLaJDLHchfnDU+PscWWP8jqyqd7LP9/IhttD82kTn9EduiOzbXKarzD
         Ut3my1V1lY2EAZb9dH7gYAkkgNLmDQOOIeJJnBlYni/BK5GVaeCg/hhTSt0MD8gnyEVx
         +KpWo4Svsrg+hAApn7v2RMHhttCHK1SWG+mvQPZ/848HYo50TKId1HIGVJ3lMUTn+XHd
         ocpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727900518; x=1728505318;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10Ete0eASbyrDKTfZvxGKRPjMfOwNNJQDe6fYsjfOVs=;
        b=LYv+1tnMYDDPiD0+fJJCffsiQIqCqkNLXzwcdu5CDTjArEHYlRqbY5w9i7osgjZVbM
         Ff1NRtPdMrwuPq8D6pMuczd17FdJlmQV4heFn9KfSUKFe/f8UQ1jnDyRx7wFGZUoDwwe
         CsL9wgOdhJ/qmwGrFcgFwXC6wMoDrpSDMnT8CWLLfJ2HWItXfdWrppvnPQuuJ9S1wVc5
         nIpI0VGr7mwbYMgWr1UKKSSLAzx/6EIPyrDasGzIgfaxiYEht1t+sEm23SrFXE7jwfAX
         1bJvb2R8Z5QSp/lMRjWLWFWUQi8IvggdKiCZ7PgsHlUg/6a6wvzgIQyp40thi98CO7jk
         /U0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeaCSwmh8lx23z0Jn3kvhelp+UZPV2pHO+Z9HqPf8oEdnpZ6f5g71Rh9hbqiDolI+22x8ww4+GsGBDV7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxno959Z4jVKYr563Av/ndJUbBTbqVaoe4qHk3iP3e62Z7i5/AE
	WBTM7Lo6KaXxXAN7prhKo7SvcRCsYyHWkwtQ118sfiao70Vw0DIZCD1k6ceV
X-Google-Smtp-Source: AGHT+IFoAq4Ph8jiDRYgIEa71gIMuyXdNHKKqBbTh6+oyGjpqdo81GEjyoal0nyN5Ul0h29juLMdlA==
X-Received: by 2002:a5d:58ee:0:b0:374:c7a5:d610 with SMTP id ffacd0b85a97d-37cfba0a4fbmr3562525f8f.43.1727900517427;
        Wed, 02 Oct 2024 13:21:57 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-28a8-6b99-3729-0965.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:28a8:6b99:3729:965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd572fb5dsm14703947f8f.88.2024.10.02.13.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 13:21:56 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 02 Oct 2024 22:21:51 +0200
Subject: [PATCH] soc: fsl: cpm1: tsa: switch to
 for_each_available_child_of_node_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-tsa-scoped-v1-1-ba6a6d657f82@gmail.com>
X-B4-Tracking: v=1; b=H4sIAF6r/WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwMj3ZLiRN3i5PyC1BRdc1Mz0zRzk7RU42QDJaCGgqLUtMwKsGHRsbW
 1AM/O5BdcAAAA
To: Herve Codina <herve.codina@bootlin.com>, 
 Qiang Zhao <qiang.zhao@nxp.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727900514; l=5467;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=rKJz0hao9xUpcsffGX5ZoN2ju/z7QmSDWhPXF7YCt+8=;
 b=Etx2qoaGCIabzk/U64d9Sqti+QbXieObYLBdJ6sdh4HrFIOI6H1/inwqehWshOTHicrQmUIRM
 8pnW+dWmNRRDzA9jRw33np5cwayHwZsmuYTEi4+1M70RhscG15sJDi/
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The non-scoped variant of this macro turns error-prone as soon as error
paths are included, because explicit calls to of_node_put() are required
to avoid leaking memory.

Using its scoped counterpart simplifies the code by removing the need of
explicit calls to of_node_put(), as they are automatically triggered as
soon as the child node goes out of scope. Moreover, it is more robust as
it accounts for new error paths without having to worry about
decrementing the object's refcount.

Note that the device_node is declared within the macro, and its explicit
declaration can be dropped as well if it is not used anywhere else.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/soc/fsl/qe/tsa.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index f0889b3fcaf2..a1140aadfd6c 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -680,7 +680,6 @@ static inline int tsa_of_parse_tdm_tx_route(struct tsa *tsa,
 
 static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 {
-	struct device_node *tdm_np;
 	struct tsa_tdm *tdm;
 	struct clk *clk;
 	u32 tdm_id, val;
@@ -691,11 +690,10 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(tsa->tdm); i++)
 		tsa->tdm[i].is_enable = false;
 
-	for_each_available_child_of_node(np, tdm_np) {
+	for_each_available_child_of_node_scoped(np, tdm_np) {
 		ret = of_property_read_u32(tdm_np, "reg", &tdm_id);
 		if (ret) {
 			dev_err(tsa->dev, "%pOF: failed to read reg\n", tdm_np);
-			of_node_put(tdm_np);
 			return ret;
 		}
 		switch (tdm_id) {
@@ -719,16 +717,14 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 invalid_tdm:
 			dev_err(tsa->dev, "%pOF: Invalid tdm_id (%u)\n", tdm_np,
 				tdm_id);
-			of_node_put(tdm_np);
 			return -EINVAL;
 		}
 	}
 
-	for_each_available_child_of_node(np, tdm_np) {
+	for_each_available_child_of_node_scoped(np, tdm_np) {
 		ret = of_property_read_u32(tdm_np, "reg", &tdm_id);
 		if (ret) {
 			dev_err(tsa->dev, "%pOF: failed to read reg\n", tdm_np);
-			of_node_put(tdm_np);
 			return ret;
 		}
 
@@ -742,14 +738,12 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 			dev_err(tsa->dev,
 				"%pOF: failed to read fsl,rx-frame-sync-delay-bits\n",
 				tdm_np);
-			of_node_put(tdm_np);
 			return ret;
 		}
 		if (val > 3) {
 			dev_err(tsa->dev,
 				"%pOF: Invalid fsl,rx-frame-sync-delay-bits (%u)\n",
 				tdm_np, val);
-			of_node_put(tdm_np);
 			return -EINVAL;
 		}
 		tdm->simode_tdm |= TSA_SIMODE_TDM_RFSD(val);
@@ -761,14 +755,12 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 			dev_err(tsa->dev,
 				"%pOF: failed to read fsl,tx-frame-sync-delay-bits\n",
 				tdm_np);
-			of_node_put(tdm_np);
 			return ret;
 		}
 		if (val > 3) {
 			dev_err(tsa->dev,
 				"%pOF: Invalid fsl,tx-frame-sync-delay-bits (%u)\n",
 				tdm_np, val);
-			of_node_put(tdm_np);
 			return -EINVAL;
 		}
 		tdm->simode_tdm |= TSA_SIMODE_TDM_TFSD(val);
@@ -792,13 +784,11 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 		clk = of_clk_get_by_name(tdm_np, tsa_is_qe(tsa) ? "rsync" : "l1rsync");
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
-			of_node_put(tdm_np);
 			goto err;
 		}
 		ret = clk_prepare_enable(clk);
 		if (ret) {
 			clk_put(clk);
-			of_node_put(tdm_np);
 			goto err;
 		}
 		tdm->l1rsync_clk = clk;
@@ -806,13 +796,11 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 		clk = of_clk_get_by_name(tdm_np, tsa_is_qe(tsa) ? "rclk" : "l1rclk");
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
-			of_node_put(tdm_np);
 			goto err;
 		}
 		ret = clk_prepare_enable(clk);
 		if (ret) {
 			clk_put(clk);
-			of_node_put(tdm_np);
 			goto err;
 		}
 		tdm->l1rclk_clk = clk;
@@ -821,13 +809,11 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 			clk = of_clk_get_by_name(tdm_np, tsa_is_qe(tsa) ? "tsync" : "l1tsync");
 			if (IS_ERR(clk)) {
 				ret = PTR_ERR(clk);
-				of_node_put(tdm_np);
 				goto err;
 			}
 			ret = clk_prepare_enable(clk);
 			if (ret) {
 				clk_put(clk);
-				of_node_put(tdm_np);
 				goto err;
 			}
 			tdm->l1tsync_clk = clk;
@@ -835,13 +821,11 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 			clk = of_clk_get_by_name(tdm_np, tsa_is_qe(tsa) ? "tclk" : "l1tclk");
 			if (IS_ERR(clk)) {
 				ret = PTR_ERR(clk);
-				of_node_put(tdm_np);
 				goto err;
 			}
 			ret = clk_prepare_enable(clk);
 			if (ret) {
 				clk_put(clk);
-				of_node_put(tdm_np);
 				goto err;
 			}
 			tdm->l1tclk_clk = clk;
@@ -859,16 +843,12 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
 		}
 
 		ret = tsa_of_parse_tdm_rx_route(tsa, tdm_np, tsa->tdms, tdm_id);
-		if (ret) {
-			of_node_put(tdm_np);
+		if (ret)
 			goto err;
-		}
 
 		ret = tsa_of_parse_tdm_tx_route(tsa, tdm_np, tsa->tdms, tdm_id);
-		if (ret) {
-			of_node_put(tdm_np);
+		if (ret)
 			goto err;
-		}
 
 		tdm->is_enable = true;
 	}

---
base-commit: fe21733536749bb1b31c9c84e0b8d2ab8d82ce13
change-id: 20241002-tsa-scoped-7565f74fe3c0

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


