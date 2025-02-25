Return-Path: <linux-kernel+bounces-532683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5488A450EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C892F16B957
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2958237168;
	Tue, 25 Feb 2025 23:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="JoDWORWh"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A2A215164
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526132; cv=none; b=IoqDNQn5/nBwSLfnhhvBDgmvUE9op1ohX1k+mpYv+JTyFgMLjm70Lmj4zY3UskHG9Gk7fHqPvW0FAmttUxGukYRmid7URS6/l+o0mtOcZsQCDtN/7pAfY9lgT/4rejGWe3Xz/3IjkxTm4kQqUYg2bVe2EbjFHHpqBI/tkVOMIZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526132; c=relaxed/simple;
	bh=QSvc/XemxvspxE6At8l/Qu+fHyG/W1yOWa6QPQHBb58=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aEUcf/r9Wk3SmX5uVXIVJ7rxHCoHe4RMxqEbr6cULf2iVr+QrOOWJkIZHVWkMCrDJpd0JsCUOp0hUqHPq5AzRC56gPYnjS94rOru2X/sG37iYM3TgUdq1P7kPWPqCOcsFYVWVTi9/gzmO8NLwGnrBMPNd/F25wzLB4uwiBRWc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=JoDWORWh; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1740526128;
	bh=QSvc/XemxvspxE6At8l/Qu+fHyG/W1yOWa6QPQHBb58=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JoDWORWh5GMuHWhPpH1YC1VOcRnB6A0kfhfXPOGKob7Lozkmp3Ldds10SIb0gMhEo
	 fmHS9hlv8mpFF3iIb62peumhlZfdGhgFv3CgFEpbMtrVtyKku5LWeuo/UR2qvIQH3t
	 Z8jAT5Wcm8SyNW+trXOBYBpF6Gk+cYA+lsQkvKDh7kS53ux52/9KGCGUU/lWA4zwAr
	 8PvFv8z+MShtsR07hsYXl3OkWSbnXfFCkv3tesjsRtL2NBV8wjH2lKY37vYfVp/CYy
	 2rPbc879sPoopOr5hnt0fyzuB0ocRbNoDd1Kaut3S26MhoDuno6+T2IE5VlHCTKMzc
	 HEV5j0ycCFL5A==
Received: from [192.168.68.112] (ppp118-210-173-152.adl-adc-lon-bras34.tpg.internode.on.net [118.210.173.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1415377691;
	Wed, 26 Feb 2025 07:28:43 +0800 (AWST)
Message-ID: <0008bab55f56252016406e06f147ef52f058bb86.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Mo Elbadry <elbadrym@google.com>
Cc: Kevin Chen <kevin_chen@aspeedtech.com>, "joel@jms.id.au"
 <joel@jms.id.au>,  Z-ChiaWei Wang <chiawei_wang@aspeedtech.com>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "tomer.maimon" <tomer.maimon@nuvoton.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, "lee@kernel.org" <lee@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>,  "conor+dt@kernel.org" <conor+dt@kernel.org>, Jenmin
 Yuan <jenmin_yuan@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>
Date: Wed, 26 Feb 2025 09:58:41 +1030
In-Reply-To: <CAOO6b=udHyXx3QXyUE=siuuJopanUxzbFeBujtqWRy=j2ut4fw@mail.gmail.com>
References: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
	 <20250217114831.3225970-4-kevin_chen@aspeedtech.com>
	 <e43b5f8f-37e4-4468-b3ca-5059a5e6f3c3@kernel.org>
	 <6fd7cd57261ddf9831f57dc4c637b24e9f8982d9.camel@codeconstruct.com.au>
	 <PSAPR06MB4949C65DF5C034BD6B40C9B589FA2@PSAPR06MB4949.apcprd06.prod.outlook.com>
	 <d4945482509cad0bf3e8cd93c1fb21bac2e0c7f2.camel@codeconstruct.com.au>
	 <TY0PR06MB4960EA7255DF0BDF235F0D9689C52@TY0PR06MB4960.apcprd06.prod.outlook.com>
	 <ba2757fd02b3e7c8f9c862c76f2cfcd2b6bfb41b.camel@codeconstruct.com.au>
	 <PSAPR06MB494947E21AB39369ADFA8C9489C72@PSAPR06MB4949.apcprd06.prod.outlook.com>
	 <f7369d6205e05c7aac3f3de7cbd08c3b08960d75.camel@codeconstruct.com.au>
	 <CAOO6b=udHyXx3QXyUE=siuuJopanUxzbFeBujtqWRy=j2ut4fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Mo,

On Mon, 2025-02-24 at 20:34 -0800, Mo Elbadry wrote:
> Hi Andrew,
>=20
> I agree that a small layer of abstraction is needed to provide common
> chardev semantics to userspace. I think that effort can come where both
> Nuvoton and Aspeed unify their design and agree on a common abstraction
> layer.
>=20
> I think such efforts may take some time for both to unify, is it possible
> to get this upstreamed (after addressing all other comments) while both
> parties work on an agreed unified abstraction layer?
>=20

Given Arnd doesn't want bespoke userspace interfaces in the SoC drivers
this will need to go elsewhere, perhaps drivers/char or drivers/misc.
Greg and Arnd maintain both, so the patch needs to make a convincing
argument to them. For my part, my comments are just opinions based on
my understanding of the use-cases and the SoCs involved, and the desire
for reasonable devicetree and userspace interfaces.

I don't think it's right to try to rush things as devicetree and
userspace interfaces can be tricky to change or remove. Rushing tends
to be painful for all involved in the long run.

Cheers,

Andrew

