Return-Path: <linux-kernel+bounces-195404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03138D4C48
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A46EEB22792
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC42A183072;
	Thu, 30 May 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0OOtwVHB"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CBB17C9ED;
	Thu, 30 May 2024 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074433; cv=none; b=R0nZE570zG+Gy3X/kVJ5/PFPm8Z9nE2m+5urSV0rILuvUmMlTn/y06KzDBYa9918ZoFo8UgNWWIZPf5v+vcGtLYQOcrLYVQo0O5QXzdh+PkvUUKpMUmmaIndQpruNRXTR6I5GReGM/xqW3i80/3IBLBrQXDV/FBzPnSYZID7oDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074433; c=relaxed/simple;
	bh=gzsjYTP3/WlWKHVnMyU/5TNINiOjsAjfhSkIRf8Yo7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9tWQMFG/VyjKnwsQNvcna35lB+dPNJ7k0bDEYg/TaKH2o+/e1mjXCAiKZTpRopUVdxlnLBCUIAn5B/t/dNmPCJmAnVzJLaK2/NWf7/h1qXOLBRaRKPndF3VyZXeepbqbKgT7NgiJeXHLA/jO2UAgU/b+phW96y2ARdmXibtSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0OOtwVHB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=laI44R9CkvkoWL5j55C7oR7usS/DpKOSclK7hV4WnUk=; b=0OOtwVHBs60a+zPox/sQdd+j7R
	4bmjQkip08Y8wnmyY0Tv1JWfy6VONeDDGxl9RQuZzxekHgjLXZ/SAZY65R0/D0rdvoNud2G/eOYNA
	nSOfKWU6wfi0ZPgrrNzM1W8NZku2IaiNbGk4OfSMlDlhRKcUnKPKTAQHOcajzcV8CcGs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sCfUb-00GLeo-8d; Thu, 30 May 2024 15:06:53 +0200
Date: Thu, 30 May 2024 15:06:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>
Cc: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
	"Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
	"Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"Thorsten.Kummermehr@microchip.com" <Thorsten.Kummermehr@microchip.com>,
	"Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>,
	"benjamin.bigler@bernformulastudent.ch" <benjamin.bigler@bernformulastudent.ch>,
	Viliam Vozar <Viliam.Vozar@onsemi.com>,
	Arndt Schuebel <Arndt.Schuebel@onsemi.com>
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <70cf84d1-99ad-4c30-9811-f796f21e6391@lunn.ch>
References: <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>
 <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
 <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
 <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>

On Thu, May 30, 2024 at 09:43:56AM +0000, Piergiorgio Beruto wrote:
> Hello Andrew,
> 
> I was reading back into the MACPHY specifications in OPEN Alliance, and it seems like MMS 10 to MMS 15 are actually allowed as vendor specific registers. See page 50.
> The specifications further say that vendor specific registers of the PHY that would normally be in MMD30-31 (ie, excluding the PLCA registers and the other OPEN standard registers) would go into MMS10 to MMS15.
> 
> So I'm wondering, why is it bad to have vendor specific registers into MMD10 to MMD15?
> I think the framework should allow non-standard stuff to be mapped into these, no?

From an architecture perspicuity, PHY vendor specific registers should
be in the PHY register address space. MAC vendor specific registers
should be in the MAC register address space.

It seems like the Microchip device has some PHY vendor specific
registers in the MAC address space. That is bad.

Both your and Microchip device is a single piece of silicon. But i
doubt there is anything in the standard which actually requires
this. The PHY could be discrete, on the end of an MDIO bus and an MII
bus. That is the typical design for the last 30 years, and what linux
is built around. The MAC should not assume anything about the PHY, the
PHY should not assume anything about the MAC, because they are
interchangeable.

The framework does allow you to poke any register anywhere. But i
would strongly avoid breaking the layering, it is going to cause you
long term maintenance problems, and is ugly.

	Andrew

