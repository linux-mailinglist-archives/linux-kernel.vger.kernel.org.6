Return-Path: <linux-kernel+bounces-319491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC09196FD4E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E55A1F25F17
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC5314B956;
	Fri,  6 Sep 2024 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JKvgTu1J"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D56C158520
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658014; cv=none; b=cJaClmZW8wTuxMXpFjUUPFK1F/MAVkWLVfMVlbIgSVY12P0c3YS3jWVNQszPdM/B07G/slCptIPMIKWFK0isOegGvijZXHQlgwr9F1hMUNP6eTDZHYmT2GK/HOcR2jILa9kD7BNdZWW7Q1eR4zBceFyA6nVNMBvSuaob96cCJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658014; c=relaxed/simple;
	bh=vbvupfzOCTKreM50XsTfLydOOQ4mxvFu/eBa7h5keDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9zf37VfrFopLozIkBJDs+A66M2WRpWrs9+QS0yo7ewl2jOv/hIoXKGHltB2ePnTqhsPq/avjDs6dujRc1HNZfu9osZHQanEuRz5rCI/BgQ+ds3Lwn3LyNQRRWJfihnu80bS8vUL5g7AOySGOs8cLGQ4hIllvM5Eb6DHFIsbhPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JKvgTu1J; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c3d209db94so2234931a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 14:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725658011; x=1726262811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=modpcTFGLF9aKbO8/hxRVTkNY+Z5zDvT8kayu0jRlU4=;
        b=JKvgTu1Jwf2Pw5lek6K2IyNLQW1ilwlXk217vDBVUk5BvXrID+a9jrIDhOfPLa1FVB
         HxF9a0FD/FhparVVp1c01hePYVIFYNDssVHGZMlMuwUSh50ir6Tdx1BIGO2P3zBPCamp
         bw/b27BXhNu5S3LOkAbIsgZ50MLnbXOAdouAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725658011; x=1726262811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=modpcTFGLF9aKbO8/hxRVTkNY+Z5zDvT8kayu0jRlU4=;
        b=pGp91zqAYjQV8YwPotjWP6sI8N3gnEM+27wkiHu4wx+E2kL4Noi+AiCxKqtgn8/6XU
         XF0lbYvBgxfKZNyKlYa+WSWaLak+mw7Dn6TOgpZhfaQwnTw4DudZg+KgGiltvYuWh9LJ
         whU23IGg6VjD0YRMmtAdXIl4ZpEHwPImVUErUJ9VpEyiNIGNvRExyI5j7vjARBAzhTO8
         N9l5iU+curb+XrAaBTErFaiGAmJf3C6n9GSYEKToOgGqF/W4JqdZbZdGtXZY2y1TFr8Z
         2CQ8gY29NP4NcLtkRSWAz8ar+LDVZxg9NOYQnrTG05NIVGzJbRnpr0s9fYs6/EAUsaHi
         VVgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV/o3007twK1tmTD6oeLwdRZjhb2OyGL6IqFiPY3FDqeJorFydjKulvpP1EuYHkU11Hn+LydBPrY5ZGes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwipHc5kIsRkm/EEJ7SLHhm2DSxo6qHOi2UQJgXSxWjdY7A4IZY
	7ZKS7Wj+SJH5q//NlWSumW5yCa9MR+2scnh/Ypyh29puJk/QqiISvYx+a9ehUStkQRTxUHxxJgb
	p9ChVdXWoih5Nx+azTcewRgAfdQJ/3EKb2ZGR
X-Google-Smtp-Source: AGHT+IHcF5eFRWlqZt110Uz30CQNhxKthjlTRSddSsueRyNGudDWIFoPa9u+T+MfMoSREaLKrpMFRIaqTdFrN9C5Yew=
X-Received: by 2002:a05:6402:35c1:b0:5c2:4ad9:6d9f with SMTP id
 4fb4d7f45d1cf-5c3e953355dmr454244a12.1.1725658011403; Fri, 06 Sep 2024
 14:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906085739.1322676-1-cengjianeng@huaqin.corp-partner.google.com>
 <20240906085739.1322676-2-cengjianeng@huaqin.corp-partner.google.com>
In-Reply-To: <20240906085739.1322676-2-cengjianeng@huaqin.corp-partner.google.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Fri, 6 Sep 2024 14:26:25 -0700
Message-ID: <CAJMQK-imYrDTuycVzQxkfbkZuHehE8uwc+qS2w=UDShETsBvEw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: mediatek: Add MT8186 Ponyta Chromebook
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Cc: angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	knoxchiou@google.com, hsinyi@google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 1:57=E2=80=AFAM Jianeng Ceng
<cengjianeng@huaqin.corp-partner.google.com> wrote:
>
> Ponyta is a custom label Chromebook based on MT8186. It is a
> self-developed project of Huaqin and has no fixed OEM.
>
> Signed-off-by: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
> ---
> Changes in v4:
> - PATCH 1/2: Add more info for Ponyta custom label in commit.
> - Link to v3:https://lore.kernel.org/all/20240904081501.2060933-1-cengjia=
neng@huaqin.corp-partner.google.com/
>
> Changes in v3:
> - PATCH 1/2: Modify lable to label.
> - Link to v2:https://lore.kernel.org/all/20240903061603.3007289-1-cengjia=
neng@huaqin.corp-partner.google.com/
>
> Chage since V2:
> - No change.
>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index 1d4bb50fcd8d..4bc1777b9ea6 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -257,6 +257,17 @@ properties:
>            - const: google,steelix-sku393218
>            - const: google,steelix
>            - const: mediatek,mt8186
> +      - description: Google Ponyta (Custom label)
> +        items:
> +          - const: google,ponyta-sku0
> +          - const: google,ponyta-sku2147483647

sku2147483647 is not available anywhere besides the factory, so you
can drop this. Same for the v4 2/2 dts patch.

> +          - const: google,ponyta
> +          - const: mediatek,mt8186
> +      - description: Google Ponyta (Custom label)
> +        items:
> +          - const: google,ponyta-sku1
> +          - const: google,ponyta
> +          - const: mediatek,mt8186
>        - description: Google Rusty (Lenovo 100e Chromebook Gen 4)
>          items:
>            - const: google,steelix-sku196609

