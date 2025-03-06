Return-Path: <linux-kernel+bounces-548578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7C4A546A3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413D51747D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DF120AF97;
	Thu,  6 Mar 2025 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rXPt/AWs"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EF920AF66
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254008; cv=none; b=f9YvhMge0TQl+4etMUcDa7LrDKMrCb2XW+3zhWQIS5BfuE0/ILvSVfGmM9pfQVgZ07EfJlzIVNpoYJBuq2E+w1OqLrg9g63HW+lXOlY0eRrN9GDgP/zxa7P7lBROH1gckYLpe/N5CEX9Rx/tVaeEctM+B8/tSmOWlksRCbhFBi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254008; c=relaxed/simple;
	bh=E/HLOCPPolZoPIVQBIEbh+eA5DoNHzTGqfwY2lcY4Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YX3p4ZHAYk0Zw5C1IzJY8zoyk8kL3pKVJhrST12DieBY3j0HbXZrfccuK5bVWmK7ScqO74YgPvM9q5nsM3mbPfez+LCqoTvXdE5NPzdXCjU2+6m4OuuNgHgP3Mu6HeWNWautntpseybT5KJo56TB+JObCtZ3CXB+VUZYFzNSf0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rXPt/AWs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bcf9612f4so3465675e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741254005; x=1741858805; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWy06ZU1rvCMAS6Oepxaxa7BjLic+0Q37gto1sXjZ9k=;
        b=rXPt/AWsMZ0Il8KwOaVhoEFc4GfGV0PlcibBlNgGO8c4PeQTmcI4FydM2T4nZuHwU0
         9yfK6GPrOXOL7NeREfkRq84YyBdkbt4Mnd6QpmUzQB5JXOAWvt2pXbz9o5GMe10R+B8t
         awnw1wtMZcLvBfml957K2H8SN9viqEMbSooyLzH4+q4hT3dzGT+eSaQ7dtzgnf6wI9FC
         H6hHvOQtsztSLIpk/Cn2Qg/cI1aBqYQ9FfBz3Fk9maxhESDNVfbeauXWzCPxQ//h9VkE
         6+YHJMQheYgzqK3G40qg4q/lhwu8Jb4vmSOJbm7vwoXD8C4lZMNmtmxVnz2NmEoV6kYt
         Pu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254005; x=1741858805;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWy06ZU1rvCMAS6Oepxaxa7BjLic+0Q37gto1sXjZ9k=;
        b=Xo1q/i0Za8IvySf3kx406SvzEN0jCIriUCjUSqfJzBA4JGnZhhqC7LY88CGlx9oAWU
         zLuTKVVjbxa3s2oe7rEEEPuCNf9So0CbkU69QqarMTcgbbPjDejcL3A6rpDqoGaNVMM8
         RwuDgVOyDLqKlUNQk2xFZ3dtuITJm+LgK6CLoff+GoVkzT3L0l2L8NkP0zBrbGker7xe
         pl0iecrBi4DHT6ykXCXG7C2pcQ03RtRmYbdkbsjy+7ZWkvmB5tK+EnZncKPdxPpTJqHn
         7Vly91CoASkddgLSSDPQLlIt4a7T/aQkuKOARZ9LnYjX6jGBB9q5ehjBihBadkOhqPoz
         57Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUe8OyHoMqfexWU0gVbylTVXrRSy3c7QlqkUrsq/fm8oSGsV/jR5guBMx8U/HiJ1jgQ1DHN4Q9cuSn1B8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7SZOKlEKg06foCQtu2KxbslyBAM/QUeA2AGIFHDBLehgvlkQv
	yn4vppk7T9YMDZHxca3RJ55gX3nVrZdRjNt6pr7twZBdxeP+CRkc9NKKLE9BVow=
X-Gm-Gg: ASbGncvmxAVzJVkRN9SH1tunru2728haBC3Vqrl3LdMAfs7Vn2Njabp2kvmNfLHcwWa
	60Z7kIanX4lxr5s5CFbtZ8CxvgnZiTue/55wHAZbZLqNt2s0mmzhY03p+J3pxZW6AD8R97r9hvn
	0vnuyOGEXGdXuxGrxivQWEHBjVf9H8L3yegZhVXt7YqjIdiVitps0zMaVGdwYFuyZFbH/DCly7q
	+Q1x+yZs4/zd5pkMkzpJJRx3Trt8HrqbRLmkut/GpR3Lr+Wm4P6IN9ZsGoarxCVLnQNx5K+DfXj
	Cm4ThGv2Qv1F+te2RZZgnuHE9vPIVP32HN6gbcn9XP7uxX/xTA==
X-Google-Smtp-Source: AGHT+IGuGJLNcho++arjKdFrJpv00rKH3wDvZRWW3PMXVOeUD58q0a3r8mqAyfvuFDAa6Dfhm44YnA==
X-Received: by 2002:a05:600c:3ba8:b0:43b:cd0d:944f with SMTP id 5b1f17b1804b1-43bd2945f10mr63350985e9.5.1741254005165;
        Thu, 06 Mar 2025 01:40:05 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd4293250sm43986635e9.16.2025.03.06.01.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:40:04 -0800 (PST)
Date: Thu, 6 Mar 2025 12:40:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: Mark Brown <broonie@kernel.org>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: spi-qpic-snand: Fix ECC_CFG_ECC_DISABLE shift in
 qcom_spi_read_last_cw()
Message-ID: <2f4b0a0b-2c03-41c0-8a4a-3d789a83832d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ECC_CFG_ECC_DISABLE define is BIT(0).  It's supposed to be used
directly instead of used as a shifter.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-qpic-snand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 8c413a6a5152..ffb2b6ec685c 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -514,7 +514,7 @@ static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
 	cfg0 = (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
 		0 << CW_PER_PAGE;
 	cfg1 = ecc_cfg->cfg1_raw;
-	ecc_bch_cfg = 1 << ECC_CFG_ECC_DISABLE;
+	ecc_bch_cfg = ECC_CFG_ECC_DISABLE;
 
 	snandc->regs->cmd = snandc->qspi->cmd;
 	snandc->regs->cfg0 = cpu_to_le32(cfg0);
-- 
2.47.2


