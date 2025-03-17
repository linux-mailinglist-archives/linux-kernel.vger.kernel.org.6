Return-Path: <linux-kernel+bounces-563446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D2EA641F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B551650CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7192621A420;
	Mon, 17 Mar 2025 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWIlz/4N"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A64B15382E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193796; cv=none; b=k0N9w4Li1LaUjM9cU1pdk61AgH44KqQkfncFo9+iqVaHKrQKuE0oH42sYWP9ouw6iSmHUQAg0r1eRNNgMAQAzdmAKHzlRro7OQwP3bOM3E6t3BM3ALFgbLeGuqYpt8co5uzYsErQyeS+K6cX9ojjefgGlf59jsjcE5F28OsRnn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193796; c=relaxed/simple;
	bh=i71WKjub0uG0+Ui9Q92aOw37mAkL9kfGbCp6bztHV4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gWstzB+h+RA+lbMEuSmk20zSdIRSpqgRIY708kxPWKOYXJI+9CO+ax2MRsGy8BtE326hhmuNZ+gfNeImZK6/MPLnjhY/xU06K3XTwMVTRkx+indyVZmCP4XIVS6h+zk8+LlQB91Z62KDAUprx2nRHF4cVCRVPxxXZWq2KMVM0Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bWIlz/4N; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3995ff6b066so535200f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 23:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742193792; x=1742798592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zYZVPweRynX4DyzyYoh+BnMU6gj3wjwqz97fLhpSHg=;
        b=bWIlz/4NNRhdlZHU247mbma+G8yAGybH2AIEG3aXjyp1RpcZZdOy+W0zBsZND0etmW
         2g8DtOfwci+BW5fkprb0JxDsEBXeyJWNy0GoPnTVj3Ihs74koHxbl9L5yz3cA1meqfZ9
         OXTIevyrzGr8ovcnCrDFD6ZvCGEIBphsOjtvi4jCocvQQuJK4PSkbq0crpDS/nAePTVP
         sbL2Uf7wPjsSrgoctiqdnMq21LROUzEgAGkteE351mmF6Ci5IMrJrN7GZ5Czk0dLEW2U
         BMNKWgKikJVEuIyr57Z0D5UfP1OSMitwLsYJh8+p7HiNupz7uKQ8Qkm/wV/sTbbeVi2C
         HtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193792; x=1742798592;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zYZVPweRynX4DyzyYoh+BnMU6gj3wjwqz97fLhpSHg=;
        b=lMZZ+CieefpsKfK2ZokYlIsnBBRfwk1JSpw3lz8VMUfWGVvd4BiiTkGseD4auhrKW5
         5nYntefnCWPBZP0cA/WH8Eu3ame4nHlcZ1JI8U4kQbjtIdDeGk7ROrJd4/WOHTyNkhjN
         FPX+QdwIDoSQdQsdO2FHzwjQqKI/tWUh3pirorlW8Q9y/hK9+kHB3i43t4UdmiLE6xt4
         QyUJ4mwAmcUf/WT/liUF3vZZ3rLo36EOZHkr+TGta/2glrqVJb770OFoHzapK3wYWz9x
         W/ndKSR/M1TtbXQOAUd+OpV5qket24VbApzU4mUavzCAv5eVYJjWwzxWquy4zeT1lIot
         o3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCCjwQfDfOldncFt1vTqtcgobBNHhGlmW/h9784wKxgyDLEUpce5e2xoqnxzY9TFAwKZLycfE0kLZPHDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyobUWmbn63nw8FZ+b+WXkH+Gh/ZSUOZ268AGFG7B91831OZrHY
	yRd6H6QR6t1eUaSDzngUP3qLa2M0gTPmUjYUUG7r1JH3ic4jx3oGMYn1joLCIUc=
X-Gm-Gg: ASbGncurNsVOc9T6/+0GWYp87MjweW/sI2WsrY8oFEk/MINitYkvH8D7Su/oNMsz26L
	sG64mK9Yz6tTYLgjOUg0+ZlXhB+/27qTKbavTpRxB3hqKeDED2ggCPialCl8w24Y2PQHi5qO2yi
	yhf9oUeEYx19wM6QFGS8RYOy4F8UYhlB/A13K9NVe/Xmjlxw24FgCAKZ36qh5ca4X888MjfFGFi
	av4I3Q3gl4iWl0LFUtK4qv9qeJqGuzgdvMZ07Y/cRZBh6YgX9lEeqJfTb2AyIqZ1P7dIE1e05XS
	vkeEHdzwx6/h+3/qzO8zKU3K+nPIyh/wnzF7yo3bY6TTm6PZGA==
X-Google-Smtp-Source: AGHT+IElbtx2TAWZbzDNN7Ov+FaGcRS5ExJpOr0ieMaeHlcgQx5UZbMz299N1BJzxKUjSd/nTUx/6w==
X-Received: by 2002:a5d:64ab:0:b0:391:4674:b103 with SMTP id ffacd0b85a97d-397209628f1mr13971307f8f.39.1742193792478;
        Sun, 16 Mar 2025 23:43:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d1fe658d4sm95398255e9.33.2025.03.16.23.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:43:12 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:43:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu/amd: Delete unnecessary NULL check
Message-ID: <d9e17a6f-a8f3-4272-91b6-0ee7e7808c8c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960a6d1a-63d6-49e8-890c-5e8a66e50c45@stanley.mountain>

The "iommu" pointer is always valid at this point so there is no
need to check for NULL.  Checking for NULL triggers a Smatch warning
because it's dereferenced without a check a couple lines later:

    drivers/iommu/amd/iommu.c:3200 alloc_irq_table()
    error: we previously assumed 'iommu' could be null (see line 3195)

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index be8761bbef0f..ce2626801ddf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3192,7 +3192,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 	struct amd_iommu_pci_seg *pci_seg;
 	unsigned long flags;
 	int order = get_order(get_irq_table_size(max_irqs));
-	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+	int nid = iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	u16 alias;
 
 	spin_lock_irqsave(&iommu_table_lock, flags);
-- 
2.47.2


