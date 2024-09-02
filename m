Return-Path: <linux-kernel+bounces-310853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5110396820A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5E36B2229D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC3718661D;
	Mon,  2 Sep 2024 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ufI/dgqz"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD6183092
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266062; cv=none; b=VUBDvhtt69gbUN/udDv11xf+1A5y/0tF9zUWIPwNXquI8ec2fWYt1rr9iq6NbivfJV1VlpPl8yG9a3/k+P/NW06/X86pE8piheu/xo/uyG9nvmLdOGPlzyX3LuqdiEC4nWUjXoERxnxO+Wf8RQfj1mrkJ7yTj7BnoASf11jHLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266062; c=relaxed/simple;
	bh=txgND3gwVKn6mjB+PMDD7QdLkXKhRLtMsD4C90K0ZC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0WVwQToWNP/WqBS2qD/N5uCNKvxXFl7Vd5b9IT+DwlM6jUeKri/P6j/Dnx4LTvaDFyjE0+c8kRcQPR4EHNuf/SH1uFk/FHdxZP3tmWJ2q6BAD+KyrH/Oh9pd9ll1ZQl9fyVohyOK1chun/XwOHP5HVi/q9i2u5VAt1hic9vD5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ufI/dgqz; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f50f1d864fso44670811fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725266059; x=1725870859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG1MaX9Wixqm8LX4jVIjxRtWDElDhiE8Ho1xpB08+bA=;
        b=ufI/dgqzjBePBCsR1bnDU8O03jxZPZ3AlZ0Pz8zipgMY5lbHchbtJqeLNUMM/A6b+i
         1BbSnwvEqnCNk4nEiQbqxoI+2l0ZmIK+q5C5kCV8XkqaIthD3iaXdniqDbchCaznUlXu
         2XS8izELJLhjKBX2aYb3uvRmz5NwXQ810A5ZmdOhmvrKMhWofPEZRF3j6n1pP7pMHtR/
         u/cnYRwVKQ3v/TRlQnwpI82b9xMgGjFLTZeairNND6/VUgUhj1svBI8HoA8Gfwt2xX6c
         bOYfi4ufpvr3HO6cDNCW5t84BBlorpAjOWzfZviw3XbiUuYr6GU50WpibpDtALv+Y6yh
         9ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266059; x=1725870859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VG1MaX9Wixqm8LX4jVIjxRtWDElDhiE8Ho1xpB08+bA=;
        b=E9Dw1RJ+eaqu3YzwSsXSc/zqIJYyGiBiLJMt4Kg39h5rx0t7qN2etPiQ3S3+SKT1Ae
         l3sgt4Vt5JkyO5fSVtR/FMj0Lz1i4cw2k/1RmL4zL9rjP0f3HKZB2gVWY3xBD7477qQO
         qgP+9/OOA98gDg50iES1pY1be8Bu+63JBatQpy290rAdLFpdKMb+0kqzhRvT9VQFhhba
         arAu9qnV+ZimEtosBI4fcW7fHzUUXpCuRELveYtCq4XYh6fmeIqFEfu6CrrSr472hICq
         nd9mmaJAqRQHv6q2UT/6HnMniOoGBaZGGB6iT53ppJ/XJiXuOkdd0SxJYfkKkBdlF8Se
         TmGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqWT+0S1BxjM0c9T88OwcHPV6nS1mVb45GRo9+swO2s9k0TwjAhrx9fEx9pMBYYRU4prKF6dZkzOhIOnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxA5zvexwvYh2F4Scl7BBVZ3w6rHVVgbvIn1riV97zLCK75hfS
	ddZAqlcZJ4ZLKq+E5DuJ8R3Y+cwu9JrNNY9vFfvtrkRm1Lh+ek8tJI2gC4OBYYkieKwUeP/i2x+
	YjFOtY4nLMfMPSe4WlLjY1tHIKAAbkSnomKcy1Q==
X-Google-Smtp-Source: AGHT+IFZPkz+zpegGiynrc/uuNxJ0ov4qqo022LeyJfV540+XBhmrJitjFwxWZA+2HM3HGR7rldq/MxJvLLQLrQlwh0=
X-Received: by 2002:a2e:e0a:0:b0:2f5:136d:89ef with SMTP id
 38308e7fff4ca-2f629063f04mr32120871fa.22.1725266058091; Mon, 02 Sep 2024
 01:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814082301.8091-1-brgl@bgdev.pl> <87a5hcyite.fsf@kernel.org> <CAMRc=Mcr7E0dxG09_gYPxg57gYAS4j2+-3x9GCS3wOcM46O=NQ@mail.gmail.com>
In-Reply-To: <CAMRc=Mcr7E0dxG09_gYPxg57gYAS4j2+-3x9GCS3wOcM46O=NQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 10:34:07 +0200
Message-ID: <CAMRc=MeuB1yhENHXqLxRf8xFNm7dYvjLisa7zsd6_2ov_OPw3g@mail.gmail.com>
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

On Fri, Aug 16, 2024 at 11:10=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> On Fri, Aug 16, 2024 at 10:26=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wr=
ote:
> >
> > Bartosz Golaszewski <brgl@bgdev.pl> writes:
> >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Describe the inputs from the PMU of the ath11k module on WCN6855.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > > v1 -> v2:
> > > - update the example
> > >
> > >  .../net/wireless/qcom,ath11k-pci.yaml         | 29 +++++++++++++++++=
++
> > >  1 file changed, 29 insertions(+)
> >
> > This goes to ath-next, not net-next.
> >
> > > diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath1=
1k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pc=
i.yaml
> > > index 8675d7d0215c..a71fdf05bc1e 100644
> > > --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.=
yaml
> > > +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.=
yaml
> > > @@ -50,6 +50,9 @@ properties:
> > >    vddrfa1p7-supply:
> > >      description: VDD_RFA_1P7 supply regulator handle
> > >
> > > +  vddrfa1p8-supply:
> > > +    description: VDD_RFA_1P8 supply regulator handle
> > > +
> > >    vddpcie0p9-supply:
> > >      description: VDD_PCIE_0P9 supply regulator handle
> > >
> > > @@ -77,6 +80,22 @@ allOf:
> > >          - vddrfa1p7-supply
> > >          - vddpcie0p9-supply
> > >          - vddpcie1p8-supply
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: pci17cb,1103
> > > +    then:
> > > +      required:
> > > +        - vddrfacmn-supply
> > > +        - vddaon-supply
> > > +        - vddwlcx-supply
> > > +        - vddwlmx-supply
> > > +        - vddrfa0p8-supply
> > > +        - vddrfa1p2-supply
> > > +        - vddrfa1p8-supply
> > > +        - vddpcie0p9-supply
> > > +        - vddpcie1p8-supply
> >
> > Like we discussed before, shouldn't these supplies be optional as not
> > all modules need them?
> >
>
> The answer is still the same: the ATH11K inside a WCN6855 does - in
> fact - always need them. The fact that the X13s doesn't define them is
> bad representation of HW and I'm fixing it in a subsequent DTS patch.
>

Gentle ping.

Bart

