Return-Path: <linux-kernel+bounces-277326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F6E949F46
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B54B25184
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E13D194A49;
	Wed,  7 Aug 2024 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yDnYgMmf"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E8194124;
	Wed,  7 Aug 2024 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009374; cv=none; b=VXCYjZAif+lVx23vTSz0or8NxbRQ+cTDUN7aNLPrlOwMGyaQGn1JB/qsnCGw9ohZNk8RQLW9jTiNVTsufsjW8kCxYo2pWagjiyd/+VhLLY4bpUHowoNavuSAS3R0lkctJZzpoRHzRJCK1ND+ITr14NwOObufrnK1okdIVcPrG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009374; c=relaxed/simple;
	bh=8ceZ/gjp99Gn2ReZrP5n1e6TqhjqXr8pPQAmOwfo2+o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2mP0RS6y6DtiFe10FEPeorg6WHA4w52AWrhR6Ip6IOvUT34v6dsWaFrv+dB1kZxIi5XyGdJ9M9XmXCq6qncXvuq/esj4JxuX3zy7Wgsg/k9Z1j6GF361vatHeENQg0EPfVSHjc5UPS59SLEkOgC3tUJA3+t/lYDzwCmCONVd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yDnYgMmf; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4775gjAc113409;
	Wed, 7 Aug 2024 00:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723009365;
	bh=touyr6w7+hEqxR4kfJtt19bFm30aXZBbAZgaNwWFKIk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=yDnYgMmfftQ5UmbCnVnz0EDlBGTBCnnPx393qIO9jWaAx2oDYOReD1yIg961QGHlX
	 o6wo5TNhMdL0iKnv5GexIsCiWC/n/yMJjGfrC8gBM1zZtSBGxpZSGEy8InRA8KqSp0
	 49M7F92vQxAWcaeMtq8iZjVGRPQgSDk2QXxA3fPc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4775gj2A020883
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 00:42:45 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 00:42:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 00:42:44 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4775giF2044533;
	Wed, 7 Aug 2024 00:42:44 -0500
Date: Wed, 7 Aug 2024 11:12:43 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Aniket Limaye
	<a-limaye@ti.com>,
        Udit Kumar <u-kumar1@ti.com>, Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-j721s2*: Add bootph-*
 properties
Message-ID: <20240807054243.pvfgexgusahe7d4x@uda0497581>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-1-9bc2eccb6952@ti.com>
 <bcd96f9f-54bd-4793-b9f1-04a011f2df82@ti.com>
 <20240806150700.uw4xdanjr4ypdvm3@rasping>
 <20240807052628.jclbmw4zs72jm6km@uda0497581>
 <8a910e2f-aaf2-40cd-8131-a1a2531a12c8@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8a910e2f-aaf2-40cd-8131-a1a2531a12c8@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Neha,

On 11:03-20240807, Neha Malcom Francis wrote:
> Hi Manorit
> 
> On 07/08/24 10:56, Manorit Chawdhry wrote:
> > Hi Nishanth,
> > 
> > On 10:07-20240806, Nishanth Menon wrote:
> > > On 09:43-20240806, Andrew Davis wrote:
> > > > On 7/30/24 4:53 AM, Manorit Chawdhry wrote:
> > > > > Adds bootph-* properties to the leaf nodes to enable U-boot to
> > > > > utilise them.
> > > > 
> > > > U-Boot? Let's try to pretend like this is a generic property and
> > > > just say "bootloader" :)
> > > > > @@ -445,6 +446,7 @@ flash@0 {
> > > > >    		cdns,tchsh-ns = <60>;
> > > > >    		cdns,tslch-ns = <60>;
> > > > >    		cdns,read-delay = <4>;
> > > > > +		bootph-all;
> > > 
> > > Here and elsewhere, follow:
> > > 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117
> > 
> > Could you tell me what are you seeing wrong? The dts-coding-style that
> > you shared doesn't tell a specific location for bootph-* properties so
> > using the generic reasoning.
> > 
> > "1. Most important properties start the node: compatible then bus addressing to
> >     match unit address."
> > 
> > This is the least important property considering Linux and hence the
> > reasoning was that it should come in the last. Also, j722s and am62p
> > follow the same convention so it was taken from there only.
> > 
> 
> Not sure if this is what he meant, but bootph-* comes under standard/common
> properties as per my understanding of the coding style. And status needs to
> be at the very end if it's there (in this case it's not but just
> mentioning).

I see status property being at the top of many nodes so I don't think
it's even followed right now, with that reasoning, I don't think I can
use that point for ordering the dt nodes. If it's under common nodes
then also I think it's in the appropriate location considering that even
in those properties it is the least important and should be coming in
the last. If you see any problem with this node then please let me know
in the ordering.

Regards,
Manorit

> 
> > Regards,
> > Manorit
> > 
> > > 
> > > 
> > > > >    	};
> > > > >    };
> > > > > 
> > > 
> > > -- 
> > > Regards,
> > > Nishanth Menon
> > > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
> 
> -- 
> Thanking You
> Neha Malcom Francis

