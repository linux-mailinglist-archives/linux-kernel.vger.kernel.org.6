Return-Path: <linux-kernel+bounces-525108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C2BA3EAE4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8C642282C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486461D514C;
	Fri, 21 Feb 2025 02:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bS3XDmJS"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E917A442F;
	Fri, 21 Feb 2025 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740106244; cv=none; b=BE0eu79AARy6CRkRGn5btoYgdyvKmsLQninmn5g0Va6j10AdSUZi9l1vKQ9KGuUb5NPVu7uyCiLfYiZkw9mCTV2IJnAYI3noteQActyeZ4bCFsFWPOHDpGB+cgPmCYNU3/G8cRVIIaFfq3l71RKEpRiTGs5xcCoahOCmcjwCZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740106244; c=relaxed/simple;
	bh=UnJlIFv0UPUzNd+Vm3edQcV3c4YlHIanESgLP3djvo0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XhpBAnfagB6CNJYk+rW2BtXsBvsJsSdetbB4UK2LyGaQSypv6Iql4o5BcmSfbJUtjQdvAC0f699hEKFWYRTyM8x6Pxc/BgpuUzhWKLvmEC+qH8ifD5p9iPlfSxEDpC74Yf+fwmEvvNmgnyRVBx3RSWh2QxvdLR/R7aKgWk6qNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bS3XDmJS; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1740106233;
	bh=UnJlIFv0UPUzNd+Vm3edQcV3c4YlHIanESgLP3djvo0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bS3XDmJSaRwxBcjtYnMTwIb+H/BxFKEtm3Pk7VaDsbV19owr6Q+j1opLuCdtqhQjD
	 6+dx3TMF4X+YLGT3ur3e/AynpgFoaPBP+vI223VEgbjjCuBxhzUe2/vHDgY8UUS0cH
	 tpBvqc2ZQBtmnsdWHuqYkOS0I56/E++xdqSsN1+TrdBmEqzThNE3Mt9bOaUCZdn5W/
	 WdhUezPTM4PI7OoUGenB05aasczV9qn3O4nKodwZiLdtHvP0rDpANhShljodZzXkja
	 OkbLOh5h3ULoqcIbv8eNIuBjrOS2om0ynANUpLZCNQDTt2xg1fj4v7QJ7m0hoFy9Ec
	 7ljKn+ys0IO6Q==
Received: from [192.168.53.88] (ppp118-210-81-188.adl-adc-lon-bras32.tpg.internode.on.net [118.210.81.188])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 59BAE76B4D;
	Fri, 21 Feb 2025 10:50:29 +0800 (AWST)
Message-ID: <eec1e53185baeed99e5e0c86875f121ab4d25fd1.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5] ARM: dts: aspeed: yosemite4: add I3C config in DTS
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 21 Feb 2025 13:20:28 +1030
In-Reply-To: <20250220023233.1686419-1-delphine_cc_chiu@wiwynn.com>
References: <20250220023233.1686419-1-delphine_cc_chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Thu, 2025-02-20 at 10:32 +0800, Delphine CC Chiu wrote:
> From: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>

Typically git's user.name config should reflect your well-known name
(with spaces between your individual names, and without e.g. a -wiwynn
suffix).

>=20
> Set I3C config in yosemite4 DTS.
>=20
> Test plan:
> Tested PLDM GetTID successfully with the I3C hub driver.

How was this successful? Your patch fails to build on top of v6.14-rc1.

Please make sure you're testing against an upstream kernel tree.

Andrew

