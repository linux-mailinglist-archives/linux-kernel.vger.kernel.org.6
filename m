Return-Path: <linux-kernel+bounces-350029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B066798FEE7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC4B1C23116
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E275A13D2BB;
	Fri,  4 Oct 2024 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="krQc/+Tu"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69D76F305
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728030292; cv=none; b=F9jKY7w6nQCyKvIPI+uAUVj27epX46ZPjg2CzSliO3tzjMqwpJhzMHU9gCJDtLj0LF+MSpfY8Z7M0bfZp6oQurPxumNmikVEktn0DtjDN3x4C1zduy2f2zaimlcj8PK7z4XrE4jrWyUcPVoULCYlcn08h6MYaAlCmsRJpHm2KJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728030292; c=relaxed/simple;
	bh=HUcJoHr6ENwP47f7Wut9FgKSjqccN5f/YJP3DW047Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hl5cqEoiB8b8hDP54UJMKmPdnNoB1RszGOxrfm+SwT+HnU1giXRWEuc/PtHPUZ7XHpj4KI2qQkxzvnCpB45f0lwZqcBXscAUVmnsRxd8QUwCaNjWHQtGAdyxk5iXbu6H8q7t4TJWJlqU1b5XmggqDuLay+D6zxYpELX/+u8BJxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=krQc/+Tu; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4a3be8c420cso550513137.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728030289; x=1728635089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oxZyp3eZ8k8zuivapL9rT1F6bBI1eaH4lwdCzl24o8=;
        b=krQc/+TuFFXN37wmIK+Z6phCoasPpXvxSvoS6PxpoblitNkJWXeQn/Q2J/eeL0wOGq
         EOsk36prMtFjYBFf6l2E6/CH4T2ev1kYUVGZw5cuQPO2gptaA4U/XpAyjv43auzM3qGZ
         ItG1jCy+1MJ2FQbYl40k2ifnR8jYiNfKK+wYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728030289; x=1728635089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oxZyp3eZ8k8zuivapL9rT1F6bBI1eaH4lwdCzl24o8=;
        b=cdLHnQq1PWgfpa0DknHE/qlnxGVkdLnJZ/YSPN6m1zQHMVUhyRT1X5FbXolMjw+jlb
         4l5Y0WlZ2SP51pumOLZhTUaoIelhUD0W0rBnIiue93nRlYIY/pW2NG22vk9FQZl2gfXZ
         ool109+V6YqjVZouCbnYZfKGLBZHvOf1jZTOLxLUDlLw80eqPKP17Bo0ua+vaWxe5OuK
         sZC8qugiX8TDRjtXdjXk2OznOEqcEm15f7WmcomLNZZ7igvwgIsVC3MC9KE+A3mpINRY
         xVUpEAzBPnEs09RNcYNt+G3apXe89/LtXfjQvKzZ25eWn8a7mlwWsTKrJij9UxIevL9j
         aNEA==
X-Forwarded-Encrypted: i=1; AJvYcCU8aGy6VRnRa/R4dXzhf079HPYgQ8pRUwZD4KLDqicWAxdSJaxAw0ZgF4EH43N/aB2MJ/DSGUXHiXex7d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3vz8BYNMtq5ImfOS4g4FAkPwqGnioFUItHPgJj4YWWlkQHaB
	pl9nk/7iQBjxAc8KIZwzQUhUGd4c4jv99K9NfjX9L39viUJRFovqrWBajtgl/dsRf3tGXzIrn2s
	oWw==
X-Google-Smtp-Source: AGHT+IEPOXx0KXh0Lp9Tp/HWKFWrV2o1ZcUaFqOsYCcHkYRCvV6ZgWx6IHAeuvIsRyyxlRlnnxXGUw==
X-Received: by 2002:a05:6102:c88:b0:4a3:e196:4579 with SMTP id ada2fe7eead31-4a40573aee4mr1336579137.2.1728030289074;
        Fri, 04 Oct 2024 01:24:49 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84f3ae77612sm374163241.20.2024.10.04.01.24.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 01:24:48 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-50923780607so524023e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 01:24:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7ueIzA9kTns8/NHmpykW+BW+4qAcvdZlNGCnZXb/F5wNeyvcywwPAwNbtdjVBd/70tMndxaDYISAo72o=@vger.kernel.org
X-Received: by 2002:a05:6122:78d:b0:50a:c19b:e712 with SMTP id
 71dfb90a1353d-50c855597a5mr1192054e0c.8.1728030287686; Fri, 04 Oct 2024
 01:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004074938.6571-1-macpaul.lin@mediatek.com>
In-Reply-To: <20241004074938.6571-1-macpaul.lin@mediatek.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 4 Oct 2024 16:24:10 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhW7ervk-b31mxtx_c-KUeLuC0P_Yr=9jtumUXAm6AZ_A@mail.gmail.com>
Message-ID: <CAC=S1nhW7ervk-b31mxtx_c-KUeLuC0P_Yr=9jtumUXAm6AZ_A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: mediatek: Refine multiple level power
 domain nodes
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Alexandre Mergnat <amergnat@baylibre.com>, 
	Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
	Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, 
	Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 3:53=E2=80=AFPM Macpaul Lin <macpaul.lin@mediatek.co=
m> wrote:
>
> Extract duplicated properties and support more levels of power
> domain nodes.
>
> This change fix following error when do dtbs_check,
>   mt8390-genio-700-evk.dtb:
>     power-controller: power-domain@15:power-domain@16:power-domain@29:pow=
er-domain@30:
>     Unevaluated properties are not allowed ('power-domain@31', 'power-dom=
ain@32'
>     were unexpected)
>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../devicetree/bindings/power/mediatek,power-controller.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-contr=
oller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-control=
ler.yaml
> index 8985e2df8a56..a7df4041b745 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.y=
aml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.y=
aml
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

For reference, I sent the exact same patch and it's been acked:
https://lore.kernel.org/all/20241001113052.3124869-2-fshao@chromium.org/

Regards,
Fei

