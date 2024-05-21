Return-Path: <linux-kernel+bounces-184469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7AF8CA720
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133D81F217C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2013023777;
	Tue, 21 May 2024 03:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a01OiOFJ"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07BD1F959;
	Tue, 21 May 2024 03:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716263106; cv=none; b=AFKlRTGVGh86bQ+a0wgseWMP5c1yf6F33UNb5H6HdZidUxo6W8XUJEO5jkUSoO8yNpDKAJcIVokkxOpNsB2ADgUQQ7zEP/Ne/WEd/y2ANgWDM6EUym5DWuXRo+tRqOAv6HnQQ4u+/rC6E/+8HGu/sV0wKE1uOqbKLci8KP13P4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716263106; c=relaxed/simple;
	bh=nT/UcWakmvnOxHqHJxkCVjPajiuq5sgmjr6Gdx1E7do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzIDVfJXSwJBfKyqhCF5T1mWf/aHUjsro8y8YwXkq7i3sTzX0j1BgYk+ILR2+jZMtisNt/qWrFLwX2EtzXbasNR94TVe++rxnYVkXnoZwVNv+6dDdaSOdjPsIa/bwNkvwv1vJLzo69q2yY29YJZcPRvjNw84f4B/Vk1oTzS9DZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a01OiOFJ; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36c7bd2586eso15692495ab.0;
        Mon, 20 May 2024 20:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716263104; x=1716867904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92eG1R1+dxxcxoqnquEsD3l0yRmXMuTseq3SVxvuVCU=;
        b=a01OiOFJ9gwaAmH8yggz5HpfbI0RwovXKZf5gn+31dT0RBEYFCJ1eFfWtAxaOGRaah
         2kOfWXECFxBPBToAPhLG2snWA78k57Snc3TI7WAiZkV66a4Zb8t/J5tGt3DGYtgto6fK
         PqyvaO4AzCTNPRoyvQZeRn+dl0aIlzd+EoEYmZ5+zDOie1GUZ6qbInB1Q8j/+j1gPQt8
         sFXAl/kzOATR1X9wyf4dg6W4zExMWE0T8BpMcoz2pR1Chtuy/5Q717iX/OFHY2qohMrB
         YQfTPEU9nfosb560QNybgvyfDcBVRRX4bcr6oOTF69Uumi26U/rcN+6ReHYqO9PJkxhn
         jGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716263104; x=1716867904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92eG1R1+dxxcxoqnquEsD3l0yRmXMuTseq3SVxvuVCU=;
        b=gcM2QZS+YlCMbSnzlREwIkQAiWZoXp4zwnp0qgk8I2YQ7V5h3FgvR/+e5AXDamlAfT
         +S3frHDlaOXFrP9biF3yEQPqnGlSem9GW1C0R2rAhXcoREllCeHrXBQ8lBrGylUvd/zu
         jtZYxZ6Omwo/x9/Po9e3t3p3yzI8Q0zIw9A/4UQbCfz8v73JutbTPWxXbZdaYJXPAZ/n
         j5WVTI8iYlFdwrCRby0VrI1PIrieIMNtw9KLeqPJiO0d20BjmCJeHKjnXBbi72OSTZjb
         Xl0R3MeYm0Es+M2Su1dfRcTywaYb+9+Uf3sSa3u9ynR8Y0uYT+e8akenX1H2LXb4chU0
         +IFg==
X-Forwarded-Encrypted: i=1; AJvYcCVfGUX31sQ6IFLXgAwIs9LuEGzEjWwm5iYnY3YI1LYt6eXqsEwt+cvNPCYXTVbSNhVFBgEDZcyHoYvoH9HjMX8uRSLjWE5jGmImSOuLuLS7eKMG/yPYYTLAiEsDEJ5uBx7GCiI8YuDy/8ti7U3rsLEmCAX05t0mXzBF8piH/npc5eJv24tL
X-Gm-Message-State: AOJu0YwJtg8J5kRuOhrDkKUV/79fBoD8RZKs3l7OFQtB6GMAbMIsmV5F
	V2KZ9XocxqlqN+4bIJIN0ARJquuQG/8wrZXNpAy9YqkK1YYLlV6YS6sIvwLPiTI5jI6cGqyPCIb
	FNpkfw/XU/9lS4i6KbbguDfWzp1nRyCWc
