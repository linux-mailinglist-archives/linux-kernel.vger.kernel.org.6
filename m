Return-Path: <linux-kernel+bounces-277378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3AC949FDC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99BD1F2547D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06111B5827;
	Wed,  7 Aug 2024 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o1bo9asw"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039731B580E;
	Wed,  7 Aug 2024 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012596; cv=none; b=cfjhM5A8+MpgiD/FlbeN1UpILf6X63jUr85NVUG8NVV3zqWa/jo4ayKXx6k2xFXvR71HsG41TXveJW33xTLdprPPXQKcOc6afVC0J/JvfNtzHio3pScnEd0AKkxo+twGevgETya/FHKtvfmCGl3cmwbe3+hJyKHol6oby4Q89lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012596; c=relaxed/simple;
	bh=BZ9EEYf4/JpyzEUJvvTn5XxxhCRSJWb6vTlkcEwGozk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBj+dRRgbowwO8USOnPdPdbhqmGCEocpcTaRQLfPYFlzm8DW2r+Ph/qYpCAjVSJqSSXBCVAerpnrdrtIN+pHrDwy+wjR0Vz4ZHB8hwabjyOh2sa2/pXgR9creiPQX7leqtcVJDR7tGWI77CuIg5GdkhTORJv5Te51EbNWYPD2+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o1bo9asw; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4776aPtZ076351;
	Wed, 7 Aug 2024 01:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723012585;
	bh=NYOUvNL28MDZaplHBKbgF2BERm6XJm20bsmlHiQb8fw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=o1bo9aswAF20AJkU6Bq56HnhE6Ui6YRri9ftRCAItHcfr4JhZRe8FD/Z4FJWSEUUv
	 bnzTx0oKsCBN683wsSVILiNCkURJiWZPDouGZA98SMkXsgWKBW/taba/uZ/X64r/yk
	 pDVzy5e+GgMlne6AS9+0vOyKayobCNVw2a8zPMVQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4776aPbW032268
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 01:36:25 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 01:36:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 01:36:25 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4776aOGn125324;
	Wed, 7 Aug 2024 01:36:25 -0500
Date: Wed, 7 Aug 2024 12:06:24 +0530
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
Message-ID: <20240807063624.2pmqr5t7qx6elk5j@uda0497581>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-1-9bc2eccb6952@ti.com>
 <bcd96f9f-54bd-4793-b9f1-04a011f2df82@ti.com>
 <20240806150700.uw4xdanjr4ypdvm3@rasping>
 <20240807052628.jclbmw4zs72jm6km@uda0497581>
 <8a910e2f-aaf2-40cd-8131-a1a2531a12c8@ti.com>
 <20240807054243.pvfgexgusahe7d4x@uda0497581>
 <99da73bf-87a1-4402-9008-3d9076074d14@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <99da73bf-87a1-4402-9008-3d9076074d14@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Neha,

On 11:18-20240807, Neha Malcom Francis wrote:
> 
> 
> On 07/08/24 11:12, Manorit Chawdhry wrote:
> > Hi Neha,
> > 
> > On 11:03-20240807, Neha Malcom Francis wrote:
> > > Hi Manorit
> > > 
> > > On 07/08/24 10:56, Manorit Chawdhry wrote:
> > > > Hi Nishanth,
> > > > 
> > > > On 10:07-20240806, Nishanth Menon wrote:
> > > > > On 09:43-20240806, Andrew Davis wrote:
> > > > > > On 7/30/24 4:53 AM, Manorit Chawdhry wrote:
> > > > > > > Adds bootph-* properties to the leaf nodes to enable U-boot to
> > > > > > > utilise them.
> > > > > > 
> > > > > > U-Boot? Let's try to pretend like this is a generic property and
> > > > > > just say "bootloader" :)
> > > > > > > @@ -445,6 +446,7 @@ flash@0 {
> > > > > > >     		cdns,tchsh-ns = <60>;
> > > > > > >     		cdns,tslch-ns = <60>;
> > > > > > >     		cdns,read-delay = <4>;
> > > > > > > +		bootph-all;
> > > > > 
> > > > > Here and elsewhere, follow:
> > > > > 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117
> > > > 
> > > > Could you tell me what are you seeing wrong? The dts-coding-style that
> > > > you shared doesn't tell a specific location for bootph-* properties so
> > > > using the generic reasoning.
> > > > 
> > > > "1. Most important properties start the node: compatible then bus addressing to
> > > >      match unit address."
> > > > 
> > > > This is the least important property considering Linux and hence the
> > > > reasoning was that it should come in the last. Also, j722s and am62p
> > > > follow the same convention so it was taken from there only.
> > > > 
> > > 
> > > Not sure if this is what he meant, but bootph-* comes under standard/common
> > > properties as per my understanding of the coding style. And status needs to
> > > be at the very end if it's there (in this case it's not but just
> > > mentioning).
> > 
> > I see status property being at the top of many nodes so I don't think
> > it's even followed right now, with that reasoning, I don't think I can
> > use that point for ordering the dt nodes. If it's under common nodes
> > then also I think it's in the appropriate location considering that even
> > in those properties it is the least important and should be coming in
> > the last. If you see any problem with this node then please let me know
> > in the ordering.
> > 
> 
> Aren't cdns,-* vendor specific properties?
> 
> Also I understand that most DTS aren't following majority of the rules, but
> considering it was a review comment I assume they want a check on what goes
> in at least so I've mentioned what I think they're asking for.

I can fix it in places where it can be fixed ( I see few places where
order exist ) but where there is no order there this will be difficult
to handle. That'd require a total fix for ordering across all the places
and that will require a separate cleanup ig. So if people are okay, in
those places I'll be keeping bootph-* in the last like how it's followed
in right now.

Regards,
Manorit

> 
> > Regards,
> > Manorit
> > 
> > > 
> > > > Regards,
> > > > Manorit
> > > > 
> > > > > 
> > > > > 
> > > > > > >     	};
> > > > > > >     };
> > > > > > > 
> > > > > 
> > > > > -- 
> > > > > Regards,
> > > > > Nishanth Menon
> > > > > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
> > > 
> > > -- 
> > > Thanking You
> > > Neha Malcom Francis
> 
> -- 
> Thanking You
> Neha Malcom Francis

