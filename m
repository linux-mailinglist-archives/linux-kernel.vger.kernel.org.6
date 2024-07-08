Return-Path: <linux-kernel+bounces-244734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C86292A8A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AE41F21DA2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2B714BF86;
	Mon,  8 Jul 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KeaLQbf2"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA314A4FC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461952; cv=none; b=PgI92l2iwmgJO3dw3iuKtw6EkB96TMRVI7/zYcpsHJi0t68DF6LXbT/xfCMOp0ZB7hwmJZKQlhAgIpuidoc3H7QeS/hqc4NxC5Xv/Booq309EFTfSeX1WgXwgt3kOPR9WbvfwtkWYcTnpNels6CkvM2TiZBg7+0FRzAmExpl0o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461952; c=relaxed/simple;
	bh=sQurFjBE9L3fAEjeupv9dzjJcGbx0I4IJJjL3X9WlHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RB3hQRwfd9qnlsp12X37Z39RYXD5BcfHhHMbLG6sQRTqvC0eNBI++D0Q+4JXHe4aIhYLEfpP5oKo2pwAeNSOwn/qvialcE6J9/yalUmCunHeX5DtAkzfCavEey1Ye67HsBv3ViSQxKTXPLLLfOBcI4S+VCe2zBHo+bL3qpfD0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KeaLQbf2; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-703607df7f3so1174755a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720461950; x=1721066750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYngg2/AvD5ABD/9akPCHM96QJ+CMJBmjqIZiNK6u3U=;
        b=KeaLQbf268m2mnCh//+CQ1tbqfpeXynd5ZCLBgYHjLnUM5GzEJonArueM+iKZH184s
         Q1AmcFw9bP/eZZv5vKZ6mC8NuUUniwA/VT/WHFxAKWmBXjRq2fYKbtVYdWQQz2c+giMw
         Y0vPCnNW1PFopbFP6fhwEmvFIGMQL0YU9WUXAvSpwkRhIqyY0AMBQHGj/gI1HktKtYLU
         SqFSwrCLCG2FP6uJV78fNnsKvq8RgE5nT8vB92GgBiaYRgwfqn4qTOATCSommvZ/XtAH
         LX4lHySvrtArDPdmzcBPo5QDBIkBBLUWHnC9Ufb8ftEw0qWKLIrRcLr7kOd2H2oHrAWK
         v/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720461950; x=1721066750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYngg2/AvD5ABD/9akPCHM96QJ+CMJBmjqIZiNK6u3U=;
        b=V9L3JN5QYwx3iA4PF9JOcABgOPu8br1X7WjjJ0JPsmAU7TSxvlOvyUhTW1chkE/F9W
         VLiW5C57sjL/qejsopbNeBayvv+I5uMSl4Fj7jqmE99O04xavm3hEbpNi8r7cnV/Kr9y
         Xarfc8z2APSkGAdxdspivnGJAhymytYgo0VXF34fgUmrENlyjyq5c03XO6sHbfxZNG3/
         /loM9blLKSJuFnvbzry5msSDesLLsh+qWGp7eITpbc9Z/fXW55AAfvlEBN1EZ3UsxgYc
         kjtuXO9UcEyn+6jA2MMyJwZX6B9JjQTBSY0n3X2NqXEoesQ97syTV4gXsLh2F7D8TOfK
         r6qA==
X-Forwarded-Encrypted: i=1; AJvYcCV1iPsFeTmi39K/XvZRxM7PinnSUBPr3ED1qYbPP46Nu1FggMI2KZ6UG68GZPRHPGH0YGFHVpJtA3+rzToG26et/T0CUkez0i9wbsiR
X-Gm-Message-State: AOJu0YwlkGo7+Cfl4ost7+J+LobA3mQdoZIhepC9ot6yzo7zwYrlwwwS
	5onlKi12FlPAP4FDJbwCYOw9/IeOWqYl6YbJ+Xle/4Nd7cyRaRVSVX9oKEVK/Tk=
X-Google-Smtp-Source: AGHT+IFotg/OqzVapLsDoyFgjgyedblYoClmUMzMboNvrP7Hf0zFKYNPw6ZcbTQzYlbt4UCndKAUOw==
X-Received: by 2002:a05:6830:91d:b0:703:5fba:5e1a with SMTP id 46e09a7af769-70375a0512dmr309192a34.9.1720461949870;
        Mon, 08 Jul 2024 11:05:49 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:cdd0:d497:b7b2:fe])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f7a2d3sm86559a34.32.2024.07.08.11.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:05:49 -0700 (PDT)
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI: qcom: Potential uninitialized variable in qcom_pcie_suspend_noirq()
Date: Mon,  8 Jul 2024 13:05:38 -0500
Message-ID: <20240708180539.1447307-4-dan.carpenter@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708180539.1447307-1-dan.carpenter@linaro.org>
References: <20240708180539.1447307-1-dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch complains that "ret" could be uninitialized if "pcie->icc_mem"
is NULL and "pm_suspend_target_state == PM_SUSPEND_MEM".  Silence this
warning by initializing ret to zero.

Fixes: 78b5f6f8855e ("PCI: qcom: Add OPP support to scale performance")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e06c4ad3a72a..74e2acf4ae11 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1633,7 +1633,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 static int qcom_pcie_suspend_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie = dev_get_drvdata(dev);
-	int ret;
+	int ret = 0;
 
 	/*
 	 * Set minimum bandwidth required to keep data path functional during
-- 
2.43.0


