Return-Path: <linux-kernel+bounces-551714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA8EA56FCD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC9E3B052A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25320241663;
	Fri,  7 Mar 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8GP3Sly"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A219B1A00D1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370272; cv=none; b=U7jNsjz3KgAToCd18wDC8eztavYDizyxyWOvSOQ155w6piIf+CFkpaqF4+kS3tUQiZUwCCZusGSgPi37MT0naqqXIzfRsftub3WxTLUtyYTEl6o8mwXmmRf+wKmoSqE+Nr9CnVHDeD6auf6J6UYM/vKispQKbXo0shjFKd7pqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370272; c=relaxed/simple;
	bh=b5drFIBe75sGDj5pYe0brea2ZUmu6wtu9bzah0lST80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vk4vRpx+6S/tsPOmGi49vyEqubM2ynPDl32+0CtD879aF9YOWchNOCG630+NIt0E+dNYckyTfJ5ZLnZ3NhyXwQDx51/BtBwKQHhNh0w0H5jWEwqYhQtEoFlm2fCdulLTO8uIx3PVLRP57WJ6bvB4KssNGTIpTQLou60N6GLSs4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T8GP3Sly; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso831272a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370269; x=1741975069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyzR9vVasmK/SdhNh8h5VH0sOIqi40QOhEUqjrHqr/I=;
        b=T8GP3SlyRp7cT2vKOaACn7oFreDt+6ol/yCwQtzNlJ3vrEQjmAXiCUaRMO8xMEIdor
         n9IBSwYewdpyC+eVVH3VUbaqyBADhL+G62/gsVxvz5GftwGGCaWOf5j8COkx3csNpzLe
         rqIS5i9p2xc2N1r2BRZwN8jEzlOSaK+PadxZv++8ipGqrDcswuk2lPgUbcw6/eQ0eWu/
         eTh+fs3Tudygi71PUv2hWEdIFSOoRaLgnEQCV7VZeOLZ95u+20z2dDXMJ5AWFAXcm6yF
         Sz0X8e32hl+JiIGexNxNzLYfBeV0X3XNh/UANupS5Yk0uQjuiSIQN0YVpPE6q+e15J6E
         U+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370269; x=1741975069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyzR9vVasmK/SdhNh8h5VH0sOIqi40QOhEUqjrHqr/I=;
        b=rngxQoInDpq7svXg2cIOULkFpQpIw2sbqwNFgxdY3biN5aMIoKBfVwvxaxS6uy67Co
         rWoEFvuV5oBVbrca1xJjNUwL2GaR2/6Zk8dyegeRBI1Jz7Hxux6w8TByPos9hVYhqQta
         8bGP5tYK/p4wib2LXvEFYKLyaTEV5xRQOAIHBAtElqzeidLM8Ju10q9xwMJ25puTvVy1
         C9kxzhorUmzW6/re6dHIsofr3vNbhJk3JIBt+MntYDCWlKq+uQkF4HqywOzaTUjBus9/
         hY94y5E3IRxFZTZTyaKmMFeS/n90+Vt8pZBJtNRnvoS0AEMidr6XIE3Ac4Gzn2V4AKga
         UifQ==
X-Gm-Message-State: AOJu0YxEL24laTUesjIVr/coAe+GdmnkbQzgmTseELpWUCjf7WCCdpQX
	a4lAmeUnq4LDWEJIQR1fTfEICg5gHrG/758arT3eeP0bIQag3jsFBms4YM0d8TeghL6CunenFVY
	r
X-Gm-Gg: ASbGnctXUNAUgN3CSUnRbJ51rDfCiBZrHLEupz3uXRKm4SvsZThLdKqvwSz9kSq8uiW
	fn8R2yV2wQP+2MYqpm19rt+PU0EExf6nxdUCFwaeBpaLfZepFgI5kWdy5ctuwcSakS6eLYtF5tH
	bXS8fW/o6mK5akEhW5kvnG7DFVhfvThK/Y6UYhOfJe53f6MBaPMfeOXR2jamRflxK0i8v1y8180
	+yABAAF6BRP12K93FFnGHWIXWRGaDXbvgMz04OjCwhNrRgMg4Gd5gcet6TUDAuq2bHtN5YjJ0AM
	ZmfDVjM5umLkNNOIYIS1kTOdGWUzwh5VCNbQux8olozInZlM9NcvCwZH1oKILV5WNac7cg==
