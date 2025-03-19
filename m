Return-Path: <linux-kernel+bounces-567397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73868A68573
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3141F179F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1437024EF61;
	Wed, 19 Mar 2025 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6JEIqll"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B4524F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742367955; cv=none; b=UR4KHaGbl0VblV11B3StTUkRy8HEmIrFbwC0w0mYocAREiR3ZhN8hBhGuX9oXzVbs9tohH4fow46EVW2dPuMlYwZd2yLEU3HKZ43PaloDnGKbm/d4NOxmFoYsDDQUYHrMjv2a9QFfjIxhNmB8j0kWbxWqYv3PfLQ+T0+R+rvVfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742367955; c=relaxed/simple;
	bh=NHmVxf51ccPygdho6qBOtOezUpa9NGhtd7AYhIOwcjY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UJX/AIeqq3UwowEALH44Y+nvnuwQROwBG9R3lv3NA5J9pGetxN7D0i/W777e4EM0wTxdYHXwgcx0g7v/gmN6zgb0hLTpi21mnDgM1nj+UHZ5spiRu5ynpACg0HzwFYLDbGUlVkuhlVToFQcmlAfMirEuPu0AvDknRY7kC9wtrR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A6JEIqll; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d0782d787so28926845e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742367952; x=1742972752; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWcdnlxlz3RiOr5CYldhEXdBAGdjzbvGPeO0bYglxBw=;
        b=A6JEIqllxDnqhkdDdhnqnJ+zjkzBHlqwhgKtSbeo3D7e/DO9CscKEgUYoJ3tRoSHTv
         sWnKfVNZjH9a4YsFKxSabRuwzLNUXsXb3eDEAHj5JQT1Nk7cP65B8RL5Mg4SvteG5V2c
         PouK4Q8uncax/OXIiI4LUtwty6htzmy8SJdgEjJkJ9HB3NQUZ/3DO5/5WzsmsZuwe2qM
         NIlMpL+SRMKQMAeoLIZnKdbEWh5BtGIG9oZz1RqitcNxIB4YFTvv2NFS4nMd7DIU/QO8
         MIZCF8eK+RyctZvInXcrUQxHiDrgDGSlaA3Uau6FQygnhH81HDLC8sR/1KWwbhMjjLBp
         BfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742367952; x=1742972752;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWcdnlxlz3RiOr5CYldhEXdBAGdjzbvGPeO0bYglxBw=;
        b=o05VNmNTUEbOeTIzrdqYXmucphxIYI9IgImQYoIdvgycA4fcC7Mb5bh7lcLdqFDsFZ
         zw1q/mRrzSo7ws1gVhkDsRaRcoJ/iHulC9MFOA6W9y0S0hEXbc/Jh3AYJRYo5WX6svdy
         4V6Z3LvKfkiEOAOiaZCcunBzchYuFCKVZoUz/0dltsUZdugRIzZtVJXn6Nsys4NAPQR4
         a4wzUkr/cRlHe2H3ma4v9gE/7VZSASIZ8pRTodx/sEv9QQPlUweP9GwV6xS9sbL0Vnwd
         JHMggDyV1LlxXzSwNXkSkdNN2JY62LPFJL4Blx3xy9qTwSmJ5eN1abG4vWZg5WWsdF2e
         qmKw==
X-Forwarded-Encrypted: i=1; AJvYcCWN1yRoHGV4H/dlemjLyFAnC+hEHmbJ9c5ZXxXEokxe/2sVuBSNWNuCiTFkKdKBcjCTQerUjXcdh5iNdBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhlVxY5mushqpsl4sr/6QC2VAhBHTQZ5MW2Pxp+MiKFOgoTpxu
	Uy9IiM+BqEO0yVPc5JP74sNVSEl/pEEmD6Wqf7s4E+cZ6X5vuYfsYunGWpsP+3E=
X-Gm-Gg: ASbGncvGxnc8pS93cWhn3oj8slpmFQZGpbaaYAt/EQVnKpiZEfVYvEpRNDcHzgVnmYJ
	t8lFl79k/OKdAchTx8mONSqMiT9sVm9d9BUkjatxCQ3h6Qv2D9cnKV2T6JwEFtKV5i3XY3lWct7
	N2KBnKxDE9FdzY+JzttZJGfkpf4/73hf+Hge1sVse3I8/KxLsHWhSfM67IcLR4yzJLZacNtnn62
	cFYX0CjCEU1C++m0aV2xD2bFprWdPTOSpV7GOoLOPdmD4Gi7QTwvn3OWrLfox/6IThqx5wc5rU0
	GZsAtj32zW0/P0iV7kmzN5N1DHbg1BZRX7G+emQ46s4osJAUPKNvYD38juyM
X-Google-Smtp-Source: AGHT+IGk01nY8D5vZYwPJQciTgqBS35i2lX2QwN2d+aG31PMswpzNbfMSH2RxcqCh5zyBjomgO3hGA==
X-Received: by 2002:a05:600c:1389:b0:43c:f6b0:e807 with SMTP id 5b1f17b1804b1-43d43869a32mr8416005e9.31.1742367951811;
        Wed, 19 Mar 2025 00:05:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f331dasm9816055e9.8.2025.03.19.00.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:05:51 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:05:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Prathamesh Shete <pshete@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
	linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] pinctrl: tegra: Fix off by one in
 tegra_pinctrl_get_group()
Message-ID: <82b40d9d-b437-42a9-9eb3-2328aa6877ac@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This should be >= pmx->soc->ngroups instead of > to avoid an out of
bounds access.  The pmx->soc->groups[] array is allocated in
tegra_pinctrl_probe().

Fixes: c12bfa0fee65 ("pinctrl-tegra: Restore SFSEL bit when freeing pins")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pinctrl/tegra/pinctrl-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index 0246acba7703..11ecbd6a9b2a 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -306,7 +306,7 @@ static const struct tegra_pingroup *tegra_pinctrl_get_group(struct pinctrl_dev *
 {
 	struct tegra_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	if (group_index < 0 || group_index > pmx->soc->ngroups)
+	if (group_index < 0 || group_index >= pmx->soc->ngroups)
 		return NULL;
 
 	return &pmx->soc->groups[group_index];
-- 
2.47.2


