Return-Path: <linux-kernel+bounces-346868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B8B98CA06
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857711F231E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B2217D2;
	Wed,  2 Oct 2024 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="FlwVgpGC"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081841854;
	Wed,  2 Oct 2024 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727828813; cv=none; b=I+1eVjnwoQ5/GoMd/pdAD53sDuHk3+lJYUaQXotelBe9pV2xoz47gLJPc3+t9vVPJAUWaNojGOHQKM+dJoaW4F+Bp+l/zuQpzz4+6v1OceI5s7qQ6/m1Q7eyERLAdSby9tJ2WMuYtApze+1oRCaebOB8d2B4YWMPI1Xs6kqukds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727828813; c=relaxed/simple;
	bh=d1HotEFnVry+mOU3VGbaWefsXTpKheCrdqtp4TOraDQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GrmLUSNiClA9X0sgZ85Qq5E5Q69+jflYpxAAiTHuPzuSyI0RWW0KzQjM9IpMgOhJYC384VYRXESiAuaEqcYo7IJPRdqUfpub8+Qlrr0+cmTxHEV7h/V09V2DkqCxVY9Zyg/IKAPSDK9B8oLZk+zSls+Qq/OJsR+gHJSAz8JJFXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=FlwVgpGC; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727828808;
	bh=KjLbqCF2jq6cvivJ349ACXivUXPIkq508H08HywwaHQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FlwVgpGCaV+Num08HCUA4wxbUH/Hk34Nc+nF5LRT0Xb2fDt3fzkSnSx/cyr01uRPO
	 H7lqvI1jFZKGDFOROblf7oHOLTJSJLTKg4wA6y+0nIDaq3gC66oaNyD/hhbnUTGRyA
	 oOnQrC5KKuBJE+iWiaYaM1Gyb8DFEMelup1Rv8iOBylKFT6m1qwAOsiockswszbgaS
	 YsSMmOyS8ABUHz4ohf9n4UqZx3HUzz5TmSFq17DIQ5SXY0RyZICrNTuJz5rcDQmEHc
	 DOSVywg3+Fmxjaq3ByVTwkRP5BKi22Funetag2q5KLEaCrddkA9e7TiRiAzYtj9Abe
	 Vb7/DguZly2Bw==
Received: from [127.0.1.1] (ppp118-210-73-17.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.17])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E3BA465013;
	Wed,  2 Oct 2024 08:26:46 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joel@jms.id.au, eajames@linux.ibm.com, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241001191756.234096-1-ninad@linux.ibm.com>
References: <20241001191756.234096-1-ninad@linux.ibm.com>
Subject: Re: [PATCH v1 0/3] Device tree changes for system1 BMC
Message-Id: <172782880678.751051.14871757116202304815.b4-ty@codeconstruct.com.au>
Date: Wed, 02 Oct 2024 09:56:46 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Tue, 01 Oct 2024 14:17:47 -0500, Ninad Palsule wrote:
> Please review the device tree changes for BMC for system1 machine.
> 
> Ninad Palsule (3):
>   ARM: dts: aspeed: system1: Bump up i2c busses freq
>   ARM: dts: aspeed: system1: Enable serial gpio0
>   ARM: dts: aspeed: system1: Add GPIO line names
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


