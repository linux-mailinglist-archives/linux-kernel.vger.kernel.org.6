Return-Path: <linux-kernel+bounces-367665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FEA9A051D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D8DB26309
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EDA205139;
	Wed, 16 Oct 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xP9UtSB9"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDEC17D378
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069936; cv=none; b=efEtRgmoCwNTwxEZRaJCKDSMFhJxYqr+pUx9GxFJZJhmrsynkvNOlVou4KnBdk8Y0I+jMqFzy7lWmbX878Dy2H+ZHVP08lPcSvQLyFKDFNsPIg719O14LqUsoGXVXDDM9qkfwn+2QCOYacYkAYmxR44nWlhTuYGEodvliXG+qRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069936; c=relaxed/simple;
	bh=uZ2WqT/KU6om0zIBPat/I+HFdeWU59uGgqv8ZntSqmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmaS1neIG41pSS3tsQ1ufFie6vC/luiC2oYHkhsi1+xzyeEz9uMV/g1D3xiQ9+v2BpFDIHXqJjVN+1/rAf8Hrg7f48tz8Wd2wpl8+uYn0vZ6HnZqfoCbdU/LUxR1for0fc3m10X+vf9DZxnBUUG/RtbcWExekT6pzLZFKk3xmDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xP9UtSB9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c87b0332cso56385ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729069934; x=1729674734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLkTQUFrbV0L+s+yopZ5QWgalT1mUxLcPDOJAGqfK1U=;
        b=xP9UtSB9WlxFFcsWWSAW5uO5MaHyjFiqtaFQ5H7IaPlVQVVoHpiJ+WyOyqyEb5/XLC
         8pS+6yfKPuXTu65fKkMOrDckRzgQ7nI8QrEYK6wR8wpTStWYSK6011IqBwLOBloGmdB7
         OBiNxpQwDALZlv4FIaKS0T+8BjnoDOADg66uKzt6M+uD6qtUqVdVGx2IW7zcVxpHhqzK
         IcsZ3SkoA9aScUuZJ6OPFK3R9sE5SFoSPFQMBlCSHIbUnrjRgNEVO1ZKvS1UeN9yjA8+
         O+DR0FmiMi/R4MwS29WyLfOWesJxGuZZDRTlf8UDgcBlWHX1ImJeHU4qz84/xOoICrLZ
         DNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729069934; x=1729674734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLkTQUFrbV0L+s+yopZ5QWgalT1mUxLcPDOJAGqfK1U=;
        b=u4bMOhCfAgJXgfMH9C13W1MgVWJIhGS/I6xnb0gBxBhC5llaEFzimIovu1xMu7Uy8h
         XW/bfPk5dpQ/sAByh64Y/BfOAVHbi+YkfNl1zFYh7bR81Apqsaqj53wHh8sTfgBbDpS2
         5tczqC9My5lo1g4vwGe54DhBZqJyP9ZlLAvoGo5ljKF2+qx9L5V6r1WVrAlQoODeWAnM
         SXRSQ410G0JqZZeq0xtxnu4tCp/+ZuK2QbXuudsU1RES9yVHF+Btd/0Fq0kZOhdnUpBd
         376guyrhcFdbQmOlgkyK8Wh8MOLkMsMu766fZTKgdO8UJl6MNYl/ASdaGZpw+9YlcUq7
         zxxA==
X-Forwarded-Encrypted: i=1; AJvYcCXLHnDwoUc8+/hHCBnTZP0t7Q1sFvZZ9COzs+byykVgeb5pd94tcZMxg2uPy+eeJTteVJUVNVyzbzJAdIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCxN+Kya0LZNKppqrsJEhfc7bzBRMbNh06y3i4yK0jD/q1Ap7a
	hV3SU2aw72NEs/YYiEPg/xwMqHbxqRZrUxHjeRonNGDCPSOGmFyK35oC2euQ9A==
X-Google-Smtp-Source: AGHT+IEpTuQgMKOjhldOXk/x3cs8GKdyYNhDHrou3DsiJAjDnoKoSf3rkJhlsq9S8AmWVWRj8pqwWg==
X-Received: by 2002:a17:902:f552:b0:1f7:34e4:ebc1 with SMTP id d9443c01a7336-20d30021470mr1371165ad.5.1729069933995;
        Wed, 16 Oct 2024 02:12:13 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f85455sm24836315ad.51.2024.10.16.02.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:12:13 -0700 (PDT)
Date: Wed, 16 Oct 2024 09:12:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
Message-ID: <Zw-DZF4B4psiat59@google.com>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <20241015-smmuv3-v1-2-e4b9ed1b5501@nxp.com>
 <Zw4kKDFOcXEC78mb@google.com>
 <20241015124723.GI1825128@ziepe.ca>
 <ab21d602-5349-47be-b346-2fbc041fa13e@arm.com>
 <20241015153110.GM1825128@ziepe.ca>
 <ce7cc76f-426f-4d19-b4be-3964647a2f2d@arm.com>
 <Zw6UCLprZj6aaajY@google.com>
 <PAXPR04MB8459EC5B8A55E7FF10E550AC88462@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459EC5B8A55E7FF10E550AC88462@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Wed, Oct 16, 2024 at 09:02:39AM +0000, Peng Fan wrote:
> All,
> 
> > Subject: Re: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for
> > NXP i.MX95
> 
> Thanks for the discussion on this topic to show much information
> that I not foresee.
> 
> > 
> > On Tue, Oct 15, 2024 at 04:37:25PM +0100, Robin Murphy wrote:
> > > On 2024-10-15 4:31 pm, Jason Gunthorpe wrote:
> > > > On Tue, Oct 15, 2024 at 04:13:13PM +0100, Robin Murphy wrote:
> > > > > On 2024-10-15 1:47 pm, Jason Gunthorpe wrote:
> > > > > > On Tue, Oct 15, 2024 at 08:13:28AM +0000, Pranjal Shrivastava
> > wrote:
> > > > > >
> > > > > > > Umm.. this was specific for rmr not a generic thing. I'd
> > > > > > > suggest to avoid meddling with the STEs directly for acheiving
> > > > > > > bypass. Playing with the iommu domain type could be neater.
> > > > > > > Perhaps, modify the
> > > > > > > ops->def_domain_type to return an appropriate domain?
> > > > > >
> > > > > > Yeah, that is the expected way, to force the def_domain_type to
> > > > > > IDENTITY and refuse to attach a PAGING/BLOCKED domain.
> > > > >
> > > > > There is no domain, this is bypassing an arbitrary StreamID not
> > > > > associated with any device.
> > > >
> > > > If the stream ID is going to flow traffic shouldn't it have a DT
> > > > node for it? Something must be driving the DMA on this SID, and
> > the
> > > > kernel does need to know what that is in some way, even for basic
> > > > security things like making sure VFIO doesn't get a hold of it :\
> > >
> > > Exactly, hence this RFC is definitely not the right approach.
> > 
> > Agreed. I assumed the bypass was needed for a registered SID.
> 
> I just reply here, not reply each thread.

Apologies, I responded to the other thread before looking at this one

> 
> The SID is not a registered SID.
> 
> Considering the security things, except "iommus = <&smmu 0>"
> being added, is there other method for this issue?

I can only think of RMRs if you can ensure/restrict eDMA3 to access a
fixed region of memory. Something like a DMA zone if feasible.

> 
> Thanks,
> Peng.
> 
> > 
> > >
> > > Thanks,
> > > Robin.
> > 
Thanks,
Pranjal

