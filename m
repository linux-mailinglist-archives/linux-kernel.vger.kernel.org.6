Return-Path: <linux-kernel+bounces-426168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1D09DEFC9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBCE163873
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99900155CB0;
	Sat, 30 Nov 2024 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJDwtJWJ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86414B97E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732960881; cv=none; b=CbMyZ18henfmwKf0DqoDN8ZDntQ2kRCc/FQJVS23pZgFidQazRgUSQqieZ0pNqJFFbDrANHSR9sXSRCqUMeWR0FLasO7EH8+jBc72oSuxj6YcZ1t28xgjdFOBrQG+BjD8CgP2pC+XisyplHJ6b2pl+hhnY7LtwtqYM163VkxPdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732960881; c=relaxed/simple;
	bh=pwCVrSo2d63QozkbYlTrgoal5OaXwx+yCaGWKkdfnss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cp2EnJ/8FbbqdobwlBWxCaKORxgMjnt1ypnWTGr8lJHmp7dkAV6SOvcEleaM/gFX77nYIP1uVV6+7hBcZF3mNb6d48fAB0cXROA7UvHBwXbXdI/k/cpWO+V27y92AmZ5JgtQvoKVKDXgPbzfZGrR2PSguwhjaWcFj8ByrNyUmBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJDwtJWJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cfc19065ffso2973727a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732960877; x=1733565677; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aK0dV1gfejvgX5AVRAv0AO9jA2ssYUcI54wSBwP2RLM=;
        b=xJDwtJWJ5nVVYoF8BeAwKwPx19hTzgGsYMyVveS/HUx/+9EhIYH5A/O1785udRsVQe
         AMUgPTTC8wFIg11nGNEPm29CLucQOHlZWF6CaserezMgX9bMvWBoUoNCcldIi2m3Sxva
         s0Vlif+LVIFuiamCOKtOPO9u37LmTIiu8HPte1A86ZgQPtVPjyuHvBoTZck3cOYfh5As
         PowTScUTXytEOhD9GNC5CXfPs9AyhTbFsvMk1jbHGg/deDV0MhhNEYpziiF09MSb6B7s
         Mx823j+dqBIkBVwLJfwWlAAC210nBtQWZy1IewM3Z4sXY2vg9CsvPZ/spqHsV+rx+CXl
         WkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732960877; x=1733565677;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aK0dV1gfejvgX5AVRAv0AO9jA2ssYUcI54wSBwP2RLM=;
        b=Z9rlabRpGinrvThlCPApW5ag8rzHKZwCl0XCltGsoQZQtDd8GO73VeXxZZ6vVYJRiM
         O1q1RbZ+SUKfotq3e78lThSk4Wr/Hg+OdS8eH+GiP34T7jT6nsaH6wNJuPUsAgHOJlgz
         LYerA62E72sSSuaYSvaTt/Z3bPIQ4zWEKx0KgqlStYsIpd7ohSgG7Xk+VXbJX70XGEZp
         po7MKjh7C61dg2IA9qyM+x3lAjdPx8DuH388Kzn2oO9Wq7eLF5+ufZi3Q18oxusmybvX
         Nz+l3I2xNLgutcSWgntjkOyjDx08t8q29x0VHcnyOAJTSRB0Fvk5SE12rq6+FlZ82KYP
         +uAg==
X-Forwarded-Encrypted: i=1; AJvYcCXpaRI9CMk9Wd7oaNHh7e6fmDP5e1VKBDTlHO9kr/hpnj6x01uaUsgGkPgrLwGJjyrhfhX7wQcFB1Samh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIu/kFBi60PRUK00mdhYPQ42z2mm6efMLqFSQjB4OnscB8pIzY
	rHjDuTYbo0Ihi9tTrguGcJHtpXAcjr1voKDk/+oj6mxa96NaCnOQBY9vB3PRIL4=
X-Gm-Gg: ASbGncvzbaiiDzyzdw+OklZqkgfJRL3PJ9AM33fwodPsijQFgQZDHXTqtkE/scPqh7W
	stshro4xrx6ZudoAmdCYVfQhLHKqltndRaUnopOB1erRtdfmn1s8PWcJZ5LzsxwR0GZbbQImeVJ
	0Gu7/5UbAeRY/XYlL73O14WMTvw2pVQNjo0uwVUPwQa56JEiPnwF8h1mrBKyjD+GF1WgcYhKPlt
	RD7OZvZ1XE0rY8EtBGPnfH12D2y32BXbagItkN6hz1BoTXpL5WORInyD6Bf2RrzyLp5vk2u
X-Google-Smtp-Source: AGHT+IEtv6gd869K+dRtqKZE6OGZWNVbaOzagbrsUDx5xx6VOeUmeXvzJOk8eFEsMgnWDlwVcluldw==
X-Received: by 2002:a05:6402:2116:b0:5cf:e3cf:38af with SMTP id 4fb4d7f45d1cf-5d080b8d46fmr14459310a12.2.1732960876730;
        Sat, 30 Nov 2024 02:01:16 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097d9f5fdsm2670060a12.15.2024.11.30.02.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:01:16 -0800 (PST)
Date: Sat, 30 Nov 2024 13:01:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] PCI: rockchip-ep: Fix error code in
 rockchip_pcie_ep_init_ob_mem()
Message-ID: <8b0fefdf-0e5b-42bb-b1ee-ccdddd13856d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return -ENOMEM if pci_epc_mem_alloc_addr() fails.  Don't return success.

Fixes: c35a85126116 ("PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 1064b7b06cef..34162ca14093 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -784,6 +784,7 @@ static int rockchip_pcie_ep_init_ob_mem(struct rockchip_pcie_ep *ep)
 						  SZ_1M);
 	if (!ep->irq_cpu_addr) {
 		dev_err(dev, "failed to reserve memory space for MSI\n");
+		err = -ENOMEM;
 		goto err_epc_mem_exit;
 	}
 
-- 
2.45.2


