Return-Path: <linux-kernel+bounces-355416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB399951F4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1581C21ED0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053851E0B7E;
	Tue,  8 Oct 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7pvYWal"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0B51E0B67
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398205; cv=none; b=DjZsV2vP98js+vYL9rHQvOrXinQItgocFGAjV4vVlkfIbKsx5Q1GMLSSpu+8i1xDaIf3l7V+LeumYhbIiy2HG4nF9O6qvgYiOOv24Ek5x+rgpi0PP8ipPOG8zJj8OurBkwtfrrgmcH8ORn2ybIgZEASUlow/oljeM9OPRGUb3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398205; c=relaxed/simple;
	bh=eiBVahTw3pcHmt4RBSpt/Ftosqh8bsjEAx9y76i535g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCHo4cmGt+9vDKu5EmoUIY2QsR0XQD/2z2qb0vRFbZgZpAYpoKs3kyy+CDmdSpXMsjL7Nh0OUMvnljqTkG337Qx+9o5iqppsXVH3pTqBgsNXaT1O7GzD51579cGR7WjBd+y+ZJ3BV3aMkalwzeNCuYKPTrcjrQ685PrVq7wyBgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O7pvYWal; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e25cc9c93a9so5289473276.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728398203; x=1729003003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WNZzKdQArnf8YLwkRp6tlekOryWYH/w6bCKp6uUyEzA=;
        b=O7pvYWal1CQuQPyMAlI9M5wjRm5JpV8qaGz/lzrwimGIvOjOqNbURh/flZ1I2Gnur+
         nCF7RtdhvxgZWXeBsv79k8vax4TvhJaPkjVMFkChzamdn1aoEcis74x3RnXALYYMbPMD
         zJ8FQZDApzgfoLB2zmowj23o6gSu6zg7KwwlSWpk6w/P0E0rhUIFIlg+wcwJehk33Dxt
         VwBs8kKOQ8vfcelQl/BKdCJ8nGrGBVv1AeEBJs/nrf6c4eUUQh/zq78Gi2n7M8LJvIA4
         7uUOCn5+o5pY2u4DNFjLcfBTW7WgnjSGp1qZxqBXMdf7BdbKFVDp+x1xQVQdTVuWjKBx
         ahjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398203; x=1729003003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNZzKdQArnf8YLwkRp6tlekOryWYH/w6bCKp6uUyEzA=;
        b=WOCD9bq9I3xyrWvz5BP1Kap5V8VQHJTS0uSnbgEFpUBCciIxo3GU8zuOAAqSyKcuOb
         Nc8XqDSt6qNK/xLfeQ+T4XaI6mMCqp3YucA8IHI8GNyfrlRkCqipSdko4KfZPI4I16UU
         Sfj1e1C4paH4PYDcKzHorxXRJJJZYb0MG7dQusr+CJ0SpBANGr5vSgIalp2XZy68hYW3
         lLLHBP+Q2YYzNRBL8zg220BLAe7zhDCcfQsEDx3k2HKxDvDs1BXl5Sn2jNf3KVV+TiJJ
         G+41G8hCn8CemxCEPgYABWsptwDw+GYptXleQdmUMlL0BjLck2+lJhzHchwK1jN+RcNi
         97Pg==
X-Forwarded-Encrypted: i=1; AJvYcCV1HPQpv7mcH9jZTerNk74EvOkBVQuo49uMRLssfUsRq4D+D1L/GMxVMU+FyRqH8PPD7xGMFt2H+nFJv4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTD2WB7zZlIRdhxXKseY3Y224eY6v5YfgpmfcpwkIGJdqmI3B4
	Y3mI2FdDpnUyEk5TSru3CufNnRgBgyYboPBYKzNw5L8+k7n7LjnepsRIrGIceOdWMyXA54LY7cx
	9niKx0OyiD0iVYJ+L1a+ZN4ajvUQndnRw2dLyqA==
X-Google-Smtp-Source: AGHT+IGpk0fkikZLIUB8Xv1LRK1/jbL/DWVujOUGdacoTm8NQ+nTWOMi8y8fhtWL/4PN4fQZf2hYlGAC3o0z4YwCACg=
X-Received: by 2002:a05:6902:a86:b0:e28:eee6:1cf with SMTP id
 3f1490d57ef6-e28eee60288mr1785573276.48.1728398203049; Tue, 08 Oct 2024
 07:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com> <20240930095449.1813195-12-pierre-henry.moussay@microchip.com>
In-Reply-To: <20240930095449.1813195-12-pierre-henry.moussay@microchip.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:36:00 +0200
Message-ID: <CAPDyKFquF3nj3BxRqc418xC9_fFasHipDePdXsSBFLJwrO-UKQ@mail.gmail.com>
Subject: Re: [linux][PATCH v2 11/20] dt-bindings: mmc: cdns: document
 Microchip PIC64GX MMC/SDHCI controller
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
> PIC64GX is compatible with cdns,sd4hc without any additional feature
>
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 6c40611405a0..ee3a838f7f06 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -15,6 +15,7 @@ properties:
>        - enum:
>            - amd,pensando-elba-sd4hc
>            - microchip,mpfs-sd4hc
> +          - microchip,pic64gx-sd4hc
>            - socionext,uniphier-sd4hc
>        - const: cdns,sd4hc
>
> --
> 2.30.2
>

