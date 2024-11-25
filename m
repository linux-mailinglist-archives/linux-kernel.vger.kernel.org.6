Return-Path: <linux-kernel+bounces-420603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7539D7D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4F1163666
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59AA18C03F;
	Mon, 25 Nov 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jKzvuja/"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F218BBBB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524227; cv=none; b=pEyJxXMUUQ3NPSFK6pe58WUK8GagQx/pKCQT2MIxGAHpvo24zPJek1t+qx3Fjg22W/2FyydvfIpoXfSpYiRzLst/ZapR+3xZBNj1jJ/Ud2teX9NJfx70AXtRyJvOLAI8mf9+BJCtO/TGEoVEGYT/oQ4NdlSSnrVNqobchvbBTSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524227; c=relaxed/simple;
	bh=gAVXzRO6flOMUc+jbivLLOShw9D4eUFZeiCNKksrDnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9qIFUP99kBWNG7nEsmq7EcIGWk85k2B3rF8vnQ+wHqBgig5yDYfT1TbImzHfKrGJpeMGka3SfPCtojOTxkYUsdiIIZIeWNIkhugFZR7jvvFJmwbGRYik77a0ovgRTUCcSy8zdgn1Sk4G+mVveUywaaacUOMO7LN+IdPh6V//Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jKzvuja/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ea304ce809so3530393a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732524225; x=1733129025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WF1SurkpJR9+d436XSidV3nIHqKYTAhhIXu+fIUsswU=;
        b=jKzvuja/Z4YlCH0uuK+81dhzQrmSQr0ej49IbhoT270N6OwQkSiFQGSLej0HEIoKJP
         SEN8JFh6+8mrJy0Jzvzs7NkFbmnQUn7U+x10/rr7EMA62N3ExHUEHRrwsqdpo7mQ/mnP
         WBz9AB9m7cbJMf59mS8D++rCWpF9DUnN6FshU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732524225; x=1733129025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF1SurkpJR9+d436XSidV3nIHqKYTAhhIXu+fIUsswU=;
        b=r08LuwLjX/jEPM2e2Y29QsgNMm2k65u5jHACV140NG/TZN0uGUhK2w+hEKuEBTEQHy
         pWtnyB0tWSeQMkhaLJvDBWF2P8mS+PyVFCX28n29IDOXUWPGIZdB1AfcN34Yd4R5hJQs
         M3Co0XZU/5R5Nbm8Y+pwtdooH5bP2l603uAXOYYGgejQJcpDY55unuwp43AvagvUybiH
         7TDayKtm6wj0USzyuZGdT7F0YQMB2/5zBxoVJvpoZgCp1YKHCyRG7E2GTvqAyEkyKm/6
         oZJ66Ga/GAgcJIgE9BD8fadaY5oi41EkA9rvIxWfcp6yALG5JrqJf8t4EnCRgPFcur0H
         mYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjj2//VdtovzbvgbVbTripJ4+9Eg6XNHjyPJlhcd13w1FsqeO3OiJG5T53FRjtBR0SsTmYRXaiWI50458=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYYH77tmoIH4Rj7YGe4KXyMFwTxvuxHqDY+D3xiFRHItrwidm
	ZgqdkG4GnBAlhMXitW676FTqVHt/l1gH8nB88mR/kDDeM1o3gPrMkdESPGmO7g==
X-Gm-Gg: ASbGncs7Uuq8xly5ovPFWGVh6nBGyZcjIuO4gsDwJ6ahp2EvYTIjWc3UKkye65BNMFS
	RZpXeIplr/kqvB6BYB5181F+nZ9FQvGePAPNMaEDHVEAV1mtOLO9gPdxkN41asOhhsk8bjV+EIN
	PhdkoJWBblXcR505r99LTDdKNoG9dN9J4CmsTzTX/fZI3pSweSLGO0xzGcQ7ol4kRDuo1b0sddt
	m+OWKjJTQxa2RpdXzmJNWWrhZFUTLJBSBcws/5nS3xh
