Return-Path: <linux-kernel+bounces-242036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A249282F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21821F247A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1E4146A67;
	Fri,  5 Jul 2024 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVvFNN0/"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59733146594
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165284; cv=none; b=C62G4J6KOcSr/OWzVVKv0p4FWFzQ9lWIvFznjL8qPRkiLzcMe4M5eupxHZ2veM+mZ12bBjct2erOXOjcQ18akGHPD/i3GhzllUxJc28Oto3Mg5mW61XZoYLAubJngmDfYeI0OHPBaolSTH/GT5CjV+lHkmjIcq75XJM3ilsVrQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165284; c=relaxed/simple;
	bh=SGpVUqdhNuunu6EdU8ICh254/ccEvSKoo44/Lv9FSuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F52Q6+6R5zzxfOsgMs8IE7lGKd1H/iSeKfcz8jrX3KIlRoLrqA4naqT69i6GFSGUwx2NNzOqSteKDuBY36dWVnv72E3/+SawS13sTCspzOFX63mSPPjLNP1GcZY4pUO07daLmmPnH44aYSWsQWhIlBOoqXTgXDy8L8olbq8Z8l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QVvFNN0/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so16385621fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165282; x=1720770082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5QLOaGfw4fqqwExDjeo+KAi/zuShPBblYH6C90WTtE=;
        b=QVvFNN0/7fvMYMI9KOFwJ6NYW2vVyg8XCxjQo/W8oI57jHJO/EwwN60fzOxl71Jkb0
         je8jEcCpYAoK7zhp5oBuXq6IdA8pITeyJVoJvbureAf8a+pxtFli1X+lO1u0UOvWG/30
         rsF0VsHCeLZEFExECuCQ3MHwhhUJe+7EsxsOUrkmMhxQPCNZuBe5oB17/Y++JYpOxzwu
         Hok+13dDXTvOI3qro3AO/8lwTFNQfBDhH6vPklFmHLN7J2IhGZxVTd0SlmLfrmz8JHRj
         TaBasVCsCt5EMC5Bm73g4VVlVg30kvspqotdBJMT9b7f2VtfgKXeEs2RuETac5qrYwI+
         V46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165282; x=1720770082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5QLOaGfw4fqqwExDjeo+KAi/zuShPBblYH6C90WTtE=;
        b=mtVY4WX5MUP/yWo+pOsHiURKIub6Bf8alaz/HVafoNABZUKAmxhJw9cfJ9nOxDcqN/
         fwC/8B4ZBVSqYKcLitWucB3a+qPGf+aMs9K1kFRr+t0rFvk2t6KMHEi9bmnHyNHTeLd4
         hIsO6t8/luqExlAF341eBAhsNnkm8pyEBiTz778T84D2JPxtLQnJBlHhy5FPyn1QG+QU
         ZcnqtP5bkn5kcIuTjdVMKeMpxslklFv7NEh6pjCeSVncr8ZoXKV3fy5fg/fHvwDTLK8T
         9//ZG+RxuFYxpoi880SIEyJFIOesj7jobzTp/Jxm10I5fIQ/P6h1omcBdZtc8zDXEeov
         xG2w==
X-Gm-Message-State: AOJu0Yw2JCfITfI/j/Lr8eLvdOX4Vu4C8AIz8SrKsCewkgrF9UJbasVN
	+Xp1cVKh2yl+kxvhAchFYY8YFeciaHMAbs/ZyoBGuDU8BZcgx987FbePW+S4Ia8=
X-Google-Smtp-Source: AGHT+IEqbENZtjHSyVjp+IOgjlrzT0gChpSpdSftAQskxb5MtsT3o8+fFCOvYNJwEo9lV8TH+aGGjQ==
X-Received: by 2002:a2e:be0f:0:b0:2ee:7b7c:7f6e with SMTP id 38308e7fff4ca-2ee8ee01a91mr32530311fa.39.1720165281477;
        Fri, 05 Jul 2024 00:41:21 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm50837455e9.10.2024.07.05.00.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:41:20 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/6] MAINTAINERS: CC dri-devel list on Qualcomm FastRPC patches
Date: Fri,  5 Jul 2024 08:40:45 +0100
Message-Id: <20240705074045.418836-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
References: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=ueXPhw+SaroMuRF+5GL1pvcqrrkgWe4MYERNdzJ9h1k=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6N96xKYlVLsSO08KDbTN/O9me/qGhzqUnMR9 4/564j3JB+JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoejfQAKCRB6of1ZxzRV N3C2B/0U28nkUfbhbqNCjbCUxs9VkpWC+2OqAbsArRn02CWLc/+cPziI3siekyfjUwB8MGXBuBK 29bXjIkjZmBit5leSFI+Hq5SnzvhAeDhPh3ajfszdeEFZCrE7fV2ea2wTYhqbQgGuXGlsmaNJMy ZeFmxM7t0EO6qjB/DqJiySoQnDJJdaK6bCI7EaH+24Xg+ziyLUWEJcRaGu34GTWhxO95ECwa8OV azZmEIRfGoeU9sNYoUbAneea+K6PCy9ozlRJDswdx/1HhYb06TFxycc/W5BCZM1uaejNpE3/gEh b9TELAbJOO6WzNzAvOwlAMaCku3L8x13FzmzxrQVFExny+Aw
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

FastRPC is a way to offload method invocation to the DSPs on Qualcomm
platforms. As the driver uses dma-bufs, add dri-devel mailing list to
the MAINTAINERS's entry, so that DRM maintainers are notified about the
uAPI changes. This follows the usual practice established by the "DMA
BUFFER SHARING FRAMEWORK" entry in the file.

Suggested-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..0b99543d9c6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18499,6 +18499,7 @@ QUALCOMM FASTRPC DRIVER
 M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 M:	Amol Maheshwari <amahesh@qti.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
+L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
 F:	drivers/misc/fastrpc.c
-- 
2.25.1


