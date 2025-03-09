Return-Path: <linux-kernel+bounces-553168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF8BA58520
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C233F188EC91
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5081DE4D9;
	Sun,  9 Mar 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OnZu8rd2"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A6214D2BB
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532253; cv=none; b=DJ5e9wR3mktnm5qbKh46EdV+agM87025S7Lgc4dyQZ3fj05fCdaK8FmqOFyw5ec+NSYxyOkhQts7Ar7m9sjELQNeidqn4SpUrN2qXWLRXKvGKuhu69GCC93Inp1/gskF9TijqXCX4oT5NKSmMpHt6KHR2L7qhs0cATT2/yGMP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532253; c=relaxed/simple;
	bh=b5drFIBe75sGDj5pYe0brea2ZUmu6wtu9bzah0lST80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BdmgQWPU0Tz/oBRaRDNFiPkIQTExmCV/bapXzia+fD6t1y+rotQft7EH1d4FQpoI8EElVWmzJJih8qDD6Ydo7F2K4/Yf9qGZdlqaL/5u6ONdWXkaWWKoSIXkPShB60Tl6PzpcYNuHWcpyum3oLn99oYUDKBHSfEhGKTKdi7cDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OnZu8rd2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-391342fc0b5so2587465f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741532249; x=1742137049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyzR9vVasmK/SdhNh8h5VH0sOIqi40QOhEUqjrHqr/I=;
        b=OnZu8rd2Onc0AeAuQYn+d6r5SVbpudOJquEZIDB6J/h0d4qfHHA+hzATj0SEGvOxJl
         PVRmaA7BmxbeRw8TqUzzVTq/rON9YJR+NfM6AYbmCxTfHClo7kZriPpbNo6IxNS59Z7T
         HTxazuFQsnR6L8eZDliN6KL8NyvHn74WG1nW/F9Hod5ent6TRf3yr8v/O4faHUO75kiw
         YnjcaUx1TieuF21cI/RzDM1/os29TCgu1rj4IVbZMNjfjYu4w9hwb0pyntnZjT7FIoOB
         SGanTzElM2CcO9z28J0PHIGBysx9CVxuaydJBJlULYdx1SyrP/QtxoKtt9GX4xBsJZu5
         r4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532249; x=1742137049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyzR9vVasmK/SdhNh8h5VH0sOIqi40QOhEUqjrHqr/I=;
        b=h8rMm+jA7tI4rA/7Dt8t7fUgNwqMfragwxZm4xKyUX6ge850EGVaiP3jpkWhky/us5
         maGGJ1PCiSaVKaL4Cgw5JZBFTyZoa/3ehI2L2SPBL4F8xWKZkMHTdQUrg/d1ZQ1R0n9M
         VOJ1vyJasEnweAmxe4h0atyJIWlO7ot/oeB+LOmeqDUcQeSrGPg6K1ESFIizFTsA1G+g
         758BwitI8CeEEZ97h/bAAoKQOoaB/43n52KkH14w+1fIUY58SzI3jfTqafnaM31ne8bL
         PbLrTu+MbBD34kQW7ycr1WVFd05jy5P6dscjSCKNa2dv6UU6ZPjQydynmbgniIdv2ept
         oTvQ==
X-Gm-Message-State: AOJu0YwLToGzD6OzdaNNldOm9xHu74/QcaLILCL/0wC8Y7RQwFJZQelG
	phNMAsNrUzHAOaZ88E9WA8hfbyHYsUofRoiw/E5WAg78+rNFyIMzWMazfXpL8vc=
X-Gm-Gg: ASbGncuCXIv/DsH2ZtmgjJBdkm1hPrpsAr7dMLXn0UZ9tP0PdztsqePuWBueKoLHH/U
	B0c/M3jtv9gzrA88cK2M4cdpyi2bAX8yOMdSxE0vHUJKv9TmUyt8uhYGDHQWqnOKiGoUBBD6mj4
	7JrUb/x1Hkiuu67eHaAc+S8OWIa78qCsphRgk9j7gr/NFKab8XsL0RlAS6YXXGtI5l4c5HPew1I
	E3wvLqKIMLFbnrvrOO6wc4r/+7/JZVYOsyeUgCyFSIvfRHcF7IN4T/6vR32S70PhT4kMWS+xPkJ
	Bpc22wtk/9IfA3La7kfdL1eaDQL3QpO54LTJXeUm67nykdPr8gXA1AHzU6fxO4KAr/00bg==
X-Google-Smtp-Source: AGHT+IHBBDyTjSN34K7Bd5Dfb6GLIL8A7xlJ/ZWjZanoUDwhsVr+5z6mmY9HdUjNnkkUWQIegEO5VQ==
X-Received: by 2002:a05:6000:2ac:b0:390:eb6f:46bf with SMTP id ffacd0b85a97d-39132d08dc1mr7450750f8f.5.1741532249640;
        Sun, 09 Mar 2025 07:57:29 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm11744899f8f.89.2025.03.09.07.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:57:29 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 01/13] nvmem: rockchip-otp: Move read-offset into variant-data
Date: Sun,  9 Mar 2025 14:56:51 +0000
Message-Id: <20250309145703.12974-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1949; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=XTvrcZqujpYXE39Dy8u7O/ipvxv7YOZitDWD3sP10jE=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnzaw5MkQcXUBxWRmO53FvtV/c/ywna5XAFDj66 YJ243dNYNeJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ82sOQAKCRB6of1ZxzRV N+iACAC5H8Y5IonYz9Hw4Vren1OcsC1FSqf7/ZvkP0b1b1zQDA2pW5nCyS01jXsyqAAHaG4gDoX PrGi//mzsRTx3bVER9lEQmJ/DgfmQXdWcuTqWcQGbF9GugV6ahvmyJu1l1cPvBmDUyuEW27depP s/HHNTEiW86f50eJbCOo6K3nJ6DD2vCRGkKO7+LPq7unr2BSaqplPdFChVY0pQkDT1vU9vkba3O HYu/GcFkgT8T15vVXUkGD5SHGuKTuXZ6cXzz4FioFjIGqBk4N34FW63Z6YR9G+T0i+lX5GdMcha 1wSiqQZ+mnesox3xm+1U3adhjhuDTiE6pAwvkyNzkYf9fCgG
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


