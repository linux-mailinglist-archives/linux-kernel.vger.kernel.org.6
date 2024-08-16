Return-Path: <linux-kernel+bounces-289351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6209495452F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD581C23E11
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEED13A416;
	Fri, 16 Aug 2024 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FeGL0h+s"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C067581B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799417; cv=none; b=AUz1NvZGKSxSf5hTflUUQLGjAz0S+jL4eL58h0fCyShSgBYW3upVf9P3di6hsuoOqPgq1+zBO15qtY0/bsLnGs1gO2Unk1TlQN2IDhT5ucvuoysxtCKev+OJwvjSWTnR/qGZqjThX3aoSTaEsblLInLA3RJYShKSdgYBRMuSImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799417; c=relaxed/simple;
	bh=+447AkOnS1uBqMb8FHGHUkrDqwuwBEyFMUSUD/t7gbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uob+pckc0glU4i5sH3yoCBKA2KMesDwu6xM8h+R/Ln2s+NSc/lv+J8gdfNucYpu4RgfmNm6CT1YDiNf4neWSBeO/0oSAtKs/6JaQuAKfhvN/HVU5V5/ByZNFo/7NlKytBeqLgaNesSTRYTbFysrgAGUkpwH6vODcsC5TlAq/8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FeGL0h+s; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f04c29588so2488318e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723799412; x=1724404212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+OEH4A1p3/H1CuxcdmLsuPBbfALhVq7kSh25EJu5bk=;
        b=FeGL0h+stBW8BNGOQ1BL/H2ddn8AmxOvTFUTXm5D2Y3u78Oe7eICm+jYY+eqgK1IUt
         TgRJ4pJ/nZmCixTCmWYuhtSuZ1wQRoYlMs8xyTXW0hreFpcehwjOcBk8zi5W1cdyRe0K
         5D8Zk4vgcXqIvqBgyo3Sq/srBz48ik3h3RuOhMj0eI3CAgExMLvNtQyYdLMnZ2hV2c22
         IbenbcX0/iimnmWpe+2eLP4fk9BWLLAONrvi4581MrzagLhWRaUimZnqh0xIJDmR7M8I
         sIwZOYVeTN3V0DJVTJz3h9g6p6TloDV2I0VMDK+OU6dbfOIkzNG++536vtePoitPAnBB
         dC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723799412; x=1724404212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+OEH4A1p3/H1CuxcdmLsuPBbfALhVq7kSh25EJu5bk=;
        b=hHCh/y3X2xk0ROZ/MRCLkVPGOgSrQxQ8ZBCia5yttboAMKU01ZHSSNY5aeUmotYKWd
         NnBCaXX0roQIt+sKFqFAJsRPb8/Ohz21roJcyzJwyLL9KXbahigbYmKvF0p8ijpGutr8
         uQOJccAdv2RX0CJavYBNA/DjXNeiSCIKC2Hkz72hHcGFv1Jske/eF13yIV/uVaEJxA3s
         rKzWdvZyMvbAVorYIVv3WJGUjkjVC5Ww0lCIszFpPZtSgBcL3Tx7N0k3fY7ppp5PNjup
         dCNnPWPJY93MKWB3A0YwR0RDHDTc/ULO1VEMx3myytp9AT12XG1AmNyptJmJUaausOXm
         gXQw==
X-Forwarded-Encrypted: i=1; AJvYcCV5c0wW65NbbUYNpqDroxCPiESlJqkvEFqc6uC/SfBdOTApgfWPfwz2R3u8AwwrU9mcfMV5r3m5Rj0NsT5T4yaRahBHdSazy4t7Zzvc
X-Gm-Message-State: AOJu0YxQ80AQU3LzlV2JZQoXOiaOTPsXK/tbc8olpJhvrgIN4h+zHqVM
	G+9ldFL1k5JILNNzxw0cHByzoIFzK5m9UaFqtW/PUyUTdNRarb8RtiWwxhBQsWzitkDvkuDWmBi
	DnzVShEOfj8fVVqCKzMBTf9R7yzsSJcn5K5mPhw==
X-Google-Smtp-Source: AGHT+IFB3aIW7Bm+lnja7PhaLnwXaRYjuWrHIHMzFAXmCtoDzMvBJ6bByky6rPgRVOj2x6JwSAi/BLj6VPI7F5SZiP8=
X-Received: by 2002:a05:6512:2806:b0:530:ae0a:ab7a with SMTP id
 2adb3069b0e04-5331c6975abmr1399845e87.17.1723799411703; Fri, 16 Aug 2024
 02:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814082301.8091-1-brgl@bgdev.pl> <87a5hcyite.fsf@kernel.org>
In-Reply-To: <87a5hcyite.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 16 Aug 2024 11:10:00 +0200
Message-ID: <CAMRc=Mcr7E0dxG09_gYPxg57gYAS4j2+-3x9GCS3wOcM46O=NQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs
 of the ath11k on WCN6855
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 10:26=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrot=
e:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Describe the inputs from the PMU of the ath11k module on WCN6855.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> > v1 -> v2:
> > - update the example
> >
> >  .../net/wireless/qcom,ath11k-pci.yaml         | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
>
> This goes to ath-next, not net-next.
>
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k=
-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.=
yaml
> > index 8675d7d0215c..a71fdf05bc1e 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.ya=
ml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.ya=
ml
> > @@ -50,6 +50,9 @@ properties:
> >    vddrfa1p7-supply:
> >      description: VDD_RFA_1P7 supply regulator handle
> >
> > +  vddrfa1p8-supply:
> > +    description: VDD_RFA_1P8 supply regulator handle
> > +
> >    vddpcie0p9-supply:
> >      description: VDD_PCIE_0P9 supply regulator handle
> >
> > @@ -77,6 +80,22 @@ allOf:
> >          - vddrfa1p7-supply
> >          - vddpcie0p9-supply
> >          - vddpcie1p8-supply
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: pci17cb,1103
> > +    then:
> > +      required:
> > +        - vddrfacmn-supply
> > +        - vddaon-supply
> > +        - vddwlcx-supply
> > +        - vddwlmx-supply
> > +        - vddrfa0p8-supply
> > +        - vddrfa1p2-supply
> > +        - vddrfa1p8-supply
> > +        - vddpcie0p9-supply
> > +        - vddpcie1p8-supply
>
> Like we discussed before, shouldn't these supplies be optional as not
> all modules need them?
>

The answer is still the same: the ATH11K inside a WCN6855 does - in
fact - always need them. The fact that the X13s doesn't define them is
bad representation of HW and I'm fixing it in a subsequent DTS patch.

Bart

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

