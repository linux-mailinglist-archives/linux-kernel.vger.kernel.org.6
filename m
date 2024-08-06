Return-Path: <linux-kernel+bounces-275631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288BA9487C7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70A2281B9D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA0B57CBA;
	Tue,  6 Aug 2024 03:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="lwwbfBXE"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9538B663;
	Tue,  6 Aug 2024 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913309; cv=none; b=Du0kTbJzLxLdP3nNZsLBFeR196o4WcHAiUUrl6a4jTy9UjcgJ4juRDozhkQa4wK0NIYh6FCGjvDLCWx1bL2/f8f9zyHzBtTfoiAzRbQRCgSjzStS10+eFOWtfh0HQnPSJ9mrOjlIHjiRcmkIh09Lx0eEVj8gAMLLHtPxkjjGGEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913309; c=relaxed/simple;
	bh=M0QMkszaeDL5hyqoTYcPs5FeLwOUmRv15dxB29QafcM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kTRLzZHLDSBiYN9pazYTUR3fTUlYrYTHpqRX4hz10tahNzHkbngUC8zxqfgnOe8NeEHjKNQ4BWNgmeYO5yRqkfNio6ZdkHnEQenoUkhw578KfA/tRQwWepiOhu1Pp19u/kXgHERfXIh77e0W1QzjlXz1PDYGwqJczvfjzNpCHms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=lwwbfBXE; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722913304;
	bh=M0QMkszaeDL5hyqoTYcPs5FeLwOUmRv15dxB29QafcM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lwwbfBXEB+9gtWp4Vrsom2CubA2Ms/9yLCYJsguZQtolPrzRs+iaWRDEUiQ3QjMj3
	 al2CEWdFSbODMUkQVljr3RI3xFmLMznSLAV39OFkJlOv2wwMWGaIkF3+DN5OhT58cq
	 VHkZe+JFzSzZMFinKA3+jUOLYeXw87fqjfmiY1snL408dMhOTMXr/ev9YgvVcs+nUl
	 6LL8ZXzKoY1qndZvesEoXtUXgJ2hCfRasxK3lTeUaur/Siog5xccUbd9cFvE9EfCwP
	 a7Zpjej9T/BuyrnNYLOVKQbwUQEhr5Z710URDrXnyL0eWj+TbdSl9PVVcve9XaXX9Z
	 z5YRtASfCrGIA==
Received: from [192.168.68.112] (ppp14-2-105-65.adl-apt-pir-bras32.tpg.internode.on.net [14.2.105.65])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4771865669;
	Tue,  6 Aug 2024 11:01:41 +0800 (AWST)
Message-ID: <1c6598d080d488005b14e127396dd7db72bc4ca4.camel@codeconstruct.com.au>
Subject: Re: [PATCH v7 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Cosmo Chou
 <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, Conor Dooley
 <conor.dooley@microchip.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Date: Tue, 06 Aug 2024 12:31:38 +0930
In-Reply-To: <20240805-potin-catalina-dts-v7-0-286bfd2ab93b@gmail.com>
References: <20240805-potin-catalina-dts-v7-0-286bfd2ab93b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-05 at 23:46 +0800, Potin Lai wrote:
> Add Linux device tree entry related to Meta(Facebook) Catalina specific
> devices connected to BMC(AST2600) SoC.
>=20
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
> Changes in v7:
> - drop 'pinctrl-names' in gpio0 node
> - change 'vref' to 'vref-supply' in adc0 & adc1 nodes
> - add p1v8_bmc_aux & p2v5_bmc_aux nodes
> - change Signed-off tag email as same as sender.
> - Link to v6: https://lore.kernel.org/r/20240802-potin-catalina-dts-v6-0-=
0b8f61b80688@gmail.com

Thanks, I've applied these to be picked up via the BMC tree.

Andrew

