Return-Path: <linux-kernel+bounces-371207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BFF9A37FA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B06E28404D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AF318C937;
	Fri, 18 Oct 2024 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pzcJQHYR"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FD313C816
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238787; cv=none; b=EFTUR05o79vL1Jg+HIiWcWdqaNrcKorlJ8IRXXmUWuwf972QfgDeh0YeEx7lPKhrZ4uDRlVgdlvjfC6549bB1AmbvjzWbf+6s7PL6dMv9uuGyoycGj+SUz1Gvrqu0To8zq1Y/pZIvDVjOuU7d0r5jScyOuth/vIyPsAFBBuIRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238787; c=relaxed/simple;
	bh=HZ6YXgVkHMC+W12bcHr8/VXyz5WVWmo/IJL16rs+v9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+898mInBcj8aQtRJPZJjRxCypq2LLKJ5l8skfeE1lSyjXGg3bT0aWR3ovtaY9cDZgTdfylzoMNWZCAg4A6i83rEGn1iZ9RNMUI/n+jxW0X68iQNw6N4eUKk0v4KPkAex4OI3GEv1+plcj9y2H72RGfaAvNMk42nianTbC02EH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pzcJQHYR; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e290222fdd0so1567324276.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729238784; x=1729843584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UJxs3TzRvpvh37ncfDE5O/qusWTGJaGSYhsl43ibuBM=;
        b=pzcJQHYRoqv8djQOPQ9b0wm56BqP4HuDDduSr7ZAhGzz1H/et/qDnbpRQfabXGJV2y
         lCjb2aeVRqfh39GoVc/nBNtnUoBcRrCwC0bBzgFCrkYrdjGpOMCArHmk+I+3AH8FB50z
         c3FpD6/PCv5hiXGmV0OC5B1tRbZg/lQwGMiGExvF/NxCCpSIPScwllQITYmvy8UVocoJ
         A4g5xVE5sZrQj7OP43vMnUaZp1uZKwwg/IlUheNUqCiRVsL1bQ+fEyfZf/8Zot6QY6DV
         LykYQ43ccTLSSvAvnXRAx26SGWtqFnJXJkfYNJZF9nka9VHr8msyzHPEh5d011Xauu76
         6xJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729238784; x=1729843584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJxs3TzRvpvh37ncfDE5O/qusWTGJaGSYhsl43ibuBM=;
        b=fKeAUq/q+TzDvJB8RyHlBuU6yZCKQrjCN7lD2j4BEEjCFdS9atm+Swzl8hiveWxpoV
         Qqx7wA5iveZct/LrZZMzcsroWbFk5BiZH9XeVlcBu7IzS9B9PqBwqAWsPt9Av2Oc69Xr
         PFUJiVBjiUYTywWdxh8BoWAA/RJ3DuUB9Cu82BUlPh1MZrsO84GXJjjNPcuHzT9mxfFb
         9O8ToMjY8p7EssMKMOQobrAXW9P3P8EavtXtXZapfdGeoS5iOr5/+UVWh5OtccPKWOSG
         lkf0vJE6UdogIjNoLUVyspTnZgPs4UDfigET+LAH1uzwiRuIqgMHB+3su5Z4aIsyD+Ia
         Htig==
X-Forwarded-Encrypted: i=1; AJvYcCWhdp4tPRIkThw0pnoOzYsF5zccyv6Hd9MWh7uW0drmwszLL+5W/81tANsUIs91+CREYNPUdWmiisTpWUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6AbfvX2ewgxvQKjhZyBMs7PvpfSfUekf8em9tVZOFzDzxG46i
	rUY2UBkpwwyHkIfxslQyp4rAMAhdk6AJ4qS34kUXdqeQREoeEWSyU2V3BXmxW+64haajM1KmwAL
	SSlB6leH8d+SJwmdQgOP2kibVxlObxdxkMOoOvEEFq3Av61lNgaY=
X-Google-Smtp-Source: AGHT+IG67iA513l+vzvhN59OEZIDnlrhUn8zZVdV7zNIa0MSXy/0JidUuX5/ugr31L6WEem4xZ1pwi6Fky5+yvRHgik=
X-Received: by 2002:a05:690c:690a:b0:6e3:195a:7247 with SMTP id
 00721157ae682-6e5bfc9c423mr11743617b3.46.1729238783780; Fri, 18 Oct 2024
 01:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017130701.3301785-1-quic_kriskura@quicinc.com>
 <20241017130701.3301785-6-quic_kriskura@quicinc.com> <CAA8EJprcOU6qeJvHH+MVoPnQ+mGcos=pDOVBSeSUfBGw-KR6tA@mail.gmail.com>
 <aa68e5ab-86a6-430e-92d8-ed89b4eb37f7@quicinc.com>
In-Reply-To: <aa68e5ab-86a6-430e-92d8-ed89b4eb37f7@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 18 Oct 2024 11:06:14 +0300
Message-ID: <CAA8EJprkq-Cct9Uk1Jwqc5Rn8mx8THTRgwCzDx=8ZgbCpwD7qw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] phy: qcom: qmp-usbc: Add qmp configuration for QCS615
To: Tingwei Zhang <quic_tingweiz@quicinc.com>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-phy@lists.infradead.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 10:48, Tingwei Zhang <quic_tingweiz@quicinc.com> wrote:
>
> On 10/18/2024 2:27 AM, Dmitry Baryshkov wrote:
> > On Thu, 17 Oct 2024 at 16:07, Krishna Kurapati
> > <quic_kriskura@quicinc.com> wrote:
> >>
> >> Provide PHY configuration for the USB QMP PHY for QCS615 Platform.
> >>
> >> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> >> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > After checking platform details,
> >
> > Unreviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > Please perform global s/QCS615/SM6150/ and s/qcs615/sm6150/
>
> QCS615 and SM6150 are different variants of the same SoC. QCS615 is an
> IoT variant, while SM6150 is a mobile variant. We are currently adding
> QCS615 SoC support to the upstream Kernel, as it is in an active
> development stage and we anticipate many products based on this SoC. On
> the other hand, the SM6150 is an older mobile platform that is unlikely
> to be used in new designs. For a product introduction of the QCS615,
> please refer to
> https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf

Yes, I guessed so. It would have been nice if it was documented this
way from the beginning.

Please note that we usually get support for the mobile SoC first. So
in most of the cases devices use mobile compatible even for IoT
platforms, see qrb5165, qrb4210, qcm6490 and other similar platforms.
I simply asked to follow the established pattern.

>
> >
> >> ---
> >>   drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> >> index d4fa1063ea61..c56ba8468538 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> >> @@ -1123,6 +1123,9 @@ static const struct of_device_id qmp_usbc_of_match_table[] = {
> >>          }, {
> >>                  .compatible = "qcom,qcm2290-qmp-usb3-phy",
> >>                  .data = &qcm2290_usb3phy_cfg,
> >> +       }, {
> >> +               .compatible = "qcom,qcs615-qmp-usb3-phy",
> >> +               .data = &qcm2290_usb3phy_cfg,
> >>          }, {
> >>                  .compatible = "qcom,sdm660-qmp-usb3-phy",
> >>                  .data = &sdm660_usb3phy_cfg,
> >> --
> >> 2.34.1
> >>
> >
> >
>
>
> --
> Thanks,
> Tingwei



-- 
With best wishes
Dmitry

