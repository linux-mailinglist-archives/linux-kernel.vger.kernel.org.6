Return-Path: <linux-kernel+bounces-321312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E0097189C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744C2B259EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80751B7902;
	Mon,  9 Sep 2024 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8p9/Wqx"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887031B6538;
	Mon,  9 Sep 2024 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882585; cv=none; b=APiRpQmxBVjVj/sJFQrEdHJ77tL9kI441o+RnS1X7abd8SsIjPP0UV5+H7kZVKlVp6VieaHKgwjIW0NhNDlIT54Wl21ukeGhWJ1AKXdRZtlj+xzeaA9Ds5hZnrOeJOzqWP6WFGtXWbqiDKSk/7zCXExAKr0MHo355gY2QtjN48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882585; c=relaxed/simple;
	bh=MZsa6SYqxrl3ZzgfuYbLQifE0u6uddW87QbRWyNYiIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lITUUhKws+x2MFppHgZLxN69oDRteWXTzU46GU4VmERha/TKfd9g2cNG/a8OIFePaFfAJCwLBUUo2zukjPm2PBhbeaa9XSEVap22dqXbqKMxQtHggmr+hQl5swHafY0A3xNGQGIPvIie8zdqwLjsIi+LQwifwKBhcfbiN5UhoJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8p9/Wqx; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so4622779a12.2;
        Mon, 09 Sep 2024 04:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725882582; x=1726487382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FqtYi1iw2vOhsrcvx4Iygrl7+RxYd6jvfQ3jmeOKNc=;
        b=Y8p9/Wqx7kuYTuVE7llRv6M2WvqNGZccrUeiXnhBVB0G6A3FxIXPBCtzuUcWDITrw9
         fcgoaZo3uegFlzsHtjMeNOii3pTGDs78jQjOvI3V7AirsPT1iKp0XCteYHGk4YIvEXQ3
         LgL7Q/1h8qKlwrl7C3Vo1R0zgpt+RW5+O/vtyf4fvNNhzmPAwvs0dORz+9+ZWs7OyHsK
         vV3E6wf/OuOTzq2sYi0SZ/IzksKWeSERGt0HTg+fa+64oI0tAWnrYdU6VQrmmR2JBIDJ
         +VYe6k9KYwTuwBsOOd4joNFyuGDOXb/E1r7SNUzxNgzg5qX3Ezk8xvb4lnYIEL4BJ1gV
         Mk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725882582; x=1726487382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FqtYi1iw2vOhsrcvx4Iygrl7+RxYd6jvfQ3jmeOKNc=;
        b=BQ4ZGuZOfnNtOox6EEpaubmb3uRjnUCm8rDm0+PsI3sEegY0IBao/v8z0ALoJtArWW
         gKAJjUd3emkTbr8JbYWygTCEVkOBSdcRldsKlNVYVk+viV0jCvkFzpGQ1NIb6b4ZpZPS
         m38KPwdmvGn8KxwfI59EHwAadeJPq2IyODQ9HhoThSh+u4AjogkNBOjRRtsL17PZL+M8
         cSG83N+LqfFZRkR/bZXcbkkXxcr8+zVYLNd6T/dJfmNjk4VeHMlT/7J8E24PR25LYLh3
         zt8JETck/n82jXDXmtz0XMs5ZMwFDYKbnY+xeilL8TLD9XQ2kuxspgTu5Z5g5PRvdnpz
         I57w==
X-Forwarded-Encrypted: i=1; AJvYcCVdO8CT8JoFXS3SRQv0niQVRlf93QJCbyrw4jqVCb6lhPfqYnTwcWsdd3rFmWAk91CPihzO68kfzRezWXXC@vger.kernel.org, AJvYcCW8VjHU8tfmJ1uChObbYOfJCJjTGpbwCmoNEUKwIIRyC6waB0WbcSmysml/wtj3NsD75H0Znhj+vCEn@vger.kernel.org
X-Gm-Message-State: AOJu0YzV2o9AwYGYJfo7gHucKXW6AJt66/wNQA4NjZIzBO1TKJTm8wfr
	Cj8GXORqWRHgavdz6xxDw4cGArkNIA8QSVZz75WSDXX4/7PpABsi
X-Google-Smtp-Source: AGHT+IF4fgHY75/BQyX+RpiuMPmhFfijUoVKMVSVclMKAAtr7zrwuxZWYAPVtcBG+8zbwSQmOE2r4w==
X-Received: by 2002:a17:907:3e9e:b0:a8a:8127:4a8 with SMTP id a640c23a62f3a-a8a887e5ea4mr831498566b.43.1725882581741;
        Mon, 09 Sep 2024 04:49:41 -0700 (PDT)
Received: from hiago-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835697sm333258566b.16.2024.09.09.04.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:49:41 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH 2/3] ARM: dts: imx6qdl-colibri: Update audio card name
Date: Mon,  9 Sep 2024 13:49:01 +0200
Message-Id: <20240909114902.82380-3-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909114902.82380-1-hiagofranco@gmail.com>
References: <20240909114902.82380-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

Update the audio card name for Colibri iMX6 to match its specific SoM
name, making it less than 15 characters to fix the following warning

fsl-asoc-card sound: ASoC: driver name too long
'imx6dl-colibri-sgtl5000' -> 'imx6dl-colibri-'

making it compliant with the ALSA configuration specification [1].

[1] Documentation/sound/alsa-configuration.rst

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
index b01670cdd52c..9f33419c260b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
@@ -136,7 +136,7 @@ sound {
 			"LINE_IN", "Line In Jack",
 			"MIC_IN", "Mic Jack",
 			"Mic Jack", "Mic Bias";
-		model = "imx6dl-colibri-sgtl5000";
+		model = "colibri-imx6";
 		mux-int-port = <1>;
 		mux-ext-port = <5>;
 		ssi-controller = <&ssi1>;
-- 
2.39.2


