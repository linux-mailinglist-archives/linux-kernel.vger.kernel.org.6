Return-Path: <linux-kernel+bounces-204382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBB18FE802
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA44C286D83
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1957919644F;
	Thu,  6 Jun 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GXwFajWW"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489FFC02
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681073; cv=none; b=Kjs1ad0zUbTWiSnuT3OOK2gPPG7yJ4UDTIDD/aKtDn7HTssu0nqzZx4cNfpmhhhJ2xTw7zAFncM0ODa5TxbCwQYjTG1ZXVPgZlLy/1BKlzld+luMXDs3wsIG/jNQjo1r2HAUbRfAIgcbehkRzNvjrfihZouhfZ8Gb7tlA+ABDQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681073; c=relaxed/simple;
	bh=zjZtV8HA3Vhf3+SRpbRkKIxbVSf+NUfL0NIXTkLvKoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bw33oMfzGTsJRlOG1yqry2wSg5zEbZfCbBBsULzfMfSAI3st9X14bNk54CR83dTttXd0JqOLq4svv7s6r7akPbspRlMxlcWMH9067g07Lw9AqAPuLtfM9SsIDsCg3L8fKb98W+RmYpAU4Us4JPjWkUTZB6Ee+nai+x+XG/AymrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GXwFajWW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b8e0e98adso1480403e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717681070; x=1718285870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BoBiv/oTzAdR1lIG+yWj+SGvl2JhVkHcJoQ9lqvUrc=;
        b=GXwFajWWpKkS3kcer4HmUXrpVPlzwLgFtMKG8/A4+csjCpvixF0Ty1Ad/oj77qN2Me
         JO87MMU494Bx0vFZ24lJf4KCnqgfrhl6A9C4kmxo16oa+jyp46+vjdzdRVoK/K/bhR9q
         fAma7enWuOIpiUF8pFO0uL6y56UCKzLkVLaKr9dv0sWg03QanZjRtgrQA66RnFrg6rLa
         zX8nytyo/ElyipZNPeu628jGgmYDY+rCTreuivwY9HE0TrAYGDQ0Gmqrlg2PMA4OkT+b
         t8/KfqsLrcj0BOBo8CzT17GOjZALZWK0+CoX5Z6OABaK+90n4ItgJV1v4L+7mY+UM8wj
         Wang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717681070; x=1718285870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BoBiv/oTzAdR1lIG+yWj+SGvl2JhVkHcJoQ9lqvUrc=;
        b=uqD+hbeQfnH+0qk6PMcK47BYaxFls1jju9TzkPhu+vlSjLiR8Yty+yFhKmbuoBl4OZ
         0YnCKhixgWWIcUHqZrhZI8NFBJYFg+ouDDBHOVY0alftbkJZuIaABLHVwnhHNxd8EpYi
         LuWJDeIscddqIz+Z+ti0Z/x7sO4FJs7TD3scKuwzpDIhxEacB7udaGuvQtm2o41YPxi/
         Gb58BU5bkxmEEtd8ozVZuOJVhE/9ic+n+EyLxZVoT10hxlRqi5Jh7E/ZMQKYlKC/oCgF
         5bJxof8AqWteTUl88KqDxRObtJrHTsTb/y4v4awdB9+ERJ8/AugFVc8rbA/plEHo2YJ7
         U1VA==
X-Forwarded-Encrypted: i=1; AJvYcCVC5rr9l9mRXtgARxO3qp8mAHXdIhQiu3PAiysfPLljeVkLqOCjZHsh+giYx3cf38QbPZUXGLOTqFNUlBgDs93sOrMGV7WKfPa52YiU
X-Gm-Message-State: AOJu0YyBJDPuTzNOZNZMotvw+TvUiOrvGMbudSn29LuYaBVSVPQGDnfB
	EvKWkIfIlyutVoRRqGoV/DOtFoMiQrBGHpQgX65wkNMDlI9NShBI2PwWJSuOCKvdoF8/IY8Xe3K
	SFKZo3ztFo1kAjX2dVsFtT5sjv6iuhvpoqZhFFA==
X-Google-Smtp-Source: AGHT+IGVi6SdXyjqLuNgspGsS7QS0koHqoI5qU5RsxFMIyqlWHAi0Sgl3JgDM1tnD4UfWiI8Hjt8tIufJO2+Xkfj3E4=
X-Received: by 2002:a2e:8802:0:b0:2e5:67bc:739 with SMTP id
 38308e7fff4ca-2eac79f22cbmr31439811fa.2.1717681070058; Thu, 06 Jun 2024
 06:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605122106.23818-1-brgl@bgdev.pl> <20240605122106.23818-3-brgl@bgdev.pl>
 <87cyouqjou.fsf@kernel.org>
In-Reply-To: <87cyouqjou.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 6 Jun 2024 15:37:39 +0200
Message-ID: <CAMRc=Mdpu=1GFR-KraxCVn4oZr5TwM3ptbY25OHNkGepcsWdcQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] dt-bindings: net: wireless: describe the ath12k
 PCI module
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ath12k@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:34=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add device-tree bindings for the ATH12K module found in the WCN7850
> > package.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  .../bindings/net/wireless/qcom,ath12k.yaml    | 99 +++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom=
,ath12k.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k=
.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> > new file mode 100644
> > index 000000000000..1b5884015b15
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> > @@ -0,0 +1,99 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2024 Linaro Limited
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Technologies ath12k wireless devices (PCIe)
> > +
> > +maintainers:
> > +  - Jeff Johnson <quic_jjohnson@quicinc.com>
> > +  - Kalle Valo <kvalo@kernel.org>
> > +
> > +description:
> > +  Qualcomm Technologies IEEE 802.11be PCIe devices.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - pci17cb,1107  # WCN7850
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vddaon-supply:
> > +    description: VDD_AON supply regulator handle
> > +
> > +  vddwlcx-supply:
> > +    description: VDD_WLCX supply regulator handle
> > +
> > +  vddwlmx-supply:
> > +    description: VDD_WLMX supply regulator handle
> > +
> > +  vddrfacmn-supply:
> > +    description: VDD_RFA_CMN supply regulator handle
> > +
> > +  vddrfa0p8-supply:
> > +    description: VDD_RFA_0P8 supply regulator handle
> > +
> > +  vddrfa1p2-supply:
> > +    description: VDD_RFA_1P2 supply regulator handle
> > +
> > +  vddrfa1p8-supply:
> > +    description: VDD_RFA_1P8 supply regulator handle
> > +
> > +  vddpcie0p9-supply:
> > +    description: VDD_PCIE_0P9 supply regulator handle
> > +
> > +  vddpcie1p8-supply:
> > +    description: VDD_PCIE_1P8 supply regulator handle
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vddaon-supply
> > +  - vddwlcx-supply
> > +  - vddwlmx-supply
> > +  - vddrfacmn-supply
> > +  - vddrfa0p8-supply
> > +  - vddrfa1p2-supply
> > +  - vddrfa1p8-supply
> > +  - vddpcie0p9-supply
> > +  - vddpcie1p8-supply
>
> Same comment here. To my understanding there are ath12k PCI devices
> which do not need the supplies. But I guess we change this to optional
> later?
>

Sure we can. But "pci17cb,1107" refers to a QCom variant and it always
comes powered by a PMU so these supplies really are required.

Bart

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

