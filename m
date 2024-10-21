Return-Path: <linux-kernel+bounces-374012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDCA9A6098
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26AA281ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C641E32D9;
	Mon, 21 Oct 2024 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFQQ6C4t"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C8A1E1C28
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504156; cv=none; b=M2quCzaf1uhI476KrrvNywTGFRRqfxFRQ1RAEnJ4lyzG1k1CS510mDGmq7Tt+cSu8U3EGRsQ2fWs4PTHhd3G9GtZRYiwob6NNPOsMlEQsWBQIft/V/+H4AVonGt2/lhS8vCqr1VjLnO/1hQeKu6O4vdQgyExWdVEswReHGJII0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504156; c=relaxed/simple;
	bh=Gj8N2dZGae8OqJpSRMhTyXNXVvdngzJYudBpM6aTxiY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=teQqgmJsttL2rBK+/SQ0mXlOlOj62an1OXZyntkukvnBkPFgYFy/r5NxRaehgL8j9QmaJPwLd24hA3jDs2FGfvaSF9wV7F8VZ+FDI4RHEjxhYL/jU/DW0Ojmr2WvFPZ+5GTzSYynnUW/1WXEimleAjbZ0GZRnolHCu9KtLzmurg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gFQQ6C4t; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43155a6c3a6so5687315e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729504152; x=1730108952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Dt0PKVA5FLKZ+3oYLR6FUUb96JY8lo+lEAfjfm3pJo=;
        b=gFQQ6C4tSjsa3kuXCCvbKQe+PePzmU8hH7LnHKdobd1j65VHaV7QpUZrzwBqerVAQb
         MLwIxP19H01+fJkg2Pt4ZPKtYG3cVF0k8/PckipF808WPzBMDZcMB+zJTKw+Wqte/9M9
         4uutNUXYg04GbPuttKMj3AQlT77cz4DTEBowGBtjyvl7vKsk2hsfXCgjNcWiq98l3lim
         QEkjHgMJSh9Q/0WeI4WBnfFXUVWE39R/ngJe4DHZs2BTRdsaiCEBrCDbKv0gHO5huMiu
         5/pe8IgLhsB5FgWClfyioB87aRmy1LcsN1IsYFa76lhzfZpojNQDL1BmXlxFH+rFzsoD
         V0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504152; x=1730108952;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Dt0PKVA5FLKZ+3oYLR6FUUb96JY8lo+lEAfjfm3pJo=;
        b=MS+RQEKg2tnUQDZeoBOPsuvFeRdrI8FZwl0gLtJQR04FzTbo6bdMRbn6GvXBp0f48T
         AH3pKf6OurN+X/31kvBSq2bcVq9p564pmqcoAT8wZJwrueBmhhQi0V6iwQOg+DjdWae9
         ZURut6PZxejNxVtJaKAO/PZ1Sx/uOphSnjv13AlRYzSftt192e4909SyYEwRdTQyC2GL
         MdT5UFKeCOuQLE8YYX8Cvtpr05hbZMf4TRvYx1D+yNPpd6TvYf4Dg9lN5yP6cn2Amb98
         4CWlDRRPYErMVih8TZ1WCtztGXwXxHm00sKS0yQAfsDI52k1o9VuT0uj29PwKiuh3cnD
         vlEg==
X-Forwarded-Encrypted: i=1; AJvYcCVx0T4LFyOjkIPpyEiMhbzoPHfC7vpHYLR8jEW25UI4lH5b9xUfdxaochnnIM+HIER0ld/ax+QxDU+Z6yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCyKE6VBFTrDWW35seeRSEDG8K4U78OkYgBvbUi52Q7pqjjEo0
	vj9XRg4ISTRp6hFX9ROW2cumQUgR9e2OsO3mZN9kqYuWbAohMPuR7rP9mjA21Q4=
X-Google-Smtp-Source: AGHT+IEYCsIBA5ybURDpuGmlpjBCB4GGptOhn+qWhkRSCHmFiYknTOVbFlAo9b7KtNdIpLz1gpmaVg==
X-Received: by 2002:a05:600c:1c82:b0:42c:aeee:e604 with SMTP id 5b1f17b1804b1-43161697975mr34443975e9.8.1729504151681;
        Mon, 21 Oct 2024 02:49:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c3497sm51399375e9.29.2024.10.21.02.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:49:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com, 
 alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, kernel-team@android.com, 
 willmcvicker@google.com
In-Reply-To: <20241018130215.487425-1-peter.griffin@linaro.org>
References: <20241018130215.487425-1-peter.griffin@linaro.org>
Subject: Re: [PATCH] clk: samsung: gs101: make all ufs related clocks
 critical
Message-Id: <172950414928.27005.6092400710266336381.b4-ty@linaro.org>
Date: Mon, 21 Oct 2024 11:49:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 18 Oct 2024 14:02:15 +0100, Peter Griffin wrote:
> Enabling UFSHCD_CAP_HIBERN8_WITH_CLK_GATING in the UFS driver means
> all UFS clocks are gated/ungated, which leads to the UFS IP getting
> into a bad state and being completely non functional.
> 
> Downstream these clocks are all left in Automatic Clock Gate (ACG)
> mode, and are not exposed to the UFS driver in DT. Enabling ACG is
> ultimately what we need to do in the upstream Samsung clock driver
> as well.
> 
> [...]

Applied, thanks!

[1/1] clk: samsung: gs101: make all ufs related clocks critical
      https://git.kernel.org/krzk/linux/c/6aff357efc2bb060e5b400774becfd3d37644b44

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


