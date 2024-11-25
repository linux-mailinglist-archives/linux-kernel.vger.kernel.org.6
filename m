Return-Path: <linux-kernel+bounces-420592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C55559D7D02
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3557CB221D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73AE1885B8;
	Mon, 25 Nov 2024 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EBtpqW2y"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0EB185955
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523779; cv=none; b=V+sEDRaTNEUDISAvHf29cJejONJr1erc+xoopq3hchKSCihXHO8RfvnUhbQ5LGx9WRSd98K8IQaK351kUCbpVJRSRoGzluD3V0bJoEicubZa+/jHN9Qox3tsJf+EWYUWykoLdWD8XwhgYnytG3Bm0KKqD4mrKtGrrZsWIuT7WcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523779; c=relaxed/simple;
	bh=LFZPIyR6ASWo+Qpc5QWBNipe1NMG6Z5pRSj8OUn4/Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM6D+EJe+NgnE3L+c6eG6e7RgUms05hKlr69T7LvaRG1nQc2K/ojV5Q5l0/YYEvYn5dd9JQM/kqG/4uSuMTB8TVYphX3fjxXNBryIFE5EHKjkVQjtqNERRNj4siFzWBGBWBG88yZfoTvfghqWGGwiOaBVf525VRHIgY7sHfOU1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EBtpqW2y; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fc2b84bc60so561273a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732523777; x=1733128577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c8y7knWYoVm5AIz2hT27XuGr0+HUiUQTJYnoybECw00=;
        b=EBtpqW2yQiYaRs3qYDJDJ8uQLJlW/QPrLDXtzx5xgTPsJK4BlwJdeEDv/waGgFcs8M
         vw49mMwu7towAFIDcoXP+TMCGlfaNSkNTs/zcz4q/R3Lz4psamjZ7m1nKCtHpBGZ5A9b
         GQk+rtHrtle/7camii2l08F4wJc9OiQmLciOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732523777; x=1733128577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8y7knWYoVm5AIz2hT27XuGr0+HUiUQTJYnoybECw00=;
        b=ieUz+/yX2NBs84WLpgO4U44ZwRg+qb9rRjuhcNzo86O0so66zKZ0H4xmFXi9cUvL1/
         LBjvgxxZb2WnCovA52D/8U2vQNAk5jPYsYgEfsDI244vlQrRgDlIe5CGr8VpeNWkMLY0
         X3n32pN+q9VKNwwM7cYdxE93kNGe0Lzrm1+4cM3VsRwe7afzO8wCiW7R4PpbWBXHTZ+N
         6459vVFgibSFufPFlARuvupJVRuVMHQ8uFc6IwUJlyNvWv+BDToGLCSJcYqu2Z9mh9Pc
         Cf5FBKwCZwQTsZV0+mUBK6S2FUo6Fiz02nkvyJ7/fkXGtrkPJByTlkNQwMPXTCHLeBQ1
         BDPw==
X-Forwarded-Encrypted: i=1; AJvYcCXnoMjcZmLECjviyEwvK6bpKT22JFscjCT8PAs1y9n7p/q6Al13rNkBDRui1ZNaeQs1Bzt228m3A7ce0mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI9YD1D2QUiTZDIGUQB+KrXJ4crAmBX8gvx/MU5EFhWeYo3ysr
	kWQIgrDG6vLog6pFluxb4vAv9p1zlNdDimPXO++bCyWjY2Y4j8/P8s/5Qk4GHg==
X-Gm-Gg: ASbGncslpPksegatWjNVQQ8PtekSllnABJutgh5Lrtu3nFdSo1i3EFcmufztlo7nbek
	V1oO2wQ3hO45wcAiDMg9n7tsFIdWaVTv5FZ1jcvw5NU1Waq2XAFW/Sfx/QZpboZnR7nuRQjY2dw
	bQnjJuijyz3C8q+D38CTHg+GCobmrLiRarC3c94TddMA32N6gjsK1Syrbni0WP4AVJG11e32T7l
	X1BzT8bP4bAbHRNAUg14N5S5+vMDrnzWDUCprvQwpVf
