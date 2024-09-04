Return-Path: <linux-kernel+bounces-315495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377DF96C34D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694AE1C22442
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1771DEFC3;
	Wed,  4 Sep 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCJqYouR"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152D1DB55E;
	Wed,  4 Sep 2024 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465766; cv=none; b=DoKqaCnwPlcZ1iGLE/juezKWnint4SU8sbhJyga54jcxoLled2w8cZd0Go+Hj4UpxB0I0UtBgQ9/iA81Ko9ol/qTOsYsnwMBkjqjfTzA02JEp8dlXFw8L+5SAyLqgWyemixdR3CQ+rT+Qd5UEbmJhSWgobQemif1g6rf8O++X18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465766; c=relaxed/simple;
	bh=8SkNDU6nkUF8PGmbkWpT1LhnqmH6GzGGxCXrKJxped8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y24/xk/P65RvzrmEAXrzwrk48Z8Xvt9UAo25a/+6o+hy6lIWjSPmBNiWHZ/VL6ZMB4sh0cf8/3KT7VRHrSBVLjd/NLf2wSjKX6dYEemNEwm1wWGTbm6nYhRSvIqGmykBjmHeUy5HEAaCUhaMDUgcMEg5Pw8LAzfc0KfJkfLdIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCJqYouR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a868831216cso812918666b.3;
        Wed, 04 Sep 2024 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725465763; x=1726070563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9gknafUPGqDURGko76WA3pPLTeVISnH2mM/eT9AOYM=;
        b=mCJqYouRsJEEZt9nmkpL7aYrVD5ZmA62oapAggWDgNSX3M5YR2p5TYtyLWaLlY/QFb
         0YYIqHHsvHLTXlpkvN/Le2GaQNhzCPW/AyEdatZnbpYk546uiDnyWiV7dTPepqb8yGF5
         YdUfEuHuc/NZe7LhUMf8czKgMTeL25hRnqD8A8f6gPjNe+x7gQDJOu0z7doQaftK3TF8
         6aCTL2PMoQQMu38cI65R/zHigD+vW99TsPDUMjk4O27FMbEeFlLMv3RG21UOktaYkyqp
         lCU69jvpzneDbFt+vH+hrErN/JOAtlHX9/d95Gs9avzZ29zN3g5N1A7i/LOJvHz/TRj3
         KFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465763; x=1726070563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9gknafUPGqDURGko76WA3pPLTeVISnH2mM/eT9AOYM=;
        b=UAduZ2kURD23MsVlrjsuGX87YCeRUcyc4bllQOOMW/Bhpx+nKiXFA1MBYM2pJuUwZF
         DdLtpLLV4HKUqikMXLQegw6i7bZMHp4owZUNooHhRj8vrdDAvTxs8FMuoqyKVZ2tZf53
         cF0gLcvhy6MST1xNQam/PIFpKD8wIu2ZzoVwdCfUNOFOaeBiY0HyCyjE0zL1jcVR/v1A
         oErorTN37Oyq2qloG/x+PGxs64pNBa5HlK8jKExNoT2+sHlxCq05j5GvNtTN/5tVUrRU
         OUGZgY8HbWOfLDTSu/2Zi1bDl5FdiQ5Lu+nBZO2shBvtjtCXT62S5bzojwSeQqAD2Af1
         /v4A==
X-Forwarded-Encrypted: i=1; AJvYcCUnBlpmjG3pvqr+Rs5zUMB2OeJRbaTY00zsyrSS4x+HSNmJLZWFCkaYm90O6XjRSmScS6gfkjyvoT49jF/b@vger.kernel.org, AJvYcCWbsLzkBuDnWXEQy0TKVk4OfhLWOKXn/MR44Zu05x/jkfuPJBsbJKiCzhxA3445OUdkEKf7RukA8R5e@vger.kernel.org
X-Gm-Message-State: AOJu0YyDh92DvPqCfFHlOnhzNNx3LZ231fyUZi5kKKyWTI10eOhMzBMv
	0BHq6msgHalQ8Pfr5PDHp17QVYqWchSeYwjxFnnEHs9y3mu92ftp
X-Google-Smtp-Source: AGHT+IHKP+PsuQ6yxiJLyRRbeKQzi/W2VUC9EHgrN50+DpTfwvr7L3nQktMJWSTQnHiQu4lFj+xXkA==
X-Received: by 2002:a17:907:3f24:b0:a86:78fd:1df3 with SMTP id a640c23a62f3a-a89b972ba01mr993062366b.59.1725465762759;
        Wed, 04 Sep 2024 09:02:42 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623e1800sm7945066b.193.2024.09.04.09.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:02:42 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: robh@kernel.org,
	saravanak@google.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 0/2] Use functionality of irq_get_trigger_type()
Date: Wed,  4 Sep 2024 18:02:36 +0200
Message-Id: <20240904160239.121301-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
	- Split patches to subsystems
	- Use DEFINE_* helpers to define resources

---
v1: https://lore.kernel.org/all/20240902225534.130383-1-vassilisamir@gmail.com/

Vasileios Amoiridis (2):
  of/irq: Make use of irq_get_trigger_type()
  of/irq: Use helper to define resources

 drivers/of/irq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)


base-commit: ecc768a84f0b8e631986f9ade3118fa37852fef0
-- 
2.25.1


