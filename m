Return-Path: <linux-kernel+bounces-337841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0AD984F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C01280E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697B9135A79;
	Wed, 25 Sep 2024 00:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ltm86nbS"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DD51849;
	Wed, 25 Sep 2024 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727225542; cv=none; b=PF8zM4gTwHXmKikW676klL5S2+1DMTkviHglNhHtHf6t/qla9ftuxNiQEAYlLdZqY3o3O17hAbe33NW9y/Ju++b4i056LiH2zXFQIFHWGRE/OQPFQz5Gk8IG/6euiYGMmNlly4u5ezzjtBCeWM9M0Pcl7oRf5c2EmT6o/4gwP74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727225542; c=relaxed/simple;
	bh=UqJwXA9BBiuvDYTwLA3Y523WQLPPVaayM23pfgsXxuQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pQT+yYiRbv5Llh5+0Rpoj/nIm+8KovGD45Y5bgDPLuLmrfLWFZR1xBOvuVuoA+/YRNLZ7AlRrlHaDMqIYaXtKjCw29cLrDsrDfnCO0wzp1PLDigBKFF7pPT2ce/uOpyvbE/J4uVjD8a2RHWysZ1IU0esk8KI9qjY2Ky/cNiO4ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ltm86nbS; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727225538;
	bh=H41MwTF6Q/0M5m52myZT/avRhCCOCQD58PwjMxG+d2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ltm86nbSNvjkJzSCE4aLPSfMtUPzfUzH7wjwi0PXJLMqYoMSi+3RNOBnO72DHOiYe
	 OBdVdKTVqnloivy0DiMNFPWU96dRqYSw6Ik6I+xFgv3xw/lSN9JzdARQaCIKv3PVky
	 dj+D9h9l9KGn6omJcmCOPvSkBY8Msp7rb6oyDhgAaKGNwe4uqnpSN/9aOeaLURg2VB
	 rrUum7NUjII6IfMyCTyHRBqzhpnanytmkzC5dtEqfW7GV6l5vEHjKb76dZUm1HrTJ/
	 nBsc2zY20njrK71szh16uTY5k9StvzPzWDK0Q89gvKtU5LP/Tku5jGDETqC4vRnVB5
	 wWbgG/38pGbrA==
Received: from [127.0.1.1] (ppp118-210-177-92.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.92])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0AC7F64C85;
	Wed, 25 Sep 2024 08:52:17 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: patrick@stwcx.xyz, Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240924094430.272074-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240924094430.272074-1-Delphine_CC_Chiu@wiwynn.com>
Subject: Re: [PATCH v2 0/2] Adjust the setting for SPI flash of yosemite4
Message-Id: <172722553796.384629.2084285836291139720.b4-ty@codeconstruct.com.au>
Date: Wed, 25 Sep 2024 10:22:17 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Tue, 24 Sep 2024 17:44:28 +0800, Delphine CC Chiu wrote:
> - v2
>   - Split the patches for different targets.
> - v1
>   - Revise SPI flash to dual mode.
>   - Revise flash layout to 128MB.
> 
> Ricky CX Wu (2):
>   ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
>   ARM: dts: aspeed: yosemite4: revise flash layout to 128MB
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


