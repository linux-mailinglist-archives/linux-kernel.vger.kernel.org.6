Return-Path: <linux-kernel+bounces-251130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37679930104
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E321C21AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC04381D5;
	Fri, 12 Jul 2024 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HJMnYMS3"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A56B2E639
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813211; cv=none; b=hdWOrMsL1D1t9jLRORKS0EKgFWmHot8+6k65hs898n6/4wdiQnt50OKa4gGt9wU1RMCj0xMtVLwjSle/2jP7NpPA7HqLJl9OMy82/0R4XI8lYOvy2zsxrj9cE4hYhNXnz4Huovck838K/GoB/ffqan6PCC4eo0qPq7w+s4Xw25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813211; c=relaxed/simple;
	bh=MIU3owLLrwypm5/MgWUvunJsmR9PY6tV2qPUPU8aLZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QDNluFeds2roCYcx+wlJNdwwZzf2eFdfrQ+HW701I76gvXlZLVPcSm21FZ9wCAovfUIfsMQjmhdknlhhxqHuaJ4TolJ0ThQZ74ByXL4/ye6I3fSRek3fvf1Vq2omb1ngsI6Er8JdlCw92TuBJEVvNtJ5r1lbHYl8AjD5xVDpnZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HJMnYMS3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso16174165e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720813207; x=1721418007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FvuQrQGGQIwwog/EnWsNcgH7JSV94m6PJ1TUizGo8OI=;
        b=HJMnYMS3Nv+hSX5/QYJeog+MLpSwIUrVlyJzKagzQh2yQ8bGopGHHNOCQk+08rwvyl
         bZUKeGAuoNbuAmEdwFW3kzM/4ds96Q8mc2L1gF6TpYaAaUQgRMpV/otuvpPgkY5v28+x
         /dfdIABQavA8eMGrFtA2A2XJv5s3l2mkjUQJcV9ZfryPxupuKFWjn+Z+OFbAs2+SuDzr
         6Ir5clbdIIXMGfcQDg0CVGyN2H6cp4ZFuqaphAe+klUMT4meybiZP3vGnzCgUNCgvugO
         S4lkLiAyZ9GdXyYpxn2t0XZqffq9aIfCXYrJB+byhWn84NVI9MJJ8Kv62LJeM/kjJ/68
         8+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720813207; x=1721418007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvuQrQGGQIwwog/EnWsNcgH7JSV94m6PJ1TUizGo8OI=;
        b=TOjYlvmv8blTYDJ78JmpAhOfGmZIDtCuvUeng9c9Sei+KHLMQJ0xJGBOtre62pKjin
         /0zal3Y361zf9NhRfzqdb4F9trHe4FZcfxkjlXv7xNP9ZWa9dJvTROmaBq9vvPgkUG5u
         y2v5gL/7FxggRVcZFLg01dfyxqcz31yFGR3WJSMvIZKYjf1nB3YV0hdXQzUXq/8UCcJN
         2JY+y45FBTS1ImZN9ylIrS2zhvl7ecVqh0XT7O6i9pgusMRObNwpF5MYiyEdHVeXQzI9
         dOqg6UY/zV5DTRjnybWL8/Si4vYzNZQj9Ez87pwG3guCFhJqrpJF5aoEQQmXraTWO3E9
         fcaw==
X-Forwarded-Encrypted: i=1; AJvYcCXKVAmVM77L1D3+uNRAV9nNNo/1wnGEybXuWf87X1wfWg2JGFGU2yyhPv3DDh0qudPS9fEbILmfL6hC22dh3AEVg0mrA0gxur1vCqmm
X-Gm-Message-State: AOJu0YyXM/7v38dNuTvcTp2Zw6JDUqUnW9jPsFCHJrdcS+UtJIMHejtJ
	fVlJ4rCjD28SaZ+VvMY3eIPjDZojqPb/eqX6ZGTdy9iJjOD7nRqxRSpow61tM00=
X-Google-Smtp-Source: AGHT+IHNcSqKCNvMJWlQ3+gm4ni/DPQb7E7vc0oXSqOGorhg1y87UCQAfw7iqfKkb+xvsPeDXJZ4fg==
X-Received: by 2002:adf:ee4f:0:b0:367:8a68:e749 with SMTP id ffacd0b85a97d-367cea964ecmr9035312f8f.37.1720813207457;
        Fri, 12 Jul 2024 12:40:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ac5f:fcfa:c856:a4d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367df88b1c5sm8862467f8f.4.2024.07.12.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 12:40:07 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] power: sequencing: fix an invalid pointer dereference in error path
Date: Fri, 12 Jul 2024 21:40:04 +0200
Message-ID: <20240712194004.241939-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We may end up calling pwrseq_target_free() on a partially initialized
target object whose unit is either NULL or an ERR_PTR(). Avoid
dereferencing invalid memory by adding an appropriate check to
pwrseq_target_free().

Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-pm/62a3531e-9927-40f8-b587-254a2dfa47ef@stanley.mountain/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
- check for ERR_PTR() in addition to checking for NULL
- only add the check to pwrseq_target_free() as anywhere else unit is
  always set and if it's not then it's another bug that needs fixing

 drivers/power/sequencing/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 9c32b07a55e7..0ffc259c6bb6 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -212,7 +212,8 @@ pwrseq_target_new(const struct pwrseq_target_data *data)
 
 static void pwrseq_target_free(struct pwrseq_target *target)
 {
-	pwrseq_unit_put(target->unit);
+	if (!IS_ERR_OR_NULL(target->unit))
+		pwrseq_unit_put(target->unit);
 	kfree_const(target->name);
 	kfree(target);
 }
-- 
2.43.0


