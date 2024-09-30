Return-Path: <linux-kernel+bounces-343789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11727989F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7AB1C22037
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4977818A92D;
	Mon, 30 Sep 2024 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLKzlMdY"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A31741D1
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692512; cv=none; b=nuEV+MkJy1ATrncKMD/I5irrxrMwJRQOpt2DIwzX22FVCWT/N2kcCH6/3Rt/JhloI9kOTi8b2jUOIQ+emWg3u2xDdwITSQHCQi4F9VEP9B0pfwXLsRJBQPiOztHWwO7EbIzIfeEJoPP5ZYLFMiv8rTY0nGH5LA9tDKTdRi8x0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692512; c=relaxed/simple;
	bh=ejnBLgwJqqjFwgJjER+8c8E0QM4KFSEIDR4O47AjrSc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F39TuOq27KLLI+Qge4smpmlsPvUNeWFJ4tIhgfG5Jc1uGmljV6fAFzXdWeMKbRzzVCV8/yILwBO4+b5fJ8BU4fKDizFUsmHTas2dCW42pEsYI+KwxBO3hxl4jRaFQVePn8zneItqVQ598rUpvy0+eeqorbGhVJJD6QFMIfBj0rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lLKzlMdY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42ca5447142so6228235e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727692508; x=1728297308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lji+21mQIO7A8/WgDulZAHnUlZFcbKgkhCSPgy/WRJg=;
        b=lLKzlMdY7BMklU0BalUJ8Eoe+pYdCzTYN3tIgShCgqX+jcCTUU7tQZne6RmFx0t4Ty
         RWu3aTj6J6M1F5xU7MmXkC70scCMIRYiuRfPidNHIwrwo1xGdyYr+1AdjrVUR57dP0R3
         pUMKn6IRUy28KQ7AGlgRqfyMqW+ANVGwCJjuHqW+sHh/gqpjK+MlOLoUuEWyorNbWJoM
         cILPn5JnO/v4DrLgIjDHXlnz+6q2gHOc3OFiZRU6K7UgvkoY05MZz0No9SCjzUfd5VhR
         Ult+G27BEh7zYbS8i5n7X9wiya3CsLBWN8yPjGwvRL8bGnGa7c6RZX+drAxxGJp82YIi
         QTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727692508; x=1728297308;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lji+21mQIO7A8/WgDulZAHnUlZFcbKgkhCSPgy/WRJg=;
        b=UGbz0qvpaDX8lzK/G3JTp7kvqh92cKQwIfN7LgoO/XRZJHCdclLyUWdEsx0sDZLxQL
         mfIHvkXM8fE/QURrzW3Y4JrA2zfikVigb3uwyOd4lkKlhm4BPtRKmqsyCErO58fwxxaJ
         Ml4ivsNZlgYEbaJjmBRSGAagJR2lI6Tjbp3Uhq5eMQ8TwMDcT1JSoTPLucZc2Dd9vtSc
         8iXW2BN0BTfmtsGPb31+LduC+OEz5PZAwKusFfKnn0M0c9fxL7q10Zl16+bOaffbpWYb
         DIiolmFUZatjpyp5lRu3VP73MO6ykmcg+9z6E7eSom9qJT/vAF4Q0OJX1KAmK/yuILwq
         xSIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIWk2JCWVndypOdx52f6i3UH+DrdO9uTdNlAoCxtrALO9o7cCj7w7783skNvqevuAoqVYDf0SCyY68xy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwICFkE51i+pRHy0N0vtG+5+rispGCVl0VG4GsQHgTsE4IsCe6W
	XRjWP40mAej2Y+kHJZDSvGnR+LhhlMJQZ52kz9InhnJPvlyEA/meT2dSEe2XSYQ=
X-Google-Smtp-Source: AGHT+IEIv3YIzxOMyD91tGVpjiLG4v6GYnFW1k0S/haEur6YF7vfhxTGVB0CNUixANKDjBDthZ0ixA==
X-Received: by 2002:a05:600c:190c:b0:42c:b55f:f4f with SMTP id 5b1f17b1804b1-42f584981bdmr38307095e9.6.1727692508272;
        Mon, 30 Sep 2024 03:35:08 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dec11bsm100090265e9.23.2024.09.30.03.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:35:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com, 
 alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 sunyeal.hong@samsung.com, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240927102104.3268790-1-ruanjinjie@huawei.com>
References: <20240927102104.3268790-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH] clk: samsung: Fix out-of-bound access of
 of_match_node()
Message-Id: <172769250641.25036.8404145862785909939.b4-ty@linaro.org>
Date: Mon, 30 Sep 2024 12:35:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 27 Sep 2024 18:21:04 +0800, Jinjie Ruan wrote:
> Currently, there is no terminator entry for exynosautov920_cmu_of_match,
> hence facing below KASAN warning,
> 
> 	==================================================================
> 	BUG: KASAN: global-out-of-bounds in of_match_node+0x120/0x13c
> 	Read of size 1 at addr ffffffe31cc9e628 by task swapper/0/1
> 
> [...]

Applied, thanks!

[1/1] clk: samsung: Fix out-of-bound access of of_match_node()
      https://git.kernel.org/krzk/linux/c/f37d898d2cd0790a7328bb4865fba4a9810c75a0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


