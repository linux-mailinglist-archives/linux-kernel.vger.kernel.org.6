Return-Path: <linux-kernel+bounces-227248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7E2914DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBD6283981
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772FA13D60F;
	Mon, 24 Jun 2024 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pf3phNxj"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2B51311A1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234515; cv=none; b=SKFdEqwnEzLOxPf8mCeqtsJjq76xJtno6OKRq0CDiaJqGMrP/eFR8RCRM9FycjMdjnFlByHd8fporhO2drNnOW8XFcBpHMD1B9sku6K1gQeCpy9gIVRKPTQgRzD0BwQSHk0qFa4QQnL+zgJaUikx8M1pd0IgpiHr+zLv7LSmdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234515; c=relaxed/simple;
	bh=NSk42wQXT5/Xm/NXv1x7pyxV8bcBaiuQanGLDAOqvow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BydeDPMlVRztkpGMIaDFFNC51kpsx220O3KdrsnVgkb0UydSWiRuuDHRnpSVkD0y+WC17Ju91FCqcJ7Km0bb9yWyJA8xAId8mr5tbBqRNMoM6vgzOIoaSWxNPdJ0sB8uyT9TueTJmy5O63aSskCc+Ns/Gm4qvXOKg2j/d2W0SWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pf3phNxj; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dfa71ded97bso3335770276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719234512; x=1719839312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iJ0GaeWHZJU3apbaE0PkNJm8vYB/Ehr9D/Vuo2kLMSY=;
        b=pf3phNxjKs6enxhgGaf5LiavBYcKvhKZHABr5D3a8MkDwZTuHmHA3uz+lAgIkaIdKw
         /CpkkMEnG8sgt5oL8DFb5R/XTs/6IOJSmPQoJ9mbVXF81M2eP1xeGsCFBKMHruAwUd2Q
         Sr2uwxl8zE4vnx3fkQJp6U8/MK6f6ABqzL/wtmykqD3CMP64wjtQxMOA2UCfYglaiTvs
         4ldV7g5h3nrVgO+VWuofqnzFMajU5jmDeQD/Pn8RigVlmXjvu6BpfuO2NTl6ryaWT5Fa
         OhXbKCZEzPxdfXUuQSvz64VfxuU7hJG/+O/4S4flAqiEyG2JQfxsNY3DraOsPu1nF/fK
         pfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234512; x=1719839312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJ0GaeWHZJU3apbaE0PkNJm8vYB/Ehr9D/Vuo2kLMSY=;
        b=hJGsN7nd4KTSFIc/7DjKdKXC7xzwdPZnOFoJ37KW0nsbn963AHcNzZkOJ4Vj120T9d
         t/PHtOJb1XAnVgD5eaugx0eQv0sdV/SkbzUnqJPaSXO7/s43zECq39lLR4fDhhCSjBd7
         qta9zEzxN/vBbxCbWm2YRUUIIhW/tP6tnBflwkNGMSPHCc+Db1GVR56hUDLtnd0S387x
         N5zKYnm7yt+2VR2BRxigIszvhwIux50TCV1EQJ7gjgyPc20Tbe9JezyrDxO/QwEuJ3Ts
         FxgadogTozD5+lvnl3Q+g9AvmDBxMqPeWW8cD7y0cqxmrGO6FUzENw1ZQt2vn2Yhv2IB
         6JFw==
X-Forwarded-Encrypted: i=1; AJvYcCXTihV4s3ouXRsHhuoOIV8YiKD2irtmanXVCvYUy/eCOGAtQb1TyYc80nw0fxaG2CgTmu3crL7I+4zStMVR9cBmzPlCgAsqgDkUHax8
X-Gm-Message-State: AOJu0YzS/oGODWHdOnBZQm7M5GCxUzn56dUd6W90Xk1l16wZqmY21srY
	YVVdO+myqr8832w+vRZlJ1v+RdHW+kEsvZIRaodHPmKEzTuocn9tEgmf8cL9L74qNEKWcmwZ6bG
	phmOAcFobVGOYpAeZ5Pdvnv6hTOWzB1kYjnZqWg==
X-Google-Smtp-Source: AGHT+IE/6w9SX4vD+UyerjeEC2niu6U7wagAXCpv5/FdgO2Xn6aChU2WgKm6SQVmwy1mG2UdMHIk7z4HCPL2yG6vkn4=
X-Received: by 2002:a05:6902:f0f:b0:dff:9d2:28c0 with SMTP id
 3f1490d57ef6-e02f9fcb425mr2801750276.21.1719234512544; Mon, 24 Jun 2024
 06:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624-b4-rb2-fixes-v1-0-8d763ee4e42e@linaro.org>
 <20240624-b4-rb2-fixes-v1-3-8d763ee4e42e@linaro.org> <8411fee8-7e09-421a-a52b-487acd3a3e24@linaro.org>
 <CAA8EJpoifd-Z175ZX6f6Pw+bQHY4F-rX05YoqJNr810_1KLm9Q@mail.gmail.com> <95a69492-afc2-4215-aa50-5d7aedbb1556@linaro.org>
