Return-Path: <linux-kernel+bounces-333036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16F397C279
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EF5284287
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A62838389;
	Thu, 19 Sep 2024 01:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Tc7JR9sz"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063822F1E;
	Thu, 19 Sep 2024 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709747; cv=none; b=SliQRU3EiJriQ7iAOXK8HcgOuLipgs1lFff5jesgRT5kb/MoB46Ih3Iki2zVyawvZN73gPYxHOt6KEwIh/oIsgy4PqQ2njS8I8MkizauUV7xqDN8WG/EPcrbj6XG8TnLMYQYiEDtKhqKsDzYkJIv9DdpV8aW3EyBoaoBgFHpR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709747; c=relaxed/simple;
	bh=dMDsKPBkOh6eiYle1ouJMD2TuTUdr/MZsmKQrK3fVE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UTnjXldE3TOV0L9dR9cHU6JUhoVsmr2YUE60yDlGHB0CQNDWkHJ+k6IQ2/rhOiA2vLq0LGRsJqpjHIrideIRCJY3xldy1cRJPoOZoHC3MNeAMBICXAPuGC0dYCXbyWomJdNB2fccTV4hsscRUA0VEB46wvIZc8BHWMjy3Ut1IUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Tc7JR9sz; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726709743;
	bh=IExdDbZ/GMKRz8cAAHlrjM+Fc2bsSlmO4LT61IojNqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Tc7JR9szReZ8ec5ByN9zY+qACCyQZRK8bB60hnp3PLNPwg7kwrb3feyUjgRhE9ll+
	 EVOsOV+OcL0wkH8r/H3+TBkfWZLEacLTCC3NC9JYsnYbaXIwSPilzhA72cqpiVlNRG
	 G3d7VX9EO3uZA1frkyQiOZBCZOeQapUcnblkNN0ETla8E5UzC54KSqH96BjZqAoEL6
	 qmDH9ET6o+SW5a23hsG1G9CKsU6td6iFRwUoygVwcIlWPwCwM8vIbEXWX6GlzpMc2N
	 TCpCBfxmLx5l+eVrpJVUo0PDBvJiaUPZVcKGcO16QjRdrQqlDIZ7tixiEzCM1uVdvR
	 EZK1F1R+Jl4/A==
Received: from [127.0.1.1] (ppp118-210-188-185.adl-adc-lon-bras34.tpg.internode.on.net [118.210.188.185])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 94CD065027;
	Thu, 19 Sep 2024 09:35:42 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: patrick@stwcx.xyz, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240918101742.1346788-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240918101742.1346788-1-Delphine_CC_Chiu@wiwynn.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: yosemite4: Enable interrupt
 setting for pca9555
Message-Id: <172670974249.626583.5344001337825691927.b4-ty@codeconstruct.com.au>
Date: Thu, 19 Sep 2024 11:05:42 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Wed, 18 Sep 2024 18:17:41 +0800, Delphine CC Chiu wrote:
> Enable interrupt setting and add GPIO line name for pca9555 for the I/O
> expanders on Medusa board.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

[1/1] ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
      commit: f2c5e6d55ee4f0a634d2ed0427f55b81cfca8f2f

--
Andrew Jeffery <andrew@codeconstruct.com.au>


