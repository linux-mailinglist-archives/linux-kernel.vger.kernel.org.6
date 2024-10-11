Return-Path: <linux-kernel+bounces-361173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F34899A498
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EE928572D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB81B218D81;
	Fri, 11 Oct 2024 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5ZMV0EB"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E2321B43C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652190; cv=none; b=RW/XhGtkKj/5676YcALFmSkzqw8BeBgFICW3lLoK9TTtbheH8oySJ/WHn++zG23SOVx0C//xwlxi7a8egDjGx/JYe9595B2IU5cOFuBUNuaUltwSO3XZ9sEdSw3TxTfiN5fkIKikgtC/2Lb/1+mxMZFzltugMESXxXAgPaK2F10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652190; c=relaxed/simple;
	bh=aiK48nBymVvo/dH/OUWaei0T3BtvhFeLUjzn+aJU3M8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLZZMpoOjdr6AyPmOrzaW+oQPKV/32bBrFE0OSshN8N40k8JIl9Srb6YvEoyS3P2y2Ds0gRFY7VLrU/KfdzbKJqZzicqMhuY6rHf1CSEl+c6QBbkolQbWvD/jG0ew9B35oCz4L5UwG0GfDTHdGmUknXS6yi/YWTjBRhDIL+T4V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z5ZMV0EB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-430576fe517so3557965e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728652186; x=1729256986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v31GXG69vMHk4ux07CakUHVd4DKmezn/8McUHHPc5yQ=;
        b=Z5ZMV0EBIC9p7mIVw5hMeXKtcyl5bjDW6ISujvli8bCjRIrkZ++6raSPG8Zt0qsJOj
         tAaPSqdbPA1ePjOjOQZgERpTiGzjhO12+xn914UugGW9PtN//En6a+I9FvM7AvYEaq1u
         TboutNC8vAZGKHzU+Vo5UQHQJqBDPOKrcqR/dcYyhadIrznIAktEkKOwqm2+8vzjm595
         D59xeA6UsmTfCUZD9azo3iXkx22AqcBlXTQtZPeDGKf5TWOPSSr/skFYAN+IDwpAqfQ2
         BwDee2QdaB0EJvGc4/3BrrN+Y//LBQoXZZChUQiucXmre1Y1ExvsTPIiOoO9VGVmN6jP
         xGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652186; x=1729256986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v31GXG69vMHk4ux07CakUHVd4DKmezn/8McUHHPc5yQ=;
        b=R5CAVg6NJkbk9ArzgRbV5YZvSaGu1BjoWSUnktocvUNV+0988J8aLFkxsg1vjHnmY0
         H4P/VXnrM2vErGAkrqhAEP/uI5J9++nl37nh9Yykl3FljdHT0Fy7QFwL8ASPnOZdY8Zn
         Is52AT3BvZxusm9MIlAeOz/ZgDIGGZBnpC58Hd52FDW54G4IbPcBdmT+ScWMIDS97I6c
         OilQQ708uKbKtBJpNohCR4CzlLSE+TFhY3M+IDbJLZ8dpL53TZHk7XYzcc8/WNNNZI8X
         J+8e+xXp8I+aoGbVOnJtHHQnSdVYR5WAGdju4wyaRgXO8Bn9O1jX1EkpPcD8MOlAQKkX
         sqhw==
X-Forwarded-Encrypted: i=1; AJvYcCW6/8uai7aOZCIpmuysw5rSNIB0iPxOJawakwjM9v/ic+9vmwPqE0nmEX3oianRllcw1DO/OxR4M8WPkT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1VWBOpGz2L+BtMThDQ7DX6qO8bOiBgHtdnnsnI/z7VZBgKtWi
	d1B3Z7W6SWqlP4ANUyHWfb5QDMzDOqxHOy5pFiPpl9PtGpn5GZpG8138fDnB0Fh6RWNfj8VTPB+
	A
X-Google-Smtp-Source: AGHT+IFJV0fBBqZyQIuuDztYZ99k87dRRpSQN2NCI/NjAAk0eHOZWEgeToj9dTo5YUpjSkp3esjnjA==
X-Received: by 2002:a05:600c:358f:b0:42c:bfd6:9d1f with SMTP id 5b1f17b1804b1-4311debbe68mr9904785e9.1.1728652186408;
        Fri, 11 Oct 2024 06:09:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff6d3sm41621835e9.12.2024.10.11.06.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:09:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 11 Oct 2024 15:09:18 +0200
Subject: [PATCH 10/10] remoteproc: qcom_wcnss_iris: Simplify with
 dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-remote-proc-dev-err-probe-v1-10-5abb4fc61eca@linaro.org>
References: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
In-Reply-To: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=969;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=aiK48nBymVvo/dH/OUWaei0T3BtvhFeLUjzn+aJU3M8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnCSOHreCkDDMaYxg+FYD85uid+AJHsN2qlBqkX
 gfF0DvhUfCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZwkjhwAKCRDBN2bmhouD
 18SCD/4xlZRL8UTPeW0P/qXuNj4U5/rZazAAwWCrbdb/JmJx1KmWWQapR5Ty9P3vU/UT9lKp+EK
 392NKtcByXR8vDiJtXv96LJwZWZV9Hl0+IVfDbngWC/W+IJT/07rXU5lVjo9+JeO0T143yU6GQ6
 J2C9HWbklt61TT4Yk9yEF4m966qdA3OZLhnbXOsL/1BU8ZKt6gqdbSwV2dajQp6MQ9xCb6YsMXr
 JnkOEIh2mqhUbd2gjgXCKFwtJi247kIizv5C7yaF/HExhnh4on/LjkfzMR4nititybGuPmRI0q7
 stsvmdbiqAnzmLlLDt/LWjY64yVEBtmGl90G32RyB2XToY1U921JW6rGJUo0ZSjhL138H9zL0xm
 +Nf90Wl8qEWdKvCy07axRt9Te2u1gRZ/Aof2b5cmw1GzFeVap4yL+wT6lkq3oHeVQRs2/SSin6j
 KQF+eTk5md7RZp4WOoKZvWJwAKEidYQLPBxdLks0eYdLzT1AY6vVx9HlX/B56m06ABKg17IqN9w
 gww58cvK3B5ntVmtVD8wZqVyL/03PbElXM1MoV3usWZniqETegyqNmDyK+nHWMPJ4r3pZAB+LzM
 LUiWbq3YbWr/ksKP75Kzo1I1O8TBqQ3XjOUoYxTVuVg5NWnI7NSirK5xtSwuGPmWWAAgPx6q9Md
 TOPVThfw/iiltiw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use dev_err_probe() to make error and defer code handling simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/remoteproc/qcom_wcnss_iris.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/qcom_wcnss_iris.c b/drivers/remoteproc/qcom_wcnss_iris.c
index dd36fd077911afec942f553a55128258c10ba946..b989718776bdb5843bd48b2d724bf1c483725bf3 100644
--- a/drivers/remoteproc/qcom_wcnss_iris.c
+++ b/drivers/remoteproc/qcom_wcnss_iris.c
@@ -155,9 +155,8 @@ struct qcom_iris *qcom_iris_probe(struct device *parent, bool *use_48mhz_xo)
 
 	iris->xo_clk = devm_clk_get(&iris->dev, "xo");
 	if (IS_ERR(iris->xo_clk)) {
-		ret = PTR_ERR(iris->xo_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&iris->dev, "failed to acquire xo clk\n");
+		ret = dev_err_probe(&iris->dev, PTR_ERR(iris->xo_clk),
+				    "failed to acquire xo clk\n");
 		goto err_device_del;
 	}
 

-- 
2.43.0


