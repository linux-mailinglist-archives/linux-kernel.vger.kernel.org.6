Return-Path: <linux-kernel+bounces-540668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5F1A4B388
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F16C3B16E5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1171EB185;
	Sun,  2 Mar 2025 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFAcFBoT"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212621E5B9F;
	Sun,  2 Mar 2025 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740934271; cv=none; b=JnHss5gQREtBVgCzY4hIFjd25tuQFB17OVNbvwWC32mwxRNpL/M0pBUxdcxklicam06Gn+/fShbN1FedZiqDwPlyclLb3Ac3lCMmWXQdokoyMlleuC2qWDjq0pM2Q4hOfuReJDJTuLPPwV07l8p6PO0/2ua9e0NxJsI+h7bgViw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740934271; c=relaxed/simple;
	bh=us8tQCsFd7YwDUcz7xpVoolCPkE4KmbeOOookqTXAwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pqu29KTqraXX1mX3estUqQkDgg5Bx/skryDskeF15NYjISaQ6qDH98i0YtbeKEfQwDtAOagA9ANLvEnrHy0m9ZS/DCfwxIpI2JecKHio8BFg2BYGl9s7cIT9zE3YpV0md2dwlCwHsaKyFwfYo5naErf/pUtsclOwT61FtpdPlwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFAcFBoT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2233622fdffso71285075ad.2;
        Sun, 02 Mar 2025 08:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740934269; x=1741539069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmO+GgUzWVuicFZ92LIZfvSSRqi+TDILi8AmnVSy/6w=;
        b=LFAcFBoTCTo4203hjfNgyCexeYWJ59srg3D4MBbAvqTdB2Ap7yRbAYa/UX5W3Mgyha
         dJ+GV6LFovWW9PjnBtdeXhcV00DPpF6oNZ51eLSEye5lPJefDNtcieii7z1GwdwR36A4
         6aCRcYk/7JR13WFWoGMufpsREou9YxabPetARYO/8ZaAUI05zOmKWLGOmqcqNNPwcuZh
         CcXlBReTBaY9Aw7ZgnkJAV0qg1GFykLCuNji4wohvr2g5Ryy2jaMYVwKD8E5vtL27cf5
         fg0PRHODrtjvb5iJN5EW8FCnLp6Zjjy/0ZvrLsKhraqkl5mwT7X6tZIMWFX7OvVICUQW
         q3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740934269; x=1741539069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmO+GgUzWVuicFZ92LIZfvSSRqi+TDILi8AmnVSy/6w=;
        b=W/9eE57K0SjJ1CRZIk1K8IbfCv+sFE/ofJ8oQn1tZzDN+xyYjy4s5vV4DvdfDz18mW
         urumdP07Rs6l11CnjiszcW9cuJLIfv4VoXQADMa6ZKoSwrreEBPbxaRFJbPLEH8MfoF6
         afDpe7X/JWQIc9kNcTs5wLjk908nAKlehlZKpfzXpnpoZgzKLS3bLDulPTC73xdWqots
         k93L/2nzeEO0Bwaje12sokATWo9rQLlJdXoJgPsllvKOq5Zo4o6GElnXUUNAIIIRrcPS
         Fd4sg98EhbMkwIdkDBpaoqPbHGstHegR0OndBV1NDYAtBCjIXuNgGgnRV7vidN+4PjKS
         k7sg==
X-Forwarded-Encrypted: i=1; AJvYcCWpV/BB0sCKSll7AVB6au06zvN8P+zsvLB27uxdbRIA1ehRknBLGtHu9mcFcpgSHYi894IdDm3/ghto@vger.kernel.org, AJvYcCX3kLTGELt5MJSAyzTo46Q4PghssaEeTSqMEqdOwwcbrN9P2uMvW22vT4qlDV1eQp/my+I/DVJd1tJLPvg7@vger.kernel.org, AJvYcCX60SFnfW49bdOqtKHFP8Y1lItHk345FU/WP2nesuL8apT811xwBnAWtU/XuvTqwzC04rSqnPX3V8bc6Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO0ROoi3SOz5PI0muQRzE3JzBygnAsu8pAgzfmRi2VBeUlkchk
	WLmg+b61mX6Skk9vd059E3JzHZkM4WprsZwQr6eLqZ6fRW04Mppi
X-Gm-Gg: ASbGncsbMidJrHKaAaVvtmACBvZbGmQ7+YD+62YMqDD3sN6nr4195vs/HtZOTGDFys9
	xLJRzyvecpXue/wAmugVTXmiOMbZJ9tYQ4J9dLGu/wapuKMCCuRbORMDYxLzSiw42alc7MjgM8L
	rvWxg+OvIIIu56L1IEIIReJBhs1Dh6GGBx0vs+QMoeRPkMWznnNGqnTiJIDY+GPvJ2nSguvHUkc
	j0XhO8rLCl2IXt+oFtn+PGlxEbCSjf99Ys1/FoTuFGigDce8IOqXXM2xEWmJrrcawIMgonK5jEK
	l7bP75En1hyiOZnieTjwpdnvNH+wdVTwdveCPXtRl/XQKRGIDCGCTvFxMg==
X-Google-Smtp-Source: AGHT+IFhbXN73C8c1R88P1V9sIiQqJcvmI5nPsi95MgZuxPifmt8O423iOmN9vaMCm/gAuTIweEhUw==
X-Received: by 2002:a17:902:da91:b0:21f:c67:a68a with SMTP id d9443c01a7336-223690e5d44mr147987285ad.31.1740934268882;
        Sun, 02 Mar 2025 08:51:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235052005fsm62009895ad.227.2025.03.02.08.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:51:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Mar 2025 08:51:07 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: hwmon: gpio-fan: Add optional regulator
 support
Message-ID: <8e8a1743-8afe-4586-8fec-33f7d172f305@roeck-us.net>
References: <20250210145934.761280-1-alexander.stein@ew.tq-group.com>
 <20250210145934.761280-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210145934.761280-2-alexander.stein@ew.tq-group.com>

On Mon, Feb 10, 2025 at 03:59:29PM +0100, Alexander Stein wrote:
> This adds an optional regulator support (e.g. switchable supply) to the
> GPIO fan binding.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, after making the change suggested by Krzysztof.

> ---
>  Documentation/devicetree/bindings/hwmon/gpio-fan.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> index 7f30cfc873506..d5386990ab153 100644
> --- a/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> @@ -23,6 +23,9 @@ properties:
>    alarm-gpios:
>      maxItems: 1
>  
> +  fan-supply:
> +    description: Phandle to the regulator that provides power to the fan.
> +
>    gpio-fan,speed-map:
>      $ref: /schemas/types.yaml#/definitions/uint32-matrix
>      minItems: 2

