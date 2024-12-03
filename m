Return-Path: <linux-kernel+bounces-429068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249A09E16F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC48C161311
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3A91DE3C8;
	Tue,  3 Dec 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zt4846W+"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922417F4F2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217371; cv=none; b=FyTWfYyFDNBkAfgg3lD6a8IHutIuE/S1EmYtHe3Sz+OKPX+NI74CTSFrssxY+Zu5PhV80KMql56fy+jm2s8pTWsS2wiCVHUGLb0FCKvIUY1HXcup9Oq7V2ADcWL5r3GsyhkdPn7wIp6O5+P+pmn1gUrPLHnekerDTM7NPNO1Vmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217371; c=relaxed/simple;
	bh=Ynw/BXgvGPSdFG5UhefPcou+uPZ7b5PbzWEqBuapC6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cqll74MfdorYd9nJNWOUhXV6BpwNeaupJOW5qaj5yjadARXt11X8oJxUyY/cqpy2Cf9tmnpQUCFQxkbZxzZw6gGB58g8iY6mY+iZG3ta+uCtzeusMZq+lewGlperWiU+dagxYIGRnM5wVYZ9zzPQpYjTV1aA/FpE95zUUdIc934=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zt4846W+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53de79c2be4so6254454e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733217366; x=1733822166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKpX/3oOMoY2CpjSV1lkQJtqW/CgZx6kTl37vj9RWvQ=;
        b=Zt4846W+gXINDWFvYq9JH6nTldtbdRbrJnH4mUfp0EqlmazMWVBchWLyRNsh/C9VTw
         fIM1eARbYnr0r0Sg45QGRnKdmc4LV9EH6NFXuYkSUw/jgiC3CI0RMkxOqRKh458pYjh1
         wRCD2xjQ9MQDFyQyOFThAjdh+Glbwe19vrdOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733217366; x=1733822166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKpX/3oOMoY2CpjSV1lkQJtqW/CgZx6kTl37vj9RWvQ=;
        b=UiuKU9iD+nj8paaUmI/59WzZeSFxcpARXbN9T0O5wR45gL+zOJIwGSNqiJrgpd9WM6
         tryiL3bX6Dy2y34h7vjriLU7nPKMO6WJIchKeIPZa3CJlyABm7UuZ8+drBmuNO0JjihX
         KUIkAWNOEm69/YqzNSf7LwNAkRXhN4Q44OpWOa6kd+lKVOr9CtbyRc+ZyEKhPqvAOmvc
         3nFRuLa518IDxUaymtAU6/5gZ82y+ro2WlbRc5jl6PPnJO+AldRW2UfcKpA2haFDGlCQ
         LrghXPjc8XjjKnwgyVTGPlIayzFvBSjq56U7ceJG+8APnS88FVLHw7uarwrmtzQQpwVx
         1SUA==
X-Forwarded-Encrypted: i=1; AJvYcCVi2IFnQp9nfBDAgfT3p0fPNj8uGeAgi/SdOOUKJHNd87lvd+rtkaLgFuHTbY/GwLqVZrtDg6v+py7NiBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBiQTpRNdQGReaD8duHt3EUQvibUCXF6I7GWmefhZOTsI51I7L
	QfE5OtzwLXOldC7/H7S3bArscEtT0Q0/GsIR0pe5YnY8kq6lUdjqR3FF+bu7ebDYyZe6hr/+Uc9
	h2w12gF8rWYWoesr909jnCUjylYoFAgm7B7u6LH2gBvwSpe4=
X-Gm-Gg: ASbGncvFFGto+y6UtaPief8zMre6W2qIqgmBWybceacAQRh4PCEgn6aofOL9nkDCVtw
	HhQb2Cb+hCVuFYDYwWELQbsr5CWwk3WxZ9u6iDGEHy84jhqSXZOicB5IujKY=
X-Google-Smtp-Source: AGHT+IHblgyX3h9C40czpfBFU4FlCVyQGCJtmnMsdRZhtqjaXaMQ/snRbicpRd77CCHWP8KcHzPutSl+2EBTyk0stG8=
X-Received: by 2002:a05:6512:474:b0:53e:166d:bdf with SMTP id
 2adb3069b0e04-53e166d0c7fmr436640e87.14.1733217366415; Tue, 03 Dec 2024
 01:16:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202032035.29045-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20241202032035.29045-4-xiazhengqiao@huaqin.corp-partner.google.com>
In-Reply-To: <20241202032035.29045-4-xiazhengqiao@huaqin.corp-partner.google.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 3 Dec 2024 17:15:55 +0800
Message-ID: <CAGXv+5HsOgRCpGOFxEJorVD+=-6GbW_=K3AChkBSxTs27fNJ3w@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] arm64: dts: mediatek: Add exton node for DP bridge
To: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	hsinyi@chromium.org, sean.wang@mediatek.com, dianders@google.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 11:21=E2=80=AFAM Zhengqiao Xia
<xiazhengqiao@huaqin.corp-partner.google.com> wrote:
>
> Add exton node for DP bridge to make the display work properly.
      ^ extcon.

Same for the subject.

> Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com=
>
> ---
>  arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm6=
4/boot/dts/mediatek/mt8186-corsola.dtsi
> index cfcc7909dfe6..e324e3fd347e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> @@ -424,6 +424,7 @@
>                 ovdd-supply =3D <&mt6366_vsim2_reg>;
>                 pwr18-supply =3D <&pp1800_dpbrdg_dx>;
>                 reset-gpios =3D <&pio 177 GPIO_ACTIVE_LOW>;
> +               extcon =3D <&usbc_extcon>;
>
>                 ports {
>                         #address-cells =3D <1>;
> @@ -1656,6 +1657,11 @@
>                                 try-power-role =3D "source";
>                         };
>                 };
> +
> +               usbc_extcon: extcon0 {
> +                       compatible =3D "google,extcon-usbc-cros-ec";
> +                       google,usb-port-id =3D <0>;
> +               };
>         };
>  };
>
> --
> 2.17.1
>

