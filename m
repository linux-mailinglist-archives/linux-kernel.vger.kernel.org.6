Return-Path: <linux-kernel+bounces-325817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F4C975E99
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42601C227A3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E902A1D6;
	Thu, 12 Sep 2024 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fB8KAnEF"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333153C24;
	Thu, 12 Sep 2024 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726105350; cv=none; b=Q6ydMH/IExbyKjGuP86IZ9zqazLEc1YiNTpqY+ayLHe328HLMernpR0369jUp+J6XcauZaAEUH1c2lgVZZVVo5wVsCOqzmKQ+arTWDPA4SBeU0z2jeVQeQrTItgBNn9fYgl0g1EQejYyuYRfBPHalSfJFY/LhRJkeamK1u6ZeV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726105350; c=relaxed/simple;
	bh=AhtLjJmMWl9cki27GULLW7uMxbGxUMd5ibgfjOAe0Bw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HdPQFEFUHVrifpbvI2h8HoDeTdWCgjbu5x4cZrp9EbgE1DX87coRPOlecmhxPlYwwaKqb+vpxsrVV9nm5bpRQ+I9/hGLbOTPoq2lBwjZ1crlDw/Cbw9G+2TDjaqUjXL9E+ACUpii3UViwKVg8S3FdrTvxCn6QhCcXXWvwbXYXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fB8KAnEF; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726105347;
	bh=HXBEzjrhINnkFwKmcbEAFRdNpgF88rPAK0NhIO44r1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fB8KAnEFOcjOww3sh7HWeeCgy97J7orYvAH5wbAPAhf5Uxljpx6sRM5/YwjpRhiG5
	 iPIEE9E0jLDaAX76YgEBRoZMlaM46U8Pt7oWCs3sVJh0h4T7SXR4fsr4Tkl8mqta4M
	 5iYPcVl7dqAKNhK4tyuL/TuQc/mdLNU57E08q0rQaGQd3Bm0goU5lX2ms4Ib8+R4q7
	 KJu0CK7WHmaeeRYhyufOXW1QVoEarh7mLFMz7nlHwvvrmxeQxLIpSjJFgIbaxB24zK
	 xBMSMX1RJqptRhnsntue8g9IJfgY+Uxlsx9AkHP4ubz77NmvQXH2zzhQODzh4tvdUv
	 CdOiQ1pHA/fJA==
Received: from [127.0.1.1] (ppp118-210-89-8.adl-adc-lon-bras32.tpg.internode.on.net [118.210.89.8])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4897D650D6;
	Thu, 12 Sep 2024 09:42:26 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: patrick@stwcx.xyz, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240910084109.3585923-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240910084109.3585923-1-Delphine_CC_Chiu@wiwynn.com>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Change eeprom for
 Medusa Board
Message-Id: <172610534620.690179.300123501570049846.b4-ty@codeconstruct.com.au>
Date: Thu, 12 Sep 2024 11:12:26 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Tue, 10 Sep 2024 16:41:09 +0800, Delphine CC Chiu wrote:
> Change eeprom on Medusa Board to AT24C128 according to hardware change.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

[1/1] ARM: dts: aspeed: yosemite4: Change eeprom for Medusa Board
      commit: 41217159f292ae69e5ba255b260c77dc644f0bdc

--
Andrew Jeffery <andrew@codeconstruct.com.au>


