Return-Path: <linux-kernel+bounces-550765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3313A563D2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB7F3B03FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705420B1F3;
	Fri,  7 Mar 2025 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDsWTn4q"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DB120B1E8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339823; cv=none; b=kiL8KqvcnYUrsNIdXMcKI0RAzxV489U4u11l3ylQ1pFWUc2NQu9y9wj2dY6tJVKxlSEdQ2lXAlYWUbsN+nU16yq2gqCEkOWe0sLCooH/qIMm07LuGI4p7RbsPrC4yBC+qoy0NE0VEWS28fQXCPUZIUV3SIj8X0USYJFGdJViHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339823; c=relaxed/simple;
	bh=Ai4u6jucrFJEo5fiJus6WWtKhesRZx/NrT2YEqPhK3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dZiV6Rdy9nWorVBKaQ4G8a+2nCJhjD2c55oqQ0Uxl7N2BTUYmex8jhyhVsPs29idBKpxPN5faSoQ1r4fETe66Xdf2zo94p9qvvEkhFpjR6n+pci0jH+PyGlW0PEn3nGoqCaUcUfq1oR4U4g7KSmfK+RvPbzGsZprO+N7GgcPkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VDsWTn4q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bbd711eedso12523785e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741339820; x=1741944620; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=93blEQmxjswWheyXHKesIB+wQzCMQvJ6bucP/eSHntw=;
        b=VDsWTn4qx/JCgvdN9+TYPTjaj1IZ+ww8uk5lWdsZfzUDSYO35B0i/UrnmwcpGuLlzq
         stNmTrMd+H8HdhIhGKIoIGCBBd4fM5cqfXSnHoZKmOreAgstZJKAwfgq5IpJ9DxjE6h2
         wcVK/EVXam2bnd7hN77O+idKL4VPLZeuhOyKx35EQijix/IZl1uqMnJrwZWDINkCQEi3
         1CacdI896HKUOHOMs4B/DupEi4O2zManKuxUt0dQh9s0qA7aE7eUap2T/iqT/j2h4peA
         tgTt1BSqYYUZlILhzX41d/Z9Lg5ajWUXVKBwFf0MpcW+F03WlcNqOTGiW+MAgedH5uJb
         bX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339820; x=1741944620;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93blEQmxjswWheyXHKesIB+wQzCMQvJ6bucP/eSHntw=;
        b=e5HdyYT8E2W80z1JsanggVouHruKa+ymXDV7DHqXA638WF2wP2pWPESwFjFPHW37gV
         8VW39FvK11FTLdOKKY2yrLphRg9yk3PKwzIWmW/JFT4v3sRoaAq9VhtFsD6OUSnZx73w
         SVUkufQYH1YJjKZBn0oXAsaigEk1Pn5w02E6/eZiG1RQqd18uoGWvoaTIUMNsQTMXNlZ
         HAzItzwIefiwxE9sMNNq3Zn9YXmojq/gd1Q8Yp3dMPd0AxRZk7r+Xa8ZZxiJ0eIFvYlp
         +HhLdYzqx2d9JKUvXM5zp5bhNq3ni5k91Nj7tKCTVQvv56HE5nE2cO0O24NM1jBmbf3f
         8NCA==
X-Forwarded-Encrypted: i=1; AJvYcCWSiIgE/WtiAbBiXpz98LgNqi4ge/lPmnnmvJKlVIba1YBl4KYT/JQieZtq07zPCEUlko8B+G/qofDyrcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyemlN/TkkihuEK39Lu20c5zNkAI2A5BJVYxaMs81ZSMOtxc15X
	3EKDxfa9WCK5wNqzP+57M1KWCigf3nayehEBbN59sNo6qoSxua8Z2xyjyMaVVjw=
X-Gm-Gg: ASbGnctdY1dIKZ+uTxS9qZKyqsekJL16Uovr3u+GdZhVKS2mhcY/2TczLDPkKSQJL96
	1p1r2GEJX0oMaVHp+ilnMKd/ABgnKy0zX4dzmkBxvZmjRPlxsDXx7C9TwSyBEXbHtkEWkH8lFde
	vyovtyYxPO1l+3eW24kcfiwZL8u9NPjJ5kmCXy6hEzIcqpdWKe06czJhOGvSobYz4GHJxnjWuxe
	0e7c5c4oQyqWnEyEJGYFa2MGqGjsl+4VQIgoygQgFwUD7mU7twzLRMsLOnpqGfJKjKsqW5eAoAE
	CPV/pn2zqd9xCuPCzLhBrJCWB0UZRQfQC+Gpd0i67Ei4e8U3hw==
X-Google-Smtp-Source: AGHT+IF7W0BZOmIMpa6aTO/bUCCYodrmELNE8zettIHxeBxOTGRaV6zmqbl8WqRyoPh3IyqfSxwMVQ==
X-Received: by 2002:a05:600c:8a8:b0:43b:ca39:a9ca with SMTP id 5b1f17b1804b1-43c5a60e07amr22236695e9.16.1741339820010;
        Fri, 07 Mar 2025 01:30:20 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfdfdb9sm4709196f8f.27.2025.03.07.01.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:30:19 -0800 (PST)
Date: Fri, 7 Mar 2025 12:30:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Dingxian Wen <shawn.wen@rock-chips.com>,
	linux-media@vger.kernel.org, kernel@collabora.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] media: synopsys: hdmirx: Fix signedness bug in
 hdmirx_parse_dt()
Message-ID: <7ec94789-305c-4de4-b477-c0eb839170e5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The num_clks is set this way:

	hdmirx_dev->num_clks = devm_clk_bulk_get_all(dev, &hdmirx_dev->clks);
        if (hdmirx_dev->num_clks < 1)
                return -ENODEV;

The devm_clk_bulk_get_all() function returns negative error codes so the
hdmirx_dev->num_cks variable needs to be signed for the error handling to
work.

Fixes: 7b59b132ad43 ("media: platform: synopsys: Add support for HDMI input driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
index 4ffc86ad6c35..e0d3fed87a92 100644
--- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
+++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
@@ -154,7 +154,7 @@ struct snps_hdmirx_dev {
 	bool hpd_trigger_level_high;
 	bool tmds_clk_ratio;
 	bool plugged;
-	u32 num_clks;
+	int num_clks;
 	u32 edid_blocks_written;
 	u32 cur_fmt_fourcc;
 	u32 color_depth;
-- 
2.47.2