In-Reply-To: <95a69492-afc2-4215-aa50-5d7aedbb1556@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 24 Jun 2024 16:08:20 +0300
Message-ID: <CAA8EJpodS=x9BZwpnOLN2eOVA31pNy9YT7rJjVfKqAKJ7c3O_A@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: prefer host mode on dev boards
To: neil.armstrong@linaro.org
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 15:33, <neil.armstrong@linaro.org> wrote:
>
> On 24/06/2024 14:31, Dmitry Baryshkov wrote:
> > On Mon, 24 Jun 2024 at 15:28, <neil.armstrong@linaro.org> wrote:
> >>
> >> On 24/06/2024 14:23, Caleb Connolly wrote:
> >>> Generally, when given the choice these boards should prefer host mode
> >>> since they're SBCs. When attached to a laptop (which is host-only) they
> >>> should still fall back to peripheral mode.
> >>
> >> It's really not what I observed on sm8550/sm8650 QRD/HDK, as the power
> >> is setup for peripheral by the bootloader and without an actual UCSI/PD
> >> negociation it would only be functionnal as peripheral mode.
> >>
> >> So this is definitely untrue on sm8450/sm8550/sm8650 HDK/QRD/MTP.
> >
> > But we now have the UCSI support for those platforms, don't we?
>
> UCSI doesn't care about role-switch-default-mode, it's the default
> fallback role to set when no role was explicitely set by UCSI.
>
> Setting host won't make it work because the power support is handled
> by the UCSI firmware. setting role-switch-default-mode = "host" will
> make the USB port unusable if UCSI fails to start since it's
> physically set to peripheral mode.

Let's not mix the source/sink and host/peripheral, those are
independent. But I see your point. Neither TCPM nor UCSI check this
property. So it seems it's incorrect to set it even for the TCPM
hosts.

