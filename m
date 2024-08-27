Return-Path: <linux-kernel+bounces-303561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EF8960E19
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF75B1F245D4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D02C1C68B4;
	Tue, 27 Aug 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEtLB0EG"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366ED1C6F76
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769872; cv=none; b=jmEcBISraT9FL5hAIYUJ/Tftayq7xBrFGNPqt6g8jEsc6VJSFewUZ5siyjjqsIpekPtB1Vd9Ve8SNp9YvJvN1fmEjshOWNmqYcMJ5vTpNznyXiJf9dH7cKlwrY5TNkOFchDdjVwN2J+wVIwHoPGj5+7jr09lbSADSpQw7vVTSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769872; c=relaxed/simple;
	bh=9cJgFjD/R7mUY/jBwLx1PxnCORxDvEzzYDQVq9k+sW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaFpvhzYjZU26QeSqVDt7ExrlCxglNvaCz8/t/S6Z9/MyaQqT0GukAip+v8KVOaeRJa9N8WDaUH47xRUuHQATTGib+EuiYsMk6cZvvFIPr/Om8uW838fYt358otCQZ8UcN56wP9zOsxT8b5L9l2aid0ypwyLrw5AfhlehRVlWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jEtLB0EG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-371b2a51746so163609f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724769869; x=1725374669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEXiFF9+y1AtJUUe0lBIVMSQ2gFJFplRHBS/b2AQ058=;
        b=jEtLB0EGfh7uOtCd+PsNwvjljxe7mw5mvh5geXteqcxqEpZmdW28Yw6v0xKdQm1260
         VUc48XjuRj0QfuZrqL5tbXXSQTxGwoF62TVJX5E9T17EhD/9nfdQCuCc/enF6DKjXjga
         VGE8fng8kgN+V8bnpPBHB23JV2t/Xlh3rI1qlVA5wPK4RiQxnxZS2gH2GST9KfhpKQ49
         Nxmhwpbd7i7PSkHTmlu4yzlr0m3qJnW39D1LSBDxcnkZJ0JyGITJWx6HcINiVpCjFW6x
         c+lUMvkXR7vvGrwWaslsiU24unxtz6IlgcPuIERtCb5zMQLdYK33KPtOZeTt/PwI7GHR
         gjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769869; x=1725374669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEXiFF9+y1AtJUUe0lBIVMSQ2gFJFplRHBS/b2AQ058=;
        b=hL/uPsoQdJdS7TTqjr8UohfI9MVWB5rXKmIg1CHCYvw/fB6m76MGZ/j5AUu9ZKPhdY
         L0J6futIPQNpX7Ki2uZd0bTLFpb37XizaMjNmnO+C/pKguxq0EQMGPaUEaLWyEuLD5IY
         IZDuIhdxAuTkFfgn/8L6ceRHLPXHmJdEym66WHNmLc7efG8+L1JeIFHvSZNOfVgG99XP
         1YI/zmqsEH4JNp4lvw2Ho/o/e9WKUdD5eeNmho1T7Uf7e76/3d8MnBMgtEgBWgd4ucm3
         mnQTI5egRu9cn9vuhRzjq1FaRG2lzW40kDdhahKP6M88oIqFoYlG2I/TZanlWz9HlKHg
         qY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxKHXvhn+R7EFRi1cQxOIwyUlQOkkzHGYsNgEeIMFxNUcmUEh8u0zdqGpJ9c++Ci2GU+lUGKHJKL1i9CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/F+Vq4MIYGm+Of3286q7wmus+0mh3Dm45PNIOa4DxnkL14sz
	m6JEUWxWYCDT82j7ebBmFVMX0h2OymkV/wJ2KnyjQHLrRSMCDX24ndgO0BlXeQ0=
X-Google-Smtp-Source: AGHT+IGffSjXGCUmbOSah5oQPlaHyK36FMHgV70SJ2QT+CDm/NnObADKG1Btd3N3UFma8fanv9/p7w==
X-Received: by 2002:a5d:648e:0:b0:373:6bf:9608 with SMTP id ffacd0b85a97d-37311843370mr5580812f8f.2.1724769869564;
        Tue, 27 Aug 2024 07:44:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff654sm13270457f8f.75.2024.08.27.07.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:44:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next RESEND 3/3] net: hisilicon: hns_mdio: fix OF node leak in probe()
Date: Tue, 27 Aug 2024 16:44:21 +0200
Message-ID: <20240827144421.52852-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
References: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver is leaking OF node reference from
of_parse_phandle_with_fixed_args() in probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index ed73707176c1..8a047145f0c5 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -575,6 +575,7 @@ static int hns_mdio_probe(struct platform_device *pdev)
 						MDIO_SC_RESET_ST;
 				}
 			}
+			of_node_put(reg_args.np);
 		} else {
 			dev_warn(&pdev->dev, "find syscon ret = %#x\n", ret);
 			mdio_dev->subctrl_vbase = NULL;
-- 
2.43.0