X-Google-Smtp-Source: AGHT+IEpo2KdlJDaqZnS03OD0RPyKY0ulaDT8hskGK6LW/OqNmKQOfY9Vz1uB+KvJ1tLMzjf1OOoFQ==
X-Received: by 2002:a05:6a20:244a:b0:1d9:21a0:14e0 with SMTP id adf61e73a8af0-1e09e3f0a42mr19359410637.12.1732523777046;
        Mon, 25 Nov 2024 00:36:17 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:66a3:d18f:544f:227a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de531b68sm5847702b3a.111.2024.11.25.00.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 00:36:16 -0800 (PST)
Date: Mon, 25 Nov 2024 16:36:13 +0800
From: "Sung-Chi, Li" <lschyi@chromium.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, chrome-platform@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mfd: cros-ec: add properties for
 thermal cooling cells
Message-ID: <Z0Q2_ds3HCMaN1jQ@google.com>
References: <20241122-extend_power_limit-v1-0-a3ecd87afa76@chromium.org>
 <20241122-extend_power_limit-v1-2-a3ecd87afa76@chromium.org>
 <4f5sahkxxqb5qonh676igaiadkxv2pbhbibu6wtx4yenplfn4o@yvidi4ujavhr>
 <Z0Pl3muZx716QSed@google.com>
 <c2e9a97e-129d-4a82-9e81-b1391b4b6ff9@kernel.org>
 <667d4273-b3dd-4027-9266-bbd88b2f537a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <667d4273-b3dd-4027-9266-bbd88b2f537a@kernel.org>

On Mon, Nov 25, 2024 at 08:35:01AM +0100, Krzysztof Kozlowski wrote:
> On 25/11/2024 08:32, Krzysztof Kozlowski wrote:
> > On 25/11/2024 03:50, Sung-Chi, Li wrote:
> >> On Fri, Nov 22, 2024 at 08:49:14AM +0100, Krzysztof Kozlowski wrote:
> >>> On Fri, Nov 22, 2024 at 11:47:22AM +0800, Sung-Chi Li wrote:
> >>>> The cros_ec supports limiting the input current to act as a passive
> >>>> thermal cooling device. Add the property '#cooling-cells' bindings, such
> >>>> that thermal framework can recognize cros_ec as a valid thermal cooling
> >>>> device.
> >>>>
> >>>> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 3 +++
> >>>>  1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> >>>> index aac8819bd00b..2b6f098057af 100644
> >>>> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> >>>> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> >>>> @@ -96,6 +96,9 @@ properties:
> >>>>    '#gpio-cells':
> >>>>      const: 2
> >>>>  
> >>>> +  '#cooling-cells':
> >>>> +    const: 2
> >>>
> >>> This is not a cooling device. BTW, your commit msg is somehow circular.
> 
> 
> ^^^ And here which you ignored: this is not a cooling device.
> 

Hi, I added the explanation in the commit message in the v2 version. Please have
a look, it should explains why it is not a cooling device.

> >>> "Add cooling to make it a cooling device because it will be then cooling
> >>> device."
> >>>
> >>> Power supply already provides necessary framework for managing charging
> >>> current and temperatures. If this is to stay, you need to explain why
> >>> this is suitable to be considered a thermal zone or system cooling
> >>> device (not power supply or input power cooling).
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>>
> >>
> >> Thank you, I will rephrase the commit message. The reason to not to use the
> >> managing charging current and temperatures in the power supply framework is
> >> that:
> >>
> >> - The EC may not have the thermal sensor value for the charger, and there is no
> >>   protocol for getting the thermal sensor value for the charger (there is
> >>   command for reading thermal sensor values, but there is no specification for
> >>   what sensor index is for the charger, if the charger provides thermal value).
> >> - The managing mechanism only take the charger thermal value into account, and
> >>   I would like to control the current based on the thermal condition of the
> >>   whole device.
> >>
> >> I will include these explanation in the following changes.
> > 
> > 
> > This does not explain me why this is supposed to be thermal zone. I
> > already said it, but let's repeat: This is not a thermal zone. This
> > isn't thermal zone sensor, either.
> 
> 
> And nothing from your "revised" commit msg explains why something which
> is not a cooling device is supposed to be a cooling device.

The revised commit message is sent, please have a look.

> 
> 
> Best regards,
> Krzysztof