X-Google-Smtp-Source: AGHT+IGUqihHFeb7eWpabPg1q5Sh/AS8XKoMLly/pnZf7TI+p69vXi5+CsRbyhaNcvW9G0mXy1rLErzVIJjrmezSMvA=
X-Received: by 2002:a05:6e02:1caf:b0:36a:1f1a:f797 with SMTP id
 e9e14a558f8ab-36cc1501d23mr336656205ab.32.1716263103909; Mon, 20 May 2024
 20:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715656329-8061-1-git-send-email-shengjiu.wang@nxp.com>
 <1715656329-8061-2-git-send-email-shengjiu.wang@nxp.com> <20240520161602.GA733483-robh@kernel.org>
In-Reply-To: <20240520161602.GA733483-robh@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 21 May 2024 11:44:53 +0800
Message-ID: <CAA+D8AOvuCKN0cU_TAHsz6h41qVXHbV0LfkFq9dSRujt2Lc2bw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl,xcvr: Add compatible string
 for i.MX95
To: Rob Herring <robh@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 12:16=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Tue, May 14, 2024 at 11:12:08AM +0800, Shengjiu Wang wrote:
> > Add compatible string "fsl,imx95-xcvr" for i.MX95 platform.
> >
> > The difference between each platform is in below table.
> >
> > +---------+--------+----------+--------+
> > |  SOC          |  PHY   | eARC/ARC | SPDIF  |
> > +---------+--------+----------+--------+
> > | i.MX8MP |  V1    |  Yes     |  Yes   |
> > +---------+--------+----------+--------+
> > | i.MX93  |  N/A   |  N/A     |  Yes   |
> > +---------+--------+----------+--------+
> > | i.MX95  |  V2    |  N/A     |  Yes   |
> > +---------+--------+----------+--------+
> >
> > On i.MX95, there are two PLL clock sources, they are the parent
> > clocks of the XCVR root clock. one is for 8kHz series rates, named
> > as 'pll8k', another one is for 11kHz series rates, named as 'pll11k'.
> > They are optional clocks, if there are such clocks, then the driver
> > can switch between them to support more accurate sample rates.
> >
> > As 'pll8k' and 'pll11k' are optional, then add 'minItems: 4'
> > for clocks and clock-names properties.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/fsl,xcvr.yaml   | 55 +++++++++++++++----
> >  1 file changed, 45 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Do=
cumentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > index 0eb0c1ba8710..70bcde33e986 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > +++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> > @@ -22,6 +22,7 @@ properties:
> >      enum:
> >        - fsl,imx8mp-xcvr
> >        - fsl,imx93-xcvr
> > +      - fsl,imx95-xcvr
> >
> >    reg:
> >      items:
> > @@ -44,18 +45,12 @@ properties:
> >      minItems: 1
> >
> >    clocks:
> > -    items:
> > -      - description: Peripheral clock
> > -      - description: PHY clock
> > -      - description: SPBA clock
> > -      - description: PLL clock
>
> Leave these here and add pll8k and pll11k.
>
> > +    minItems: 4
>
> Keep this.
>
> > +    maxItems: 6
> >
> >    clock-names:
> > -    items:
> > -      - const: ipg
> > -      - const: phy
> > -      - const: spba
> > -      - const: pll_ipg
> > +    minItems: 4
> > +    maxItems: 6
>
> Same here.
>
> >
> >    dmas:
> >      items:
> > @@ -97,6 +92,46 @@ allOf:
> >        properties:
> >          interrupts:
> >            maxItems: 1
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx95-xcvr
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: Peripheral clock
> > +            - description: PHY clock
> > +            - description: SPBA clock
> > +            - description: PLL clock
> > +            - description: PLL clock source for 8kHz series
> > +            - description: PLL clock source for 11kHz series
> > +          minItems: 4
> > +        clock-names:
> > +          items:
> > +            - const: ipg
> > +            - const: phy
> > +            - const: spba
> > +            - const: pll_ipg
> > +            - const: pll8k
> > +            - const: pll11k
> > +          minItems: 4
>
> Drop all this.
>
> > +    else:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: Peripheral clock
> > +            - description: PHY clock
> > +            - description: SPBA clock
> > +            - description: PLL clock
> > +        clock-names:
> > +          items:
> > +            - const: ipg
> > +            - const: phy
> > +            - const: spba
> > +            - const: pll_ipg
>
> And for this case, you just need 'maxItems: 4'.
>

Thanks for the comments.

I will address them in the next version.

Best regards
Shengjiu Wang

