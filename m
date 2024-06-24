Return-Path: <linux-kernel+bounces-227247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D4914DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A0C1F243DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C14213DDA2;
	Mon, 24 Jun 2024 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="1gJjEIM0"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2840A13D88F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234373; cv=none; b=NMlOmNs4JDCOarmnUDlmIfABjx027NrRzCl2V1kFaezcPrBNNfs7mK7hKGGxcOfan3PcQpf0+bE03YYonGUnRUI32me03+oabtcDymyVGkuOb3A1r4RbSmK2iYmNFge+6hSTxoYPRLTOgsm4QKGnJhTbBkjwZPxkVT192uD2WAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234373; c=relaxed/simple;
	bh=ex+7rt4pI1Xvmjbse0OMdVHPQn7ofhcny9ssr3PsAmI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QN42n4cRohs4Ox3kxjF+Mm0ONO33J6Tj5/DIy/R69TidNB1RCTo4QrUz+F20p30m76swkboaIUMNcrnglxSgO2PlB8j9wLSM4LZb8iRNbHRurRm+MDw4y7v0qJiMiTV4B8zxWbWBVN57cJBqMEGSKzI790hQgqV0nJgRdevnBy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=1gJjEIM0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso473496266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1719234369; x=1719839169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NvHQSEsF8s98aDBqYQPy5qb2e+DikeQTdgIkHVK8CO4=;
        b=1gJjEIM0RTWKvkfAyan+/yzlnQSQTTvI/747gjv6h6XkHmn98rj7gj6kOKjeJvdSLk
         RcYKZI0cRBoJaLVCFKSO5FvonRkJwP/61DUBf3lScTCf1ZO+wdpBDKAPk8rHFkLWK/iE
         /3EbJJG8NVrrMg2T6bpvz9l7voKl6om5UBOD8sY36Pn9mp43dGKVVrarKpoevZa3TgrR
         HResjoFvpzHyGevCkuirJlsFNsPhi+6u/MPc7Wu1+IIDKOdAHFaNX/sEDMIq7t3YpYmB
         Z2wUbitAw/pX6aUOlzs1lsVtTp/4lOPyGS+wdtpWyVT4HWLIC15rRf2Bx8YKgupt9Rgi
         +jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234369; x=1719839169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvHQSEsF8s98aDBqYQPy5qb2e+DikeQTdgIkHVK8CO4=;
        b=p6Tz93FtqpIFbVsc1tqSE07AWWTtub6Rja48onWdbvoXfuPgE6l4tML5a/Oz4gbcfe
         qqsGQmprPjC7lDdquRScY90um6b9jeuCte5/zOkirT4XcP7P0Rg2eDwV9sOtc4z+jHAV
         NV1M/P8PHUkWCH/1acnvYRRf/twvONNpvI+KugtCdWU+Ufk+s2ZsFJhsNHLrp3lAIO62
         GvPcEPKrA5oC6jOSCLhXCidfi8/WwDKIrWXqUmCzILvg8VQi0YB4M6WFJVk2X2+pz4wW
         wBzRJExKBlaHdd6xzxKsAHDvzhW5Tqu3jBpfx9KWuRdid2Z6d5GIhEdlLH3FWFpuwXez
         j+VA==
X-Forwarded-Encrypted: i=1; AJvYcCXakP/FaQ3ZJ81D6XvQK8WrKBab3A9ZBuEUc/De85wz1Uc04vXlhY+zX7x+/gYVpcEMD1ZWPrVhs7hgqSrqB10TvKKV1au6jBQRESnN
X-Gm-Message-State: AOJu0YzPpDXddA29ahW7xW7lVn4omg63OhSWT7/n4nsLMJislFj1Ptbn
	c+4mmksHhncsDdF3VujQks51m78RIg4jBZebghO/ijLxE+UQyCFWQj6iUibG4+4gcpLcsnWXYQw
	W+cpvBtbSdrPs0IaP+SYfJr6BI/xS7xT05zB9g7UByyCbKlErnRrX7Hum35ylabTyi8pRhmftKu
	VZWY46RN9LAvHS18T3iBlGPFCFOPE=
X-Google-Smtp-Source: AGHT+IHLYhIo10rbRWz1dfrBxzGxpNEXMT580cBsYCelbQrN06els0yuR7g8+LyMgd9+sd/SRxin2w==
X-Received: by 2002:a17:907:c78e:b0:a6f:bc02:a008 with SMTP id a640c23a62f3a-a7242c4de49mr335996166b.4.1719234369354;
        Mon, 24 Jun 2024 06:06:09 -0700 (PDT)
