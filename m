Return-Path: <linux-kernel+bounces-427874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6099E06F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8ABC280E18
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47C620969E;
	Mon,  2 Dec 2024 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k5Lk6NCL"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E329D209685
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153050; cv=none; b=e8NJpaXlzQv9T359XL/ieRzJRn459ZyVypaVupq5CEeKUxajd2DsGzvYTBkU7KYiTGz9ctrVI2JSOVj9boTNOH8TnmESxMREoKBD6lOgn8g2u3JPVa3Bi5OI09WaI7EdM5VWZAzTdKCLJgCrPe0IaCvPNW+ZQPGmb426s7rxX4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153050; c=relaxed/simple;
	bh=+Xl8s91uz6z0166yhunqPMLThqhGtXNxm6DGP1hGyaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aU/o8Fd8D5OOl80PxWjz2ttYgnbfFs57vW851tVfUH2ImKiHqvgAztcvDNhD3m48XeUJL+vEig88w5iDfyVvybCBPzMQIKzY6VZaBeXjmfHqskQdCgEfX/bLlYab5JAypkoI84y2J+PYm05qk2sA78Fn6crwkuOOVRSZD7IueoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k5Lk6NCL; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e398273d6ffso3020844276.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153047; x=1733757847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XMx9usLc+8H+1O3Ux5r/Qz56sk5GB2iRle+hBCjO6+0=;
        b=k5Lk6NCL/Q9S2n2SD7XUQy3GgjWsjcXzD2V/+giR9rhAUrOGGCsMQ/r8/8dAPLYGsW
         ulCSdELHI1aTBluKfiDycsvm82o8sgvRyGtiXYSAGP0/WxrT27xmDDDgbwE+M/CCvKEd
         0uh4t60+ULG1Ks4uJ4LNZYFklbSa+BPzal9TSB/GfYKX+XXRNKkYMor2pa3wur1kOHlS
         FwhQtAJpO5o9tSZUZtX+ynvGl4TSVftm5BgyNchSRDtjBsudY0vkHF6+9NmXWz9zclq8
         x8WgYa44Bx7oS49t0Opu8E+xUy/9ma+sg7UrILv5kSFdznhmNNCq9kHIJbfa2juCgfhX
         oyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153047; x=1733757847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMx9usLc+8H+1O3Ux5r/Qz56sk5GB2iRle+hBCjO6+0=;
        b=fPkUHdBIJ94xXsrSt5mCd0OqnRCwin/t0/QNIf3URfI7dhhO2ojthT5qeOB+JM03hi
         RUA/ezxBH/Zy+21hjQhaimr09/NqKWzwzmeTEmX9Ehfn4Bt1QAIE4QcJgx9d66Z0zvVv
         6FhvzNN7fS5k5Sl4t5F54es17K1lkL7ba0MSbe721VsDEOpod9ki81X57Uajoa8La46j
         HJXKP3tMiH8fqHDHNqcSnScnba7l5p0EHeMXx4v9JJkzSd+hsy4YlU98CJituyn18vSf
         6FcD9Ed91u6aOZYJEL75+dWKRpVNZ5Goickfekr/96qulGxI1jXa3KIr8kN9PpEJCcBc
         pY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVO8pW34zF+G0y95TCCdcyDErvP1400946/QEVqrhiAWvAUWQ9te9QTQfhVCNoscnz+SRgpIks+UHxyfAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM/dejFJr4B0/quIdDL5coQy73uqSP9yvfdJXOYhKEGv+QSVqp
	OH0cfDT8KlDDtHt2PVnUPUbszzmOnfHN5vw7MtBEL/HF5Yzqp018j0d+cRCduYA43Z+a1zxPHJV
	eVZFEeXIN5rQbaRKX04JWWy598crTW5N7OQZybw==
X-Gm-Gg: ASbGncu3VVRm2B2Fhmu8+g0u/tpjTq6p4DAshx7KB4camoSu5VKslbafo/qEx4G+Vqb
	qu0Y+F5mgLz3REtGYeTmptfdCtdIqzIP8
X-Google-Smtp-Source: AGHT+IEGJdd9IwF7sSUzoqqAWgtWCRY1a0UMhBwb88ErQOHU8BaxnCWHnPMW9+ru+41yFpFYGuJqHhtoLonEK76JtT0=
X-Received: by 2002:a05:6902:1895:b0:e30:c614:5c3a with SMTP id
 3f1490d57ef6-e395b869b78mr21357729276.3.1733153046692; Mon, 02 Dec 2024
 07:24:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1732030972.git.Ryan.Wanner@microchip.com> <e9e9e4cf0753422706bdc44fe7d20ca3a686ce7a.1732030972.git.Ryan.Wanner@microchip.com>
In-Reply-To: <e9e9e4cf0753422706bdc44fe7d20ca3a686ce7a.1732030972.git.Ryan.Wanner@microchip.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:30 +0100
Message-ID: <CAPDyKFpN-2kowdi_eCtbW1WEdc5OKh7tj60GfbPPBR0Hbpyj5Q@mail.gmail.com>
Subject: Re: [PATCH 04/15] dt-bindings: mmc: atmel,sama5d2-sdhci: add microchip,sama7d65-sdhci
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, mturquette@baylibre.com, sboyd@kernel.org, 
	arnd@arndb.de, dharma.b@microchip.com, mihai.sain@microchip.com, 
	romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Nov 2024 at 17:42, <Ryan.Wanner@microchip.com> wrote:
>
> From: Dharma Balasubiramani <dharma.b@microchip.com>
>
> Add mmc binding documentation for SAMA7D65.
>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> index 8c8ade88e8fe..ba75623b7778 100644
> --- a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> @@ -22,6 +22,7 @@ properties:
>        - items:
>            - enum:
>                - microchip,sam9x7-sdhci
> +              - microchip,sama7d65-sdhci
>                - microchip,sama7g5-sdhci
>            - const: microchip,sam9x60-sdhci
>
> --
> 2.43.0
>
>

