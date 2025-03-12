Return-Path: <linux-kernel+bounces-557602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE86BA5DB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE2B189AEC6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4EF243956;
	Wed, 12 Mar 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8tTnLeS"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE77243370
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778720; cv=none; b=af7+Z+B38Dc5obg8A0MtswlAo1JUR36W1G6z8vERX8MT4QAM31lcwcqKgpw+MC465X2/GSJrktKF0gTqgO5EA4pbNihfnPlyU6C7mkOIDdEkWEUCskuKECQt5f9o/lzr0kNPXuBPh0aIAGI7rHryr/0e/j8fg/mnSqlaz26LpMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778720; c=relaxed/simple;
	bh=yMvqv5UmFT7AIpq8F8YeUqicsmsyJRqccpHBeoe274Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4xXn3l3bxlM08Qze5EMvkl4afdNwNweHGv17YYaeihIGr3EdULTqvSSvpnievwg4FmVxsPmi2ZxdsZs4FmlEa6tE0OfB7Wm8dMKQvtMi5lhvdw+QlM6l+2JULTXDd0lzTg8F6q0jpum1pj4zX518h3ueoE14aaRDeedjdcyZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c8tTnLeS; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fead317874so58265447b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778718; x=1742383518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eq7CbEnzO7luGgtEaDN5nrJnBFu8hWWVpatVuYHiagc=;
        b=c8tTnLeSGtlwgoeHahliIAdX75n6agHaNt9LmL7xRqe2mJIgZ+0x10HWALD//U0waE
         HQO2NXxVI4N21D96uTQGiJS+EuD+han4zrgnZG/y5ZWb/HI3O2H+ICwUwSjHwXzVt3oR
         /80NXdBAWtQZ3QPWei8ngdvJe83SkA4KFsRjuB7+vH9kjVDwGy1bS9yr8n4fWmGNVvRf
         iRH9jx/nVG94cFoCKszqImXQsntqWJiMTy4DZS/xqutW8FynZQy+tquQETcIXFVgdAU5
         zSfe2pxdfInPXjaMDeJvhFYlunxtujx5FK83WnxIrmPUgUc2mvymTnkp2MyZNG6gy0FU
         bbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778718; x=1742383518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eq7CbEnzO7luGgtEaDN5nrJnBFu8hWWVpatVuYHiagc=;
        b=MnwuGDgq4H6wxWAE50f3fjnyE3GirODQP1tziJYkwVMhx7S2FGr17t9hvpOcfpaVVk
         O0Bl8yyDdw7ZitFFjO/GbIxzQrwj4UIR2EgHM9SgSXR8kDuTeDN0gH2OSXNw3KZerMjE
         xh8ZaxT7Y4wzdSUqtDXGTPhXqjb08msyk3xf7l+79+ppwa1AKVljLRpgbRtmOIg+Dlh9
         IVXsOKCAlqwgy6x+fkuUVppkldHJMRhqm9LUv4JQt8LFj9p/syG02GLXgOK8vvtloBk8
         7q7uqaAY5l83igXDa5/yZdfOHxiZL5ROCaTTStdKuZ6vm4rZVOIkCbhnwCg7f+kPnCoO
         4N+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWR6Lej6AohYkwq0iWdshaDkgbnfQSdNevvrMzS8dKONHHN98mpfiO6Y5kSabkYd+lv8H1Y4wdjjgIHz7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy51fWQMHZpuEozHCxo55X4QINTCjxJm+VheVQ1jUupLzWnxLLg
	MZg9Pd+pBZwMkW3IomjCzvOCUeRNX63l6kO4ba2ANAuq0fyVgMwCbuzsI/RyYBP636r9cTqyxK9
	3TlFfQzFTRW308HpM5derQ93Fr779g0H4O31laQ==
X-Gm-Gg: ASbGncumArqULaD06kWKbB2fY5gO3FHgj8swNYLzLjlNcCK29E0zVMNmP31bK05VeH9
	NEnMLQVL0+Y+X2BOpNHwRdxhfuHZNL1WdKe6DyNQN0zN6urA1AdIUAhc5RSrTg5D0aWQIJfph+/
	YpScK1baazi1Tai1OZNsRS7tyvOXU=
X-Google-Smtp-Source: AGHT+IF6eG8PozRnESEd+R3ZnvGLnXtUo4BkvfgZwwoCUSGgHtU5TC7KInrEna3NWKS8wRzqC2uVDFF7ZV4wfbroPfU=
X-Received: by 2002:a05:690c:6f12:b0:6fd:9f44:f3ab with SMTP id
 00721157ae682-6febf2f2438mr302004087b3.13.1741778718231; Wed, 12 Mar 2025
 04:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227111913.2344207-1-kever.yang@rock-chips.com> <20250227111913.2344207-3-kever.yang@rock-chips.com>
In-Reply-To: <20250227111913.2344207-3-kever.yang@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:42 +0100
X-Gm-Features: AQ5f1JpJoF0WsaJEsGs8Ev2GK1W0qmOLgd16kceh61tUecpXUlKoJF3fFSj3-Bg
Message-ID: <CAPDyKFqmODGkWPA5Doc_6HsfihxnoABzu_1QvR=03dqXZRFmpg@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] dt-bindings: mmc: Add support for rk3562 eMMC
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 12:19, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> The eMMC core on Rockchip's RK3562 is the same as the one already
> included in RK3588. Extend the binding accordingly to allow
>
>         compatible = "rockchip,rk3562-dwcmshc", "rockchip,rk3588-dwcmshc";
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v3:
> - Updae to fix dt_binding_check fail
>
> Changes in v2: None
>
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index c3d5e0230af1..2d5c9931f623 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -14,7 +14,9 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> -          - const: rockchip,rk3576-dwcmshc
> +          - enum:
> +              - rockchip,rk3562-dwcmshc
> +              - rockchip,rk3576-dwcmshc
>            - const: rockchip,rk3588-dwcmshc
>        - enum:
>            - rockchip,rk3568-dwcmshc
> --
> 2.25.1
>

