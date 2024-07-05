Return-Path: <linux-kernel+bounces-242050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E2C92831A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1685285D06
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D45145B27;
	Fri,  5 Jul 2024 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICzW3IqH"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588BA1459F8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165751; cv=none; b=Q3PGf5nYmOEBRyRMvAbiYf4i2sf1ZphiZZGl6LIbXdgelRVoc7b/Ak8qKSC0bNcbOUB0nrlr36+Vpqk9HZFGXb98+yw/bH2AKlbl9RUDBWZKp/q5Y/MHOvtym52ck0h2oa1jskFuGrEzF0nRSdmdQtkTjm1eb8VrAtBE//X51XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165751; c=relaxed/simple;
	bh=ExHT2EX/ILbAEUasFM79Vj21uF35V67tuLKVC/Rcxoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SOaRgkdEkqZpNY8k/jTVOYlgR8/8m6ij3o0+Yh9onnRQhP5bMlx1VcM2i8IHlzdICen8O2tjTTtIRCTeEnTGXlMhZjAPU26k4EVoXgY8Qq7BlEmr4m1mQyNTuRo9hdku3RpJzG3KTHkdAPiJoeGjG1sRcv7o7UHlqLqf3Z1M9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ICzW3IqH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36798e62aeeso839625f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165748; x=1720770548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58Ieoh+8Dv9L+S664n+nMyrN6Z2PXH7+gflZGbfCUeo=;
        b=ICzW3IqH//yf+JpbXc6AM/rT4mpGxiTtRPKGALs2+Nl/uovWNyjwKoAtP3GrkSBUS8
         VOJFlxC+a/giaFAL4ryMvWFmpvl5E7rFky6fjZQq61bqZYratxuzS1F6Bd+HNLVlsI6S
         FSRpPNm7YXGQcxGEpmco7e5KQ1PyCRkwiK6/k/Ys2mQzcEpqEzvB1LwcAB1xrlGSWk/A
         BxqiwOffcD5HT3IL4Desn7pGjlcotN/3KG52J1YKDCkMoMV9oL73zKXA5+of/Fk4qTQW
         1fxs37gug1w5EQE7obsAe5Y0IYraubUerxYRM4MT99fZBnjoJw5f0gkeXE045gkCb/tu
         UCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165748; x=1720770548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58Ieoh+8Dv9L+S664n+nMyrN6Z2PXH7+gflZGbfCUeo=;
        b=Ul0wLhzcYiuLxCS86+N5qXLc/hgiJB4dAJFgaQ33UNWqE1m/7jVZvrS1Y/oQBbIR44
         FRVVuipsZMtrrHonUvG8gskz0B2CqwvluA33Icw6DGPtK9+ln3+QHZ0sPiVh8eZJeqKV
         3zMMbSSOjatJ8V/lIJc1kEaEmSK05JRzKgZjhWFYddXKwuKMre9Wv6MajkBro3n5TPYM
         IPhJ999RW7/kOUf99c+1GdA0/5HRI/cupiAxeqSd6JGEMekZjBkTkPh2lQjursc3Ayew
         IZ2DPL84uk63cvZUGMAqpdAsDSMfzE2nCVURwTeUm+PnzLGKeVLQpgmUHpi9ufim4r+S
         bBew==
X-Gm-Message-State: AOJu0YwR2Myoem9mbV+WMm8JK3Eof2SBGyl+xwTlD/NOzgPXMgii6/x1
	Y3qbMt34M/ACk2Go2UwXkv8H9AeiSR7a69DPtpObqaYwQCMQ2WaBCI/mgHB+BYA=
X-Google-Smtp-Source: AGHT+IHdfofxCv6MIs8n6sbnyJ/f8DPKxmjE68VHV+MP/9x3ZXWIdTSVWUixgECq40in8C8JUvLPLQ==
X-Received: by 2002:a05:6000:b85:b0:367:880f:b8b0 with SMTP id ffacd0b85a97d-3679dd311a4mr2390143f8f.8.1720165747794;
        Fri, 05 Jul 2024 00:49:07 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:06 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	MarileneGarcia <marilene.agarcia@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/15] nvmem: meson-efuse: Replacing the use of of_node_put to __free
Date: Fri,  5 Jul 2024 08:48:40 +0100
Message-Id: <20240705074852.423202-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
References: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: MarileneGarcia <marilene.agarcia@gmail.com>

Use __free for device_node values, and thus drop calls to
of_node_put.

The goal is to reduce memory management issues by using this
scope-based of_node_put() cleanup to simplify function exit
handling. When using __free a resource is allocated within a
block, it is automatically freed at the end of the block.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: MarileneGarcia <marilene.agarcia@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-efuse.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 33678d0af2c2..52ed9a62ca5b 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -42,20 +42,19 @@ static int meson_efuse_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct meson_sm_firmware *fw;
-	struct device_node *sm_np;
 	struct nvmem_device *nvmem;
 	struct nvmem_config *econfig;
 	struct clk *clk;
 	unsigned int size;
+	struct device_node *sm_np __free(device_node) =
+			of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
 
-	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
 	if (!sm_np) {
 		dev_err(&pdev->dev, "no secure-monitor node\n");
 		return -ENODEV;
 	}
 
 	fw = meson_sm_get(sm_np);
-	of_node_put(sm_np);
 	if (!fw)
 		return -EPROBE_DEFER;
 
-- 
2.25.1


