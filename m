Return-Path: <linux-kernel+bounces-318946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C932E96F580
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41666B23880
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C3D1D0DE4;
	Fri,  6 Sep 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yq5KW+7Q"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1158A1CF2A4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629727; cv=none; b=WzvK8mn87kCLgHQ/9xvYpdalBBOX88bvt4LdMPjlrgsVmLqUPe0owZd3/jznEN2yu5FHxZ4oaQA6ocLd29OR6xV6pzXLvROeXdx/5n9IbrdDNDwye4HatYwuDUjWgJXeDx1n3xNIhleoUMBoPrUvBEKi4I2TGcZYzS+uLkrC64A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629727; c=relaxed/simple;
	bh=uFpLNDx7axOqsTgkkJPsc6yBsPXI/ygS3MYpVh8ixvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BvXZNyOt/2G9PSocWalumhe77Wl47NVnpeVbIud7RYPfY7hbCSWtHlEFc584fijH6YgXTtP/6SA5JeiSYK0MDWF4w6YPeGbkZpP0pomaFHrvZ9jQ/IR46bmx0FTb8Imq3pnxz+5+fkkGbWvU9MjKVF0NabqgGp2fvM9FiJyfpow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yq5KW+7Q; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374b25263a3so1006178f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725629724; x=1726234524; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tSPL9hjXApUYKXuHpC3lX5106d4gltSKmV8tShxn0Y=;
        b=yq5KW+7QqsJpgoPPoYgudqUE2/IcQmZStXuFJcGbBoljW46DNSGG6a+XaYhd7UQRKb
         iPubDIgh0SRjPBLc7f3tMpVni0lxSB46srmsghnhN6h2AO3JeEq/lzBb27esBPvWp3NG
         UEzpoduCSQMeBqvbXTMVlRNHsLSOaeLQzVK05JRYrygCuR84gw9a3Po3YESLlLO6/c/A
         gUT76uWJ0xo4aflJklIXa1dUf1rvCw6RlD7yvu34zOtJj3V3frZqFIFlq2z1Ei5XIuJ9
         clKbmYta741Kw707eub3L7WfTYzwTvGXoCcWFQMBAg4zw+88jHi0eoztrvVdWcngJEi7
         oANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629724; x=1726234524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tSPL9hjXApUYKXuHpC3lX5106d4gltSKmV8tShxn0Y=;
        b=GmDoyO8j7ZFa/MHfImQK232vmT+mEXE3tFypp8h2fAJAe9siuKvCCPyAV1P179s983
         +WLVF2xFOXe5be+rLO4XXq0JwC6EcvPNbVAaqQYs71o5mAP+M4d/kMmztsy3/ZisjSt5
         J3G/jkTJQsaVDlQ+IBSqHGD6pFZ1jirLUZX40Jim0DROohWNk0yED3CHu814XDpzc0jU
         0ZetPweiLiPmI7JhFypcidqsqLAlzg9M8pDLGzVbaqnBS0PAH02SWuDzJdsamXskJH0I
         Nyx7lzjzJokDn5XPblfRwCXanYnX1zrDllCA0xN+SH0hunVyXpueil+IgHcfAZGG5wHs
         xxaA==
X-Forwarded-Encrypted: i=1; AJvYcCW5DXk0qF1fD3B6y5D3tmQ/8YnEhHaQBmbaWSGQAhqj9AuGSC8fG+/srNg+TnWwK1wDxPIfVMzjFtomfj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/Ui2q/OKF1JJ1yG9fm9uRmzREzZ1NtLsdGmMUaqIDDRBzgJY
	F6/PBjLy8cFMupfZrPU6XDhshwxw8efq1OnzVYkiARe6pxHvD5PCzBEDAm08KsR994zwpv2RWFu
	J
