Return-Path: <linux-kernel+bounces-417633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 233EF9D56EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A1F1B223B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5177F8C1E;
	Fri, 22 Nov 2024 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="RU73TvfE"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6324017C;
	Fri, 22 Nov 2024 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732236852; cv=none; b=r2cMC9cOsgJ76lq/3zwMb0r1IOWBLE93SaS7vaxWRRj6VWHCUZWtYPgiwXtCCv1eqy+hDJ9GPRVC2DKPMMrb3P0u1qBsDQQ9ZxnuqHJo/MQTQnME7nksgA++42RFIbhH6nsX6L7emwWHEUes/Y7HAx6ox4fIgLJE+nGlCV33iDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732236852; c=relaxed/simple;
	bh=hlVkkw43yi/eW1WmvDZoWjdSjQP+LwaURgWmtZGcsUc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=olF9FwWyDHrdGyz07qerXxs3lII+00kkeKiNN9Fogi8GZM5BC7NLZMvOO9kKafJDB3MyX2KV6/0eY7mcu8Up0Xi9NiDDssanlE8Nq7WO3i25wQ6W3bdeyBnYdyrj+ZJA3OX7VZEUFNV+TSRuZiyOV9ajzovPNe46aW51iNRQAjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RU73TvfE; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1732236841;
	bh=T1I+8cWLkRZIi/BV4IKPI5W32DddwVLd1vKWfehM2gA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RU73TvfE9jQCiayiefvYQq6OgCagPxOTLZXEkNDt96tKd0KZJIgesMdZGbaWIQFUZ
	 9skdEkbMBUInwC+EaFpWF9P40wZD4j8D2Co3U2vvENhpb+kOYeSb5GOA8HQqcDC9Ts
	 pmZhr41GyJH6WlZlalhT59KnweAlhD6WT8ZLmBdipsSiJToUtsDysu0GUoXhyGq/36
	 huXQipJhSIt46ScYrAamK9JGD41x4gWu+T4TPPqwQsDZN2r/FItXuDOlu2dI+znp5b
	 nGpgLY8Ra+nw6nGiYNCwbj29EjuiiYS+kCY8Z1LlAmxZwy8fob0ixrWiY0ekT1eQ9H
	 5npHOCCECq7YA==
Received: from [127.0.1.1] (ppp118-210-73-187.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.187])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9EF3068F88;
	Fri, 22 Nov 2024 08:53:58 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>, Potin Lai <potin.lai.pt@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>
In-Reply-To: <20241121-catalina-dts-20241120-v1-0-e4212502624b@gmail.com>
References: <20241121-catalina-dts-20241120-v1-0-e4212502624b@gmail.com>
Subject: Re: [PATCH 0/2] ARM: dts: aspeed: catalina: revise catalina dts
 file
Message-Id: <173223683845.339623.11713825079934765892.b4-ty@codeconstruct.com.au>
Date: Fri, 22 Nov 2024 11:23:58 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Thu, 21 Nov 2024 12:34:03 +0800, Potin Lai wrote:
> Add following patches to fix issues.
> - revise ltc4287 shunt-resistor value
> - remove interrupt of GPIOB4 form all IOEXP
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


