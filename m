Return-Path: <linux-kernel+bounces-246532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E058B92C32B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482E92840A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFB018002D;
	Tue,  9 Jul 2024 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQkAW/mk"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66F1B86ED;
	Tue,  9 Jul 2024 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548825; cv=none; b=IfJ9Hca7LXor7MyJFB+6/HR29xOz3omE8z/nP1LF0mx7WfGAJeSXjFThYezGkiMIv1kotzFrWUytGaM0wkKHcZrDzxJh3BKk+fNaonf8EmfYdD+6ur/rcH36NxQW+e5DbXqSZY+T38q2RnXPH7LDtY/QiKrcrnJaKaITY/rX7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548825; c=relaxed/simple;
	bh=QL6vfS7t2ZXZBqDE+w38HqrlAOgIQ5D/Jl7C3qGdIq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fplb7huQ3a7E31OlHuNwOYKGmLM+Es8nrUDCYlgHQXkhfcg1aGcNcmGj6PdTommWTzuP9zeeK5izGEGJdnW5LQzpTL/hssTZHCsbt7Fgt4tgNmD5fFbejvPDh5qEqMMkY/F/6eafqd721Gg+KOrhQGUZrkwt/l65u/pBuyl2r20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQkAW/mk; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d9231a8dd6so1624991b6e.1;
        Tue, 09 Jul 2024 11:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720548823; x=1721153623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROMHyto+2d5m9gvIVW0NcBrDATzh3Wi6vpT55RVsNsM=;
        b=RQkAW/mksYDy12jfluNuPqI4WXB1EGPrsXEbxn9fF+KyfnN6S5Vxqx9BLa6z2EdPFi
         7eNy4KZ0cyexTvnboq9eJdrSUVWxTRqw41fQmNly9gMrcnYe21m1RDOX6XtNmQw6/aub
         IUXfPDZ4CKSaqgxjSa8r8+N34g4K4+l1XEKU68+4evLTAfyVgux2Ru+KR5v2CDOqDc1o
         jaCZ4coh86zQbck0LnModlPHRmNfw/l+GagttkMzm9aV3tHrMyryA6Il0zcORpj2pwRF
         r43m8AhcU3Pz/GFhtXRmzjhxbdQUaj7aRIHzO7C5SGrZ8vi31YVV7RP+VhysoS0dZAIe
         3bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720548823; x=1721153623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROMHyto+2d5m9gvIVW0NcBrDATzh3Wi6vpT55RVsNsM=;
        b=pEsAmiYuGeS+gKgkMj8d6NuHir1Exhe8jPyNA1QCJUcJa1xQgvVb+AaGI8VUahnek0
         ybobn9vBjfjW/rESaZtNVXcG5d19XUqRW3BDh2jHwNtvtLhdc2nI/k+r2eu9dLiwQNF5
         LCqnFT/fE/49WjA9b/Wu+xnA5thPd4w9B5B4b81Y9f9yFvVHqTzkiIZ3FBmHsdxfBswc
         KPZn+z8GpTfjBNOCxgVgkU4+meRZV1uIf+Z+vtwXpFs8mMvqYniBiI5/sGxoMTxsuBr2
         WfRoL1hsTTaDPzbYIhZxuRyZqaEWLcqgbQ60KQFz8LDZlEnrCZGOuDfsg3wk2NOURkrJ
         V9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCV233fdqSuYTJnXPoE8RQgODc9fNFF8ZKC9NPRkSTeD8Gr1yC4u0C75jwDJOwfaV2b+QRKMZhbxZYacV3iVDRyok2PX4wgn0pHAaL9syYy4lRJSKsPPz5jOlLCpVsm0Ngu44kRXGIsNVll8/2PnV1vIj6EL3ZH8TpEdsdg4D1mBeC3diocv
X-Gm-Message-State: AOJu0Yz4I5kV01rDYPYYnqQ+OyGLLVsm4hmV54m6IFsFk7d44GmaWx+F
	mZJlfgkjZuMUFKCcjZCV6mz4qeJ9JhOX1fPhnsNC0Uq7O2XPBFr4OrMHJyhqRMPAjPxyS2MH6Mk
	96RO3ITdErQvU3IJrvkoi9acWc6tJFZBk
X-Google-Smtp-Source: AGHT+IHevraVd4VAfdho+QOwUt6YVkQU8bdQp+gENg36rqNZi9wUtYbQlbdAXUq6zj6JrypsVOIIC94IzJBFd1iJw6o=
X-Received: by 2002:a05:6871:b23:b0:25e:2b26:e05e with SMTP id
 586e51a60fabf-25eae83c5demr2302832fac.23.1720548822974; Tue, 09 Jul 2024
 11:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707062702.174390-1-animeshagarwal28@gmail.com> <3d40f02f-529b-45ac-aa31-c4342f6f4f55@kernel.org>
In-Reply-To: <3d40f02f-529b-45ac-aa31-c4342f6f4f55@kernel.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Tue, 9 Jul 2024 23:43:31 +0530
Message-ID: <CAE3Oz82KvEv3uJw-ha4RjXDuwqbMAy5ifEnK-gtR9ajkEbm-bA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: cirrus,cs4270: Convert to dtschema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, patches@opensource.cirrus.com, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

xOn Mon, Jul 8, 2024 at 1:08=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 07/07/2024 08:26, Animesh Agarwal wrote:
> > +  va-supply:
> > +    description: Voltage regulator phandle for the VA supply.
>
> Your description is redundant: you did not say anything more than it is
> already said in the property name. This could be in such case just:
> ": true"
>
> Please keep this feedback for any future work (I feel I already said it
> once...).
>

I'll add proper descriptions for each of these instead, thanks for the head=
s-up.

> > +
> > +  vd-supply:
> > +    description: Voltage regulator phandle for the VD supply.
> > +
> > +  vlc-supply:
> > +    description: Voltage regulator phandle for the VLC supply.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
>
> This won't validate DTS... test the DTS. You miss dai-common.
>

Weirdly, this wasn't giving any errors upon running the dtbs_check,
however I should fix this.

> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      codec: cs4270@48 {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
> e.g. audio-codec or codec
>
> And drop unused label "codec:"
>

I can see some other cirrus bindings with this mistake, maybe because
they were written/converted several years ago. I shall fix it here.

>
> Best regards,
> Krzysztof
>

