Return-Path: <linux-kernel+bounces-553177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF6DA58529
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDFB2188F02F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3761F099E;
	Sun,  9 Mar 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8A1BjQT"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A991EF391
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532266; cv=none; b=JIlBfMj/LJye9WMw9oEFau7BcQnWR5cASc+MxNqa6Ln16ewXgpHm/aQZR0guZpMMyGJju5HMg2fKILkBRLWA8cZ+G1htOrMvgNw55lW8bZLuc7i6+SmB5BcZVppyZjHtBTfsPQL38GiVAZg3FWT7/mImvsOoOgQDTLw82h0YChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532266; c=relaxed/simple;
	bh=dGSufDZev2QnQviFvcBnIsmi07aLyjmsV8qATZd6Sdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HIx3pOWy5mlhm4EIXvL12HATt+ipGWhK9xgDDf6BWzM/ys8/5gIO1WbBXZ3GUho3qWtBCtnRVb9Dqjbj9jD5uqfvBfJGe08agCr2QhoCC4ZhtCQ2TnMG/fiFZ1NN9+SxcoVih/EbLBPwcjUIvJWsLIi4S6f1+jva1EomvZoEqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a8A1BjQT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso1615951f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741532263; x=1742137063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oljn2yRDTGh2uUzf7dOnwcTZL+reSqVlKX1rZt0zRyU=;
        b=a8A1BjQTPeeilegU/CGO1NYWHWrk6WNNYFzNWuDni/teDpCjQ7rMekMyWzVKjbpsZ+
         bW8sj4kFBNK/vjLxcoLOcmcV4GszwztPj02oBbs5wiFGC0PLW6RAWNrOKMgBm4yHb/64
         h/F+FeMFA93FXssESSRBQmjrbrC1jTbYLE2Hsuiohk+ireMb8s7FnCbJj2ms0i6ObuUU
         daGgbIGpDS64HA5t2qf4Y8GM+2JqtrRrJMto10WRN+zsD6t0994Syh3gCjwd/u2Nk0Te
         sIBVhpu/Ypd3GAaPWKcrreGwDTGelVoQvceUljZ+2v3BDdmofMUTHF+bb80/VUnaxptN
         l56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532263; x=1742137063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oljn2yRDTGh2uUzf7dOnwcTZL+reSqVlKX1rZt0zRyU=;
        b=jpaDS9cdV7LcHFk7GgTM6Msgnk7s6Ts8ymSZslNuFsI+Ku265RCE/yCZ8xXL7FP2vp
         nBFdE9Q/RPcVM0+KqqT8/UzL+Hx9wCVyT2tzwcliKcVg1jvVMLNI4LEysH2z9tlp26eU
         qpb8z53IZ/SGVBs0F65JsI2WGv8LG9XBq9rlIorHJpq0Df9av1lp74DmHAyZTFaQKqSi
         qaC8ODuWxYzmXYRbIKtJI9vGLV5IV273dp3/f+JziZ87s2TSGw/n8bfKFhQk1aRKudHa
         V5uNNoQ6KeUTmznZgiXo8B5tOrGX3rEJrT9kSoy0Ni2kTsHA8P9JwdbTf2fCRtfzMIC4
         /QrQ==
X-Gm-Message-State: AOJu0YwEXZ/KrC3OkCYSONLlUKFv+5pVAVI1r42q83OO3Ed80OZsljye
	VC4sOEP+nxcxVfHZFbA3I0840GABq+GnzqkC+b6Nj+OuDtd6vdcJgzi48T58wpXGHyWoK599Ygz
	5
X-Gm-Gg: ASbGncsPu/PkV21a8/b6VmRhz5ViYfm5DPdBDg+5ZRgz4hiJj/sdA4qXwpqzci06jxH
	YE15RVXSxCKeqe/rpaAbPDoKnfJbV2vL6iY3JEazf2RzSO/IWbhJSRjQPbR35t3Ye2dKeHK6sxd
	YJKpnTL8i4rHjk7SgcHSPcUnjp4in/0C2pvTlTmsBYZNWX1Nk3JyGmPG5Woa0SRTVap70LFD+yZ
	OeIuFcjuFMXB97wUkp5TEh+GGu3OlDNbGAJjmgXso0ehITipLZrcEsgAOLzT2EhraN3F2l/tCaW
	QNUhxFanDypVRdN33yFel1hTuhscYdGyEloYQ0nGjGj/+LF+VvlrdmfwQOvDg61JzKdVhLT7o+W
	Fm5v0
X-Google-Smtp-Source: AGHT+IFm4WXXNPHSsGBmgKkeKJOQLRmkvUPgfX5WrCBaH+jDvJTai+16aqEKimT2Nn9iDybbnt+ehA==
X-Received: by 2002:a5d:59ae:0:b0:391:300f:749e with SMTP id ffacd0b85a97d-39132d68326mr5558501f8f.11.1741532263488;
        Sun, 09 Mar 2025 07:57:43 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm11744899f8f.89.2025.03.09.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:57:41 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 10/13] nvmem: core: update raw_len if the bit reading is required
Date: Sun,  9 Mar 2025 14:57:00 +0000
Message-Id: <20250309145703.12974-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=6o2wzllNpXzhs6trxDlkHyVJbZYKpTR68bXt6jsCi1k=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnzaw6boJ8XxL0UyZ73ssdMQeBJBYfMcuFV+Wn2 kjZEOmMDKKJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ82sOgAKCRB6of1ZxzRV N2reCACOpVoLsIcLs4QmWPHwx6KCDUVfbYqrO5KQAGN+OCQbUM9/keC20arPzWcvcV0i/jNTtxa h1bNWETUyxGLkgUNa7u5oCQU0ciGDeT6OxiDFuG5TMv8Wlg6i4hN2OUawVOqcyz0f64k60LmAeQ KtsyR+b/rPeUwf6b+B+AR/xtGqQhfDSKmIH4HaDzg4mIFwJwnJb3m1y2/xC9wqpnnMc1K/nNA8E Hu0wzNXpR3eUDdQGtLCCOSD4RvYnI7LTnQPdvHvmmsbLC6bpO+2ING002draxyCn48ZkHevCo1U Q5jRoBsDP0D21SOfg5JVkCav3KU6G6sX2pezZI9iydXZsR3v
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

If NVMEM cell uses bit offset or specifies bit truncation, update
raw_len manually (following the cell->bytes update), ensuring that the
NVMEM access is still word-aligned.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 7b8c85f9e035..e206efc29a00 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -594,9 +594,11 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 	cell->nbits = info->nbits;
 	cell->np = info->np;
 
-	if (cell->nbits)
+	if (cell->nbits) {
 		cell->bytes = DIV_ROUND_UP(cell->nbits + cell->bit_offset,
 					   BITS_PER_BYTE);
+		cell->raw_len = ALIGN(cell->bytes, nvmem->word_size);
+	}
 
 	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
 		dev_err(&nvmem->dev,
-- 
2.25.1


