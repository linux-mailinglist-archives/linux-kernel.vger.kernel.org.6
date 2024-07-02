Return-Path: <linux-kernel+bounces-237537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E23F923A97
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66031F222A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC60156C6A;
	Tue,  2 Jul 2024 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydDbUYVS"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82F03A8D0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913738; cv=none; b=A0wnvQM7uj8r0ZGxAPWmi59maGmusrLBhAeq4El0LzS806U6BU1ynumGozpeLXzzwB0Dy0vAsPUBxYvCGrZQd2ZPEGgrS7Q1N++3uu2tBIzujZFMOyOJV/HsrDrgG9tXENRqbX6U1rkTVLOreLasjShjBLu1dbl84kSL57GRylA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913738; c=relaxed/simple;
	bh=ZHzhL2qDJx6VCsIqQPH6DPvSD0dOn8r7tcbnzboUaz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXophBixtatRXgvhPILj7gL/6ClXcSasgQXnuHVBcC3/OmOmghlpe4LxQoXd+auJlWsB49uG93GczjjGWDg+gwWqlPj0n8s4UyLqh5+5AfJhKRlDGQAMu3Z0Hd3ascUFLe6ntKn9zzSFI0vS8bPXJdZnAYp/0OrrhTzUKgYZ11I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ydDbUYVS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec5779b423so36402981fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719913735; x=1720518535; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grKYh+BySNj5dd16DxXRdwU80BL8FOK+kLgksXgznTg=;
        b=ydDbUYVS+lWjfItmvj/3zFXCS9WPXJ3tiAo9pf3DzeD+MBKRyAXtTg6CGdxItn7/WL
         bHm78QOpI37kaJfS8PVSc1SuoS7kaZ0t7ngYusnCWsq7Dto54a5L97bPdPoPU9Vt11Q/
         zjykn0yqTrN5GQdJ6aVnhjJUubm0ffMD/LaaThqbuoFfHyg3n7un3sQliIsG71JNgtk9
         iT9NqwNeQJ0W5EdkJYJQr/9BP8qLmpsIHrp9cTj+YuCWu3IGbRjERLLrm2fSjxXMWt1Z
         Jf+2TZpZvw95Nz5izz1n0GmSlvMm2iZoN0w4t31FcDyBUd700ynyZzj2QoEnJcPAPNFh
         Nkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913735; x=1720518535;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grKYh+BySNj5dd16DxXRdwU80BL8FOK+kLgksXgznTg=;
        b=A93HpBdDiePpxeSF/E4qFCNFKkSru3KcKlRW50nThbHuL7LuM3nqINeyjBMtpg+LKt
         VFUD4GqZ+FE5QRw99EjqIg/BHkOcF0/Emga3givljsesbwFnrWKem27UpE1TBLx11OtC
         JDJc5TRamYBBXa1JBhDkxOAWA+aHZgIbF/kf9CgEaar/kqIdtQfi7kFlm3M+AWwAFvdk
         fcXrjsFHbxZiVxj9F1i6AtWDCFljBTCZgVfEdcAg8w2rI9PS9/qOXAYxH8TmKU6Stp/j
         d0lRmG0+/pV1HeSb7tG/MWFTFkWEt+hoNytkemna1mq3pT+dOh/S1X33Bx5E+oa/959U
         0dYw==
X-Forwarded-Encrypted: i=1; AJvYcCWytlZ5AebRyTb7kU8+XlsJciSDkC6R0J7yE34J+ezR/NzXSzcmjFoHissx5jrPElQwr+thmYfGO1sPPdpbsXsPOgOytD99mBgAXNVG
X-Gm-Message-State: AOJu0YzA89Xrk7hTSOQ0o3wwCn/N1T93cj+ceCSf7qObQyzZGaTKo79R
	06RM7Vm7/HifM5lpIMs1Bwk+7QjdPx4HG4vi7J4G/pWXJHhbeJIAIDMwiIg/Taw=
X-Google-Smtp-Source: AGHT+IEHYPqBRlSa4/s9XNTLhrSpJ2d7hL4YRvX3igF6c2N0POyPLUNHv3ogsHuGow9fTT7WHEO5lg==
X-Received: by 2002:a2e:a9a8:0:b0:2ee:4c66:6828 with SMTP id 38308e7fff4ca-2ee5e4bb786mr66677251fa.24.1719913734882;
        Tue, 02 Jul 2024 02:48:54 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5160e333sm16231161fa.5.2024.07.02.02.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:48:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jul 2024 12:48:52 +0300
Subject: [PATCH v3 1/4] drm/drm_property: require DRM_MODE_PROP_IMMUTABLE
 for single-value props
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-1-12b0e3124ca4@linaro.org>
References: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-0-12b0e3124ca4@linaro.org>
In-Reply-To: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-0-12b0e3124ca4@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ZHzhL2qDJx6VCsIqQPH6DPvSD0dOn8r7tcbnzboUaz4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmg80EWZj1pah8UzMX2/G4UNqFRNqb0JlRO93Ms
 RRkSO6Hv/KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZoPNBAAKCRCLPIo+Aiko
 1Q1+CACxdDwVSgOIcrD5yaAYfHuWsZQlYwFDxYyvGJAOp18OWx0WYgryw6qDB4Kv6Am94YL8chA
 rzWgZDP7Fh4hmHGMQfPYqu5jd3h2jA45NJamjWWdXMWmVzFsrHBIlr/MqN4K+c1mcW8qAPM4Aut
 LQkdGUHQ936Kwhec384brroKfge+MO1h9dgB7wxbVvnPQapQTOibV0b3aISdjN8fkI/SBR5WEKE
 61amWsXJ1hCW3zNZuGyFOepos7d/6vkL4gaCQ3svBPeNQPYHOxjH2EpaiW3Nmeh+x2C0+GhnVEV
 a/WFgjPVG7wSHgFk78J3uoewD+jjE5VNy14bP8PoznvUJzhS
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document that DRM_MODE_PROP_IMMUTABLE must be set for the properties
that are immutable by definition - e.g. ranges with min == max or enums
with a single value. This matches the behaviour of the IGT tests, see
kms_properties.c / validate_range_prop(), validate_enum_prop(),
validate_bitmask_prop().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 include/drm/drm_property.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
index 082f29156b3e..7d0f793f50ca 100644
--- a/include/drm/drm_property.h
+++ b/include/drm/drm_property.h
@@ -162,6 +162,9 @@ struct drm_property {
 	 *     userspace, e.g. the EDID, or the connector path property on DP
 	 *     MST sinks. Kernel can update the value of an immutable property
 	 *     by calling drm_object_property_set_value().
+	 *     This flag should be set for all properties that have only a
+	 *     single value (e.g. min == max or if enum has only a single
+	 *     value).
 	 */
 	uint32_t flags;
 

-- 
2.39.2