X-Google-Smtp-Source: AGHT+IGh0HbWA2IvTSqHJmBK+lJ8nsE3aksAjKs/B6hcz+IVxN5XBkRPlliYSkbr5ltAj9mYwc0NkA==
X-Received: by 2002:a5d:58f6:0:b0:378:81aa:2662 with SMTP id ffacd0b85a97d-37881aa26fcmr3879235f8f.7.1725629724309;
        Fri, 06 Sep 2024 06:35:24 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b0ad:b504:10d4:481d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm21684597f8f.62.2024.09.06.06.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:35:23 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 06 Sep 2024 15:34:51 +0200
Subject: [PATCH v4 6/9] reset: amlogic: add reset status support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-meson-rst-aux-v4-6-08824c3d108b@baylibre.com>
References: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
In-Reply-To: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=uFpLNDx7axOqsTgkkJPsc6yBsPXI/ygS3MYpVh8ixvI=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm2wUSAS3Nbjn5SPm8sfJpgm5HVfxx1YI3Rng9m
 a7emBSfQleJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZtsFEgAKCRDm/A8cN/La
 hX01D/9jPU8wNhdj3cGkbDsDFOcUizWHJTxZQVNcuuvU3YARiZ2ZWZxxVIO2g+S1MEiVC9f1Xg+
 9cILnAENe6RqjcnmegHUjrxB7wHtVTz66G87kwhuR7kp+92TDUF0iCWSiqE7Sh+rOYKFVmmOVQh
 nxdcc3rMZSneO8iie3cV++LFLFWH5wR5rMiU57p0dr6hIBgm+k2OQZUXLvX/JeFcY4KKUg4HREA
 1BsXFzwkMcz/ZgCrVqokLqtODgO/D0cdd/58UU398+ZwDv9AZjAS7l1DBeZu1tW9o8drO8Gcsto
 IuTOrD/lNYTolBFNq0DGn7RdZo+cBrW18ZetSwDCM3F5z7/xA/+aabkyh4WAeLLg4KL9kdtJq5Y
 uk/hOesetOkgJ8gDzcjWPb+suk5mIlbslUCr6FTqomWQxb+Ufdup6FHxTjTpwrQTnpZiJQaBKCB
 QFVaCzFdtouKsSgzkkIAg6a4e7rI4PAb6eU79NX5XovlY+mk6PKINUJ3rQszHUw6/UFltA7w85w
 JA59QJVLz8sbJvgxudM1ULR7wz3qYiAMuhOlgbmBv1UQHXrvymqUKHHFRYgghQD5xIKG5tRIfOX
 5KypBuiGoS2L2Hxe3PtZX5FbiB9eqd7rthdOBIIbo0sCzjqtua+AG6niI+Nfww0xrqV3BwcWi9J
 IHxrsEzom9u9wCQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Add a callback to check the status of the level reset, as done in
the reset driver of the audio clock controller.

This is done keep the functionality when the audio reset controller
get migrated to meson-reset.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index e31c1b7c9e4d..af690d3012ec 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -68,6 +68,22 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
 				  BIT(bit), assert ? BIT(bit) : 0);
 }
 
+static int meson_reset_status(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct meson_reset *data =
+		container_of(rcdev, struct meson_reset, rcdev);
+	unsigned int val, offset, bit;
+
+	meson_reset_offset_and_bit(data, id, &offset, &bit);
+	offset += data->param->level_offset;
+
+	regmap_read(data->map, offset, &val);
+	val = !!(BIT(bit) & val);
+
+	return val ^ data->param->level_low_reset;
+}
+
 static int meson_reset_assert(struct reset_controller_dev *rcdev,
 			      unsigned long id)
 {
@@ -84,6 +100,7 @@ static const struct reset_control_ops meson_reset_ops = {
 	.reset		= meson_reset_reset,
 	.assert		= meson_reset_assert,
 	.deassert	= meson_reset_deassert,
+	.status		= meson_reset_status,
 };
 
 static const struct meson_reset_param meson8b_param = {

-- 
2.45.2


