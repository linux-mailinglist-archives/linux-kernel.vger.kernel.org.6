Return-Path: <linux-kernel+bounces-250787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C2992FCD1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062FE1C210BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59D3171650;
	Fri, 12 Jul 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DOQoBHpE"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F615ECE2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795557; cv=none; b=LwT1DlN5iuq4F2tixqeRpl3CnKzj0+dYpJpgGidz/ykq6uFuRi4LbIWJUAfPTOQyOyL86RYw2+PyCzudVCpe/EA7KJIv/gbx18TpzxsCnKxtPNmGRYYnZhVrIOhe/NYvIT362HIf6w6EgOgGsfk/Ama097l2VRPoqbhkc8EC544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795557; c=relaxed/simple;
	bh=23GKNyE9PLGr6YAiYTbtJm8q7GT6UoIX+SmnMPRgnhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXRwXNOxmYvze7eJT5eeGM0gR/HGe8Hxr+oLzREf3WjvRnkvYH2f10sj9xHoRQVpuA2/d/jTIgyeQQ8BGiHw2f+nQq+jj0U7Kvn4wArcmIJuuh4JlVfXGw76kHczAYe/E9mFILOlTDqkH4Z4Tn2JHtml1Gt05cEOzhbOQwJuRnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DOQoBHpE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36798779d75so1880370f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720795553; x=1721400353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7DJWJIBnnLN7/m2qPdHFhTG1iO/GpmbvrntFpTu3ic=;
        b=DOQoBHpEX5SP4KiB0pKAbKTrkLhOfxC5SeKlk7mWT1zTgv20XVMeCC6go4O4oSBqm6
         uLSGbyS7fzmsf6vW62jy72UovOV+ORXq2wiQxgwaVZZtEO/q8L8+/6UDGAOPTKZYtOzS
         N8E6r4bYeCddarkfPBAi1JK4WQtExdxECHmHx1oKF+uumcOqSucH7/FubZtlgVvyoEnD
         4tqaUW010/xVnPMYWtD5la1sOYdVaX8OQ04O1P/pF0mgjy9Y+IASOqCGKFf+w5Xn5e8Z
         /sCb3q1pXM7xi9/XIUj8iRAEo9ZBceiwMm3PhP5n3ctXchmQmUmLz1sjyQhtG62jKxLU
         imdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720795553; x=1721400353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7DJWJIBnnLN7/m2qPdHFhTG1iO/GpmbvrntFpTu3ic=;
        b=YeBb80p3x/9Za1RUAiRQpxaFPGAqLGZVIX5+tfQlkcXJDcH8ssY5vPTe0gAZchHswn
         5efXyJ82FN5a5C2rya+ZUhiOrRNqZ4OnCmgrwz9wt/Dai2GizPZB29nKWXweQQaZp3/J
         IajoJGNVNzkiKc/DWQXgqdY4Mbako08sj0IQkryMSgt3g04/AKFl+stk435D61GuqxkS
         uE/7uy0mutp057GhRRBATtRCEd1WYWjS8dGN621kl5ezUWeQVB7XdclXV1wqPXSIp0Zl
         LzjM4aWrMHC95X9vluGJVWvObGmkhVf0KHp3GkYTUUudiEdXs2+9AAvBN4bU/Wn7vvqZ
         YFOg==
X-Forwarded-Encrypted: i=1; AJvYcCXe/e9r6wZmZDikkAnkO7l2Cl/xKXmxo10oLkL2WE0QJoSluAVfjkRYElOtXfov+h2wFbztGhByaU5o8e0E6o+imTngYHOi6qsnSwS/
X-Gm-Message-State: AOJu0YxBvpyOwJmm80zHZhnvsOhuHmBo9FNu1fQ+HJK8OJq9s3QS79sr
	XZ4s4ouqpRKG2bSCbbC7l1I6vrXjFD/MR2J8qAIO5YGCAxjtKYFGXG0wnZsf7yI=
X-Google-Smtp-Source: AGHT+IE/Bg/DxrK0231HQRehavFFx39v8TMrRX01cM7LMiVJJoDkf8F0um2u6yjqf0Pd+5Vl6oos9Q==
X-Received: by 2002:adf:eac9:0:b0:367:9511:b612 with SMTP id ffacd0b85a97d-367ceadc704mr9958447f8f.61.1720795553543;
        Fri, 12 Jul 2024 07:45:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ac5f:fcfa:c856:a4d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab106sm10362309f8f.103.2024.07.12.07.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:45:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] power: sequencing: fix NULL-pointer dereference in error path
Date: Fri, 12 Jul 2024 16:45:46 +0200
Message-ID: <20240712144546.222119-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We may call pwrseq_target_free() on a target without the final unit
assigned yet. In this case pwrseq_unit_put() will dereference
a NULL-pointer. Add a check to the latter function.

Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-pm/62a3531e-9927-40f8-b587-254a2dfa47ef@stanley.mountain/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 9c32b07a55e7..fe07100e4b33 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -119,7 +119,8 @@ static void pwrseq_unit_release(struct kref *ref);
 
 static void pwrseq_unit_put(struct pwrseq_unit *unit)
 {
-	kref_put(&unit->ref, pwrseq_unit_release);
+	if (unit)
+		kref_put(&unit->ref, pwrseq_unit_release);
 }
 
 /**
-- 
2.43.0


