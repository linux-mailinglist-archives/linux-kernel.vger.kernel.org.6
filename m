Return-Path: <linux-kernel+bounces-547106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FADA50316
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A0B165225
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0928524EF90;
	Wed,  5 Mar 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4XQwnFr"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B179724E4AD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186814; cv=none; b=JqsquwbmGCgX+4PWpUw6W2jIIql4A26NvK9AW01WchuNkYAYaFXqhALdN4v2l+AwaL64St/G6CLlzWNBLsr0yJczwYhTzM1Ch55DZm/NuglrKwkTCf5xaISMWcwzT6wkbzW+4onAqwvgA2HOyX/B/TCKzeo0M+AfjNBRyf9q65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186814; c=relaxed/simple;
	bh=Q8DJ8fiTmNjeP/+2ks1wRurrJfcRDgtOToR7IsclVLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uBVOAyMMNvXEvH/kZzZcgB6CPSkG6CwgMmEKKFXuMMvpy204u8H+zP+gcucNCvDgSK5JyGAtkm2/3XOii8ofqPLsAQJ/2ReCagi369VZfTeEK5uY5Aq6iuy6JHp1XAAiWKyasW9hRJ+5rpfhj7SjxqFGzo+/I0LmUCNf90kPUsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z4XQwnFr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so33250195e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741186811; x=1741791611; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bXn+R30pfqAeO+ripC6gzbXJrYwc26V6TE4Knds++Rc=;
        b=Z4XQwnFrXlxKwgfpMtsWoubHNjl00O57875c1XTaww2fGik1DcTZoywAX7je1NLgAC
         WOPcwwKvMA6AVMesw7kZqb7SGR2mzfkQqaWRaVEVCpsWwrkJgUvcWqydEqOIDP4HsRKK
         0wDVjHjlqxtADqXOWjLWRAcfiPnPQ3q6be/iGqNvN2tbM3TzFAwGYNWkKZi0qnV0UYVl
         sixFDr6cYoh8c4D9XvyMALvvml/Z5Uy5t1PvsFqxbRDUbQbUmeaXbXODTOFDmhzeedgh
         kxSgBvzMWDQ5BAv3zFOI1GLUQkaiVE8kilaP6nIr7CcZwtjZ08Ayi0HfaJYumXmcrRmU
         2Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186811; x=1741791611;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXn+R30pfqAeO+ripC6gzbXJrYwc26V6TE4Knds++Rc=;
        b=hAjlYyqvVtCeEdr/lNvhLV+/4r8mbSa8imixU1aiUwShPHo83H7lJPSRwaYQJzdtL+
         0kfaJGr5C7ON6Fqs1Q2yHJyuuTYAsqxgYSTEYUhRYCGSO96KKNorWb4VSgz0hDEi06jm
         iWMo455RAnSeCKaRVABNsNehMd7EXSmvaC/1l16T+cKW9mnd8DYGoNprf89p7ck8oTvQ
         1lb4j+jxp0NBCG0M8AduhUy3JgEOMuRuZVq68yjjB5BqY74lVIauNk37tUd/yfLgmyPq
         VexLeVNjjATqCJ1ycbUxmb6qpv5rXlj059KY1wndxUmZQW2219fWh10X0CMD2GXV0Xjm
         bCXg==
X-Forwarded-Encrypted: i=1; AJvYcCVa/Al/Itoa7TU3qE6QHqOkZcc9DlcebssxPoeGBHgIF62ZItmdjtY7ZJKqvd23j2zxMl9e5Xs9A6t1smM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz35N4YDc3EgGVoSFnobGtQyMpXpAR+jjnqw7FcnSysZMKcnVXy
	Zuh4onvsXOKYuc9TCu+QJAzkPyJxTS41BhjfO4rwSho4pj5yZJmJPc0UeKkSDpo=
X-Gm-Gg: ASbGncvBB4iyvYQte1yXjB2TconB6DpsGBCe6/QVun5W/z/kKPNe4zS4Y4fzda/zZ6V
	I6TIfBq+fY8HPKmJOU3KWzYNBDUrfYaEHy2Ac+DzOiO7FpOdRJa1uHh1908C2Pq2OTeM8undHR2
	2k8AIRWs3uUBxJYdL+iieCYC0nJudMgM5wHQvGBLky6EwK/jxceTj4IiKbkkPsHd85Aik2YDoXG
	JwD1SYuPNgGVQ7VVJKX8kYkPC9Moc1+/kSGvnrX8BFYEILeHsdXqHEJ3e+MSy/y7mt6vicXYkcq
	sg0cO5jJs9ePmZvC+Lcr+BygD2OYWwJhLBudLS6cdwS59rSrcg==
X-Google-Smtp-Source: AGHT+IHwAOMpL/YkvcIgyvX6we6SxWByrXnH2O7kDqMIwc9Mimc1XxnvaS/gUDf6T/jHttMfPf7cPQ==
X-Received: by 2002:a5d:59a5:0:b0:390:ea4b:ea9 with SMTP id ffacd0b85a97d-3911f7b7459mr3110045f8f.39.1741186810870;
        Wed, 05 Mar 2025 07:00:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47b6cd8sm20988561f8f.44.2025.03.05.07.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:00:10 -0800 (PST)
Date: Wed, 5 Mar 2025 18:00:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vidya Sagar <vidyas@nvidia.com>, Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: dwc: ep: Return -ENOMEM for allocation failures
Message-ID: <36dcb6fc-f292-4dd5-bd45-a8c6f9dc3df7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If the bitmap allocations fail then dw_pcie_ep_init_registers() currently
returns success.  Return -ENOMEM instead.

Fixes: 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure for drivers requiring refclk from host")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 20f2436c7091..1b873d486b2d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -908,6 +908,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	if (ret)
 		return ret;
 
+	ret = -ENOMEM;
 	if (!ep->ib_window_map) {
 		ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
 						       GFP_KERNEL);
-- 
2.47.2


