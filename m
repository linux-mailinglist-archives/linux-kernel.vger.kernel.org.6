Return-Path: <linux-kernel+bounces-277333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BB8949F62
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF60B23A4D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F2C197545;
	Wed,  7 Aug 2024 05:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QfDJMK27"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2AB6BFA3;
	Wed,  7 Aug 2024 05:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009792; cv=none; b=RFbNRI3o+9fuZJnS17mOpPK0OTo8UD6+oleONs4jaBZCDrar0W1cbHUFcvMj93hUp2DyoIBQ8ZTpIAAftwKWkdQS5cmxWHYnC3GFqctL/VUaUhYhIVX7tiOglhX+alM3pIQRLMMy3/pBU7j2Qd3m6BuKqnWUAlG7r2o2+maRHVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009792; c=relaxed/simple;
	bh=FHpddn2Dre2u92rA4iiaH2DthAsRJ94/WAzrQ9Onn2s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saHhtkgTmhrdb1CT3xOisrcjqyYMxjiyyGLQ5xLalWlOMfmpdrUYIFxFl2tzMLKAklQh76FusiLlYXHc8cb8zMhGca3HNXoJD9J+JFSVUmEZFuxLLg4XLPuBWGqMHML0RkBKy5VdeYG4Pan2f1Vcqqw4i+N/vQQlw4Yss11nctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QfDJMK27; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4775njVg115639;
	Wed, 7 Aug 2024 00:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723009785;
	bh=9v4SsW5LT+D9asmZl5EMLQv7Ll3Zd1TIuhJiBGmhV2I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=QfDJMK27ogEIdppwe4eFQSmJotSfkK9aWLt7FflBLDawtVWNcjoXOHc1qgSeVmqYk
	 z4WHq/XZpNIb+x1z3frUETfNEwF21v2wkpykOBTl6n7ZAv6vv723f8DOw4g85ScsnS
	 YU51Xxhbm34KFmA09rBkfTyv2NdGT4i57PSYL/us=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4775njNt024554
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 00:49:45 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 00:49:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 00:49:45 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4775niIV054740;
	Wed, 7 Aug 2024 00:49:45 -0500
Date: Wed, 7 Aug 2024 11:19:44 +0530
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
Message-ID: <20240807054944.g6xgiamjn76xlv2g@uda0497581>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-1-9bc2eccb6952@ti.com>
 <bcd96f9f-54bd-4793-b9f1-04a011f2df82@ti.com>
 <20240806150700.uw4xdanjr4ypdvm3@rasping>
 <20240807052628.jclbmw4zs72jm6km@uda0497581>
 <8a910e2f-aaf2-40cd-8131-a1a2531a12c8@ti.com>
 <20240807054243.pvfgexgusahe7d4x@uda0497581>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240807054243.pvfgexgusahe7d4x@uda0497581>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Neha,

On 11:12-20240807, Manorit Chawdhry wrote:
> Hi Neha,
> 
> On 11:03-20240807, Neha Malcom Francis wrote:
> > Hi Manorit
> > 
> > On 07/08/24 10:56, Manorit Chawdhry wrote:
> > > Hi Nishanth,
> > > 
> > > On 10:07-20240806, Nishanth Menon wrote:
> > > > On 09:43-20240806, Andrew Davis wrote:
> > > > > On 7/30/24 4:53 AM, Manorit Chawdhry wrote:
> > > > > > Adds bootph-* properties to the leaf nodes to enable U-boot to
> > > > > > utilise them.
> > > > > 
> > > > > U-Boot? Let's try to pretend like this is a generic property and
> > > > > just say "bootloader" :)
> > > > > > @@ -445,6 +446,7 @@ flash@0 {
> > > > > >    		cdns,tchsh-ns = <60>;
> > > > > >    		cdns,tslch-ns = <60>;
> > > > > >    		cdns,read-delay = <4>;
> > > > > > +		bootph-all;
> > > > 
> > > > Here and elsewhere, follow:
> > > > 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117
> > > 
> > > Could you tell me what are you seeing wrong? The dts-coding-style that
> > > you shared doesn't tell a specific location for bootph-* properties so
> > > using the generic reasoning.
> > > 
> > > "1. Most important properties start the node: compatible then bus addressing to
> > >     match unit address."
> > > 
> > > This is the least important property considering Linux and hence the
> > > reasoning was that it should come in the last. Also, j722s and am62p
> > > follow the same convention so it was taken from there only.
> > > 
> > 
> > Not sure if this is what he meant, but bootph-* comes under standard/common
> > properties as per my understanding of the coding style. And status needs to
> > be at the very end if it's there (in this case it's not but just
> > mentioning).
> 
> I see status property being at the top of many nodes so I don't think
> it's even followed right now, with that reasoning, I don't think I can
> use that point for ordering the dt nodes. If it's under common nodes
> then also I think it's in the appropriate location considering that even
> in those properties it is the least important and should be coming in
> the last. If you see any problem with this node then please let me know
> in the ordering.

Maybe I missed, cdns would be vendor property I assume, let me get
Nishanth's ack as to that is what he wants and this is indeed under
common/standard nodes then would move it to the appropriate location. 

Though again, j722s and am62p don't seem to be following this
convention so not really sure what he means actually tbh.

Regards,
Manorit

> 
> Regards,
> Manorit
> 
> > 
> > > Regards,
> > > Manorit
> > > 
> > > > 
> > > > 
> > > > > >    	};
> > > > > >    };
> > > > > > 
> > > > 
> > > > -- 
> > > > Regards,
> > > > Nishanth Menon
> > > > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
> > 
> > -- 
> > Thanking You
> > Neha Malcom Francis