X-Google-Smtp-Source: AGHT+IELeKnAf6mRumsfHBASWwxD1ptgFBWKXV9VYVPV5Rkq8l3ye7UjGfqBhvrhoFVsMBwkkBNLgw==
X-Received: by 2002:a05:6402:40cf:b0:5e4:a438:a50c with SMTP id 4fb4d7f45d1cf-5e5e24c5c50mr4852576a12.20.1741370268830;
        Fri, 07 Mar 2025 09:57:48 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:57:47 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/14] nvmem: rockchip-otp: Move read-offset into variant-data
Date: Fri,  7 Mar 2025 17:57:11 +0000
Message-Id: <20250307175724.15068-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1949; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=XTvrcZqujpYXE39Dy8u7O/ipvxv7YOZitDWD3sP10jE=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN8MkQcXUBxWRmO53FvtV/c/ywna5XAFDj66 YJ243dNYNeJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfAAKCRB6of1ZxzRV NxzMB/4y/239ePFOtTwXyULvvEim0y1tNPwsyH/9AMyCE0sNin0/oxxzU0z7hoki8R0RyYmd9JK muyn0M5AU4GL1so20Yx1CVh0kbdJkXLgurET35xQt+ocDyTg1Cn1oSXfO91KR3hbfNHZELNiJlZ ZdgkHFNrGvgWWvxDMCl2fJJ6mh4favj1pX7QJe2PUB2Ko3mPojS8bmxiHKVx78Ol/opMxt5XB76 e6CLKIO7IJ3FmGNKWR2RSZczxv3ZUjhokxiXlWvme5VaQpse0222Lp48R2ZcdoMSjNlZlcHJvtn T5bysEUvteEYIWlIcrlEu8yqdoV3mABYVe53n6gNoYl6WkfU
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko@sntech.de>

The RK3588 has an offset into the OTP area where the readable area begins
and automatically adds this to the start address.
Other variants are very much similar to rk3588, just with a different
offset, so move that value into variant-data.

To match the size in bytes, store this value also in bytes and not in
number of blocks.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rockchip-otp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index ebc3f0b24166..3edfbfc2d722 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -59,7 +59,6 @@
 #define RK3588_OTPC_AUTO_EN		0x08
 #define RK3588_OTPC_INT_ST		0x84
 #define RK3588_OTPC_DOUT0		0x20
-#define RK3588_NO_SECURE_OFFSET		0x300
 #define RK3588_NBYTES			4
 #define RK3588_BURST_NUM		1
 #define RK3588_BURST_SHIFT		8
@@ -69,6 +68,7 @@
 
 struct rockchip_data {
 	int size;
+	int read_offset;
 	const char * const *clks;
 	int num_clks;
 	nvmem_reg_read_t reg_read;
@@ -196,7 +196,7 @@ static int rk3588_otp_read(void *context, unsigned int offset,
 	addr_start = round_down(offset, RK3588_NBYTES) / RK3588_NBYTES;
 	addr_end = round_up(offset + bytes, RK3588_NBYTES) / RK3588_NBYTES;
 	addr_len = addr_end - addr_start;
-	addr_start += RK3588_NO_SECURE_OFFSET;
+	addr_start += otp->data->read_offset / RK3588_NBYTES;
 
 	buf = kzalloc(array_size(addr_len, RK3588_NBYTES), GFP_KERNEL);
 	if (!buf)
@@ -280,6 +280,7 @@ static const char * const rk3588_otp_clocks[] = {
 
 static const struct rockchip_data rk3588_data = {
 	.size = 0x400,
+	.read_offset = 0xc00,
 	.clks = rk3588_otp_clocks,
 	.num_clks = ARRAY_SIZE(rk3588_otp_clocks),
 	.reg_read = rk3588_otp_read,
-- 
2.25.1


