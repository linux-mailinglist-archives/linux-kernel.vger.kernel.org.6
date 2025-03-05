Return-Path: <linux-kernel+bounces-547577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF2EA50B13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83666188669D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8936725334A;
	Wed,  5 Mar 2025 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HK//WSce"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD1204F98
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201782; cv=none; b=IQCrZr40rANVzT023PnZZeYXQO5Ir23bJnOpno/f4vTu6/ihWEH3BcoDZC36m6q2RGApIdU5F0Waxm/ruN71ibSuGfoUKWcOTmisUfiJoUzigrfICaQIjT9S908t+IRpriPel37WEeKQ0q61TUCk08Ded7NmnzkXzuj5d3zITYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201782; c=relaxed/simple;
	bh=YXN8hyLuHQAhrc9NEQKCCoyB39SPARw+nLAxEXiu7nI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TGQWghpzGkolpVZS5lI9NSfcDeFOZk+WRoIC1q65QaxKmEFlIB4nsdjXiw8bNIVHqt5tc0MCMhRsJHLo8eRB/JSCdlJuBAGCGvoChghC5K6PCPzx30Lu52yq4Cjudb91I9kP8qubFfKAGMVZ9gdkzOiksV4balbhM7SGczhhRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HK//WSce; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bca8cabc8so3338705e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741201779; x=1741806579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgIFZoxkbW0KwVO6zN97CfpiFd7piOBwwsm3LQac8GU=;
        b=HK//WSce+NmDOQYZFWgdWys+wby4qnHuMCS5n2Rjuhcya/4pyAFjzGvs5I7CHqcRgE
         CdjC8VZtrBOxUae7KZZencwDRWQP19KjHX/vZq3huCisginCQiNtENcOekHH07hNIqzJ
         LJ4zTJP7zNZq1zYgjGiL3GoqrMvxLH21LKzY49aX+GhTEesCBsuJZ8UrGDIskynoyNBh
         xJi9ViscitYAEmuX8oGV4TovYxzhZnDInwFQdkKQwDhOOVj9LkbaE8zuqY0sHHZLQSN/
         bNy5xVFVNi7KxJamVYw4htiZV8lyWq80236h7UAguTCICsfrDL3yrAlC5pUFMhz7yR0r
         2MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741201779; x=1741806579;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgIFZoxkbW0KwVO6zN97CfpiFd7piOBwwsm3LQac8GU=;
        b=B4avi06axJgQblQjZQc5jm0rF3iGLlOHVUAv7jzDL1LLBEQRkHzDl9mAgsuVFWK0Ob
         XXVXgAjuWreppfYo/2kSX4tnwuxkJzv7TiQ3OBqIAIcXmXmeFSFsqsw5RfKwAVH8nv3y
         64JQasd4NErGhA7kwEd7Ajx30ia0rRjEum+kJqKXG0CBMwrgPZMR+cXS4jWaBmgYsI13
         nwHf58ufnSAyH0JzA6V0oZA28klfSnhuvEHH9dl06E0M3T/TeqkIOsfcbTLLs4YXkMfi
         pr/UzHY7H26+JJy1oMXZr/GKOJegJOY6Ll0xz0E0Gfd/Db56KNFzLHzfUP07YxJPxTnr
         bLiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvhQUdCbnVrbPrZ1G9TomHw53Pwq541xmyCjbJG/i4UyOLPlBDKBZD8B6HokbtyhFzXhM/tGx+CMLEP/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/L0r3z6SmdP3eNVB5xsQ6ie81IObXp+9eRPhHZtQlBJiKq4w7
	JKS2dD44iEfeL+5jRTmcFxyvZ2fnMt2Shna0xMegrlUxtXqcpNWV0fLLu2tRTog=
X-Gm-Gg: ASbGncspLBdPvzxlAo2SPzkk3gjx1AN96vpsxmWB0bySO4NybsmZpXgXwCXHD2FDaJi
	mOgpjAGeth0b0d5M3I/D0ZJXKT6XyynHVuk8T6fjE/pkx7hb6ab8H7EMzL9HNzxLz+epkq96cpD
	LAaxcwTkbj9u9npHFUCAvif7FQqOGogSwkcTIYUS/S5dmydJJuVzADkyd2tMh/6VxdmV6Eys7wF
	q6E7XmqnfqqPeQDIhHYZ6rqyk97sVvsFfZg+0nns3fHRRkMs+PEYJwV2sjN1AmuCzRX7GV9SSrs
	ohCI3Of1tiBP62klZAHmJ3C6aLZMkwAlrHshsttwGO6H+RjXAINkSWRjYeH1
X-Google-Smtp-Source: AGHT+IFrSoo3gOE5FHktH87GAqLOOH8zzQprfwlqJYQydb/cjo2MTzmjtJwGHriaXSDaH9mOaM27Tg==
X-Received: by 2002:a05:600c:4750:b0:439:9b3f:2dd9 with SMTP id 5b1f17b1804b1-43bd29d8578mr15177295e9.7.1741201779287;
        Wed, 05 Mar 2025 11:09:39 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eb1sm25628705e9.31.2025.03.05.11.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:09:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com
In-Reply-To: <20250303-clk-suspend-fix-v1-1-c2edaf66260f@linaro.org>
References: <20250303-clk-suspend-fix-v1-1-c2edaf66260f@linaro.org>
Subject: Re: [PATCH] clk: samsung: gs101: fix synchronous external abort in
 samsung_clk_save()
Message-Id: <174120177454.75135.6216013717633178470.b4-ty@linaro.org>
Date: Wed, 05 Mar 2025 20:09:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 03 Mar 2025 13:11:21 +0000, Peter Griffin wrote:
> EARLY_WAKEUP_SW_TRIG_*_SET and EARLY_WAKEUP_SW_TRIG_*_CLEAR
> registers are only writeable. Attempting to read these registers
> during samsung_clk_save() causes a synchronous external abort.
> 
> Remove these 8 registers from cmu_top_clk_regs[] array so that
> system suspend gets further.
> 
> [...]

Applied, thanks!

[1/1] clk: samsung: gs101: fix synchronous external abort in samsung_clk_save()
      https://git.kernel.org/krzk/linux/c/f2052a4a62465c0037aef7ea7426bffdb3531e41

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


