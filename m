Return-Path: <linux-kernel+bounces-355417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080879951F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34F3283CE7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6283E1E0DA4;
	Tue,  8 Oct 2024 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVzfV3P1"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603D31E0B99
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398209; cv=none; b=q/+oujMoNh4M4StQ9Wos58OUt9YKNWeJ3RwNEceKVGT+w4AEdgCJxML7tI/PlNd4Pgw/vEAntGP2Ia6rQhIwyLGm8XXfTK1qd/BY+ND1dfbdTEcHbTjYiVzbFsRcpH4jswFBsAQ/62WFrmti3RiaAQ0J+jpatJMMfZnjMvv4axI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398209; c=relaxed/simple;
	bh=0Z1JExvdy9ZeQJ6p0A/0vey3LiyAqfmOE62rwLJZmTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnVl28SqMPwS8zFIm72AT/RlP6j5X56iOiFHrF344ap/Vhk805vLbqk82gtsAwogdCOy9FKIXY7bdoCgPkEFb6OzZ1XOX1Flvm6xpA/EuOZrci0OZY2nNRY45V0UDMF5q/IWI9bRrCYW3eXi9dHp2eY7kgLm3OqdnQNlz/njW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DVzfV3P1; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e2772f7df9so45376087b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728398207; x=1729003007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iwY3r5V9M933BYc/JpXLz8VpdD3oK06DMiHe6qdoa+c=;
        b=DVzfV3P1/xELASKTE2Y6d8IlVKVLot8vmbVzfzaw2Rs4gDpNTHkVRJHYnecJEsRCsY
         qL1Y6uQmUtHl5rHUbQLc5HhiQc3spJpTiqS3gdpBuXNh3G+Zt1MdtfW0TJZxmyTNdO8D
         aq1Q9DRW1kcvaFqilKJg3z8UhhVFFPidFgy3E/+JNFcZe2VRMzwnExKJWL/QUj74DUt5
         B+ibSxco0i2maIs60/tvOTn57sSWN+oqhFu1OxopPju73hX20BWia2XsxeJSFl9N/O7A
         Ukn21nlLqOOhZ0s2Zrk7c0UtmfB0i2aLu2mNYcPk2IzC6rAIrrHAnoamOk5WYlYErfp9
         /EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398207; x=1729003007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwY3r5V9M933BYc/JpXLz8VpdD3oK06DMiHe6qdoa+c=;
        b=n3iER17ndAEBslp3GBGpGKrVX7KZcNAdhEiahajfBAt4LHWNAKpntm4JbKpcvAuHqw
         yh/93z1jmKc4YJ58LBAluAQEHoPRGMFyhWE1GWzmAaHGPMTm6W249B8/8Kw3pokLAspq
         /NiQQEMSWVRJipyXwpvg4ajZw7BM3h7Lnpk/w4/t7ikbUKxkrrMRP1H8AcLVDc4xLQdy
         sCl4Vji5idCuqb838EWOzvtBlNHGczXZTm7gY5rms1qt8ZUg120+ANSBaDLPgqV3dWYX
         C7hGwespUueYUKASlrpKIj0RzBvp5/9al0SqdsUOlJ+v1DfYr1+taeZqX2nZsa5i/rrV
         ncrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyP6l+KO6ZK9YfNkolS7xIdvdAWtaqiPVif7dk0l8gwW9ByRaUgJSuGl530uvIuU/I2kawH70IVwYIdO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR8JXCCHorrw/ZHoSbxqUwyxoy19j0btD2JZl3Hl4zstSpI7cb
	haOhm2a+QXV+J8YKGceYyju9xK10+An8z8NciKaxGMSB86wb0AH5Obckk4Mn+sDZZTyk9wEI3up
	0YezS4KjN8f87DnaXxvMGNLxN6vlnEi4C5tKEbg==
X-Google-Smtp-Source: AGHT+IHCEE3cQALhziR76pWxSHYgivNkdxDE7czzTvB21/L8ltLPROWzkDkpEip7V+fuz0HUO9PqM2K24IAxVFHk8Es=
X-Received: by 2002:a05:6902:1b8d:b0:e1d:8a06:86c3 with SMTP id
 3f1490d57ef6-e28937df468mr9516417276.31.1728398207480; Tue, 08 Oct 2024
 07:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com> <20240930095449.1813195-17-pierre-henry.moussay@microchip.com>
In-Reply-To: <20240930095449.1813195-17-pierre-henry.moussay@microchip.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:36:04 +0200
Message-ID: <CAPDyKFq1HZxKSd-V_VnmpbQTftMDmF8SkPf11N_ELcahqo16QQ@mail.gmail.com>
Subject: Re: [linux][PATCH v2 16/20] dt-bindings: mmc: cdns,sdhci: ref sdhci-common.yaml
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Sept 2024 at 11:55, <pierre-henry.moussay@microchip.com> wrote:
>
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>
> Since the Cadence sdhci controller is sdhci compatible, the cdns,sdhci.yaml
> should ref sdhci-common.yaml to use 'sdhci-caps-mask' property.
>
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index ee3a838f7f06..0432cc96f7ca 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -121,7 +121,7 @@ required:
>    - clocks
>
>  allOf:
> -  - $ref: mmc-controller.yaml
> +  - $ref: sdhci-common.yaml
>    - if:
>        properties:
>          compatible:
> --
> 2.30.2
>

