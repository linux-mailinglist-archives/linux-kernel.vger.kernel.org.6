Return-Path: <linux-kernel+bounces-300450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4079E95E3CB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 16:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0471C20BDB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD0E15B108;
	Sun, 25 Aug 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvEN3O7h"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ACB155389
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724595278; cv=none; b=VdUVjpP+rEi67iSRXVWbHf7vnHbH9Qz2uuaPXz2732XbnuFM5ZjJNr/GZ45Iu08DbQ8e4v/gXAl+Ywyj9fe5bGL7mt/raSG/Y/243mwQoRhDPuqntZ9q/C217Q0ygsDjIJR5MkcP/yiKcXIc9uToqwKvGcVd7CEvC9Cop3AEzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724595278; c=relaxed/simple;
	bh=9pgusit1pxrr+A2/sS7UfW0KAIyXH2HmTDW6oahLzho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b9FEIsMKANXTJwApsxKrdUVtkdnhzzB4N6G952YFOeMCvkMlp7e796Qq7y/H7JZtndZJEEIeaWNHvYLC00Sukq+jgiuwuw5Hrv6Yd8VSrggUp3hsnqHNz2adQ+RRPsgtb1uhMY52stGVeWqLUyLmk9pmgVBoSRS06DFnwxNWpDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jvEN3O7h; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4281da2cdaeso5392075e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724595275; x=1725200075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vyI734cRrZFj0A/p/jgke1T1ninVILNTlfgxfQSwKE=;
        b=jvEN3O7hN2gt7KPXx59yqGeB7+Fd/0OckZx8LWBXp7/S3pzyTDVrryYhLZSlVQvLDD
         ld0ojYmh7rlPi/WQFFl/eadyQqbDnU4y8NIxh0KGNsHtdpGF7DIMrcY6/XjbEnMo4mCE
         JKklhcgD6x5smT6VZQWcZG8pGDrsHHXnQql/fV8m9s4drEtPvDuW8w6E3SZT30AF3TJp
         n2jbDaHJnBil/CjEs5eAq+W61PFxNkEHJ/47O0TnHyTn9EaeS4kNofqR9LrME6Y7NVoR
         tQb8cYJM12wrpeYltUM7s3HxRuHLtb50E2MBipBTdrI62Kw8v4EUJrEnZg/Q9awcWJh+
         JBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724595275; x=1725200075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vyI734cRrZFj0A/p/jgke1T1ninVILNTlfgxfQSwKE=;
        b=fPj4xeDKs0mwJnGQO4jbdwladS7pmsTh84Mu65C5/CQBIRgFrEvezzX+zA5Xl+USm/
         P62mcrgN6FQoPOkGizXUivzDzUsFP3cAHUqWuBVuKjJMCgg8i1Bk6F+1huPQSD4lHD9D
         UJPXvLGpkVuLlStkNmFNNWEr4llNky05jNTZt3hHtZOFXWMVQ/diQRtZ0KIituGCMbA9
         U8Lvl8oAorwdjGTEUQydfjAH/0/ZLsvNNn9GbBsDudofsDw+QSBnB6B9b5xvSjU6ZEKI
         MvyvTsODd6vSYsUD1P3EClAtAPSw5WJNfde3nqZyUopFwkKKdTc4aovjvt5Lx5hpKvKa
         ibpA==
X-Gm-Message-State: AOJu0YwEG0LMcH1/Tl4ebMFu2NQN/oaLKO8WQgo3XWwfl8pRb2zUBFce
	+bYtKDM0phvAQ5k3vq4+4P6lXnDogOuAiYRC+rDNb5A6ho1Ya5q+777NvKmdzfI=
