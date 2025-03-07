Return-Path: <linux-kernel+bounces-551717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92A1A56FD0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1964B188E7FC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B319D24293C;
	Fri,  7 Mar 2025 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PagxRdx3"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F032417FB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370277; cv=none; b=h4GzENx0DFSkMQhYk+bqT9MHuy5LraEE6V9XL+hfJsWwsOrVUO8v4NW5A2Z1UysC3ODAeujWXiapp6xZgLjC4aF9qXxsB5xUNaaqCbaHjxAfqIHz5h2dMm+kQerqeROVHcFW2v8WXe/FdG2roGXr0IS5VadC9y7HkBsBhHDzqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370277; c=relaxed/simple;
	bh=pN/3K0c07mgtPTRPXPCJpX/AGnbpoFURyIzTH/nlVaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cM5RGKf4b1BJvXoS4PdmcHyytx5NbmpsQhTOPiP9lWW6VsKv9ixDcSc46zdYQHgChJCgedBl2J+FCB1kyg+hsvQneRXuSnvPESj2MTcK0VzoxYwOtT4pOqxa+OXDy7J/lsfmDPHeBC72MzO63OAOFG3P3B1jFG2iJZwUl5aDkqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PagxRdx3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so4018987a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370273; x=1741975073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r0/g7jMkIS31rWPP+0eYALjsbxAMAbdDJjBS2LpzoY=;
        b=PagxRdx3v9kjWso0DBB8OyMtWKreWZ3usA9xKZeW484Y8dg8hA91ZSGSkQ/LBhf/xV
         gn+qlJCYXbFEifbr8VMTD0lriS7pfkw+Im+cba7APYQf9cIcn7UCMwvDq1z0rrFRlI07
         V3YRTOtPtmW8gju1m8ZKCZdf4e7Cj5PsvQnKvyHhNU5EY36AqYhnedA2LtMJMN4kiaAf
         EVDGg8IlZB4WYLKqrn9jpZnAN1slj9uIHVh3ZUCaFRb5xIQIBt+y01IPnyZY+iOkos5o
         5KEHnTlwMQmQfrvZFL31uHNf7VV6z62xwpTrrD30WudHtUVBqy2sfAJQa1wUNtjRttSm
         VWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370273; x=1741975073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r0/g7jMkIS31rWPP+0eYALjsbxAMAbdDJjBS2LpzoY=;
        b=EmCEJEK1PgloES4PtdcDFQY+ETP8OjZupbzjVPgcZJlvS5AjFCeTaFzeWtJUVo5tLT
         OKLGAouvY3X8gh4PTRQpzbKm+tSBaNbDgoX6sIvc+bm0P4c+a+l9xMs/kSHJ/Z3udjiQ
         XnxxWCaj1RRiwcRh5CCvVAdgrLGVNh8503SzWTbjfe7Osqv+Nh6kz3EDxMjFZpq7BU/V
         SnTM2nvoShCm3vUb8qY758XSWyvWLb7KIA/sA7eBd2z0GFidn0y+DeejKdYiBoR/U4Zq
         pRRpJBKyTZMAFCO2XkPD7kNvrsAsysMzYyYmyIxNc84DmrwDnjkvheBAFpTcG27e0po1
         5rFg==
X-Gm-Message-State: AOJu0YxGMYBLVRJpPM054WbXMj2CiEPVCr7m5JTikGmJDg4CVhLuXz7M
	K0/dz+n+xY2JB4IMMUI7NgL+BXnRxKtOdmNJ7IeJjSa+SCxMDheoI7RqYqmM700=
X-Gm-Gg: ASbGncthurnz4tFa0Z0XDZkXXjgJdGEIOJ53Y3TOsMN4vFUptsdzMFWUoOW6Z8tIAdQ
	VFxqa1KwtqH5E8A0RwXO+MTlRpN26yTGpHbBd4tyTpr4kmetT/IRVyJkeDqNdwXD8BfmEvn60nh
	7yiiERQpYWJOBE3sIacJeJc17rqHb65ybD1h1mPt0nVyxf1WZl0+9+dEvTZSUc6A9k7HjqQ6IOH
	csJQv3XwmPwsT8SORVGPSdZa6emsQX3uSBSjO+1PQx6etsL2pkXMsJaa1B45/kLOmYM3ptUH55g
	jHlJmm4tj/CACvPgnVj7W1vl1u6M5d55BRjMaHEQk334w8wg4KqtNrQ2faVP49rSKD2jjA==
X-Google-Smtp-Source: AGHT+IG8xchqxA5bKUGvw4dLkZRUdmLkmbBUsHCHrDlBu4zH0oLl90mPIt/Urx+gq2R2YnZP/o3yPg==
X-Received: by 2002:a05:6402:3884:b0:5e6:14ac:30f with SMTP id 4fb4d7f45d1cf-5e614ac10ecmr662833a12.2.1741370273574;
        Fri, 07 Mar 2025 09:57:53 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:57:52 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/14] nvmem: rockchip-otp: add rk3576 variant data
Date: Fri,  7 Mar 2025 17:57:14 +0000
Message-Id: <20250307175724.15068-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=3Ys4IkX8eCFRNDyZ5cOnVGSBTrGSodl3ymtNu0NI9Wg=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN9zrcabPVsgwcqQzznbddwl7Md0kDIrrWvM 52dXNcO/WyJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfQAKCRB6of1ZxzRV N5t3B/9E4ZbQToEF0XX5g02dCRpJi/qLHgCTB0IYoxS81+kOoqKuSQxdh4UT+V60B65hGbAjOOA CtGy+vu888rEnqQHB4kYOvNQQXt+aqpmukfkDQEuzOFHWov74VMYNRBzhT32+jucDwBQAJGQL/C /DZKRZsExv/wx2sYiVcQXmsvSKNOKQAPuyha42gbDVNWjmHR+lYTq7J2J/4X1HMq1kPhc0MuUxG Fu5z50sa0o8xPHx5M5KV9Xq+DA2GFhMQ6akZSJrAILoxlO5f9EPns5rfhEJSD1+jY+siOdlbX8D vtPaM4rjy7fvzAl6P6tf+ciY5FuMSjCe60hTLVI1yqcx12+I
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko@sntech.de>

The variant works very similar to the rk3588, just with a different
read-offset and size.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rockchip-otp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 3edfbfc2d722..d88f12c53242 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -274,6 +274,14 @@ static const struct rockchip_data px30_data = {
 	.reg_read = px30_otp_read,
 };
 
+static const struct rockchip_data rk3576_data = {
+	.size = 0x100,
+	.read_offset = 0x700,
+	.clks = px30_otp_clocks,
+	.num_clks = ARRAY_SIZE(px30_otp_clocks),
+	.reg_read = rk3588_otp_read,
+};
+
 static const char * const rk3588_otp_clocks[] = {
 	"otp", "apb_pclk", "phy", "arb",
 };
@@ -295,6 +303,10 @@ static const struct of_device_id rockchip_otp_match[] = {
 		.compatible = "rockchip,rk3308-otp",
 		.data = &px30_data,
 	},
+	{
+		.compatible = "rockchip,rk3576-otp",
+		.data = &rk3576_data,
+	},
 	{
 		.compatible = "rockchip,rk3588-otp",
 		.data = &rk3588_data,
-- 
2.25.1


