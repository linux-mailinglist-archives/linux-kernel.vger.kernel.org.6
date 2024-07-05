Return-Path: <linux-kernel+bounces-242053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF7092831D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EC61C240DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A918E1465BB;
	Fri,  5 Jul 2024 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BujD0VOn"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C43814601D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165755; cv=none; b=QCpcyKXVzAbNxT2zyD+vdtTrBqKN4CBfVClc00eWKsnDlpONMNFIVa0V3TEQHi4M1RIcvxgWG2kzehbzm/mZxlUsd5IcPGmd1DTpQHqnMfd0/Dk6BhkMmJK2srujURJn8PtszB+8B6TWbEZV1um1ac5flwFHDcrYhrNLOeSBDJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165755; c=relaxed/simple;
	bh=8E0U797Ai02f/x43XQavOkgktbx2z3xrDzNJGWfgnhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sdye4xvhqeTno9AQTm1VhWN8fxFnQ45ptK1kbL5Aj2mZYxSbBJBY/dvkiFSRqSVr3J0asN1ww1+gYegEk4IrmfejnDWQdeNWy39OeNiPEYS74ulucJFCM3DsZOeIb/bigI1VmZuvSk7DU3DvIadlexLh46uesibRPWULBRaQkhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BujD0VOn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4265921b0f6so756785e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165752; x=1720770552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DePcDWsxo3qyzVu5W9YbWFSxi8awVgKAQK7WIV/XO+w=;
        b=BujD0VOnNM9IHEkiODNlUoLIXfN/MBBroCmpL1susDDJmhkPT+22XPWUtX9HRbksG0
         cVGbDbd7NhSdDt5zU+qH/de9YWxcBH0Xhx3J0GJ58/rZnfAvPfblHsrb+f+vPHbFcVZc
         do+qrKZuUoBqAPrWV7T9skWT6GBhAmi5R2mSBkP+y3s3RmPe70FdN7mXUZr4AwVYXHV7
         Z/8KsF01b8NXjmPavUL3oKNVVcFNEB394zy0kt6Fv7c7uKCnmuSLeFHgKIyImfq/2pdt
         GBtbHBn7Lb6TPkRreyy7aVyg6n8hxrmi3Yljic79PfmgqAPEwdcH2OKx8pm/p8RrKYN4
         tbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165752; x=1720770552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DePcDWsxo3qyzVu5W9YbWFSxi8awVgKAQK7WIV/XO+w=;
        b=m8dC3UaIEAGLufhuS9xtoMwGcR8BjtgEPnxsVCZliD4/sqV8ImbPDSlCjYSaMPtCgC
         lQr3bkQO5pCwKke0bEueXrmBAyGvApZkcp9kmsMF08/y9Ly9RWWkpsOuFYNQC1RKH706
         xexFojnCdEw6nSAeO9BPASxCWYn0iJZZREyPIJ6MWG38lx0n+CzlI9qsWuSOfmz0g1YC
         S3CwTDvOGtjiyyvH7+PkFHuFu9EbzOzJPIoILKFK2lF5JyVuI05oNL9XHbi5fld/f4+K
         aQmCDwaerrYv8mjw/LR+YpIAzcGr25/zKcW3CoTVcKfH+udH9yNjPAnPiK/vcnwf6Kij
         bdWA==
X-Gm-Message-State: AOJu0YyUI4kwHkZj+JB0bNm6n0ik5BGv9XfmSs2haSmYJwy2F+Hf6F7S
	c1KQnFb6i0ptCXwso8xF02EzYIbDGCEfLOyh50riEdWdZRvAB2UUnqf5HKrAhFA=
X-Google-Smtp-Source: AGHT+IHy/c96L8vwSh1xetryRpNzghKNSfpN8AfxeAEpaQEcstyxOfDoOyLf3NAKBGVdtC5M+lERAA==
X-Received: by 2002:a05:600c:88a:b0:424:a4f1:8c3e with SMTP id 5b1f17b1804b1-4264a46cb5cmr26759355e9.34.1720165751904;
        Fri, 05 Jul 2024 00:49:11 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:11 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/15] nvmem: rockchip-efuse: set type to OTP
Date: Fri,  5 Jul 2024 08:48:43 +0100
Message-Id: <20240705074852.423202-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
References: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

This device currently reports an "Unknown" type in sysfs.
Since it is an eFuse hardware device, set its type to OTP.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rockchip-efuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index 2b40978ddb18..013e67136f3b 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -206,6 +206,7 @@ static int rockchip_rk3399_efuse_read(void *context, unsigned int offset,
 static struct nvmem_config econfig = {
 	.name = "rockchip-efuse",
 	.add_legacy_fixed_of_cells = true,
+	.type = NVMEM_TYPE_OTP,
 	.stride = 1,
 	.word_size = 1,
 	.read_only = true,
-- 
2.25.1


