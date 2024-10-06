Return-Path: <linux-kernel+bounces-352501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A54F992013
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B841F21A8A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6FF18A6BA;
	Sun,  6 Oct 2024 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="HtgOCbPE"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF89189F2F
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728236606; cv=none; b=PuHq/odUmLvOE3lFQwpeKI/QabvcULvyenQs8KOOM/XVDP2/zgeL5jzBfZO+SFBC9ICJqw9CFkRgV4YXHW/nCRqzNPKJIi1SR5pHdK2D96loAgF6nQW/tmnSMf8tAwXPLVRZ8vpykFzhyleVipmLT1VLmWPrS6bd9MywON0MF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728236606; c=relaxed/simple;
	bh=F0fzJk3goWwHbOnHvEHn53C9HzZ826eUmoIuPWYk1H8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i4Hx62ulbBbH+vfLs8MulEO1JYBRdEHmB76A3tiKxxgDcT49u84QM6E0yv/6sxTd8QntzGKyrI7G/a7gU22EFrwWWQSX9DyJ16F40STUZb+w6kzzesjldIzQcW1C1w+ZbtjzVFxtntx9YU/bPZ0gOfKaE8C6Ga833xHtu9NkNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=HtgOCbPE; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso2196640a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728236604; x=1728841404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0aqH8Nz3YTxyf3WOUwJPMSHP7Sz01anRaWLkW9KhzE=;
        b=HtgOCbPE1dVQ9uW+WNMQp6KdjucYMffvWeEGtq3GBC/ldFRWrfhaQZdz+G5EtG0omI
         L93pk8csjQgNsd2gHWDx7CSyF2Xt88odrNPIGKEIcdruGc/ha2gV7hCyWEy6HhY1FTEl
         9tmpkOv9Q0yxpttSFjThntYLkbWGr2UjU9EC3SJEDqtikfOqhuUA58/ny6BQRGAQVe0R
         uLGuWeFjiiHycYoyIlyQ6mDwCKtQiRDChEZmnAoKy0ip5SQsXPbBhCmI871W7/Rb3ZMT
         fV4szf7YUrUc/3kBPyLhJ098JbQL62gkNsO5svK0Ig7D1UwsPmV6atT8hKsJWHCD9Q4i
         LqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728236604; x=1728841404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0aqH8Nz3YTxyf3WOUwJPMSHP7Sz01anRaWLkW9KhzE=;
        b=bplvpwpRoXDLYveOUbB0VYP+KT7VuBF951NNzH2qVIluGjm6nRxnig/yR+Fm7wfXOj
         oUHdSpzXkm0Zvtt7goXmULv1d/EZF4+XnVCty9OcivBIDJ6aPpSd9PL70dYud9QkdTs5
         9hQ6Bz5N/ld6XA3br+n33XTBqibJuKWXahnw2hfut6kt1T0KUof63j+DHrhDUOKTtp8v
         zcWkUG64AVpZuVbhvNOhpwZnXJROGcvi93xdZSB0c+URYtsY5YTJ9y9KnPYkn3cFelQ2
         zaLAO8BabcCKWQ6+PE0HbSnJcLlGmCdcSMdO9CktCZArAfcbmgQ2+RZg2ZA2FEabeDvD
         Rlkg==
X-Forwarded-Encrypted: i=1; AJvYcCUsSNPmaAKSPNo7zVyRzWlQs7pmSsV217mfFnLK8VVi+SAjTUXO9o8Ra1Ik4K14cDB2jRWclWOJkkXNyic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0R2DWP75I/L3luVaKDMck7cCKv2B9JXwfyA+KHLCZu3FfYE+s
	FzUIkauIfaeCrYAeDmYyqc9l3MgH5/ZI7yDTkqt1v4C39nChc34Cw3m7CucYMzo=
X-Google-Smtp-Source: AGHT+IHVc4JR7QyWPEo99nCtTOnKJvnv2SE8G5Rtxbg+iGO4JRlQKbzCRbb7fdIDCqesN12taDtiuQ==
X-Received: by 2002:a05:6a20:1a9d:b0:1d6:e61c:23ec with SMTP id adf61e73a8af0-1d6e61c33e0mr7436331637.6.1728236604624;
        Sun, 06 Oct 2024 10:43:24 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d6526bsm2999591b3a.159.2024.10.06.10.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 10:43:24 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Sun, 06 Oct 2024 10:43:22 -0700
Subject: [PATCH v2 2/3] pinctrl: th1520: Convert thp->mutex to guarded
 mutex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241006-th1520-pinctrl-fixes-v2-2-b1822ae3a6d7@tenstorrent.com>
References: <20241006-th1520-pinctrl-fixes-v2-0-b1822ae3a6d7@tenstorrent.com>
In-Reply-To: <20241006-th1520-pinctrl-fixes-v2-0-b1822ae3a6d7@tenstorrent.com>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.1

Convert th1520_pinctrl_dt_node_to_map() to use guarded mutex for
thp->mutex.

Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 drivers/pinctrl/pinctrl-th1520.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-th1520.c b/drivers/pinctrl/pinctrl-th1520.c
index 265a75a78d5a..7ed3f82b9339 100644
--- a/drivers/pinctrl/pinctrl-th1520.c
+++ b/drivers/pinctrl/pinctrl-th1520.c
@@ -444,7 +444,7 @@ static int th1520_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 		return -ENOMEM;
 
 	nmaps = 0;
-	mutex_lock(&thp->mutex);
+	guard(mutex)(&thp->mutex);
 	for_each_available_child_of_node(np, child) {
 		unsigned int rollback = nmaps;
 		enum th1520_muxtype muxtype;
@@ -531,7 +531,6 @@ static int th1520_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	*maps = map;
 	*num_maps = nmaps;
-	mutex_unlock(&thp->mutex);
 	return 0;
 
 free_configs:
@@ -539,7 +538,6 @@ static int th1520_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 put_child:
 	of_node_put(child);
 	th1520_pinctrl_dt_free_map(pctldev, map, nmaps);
-	mutex_unlock(&thp->mutex);
 	return ret;
 }
 

-- 
2.34.1


