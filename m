Return-Path: <linux-kernel+bounces-428901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA5C9E14CC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0309164571
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8651B1CDA17;
	Tue,  3 Dec 2024 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bp9cDtKY"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D911BE251
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212629; cv=none; b=R0Jc2IYA/h+UgjhL2BcqpVQX2jaf3l4dkoFMrZ9XJVkT0Q9bHVpU8ltTf9HoYnb0rUJovG4Rd8Yp/eDq2Db4zbEg3Ypb3/KtjZyJTM+M2jZcFrdQaxE+hKyiE5gwov0hHjS6q7+m6yVJTP6y00MxyMDLyI9QGLsdjDwsAfirglw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212629; c=relaxed/simple;
	bh=BN9oqBHKXYcufRO+eCasqfzBY8zLc9V3aSmv0W/2EC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UgtbKW4FsarRpH6wyRhMKc16b/LDsI56/5rndqEmbc1CrURvOHrChpJ2m+mwDoHBFvUZjQSZ68VIwiDAxda76/kUV3iyZEIwyf5r1pzITgpDnYGmRpnYCNljZRaOalf7VZIylp8diaud5Sv9FtggWLLtS/eDBiU2pw+eCtv/UPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bp9cDtKY; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53de852a287so5844729e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 23:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733212626; x=1733817426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WSM6TGpmmItz1uM+DrPz33P+iBBhPav9/6+0hNpzfY=;
        b=Bp9cDtKYIulZYLJVsMyF4pbX80JXp7spNIRLp4Z3kZZEjnIn3jlZ0HMyVF3kMzayq2
         wOF3k7XrBBw1vjbeOOLaTynL7BI+r352g7ZouMhhK7bn6DdBX3rsFNRC2VQuHwgkVk/O
         USaav2g7eV97nFYkw7/gDAHYL0EKww5/Xk1Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733212626; x=1733817426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WSM6TGpmmItz1uM+DrPz33P+iBBhPav9/6+0hNpzfY=;
        b=ALUW8WquJxInSM8w1RFd/IgrOlJskNTxHnTZ3jVXjTC8yRTsQPOUxMkK9QjrcGNEfv
         GtVqxlFq+Ax+NkHMmAv7WHYfgtRKm19HJcFZT5xHph4EojsD2aUzP8J/S56CkEZcapVc
         OUM0JTQ6A+g6UHA3axN08+KcGNGD7o4MNFPFIBjBk8JrhN+7Hd8JWdXo8UOCi4nsLQqa
         hO2WFFvpRjMHedset1ZNwmGWeguh+MIZtAFkgwNd174gjQFvMg4MSQcjm7CrB6J/TTZy
         gQUxL8/P/pS7P8vkx3Lo8ZiuUeU/twu88/SoviHyAtevARzljokGZqmgo6uR3yXDiCy+
         V1iw==
X-Forwarded-Encrypted: i=1; AJvYcCV6/mzsbSftt9qguCZ6QzEnLLm5GTZ90oehYfGQVusK/wk+KEs4Z8SNome5on4W0M84VQlHAxNZoPF2Oy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ndF4KSRfYm8Nat6/pHUucVDntII8DUvu5ucXAPU8dLqTJStE
	gy2lw41wJkEpituzZqMi2lJ0aT2VHvcWiMXirnpbX84Ouc5rF2MnO+xoMHxv8q1ivI19090/r2Z
	yRP3gOgjlpbHCDx6BBNJ+bzf8+llLezCOinac
X-Gm-Gg: ASbGncsaIjbwGx/v+hcwlmansUWnps06v2AmW5RE9sifmJ2SdEpJYMbDRBg7W4bZbUE
	s4raI0UkLKcNGhshLHH8UnEFUZmUxrp/+93zok3PC8LvgBjVSvdy+ly5suBg=
X-Google-Smtp-Source: AGHT+IGpQFfklgML0v0C4LtaU2v74NIo4jtxn8wZdpHFLuloc5xneMzv1C9DI4bftKit5brhjQgwO+p7wVaG2CY8JIk=
X-Received: by 2002:a05:6512:138c:b0:53d:e5f0:32bb with SMTP id
 2adb3069b0e04-53e12a3929bmr524178e87.51.1733212626459; Mon, 02 Dec 2024
 23:57:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202032035.29045-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20241202032035.29045-5-xiazhengqiao@huaqin.corp-partner.google.com>
In-Reply-To: <20241202032035.29045-5-xiazhengqiao@huaqin.corp-partner.google.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 3 Dec 2024 15:56:55 +0800
Message-ID: <CAGXv+5Hp030iiCXDYHYX6F1mD5WnsL=EziHPfM7Hm4kMxnhgXw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64: dts: mediatek: Modify audio codec name for pmic
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
> change `codec` in pmic (in mt8186-corsola.dtsi) to `audio-codec`
>
> Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com=
>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm6=
4/boot/dts/mediatek/mt8186-corsola.dtsi
> index e324e3fd347e..cebb134331fb 100644
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

