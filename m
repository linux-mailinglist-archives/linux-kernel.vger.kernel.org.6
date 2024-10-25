Return-Path: <linux-kernel+bounces-381915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33719B063E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591D5B26A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B95166310;
	Fri, 25 Oct 2024 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rCKCZPrA"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3014A0A7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867929; cv=none; b=k1mN2PggxMJSpM0/pf/TEXdJTNQmKQoZD8rlNW8SgKntubvEjcH+MYhUZEF/RBaZNegr7wzbBoA+VhjVfe83GtFSgYYSTwcNeCHJnzWtApDnZDc7Xv/sg2Z9LJGbXO73HUggmNgTd9JDB38UeMk1H6wBT+5CagyK4MCTn7rnUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867929; c=relaxed/simple;
	bh=PR/HBC/9SdnqLv3iwd38ahFTmRtcv4jpMizzyfBx17E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9uN+kC4qBNK4sWuxAE0Aibrbf7COyL/0hDsseJsr0rcjijjaqRmpwJi4O56FRXsjs+PGXS2K46salCaFG45jdjEfd5BrVeKh35hOMHGEqIg2OHu2Qel++wtRu4lA13xDWRp1Dv621q5gpORVGnAaz8INrOFEmGxpiBCdieFNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rCKCZPrA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99f629a7aaso352521466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729867925; x=1730472725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=linTMr6O6XhFYFc+VtOW5M19IlrPjzZArEaPZ8T+Wss=;
        b=rCKCZPrAUvxIrbdATtoDn3bl1t/LNHnXVrQJ3j+JMgZ5qtvXE2IvVveaJYfx88SYcz
         Va/xW4+fJoFn3eVeIAQMgHgrC9eMkeO/QPE51tVvbiNz0amxWMM3HO+N7vDy/678fvAt
         O9+nYzTw0QRbgaRO8hkUMocctzjF9jmcJQgL+VrYzK0kLZPPsRFSAGrvtE9sUGcB9Ljp
         t24eTLKvGtAJlsLMFv89HHFoRdVYv3t+OY6cS+f2OUiiJUwu+X8Z2qImHxXHL1kqN2HS
         BoilBWaWQGIRLDQrZmEJXyChhQrTok0bbZ465JFd0gW5jU6c+Q94vEdsC4MylHm4vsAe
         4EUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867925; x=1730472725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=linTMr6O6XhFYFc+VtOW5M19IlrPjzZArEaPZ8T+Wss=;
        b=OBCqhgBGki4CnsCbZuemDfWe5AZ+HXYRSqNuSgdfX11QxYbAIdLqnR3nEV+7Uvy45F
         tq9X9+ktGJJw6JptQisRgXPWuHcdC5cpuHblJLKUm/Wczw9CzNskwHi8XchB40q44TKz
         gApZ4/4RDNwQxQYOwLkgzVJipp9A5Z9spGB8w7cpOcR6v/j2utZtb8NzlDsGd+JdmsZn
         PQPiO1wBGQDojnEKY8XVjZ/rGRCzc580rO4M11+v7BPAkKQzlRxEZmtEb/XZ324fPNUz
         JBXo54L8i6iqO7/whjl9++qbZdq4w4E9A5DJS1BO1mNR2kLgDxhpZm0ip6vsK2bhK058
         mvEA==
X-Forwarded-Encrypted: i=1; AJvYcCVdAr/2dVkrMkEpCdXTn6cs/3ExfR5t+0nNVSzgURrGqD3chsk+xPKbruO23pMQpBSbxbdKtv5N+Sed0Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTxdCEK1lYmyUXR0pXLa8/6K0I/gLi0/r2MP0Fql1ZVKaOwhw
	gEzHoyIjclLAWtQIjDtprLGhK/W3IiHVauM3rw7nGJSe29dA3iu5jh5WzQMmLgpKnkQWjqCZfZ+
	OpAneVmUIsLxz1Zng7BafwMLDLb/Ub1rgyBTywQ==
X-Google-Smtp-Source: AGHT+IEwfs/W3Owgk+RTmMlzdFuDGgmomxgsb+KMUloSwElRxnFSyypOytLKotVKhjZEiJNaWnl8Bz+gsTn3D052dQk=
X-Received: by 2002:a17:907:1c84:b0:a9a:8263:d2c7 with SMTP id
 a640c23a62f3a-a9ad199c2c5mr567345366b.7.1729867925486; Fri, 25 Oct 2024
 07:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-sar2130p-mmc-v1-1-c84da16a001e@linaro.org>
In-Reply-To: <20241017-sar2130p-mmc-v1-1-c84da16a001e@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Oct 2024 16:51:22 +0200
Message-ID: <CAPDyKFqBAm8kC5HNsKKpszftqaVisL1wMuFVNSKtBT1soz9HMw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: Add SAR2130P compatible
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Oct 2024 at 20:15, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Document compatible for the SDHCI Controller on SAR2130P platform.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index b32253c60919eb68f3cc0e1a37381f8cef748728..f2215de02e1b1f40ea9b11cb39f1ebc39d78845f 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -44,6 +44,7 @@ properties:
>                - qcom,qcm2290-sdhci
>                - qcom,qcs404-sdhci
>                - qcom,qdu1000-sdhci
> +              - qcom,sar2130p-sdhci
>                - qcom,sc7180-sdhci
>                - qcom,sc7280-sdhci
>                - qcom,sc8280xp-sdhci
>
> ---
> base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
> change-id: 20241017-sar2130p-mmc-7f8b32889e31
>
> Best regards,
> --
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>

