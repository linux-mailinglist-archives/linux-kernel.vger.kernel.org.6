Return-Path: <linux-kernel+bounces-289076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 677B09541E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFFDDB2382C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2922B83CDA;
	Fri, 16 Aug 2024 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="21FlmIED"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9CE82866
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790135; cv=none; b=Kjh39JXTGOup5XbqZJelLX3zMyiu7SKnAfIi8cNYDGMKfQ+if26P4j+vN0Lu1NbjJgCWldeI8YZchtg8t6uBojjbmKNIsN3jIqMhy1XPRJcN/giCZMcIB/1E+pfmRb/Ztk4pgGdAA8ItbQ58Ewmd0h8IEkZjhh9tT1RY33DPfCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790135; c=relaxed/simple;
	bh=Fyd8Rghju8MutKywJURznuQGDhRTdOs24AGq+FEMZ5E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CPGgKrmzXKbgCqBsnVldszagzI6/gNG42ZDNQxs04bxdSRT0aF4Cea/JHBimGzApf04rKC0YrSO9rzrjSHbWpAQFOnWz7TycmlQ8FqdRFQuqrxhoW2RRnm77H+47NLWDk6umlM+uMBCKd33NSzHHTQJ+9t2O6vlyBmgtX/q9A80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=21FlmIED; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so216862166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1723790132; x=1724394932; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlvy/2cOpY4w4qpZGIrneMUP1FhFXubcCbWNdPksnnY=;
        b=21FlmIEDHKSC+hmkidrhhwE8kt4G0xMdf2U/ZWiAMauSrmESjcKGM8Q7Dwqx7bjkbg
         Fg974uAibwQv5ikFYWDTNge6Brdsr6AZFjEX7wfnrNn6QMGDNnDyJrCxEU3u6JsKMH0S
         aFznz1SMdhdJ2Nw2feQVoxBjOh0WFvKIE/F3EpHfpmS6UvcLoZ65GWy6+ah/+oHGnDAs
         UfNRdv46mANu22sNsR/JW0IPuIRBb+EZYzTxRzywjdk+Ie1BwJEekFUqly0/Ixit6oCR
         YrDnfcO8O5LTfrjU21coRdXACskOaINA2jAhcG3xBbgyOBWHYGkJy7x4j0rknLPa8Dkj
         i4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723790132; x=1724394932;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dlvy/2cOpY4w4qpZGIrneMUP1FhFXubcCbWNdPksnnY=;
        b=OCVbOHThtJDd+YiDCqAyTNnSlgNnMc6FZBePSk1RCWNOp70wJhC7fphqo2HgAivZro
         Xp6OqANl3oEnSeHku9xwC2f2aUpieToYKjyO2XsJdoOnBZADi4lqX65epzZ9ZpTbOhYQ
         j81OvDw7AOrEnuabKT9Rq/64CNrkrtIR/Azx8Xl7YEEkFHGHJH8ewA7tt+UXv6VSECAX
         hiQy73o8EyMA2ActXm/yzyRuQjfTVtrdKMBwH1wxvXYz/9UqpDNZYMlE3smuhsZamc7S
         04nlssjf+Xu7MHLbF9X8yIgOz6qiExLTk4GsqKvpkISh0Mlu4cPQvtKzJc92n46a5Zg3
         98dA==
X-Forwarded-Encrypted: i=1; AJvYcCVnoMt+CjjZ0XrB7cw7g7qRh0UvT5e8IJb4nVNgcnmJ47ihEZNdRiLZDpRDODN46V3kjX+1BygB77PqbuNzM+ByYMtJMEO6U/wtW4Rb
X-Gm-Message-State: AOJu0Yxv/FZle/pOZr4agDKoXlqXBzpmGC8fi+uA7S/jK/YZQLGMQ/Gn
	OONgUaXd//aRZNYNSUiZUL8iLn5r1AVlCytM5aSe78W4A+2+uAfMNMeTuK/B+GU=
X-Google-Smtp-Source: AGHT+IEjLooN9mJouFfwclDBmTI6IWvI0aT85+PtIm7Jj9agzY0qG27OrjnCsCVb6+1o8gjkiZQ/Qw==
X-Received: by 2002:a17:907:944a:b0:a77:db36:1ccf with SMTP id a640c23a62f3a-a8392a3bb13mr117533666b.42.1723790131615;
        Thu, 15 Aug 2024 23:35:31 -0700 (PDT)
