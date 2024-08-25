Return-Path: <linux-kernel+bounces-300403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F8395E349
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 14:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213861F218D6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6AD156F42;
	Sun, 25 Aug 2024 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MxuFnpTy"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF5155389
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724588538; cv=none; b=E+VHyVJtIhmkx6tLRPBAN160Q0rjeLdF6GwQPTmhOpauZezSQR7aHnRYm+JWTg+k7OrTWXFQxywkE04KUMJsWLLBPQfnjfQzU2CrfF2HdJuc/1lb4IkSfQ7d6RQV+HqT7jT6dijgEb/9ewlG2E04QHNdCZuNwQE9adbG0NzMZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724588538; c=relaxed/simple;
	bh=FWBbTWDTF6cDtrzQbyZLTrQCUrCkvuS4+bTaMk774To=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mmsw6WTdor8TbLNJ5tJywSjiAChwq/7b3UxWxX171eq+wVmlCWu5r/lUK7ipIsYXI0EJsccvmLYBZIDd8Py/UCw8aElirC22/7Dz+kJ86FSkbSyZZccXfIvIdcQJy+5vuyEXpetu2jCYOwgQdkdHUwPIjh5ChPzIAF3BsG9w0g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MxuFnpTy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428e09ee91eso4236305e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 05:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724588534; x=1725193334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmOsV0yImlKoC69kweQVAT3xtLfWBJj1u/3pWJdp1ts=;
        b=MxuFnpTytfw9AJ+gAylcSs8qCOZrYLscRbL20ECTnYs2qW2wdTB+03/Re004yF+45I
         c7E7yL5q2S9tFTUmUvLcOTaokxaA8CeVp/TgD2+emPoulqO+sEIdRD/xSnc44MLulDAB
         jFOTineEGyPRu6NojTd2IHQz012VkNaL8y/CqnH0dsRWV25SQ+5jit8yj2YZWHfdp4yW
         qrczhdT31HSSNtZEn+SimboO4PyIadPrZc5TSPA9goK7XJt6PpjEyDC0u0lMv1zC1odb
         22r4cPEW5J37Z7TZ7kUYgnzRUx+eLRqjcFvNzKwybTIajUx8xL25u+rlk5YU+I4SHdWF
         ZPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724588534; x=1725193334;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmOsV0yImlKoC69kweQVAT3xtLfWBJj1u/3pWJdp1ts=;
        b=S2dDpPbZmv6y2wJXyPgxS6paUg3W2jXuqXLRNpvGdqy5O0L48mnSq0LGckA4ngvLlS
         oEDFxmBp0fUFZzfLPJth62fC48F2d+AecM2sW7QnIn3Vx1wLmQJE8Up5xe8kBW08q+Cx
         AnaOCglfDXeBpXYn6m2HRh9dSk5Xq5oAo3bzHG6pMqbSf+glni6XaoKajsgVGOqtGwnP
         U9iOLMgxFqOxrOMhWNF7QSF0QnJQfAllhisfKQ0jJRfio8T5ZHQnNoQGD3g2q9EyLPLV
         Vi0Z/+7Y5W9+alCpdkQ9w7i1icN1gNIQY9JZx90L8+MhvKCjwL4+L8XKWjqSXFyqHXxM
         FPpA==
X-Gm-Message-State: AOJu0YxkcrZXR/fAn0XUVL01q0udQXBd9yW2dR3FzQPoRiCDJtW4wECy
	VewRTdqFlgborFUNrxyM9jOu2Wi+/dPRORlBulGeDr+XKW7hE0ETuv7U83z/1GN0877tDRKv6/z
	W
X-Google-Smtp-Source: AGHT+IFern2xtsYagESwPRT1Z8RlfPFyAaudfiuCdSo22l1jDMZDhJlrQPnKSfT6K4z3f+2OGeIsXg==
X-Received: by 2002:a05:600c:4445:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-42acc8a7756mr30856035e9.0.1724588534380;
        Sun, 25 Aug 2024 05:22:14 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef81777sm156774065e9.27.2024.08.25.05.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 05:22:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20240824080235.56472-1-brgl@bgdev.pl>
References: <20240824080235.56472-1-brgl@bgdev.pl>
Subject: Re: [PATCH] Revert "memory: ti-aemif: don't needlessly iterate
 over child nodes"
Message-Id: <172458853245.37697.15563719161583396830.b4-ty@linaro.org>
Date: Sun, 25 Aug 2024 14:22:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Sat, 24 Aug 2024 10:02:35 +0200, Bartosz Golaszewski wrote:
> This reverts commit 23a641d5c2bce4c723fff9118a5d865ee6b9d05a.
> 
> The first-level children of the aemif node are not the device nodes (ones
> containing the 'compatible' property) but the chip-select nodes which
> instead have their own children.
> 
> of_platform_populate() will skip such nodes so we must indeed iterate
> over the direct children of the aemif node. The problem here is that we
> never call of_platform_depopulate() as it takes the root device as
> argument. We only have an unpopulated chip-select nodes so we will leak
> these devices if any of the calls to of_platform_populate() fails.
> 
> [...]

Applied, thanks!

[1/1] Revert "memory: ti-aemif: don't needlessly iterate over child nodes"
      https://git.kernel.org/krzk/linux-mem-ctrl/c/c7d2f3fbdf59b206414ddc306b0fb74cd174c0ed

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


