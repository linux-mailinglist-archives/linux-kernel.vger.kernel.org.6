Return-Path: <linux-kernel+bounces-333047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E31B97C2BF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259C01F21D55
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA8F1E517;
	Thu, 19 Sep 2024 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aFjCTQzF"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8CF14277;
	Thu, 19 Sep 2024 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726711197; cv=none; b=iMS0gkyfWs5sRbrWvJwDNG5Ma3XJPFBF2/QwxGcnz8kLUq3Mdx/UBYS94NKpIT4RIbRzx4PprqeSnOTZxiNV4b9v+fEKaFaN1JtQIuQz7b98N/b+uWeumQokPVH8Hj05Xo+THZNMjQURWo9Ix+yXxoKkyuNGVXk+3s+7jv9qNWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726711197; c=relaxed/simple;
	bh=m5PUaKW2ELuXjAB5HMyT7Pt2piju5d6Nl7Y/GXiNhqQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eoyXZrNL15fuyypA9PLe4Em7puxah08XylbUchS1Vtk6AoiqmROrHyjcC1T0dh72gg7jZ6L+7RqLvQiiQavBxHiGnbKJQUTIy3+ukgEIiXiYBbrDT4BokZ713X8RmLmtzF64tyXaarhtcjsGPBaP8YnJN64Zt2/01cST9ei0kzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aFjCTQzF; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726711193;
	bh=xf/mEOumj8cpcGVjlVEJWxcLHn9GgqGfR5C96mEP2rA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aFjCTQzFIekzTuYw7VbNuDar0cAssOmRJigdJCAOtgRn/9RPVMxjBnqwfTWx0iwBg
	 hfrTFIbV2Q/RWP6iEigFAQ1vLdSVrd9bvh/EBksd56JmeXNFS4Ih6ctmYgCiaTw7mU
	 5lWSy72sySrU/nsIBywD8VfTvJ44ZM+OAPK5mG0Y49VJZiyRsC/DLBtzoNKnZblSyN
	 nexqn7PAbBKPpn/l0lCv6ecVupnQJY1z7l0FSSnlqvfDQY3hidqnHXDh0L0gBfdNdh
	 SUBgVR1kykw3g9KuJ4MM4wEBrHSlMgY9lRsqf/jkkfmO8us8i/4jCC7L/jkDqMjR4h
	 dlm2gsiJzwH5Q==
Received: from [127.0.1.1] (ppp118-210-188-185.adl-adc-lon-bras34.tpg.internode.on.net [118.210.188.185])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2583C65027;
	Thu, 19 Sep 2024 09:59:52 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: patrick@stwcx.xyz, Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
Subject: Re: [PATCH v1 0/2] Yosemite4: Add devices on I2C buses to server
 boards
Message-Id: <172671119203.649222.5621392370744640415.b4-ty@codeconstruct.com.au>
Date: Thu, 19 Sep 2024 11:29:52 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Tue, 10 Sep 2024 13:47:49 +0800, Delphine CC Chiu wrote:
> Changelog:
>   - v1
>     - Revise to use adm1281 on Medusa board.
>     - Add gpio pca9506 for CPLD I/O expander.
> 
> Ricky CX Wu (2):
>   ARM: dts: aspeed: yosemite4: Revise to use adm1281 on Medusa board
>   ARM: dts: aspeed: yosemite4: Add gpio pca9506 for CPLD IOE
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

[1/2] ARM: dts: aspeed: yosemite4: Revise to use adm1281 on Medusa board
      commit: 4c417a6b31471da78b87f9e542f285e2225744e0
[2/2] ARM: dts: aspeed: yosemite4: Add gpio pca9506 for CPLD IOE
      commit: 00f897797acf562bcbda20d8ca93f279a0c6bb5b

--
Andrew Jeffery <andrew@codeconstruct.com.au>