X-Google-Smtp-Source: AGHT+IGwNB4nRJMnNhTbAeM5SVohmmw2VhsVBxq/0MFDU/T8BxbRsqUD7vI2vwEli6Gsw3VQCvNV0A==
X-Received: by 2002:a17:90a:ec83:b0:2ea:5fa5:fac0 with SMTP id 98e67ed59e1d1-2eb0e332553mr16365914a91.16.1732524224785;
        Mon, 25 Nov 2024 00:43:44 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:66a3:d18f:544f:227a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead03de64asm9677264a91.41.2024.11.25.00.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 00:43:44 -0800 (PST)
Date: Mon, 25 Nov 2024 16:43:40 +0800
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
Message-ID: <Z0Q4vGXbvU3j9H65@google.com>
References: <20241122-extend_power_limit-v1-0-a3ecd87afa76@chromium.org>
 <20241122-extend_power_limit-v1-2-a3ecd87afa76@chromium.org>
 <4f5sahkxxqb5qonh676igaiadkxv2pbhbibu6wtx4yenplfn4o@yvidi4ujavhr>
 <Z0Pl3muZx716QSed@google.com>
 <c2e9a97e-129d-4a82-9e81-b1391b4b6ff9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2e9a97e-129d-4a82-9e81-b1391b4b6ff9@kernel.org>

On Mon, Nov 25, 2024 at 08:32:19AM +0100, Krzysztof Kozlowski wrote:
> On 25/11/2024 03:50, Sung-Chi, Li wrote:
> > On Fri, Nov 22, 2024 at 08:49:14AM +0100, Krzysztof Kozlowski wrote:
> >> On Fri, Nov 22, 2024 at 11:47:22AM +0800, Sung-Chi Li wrote:
> >>> The cros_ec supports limiting the input current to act as a passive
> >>> thermal cooling device. Add the property '#cooling-cells' bindings, such
> >>> that thermal framework can recognize cros_ec as a valid thermal cooling
> >>> device.
> >>>
> >>> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> >>> index aac8819bd00b..2b6f098057af 100644
> >>> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> >>> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> >>> @@ -96,6 +96,9 @@ properties:
> >>>    '#gpio-cells':
> >>>      const: 2
> >>>  
> >>> +  '#cooling-cells':
> >>> +    const: 2
> >>
> >> This is not a cooling device. BTW, your commit msg is somehow circular.
> >> "Add cooling to make it a cooling device because it will be then cooling
> >> device."
> >>
> >> Power supply already provides necessary framework for managing charging
> >> current and temperatures. If this is to stay, you need to explain why
> >> this is suitable to be considered a thermal zone or system cooling
> >> device (not power supply or input power cooling).
> >>
> >> Best regards,
> >> Krzysztof
> >>
> > 
> > Thank you, I will rephrase the commit message. The reason to not to use the
> > managing charging current and temperatures in the power supply framework is
> > that:
> > 
> > - The EC may not have the thermal sensor value for the charger, and there is no
> >   protocol for getting the thermal sensor value for the charger (there is
> >   command for reading thermal sensor values, but there is no specification for
> >   what sensor index is for the charger, if the charger provides thermal value).
> > - The managing mechanism only take the charger thermal value into account, and
> >   I would like to control the current based on the thermal condition of the
> >   whole device.
> > 
> > I will include these explanation in the following changes.
> 
> 
> This does not explain me why this is supposed to be thermal zone. I
> already said it, but let's repeat: This is not a thermal zone. This
> isn't thermal zone sensor, either.

Hi, I added the explanation in the commit message in v2, in short, I need to use
different thermal sensors, and need finer thermal controls, so I have to use
thermal zone. This is included in the v2 commit message.

> 
> 
> Best regards,
> Krzysztof

