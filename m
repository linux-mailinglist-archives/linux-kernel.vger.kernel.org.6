Return-Path: <linux-kernel+bounces-242061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE2D928325
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744A01F24887
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7D7145A00;
	Fri,  5 Jul 2024 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYGVjNWf"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174351487F7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165765; cv=none; b=j9gmU6epSfu48HW7yZmTLC6a1hSCjoqPfvk7qz4B7D8y8MfzF1Bk6Tjdt+Rsk8Y6MHX/AKj7Uwv3mTkfVUc9D+p5jJjy4DRGkjHB8Otoj2gOV8+fzyXsdqWqY+37IqepbKvSPSBHstHBZxdgCxYR0VT62D8IAknTEobUoV1AgRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165765; c=relaxed/simple;
	bh=aGU0i+e8LTqfCA2uX3KKKSQbgfrowWpA0IV+8zTsXwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P510vfqMk3ISOkfo5rgwJfI73WqMnMtjDi5ENxubgdRPWUer+xUHhSXzyGBufYbVp42gXnXFSXW0gF7m4fw5L1jbyEIGje3Y+cGlcepFUUMt91ubWdJ/M1E1kdvz8pLUJy55K64APRpr9i+r2Q+VT1sxpTcrCAphHqIIjXkxlcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LYGVjNWf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42565670e20so14958265e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165762; x=1720770562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZ/gbUJARlOgZBmBHD5nmD6UTdrTLHcLtrsmFiCucHU=;
        b=LYGVjNWfSjalrrdq9mI0kAYHRaGXNBmW49BALVHNS0IXvizBxrJu0rfPnYDV1Agr/V
         Dl4dO2gTVyO5hypS/sMOtAUgpOeM4U5QrAWs9bkyc33ZmMCkzV/g4W797gAImrKUpdyD
         96gtcyi/bf8Wq/Da7qKaOn2L6rq3bg0eA/6a78nIiS63YzkDeBZsJi0SneCbHsI0wFai
         FbWPlEVje7rolOupc9Mr848goU2tfJlc6aaptY+Dhs8+lP/SN29bAqxafJbj+Mxs3Mo5
         Pcptr6kq54dTgo5OZpKFVTRHYP0ZvxLZ1KutSKYcmxnNo1aKopwuryKC9tJD+IqizPeg
         DprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165762; x=1720770562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZ/gbUJARlOgZBmBHD5nmD6UTdrTLHcLtrsmFiCucHU=;
        b=I9J+6Qm67/kUOrQkR/u0RgH33FgVGzonVsyQ1HoD0faE4ldJx/yfxR7joZu5sAXqHv
         KZw+NEeQZ9lP4NIe7DnFCPchejPN++yDJzuB0UEsrrYqgaAUPE/06cqhIucj/0X2Y0B9
         Lt+F2SvfMSohEQOW/p2EiZLzikZFOVii7946nW78LPwHTSDSaQ4PchdDc0jtD/qEtsQC
         CZToK5S5BeOnFUwYXWVz2uUYVwkn0OOjNeHC5r/qrMVLDTk62eM1a6k+0Mo4YIuvtm33
         VG7PrwKVtYt0ZY+HUQbvTFHMhZR9Llvb5JxM09raBXALBT8yFTU8bEvbf99Ru9QIbtYD
         H7eA==
X-Gm-Message-State: AOJu0YzGxZxp7Xat2k1kdy4MFBW6lqk1d7QicQRNfPc/A/QoRoCkPMbB
	j+8MtFwcHNhALcJDvbYNH31AYalmnWTaMYhH7SWVyq6l2GOR3PRLSsgF9QS3D3LwIrj7ApVbWpW
	fgpE=
X-Google-Smtp-Source: AGHT+IEGAhv5ohzGYPfo+pCsNxpMjkhF9JPexhSmyyNt4LZC4RgrzBuHHQ1HNc781kuamE2pIivy1A==
X-Received: by 2002:a05:6000:25c:b0:367:8f89:f7c9 with SMTP id ffacd0b85a97d-3679f739cfbmr2754860f8f.33.1720165762603;
        Fri, 05 Jul 2024 00:49:22 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:21 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 14/15] nvmem: Use sysfs_emit() for type attribute
Date: Fri,  5 Jul 2024 08:48:51 +0100
Message-Id: <20240705074852.423202-15-srinivas.kandagatla@linaro.org>
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

From: Marek Vasut <marex@denx.de>

Use sysfs_emit() instead of sprintf() to follow best practice per
Documentation/filesystems/sysfs.rst
"
show() should only use sysfs_emit()...
"

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ec31c1fe9a99..89f632f91768 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -179,7 +179,7 @@ static ssize_t type_show(struct device *dev,
 {
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
 
-	return sprintf(buf, "%s\n", nvmem_type_str[nvmem->type]);
+	return sysfs_emit(buf, "%s\n", nvmem_type_str[nvmem->type]);
 }
 
 static DEVICE_ATTR_RO(type);
-- 
2.25.1


