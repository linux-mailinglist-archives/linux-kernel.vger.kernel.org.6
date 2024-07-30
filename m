Return-Path: <linux-kernel+bounces-267279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA8D940F84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE241C22A55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA67319ADAC;
	Tue, 30 Jul 2024 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FC/eXwEH"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3802418E746
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335444; cv=none; b=qLdkf5nDm607UqM6LDPvOWwfFICCmWo9tH29fEkudoxCE5yMW4uZF0vuja4IkjGPhwrjKtRKOj/lsOWwYAT27kIQxlSewMQVdv11VXN4sy5Ezjeg5+SLxXGyvr2q92TXK14uWqmIdre9ug6T3GNxyfm0nKOX68HtXyBVTprzlYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335444; c=relaxed/simple;
	bh=+SZusJMwP5eTibZ0Xgy1WVMZxJPy4VghvcWPJCa+v2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwhBhG596Tc4jN8qBq88EQXYgZtYjUPpsGdusczoWPzMt4Ou0zZH1Ex1ofFOkIXFNKUZ/quPpzyRXdqCi+k/Cy6lKVDN0xBWMhqO7dQiXsHdSfgRhLO/a+VeGERUR20JBPAnsiEwHTJEXhq4I4bOmk5sfittzpr35OXo4e1jxNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FC/eXwEH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aac70e30dso562071366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722335440; x=1722940240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gfgTeO7eFehEfuHZo0dSc8+LCrIJf/o/Tpdg8fxovkI=;
        b=FC/eXwEHe+1YqH+wwKuOMai2VT7ZmZqh6eRRF33Y/d5LQefLFjk4sqMsMHrflheGxJ
         3+aTTh8rpMI/wOHcjX1HmhayCbUIXQT1kyjpRqyZBZaLYWTJn+JL9dHVWXyofisIohiu
         5eL5u2LC7DI/zcyv+eGpXIDW6rjORiciDXORmVyR7CJ2M5GTR8uGing/Js+yaQpHP66r
         YVxmC8yXsTPhMha2vvaUV6ADT+nQ+G+WFvp8B1y1TJBNxpvSx+tgIljhFK5im0dp5/F2
         3YqqkH+VJnfNF8Aut7oMCPDdFU9GsEugUuSjjRLO+G2eKNR0bQgE5VvNIdIRPndWwlTO
         UIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335440; x=1722940240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfgTeO7eFehEfuHZo0dSc8+LCrIJf/o/Tpdg8fxovkI=;
        b=Qe1bgjHlLDTYa39DlA8L8NBMRCuQK0UyzXco6ppLe2g+qXldPSrmEpzYydQl6tPfS3
         uhF/teu40XcNdpnLDEgjyOxJnkOLRTsJLhHPdvYa34Y+NtUHcg9DKp3DJaX/pBmyH18E
         N23Qe8n5pWQUQ+siTuvVmNME+AQtouAFg1lscl0eY59sprBVcnANk7MtFYGc4JsBQ7BS
         gy1xxkd7Xd9Sy0Zh5PgfRZwHSmaHz6H8jPNgWeaTLHsEjLVqPedLoDWSVC8hcjGfSEwo
         J9PmAoQufjH1pnaxkfwST5nInwgaQ3U0QccEetAF9WTCZTWz5MkiE6wk3Df1hkM/x6QO
         PScQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFqU34AEPm44W8+c2Vjot6wGjO02uC0KB1xK1J1KBebM4bh7AOQIVibbDHbZWf9Saad9xfoXT3q9px9ujF856saypJDZFArtxNZVBE
X-Gm-Message-State: AOJu0YzUjeJppAVU0iS/KsBZ6yysk4x7EJjiHzj60sHkaX1j6YYuICEJ
	wGzjoIJQltDtBCKBqUYauogYoounvzD6XLsSwiYTlt45vbALkTYESZ5czLyf6sk=
X-Google-Smtp-Source: AGHT+IGxx92z7IX9vhw/RN+EO3wwfQ/M++6atfLPhpUAf+bjo2ykfbCE8+G6Hz0TR83vimf4DR4ZTQ==
X-Received: by 2002:a17:906:dc8b:b0:a7a:aa35:4091 with SMTP id a640c23a62f3a-a7d3ff5b256mr842252966b.25.1722335440243;
        Tue, 30 Jul 2024 03:30:40 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff1f:b280:8303:a4e9:79c5:e939])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4ddefsm625461366b.59.2024.07.30.03.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:30:39 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:30:38 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Stephan Gerhold <stephan@gerhold.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adam Skladowski <a39.skl@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,apq8016-sbc-sndcard: move to
 separate binding
