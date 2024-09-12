Return-Path: <linux-kernel+bounces-325843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D24975EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38F61C21E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47DD41C65;
	Thu, 12 Sep 2024 02:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="M0lMF+m5"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF773C24;
	Thu, 12 Sep 2024 02:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726108023; cv=none; b=g7OV0yCjM9AN1iWncLsVFxT8lKovnxbJKsoTaI9h3dC7J+FGwXYuEfQC7bvxLZDuFLyv6Z4YMILOyglaWb3W78f9Ic477atO6ssPUeAPX6Gc36lRPn8VPCcxvCH5R8Sgex7vHNzTJQ9HXrMcncCxm7XZxGtcT5ysIYDmtHNJZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726108023; c=relaxed/simple;
	bh=BXcYBcx2y4YZCH6yjZQSNtfF5AUmkdKLYxNVH2SITfQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Po86kMRLzQU4FC9hJn1gTn8m7BV6K38v9IEiNgTCviQbMzoXIKFGsbTWbV9/U/Y5baoqBxqZEORicvNSNUGh5K/J0Bs7bPVYk4F/fF3PSn56bh4uTfp+ENWbhL9S6E1CW+yG5Sh+f8DsyE5dwZ8Fv3OEj3H0hhyYuoa0QM6dDVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=M0lMF+m5; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726108019;
	bh=4T+rDZ0xJ2wcnLPEZ14zB7/g2o2IjvlNz0qDcwZKU/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=M0lMF+m5rm6jq08qEg42+8u0hQV2kXypF2aBpBQs6gO8f1qcAEKHWuwD6zUseVOah
	 oE6YLdG/BwvAQu3nuBIPjNhsvSzHxgMiYtiuI9c8iGjlQVwoaDfddfClpj3JEJi4bG
	 LrxU6d3FLkP7ppDGdf8BNZbvnLf7oVX0ICXDVaBs0qE7LEeE7fHpUBTOFdZ8EKNurC
	 e0FB8+H4ZKWBRUl8E9dUFHiTVwjB+a08QpZoCnSDSaimkOf4dlEpP7Fm0jzOLEXCXs
	 xyZM6OPdFVagMaLEfgD720gpdosvfbg8RlUdPGx6QgoXN4DUE8w7uQtFziFaXPuHU/
	 S4eV5aabqvBAw==
Received: from [127.0.1.1] (ppp118-210-89-8.adl-adc-lon-bras32.tpg.internode.on.net [118.210.89.8])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F1A34650D6;
	Thu, 12 Sep 2024 10:26:58 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: patrick@stwcx.xyz, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240910022236.1564291-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240910022236.1564291-1-Delphine_CC_Chiu@wiwynn.com>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable adc15
Message-Id: <172610801889.712033.6359452612409373701.b4-ty@codeconstruct.com.au>
Date: Thu, 12 Sep 2024 11:56:58 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Tue, 10 Sep 2024 10:22:36 +0800, Delphine CC Chiu wrote:
> Enable Yosemite4 adc15 config for monitoring P3V_BAT_SCALED.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

[1/1] ARM: dts: aspeed: yosemite4: Enable adc15
      commit: e3b9afda18a6dc7975197a061c698142deeccc1b

--
Andrew Jeffery <andrew@codeconstruct.com.au>