>
> Neil
>
> >
> >>
> >> Neil
> >>
> >>>
> >>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >>> ---
> >>>    arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 1 +
> >>>    arch/arm64/boot/dts/qcom/qrb2210-rb1.dts     | 4 ++++
> >>>    arch/arm64/boot/dts/qcom/qrb4210-rb2.dts     | 4 ++++
> >>>    arch/arm64/boot/dts/qcom/sm8150-hdk.dts      | 1 +
> >>>    arch/arm64/boot/dts/qcom/sm8350-hdk.dts      | 4 ++++
> >>>    arch/arm64/boot/dts/qcom/sm8450-hdk.dts      | 1 +
> >>>    arch/arm64/boot/dts/qcom/sm8550-hdk.dts      | 4 ++++
> >>>    arch/arm64/boot/dts/qcom/sm8550-mtp.dts      | 4 ++++
> >>>    arch/arm64/boot/dts/qcom/sm8550-qrd.dts      | 4 ++++
> >>>    arch/arm64/boot/dts/qcom/sm8650-hdk.dts      | 4 ++++
> >>>    arch/arm64/boot/dts/qcom/sm8650-mtp.dts      | 4 ++++
> >>>    arch/arm64/boot/dts/qcom/sm8650-qrd.dts      | 4 ++++
> >>>    12 files changed, 39 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> >>> index c4cde4328e3d..bac4ed5874b6 100644
> >>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> >>> @@ -657,8 +657,9 @@ &usb_1 {
> >>>
> >>>    &usb_1_dwc3 {
> >>>        dr_mode = "otg";
> >>>        usb-role-switch;
> >>> +     role-switch-default-mode = "host";
> >>>    };
> >>>
> >>>    &usb_1_dwc3_hs {
> >>>        remote-endpoint = <&pmic_glink_hs_in>;
> >>> diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> >>> index e19790464a11..bece4896ca23 100644
> >>> --- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> >>> @@ -593,8 +593,12 @@ &uart4 {
> >>>    &usb {
> >>>        status = "okay";
> >>>    };
> >>>
> >>> +&usb_dwc3 {
> >>> +     role-switch-default-mode = "host";
> >>> +};
> >>> +
> >>>    &usb_dwc3_hs {
> >>>        remote-endpoint = <&pm4125_hs_in>;
> >>>    };
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> >>> index 1c7de7f2db79..17d36f0ef5ab 100644
> >>> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> >>> @@ -661,8 +661,12 @@ &uart4 {
> >>>    &usb {
> >>>        status = "okay";
> >>>    };
> >>>
> >>> +&usb_dwc3 {
> >>> +     role-switch-default-mode = "host";
> >>> +};
> >>> +
> >>>    &usb_dwc3_hs {
> >>>        remote-endpoint = <&pmi632_hs_in>;
> >>>    };
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> >>> index bac08f00b303..fe548d795490 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> >>> @@ -695,8 +695,9 @@ &usb_2 {
> >>>
> >>>    &usb_1_dwc3 {
> >>>        dr_mode = "otg";
> >>>        usb-role-switch;
> >>> +     role-switch-default-mode = "host";
> >>>    };
> >>>
> >>>    &usb_1_dwc3_hs {
> >>>        remote-endpoint = <&pm8150b_hs_in>;
> >>> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> >>> index e031ad4c19f4..20d5c54cfcf9 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> >>> @@ -847,8 +847,12 @@ &ufs_mem_phy {
> >>>    &usb_1 {
> >>>        status = "okay";
> >>>    };
> >>>
> >>> +&usb_1_dwc3 {
> >>> +     role-switch-default-mode = "host";
> >>> +};
> >>> +
> >>>    &usb_1_dwc3_hs {
> >>>        remote-endpoint = <&pmic_glink_hs_in>;
> >>>    };
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> >>> index a754b8fe9167..ebafcbe6859e 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> >>> @@ -1098,8 +1098,9 @@ &usb_1 {
> >>>
> >>>    &usb_1_dwc3 {
> >>>        dr_mode = "otg";
> >>>        usb-role-switch;
> >>> +     role-switch-default-mode = "host";
> >>>    };
> >>>
> >>>    &usb_1_dwc3_hs {
> >>>        remote-endpoint = <&pmic_glink_hs_in>;
> >>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> >>> index e0dc03a97771..1efda478b7b9 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> >>> @@ -1252,8 +1252,12 @@ &ufs_mem_phy {
> >>>    &usb_1 {
> >>>        status = "okay";
> >>>    };
> >>>
> >>> +&usb_1_dwc3 {
> >>> +     role-switch-default-mode = "host";
> >>> +};
> >>> +
> >>>    &usb_1_dwc3_hs {
> >>>        remote-endpoint = <&pmic_glink_hs_in>;
> >>>    };
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> >>> index 26dfca0c3e05..7b05932f9c36 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> >>> @@ -945,8 +945,12 @@ &ufs_mem_phy {
> >>>    &usb_1 {
> >>>        status = "okay";
> >>>    };
> >>>
> >>> +&usb_1_dwc3 {
> >>> +     role-switch-default-mode = "host";
> >>> +};
> >>> +
> >>>    &usb_1_dwc3_hs {
> >>>        remote-endpoint = <&pmic_glink_hs_in>;
> >>>    };
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> >>> index 361b0792db4f..744bdc846e70 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> >>> @@ -1211,8 +1211,12 @@ &ufs_mem_phy {
> >>>    &usb_1 {
> >>>        status = "okay";
> >>>    };
> >>>
> >>> +&usb_1_dwc3 {
> >>> +     role-switch-default-mode = "host";
> >>> +};
> >>> +
> >>>    &usb_1_dwc3_hs {
> >>>        remote-endpoint = <&pmic_glink_hs_in>;
> >>>    };
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
> >>> index 092b78fd8a3b..f07a56583e7d 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
> >>> @@ -1300,8 +1300,12 @@ &ufs_mem_phy {
> >>>    &usb_1 {
> >>>        status = "okay";
> >>>    };
> >>>
> >>> +&usb_1_dwc3 {
> >>> +     role-switch-default-mode = "host";
> >>> +};
> >>> +
> >>>    &usb_1_dwc3_hs {
> >>>        remote-endpoint = <&pmic_glink_hs_in>;
> >>>    };
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> >>> index d6f91580ba8d..1a9a31423af4 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> >>> @@ -839,8 +839,12 @@ &ufs_mem_phy {
> >>>    &usb_1 {
> >>>        status = "okay";
> >>>    };
> >>>
> >>> +&usb_1_dwc3 {
> >>> +     role-switch-default-mode = "host";
> >>> +};
> >>> +
> >>>    &usb_1_dwc3_hs {
> >>>        remote-endpoint = <&pmic_glink_hs_in>;
> >>>    };
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> >>> index bd60c2770da2..031b7ada8eb1 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> >>> @@ -1285,8 +1285,12 @@ &ufs_mem_phy {
> >>>    &usb_1 {
> >>>        status = "okay";
> >>>    };
> >>>
> >>> +&usb_1_dwc3 {
> >>> +     role-switch-default-mode = "host";
> >>> +};
> >>> +
> >>>    &usb_1_dwc3_hs {
> >>>        remote-endpoint = <&pmic_glink_hs_in>;
> >>>    };
> >>>
> >>>
> >>
> >
> >
>


-- 
With best wishes
Dmitry

