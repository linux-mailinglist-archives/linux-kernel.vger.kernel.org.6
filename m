Return-Path: <linux-kernel+bounces-410238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9619CD6C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E892832AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 05:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C9217C7CB;
	Fri, 15 Nov 2024 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MrRdo6eK"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022CB1632DA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650288; cv=none; b=eLwUPW3DBnflxH2lFH7t/f0sGrgBJVFlPyMxjcO01r8w9AEIpBkpBymlZnZgDeSFKqlNHDVD38ai3x8rcwDAVCH//k+fuwBe7GrYb8QEaCGaARxDP7wc1dgHjHzn12E4LomoLF1chxwQFj6a6Cv2vW/IhDo9Om1yXlbZIB9wIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650288; c=relaxed/simple;
	bh=kMxPLdg2xTIUu8NOMQWZJ6CNX2JXgroqulwSiKUnCPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FQBD+5AfLXsxaBgDI0eW7/O3YDnOdOCxqzQ+NAXs8lXmla4fUhd6fqMKZ4JAklqcaoWoDp/UTwkY4UViX2l4acagd0tuZL+IWZ/l0wvcI70/6AmoSlmor6IgMCw7JgY5AhfpUiCwKipL9FlOHOzeljRFFdFuX1/f+Fom2aWpGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MrRdo6eK; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-288fec398f8so184605fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731650286; x=1732255086; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FCEL5cvn/DmJs+eCH4aavMuPmImiCDAr4Q8vsptoYs=;
        b=MrRdo6eKLz/yg9ZjYXOwrtJ58cyNfrN4SgSMTHSKeixFDVzEAg2lyHiFNfsOx9Ncxg
         XWeHxYTqzez/5HdspQ8879gNOMhOmq0Wsz2TyL2x4YhrShufLPxj9hupGcn9wdG5dp9I
         YRNytOVUtFiGxc6+MoO24z5TBfYrlZkqMj5QOWJEPWEFTlUeeMhbw468cU0ppBDCTIvE
         ohCOrJqXj66rcTSrz9Ki6tqCS7yiFZxeqU6kMeh89ukR6DXKlwxq/YzSICWuOUXff5Ue
         CTPBvy9eDPf9Vhj7KQNwmYtX6Ad61Ywgdj5l0xx+UdY/adPmZO26VcxKHvu8pPK7P8WD
         lQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731650286; x=1732255086;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FCEL5cvn/DmJs+eCH4aavMuPmImiCDAr4Q8vsptoYs=;
        b=MSnzuAmOkHR0zZIf20av/x85d9KBfQi/GBBQjrJro4ufTYMqaYUGobrznF5OuHOyR0
         6PM0jy06eCltnL2IotG2SYGmhT6Lm2Ao6RI2LPO+v2g9kCTcYlpCHgp74ccTHZjHJ7s1
         /Vq+VXSP+g+45g6PjSkhZhjLU3sfXVQ5f/+4qfrDV1fAdb+FokMCoQSThm2Drass2aP8
         Hgttsa9sosoY4XMglWpNZ7+/AnIABA8MIoXuDq71DGCkS69oFTAcfXtoghiPxOjnVZ68
         LfvfLNHnBPHfQpc3BB6LYTEIKeBwyAdlSuk/PkEBh1fyeT5sxecxDv6xIxPOudMgJXzz
         4rKw==
X-Forwarded-Encrypted: i=1; AJvYcCVoH88ocdTVThxFh5sCiTZIJLCNYPgwb4hI6o3PpTHHor/htNGYVp5YHxFFFKPYAd2hqwayG0R85NmP0N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyOfiWErti+UOpV0J1duei6+NPh55EU6MWtGM8Iy8UfGUAvO9q
	DYunicGk/calLI6blfjPN9U62YxQuz1uXtH2t8OcclX9N9NWFtrOEcXWXhnmw13urZ76/1bMbiL
	ckJFU5Iqcpytmji/wj/TUCiNedsZhU1E/aXbACA==
X-Google-Smtp-Source: AGHT+IH08LKZaT/MNLlQJFmAnCHMH+5h4dFmcwDILxNxHwbbhWEamUPv8K0yf2DWpwhOv7gBw7hRU0rNhv2SZ1Q9U8g=
X-Received: by 2002:a05:6871:aa01:b0:260:ccfd:1efe with SMTP id
 586e51a60fabf-2962dd0882fmr263152fac.6.1731650284569; Thu, 14 Nov 2024
 21:58:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021072626.15102-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20241021072626.15102-5-xiazhengqiao@huaqin.corp-partner.google.com>
In-Reply-To: <20241021072626.15102-5-xiazhengqiao@huaqin.corp-partner.google.com>
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Date: Fri, 15 Nov 2024 13:57:53 +0800
Message-ID: <CADYyEwSjV=YQ2dJ7+RwQFif7WHU7PCDPxbh4OwuBNULsoQ7bkQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 4/4] arm64: dts: mediatek: Modify audio codec
 name for pmic
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	wenst@chromium.org, hsinyi@chromium.org, sean.wang@mediatek.com, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.or, 
	Doug Anderson <dianders@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

No one has responded to this patch for two weeks. Please help to review it.

thanks

Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
=E4=BA=8E2024=E5=B9=B410=E6=9C=8821=E6=97=A5=E5=91=A8=E4=B8=80 15:27=E5=86=
=99=E9=81=93=EF=BC=9A
>
> change `codec` in pmic (in mt8186-corsola.dtsi) to `audio-codec`
>
> Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com=
>
> ---
>  arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm6=
4/boot/dts/mediatek/mt8186-corsola.dtsi
> index 943837f20377..13e464dac1be 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> @@ -1276,7 +1276,7 @@
>                 interrupts-extended =3D <&pio 201 IRQ_TYPE_LEVEL_HIGH>;
>                 #interrupt-cells =3D <2>;
>
> -               mt6366codec: codec {
> +               mt6366codec: audio-codec {
>                         compatible =3D "mediatek,mt6366-sound", "mediatek=
,mt6358-sound";
>                         Avdd-supply =3D <&mt6366_vaud28_reg>;
>                         mediatek,dmic-mode =3D <1>; /* one-wire */
> --
> 2.17.1
>

