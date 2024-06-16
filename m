Return-Path: <linux-kernel+bounces-216157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0053909C11
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 09:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41391F22A6F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 07:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC28A178398;
	Sun, 16 Jun 2024 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHyQNrr8"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42416DEB4
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718522655; cv=none; b=sG3HwZ/deqyF6LCEQ4MScvDOJyZCzfC28NliPyxWBx6X1WKBEajV/YDoJb+mSvLSMWudWxIIiBAnDd0XxsPX810fmYi7rWc+Qikzak7cbpPW/+zxVKJ42t4OUiZj+dohFr0cJ3GC/TGZ9Xt9keHgoMLqMQSSvJ8fklmzygTmGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718522655; c=relaxed/simple;
	bh=3v5X7OMLawldb7SFk/J4caXxyFYfI65QW5lRP9eUVkE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hN6EjImx61RDuBxevm7t+jc6biZf8rhJxN6yGDFfH22SeTuc9jYJ27Q/z0Ws1RybWeuRzfOdrEua7THX38OmdXfxPgf7r6/ZZkMiOSMbp3wphWlSmxQkleGRReMIEv7917UHKZVyDPvkXY/nv4li7QFZl4ipmuf8ZePILlINjl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AHyQNrr8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f176c5c10so405390666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 00:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718522651; x=1719127451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3+k9sB6bIvCFm1HjBgH8dCg7qh1UZx1fKQ1LomFQ5M=;
        b=AHyQNrr8yrumRYU2ogrz02u6cpS5bP2nOi3YH+b8HSf8szP67uNY4s63TWlQpeo04E
         gzhtXyZKW8MxF9Vjod62dSZ9bB+LDo6qIK157ROEDOBu7R61t7PUiUnmKs7AIFI5I5Wo
         M05ftIBNXi0j8VKaqnf/V+0fWP9dbT47WXcw0RQE4mCOEpJUkp7T+suK+viSzUjSLr2V
         VXn9Z/BMkn7KAzuDeT8Url61KExRj6CkYO+SznWdDcvuYBuTkBw9wvLjuu5axQlr5a6F
         GbNzxoL0f0ZEozCHYFB4B57jD49pYAohx0uPK/GESA1il7ezyHOEWuzDarOkfvnRLjVM
         xlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718522651; x=1719127451;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3+k9sB6bIvCFm1HjBgH8dCg7qh1UZx1fKQ1LomFQ5M=;
        b=JPfzldLzySOYSAE8xmHCB9mqoUEVjL0ExSpp6pyIdFbSMqBzC8paINAuZA0aywvabL
         bFbMNU83x13Xex05fJHhNMpM8yo6GARFrnbl3pj9oyN45fdIrZuZBmKlkv1LwP0dKpuC
         EceRtLQ7i5Vs0YqbkloxLa1GsfifykqbLJcT0SYUJiXhaxLrJ9lAheJgnsVkT+yw3vLD
         fEf5M29tzpnZlDBP1T+rGvLt4SEDGkG+ne00ByxO0aJ6k83lqAWvmJVDbjUIfHje7ZVY
         ZkUJ4iJCdvtVUL3wjo6VbEDePdP9mkqMW2hUZQqJqKKQnHmlVqJZM39GxP51woGrtkJx
         1+ww==
X-Forwarded-Encrypted: i=1; AJvYcCU4F521Q11b9IadM2z6TjUal8JHCAit/BLXW7TEsyfW95KV2RAYuDqKu0Z/NG7E/4TQ7g51ib4GRODJDzuXrjnUyIz/PLVQ0N8jc8wz
X-Gm-Message-State: AOJu0YzRfHRbkC09AwWlfo6QEKNMJKPTv4TyPOsmaU2f3hGsmApxtTWh
	u626BGwHI/udmvglBjikZqcJMekboWWl4PcHIaRuepgDyyv5VzLpJdaAPZrGhHmrwnuC/Nzn4QO
	L
X-Google-Smtp-Source: AGHT+IG6FwqrVyI5Y84CmiJBAmC7qtLBsb1k75sJ/5JFgxqCs97InBwD6RcdfDPdrerJqC+hG8FgeA==
X-Received: by 2002:a17:906:25d5:b0:a6f:586b:6c1 with SMTP id a640c23a62f3a-a6f60dc56f0mr429149466b.56.1718522650779;
        Sun, 16 Jun 2024 00:24:10 -0700 (PDT)
Received: from [127.0.1.1] ([78.10.207.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f5f8f6eb3sm320840066b.143.2024.06.16.00.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 00:24:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sam Protsenko <semen.protsenko@linaro.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20240606161028.2986587-4-andriy.shevchenko@linux.intel.com>
References: <20240606161028.2986587-1-andriy.shevchenko@linux.intel.com>
 <20240606161028.2986587-4-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v1 3/4] clk: samsung: Switch to use
 kmemdup_array()
Message-Id: <171852264936.6236.3386941184729055865.b4-ty@linaro.org>
Date: Sun, 16 Jun 2024 09:24:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 06 Jun 2024 19:09:33 +0300, Andy Shevchenko wrote:
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> 
> 

Applied, thanks!

[3/4] clk: samsung: Switch to use kmemdup_array()
      https://git.kernel.org/krzk/linux/c/7666718892f2a8582127f584fdbf5dada59af2d8

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


