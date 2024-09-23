Return-Path: <linux-kernel+bounces-335350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E0897E47A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B121C20FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DC52114;
	Mon, 23 Sep 2024 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="RnbKRmh+"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A38D372;
	Mon, 23 Sep 2024 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727053357; cv=none; b=VsU+faJO+YODh0xk7vOk5DWcLAm/H1/FEseZS9NNOCxLmappJljPKaqQzdFv5PjNiJfk9rTBgHgTBSv76Wk65GwXSTa8D0Qlc1evN9n+5mPKuREwE6zE6+znTxI3TMWMORpuRzexeCG2Xj0HztGGydciGVwl68mXdJYIEOn60ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727053357; c=relaxed/simple;
	bh=l7Den0zj/MD0EHCURTk8V5blKj2DqStv6HhlLuj4F1I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CUoFCfAxK96+ymfUA/lM1+7xkeuzlIXM7U0Mn/YHB7zJdl1u7lOEeY/jete1zJrY7rxiJl1zu3cNozUnY3N4CZvyXZL12JrAPfYxNhVMiQ/jZ6+7YY1X45FiaN4L7qJQMCazWNHt7NgY+JFz8pM74oi1G/kmGAiFWN+9imAqOU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RnbKRmh+; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727053354;
	bh=l7Den0zj/MD0EHCURTk8V5blKj2DqStv6HhlLuj4F1I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RnbKRmh+RYTAHI/I/0kjl5TQ2kbz1D9aM0cdCK0xAwZ9v1IcO8ropbeLn0kxNTz/b
	 y9mpFDXibIreFEPZi1Y35eewnZM9rKIj1EICi9WsHNc8+CO2g+fUqOmkJiz2NUCXh9
	 sjFo/WrL3gZobrnnH3Y2aLvDiQLXjbN/yn7PqsJ3+yquo9SAP/rteBdvYupj65+KD+
	 eF/9iaA05JSqRy+TpnmbWkyE+PtfCVwhGGucpqMPowQ+smhi76AlwKB/rmRPcUPDa9
	 B64ww/IIy7XKqIJEuU6v/ZVxg4Hxs4Yb+/tOAWDTEmp1+r5VoZ5/B+zRxNaSYpSyCp
	 JrCqwJZPoPAzA==
Received: from [192.168.68.112] (ppp118-210-177-92.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.92])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6E25B640E8;
	Mon, 23 Sep 2024 09:02:33 +0800 (AWST)
Message-ID: <a93f32cba7721cc6874d0baf0b29e1cc9bfe15c1.camel@codeconstruct.com.au>
Subject: Re: [PATCH v19 2/2] ARM: dts: aspeed: yosemite4: add mctp config
 and sensors for NIC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 23 Sep 2024 10:32:32 +0930
In-Reply-To: <20240920070449.3871705-3-Delphine_CC_Chiu@wiwynn.com>
References: <20240920070449.3871705-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240920070449.3871705-3-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-20 at 15:04 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>=20
> - Add MCTP config for NIC and remove the unnecessary MCTP config on bus
> 15.
> - Add eeprom for NIC.

There's no suggestion that these are related. Why are they done in the
same commit?

Andrew

