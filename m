Return-Path: <linux-kernel+bounces-224003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 828FB911BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7BF1F260AB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1391C167DB1;
	Fri, 21 Jun 2024 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkmHfFN+"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D6D15A49F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951260; cv=none; b=T6fuPW7JTBjiKM12RVVicO9TmqAcovO1i17ypMeT9+0PNkkX0dUHR6PzcNPeSiKo+u/uBNfonG5hwTshmL/5BtDr7OAozBdBEbnynMxA8LLXHhCATfy/0uTWXNWV/3tBTR+n91WTtVmEU41fixbmDYBi/9jul7vPSTND8qbpco4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951260; c=relaxed/simple;
	bh=IwilEpxoWBhCfcRwNi6IPFn8TUid8ReCw/G+eRzc3ak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u4KUrp1cJKtK8BKLoPCortMy5nfG8oOmBTb0ksxerMpb0YI/yH1mjBrpCJLBrL5ZLOxQNuTydLdvwuPvFjDsZq1THcems/pxUhaLhp4FZXxBcU+C0CGZHE3hWoiPW1AIwsVC96fTxf4mpFD25vVcigzzgdKdRaMmXJAFX2SIWPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IkmHfFN+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3650f2e540dso1041964f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718951257; x=1719556057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmm2AP8HdLA0xcCQlwNYSdjRGs2bIdgqgz6HJe1wJBM=;
        b=IkmHfFN+ADXq9qvqUw8OyUQ4z101LNTLH5D057olDgsaT0yq7vC0fKY2jtxZO16D/O
         tGxVrolbUC1i66hqwKR9CXuHvRV4x748e5NSmaJ0Ee/KUw2YqUt7H3aQI5hQm+05zg7F
         92VMS/hevpzc/uEGWZmphqM2QkjcH2VzFjfvEdLKZtFdL8Q6D82K/YG/mbZHSekC+rof
         2X8zlWDvVHxGpev7sbh7d1caWEZwosOJd7lYNNhCIO/FuRz88EU1B0odISwfIcxvryp7
         0MXuw8nTQp60GmaZpUYPv4GTod9VWfnoUv22N0P87Xs5ydsV6pM/4rq8MkmoFrAtorA9
         V1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718951257; x=1719556057;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmm2AP8HdLA0xcCQlwNYSdjRGs2bIdgqgz6HJe1wJBM=;
        b=IjNJ/s7PFnDEuvDFFeyXR0SP51TYAafCXKzK9f3TEkzyX7ofSqi/IMAqxyKQnHQX10
         E82SuNtQA3XUPOI7+ikim59NDGOOub/BnVTJ2r6t8wV2G5eWeTFjiabA2r5n5dWScoSX
         EK28MMWHVM+PqH6/EQb7kKiGTPVlFExOepFE0ksRmhcazlrpIgQyURX98C77xwMw5YQg
         joa4FqqDYS809Lo47O+xYYIyF4LV9r18E+BcIaO8sByw5N3raGCltMYaMtKsf641BhOm
         n2tpNti0CyODHMNl+Yiq3MmqxPcAnAOd1RPFQpvLLXlB2DYLMWxRicAcrPTtNxXOBtWt
         uapQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzC/IOW7MYVA1iSO5sZV3MuIGVOzm3FJ2qK85M8KjAPPdn3ecDBiHxqf+mdHQJWAhnKhVqUkHKPJXR6IOjmp9+9BFij/Bmqt5KdDpf
X-Gm-Message-State: AOJu0YxQ4rr5TCT/aRHRvSXVhMs1OahtDm/ZBcjh61clmXAtHn310eFw
	7xNMPwRankCAmkPlApYjN6s70tmn2yPBUR8dVkx+/LcGMcZDz78EWb4CUHJlWtkROlB5H6AfiKq
	W
X-Google-Smtp-Source: AGHT+IGNuPtTUWoR/fyqtIISKh2Cu4R7v9ETKaekvIPXTadAHe0SolPNV0MLSDlmZ8gtZV4ZTWZwZw==
X-Received: by 2002:a5d:4e87:0:b0:360:89a3:5293 with SMTP id ffacd0b85a97d-36313fd379amr4629579f8f.0.1718951256942;
        Thu, 20 Jun 2024 23:27:36 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f68acsm814013f8f.2.2024.06.20.23.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:27:36 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, 
 sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
 shengjiu.wang@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <1713848917-13380-1-git-send-email-shengjiu.wang@nxp.com>
References: <1713848917-13380-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] clk: imx: imx8mp: Use modern pm_ops
Message-Id: <171895125570.3618049.5200843914649548447.b4-ty@linaro.org>
Date: Fri, 21 Jun 2024 09:27:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 23 Apr 2024 13:08:37 +0800, Shengjiu Wang wrote:
> Without CONFIG_PM, the driver warns about unused functions
> 
> ../drivers/clk/imx/clk-imx8mp-audiomix.c:363:12: warning: 'clk_imx8mp_audiomix_runtime_resume' defined but not used [-Wunused-function]
>   363 | static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/clk/imx/clk-imx8mp-audiomix.c:356:12: warning: 'clk_imx8mp_audiomix_runtime_suspend' defined but not used [-Wunused-function]
>   356 | static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] clk: imx: imx8mp: Use modern pm_ops
      (no commit info)

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


