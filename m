Return-Path: <linux-kernel+bounces-525110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38DFA3EAEC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736CE19C5DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09E91D63C7;
	Fri, 21 Feb 2025 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="heDSOgdi"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9A517A2E2;
	Fri, 21 Feb 2025 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740106321; cv=none; b=XF1LBi2k540agwFneqWJXEvzZIxkYIIO9NOErsx4GnXSLfoOFfueoB09JoKCqYtPRSCn/KnFzX4V57kh9wYp9/MoTQ0H/gHYAQUBtb/hYbO9+n4GOt1rp3TbSdBy1iY+b4sTuneJun57Kn9jJiib0EWKYqVqH7mZBzKbrRejf74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740106321; c=relaxed/simple;
	bh=UnJlIFv0UPUzNd+Vm3edQcV3c4YlHIanESgLP3djvo0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DRd7HT12BMi4PxendIjXK3rY/SvkqYH8N3hznPyxlo9xHlIq3uio9YDrawhsmIhQU5cy5bT3nL7Ax6b/fnaE9EiMxXEH52w7IetqivJ5vfyzPOBBlaxozjQHpyWgqz6+A1/SGv3Mxpru9ArZig03L+jafG6exHIC4qreWwWDHCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=heDSOgdi; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1740106316;
	bh=UnJlIFv0UPUzNd+Vm3edQcV3c4YlHIanESgLP3djvo0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=heDSOgdi2Y2Q3C6UtY3/RAZCOylprvSdvWWTv++IwVftSMht359YMj0lw/EZgpu5q
	 SpjrKtHOF5jhW2BZRvEk9FFYcfAgB0BDK6dLYghRL1inDTJgKq51bYpQ4hpPiAjlXI
	 7Cr44g/wIl3uA5GQWTw3TudE8FTG5WKmqTb/mR1v3POlp11pORfFNcSOxqKkvuAYUh
	 SqHMdAy49SJsvStLIiLOSagIrA4IWXlWQE1i3R6mQljqEJWI9HG5DR/DOSCuJhkSNI
	 NLS7xNtFlR9QOlehyStYuHx3maYm0TBdxYzLjbfLTZfbWowRjVSBvKATI7eoPpSZrU
	 EKPeciMa5yRBA==
Received: from [192.168.53.88] (ppp118-210-81-188.adl-adc-lon-bras32.tpg.internode.on.net [118.210.81.188])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0E0C276B4D;
	Fri, 21 Feb 2025 10:51:54 +0800 (AWST)
Message-ID: <a8fec7b5a84cee03602d4bca6c3a12d81fb141f4.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5] ARM: dts: aspeed: yosemite4: add I3C config in DTS
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 21 Feb 2025 13:21:54 +1030
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

