Return-Path: <linux-kernel+bounces-432236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213469E4815
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0122843FB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ABE1F541B;
	Wed,  4 Dec 2024 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MIaWaH1z"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DAD23918D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733352458; cv=none; b=eUO3QaABhGZgAQjB0Jkm1sW1kef50FYpKA0IG4nSlRWM9jQnBk6jLKllknrp9aB3qAVJdiThCdmjXhVy8yxMW2TgnKUCHfWhURN2Ly82ld8osvZmyAfm6ctlXP9p1OxajL8bQkiwCcpEa6KHrIiTRhAG76/eT2NOrif8X9UUY4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733352458; c=relaxed/simple;
	bh=kJdSvnUsUWuFAazx9AVYeMRAMXugvXd7n56wCE1Oaq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hc277Tgd0L60A+0YDoo2nY1qqrDwjHej4OQl/kpxQhoX1ZrpXy6Svpmrleda8ba00qbHcvtKAU+D0mAePYKvdQsGIsZmmNu30vasn0bV+3WcwJY2pJJD8BaH1Efm6u5Z6cyyAcnmdqvsEiSdznupMu8yEMfHbnVK8Zf0hdXIhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MIaWaH1z; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffdd9fc913so2521551fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733352453; x=1733957253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HJnxmfo5xvPN+49q760TRmvPlUcAyzClpyK24RSgC4=;
        b=MIaWaH1zJqcU2Yr1C8UDy8Zz/DWR6wHsBevwuK4f5cstgGbJ1Go69NLNOMpYibqfms
         IFxZGiPF2ngCzvsJ7xPLaT+UcejOHjnHERPk2nv24mJurv7uvYG29zUt6jJB/1ACE/WM
         vTbg5gZu46ipQXxen0hZt0hn8e/PuMnEeI8w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733352453; x=1733957253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HJnxmfo5xvPN+49q760TRmvPlUcAyzClpyK24RSgC4=;
        b=XF9r8hRnXGH0AuKuqtqzUp1b5TeI8gxe7jKjDVfnDyksUd3gJ8BcvpUxpzIeaNDgs2
         9fcfDg9hY3vXM3ynPdH1uEEXPt0Jt298CYF+IwXIKp/kB6fOw5zAYmEWj+qn5Y9lIj1z
         /ksIfRyCWgoDVdaIYdvmTTMWwtgmxzstJrQFC3c/wYQRcLPzNzxE+PQ/V3Mjr/ldD1e3
         UrLkMC3NW8Cioqxk3UUwhEoMreDQPVTTCQBi9mVDXEs9sBDNa3rs1TuNn60qtS87jivR
         W3zV2/UfTmr1rBEJ2kXLmhVFrlt8w2zPuYGyJFaU5d46L9XXn+8lh2Q2l8EAlsP5BqDC
         Z5qA==
X-Forwarded-Encrypted: i=1; AJvYcCVfwSoWc2Uvi3MTIpdygy+6hgqlqsbCU1k7tiSRRxa72MU5G+uHqGXQI7dQS5baqD5eNW/ZoIM93SEPuSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ENHRTfw9QKZLOCEo/tvYLOoBwtLk7KJ7T/CuokSEc8ngzRKK
	Z5FVvNioUKhhwWicAtpv5P0X3lEfjjj3HadBPiOKBTD96xH2UGQSuEghWZZvkEakYCo0wXoNDzq
	7worD
X-Gm-Gg: ASbGnctbSfSZPrDnJBhk9yd+Nf1coE2Op+BJavLuaJWoLdFgypvS7MfrjO/F0gEMx9Y
	3tRsrbzIAAVWhC/v/l0eCmkRHzVIQc28C9SpuFdDtx6pzPjSdoTEtvjTamKNVRbVjVRB878HrMP
	6GiMvc8VlNdz/3phe8YK3zvFLIlORpvymMAC4h5nSC4YzagG0Bdx7vCDoUW2sVDas/HxApIfXyO
	nRdoG4lAlxMKgUREX5ve3LVW9cx+b8WnJ0sdHHdilaUFb2wSIPN4FJlpRQpupjJjZX9/POhPqeo
	tOUodH57BjeRyg==
X-Google-Smtp-Source: AGHT+IHUnF2vjHMxL0HdApFhlf6cYfTGuWaoFDDOqxQBl+ocBdVWwDrxp4KnRPRM8vqIVYbrdN2xVA==
X-Received: by 2002:a2e:b8d2:0:b0:300:8de:d2a4 with SMTP id 38308e7fff4ca-30009c52bacmr47949391fa.17.1733352453283;
        Wed, 04 Dec 2024 14:47:33 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020dbb4bfsm87221fa.64.2024.12.04.14.47.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 14:47:32 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53df1d1b726so314264e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:47:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUh5PcErvw6dhnEJRg+0VNjArdvqZ464so27FPQkxs67RCPV14pArcrblx9JG6bw2wUvX+oUu7+myJ/FJ4=@vger.kernel.org
X-Received: by 2002:a05:6512:3f0e:b0:539:905c:15ab with SMTP id
 2adb3069b0e04-53e12a01745mr5161964e87.32.1733352451667; Wed, 04 Dec 2024
 14:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org> <20241204-topic-misc-dt-fixes-v1-3-6d320b6454e6@linaro.org>
In-Reply-To: <20241204-topic-misc-dt-fixes-v1-3-6d320b6454e6@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Dec 2024 14:47:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V8VwixdgNjyTL5m5YzEcCuCFE1iYAwBkdkcpzZ6OusgA@mail.gmail.com>
Message-ID: <CAD=FV=V8VwixdgNjyTL5m5YzEcCuCFE1iYAwBkdkcpzZ6OusgA@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sc7180-trogdor-quackingstick: add
 missing avee-supply
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 4, 2024 at 2:57=E2=80=AFAM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> The bindings requires the avee-supply, use the same regulator as
> the avdd (positive voltage) which would also provide the negative
> voltage by definition.
>
> The fixes:
> sc7180-trogdor-quackingstick-r0.dts: panel@0: 'avee-supply' is a required=
 property
>         from schema $id: http://devicetree.org/schemas/display/panel/boe,=
tv101wum-nl6.yaml#
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b=
/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
> index 00229b1515e60505f15fd58c6e7f16dcbf9c661b..ff8996b4de4e1e66a0f2aac01=
80233640602caf3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
> @@ -78,6 +78,7 @@ panel: panel@0 {
>                 pinctrl-names =3D "default";
>                 pinctrl-0 =3D <&lcd_rst>;
>                 avdd-supply =3D <&ppvar_lcd>;
> +               avee-supply =3D <&ppvar_lcd>;

Looks right. I guess technically they could be modeled as two
regulators, but it feels pointless. Looking at the schematics there is
a single component on the board that provides both the positive and
negative voltages. There are two enable lines on the component but
they're tied together on the board so we can't enable one separately
from the other anyway.

Thanks for the fix!

Reviewed-by: Douglas Anderson <dianders@chromium.org>

