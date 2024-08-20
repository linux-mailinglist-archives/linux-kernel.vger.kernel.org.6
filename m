Return-Path: <linux-kernel+bounces-293878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6EA958619
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C641F232D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0EE18FC68;
	Tue, 20 Aug 2024 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9cObCYO"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC0118EFE8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154642; cv=none; b=YNR+ib6ddYtzH6KFOAc2qz72uHETPIvdFoSuKoi8PYCL0ZNKLNyqGAifuSvnPemV9Ae4qKc2CeXVBhRYAjC0P/Mo7rOcg37fZwgGk076lvJNxyvqKIJzNLQlrX8QW/YsODKx7WR4DF/80u6QLfA30FtWJ0axqeEmfRQvZLlv9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154642; c=relaxed/simple;
	bh=mqu+zUl6X9D6f93sxCCJF2mnDHiCXHlm2Mfc68Fo06E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuHt6az8Y52j6D1i13R8wLGfg0fDSxLLJSHWUIvNyJvgb2uhXQ5x2Bb5KbQ+EfuplIz02AOiEoANcvamr4T/9qXTy2BKPjSOdV+U3E1PqLEfSND9XNG8hvYHcpgcX+3BQzoZzBntDHdzyyZ87q41B5+2TsAyr4W/k3qGLe00RaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9cObCYO; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e11693fbebaso6089985276.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724154639; x=1724759439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FlNvcC8AuUIcreI5Mnui6pLZVwffrglnnBdB2303BJE=;
        b=C9cObCYOexsF0MXxhSQ0JRTIMKIIv5mdti3CJzI4VYvEIipsxnJv+/c+uy3eCT4a7y
         9leXHG+m7fRVXpBni/UBkreNaWquGe5pXyzRvVfWQQU4kYB/Si2eni/hRkczi9tseGf0
         uSo2dZUpgUj7HR9nKx9A0J5vC6BVgjIsu7y4xqdDhjT8cPOxrauHuom1wl7CllxeDcyr
         lfRQ7dIXU/0PQRD1hmECFUKumgVvjaGvDHchw1BLtgCITLpAJAP/5NlJjg0QCQQJxsAE
         B3fhcCLTbHqzlLC5aFfu/tNR6JGXuNWvMuEFsBaah4tFI7nfsh+NrHH1Hcc3QqhEH954
         1LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724154639; x=1724759439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlNvcC8AuUIcreI5Mnui6pLZVwffrglnnBdB2303BJE=;
        b=vdEQV7tbuloSkt8e4qInlyvndxVYvotfd3mtz7UhCUaJRZ3c9NPT7mqL7sEPamGu/1
         VRI9LaWg+iF8opAoXEtbv5D6u7xa7U+2/IaKRmDVLoUAtXkOzeYMwby7hfKkDM4GTOvV
         0F0MpOM70DXbkRRJdH9Z6kkakeqthRoHHOHkQuxCmwA+mzr1X8JcmcOQcnOWPHBEALsf
         Dc2ykPzGbQOidqB8imCUKE2xDJDYMaGqNxw8swEpVD3cJKpuhzLppwlx0z7UB19vGkhr
         q0B4AmZRRK8jTwZItWYehIIbBc0cVVqODZDrvz9vHjCXOKCr/Aqbk/Gll8Eef9vHlB47
         Kkdg==
X-Forwarded-Encrypted: i=1; AJvYcCVEv5kSTiRNimKEH9ytrpFoDR7wZUjDDe8v/9WHo2OXOJR5jM4e6czO9gW9iU38d5SMDdF3rdpYDVIkuKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMI1VbKNTJDeuLw5nn45gbYlaUJ1zrsOxwHSbpUMlXj6v8CFqy
	Q0YxNF+zc9UKtAyLxOgLx1uhX3tXar9SE4EIVQr/RCD2KPiio02RrYjpY/IcmaF7590lpIDxbMU
	Fn3dyjFZFiY4TbrjKDhdQR2GTwqcgQlz2dlqhdw==
X-Google-Smtp-Source: AGHT+IF+VTVxHiNVj6hPP3k5Ib1ma5eJfAGMXGeEZ5yHCDH3TQ72vmA/Si0268nLARdDdIAk7TAtRCsPfyEdSpUHw4k=
X-Received: by 2002:a05:6902:2612:b0:e16:1747:732a with SMTP id
 3f1490d57ef6-e1617477734mr7970816276.38.1724154638960; Tue, 20 Aug 2024
 04:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818172923.121867-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240818172923.121867-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 13:50:02 +0200
Message-ID: <CAPDyKFrcdk76CPCVRLLfRVT4BKMRQFJjZVV8ss-u1NegSf4fkQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: add top-level constraints
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Aug 2024 at 19:29, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clocks.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 1155b1d79df5..6d4a1faa1c4b 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -77,9 +77,13 @@ properties:
>      minItems: 1
>      maxItems: 3
>
> -  clocks: true
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
>
> -  clock-names: true
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4
>
>    dmas:
>      minItems: 4
> --
> 2.43.0
>

