Return-Path: <linux-kernel+bounces-325832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 716DB975EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3CB1F23D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0073CF58;
	Thu, 12 Sep 2024 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hBZ3oH02"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB136FBF;
	Thu, 12 Sep 2024 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726107054; cv=none; b=U/SWCvAacHaAuqTWRbTHK4XQZobDoFqrSjw4wqqiuKQlBovFojK592bTr1dk4/rOFHgg3p+ERXxvevstVLtzMX+/u2GNdH4dETFQGA6YCwMdD1fmegkvKQLrISVV8LxTUh5yIqTObK+bYbAjBMK3vFvdl2onfxXR/g82am7O4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726107054; c=relaxed/simple;
	bh=DtNloa3oi4zok1Zi6spcA5MVJDkX7AFOgnObSZ7N+dA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1J8i7CIMauoPuXjkYRwSYXr7ayD8enY4ftVVxInYhSxU6u5Ib230brbUfboGxmwZBdQTDH5curhjs3Ievu3HUvrINCySiurvvxT7kcZ8olBAPuuQzNYYh6lpSIPkVooqTsmmt+m4e7uV92dtW2y1L4WsBi4qSUtjPFwsBQqVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hBZ3oH02; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726107051;
	bh=2LaLyx7zyb56bK2TU4DCBHWv1c41cNWe6RFydXIXBPY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hBZ3oH029X4Lqtkmx7x+tv3L/RMwd4BCdPUAVpWUMdI+CnTu8he+qdmUiuB3X+//0
	 oUJdl0FY2R3P4Lp2+Jwqcdu7t2e1JldZDcJ9S6tD6hFfQneRnBEAxUCBRtaWCpNCsX
	 OxY2paMacjRtlPSiS5VNwujyMAnfz7mvU4GDDvE1oUIRfda7pgQo2ChJu2qjyl6hTa
	 ntbKkfHjXXQmhR8sk7Sd7jJZLaym0Vh2TU9kcOHxdVd8+m6wJ0rGwLEgJLujLxhe6J
	 QNuD69keeMJ4qmoybbIQjJrGVVuuASubL7l3PNclpMAuBdqRAXAmkVnU2X6+3Zi6g+
	 fRlc1WEr0GeYw==
Received: from [192.168.68.112] (ppp118-210-89-8.adl-adc-lon-bras32.tpg.internode.on.net [118.210.89.8])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7A63E650D6;
	Thu, 12 Sep 2024 10:10:49 +0800 (AWST)
Message-ID: <ccef1d90b9a7eb343e99afa2c6cd6ea7407b0541.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio pca9506
 for CPLD IOE
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2024 11:40:48 +0930
In-Reply-To: <20240910054751.2943217-3-Delphine_CC_Chiu@wiwynn.com>
References: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240910054751.2943217-3-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-10 at 13:47 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>=20
> We use CPLD to emulate gpio pca9506 I/O expander on each server
> boards.
> Therefore, add pca9506 to probe driver for the CPLD I/O expander.

I think it might be best if you add your own compatible to the list in
the gpio-pca95xx binding just in case there are some behavioural quirks
of your CPLD implementation? Not sure if this should be
"facebook,pca9506" or "wywinn,pca9506", but assuming facebook, from
there you can specify

    compatible =3D "facebook,pca9506", "nxp,pca9506";

This allows you to add the quirks to the driver as required in the
future through the more-specific compatible.

Andrew

