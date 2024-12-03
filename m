Return-Path: <linux-kernel+bounces-429506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2AE9E1D00
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D492824F6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0701EF0A6;
	Tue,  3 Dec 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3HUhj5c"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419BB1EE03D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231038; cv=none; b=pn+Oa+pMc+RppEgiNLxPcYvF6rT5BMg0XKL0SV3Gvj0TrMoGJeqRZO6W7YlutG+Jm7RHUoii0vp8+TTbuvKIe33BIu25XNVdbjTbjbmIH6vKGyRRk5bjFXzy4Ek2RiRNiZmM7n66yOB81DcRlzOJnD4xtyOK65dgB3n5VcA6dag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231038; c=relaxed/simple;
	bh=G9Zx6yR+781XCG/n/fbfDfT+/1Gr/1cauqBqJjTW8o4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GX8fvvHB9du3iemMuJSOWaoQH8SURqVjw7wc4yOL2VEy+qx9w9tKX3STUGQRyxAcLDe/Gze3wEuIJqf7lqALsYY6NYRpljB1D0RgXqAYzenTmqjCXBff+IHtcQu5ToO9tvabYcLW7ujMN1t2XRWfGtdJC3QrkGsCM2m2BOArC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P3HUhj5c; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so248467966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733231033; x=1733835833; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KIGcxZ8Psy2FDVunuCyBKosiOVkthQlOppOTs772mFg=;
        b=P3HUhj5cV7QQkHf1f7rcuE2rwFgZ3iFEKXFb09h1YurUVPf0FFGmhh9ARitGFxHlg4
         k/8+Jc97iw7rtaMCkCef83eHxpWDVnsQzOmsOadhvHvoSyDeULDbbWCAcA666KW9kHOG
         Rb1BLDX/fccih5cKOpx5ApZ7A4WdIXGxsuG13Wtz8nceCNrCz7v4/mhZNd9FE8f6svEh
         4ga8afdL6kFh06loDfAhXHPKeRrR3rC0QkcXA0pQsscn7ZcoNh9yhml7U8tL9pcTqPDs
         D6R3mEVrVrj5Nimk91Qyj+C0uhF8bLoMWEyEp7FquamYbHYr7BCWyWwViFXKbVGszPQQ
         MvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231033; x=1733835833;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIGcxZ8Psy2FDVunuCyBKosiOVkthQlOppOTs772mFg=;
        b=dfO77TO4FcLsT/C5L3oyyP8oYZQs23hJPkMOF2udyDTShYOptd9Wrj/0lmQkLXIeq0
         eI7cmmfuHeP8pPT4v7/Hurwa4bdeOkCyn6Rb42iMDgC/f6NQckI/cVxnL3sq5ppO6sZa
         vRRNVMB2PICJ6k4xo3zHJ6Q6YdXY5YHXhsJX7edpL686E73wZtY/2U8IXEz1IHbbJNI9
         fzooU8W76LdadktCJDe05HjVTq6Qx51UvST9ZsN15xcTpppWC/RBBRWI4ebukIoTTUaK
         REsJQpvckE5S3Qra9hJ+kgaZLNnRW7ZNpbOwlW2BFcHi/0Aye8DRCJ7WWapCG/4mDpHI
         7CQg==
X-Gm-Message-State: AOJu0YzdzmbCCXrFYF6bZCnLgiFa+WZMFX5VNDF8CW/8xJZvbxyx8GbX
	Bu9zAxmPQJRFm929jt0l+K5IofpSdJegyQAUDZqFqeuYKMrhKu2WlMy/2HC/FPBfTGX1tvUMtRv
	zh4Q=
X-Gm-Gg: ASbGnctr37fI+PY0SQs60o8akJDVMyoamf5X+IPrebTyt4QSVXKxAmxGWdw+UOwYcok
	cS3IHl4PmxRevAr1DU8BCp5sXPqAHOPr1hyPrKvAximUeFKZgMlusp3vivbm31UI2ZrOHwWKj+b
	9soHlRaod5aTMb4822HtltrHHMSQ0khSpsVYDfwFens6pc7yZsU/c7Xcbf668S9HIrHBpDAWC/D
	FHHCJVN7w2Ec0Co9QzkqcxFvARB3vk0G5FEVauD9akWbjrPUAzldBtRHWn+moUl1NO+IpIWid01
	pYgTBprUoX0wyIcHUxAuwlQDPnTMzg0lGQ==
X-Google-Smtp-Source: AGHT+IEK4L2mxFtzL87PS4BcKmkcVwHyuFe2W4bjoaXvNg7AkfFZpDGSmmvKTSD8eht+D7KFJe38yg==
X-Received: by 2002:a17:906:bfea:b0:aa5:3ce3:7fde with SMTP id a640c23a62f3a-aa6017f0beamr7769166b.24.1733231033374;
        Tue, 03 Dec 2024 05:03:53 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6d7esm611425866b.114.2024.12.03.05.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:03:52 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 03 Dec 2024 13:03:52 +0000
Subject: [PATCH] MAINTAINERS: add myself and Tudor as reviewers for Google
 Tensor SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241203-gs101-maintainers-v1-1-f287036dbde5@linaro.org>
X-B4-Tracking: v=1; b=H4sIALgBT2cC/x2MMQqAMAwAv1IyW2hTB/Ur4lA1agarNCKC9O8Gh
 xtuuHtBKDMJdOaFTDcLH0nFVwamLaaVLM/qgA5rjy7YVbzzdo+cLoWy2DZiPTUjoqMA2p2ZFn7
 +Zz+U8gF9KQ9WYwAAAA==
To: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Add myself and Tudor as reviewers for the Google Tensor SoC alongside
Peter.

While at it, also add our IRC channel.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf1d81bd04a7..2039cc57d8a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9754,9 +9754,12 @@ F:	drivers/firmware/google/
 
 GOOGLE TENSOR SoC SUPPORT
 M:	Peter Griffin <peter.griffin@linaro.org>
+R:	André Draszik <andre.draszik@linaro.org>
+R:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
+C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	arch/arm64/boot/dts/exynos/google/
 F:	drivers/clk/samsung/clk-gs101.c

---
base-commit: ed9a4ad6e5bd3a443e81446476718abebee47e82
change-id: 20241203-gs101-maintainers-9a24c8b220e3

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