Received: from admins-Air ([2a02:810d:aec0:2a54:f136:1973:486:27b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7240f37b16sm251177566b.109.2024.06.24.06.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:06:08 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:06:02 +0200
From: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
To: pavel@ucw.cz, lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: Add LED1202 LED Controller
Message-ID: <ZnlvOuvMQmJFrfSX@admins-Air>
References: <ZniNdGgKyUMV-hjq@admins-Air>
 <7a080980-a247-4d17-88f7-19899379e1a1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a080980-a247-4d17-88f7-19899379e1a1@kernel.org>

On Mon, Jun 24, 2024 at 07:02:12AM +0200, Krzysztof Kozlowski wrote:
> On 23/06/2024 23:02, Vicentiu Galanopulo wrote:
> > The LED1202 is a 12-channel low quiescent current LED driver with:
> >   * Supply range from 2.6 V to 5 V
> >   * 20 mA current capability per channel
> >   * 1.8 V compatible I2C control interface
> >   * 8-bit analog dimming individual control
> >   * 12-bit local PWM resolution
> >   * 8 programmable patterns
> > 
> > Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
> > ---
> > 
> > Changes in v2:
> >   - renamed label to remove color from it
> >   - add color property for each node
> >   - add function and function-enumerator property for each node
> 
> Fix your email setup, because your broken or non-existing threading
> messes with review process. See:
> 
> b4 diff '<ZniNdGgKyUMV-hjq@admins-Air>'
> Grabbing thread from
> lore.kernel.org/all/ZniNdGgKyUMV-hjq@admins-Air/t.mbox.gz
> Checking for older revisions
> Grabbing search results from lore.kernel.org
>   Added from v1: 1 patches
> ---
> Analyzing 3 messages in the thread
> Looking for additional code-review trailers on lore.kernel.org
> Preparing fake-am for v1: dt-bindings: leds: Add LED1202 LED Controller
> ERROR: v1 series incomplete; unable to create a fake-am range
> ---
> Could not create fake-am range for lower series v1
> 
> 
> > 
> >  .../devicetree/bindings/leds/st,led1202.yml   | 162 ++++++++++++++++++
> >  1 file changed, 162 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/st,led1202.yml
> 
> yaml, not yml
ok, will change
> 
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/st,led1202.yml b/Documentation/devicetree/bindings/leds/st,led1202.yml
> > new file mode 100644
> > index 000000000000..1484b09c8eeb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/st,led1202.yml
> > @@ -0,0 +1,162 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/st,led1202.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ST LED1202 LED controllers
> > +
> > +maintainers:
> > +  - Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
> > +
> > +description:
> > +  The LED1202 is a 12-channel low quiescent current LED controller
> > +  programmable via I2C; The output current can be adjusted separately
> > +  for each channel by 8-bit analog and 12-bit digital dimming control.
> > +
> > +  Datasheet available at
> > +  https://www.st.com/en/power-management/led1202.html
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - st,led1202
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^led@[0-9a-f]+$":
> > +    type: object
> > +    $ref: common.yaml#
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 11
> > +
> > +    required:
> > +      - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/leds/common.h>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        led-controller@58 {
> > +            compatible = "st,led1202";
> > +            reg = <0x58>;
> > +            address-cells = <1>;
> > +            size-cells = <0>;
> > +
> > +            led@0 {
> > +                reg = <0>;
> > +                label = "led1";
> > +                function = LED_FUNCTION_STATUS;
> > +                color = <LED_COLOR_ID_RED>;
> > +                function-enumerator = <1>;
> > +                active = <1>;
> 
> This did not improve. First, which binding defines this field?
> 
it's a new field I added, but if you would like for me to use another
please advise.
Depending on this value, the enabled/disabled bit is set in the
appropriate register, and the led appears with the label name in sysfs.
Hope this extra info helps in helping me pick the appropiate binding. 

> Second this was never tested.
>
are you referring to the automated test done by the kernel test robot?

 
> Third, where did you give me any chance to reply to your comment before
> posting new version?
> 
I think I have a wrong understanding of the process or mutt client is missconfigured
or missued on my side.
I've been replying to your emails in the mutt client, but sending the patches with
mutt -H.
But the changes you mentioned related to function on color, I don't know what should have happend there.. 
I sent a v2 with the changes you indicated.

Thanks,
Vicentiu

> 
> Best regards,
> Krzysztof
> 

