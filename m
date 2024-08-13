Return-Path: <linux-kernel+bounces-284156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDED94FDA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE5D1F23D50
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E90B3BB32;
	Tue, 13 Aug 2024 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="BDdFS+O4"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0EF3218B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529753; cv=none; b=BcN4h69STTK2nz/XH+LPoJ/qP/2c1CB8al2tkX9NZUgsmrFvJTjgfK1gFHpU209zgg8ied7n1VvWXkcnu7eqhKCYlgX9HPq44Da1Q3CZrFYFV5ZMfZHeAVeQy4b6u2u6CDhBTlwUB0QGidJ3mqACbUQ0V1QdnsXXEc2yYJgvHKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529753; c=relaxed/simple;
	bh=MDlcYP7MFghiJnxFdNtc6UqcKOzHtvSJqJ34W51yRWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fq0J3OIlgsWO3o/XB/HYj9SKjrv2dIyFYDADr2POVAEEHCMy/DaBSPtd96qSSKhR6l3ZGO9vk9XQtgdkKths6cvBoIFjTIoAqUQbRMW2vFEo/QdomzJbGvp5QOJE4N2actaYCYecuevOH/mlmRBnMynIsNpwD+83dGL64NcYtys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=BDdFS+O4; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so6609431a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1723529750; x=1724134550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ+ckW8fPFa+FfxKAJA2U4uZ365cTlaQpuQmLUm/TYk=;
        b=BDdFS+O4AIU+uaH5ZV/ZlF+pnfdRwgoMNaCsbLEywKhQRO2wnPXVfwMlHdrTJGCiMZ
         N2DR9V+ggnD6XlcCIsdKklZcQBDMC/XG1BvCQ9Ww92TNjFrKui0LnctUTWrKy2fK0kS4
         tX8j0S3lqj0IVLZzXUGMIB/vm61YQ2V6ZuaVqCDoE/n80gFzUSh+5akWDfbJhY7zn4xl
         UkO5hGKerkGrCGwdcsNzp7Q2BBatQgkjQLBOE0fQkhpPuQnszg+EMydDVfMgUAdBE5ji
         sCW+n3+fZOMH9inK5Ode7zWRwL/+nZymrobiJgqiHCqvY85odUH7QQlLyYaDVI05xu2T
         4LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723529750; x=1724134550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJ+ckW8fPFa+FfxKAJA2U4uZ365cTlaQpuQmLUm/TYk=;
        b=xM0qg6XbM8QwX7zELfFXbjNr0OW2D8de1QfZtp9NqOaOXYkp/cR1Ta3l4VHvWOkSqt
         9BPQV6tCi0CEXtccwgvVugMI2er9rZx0Vy5sTmfw/wUBM9fshzXZy7f22+IE4Pxz1YgS
         obn7wl937Z/kZYvqo1UR+0DxfCCVIq+mDbzOVgOhxrxDPlHETkuRxkzwF1zDSlPSwJYv
         f9ssaNPc8tThTJHQegJ1nrcwHdzW841bnHAjlGRh9mX/MHTfnTOXRD/i52Qq+xnQUmb8
         64tPA4xE19uOTsRGsjgsURdqy9AltvZxbOYXkbET0u6EUXrF36SVS/vM3LWuQfUdPnPR
         ROSg==
X-Forwarded-Encrypted: i=1; AJvYcCVxvt963747hCXusNFEHeypDuFAWLqDXhLDt6+FK0TkjUH6CqcJ35ZM7HkUai+C0ePiu2Z1FF8vPUWdiHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGug5pR/6p+sBC/P6KfotzhseMUUpGEiVfeGI9PjeyfOKlsqGt
	O88olmBW3mz6ESaCxIkwfU6UqaYaD1E8kqblAVRXJKPxJkCXR+9oAmREGcoJPhU4g3oeqZNeFB3
	cLczRP5m6ye5939VFJKkNN92IMZNRYTOP+YXoPA==
X-Google-Smtp-Source: AGHT+IGu1hBC7Cs3wwmL9kJy5yplkBo3X8qqjVkv3nvp18pwu0qYrZ4GOTjyCM5ylwZ5iXpmXEKU3VQO55wGkHKnQSQ=
X-Received: by 2002:a05:6402:2353:b0:58b:585b:42a2 with SMTP id
 4fb4d7f45d1cf-5bd44c7cb00mr1846131a12.38.1723529750024; Mon, 12 Aug 2024
 23:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812-sc8180x-pwrkey-enable-v1-1-2bcc22133774@quicinc.com>
In-Reply-To: <20240812-sc8180x-pwrkey-enable-v1-1-2bcc22133774@quicinc.com>
From: Steev Klimaszewski <steev@kali.org>
Date: Tue, 13 Aug 2024 01:15:38 -0500
Message-ID: <CAKXuJqgOfqEJQhcLXYV0nUMe2TOOM6eZmYjP6518hwLvR6jShQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: Enable the power key
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 10:30=E2=80=AFPM Bjorn Andersson <andersson@kernel.=
org> wrote:
>
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
>
> No input events are generated from the pressing of the power key on
> either Primus or Flex 5G, because the device node isn't enabled.
>
> Give the power key node a label and enable this for the two devices.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 4 ++++
>  arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi         | 2 +-
>  arch/arm64/boot/dts/qcom/sc8180x-primus.dts         | 4 ++++
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/a=
rm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> index 575a1a5ae20f..62de4774c556 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> @@ -484,6 +484,10 @@ &pcie3_phy {
>         status =3D "okay";
>  };
>
> +&pmc8180_pwrkey {
> +       status =3D "okay";
> +};
> +
>  &pmc8180c_lpg {
>         status =3D "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi b/arch/arm64/boo=
t/dts/qcom/sc8180x-pmics.dtsi
> index b6f8d1558c0d..451c9b984f1f 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
> @@ -75,7 +75,7 @@ pmc8180_0: pmic@0 {
>                 pon: pon@800 {
>                         compatible =3D "qcom,pm8916-pon";
>                         reg =3D <0x0800>;
> -                       pwrkey {
> +                       pmc8180_pwrkey: pwrkey {
>                                 compatible =3D "qcom,pm8941-pwrkey";
>                                 interrupts =3D <0x0 0x8 0x0 IRQ_TYPE_EDGE=
_BOTH>;
>                                 debounce =3D <15625>;
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boo=
t/dts/qcom/sc8180x-primus.dts
> index 9447c1e4577b..79b4d293ea1e 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
> @@ -578,6 +578,10 @@ &pcie1_phy {
>         status =3D "okay";
>  };
>
> +&pmc8180_pwrkey {
> +       status =3D "okay";
> +};
> +
>  &pmc8180c_lpg {
>         status =3D "okay";
>  };
>
> ---
> base-commit: 9e6869691724b12e1f43655eeedc35fade38120c
> change-id: 20240812-sc8180x-pwrkey-enable-9fe58187583e
>
> Best regards,
> --
> Bjorn Andersson <quic_bjorande@quicinc.com>
>
>
Tested on the Lenovo Flex 5G.  When I hit the power button, it does
indeed want to turn off now.
Tested-by: Steev Klimaszewski <steev@kali.org>