Message-ID: <ZqjAzgoKo-5vaCtK@linaro.org>
References: <20240723083300.35605-1-krzysztof.kozlowski@linaro.org>
 <ZqVXUI37fNB5D0DM@gerhold.net>
 <3d9f76c1-2e14-43dc-b438-5fac94ffc73e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d9f76c1-2e14-43dc-b438-5fac94ffc73e@kernel.org>

On Sun, Jul 28, 2024 at 12:30:12PM +0200, Krzysztof Kozlowski wrote:
> On 27/07/2024 22:23, Stephan Gerhold wrote:
> > On Tue, Jul 23, 2024 at 10:33:00AM +0200, Krzysztof Kozlowski wrote:
> >> The APQ8016 SBC and MSM8916 QDSP6 sound cards are a bit different from
> >> others: they have additional IO muxing address space and pin control.
> >> Move them to separate schema, so the original qcom,sm8250.yaml will be
> >> easier to manage.  New schema is going to grow for other platforms
> >> having more of IO muxing address spaces.
> >>
> >> Cc: Adam Skladowski <a39.skl@gmail.com>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >> .../sound/qcom,apq8016-sbc-sndcard.yaml       | 205 ++++++++++++++++++
> >> .../bindings/sound/qcom,sm8250.yaml           | 137 ------------
> >> 2 files changed, 205 insertions(+), 137 deletions(-)
> >> create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.yaml b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc-sndcard.yaml
> >> new file mode 100644
> >> index 000000000000..6ad451549036
> >> [...]
> >> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> >> index c9076dcd44c1..1d3acdc0c733 100644
> >> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> >> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> >> @@ -27,9 +27,7 @@ properties:
> >>               - qcom,sm8650-sndcard
> >>           - const: qcom,sm8450-sndcard
> >>       - enum:
> >> -          - qcom,apq8016-sbc-sndcard
> >>           - qcom,apq8096-sndcard
> >> -          - qcom,msm8916-qdsp6-sndcard
> >>           - qcom,qcm6490-idp-sndcard
> >>           - qcom,qcs6490-rb3gen2-sndcard
> >>           - qcom,qrb5165-rb5-sndcard
> >> @@ -58,18 +56,6 @@ properties:
> >>     $ref: /schemas/types.yaml#/definitions/string
> >>     description: User visible long sound card name
> >>
> >> -  pin-switches:
> >> -    description: List of widget names for which pin switches should be created.
> >> -    $ref: /schemas/types.yaml#/definitions/string-array
> >> -
> >> -  widgets:
> >> -    description: User specified audio sound widgets.
> >> -    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> >> -
> > 
> > These two properties are also valid and supported on all newer
> > platforms, please keep them here! There are certain use cases where
> > these are needed independent of the platform, e.g. to control an analog
> > switch or mux connected to speaker or headphone outputs.
> > 
> > I agree that it is cleaner to move the IO muxing to a new schema though.
> > Perhaps we could define something like a shared qcom,sndcard-common.yaml
> > schema to avoid duplication for these generic properties? In the Linux
> > driver, these are handled for all platforms in sound/soc/qcom/common.c.
> 
> This was added to the common driver code but it does not mean it is
> reasonable binding. I don't understand why for example we even accept
> here aux-devs, instead of putting them into one of DAI links.
> 

The auxiliary devices (typically analog audio components) are not
necessarily related to one particular digital audio interface link. It
is typically the case (e.g. an analog speaker amplifier connected in
parallel to the headphone output of one of the codecs), but I don't
think we can assume that as a general rule. There are often multiple DAI
links that go to one codec and then it might be tricky to decide which
of the DAI links the aux-dev belongs to.

> The pin-switches and widgets could be used, but are they? The only valid
> argument to keep them is that you added them to common driver code.

These go hand in hand with the aux-devs property. If you have multiple
analog audio components connected to a codec output (e.g. an analog
speaker amplifier connected to the codec headphone output) then the
pin-switches/widgets describe that the output paths (speaker and
headphones) should be separately controllable.

The alternative for pin-switches and widgets in the DT is to hardcode
them in the ASoC board/machine driver with a separate board-specific
compatible. Personally, I would prefer to keep the machine driver
specific to the SoC instead of having definitions for each and every
board.

Thanks,
Stephan

