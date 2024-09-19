Return-Path: <linux-kernel+bounces-333043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F9897C2AF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7054F1C210A0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8351DA4C;
	Thu, 19 Sep 2024 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fIso8GI5"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA2F3FC2;
	Thu, 19 Sep 2024 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726710347; cv=none; b=Aouyv1cirv9zzuym56c5IDz+DYf+r3iiMXAY0xb5aOM674zetokHToSJO1B6nfUh8MN9lnd6e0XtOPcpQ3jvMcaRG8Og+3/4w+3wqBHTC/vDnaWeW985ehleeQ4MlRmUcUOc2/RGhfkHwxyd0xEWZX0kHb2548nSJZXevzp0pTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726710347; c=relaxed/simple;
	bh=AYYh1Lu4UbQQORxGB+wWgWM1iYI9/4u2M89VICvYFAo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kLGBRt/akV+EIBrtYl6fZ/Aq9zvsju+dtia7GRe6UssvCunKz11k2xLYfqClWa0c2OxUCuBm9s9JoSj+yYh2+7VXvnbyJpFanDCp5XityPt8aneg9lBq2XCZImPFgI/dqs1NmwRMZBPzeQRmX1dOhLUZWVqzbWTuLAJmM+Q2pLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fIso8GI5; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726710343;
	bh=VgnCtdAk6lb3Sr23RFqM8ound6zyQIntpDJ821pp0Ik=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fIso8GI5Kxzw5p6Ywze2nDiMEA6sKcqWcXj0K9RKKJBV17F+Jlem1Lk59iQB3qqWE
	 UmDXMmzZAub8vSxdAfk5jqhSJUcKss9EmdlsYfXXbt89ec8aKNSN4PvgUSLDDK0kg2
	 rgnulKyemqvH1/gezXbK1fabzsQQHQK1cWbYgMp/LHP/ijtifMERticdf9Ao4stnFh
	 MpBIYcRJq7SW4YA+6EAs5aOhfpSX6wO3ovsiYCu1ijVPmYGvg42iwRhIxpjWzqdcQb
	 aagV3GQjHae/OAg21C3nw7KyGpC+e59VKYAXJj4Gmvd3EpQ856cdME186jrEf65YMv
	 qdVaHADV4CcgQ==
Received: from [127.0.1.1] (ppp118-210-188-185.adl-adc-lon-bras34.tpg.internode.on.net [118.210.188.185])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 90F2465027;
	Thu, 19 Sep 2024 09:45:42 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Manojkiran Eda <manojkiran.eda@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Ninad Palsule <ninad@linux.ibm.com>, openbmc@lists.ozlabs.org, 
 Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20240918-dts-aspeed-system1-peci-snoop-v2-1-2d4d17403670@gmail.com>
References: <20240918-dts-aspeed-system1-peci-snoop-v2-1-2d4d17403670@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: Enable PECI and LPC snoop for IBM
 System1
Message-Id: <172671034240.638277.4020741280785958625.b4-ty@codeconstruct.com.au>
Date: Thu, 19 Sep 2024 11:15:42 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Wed, 18 Sep 2024 14:50:03 +0530, Manojkiran Eda wrote:
> This patch enables the PECI interface and configures the LPC Snoop for
> ports 0x80 and 0x81 in the ASPEED BMC for IBM System1.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

[1/1] ARM: dts: aspeed: Enable PECI and LPC snoop for IBM System1
      commit: abfafb7269c3c1d73a2a7136f9d3f7e417c83a4c

--
Andrew Jeffery <andrew@codeconstruct.com.au>


