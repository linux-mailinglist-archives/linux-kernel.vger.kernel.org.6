Return-Path: <linux-kernel+bounces-373743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB59A5BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4741F21D66
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68CA1D0E1F;
	Mon, 21 Oct 2024 06:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i9MZigny"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C389715575F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493767; cv=none; b=LtldTCvptTtJDDMq62ebKOmO74TV9A+/Yr4ExAw30Xb7zkRyLPVYDWZB6pbcqguHgWbCGUxD6L1yblxUfu65xQd7pGGgssNeKKo2R3cpna4y5347imG5qDvFuatzfX/PlmvdNvnD4XQ52dyz68/xPbt3xTsXPwo5gIHf2oYulAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493767; c=relaxed/simple;
	bh=8imqCDlRdFRHGxgoDtmIrc8bFSvYciOXZ5msN5RcHrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7n5dVV7z/A0fmMHFOLRnyFvyza8Q4dbl7C7zTJ1UbdaVS/8UrkqiO29xjznoVN8vzMvWc9kuamA3o3W8gacyVlwuAsNjc7mIl4MRn9gg0RR3BYXGMGKKefbB8JWpg1A6YEeBdVTJFe4dsXhVUQtPsN1Zam1oVvj3jhhstUeuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i9MZigny; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e4b7409fso4113293e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 23:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729493763; x=1730098563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNidV6zQRVAttNm6/BViiBS78cigdlLuD+Cor4bHBRU=;
        b=i9MZigny1Ve84xZ/QLVuBk1F6hYwjXUg8/aKf4VWFWenuzQKF7+pVaZtML+jQa1XBN
         GILk8RGYHTnTnV+3T75Ib+vTH1z03EJ1E4O3/nTE3VhjvtUOJREYhX7rIYXoEC+Y/2i7
         U8vGkfqq6KXPfXJAPalUbEVeo7lDlquZ5afng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729493763; x=1730098563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNidV6zQRVAttNm6/BViiBS78cigdlLuD+Cor4bHBRU=;
        b=UEWXP7vY1f+ezM0ZU1u7lzKQxwxIZSbYx2j3F2Lt/8T4Bl6y53yLPupy64mCF41jE0
         QSr1OeSHU2Re2I/8BtK6RJQg8FpJlWOn5SLONSYryiw9b0TKoCbe1MV391F86rjnxpVK
         u67POmKD3QdK3Va8JlDOttyL02PNowId6WzzFs5LczoWqmq4nWoAmXgVBLAIiIaI//KA
         yMsAS3BpU0+DEUkxhywc4zWmu2ikZjE6WhgtbaK3Lqzv8DNK8b/OnIH+7I8TFdJZCBSM
         J41fnwGCWsGZ83cKsj7svc5kwwgy6zycj3DfD/jAaaIzu/5ocQ7pm0Jrmb6DThzNhE42
         H+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6BLykQzhaVw93qikQJCBJb8VFM8hGjh3xgZr6ryhlNmmPsHBi/mREBTfbWRt4fbvOH8TMHd4dT4qPTlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5KCv6BPgiWETNuKqVgdRZGpybeO+pNzG2MREyAHDVnb13P3O
	cVriGwa+t9aXj615Ne7xZSyJmY/txBDrFjaQ35yAxujIKFSEtKJ5AQGz78v4Hyx2zgMQhxUrQec
	J4iPL4TvRzDh/GdhEpsB0pgKzJDsTfoi7IoHF
X-Google-Smtp-Source: AGHT+IH2grfsk2J11/R+DtqJL9MsiARRehfvs3wTJ4dpT61anw0+qbBHxQCnXBmSmtIOZmW35lIuuB1aQSapi3a6q+Y=
X-Received: by 2002:a05:6512:3b2b:b0:53a:1b6:4624 with SMTP id
 2adb3069b0e04-53a0c6a5c2cmr4349435e87.5.1729493762768; Sun, 20 Oct 2024
 23:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021025938.676-1-xiazhengqiao@huaqin.corp-partner.google.com> <20241021025938.676-2-xiazhengqiao@huaqin.corp-partner.google.com>
In-Reply-To: <20241021025938.676-2-xiazhengqiao@huaqin.corp-partner.google.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 21 Oct 2024 14:55:51 +0800
Message-ID: <CAGXv+5HRc6MrNuNxqAi9mst3X4pieUpRW5jzbjKgtBjTUT0P8g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: mediatek: Add MT8186 Chinchou Chromebook
To: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Cc: devicetree@vger.kernel.or, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	hsinyi@chromium.org, sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 11:01=E2=80=AFAM Zhengqiao Xia
<xiazhengqiao@huaqin.corp-partner.google.com> wrote:
>
> Add an entry for the MT8186 based Chinchou Chromebook, also known as the
> ASUS Chromebook CZ12 Flip (CZ1204F) and CZ12(CZ1204C).
>
> Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com=
>

Hi,

For upstream Linux kernel development, it is customary to have the maintain=
ers
and anyone that may take action on the patches to be in the recipients list
or "To:" list, while the mailing lists and anyone that might have an intere=
st
be in the "Cc:" list.

Here you mostly have it backwards.

ChenYu

> ---
>  .../devicetree/bindings/arm/mediatek.yaml     | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index 1d4bb50fcd8d..3efab59b8a73 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -239,6 +239,34 @@ properties:
>            - enum:
>                - mediatek,mt8183-pumpkin
>            - const: mediatek,mt8183
> +      - description: Google Chinchou (Asus Chromebook CZ1104CM2A/CZ1204C=
M2A)
> +        items:
> +          - const: google,chinchou-sku0
> +          - const: google,chinchou-sku2
> +          - const: google,chinchou-sku4
> +          - const: google,chinchou-sku5
> +          - const: google,chinchou
> +          - const: mediatek,mt8186
> +      - description: Google Chinchou (Asus Chromebook CZ1104FM2A/CZ1204F=
M2A/CZ1104CM2A/CZ1204CM2A)
> +        items:
> +          - const: google,chinchou-sku1
> +          - const: google,chinchou-sku17
> +          - const: google,chinchou-sku3
> +          - const: google,chinchou-sku6
> +          - const: google,chinchou-sku7
> +          - const: google,chinchou-sku20
> +          - const: google,chinchou-sku22
> +          - const: google,chinchou-sku23
> +          - const: google,chinchou
> +          - const: mediatek,mt8186
> +      - description: Google Chinchou360 (Asus Chromebook CZ1104FM2A/CZ12=
04FM2A Flip)
> +        items:
> +          - const: google,chinchou-sku16
> +          - const: google,chinchou-sku18
> +          - const: google,chinchou-sku19
> +          - const: google,chinchou-sku21
> +          - const: google,chinchou
> +          - const: mediatek,mt8186
>        - description: Google Magneton (Lenovo IdeaPad Slim 3 Chromebook (=
14M868))
>          items:
>            - const: google,steelix-sku393219
> --
> 2.17.1
>

