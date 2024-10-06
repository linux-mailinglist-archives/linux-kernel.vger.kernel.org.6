Return-Path: <linux-kernel+bounces-352502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66E5992014
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88F21C21019
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B4918A6C2;
	Sun,  6 Oct 2024 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="YUa3z7Ee"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF05189BA0
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728236606; cv=none; b=P3vMbwKzIceHDpxGUmBdmZ0QbOVIB3wR+Q7x+ZxGbF1sd3hoH0D3Aky0pOnmgmpRvLQ1CTM5k+bykFb5GsrtNbsZQNAVC8isXu4Dj74NyTNNE7iGJ7QiT821bR+Uo8uyTtnibPIuu5w6w33lqggdpIQdkv0JdqfIeliSLxyHjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728236606; c=relaxed/simple;
	bh=1mJpiNVP/4OrjcFTAp0TvKU8K5r9YHdExKD16255m4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+C/JbCRjIz1FGzgBt9x5wc+G97QWpn1ecMUBuDsiIcQf8zfSaW9Mb3a/nmoDXU2v1fyRFJav6l4arosQHIPyFFMCqVfGCtQUOToKeooehmZyvRDYkl3gIfleTy2JQV1tAlspOpyRxxyPHFV1hjKcpad2JtyPHpcEmPwsB5WNz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=YUa3z7Ee; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e02249621so217529b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728236604; x=1728841404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2dcGg6sikxvnM8Tn6Zg71r8Ca2eyP6yTGUfifpMwTY=;
        b=YUa3z7EeYanq21vQXUg4wpHNmxbWN/+1SfThcZxzQ7DuowGiOyI8PPsjGODnWPr36F
         7PTYzYe9youthA8nH3GMl9V4RiZu/dlKOtIQhKAuhH7RHtkqihVILd4g/f+O7y0gkZDR
         3E894HBMddwrAY+HgskvOWXbbrF+W4UX2bX6JRCqD4VaazFZJlom8d+mcwS6DBwgZXKP
         Uioku4k0DCVsqyMFhjUvlzaTOaZfaK6XBCKuiv+n8ybfG6ZBRt2aBi14BLXkpKEUiJfU
         Li/pD0FNVpxtnkmHAkwjYBaM3IDOp5tM5vCNhEybQ4cfyY9qWJbvNO1GDyzQYx1M5cgm
         o80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728236604; x=1728841404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2dcGg6sikxvnM8Tn6Zg71r8Ca2eyP6yTGUfifpMwTY=;
        b=NZ3IyqDg8o3U8FdVZlCdY0aIG7CbjmEFbAEjko4chgY5XSxOfLlsl9kKWfg7aH8Md2
         SLOBf0N6FszcQU16q/5ZtYWwRzow8WSHYa3uxBJy0nJfzCeNMic0qJkCUUPtuHKFug5I
         96X2JgI/IGzlubAAZ7dELlhfzb4reqKHXevqK64tigKqGhM4mqwCXoArJutcxbDna8DU
         xq0uuDhKPu6Wb1hbdd4UyPsz/5yAG4KXM8gc5s7LMHOQo7smZhXUCSXXSQ6Fzcd1wpUg
         bsN5B78a1eky6jEPB0G1IkJfuGtfm4/ZDOw4qo9M+oJEMCAKPwcP0zo8bfEJWfsPOj8N
         FHYA==
X-Forwarded-Encrypted: i=1; AJvYcCWCmCYHgTHs1rOtoTsOwDndzB95lLSz/JHoZOl1ruEELdHTBXbrMFOPfDt3SUZSdtlCgsP4O9aE16hdunQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi1joBRzdxSbth9Kv6ktoX/8PA1PicEIyDh4BkTxrGCmKZVNQI
	zQ1+WtF5pqtvB8XGnHFkUGTm3T5plef1iMyyE4eknCqVRX17iMFlWoCdmbefiN4=
X-Google-Smtp-Source: AGHT+IEW4o7tvLckDilWYjuXJtcfmQwtg0eJys42bHOEUexDRrnhKPRGjs/rA1lE+MfbcUv1uwJCiQ==
X-Received: by 2002:a05:6a21:a34b:b0:1d2:eb91:c0c1 with SMTP id adf61e73a8af0-1d6dfaef79cmr14944850637.42.1728236603796;
        Sun, 06 Oct 2024 10:43:23 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d6526bsm2999591b3a.159.2024.10.06.10.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 10:43:23 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Sun, 06 Oct 2024 10:43:21 -0700
Subject: [PATCH v2 1/3] pinctrl: th1520: Fix return value for unknown pin
 error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241006-th1520-pinctrl-fixes-v2-1-b1822ae3a6d7@tenstorrent.com>
References: <20241006-th1520-pinctrl-fixes-v2-0-b1822ae3a6d7@tenstorrent.com>
In-Reply-To: <20241006-th1520-pinctrl-fixes-v2-0-b1822ae3a6d7@tenstorrent.com>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.1

Fix th1520_pinctrl_dt_node_to_map() to set the return value before
jumping to free_configs when an unknown pin error occurs.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202410022336.xyWlV0Tf-lkp@intel.com/
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 drivers/pinctrl/pinctrl-th1520.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-th1520.c b/drivers/pinctrl/pinctrl-th1520.c
index 9331f4462480..265a75a78d5a 100644
--- a/drivers/pinctrl/pinctrl-th1520.c
+++ b/drivers/pinctrl/pinctrl-th1520.c
@@ -499,6 +499,7 @@ static int th1520_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 				nmaps = rollback;
 				dev_err(thp->pctl->dev, "%pOFn.%pOFn: unknown pin '%s'\n",
 					np, child, pinname);
+				ret = -EINVAL;
 				goto free_configs;
 			}
 

-- 
2.34.1


