Return-Path: <linux-kernel+bounces-242086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA94928357
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7E628715C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEB7146A62;
	Fri,  5 Jul 2024 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wLBlQpA3"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1559146587
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166353; cv=none; b=F8rikhWALGNBkXP5zME5rR63a9yvMlQwPAZ6IQngBXT5umVwfEL55PvIGmeLb8XLbqbgkEjkXgJ/lVdK4DMuEKCTU7D0dVLZ0SqCpL3ptPiIA3AhGUKL69x/nZhs62hx0OxW1l0kqZikIRAHQ+3E59be4VqUwJq3Ln7Xs8kndrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166353; c=relaxed/simple;
	bh=SGpVUqdhNuunu6EdU8ICh254/ccEvSKoo44/Lv9FSuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=orS48RcKfqqcP3zGEwvJ0cLfprwAFQq93uBLKL5E8tkEcM+r/EEVEC5dxy84ov+KaYrAH1PxVhIMigAIsFfcsMpqwoLCshYy0kxVBUlAUlw/tCHfS7z4nI4xMcc/655ZF19+c23oq1aQo850mLWWUmEkU48uaEBqx7Fu24NM1HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wLBlQpA3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-425624255f3so8396425e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720166350; x=1720771150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5QLOaGfw4fqqwExDjeo+KAi/zuShPBblYH6C90WTtE=;
        b=wLBlQpA3ZtSGO9uwVnov7+IZZA89S7rBl7v7GunQNkMYzVkCKcVy+OCkYKkEPEAIEF
         QZcowL02k2ALlaTC6o22+0AMSb+gULKjI3jN9lOsfaWT+crKBYy9aMqVZourKdCEKqGJ
         67zVOq6rUyK+vRFsDbOThkENqWpda9VW5w1Qm34pOh3aV55ONd1bVZD5DFajtjCmq9e4
         IKNUIhc19+pkIkIRyQmdJO2tJx39jsaiYdXs3RVMC3jn9yInwUMODBfb1VPnFEbrhr2L
         RJwjD4HLnEVcQcaXf99gN6ndRr9RYO2irQBin2Un7OtLHS2x7GOVh80+sgnKOiW32RtJ
         7XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720166350; x=1720771150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5QLOaGfw4fqqwExDjeo+KAi/zuShPBblYH6C90WTtE=;
        b=ObbUJEKqPU7DWFFOOX3BFmihwQdbJfAMzFGfgj6fdKg+xAkL2uLwFfcEbJI+3j2Bwx
         3S/1/NoUrRRpntwhukY793S+vsoOAMCnii1dAFObi3psN221qOIDiFc9UjY9Pc/libVJ
         4sRqdRBCCCssS3coAb6Kn+/3X1sWLgtVoOMUUnIrFox2rA+qIiFYNjPf9DJvMxJVCieJ
         1Cdc5IhD1+v/d7HhWijUgLPMKpwedBFlIAmXnBkVHOvBUmoasxEEWsO5DBH/dDr8+aNx
         YdfFBILOp10PEsBahsUIXdBd1ZmiQ1ddEffKb8iJi7YMc7pN+rkWbV36F5LGDAdeYHTN
         3tGw==
X-Gm-Message-State: AOJu0YzpaZEM4r2c8S1TShygSZAgd2+VdQo5G7UOZ3SQzxAPcCZjn85h
	d/PCyp1b8BVjaq0ruPDSrjF7KGlkBXtm9IPcNWfM20OObhHHZjufASTPtVQeuxI=
X-Google-Smtp-Source: AGHT+IF9gFOr4gU7Pq320fkClZbJsxIC2Erzl2kbomnXaeT/ysdV2OnGI5wtpK7K9mJS/jjnpSr8DQ==
X-Received: by 2002:a7b:c8c5:0:b0:425:6424:5f97 with SMTP id 5b1f17b1804b1-4264b126c8emr36205555e9.5.1720166350441;
        Fri, 05 Jul 2024 00:59:10 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42651531f1fsm15315485e9.0.2024.07.05.00.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:59:09 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 6/6] MAINTAINERS: CC dri-devel list on Qualcomm FastRPC patches
Date: Fri,  5 Jul 2024 08:59:00 +0100
Message-Id: <20240705075900.424100-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705075900.424100-1-srinivas.kandagatla@linaro.org>
References: <20240705075900.424100-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=ueXPhw+SaroMuRF+5GL1pvcqrrkgWe4MYERNdzJ9h1k=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6fD6xKYlVLsSO08KDbTN/O9me/qGhzqUnMR9 4/564j3JB+JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoenwwAKCRB6of1ZxzRV N61bCAC1Wl7cgtoNqBph4ET6HMbXunvLH7U2vpU9fWniOtCoou4dGCmS/5/OeqQEtZB6YGwHjPx U5O7Wxj8os2B6/If4dkXZgF4EnRXJciFnRG1WsjUfiwO7rL8UgRpVOQ5kIItiVkgIX6DQTH7Pdj YE5IwnShoaGv32A6A+ASPcGoD2C1JLRchGUf8DYzYr/K3ZDjGgWqAjUf+p81bEXrY4hARxNi7YR PegTvas8gj+7geNiLk0gB7j6V4fQ7xpSR71MQnBXmefvonmfT+LC1OcEpdqzQDAS9PjLxPaeAXm 09WKNtT36S7ESPd0aaXeBnw6Js4L9KFUwGU+8teazc/Cfa5L
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


