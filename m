Return-Path: <linux-kernel+bounces-303623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8B49611BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92866280C14
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6575B1BC9E3;
	Tue, 27 Aug 2024 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="juFlXAHp"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48381BC073;
	Tue, 27 Aug 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772161; cv=none; b=Gx+7Nxxg+l21DrXoMtnijzLYmTqAkMuqQ8Eo/WfW6m63u2sSWzo81usDSOaqiktrvt47/vf31VCK4XRZuddqG7aX1JbkO8mpj5sf8W99dtLnIGfDLa936EPKsmrCIvAp00cRTbbgGdQLUYMLiubQ2PFwz8cniN9SaeD9YMK92Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772161; c=relaxed/simple;
	bh=FTAaRDrAktlQbof46vd1YzSU/GPPobUGQX7/r/ZL9BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fG+iEvgMjkdRi+LYMq4VllasNNO6JYBF++/EvtJ3FJeXHBIxVtO+QzwgQ0oNopvL/ySDdEgppdxYS5D8JunD5SpVLDf6P+OkUfwlthpsmgkOVU7CZbPoSgEz+l29MOKV8vSbslArrA9CWAad+qDnky29WvzG6+qLMZn+Iy3DcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=juFlXAHp; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47RFMJ6m084297;
	Tue, 27 Aug 2024 10:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724772139;
	bh=plRvOJkmnI84SapBQUzX8HSqk48OkCc/MtkTYAImTtM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=juFlXAHpacIzsq2qvRlzLwmzDvCsRAVnjSMbmlSD8E1B2ixd5OgOd9cauYUGFDjXC
	 lJba3d33PF5Vb9SbGwgPyjQxAgJ5IwnPrn7jR7MbA8t2nizNRPLnruuV8KG/B4MWyI
	 Rp6UqE/Kf6ur5ghORRbx0NoKdr2ofZWw8a4XXnHw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47RFMJiN015911
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 10:22:19 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 10:22:19 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 10:22:19 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47RFMI95098754;
	Tue, 27 Aug 2024 10:22:18 -0500
Message-ID: <b18cb162-e95c-4927-8fa7-1c29b8dda1a7@ti.com>
Date: Tue, 27 Aug 2024 10:22:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] Add generic Overlay for Grove Sunlight Sensor
To: Ayush Singh <ayush@beagleboard.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Derek
 Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>, Arnd
 Bergmann <arnd@arndb.de>,
        Michael Walle <mwalle@kernel.org>,
        Jason Kridner
	<jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Ayush Singh
	<ayushdevel1325@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240702164403.29067-1-afd@ti.com>
 <28513e07-ab56-4cff-972c-64c2e3d6d9e2@beagleboard.org>
 <cb8af9ed-6200-428a-a9a8-87356af6e37d@ti.com>
 <eab183e7-8e70-42af-8786-a8e7b29b72c8@beagleboard.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <eab183e7-8e70-42af-8786-a8e7b29b72c8@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 8/27/24 8:20 AM, Ayush Singh wrote:
>> Sorry, no I've not had time to circle back to this for the last couple weeks,
>> and don't expect to be able to for a couple more :(
> 
> Np, I will see what I can do.
> 
> 
>>
>> The two parts I see that are missing are:
>>
>> 1) The /append-property/ tag [0].
> 
> So how do you envision it? Maybe something like the following:
> 
> Base:
> 
> / {
> 
>      node {
> 
>          prop = <0x00>;
> 
>      };
> 
> };
> 
> 
> Overlay:
> 
> &node {
> 
>      /append-property/ prop;
> 
>      prop = <0x01>;
> 
> };
> 
> 
> Or would it be better to append 1 element at a time, as follows:
> 
> &node {
> 
>      /append-property/ prop 0x01;
> 
> };
> 

Does

/append-property/ prop = <0x01 0x02 0x03>;

work? We will want to be able to append lists. Some type
checking will be needed, but shouldn't be too bad.

Probably good to get input from the DT folks which syntax
looks best to them.

> 
>>
>> 2) Allowing the __symbols__ table properties to be phandles, not just
>> full path strings.
>>
>> For item 2, this will make the "adapter overlays" look much nicer, but
>> more importantly allow chaining together adapters more easily.
>>
>> Both these changes will need to be made in the DTC project, then
>> moved back into kernel. Neither change breaks any existing compatibility
>> so I don't expect much resistance there. It just takes some time
>> to get changes in, then have them migrated to a kernel release before
>> we can make use of them.
>>
>> If you want to help with either of those two items (I can provide more
>> details if needed), that could help keep this moving along. :)
>>
>> Thanks,
>> Andrew
>>
>> [0] https://lkml.org/lkml/2024/7/5/311
> 
> 
> I am in the process of understanding the dtc codebase. Will send patches to device-tree mailing list since that seems to be easier to keep track of with the Linux patches instead of GitHub PRs.
> 

IIRC they have a dedicated mailing list for DTC,

devicetree-compiler@vger.kernel.org

Andrew

> 
> Ayush Singh
> 
> 

