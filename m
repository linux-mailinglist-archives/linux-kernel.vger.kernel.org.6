Return-Path: <linux-kernel+bounces-277835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB9794A729
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571E328323C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57861E486A;
	Wed,  7 Aug 2024 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GVI+K5jT"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A418171E69;
	Wed,  7 Aug 2024 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031276; cv=none; b=s2LHU2UfM89HGpHsITtWKB3UnJNaRXfCpdVCvYvmqFOaxMu9jBEgnPJRdtoE/eIwq864PaX+bXv7qR3/SKE5j+3jdvDTzKQ57cQl4kKivt/uXdltjwoujgOZaLnz+dSapJ1Br+ecvDARSa2jq2YCjvwW7b9uU8lSHlvTjwMiYmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031276; c=relaxed/simple;
	bh=9ah2l3mOft7DOtFEzytv99Opoie129YPq+JSB9Blhl8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TppKwfAbZLxB2HDy0nHNkU+i6mx1BzCny/eklthu7bhKDWR6BXr0SyjSesbC5YqspqIRB7Z5NSQp7KRBEwUoPGIzHXg1XWtHgkcZJFBrSO721yjfQRKcRRrAVm6q1yRo6jwuG/B3He14uF5NGUE5mfYvURTr3mcpKPgqPhSQrqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GVI+K5jT; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477BldaN070553;
	Wed, 7 Aug 2024 06:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723031259;
	bh=KDuDkR3cT3auCGtVG7eO62xWbKsmQBAUL0KcQ/6RCEg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=GVI+K5jT4o+lzoMfz3SHmajJ4iRTzJXiDOM0ZMeKZ5iIwMe8a7inSLEptwWCq59OJ
	 rJtuozJLYMMvATQo4d5nc/vNKfmh7XR5k37kxSJmrnjIbnMqEaMgbNbX1Q4afiKW8B
	 0VBdVJd0z3S8GJM3JpJzp9jO5J0IrROGCXwuEeOc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477Bldv8058163
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 06:47:39 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 06:47:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 06:47:38 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477Blccd095790;
	Wed, 7 Aug 2024 06:47:38 -0500
Date: Wed, 7 Aug 2024 06:47:38 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-j721s2*: Add bootph-*
 properties
Message-ID: <20240807114738.tu3cmiu3mmk65g4v@phoney>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-1-9bc2eccb6952@ti.com>
 <bcd96f9f-54bd-4793-b9f1-04a011f2df82@ti.com>
 <20240806150700.uw4xdanjr4ypdvm3@rasping>
 <20240807052628.jclbmw4zs72jm6km@uda0497581>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240807052628.jclbmw4zs72jm6km@uda0497581>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:56-20240807, Manorit Chawdhry wrote:
> Hi Nishanth,
> 
> On 10:07-20240806, Nishanth Menon wrote:
> > On 09:43-20240806, Andrew Davis wrote:
> > > On 7/30/24 4:53 AM, Manorit Chawdhry wrote:
> > > > Adds bootph-* properties to the leaf nodes to enable U-boot to
> > > > utilise them.
> > > 
> > > U-Boot? Let's try to pretend like this is a generic property and
> > > just say "bootloader" :)
> > > > @@ -445,6 +446,7 @@ flash@0 {
> > > >   		cdns,tchsh-ns = <60>;
> > > >   		cdns,tslch-ns = <60>;
> > > >   		cdns,read-delay = <4>;
> > > > +		bootph-all;
> > 
> > Here and elsewhere, follow:
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117
> 
> Could you tell me what are you seeing wrong? The dts-coding-style that
> you shared doesn't tell a specific location for bootph-* properties so
> using the generic reasoning.

it falls under standard properties

> 
> "1. Most important properties start the node: compatible then bus addressing to
>    match unit address."
> 
> This is the least important property considering Linux and hence the
> reasoning was that it should come in the last. Also, j722s and am62p
> follow the same convention so it was taken from there only.

follow the order - bootph-all is before the vendor properties

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

