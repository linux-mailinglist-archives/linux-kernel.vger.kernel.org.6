Return-Path: <linux-kernel+bounces-346976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E83F98CB8C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50486285D90
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26A71642B;
	Wed,  2 Oct 2024 03:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DpcnGEDL"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB211078F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 03:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727840181; cv=none; b=WEPtcuD55lDuoCGN7xvBg28dTt1kykMoYy7w7+4Aj7WRfYNEyhiAJh4t7xZP8W+mlLjZ/yWQEj2stuKug9irWNBWlEauvj6hjxIKnhC5EYrj9KfrNyuqhZMw/vAQY1ZivmLu6MmbIeUeOjAVk/bOm6cXTFgAqSL0QuBJhIsR2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727840181; c=relaxed/simple;
	bh=av2Zb5PMB6fQe4PCUNTCIeI91KPfoH514yjPHhk8h4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXqKAx0Ix3pcv7cEIw+SbgagiPOaJtWF7qOv7C6Xb83G2MGM7vqMR2+nCtA+lL5PbKR5w7Lte9gRfpsy6PsTYmODT9lYONn4nrcptK2xXSiWSfImAAIKSa6xMAtgkLDUy1CkSYOcH/oKrjBOcwlxPeRaWWxc7PKfLaBP/c/VCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DpcnGEDL; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-507904d0800so1702095e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 20:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727840178; x=1728444978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwiLVnc0Ymap70LQ2v/RfJC1Ad9ePUxHXG7oryVkvlE=;
        b=DpcnGEDLVRiEcOp+bbNRxPD+3dzU/RtS7Cmj/CYeGgV9gK3wZfSaG/kTnSa0DLaEfG
         b+0lyzhi1K1sxe29p/dSoCbjtPjFKFXHDc8e0xf7EqVvzYsi4Q/ijzuSIBwA+Fu67uPz
         mJxVT2xoJN2kkO+h6g9P4uDbMnP0iYuUhx/pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727840178; x=1728444978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwiLVnc0Ymap70LQ2v/RfJC1Ad9ePUxHXG7oryVkvlE=;
        b=j1P1USOBkVSU23wV1OgjvTHka4SZnfN8q/cZosyPzZfh+2tKps3bV1ftnRYNZmrydM
         UZvmAIABKGcvBBFn4BOW+zEEkUSmqjHBtI6RG+Peghb4ZHThtWk4u581iuL2Ez1ZZVWp
         Dqq9LAovK4LCl4JI6ImNtiCxC+WELe4DKBUo2nZUW/bJuKALBoW9ApM+yKvXRaW1GgyO
         8gdLdOypZddG3FkeHbu72mMQ0f/sGU5UF7Y/8Ggsp1WEGs8inVD+C+BN6eOOVEiyAsYo
         DEIZYq1czmWkzx2jraxGgHQBezLco60O6rq6QNrzrs34/WCyQWOZzFFVat9XgKCF2/84
         2DBw==
X-Forwarded-Encrypted: i=1; AJvYcCUjjzKV/f74TAsuWArCkdXLFutmk7Zh7WwLrXlLEjRwHSCcenKSE1Dqaee9Z8BZClo6LQ8KBGxDQT6KSTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVot2TweFYSkjMqEnvJUYT7UKlmHEsSgpSeGB2XC9sj5GyTuiX
	AKB8VqGALbgiI5x4uBdKuh2ufM4UpOtBjH1RoAGHeroyBXFKWzNI8XaZU5T5dhAgA+dtmFKjtOv
	9UA==
X-Google-Smtp-Source: AGHT+IFOFWtbjXBc2vrf9K3fsq0py8pdjQkIfHb6j35V5fNs0BIOmM/34CiXKoblSYCokdK8QZ0fow==
X-Received: by 2002:a05:6102:ccb:b0:4a3:b361:1e2a with SMTP id ada2fe7eead31-4a3e687fed8mr2106342137.13.1727840178072;
        Tue, 01 Oct 2024 20:36:18 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84eb22d3e91sm1494501241.25.2024.10.01.20.36.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 20:36:17 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84e962c9a99so1849915241.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 20:36:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlxTtyI8vn6jbwxLKrWxIhk3yew5MKj7xDRpUu/4XTxOV1oTsZjt/h5Od7oxaUK/sZd9wQMlU/7E0Iig4=@vger.kernel.org
X-Received: by 2002:a05:6102:32cc:b0:49b:e3fd:b6d0 with SMTP id
 ada2fe7eead31-4a3e68264a4mr2070117137.5.1727840175839; Tue, 01 Oct 2024
 20:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925110044.3678055-3-fshao@chromium.org> <20241001195325.GA222000@bhelgaas>
In-Reply-To: <20241001195325.GA222000@bhelgaas>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 2 Oct 2024 11:35:38 +0800
X-Gmail-Original-Message-ID: <CAC=S1niCc5usY4SJ7wqtKAfcUqyTBf3fhRmkk4Sdnr3x2zsuVA@mail.gmail.com>
Message-ID: <CAC=S1niCc5usY4SJ7wqtKAfcUqyTBf3fhRmkk4Sdnr3x2zsuVA@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: PCI: mediatek-gen3: Allow exact number
 of clocks only
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, 
	Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 3:53=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, Sep 25, 2024 at 06:57:46PM +0800, Fei Shao wrote:
> > In MediaTek PCIe gen3 bindings, "clocks" accepts a range of 1-6 clocks
> > across all SoCs. But in practice, each SoC requires a particular number
> > of clocks as defined in "clock-names", and the length of "clocks" and
> > "clock-names" can be inconsistent with current bindings.
> >
> > For example:
> > - MT8188, MT8192 and MT8195 all require 6 clocks, while the bindings
> >   accept 4-6 clocks.
> > - MT7986 requires 4 clocks, while the bindings accept 4-6 clocks.
> >
> > Update minItems and maxItems properties for individual SoCs as needed t=
o
> > only accept the correct number of clocks.
> >
> > Fixes: c6abd0eadec6 ("dt-bindings: PCI: mediatek-gen3: Add support for =
Airoha EN7581")
> > Signed-off-by: Fei Shao <fshao@chromium.org>
>
> It looks like most changes to this file have been merged via the PCI
> tree.  I don't see dependencies on this in the rest of the series, so
> I'm happy to take this via PCI if it makes sense.  Or if you prefer
> that this be merged with the rest of the series, that's fine and you
> can add my:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Let me know if I should pick this one up.
>

Yes please, thank you!

Regards,
Fei



> > ---
> >
> >  .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml          | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.y=
aml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > index 898c1be2d6a4..f05aab2b1add 100644
> > --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > @@ -149,7 +149,7 @@ allOf:
> >      then:
> >        properties:
> >          clocks:
> > -          minItems: 4
> > +          minItems: 6
> >
> >          clock-names:
> >            items:
> > @@ -178,7 +178,7 @@ allOf:
> >      then:
> >        properties:
> >          clocks:
> > -          minItems: 4
> > +          minItems: 6
> >
> >          clock-names:
> >            items:
> > @@ -207,6 +207,7 @@ allOf:
> >        properties:
> >          clocks:
> >            minItems: 4
> > +          maxItems: 4
> >
> >          clock-names:
> >            items:
> > --
> > 2.46.0.792.g87dc391469-goog
> >

