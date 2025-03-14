Return-Path: <linux-kernel+bounces-561174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E560BA60E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3578E17B596
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7781F4168;
	Fri, 14 Mar 2025 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYSZJ0Gc"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0251F236B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947022; cv=none; b=NSHjxchyt+aJUpag3VMS2v/bjvAuIU1VStrdBQpglw4+mTZKm70ln6rEvu8rduJ6aks5ZVukTDejgKdjveqbb4du1FD3rKkO/Vyr6zH2ndQUuwkteNY0w+x4uzTYHeIFtQbptAoqZMQB9iUbhUgHSRiGp7mjAj+O420swtGk1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947022; c=relaxed/simple;
	bh=npAfM/D95DLWrhMgnpbK79dbd/8CwbndFi8Um7n00Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tVOEj7lE7FF1cU/A7lq9MVr92lIV6x38s4OP6oA/ZC34qYIOxBN/6YD6JJPEI9JIZxVk//3RwTx1Vk1bY0INh8pJRetzg+I97iAa58kyJ1nEGBwuv2BC4MxGLU4aisB3G9OpLNRm/6K4puQ4njUoRCMTQPIH9ZaY9CRtkmDf9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IYSZJ0Gc; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39130ee05b0so1891759f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741947019; x=1742551819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHBf1AZS6BuzpUz3+oCl4k1y+Tt83Lx+NAGAApql9uw=;
        b=IYSZJ0GcC4Tt/T1mE/KQCrBINIPgH6b0TK15f9SvL+ESzUoL1DBQUBKtE3DawSce3R
         IRscePDvLL90NWvTbDJiMcCrzHNbsoiMN69NkIcfrVNNW0av2UdoxyxMrlJ+yueI3Aws
         L4n0PivRAzaMA/bI1ozolp8JFstkefxob8li+i7o4fjKcGyJ+eAQmCay6lq5joofcbKh
         Ay2xGuXglzd6ijL4wdb3fQa6O6dRJpDa3uVAbGWYFGl8l1y1kVtijREm5GJMX64cNqIg
         bXkqJfYvCrM7IcuWXd/n7QdwZd2ly6YJayLFnaZ84h4AJwXm/59NuyjWAF0VWzjrxOtc
         LqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947019; x=1742551819;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHBf1AZS6BuzpUz3+oCl4k1y+Tt83Lx+NAGAApql9uw=;
        b=nD1nHhPXTkGt0gApTbW88nEgFbCex0S6nt2Css7K5xtn60R4la9kJ7R4OUQjERW/BB
         ++Le9OR4gf0H+YqnTr0WTBejwZmAX0Y3N+crvadiKvWxHr+YAa8qJw18M7QvqMrvaYOB
         Y9bl5NzzDUVDpEw/PgeOEmrP04R9B+XVrqOpHgbaVMa8Fl/QPo2b0SJ6sqOBVtmBiH/j
         38kDfebc3qBSWbrZ876SJO/fQg0Mg9FilfxakH0uZB/pOm7DTJzLZfroPOZd5cLaY0hd
         wVY7BU4GGWltwJe6EBosbNDiQmxDGz2EzwsxYivMmDcsrFCBws/jom4nZdFf+g+HCKC7
         xzfg==
X-Forwarded-Encrypted: i=1; AJvYcCUS6NT7K+U2QIkUInL0eYRHfOVBlf3uttqJ02P+UyzI3wpmxmzvlAdhQbJmJLPYfSUscQQxDtGevSRj6sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1g9eh3Kl/8i0JfDd3PoC0K8i5wYaxRkXC83Tg04wP6i2R2l9T
	67UOvxJo8RupyajTow/iCJPEf0MOVUP/L5+5CM8cZikISb1c0dqx8R1qfZbKUytObA+JsBvvYng
	a
X-Gm-Gg: ASbGncvwNVBnKmCU3+nqDS2hsYu+17O5HC+Wfk0GuiqHqYehxEeGyjuHmc9Y/EUJ4FI
	ALXc3Nune7oDbXP7+lQd9R6FCj/BZtNTcyhLV9TBoNGKXal68h+bBkQSEKEabvyYoj3k1zRRuEq
	j0kO9t7wxe3dhlJHxdflw9prSxH9JZmdbXI3DJzrNB9PzkcMWkc1tGQC75wGPcGaUpA557Cj4FM
	eZtQAaJdW6C2GdcHx0pWHHjiqVtT8SBX6gbZhfdIX8j+U2063D4w+D1il526zl2DEr/PgERzjWA
	VLcUhMZI+dplz73Q3/sWsZ/8dOL13da3zK3FbIAIk4jQtALFiMVZvk7CvqcD
X-Google-Smtp-Source: AGHT+IG1sxTE6WTNjzIQp91HxiQTObGusic65wZslfKY6Ot3KoscqKikKk9/AjhiDq2kcsqvmeb41A==
X-Received: by 2002:a05:6000:2a7:b0:391:13ef:1af5 with SMTP id ffacd0b85a97d-3971fadbdb5mr2747764f8f.48.1741947019105;
        Fri, 14 Mar 2025 03:10:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb318a80sm5127616f8f.61.2025.03.14.03.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:10:18 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:10:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spi: sg2044-nor: fix signedness bug in
 sg2044_spifmc_write()
Message-ID: <4e16e1bf-e5fb-4771-bc92-c5cba9aac473@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79c71b81-73a9-407d-be6f-481da27180bc@stanley.mountain>

The "ret" variable needs to be signed for the error handling to work.
It should be type int, since it only holds zero and negative error
codes.

Fixes: de16c322eefb ("spi: sophgo: add SG2044 SPI NOR controller driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-sg2044-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index 454153a63b42..baa4cf677663 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -216,7 +216,7 @@ static ssize_t sg2044_spifmc_write(struct sg2044_spifmc *spifmc,
 	size_t xfer_size;
 	const u8 *dout = op->data.buf.out;
 	int i, offset;
-	size_t ret;
+	int ret;
 	u32 reg;
 
 	reg = sg2044_spifmc_init_reg(spifmc);
-- 
2.47.2


