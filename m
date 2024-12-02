Return-Path: <linux-kernel+bounces-427964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1F59E0967
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BFB9B3B6BE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352511632C8;
	Mon,  2 Dec 2024 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IN8oPbX5"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0AC146588
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155694; cv=none; b=RE2ZxOiZip34ELga2R95X+K105jM8pdrJg2EZIAaLGzm7lcAJfj9nabIRtHoh0ZYuwliCiWZow9p1cwuEprOGgDg7BSDd7LINxGApf4JGvRBj6w/neLDuIMPl3etHU9x3YAKV3ozBG+QEmJihO3oQLShMhh8XaM8wBFQzOzpjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155694; c=relaxed/simple;
	bh=0BkrnC0seWUpFfjCOuhHrYtdt/QLPpXm683QTECDbjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kuo5T5isQPmJ9+RzKV59m8s5KOLuY39lONsF8hYIULIb84akha3+nR+6XbwLK/rp942j8SC07IUAR5EcS6sDaN9Lhtzpk7Vru4uCZm8iVvJdIJJBoULzo/2PfjoeN1MA98GzMKoATKiLCav4LnESUIk7rXCPDg/Nf0+QfgFxi9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IN8oPbX5; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e397269c6a6so3200127276.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733155692; x=1733760492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PaH2quEaKj8yOu++9MIx8fQjkXZLihRJEM2GwaPWvJ8=;
        b=IN8oPbX5LeamoxYoHaswYgo7+0JOZB/DVMQMgAyMQH8ek5iVzo3oZ6h3+a/G+RLblQ
         q26pdVwjh0U9zih+qzpswRFsHIVNqJqMC2rkSp4qBjwA4WZTKbWxpLfIYvmnypUig0GZ
         AM04aaH9/g2cTbMPHoE/LlcGwy0KfYSJ1/qiqzEMEwLm1KoVEig1Qdb9kpSIjEUhr+BK
         fehS5VCT0sMcqWNJN0hXqcd4+9EfV78JjanB7sjt79jXcBOP/Ktd5sUfQftre9DFSGeN
         d9x01vLEuER3hX1W9JWpHbLhAdSiTbYKiEBwbiiYfiJ8wtCaCG6ef8vU600gCH1KSmA/
         DahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733155692; x=1733760492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaH2quEaKj8yOu++9MIx8fQjkXZLihRJEM2GwaPWvJ8=;
        b=tEUJIiOv6JQHrb6Wu8q6LrG+zBygIn20U56bZPnrd1buar3ibm+fnSz4P5t4l0LatZ
         qgjqJSgl3yH89Wf1mQSztpKO32XBfnoqRlvrlR2McuLq8uwnHUAcTe8mRryFsFU2QjxX
         XjQYLWzdq4OZrRhoy0jgrAmEoZpJHxHnjrzhoVGf6XCQo/wDU0rYWFgo7exNHBVm1PtM
         DfS4+BTsCQ59SU/ykxqFkvUNand1dyAQyb84Ppq1UYbDt64FS6gcS9nzkNgF7whhvZo9
         g5qkAmMGTsmFEZvEVguUUxGGwgmlNxGww9D+jVEpxfYDSgKTE/oQ7K8YozBwenjPjl/g
         zFCw==
X-Forwarded-Encrypted: i=1; AJvYcCW9ftIb0eiZx2MoRZl4uSD1pYdqCoBKqJQbMbYgdORl7BiZhROInw3A/gKJr3KrZ6INEaJw79rSSbE3a7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+FGtOUHjssStEHIh4RTqbKO5kHgwza7AnxGfs7FYZLQCmRWh
	ngOJJXwVNvE06l2f/nfJmld3807U9hi2z+FVWK2GWAyefRGQprWDpxmiOtpT9QcfGKJWzkI4Xzb
	z7gdsToIHLN4Lk7Pj6DzwRLEk42JnwA10E+AcXw==
X-Gm-Gg: ASbGncsjBYexgQxkUuLGx4xGxyf+L2N2gml/qdeTPbwAnZnygBIdCqfUmOJv2pHNxna
	tTMQf4X2lDbY8IVvS6NvV341Mh/tM7Cle
X-Google-Smtp-Source: AGHT+IG7HwzdQGc2Kvrg8khctxbecpx+AXVlBCSBHTZ8x/NzPHJXof0Ee7iQcAC8+6QwlvR9QUpxPUtKrKBUqfZBBpA=
X-Received: by 2002:a25:7bc5:0:b0:e38:864a:1522 with SMTP id
 3f1490d57ef6-e3971958a74mr15808882276.9.1733155689500; Mon, 02 Dec 2024
 08:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001113052.3124869-1-fshao@chromium.org> <20241001113052.3124869-2-fshao@chromium.org>
In-Reply-To: <20241001113052.3124869-2-fshao@chromium.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 17:07:33 +0100
Message-ID: <CAPDyKFocgdjSdek-sNHy_w1ZQkscgs8Z0TYwXPKC9phUbH-scg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: power: mediatek: Add another nested
 power-domain layer
To: Fei Shao <fshao@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Fabien Parent <fparent@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	MandyJH Liu <mandyjh.liu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 13:31, Fei Shao <fshao@chromium.org> wrote:
>
> The MT8188 SoC has a more in-depth power-domain tree, and the
> CHECK_DTBS=y check could fail because the current MediaTek power
> dt-binding is insufficient to cover its CAM_SUBA and CAM_SUBB
> sub-domains.
>
> Add one more nested power-domain layer to pass the check.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Fei Shao <fshao@chromium.org>

Applied for fixes (to silence the warning in v6.13-rc[n], thanks!

Kind regards
Uffe


> ---
>
> (no changes since v1)
>
>  .../devicetree/bindings/power/mediatek,power-controller.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 8985e2df8a56..a7df4041b745 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -54,6 +54,10 @@ patternProperties:
>              patternProperties:
>                "^power-domain@[0-9a-f]+$":
>                  $ref: "#/$defs/power-domain-node"
> +                patternProperties:
> +                  "^power-domain@[0-9a-f]+$":
> +                    $ref: "#/$defs/power-domain-node"
> +                    unevaluatedProperties: false
>                  unevaluatedProperties: false
>              unevaluatedProperties: false
>          unevaluatedProperties: false
> --
> 2.46.1.824.gd892dcdcdd-goog
>

