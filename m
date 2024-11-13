Return-Path: <linux-kernel+bounces-407338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2484E9C6C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8D8B2A281
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFE01F892A;
	Wed, 13 Nov 2024 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6PVGxgx"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD21F80B2;
	Wed, 13 Nov 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491633; cv=none; b=OI+D1NDU7iVcFhufmphHzjt9IfOiptUzVAnIvnMdyAHrqM7/3+YKSDq+BKD2l3Rs/gIKYAaPWXyuxUo0RrJLmHKK5jbf5oezSpPybYG6yy92B2QUYBZLqPhOxMlMmsPtuzan9uaBlQkLTnHv3Rvpz72lVnif5aFXCr1QwGKPPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491633; c=relaxed/simple;
	bh=LJG8fRx8sK9z47RPmgOvlzQodxcVChUzAP6xlKgXsHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WXM8CUYe1IdOWZFrOe7QKCqoP06aJ5RUHtKz2Ab4LPx3iEfY949AkWRmtba/zqE7V3dYk7PJKXjWquDBHrkGChWfNXeCEKM07bx/d3G19Xs6WFoRvvdMofnKkledefYzJp2Sg77b7zyJLZOvKMoZtgSlsPp1fU2HAI+dRcSwrvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6PVGxgx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-432d86a3085so353815e9.2;
        Wed, 13 Nov 2024 01:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731491630; x=1732096430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=elTTjq7EKHhc/rmuU/TuzD2ilhBd6L7N4XdE1BEkYcw=;
        b=e6PVGxgxaIrq8wWhy1tSmE+yVPEfmL9Yrk0mqYAFBHWB0fFowiI4sEBJo5JaWp6syR
         EPTOOLUgZcUZMuzcuFTOaml1kgNBnPuB4ktpWbCkqYGHFQ7IqnC1sZTgJksEx6BgdVVe
         Jg5mGCcHqD65LPuPW/xzY8MuZ85MnvjfZBys6FAvH7FmjzSJLuSFOn684ki2xWuOmF0O
         Ng5txfUiailOvD66qLWRHsrMz7+3Uaupw9kzw6Ykk2BN53Hom/H62sXq2IAgxDXKxXXD
         AESsKAcPruHTcT1dhFcL7QzP2rgh0Db3ut9RzoVzVxr/Z5kKNQjMrwmEywmBFFcYmZ1/
         ZCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731491630; x=1732096430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elTTjq7EKHhc/rmuU/TuzD2ilhBd6L7N4XdE1BEkYcw=;
        b=UdTP+ABvD+Ozr2pYicUO+W7ji7JpuO9EIAphMa7Bl0YX+KoIkX5Z5aA9lGGcxZtHEc
         ryayBR6PZ487eRr+zWcaHRPTkzuhsTgah4FT9cbdXjj5x7NiyeUkxVv6cnl6eKNV/hh9
         3/flLlB6kVHRXxlvXPs6UiWFxl5Zbm2Dm+0lm+DSnnpOKvZIY1JYtebHpAzQMI5PwYaC
         nIUkLl5vfszkK900z7PZW/u7VSyODK7FpyOG09yalup8XQQXEv9k45LtIwq5jxDZ24BU
         e3q0Ksfq4ak5aq6bqwUInA9t85DOlpSWeD67yTkxjjDsiECbZHJB8b2BIEIh/on06kqC
         WSSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJJssmxalQRFgZa/YTDfQ4NuohPgWBI4zC1Qh5diSMY/sBAr+NnKCItK8g5k8TEQddS8aB7xK85V3wRnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2361OjxFWHo1GDewMFBoyGbqxm+uWU0IwKynn5jHOR408xmYq
	ZPb1MfaE7JyAq1Wa6W4A7fx2ff2OnOcqn9Op/4zfNMduwXWxTDwY
X-Google-Smtp-Source: AGHT+IHJsGszYhCG9sKul2LVAcQekuyWfmALrzVcIaIonAHypoPW2E58zCZu/ukNnLmrCe/epmN0Lg==
X-Received: by 2002:a05:600c:3ca8:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-432b7509717mr151967305e9.15.1731491630125;
        Wed, 13 Nov 2024 01:53:50 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d552c89bsm18201955e9.38.2024.11.13.01.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 01:53:49 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/amdgpu: Fix spelling mistake "versoin" -> "version"
Date: Wed, 13 Nov 2024 09:53:49 +0000
Message-Id: <20241113095349.1161044-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 9c905b9e9376..feecd099cf86 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -646,7 +646,7 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		break;
 	case MES_MISC_OP_CHANGE_CONFIG:
 		if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) < 0x63) {
-			dev_err(mes->adev->dev, "MES FW versoin must be larger than 0x63 to support limit single process feature.\n");
+			dev_err(mes->adev->dev, "MES FW version must be larger than 0x63 to support limit single process feature.\n");
 			return -EINVAL;
 		}
 		misc_pkt.opcode = MESAPI_MISC__CHANGE_CONFIG;
-- 
2.39.5


