Return-Path: <linux-kernel+bounces-378295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C749ACDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC75B276B4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4D81CF2A1;
	Wed, 23 Oct 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbM1Bf7d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274041B4F17;
	Wed, 23 Oct 2024 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695101; cv=none; b=bT1T7heEJWa+5Me857Q3o+ebYFXOtwKXOmuL5NCoB6N7C76JbKg7Dg/+ZxhXCgn2lglZruMxwGUEVQlnD4UH1HImBGjR/ftGytAHam4SDrorrmZXiDmV83spJaKOQtU0m+rT0p8DExfRU623w+WW1mz6/OhUBtXW2eAWL4iOfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695101; c=relaxed/simple;
	bh=V0WnmKHkiubGXH7powCeniKJAeXlAH+b4/k8QVVp3oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7FY28ZiOGQXpO0KsFaqUy7CT/YXYRj/5t2lOET9vghSYbK1bQMebMfhm6LYwQKsHTg9gcFd7DqiJjA43IpNFnmchmSK3xz8p6m7gm7nRcE+VBGHiT2TIzHQuH0QOrMmK7QwIw8oZtBAUr2fQ76Yq9AVK1f76b2uFlkbrWzSyng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbM1Bf7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5CFC4CECD;
	Wed, 23 Oct 2024 14:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729695100;
	bh=V0WnmKHkiubGXH7powCeniKJAeXlAH+b4/k8QVVp3oY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jbM1Bf7dm1i85D6ulVyTnMS5SyvGcjGl4/R6/tDvcby7kvQjGoCCZwsxPxd6B7xfj
	 FBkw8OwMGRF+yCrVCvrfKrCyVAL8xIcpiBR9WBX8W4exf+dikRAyIPcqjBUySDCMJk
	 LyPngvof18LuQeH/hJ9LuLQlZw0NMigqnc22baoK7Fd3QMoGJqeU3tq2w/VWN3hbo5
	 4lZ6YQWEZfGjRm35CWPON+HudtTolbDR94B98/Mxj2MGawwCjgXSgYMQ1/7m+vAeLK
	 EpSuXp2xABGUFQwkazPi2XNN/V0uPySS/V7HeXod3TZ+jAwYJ1dnA2q20+ew+ZY9T8
	 CJUdLwAJ1SngA==
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2bd347124so5146091a91.1;
        Wed, 23 Oct 2024 07:51:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5bt8suZ6LoCtbfmsx3bILFadPUKIzSPhNyYXbGz6wDcuSiZj970Ct92KYHk/k59zo1LOaxRGYjg9p@vger.kernel.org, AJvYcCXdC9q9br12Use7L95YoxYKdgb/5IDwZRpVJ1v5BiQpEpLbgwQ6UCI3tywKhb+16XTuazmCdYOv1HHu2n5o@vger.kernel.org
X-Gm-Message-State: AOJu0YylDUEphHoYa5ISZ2qNqDR+2s1VHG2WpciUFS1u6H1cic8FNTwq
	YyWFmURCvav9Rq0VeniTIzi0p3wG+j+qX5fGPx/hJiCq5pJ1ijoP4dbVF2QQhMY/8ghduzE05xv
	mbk3eWHlvSAun+lL7VJvirC0ARA==
X-Google-Smtp-Source: AGHT+IGiOV49HPeVWqZgqUDfen8sjZxWmSvuRAGE4z98/inzDbsAH3T7NKTZ/wjACKOgmYMVQ+VQCdv4ftbQedq6e9Q=
X-Received: by 2002:a17:90a:d512:b0:2e2:e545:82c5 with SMTP id
 98e67ed59e1d1-2e76b5b7edcmr3019116a91.3.1729695099200; Wed, 23 Oct 2024
 07:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007022834.4609-1-moudy.ho@mediatek.com>
In-Reply-To: <20241007022834.4609-1-moudy.ho@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 23 Oct 2024 22:52:00 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-jPWv1nHf9NnxNkVW2+ZOFOagAPf1DFQu5AD1KnCQNYw@mail.gmail.com>
Message-ID: <CAAOTY_-jPWv1nHf9NnxNkVW2+ZOFOagAPf1DFQu5AD1KnCQNYw@mail.gmail.com>
Subject: Re: [PATCH v5] dt-bindings: display: mediatek: split: add subschema
 property constraints
To: Moudy Ho <moudy.ho@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Macpaul Lin <macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Moudy:

Moudy Ho <moudy.ho@mediatek.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The display node in mt8195.dtsi was triggering a CHECK_DTBS error due
> to an excessively long 'clocks' property:
>   display@14f06000: clocks: [[31, 14], [31, 43], [31, 44]] is too long
>
> To resolve this issue, the constraints for 'clocks' and
> other properties within the subschemas will be reinforced.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 739058a9c5c3 ("dt-bindings: display: mediatek: split: add compatib=
le for MT8195")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
>
> --
> This is based on [v2] dt-bindings: display: mediatek: split: add clocks c=
ount constraint for MT8195
>
> Changes since v4:
>   - Eliminate the possibility of varying quantities in the 'clocks'
>     property of mt8195.
>   - Move the constraint for 'power-domains' to the top-level.
>
> Changes since v3:
>   - Correct the compatible name for the mt8173 split in the subschema.
>
> Changes since v2:
>   - Revise the commit message.
>   - Enhance the descriptions of 'clocks'.
>   - Strengthen the conditions within the subschema.
>
> Changes since v1:
>   - Adding functional descriptions and quantity restrictions.
> ---
>  .../display/mediatek/mediatek,split.yaml      | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
split.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,sp=
lit.yaml
> index e4affc854f3d..4b6ff546757e 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.y=
aml
> @@ -38,6 +38,7 @@ properties:
>      description: A phandle and PM domain specifier as defined by binding=
s of
>        the power controller specified by phandle. See
>        Documentation/devicetree/bindings/power/power-domain.yaml for deta=
ils.
> +    maxItems: 1
>
>    mediatek,gce-client-reg:
>      description:
> @@ -57,6 +58,9 @@ properties:
>    clocks:
>      items:
>        - description: SPLIT Clock
> +      - description: Used for interfacing with the HDMI RX signal source=
.
> +      - description: Paired with receiving HDMI RX metadata.
> +    minItems: 1
>
>  required:
>    - compatible
> @@ -72,9 +76,24 @@ allOf:
>              const: mediatek,mt8195-mdp3-split
>
>      then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +
>        required:
>          - mediatek,gce-client-reg
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8173-disp-split
> +
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +
>  additionalProperties: false
>
>  examples:
> --
> 2.34.1
>