Received: from localhost ([145.15.244.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838eeecesm206592166b.95.2024.08.15.23.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 23:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Aug 2024 08:35:28 +0200
Message-Id: <D3H4LOY4UHKJ.2E21EUSJWXQGJ@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] arm64: qcom: allow up to 4 lanes for the Type-C
 DisplayPort Altmode
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Neil Armstrong" <neil.armstrong@linaro.org>, "Vinod Koul"
 <vkoul@kernel.org>, "Kishon Vijay Abraham I" <kishon@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konrad.dybcio@linaro.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
In-Reply-To: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>

On Mon May 27, 2024 at 10:42 AM CEST, Neil Armstrong wrote:
> Register a typec mux in order to change the PHY mode on the Type-C
> mux events depending on the mode and the svid when in Altmode setup.
>
> The DisplayPort phy should be left enabled if is still powered on
> by the DRM DisplayPort controller, so bail out until the DisplayPort
> PHY is not powered off.
>
> The Type-C Mode/SVID only changes on plug/unplug, and USB SAFE states
> will be set in between of USB-Only, Combo and DisplayPort Only so
> this will leave enough time to the DRM DisplayPort controller to
> turn of the DisplayPort PHY.
>
> The patchset also includes bindings changes and DT changes.
>
> This has been successfully tested on an SM8550 board, but the
> Thinkpad X13s deserved testing between non-PD USB, non-PD DisplayPort,
> PD USB Hubs and PD Altmode Dongles to make sure the switch works
> as expected.
>
> The DisplayPort 4 lanes setup can be check with:
> $ cat /sys/kernel/debug/dri/ae01000.display-controller/DP-1/dp_debug
> 	name =3D msm_dp
> 	drm_dp_link
> 		rate =3D 540000
> 		num_lanes =3D 4
> ...
>
> This patchset depends on [1] to allow broadcasting the type-c mode
> to the PHY, otherwise the PHY will keep the combo state while the
> retimer would setup the 4 lanes in DP mode.
>
> [1] https://lore.kernel.org/all/20240527-topic-sm8x50-upstream-retimer-br=
oadcast-mode-v1-0-79ec91381aba@linaro.org/

Hi Neil,

Is there anything happening on this patchset? From what I can see there
were a few comments on the patches, would be nice if we could get this
in at some point.

Regards
Luca

>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Vinod Koul <vkoul@kernel.org>
> To: Kishon Vijay Abraham I <kishon@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-phy@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>
> Changes in v2:
> - Reference usb-switch.yaml in bindings patch
> - Fix switch/case indenting
> - Check svid for USB_TYPEC_DP_SID
> - Fix X13s patch subject
> - Update SM8650 patch to enable 4 lanes on HDK aswell
> - Link to v1: https://lore.kernel.org/r/20240229-topic-sm8x50-upstream-ph=
y-combo-typec-mux-v1-0-07e24a231840@linaro.org
>
> ---
> Neil Armstrong (7):
>       dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Reference usb-switch.y=
aml to allow mode-switch
>       phy: qcom: qmp-combo: store DP phy power state
>       phy: qcom: qmp-combo: introduce QPHY_MODE
>       phy: qcom: qmp-combo: register a typec mux to change the QPHY_MODE
>       arm64: dts: qcom-sm8550: allow 4 lanes for DisplayPort and enable Q=
MP PHY mode-switch
>       arm64: dts: qcom-sm8650: allow 4 lanes for DisplayPort and enable Q=
MP PHY mode-switch
>       arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13: allow 4 lanes for D=
isplayPort and enable QMP PHY mode-switch
>
>  .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |   7 +-
>  .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |   6 +-
>  arch/arm64/boot/dts/qcom/sm8550-hdk.dts            |   3 +-
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |   3 +-
>  arch/arm64/boot/dts/qcom/sm8650-hdk.dts            |   3 +-
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts            |   3 +-
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 169 +++++++++++++++=
++++--
>  7 files changed, 174 insertions(+), 20 deletions(-)
> ---
> base-commit: d4eef8b2e18d3e4d2343fb3bb975f8ac4522129a
> change-id: 20240229-topic-sm8x50-upstream-phy-combo-typec-mux-31b5252513c=
9
>
> Best regards,