X-Google-Smtp-Source: AGHT+IFak5e9TgxMwRV1VQC3TmD/nC7hYru8uGqId4jYQGfP92V0mB5tath7X71OxrZX1Y6HIUhsVA==
X-Received: by 2002:a05:600c:1d25:b0:426:6ecc:e5c4 with SMTP id 5b1f17b1804b1-42acca0c727mr34083495e9.4.1724595275253;
        Sun, 25 Aug 2024 07:14:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162347sm122556045e9.23.2024.08.25.07.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 07:14:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 Aug 2024 16:14:25 +0200
Subject: [PATCH 2/5] reset: k210: fix OF node leak in probe() error path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240825-reset-cleanup-scoped-v1-2-03f6d834f8c0@linaro.org>
References: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
In-Reply-To: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Antoine Tenart <atenart@kernel.org>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 Palmer Dabbelt <palmerdabbelt@google.com>, 
 Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=9pgusit1pxrr+A2/sS7UfW0KAIyXH2HmTDW6oahLzho=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmyzxD9ZG4S/H4bpvV+Ch6/rnPSqPk9mJsU/Jxb
 DPFQLvB6+KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZss8QwAKCRDBN2bmhouD
 19lyD/4x8fa4AOkKyveVLnoZhsiOq4/EM63MPkrJMxfB9Vfm/yTnK2uzctxkuWPgDgB076mY76k
 SaMnFfbFkK8VdlwXcAX/zFm0PBTyRXcbKk7Nv4u01b8rHPx9IAHCFOM8hIwGIa03i6XNmsL5Uko
 t42t2QmGdu6UFGT4kC9GKB5YbpDuZVYys8UZdPTYbwFScrCa3qRrMkZFZJZ8KP2YPGNtRR/F/Ua
 NqmT68ych37x5XciGnCF23o31YCm6nU5COwcDG6I/N7hWjqMt6f8ur/bRKEJeV/BJWFlK+Y2VHj
 2zhkkrX7jC/eVXDm8L/zrU+aIn68h7lrDNgOtp53fekgqoPoQ6VXqmXGzYpChSl8atweHp1gDBr
 Q0/uc0DWw/Nheal0uryPSodVR2zQ1iqMoCxEPIa/wPHNqOcPOxjFC4OLs2tBViG6jaTrsWuRQBm
 zpVBbKkvEGSsf9sPZoNLWnyG6k9DnsXaaNoJPRC6EFXmpGJPnCIFAFW1BLmK02AWvLJ1IfZmIv6
 Dem+z3xlw1HPDUIc1VjoTAXgLqUVqUFiSWXjd4jYqUtCtbvsNqp8+3iMCsvZAKJuK7RMKQGLwOs
 l3/2GQjQD7VfbOVodIn3WKUknAfKn67Gdhj0ML4V9Fk3gIyBj93OX8kSoSyTxq2vYb91N1LAfbb
 6ZR51YIOEl0TDoA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver is leaking OF node reference on memory allocation failure.
Acquire the OF node reference after memory allocation to fix this and
keep it simple.

Fixes: 5a2308da9f60 ("riscv: Add Canaan Kendryte K210 reset controller")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/reset/reset-k210.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-k210.c b/drivers/reset/reset-k210.c
index b62a2fd44e4e..e77e4cca377d 100644
--- a/drivers/reset/reset-k210.c
+++ b/drivers/reset/reset-k210.c
@@ -90,7 +90,7 @@ static const struct reset_control_ops k210_rst_ops = {
 static int k210_rst_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *parent_np = of_get_parent(dev->of_node);
+	struct device_node *parent_np;
 	struct k210_rst *ksr;
 
 	dev_info(dev, "K210 reset controller\n");
@@ -99,6 +99,7 @@ static int k210_rst_probe(struct platform_device *pdev)
 	if (!ksr)
 		return -ENOMEM;
 
+	parent_np = of_get_parent(dev->of_node);
 	ksr->map = syscon_node_to_regmap(parent_np);
 	of_node_put(parent_np);
 	if (IS_ERR(ksr->map))

-- 
2.43.0


