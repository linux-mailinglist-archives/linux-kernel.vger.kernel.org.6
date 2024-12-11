Return-Path: <linux-kernel+bounces-441623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B229ED0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7DF28741F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102AF1DDA3C;
	Wed, 11 Dec 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HO/qY15m"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8AF1DA116
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933246; cv=none; b=uUglwJ6DFxN/03oFbqo6+hV2niP1fGcJ2Mr4uzHBlVuaXwe+DV7rQoBqY6Q0mMXBI/m9zV8J04c/ucahZq6i/3lalPNkf3wDdntYFBO+tKMzs23BPjf3RGIki0rAqc1z5VDkxfyGhsQeP3TKb79K1Zy5AVEGCzeIO5X7otHYXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933246; c=relaxed/simple;
	bh=Al9wzob7Lhv6GfLgpukZha8snPi/gtMWzqmI5Nh5O0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXnBOfTTnrhZb4G6BSx/Tp8mVBk1EPKYCiOwWHrAEwWLr0PjFWEgkMUJRUuy3jT9Db+CGLOZyqbL7/Rj54jTwzp4TJJ1FyURAE2CSBXYid6wA0Ht5mh5Tj8X+1rFaG2ymuZvvUwG8NimX69NcYWPHDKEE93za2I33W+3PMf6d+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HO/qY15m; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8fa32d3d6so56514036d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933243; x=1734538043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTwO2nGd6wIbXXez+6l1I38nMUW2rTd+Ao412JHVCs4=;
        b=HO/qY15moLUF1pboU2g8cZo0H+/lhuE9UZA7CGcSY054umih7oTbcygFUhw1QVlWzQ
         Iv3IFyxSHLsZS70V5cWDrnBNm34AM4ZjKmhEuZo9fZ1PCaHx2O7nfdNf/EnLyzq8beUo
         pRt+3LzSpvt/h5NVyJ0dPRzQ1cV/cq3KbK730=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933243; x=1734538043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTwO2nGd6wIbXXez+6l1I38nMUW2rTd+Ao412JHVCs4=;
        b=uhlWLuMw6sCVz4JShc67Msu9OLvlqkoolCYd1b4rAUXRApAvnoMAH5dHGhsagkLbRR
         ZMxlx8PX8JqI3WRiSq8GQv8egtLgeAzaBuQP22rQhbL86AWvkJE9JNIg0TOWFBJTB8NV
         V8+Ou2NxUzCmWv8SylPPc/nNDwYghtWT9hp2Vkzb9Wu/BP1uraWOph2URZpiyAeLeA/9
         0+vxFQaylT99BybMkv2wfBbhZSUBAERKSnPbwyzr+1JrvcTPLZIElnKY37cnC2XW3wI5
         2VgbzmHpAqJGx1OZVHYz4Pv6VrqXTWNgz7yZ4GB9EqlShVJiHdZNzJh8sLhK5wn8lueX
         RqzA==
X-Forwarded-Encrypted: i=1; AJvYcCUnnSeJ+iJRovrAxITyVBTjq2xRRdzvpNuaVZzyi6lCgjlnm0T0Ot0g4T59xw3EMeXqbXGo7IhXcI+f0yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiNf2ZRreO22tedoMcUZFQwGpaGxK93RnG103v/RbZ8jdlIYqC
	rhGgjofjs6dNjx56D34qpd4BG/9PaosNTV8NggdMBlB5q/v+0AYNUWA0lcrjhA==
X-Gm-Gg: ASbGncstGbjPAakrMRgRcN4qS+67PuW9fWQuJzr/50GP45+t9J/MsCrP9Oct03AG2BK
	WWG7qiSGdK7KIsaYCTCurK18Q4fpvcGGXAx6EFCpd3ndPq/gy8ggTcoboGnBLz4xh5JHlbloTzz
	sOTM5jkipNIS6mJAPJ/EXyQaUAjRASkL9PwkWc42Vv2BZJ0gk8jcPySrvLoMp6WzixOSJynqM2U
	2FbE+2vbGk1Dj+aulWWFPI7WVdFUqEu7o4J9KYhm6AJYr7nyLERfGlbuYrGuWvCDVIcJ1D+C4vI
	HZ58cwooA/59S+n1uCFEsKWO9gMf
X-Google-Smtp-Source: AGHT+IHNI8I7kNh1BQAzlY9E5JVcbcVT91dIbzXQpJE1CHokvbatsoZUS9G+d6jIEJjgxda5ooPoQg==
X-Received: by 2002:ad4:5c42:0:b0:6d8:8f14:2f5d with SMTP id 6a1803df08f44-6d934b2d7f1mr64995796d6.28.1733933243062;
        Wed, 11 Dec 2024 08:07:23 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:19 +0000
Subject: [PATCH v4 3/6] ACPI: header: implement acpi_device_handle when
 !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-3-4102e97aceb6@chromium.org>
References: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
In-Reply-To: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.13.0

Provide an implementation of acpi_device_handle that can be used when
CONFIG_ACPI is not set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/acpi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 05f39fbfa485..fb88f21bffb2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -854,6 +854,11 @@ static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
 	return NULL;
 }
 
+static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
+{
+	return NULL;
+}
+
 static inline bool has_acpi_companion(struct device *dev)
 {
 	return false;

-- 
2.47.0.338.g60cca15819-goog


