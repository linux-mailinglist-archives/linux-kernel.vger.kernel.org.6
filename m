Return-Path: <linux-kernel+bounces-250669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6251792FAD6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8D91C22117
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C4316EBF6;
	Fri, 12 Jul 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nOvxLF2P"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC81607B2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720789241; cv=none; b=JkJVe8sGIXLpDKrqJgEri8mNqDQasog592Zu6ApySE4bb0n9HBBmQ8bKXUPYE1b3dBccAuO48rm1Ex+5QpokYXaAL/B4EOWa9TOVth8oT8X0hhpYaFWJvnN6S4iNiSqg7uL3+aWQT6m+3BLcxMRJZPub5ljM9xGpLmS8QALewps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720789241; c=relaxed/simple;
	bh=4vaan9lVCWHn6tCkQmfCAQNwBS43BDI/yL/E404vsrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGRQElcA7ci0//YKhazGcBk57L+K02Moki/kHIfD3lJevbdWCS2vpIp5VvEP5XqwIZZuGYJ6V6McD6kZ80ggxV0OZ9wHcyPzncbte9GsHUYOJX6edHYvGQKA02OE4RI0EQoh6O+KpAK66g6x4rVpR3qLTpY30v+feC+WkPwT//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nOvxLF2P; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e03caab48a2so1528206276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720789239; x=1721394039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T/w0zwGhNPKt9SyZTMl06PaCMjOKZYwYdrSeXLeSiM4=;
        b=nOvxLF2P1HOzcYWDPm3r1I/lpvQNlV3bC0CTGnBWOdYvHizdrDfgf8fb+y2JXDXRow
         GoBz3OPJrewoWpLEjSWQzjwBk8wDwannigJPG16JSOzXzF3YsufCA6rx1jaVfeE+2Cwy
         wci2OekUB5NxkaopPpr07CnXBrQhsXTn95U9JLLpIw5EIBzZVJZFDwG3DQF7l7YvqZ/I
         VWtPUQfDioPmmSxCWYIOL4orwq7+7FEEw/7ICKNH2riuWy31T0/zZqmplsw9r8zX+ZX/
         GA5Lo9lY/chHhOqk7/YqKdeaFHqzhrVo9rDTYUhsProyJjmNQNtvfxiYJUv3D6ezC2UL
         N81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720789239; x=1721394039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/w0zwGhNPKt9SyZTMl06PaCMjOKZYwYdrSeXLeSiM4=;
        b=W2OTBKUKEaJQUhxAlQ+DCRWwfbeERrOqAE/IDUysltl6TKnp5BAucx8SPr0lvresgW
         iRlhcxTnzUm87EucXx5i+JtmuVaogNcMpQ66IZMxT6mW4jMUvV24vwSnxNV+Y1xopx6E
         Ra/WTXEfYFG36pdRv1W5QO0p2o8GWzeFhehI19pfNLn1quvjBVKrA+vzzVasayYyG4Ky
         qKQazqiHSFsCZ91Wj279kwHZN9DNom805GoCXr/fItKVwjK1kpD/xQN+Rjxh4MwTRiCP
         9ahOUFnS5WiQCRKm4CxGlZOk/9g+wjy3vxJLPAveeznECTVoj5eoCyn1K3s64l5GOiKG
         rhzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA93L65zbezwyaXD9U0os9gvquQ1vaAo6ikwxvapO1gOsv3EBXTeMponY+lwTSZjyj4gqjtR1Pd1h1ZMkG2l1CBb8mh+Aas0Wz8Cqs
X-Gm-Message-State: AOJu0YzJxm9OF45xezsz1O0niJp7SBqz5TJVPKp/01WGl5W4KZGtO7Gz
	ATDN/+S22aokBgpnlKw0zy5Mu+4uBumtt1nmQAI0ihD1Q3CDtC7jMp9Hn8vyG30=
X-Google-Smtp-Source: AGHT+IGrtfbkVyeqhWaqWAqPeH9PGe1fIAllaalk3hPaJxwrAsvjR5TxMPnud6p1klxpbKWWS6qKSA==
X-Received: by 2002:a25:69ca:0:b0:dff:2b97:b06b with SMTP id 3f1490d57ef6-e058a4eb6c3mr1874869276.18.1720789238613;
        Fri, 12 Jul 2024 06:00:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bd25d2sm40132481cf.61.2024.07.12.06.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 06:00:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSFt7-000J4s-JG;
	Fri, 12 Jul 2024 10:00:37 -0300
Date: Fri, 12 Jul 2024 10:00:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <20240712130037.GA14050@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <20240708162957.GB14050@ziepe.ca>
 <ZowxyUQAcqDJ4yZ6@Asurada-Nvidia>
 <20240709170038.GG14050@ziepe.ca>
 <Zo10duoguPCADKSY@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo10duoguPCADKSY@Asurada-Nvidia>

On Tue, Jul 09, 2024 at 10:33:42AM -0700, Nicolin Chen wrote:

> > We are potentially talking about 5-10 physical smmus and 2-3 FDs per
> > physical? Does that scare anyone?
> 
> I think we can share the same FD by adding a viommu_id somewhere
> to indicate what the data/event belongs to. Yet, it seemed that
> you had a counter-argument that a shared FD (queue) might have a
> security concern as well?
> https://lore.kernel.org/linux-iommu/20240522232833.GH20229@nvidia.com/

That was for the physical HW queue not so much the FD.

We need to be mindful that these events can't DOS the hypervisor, that
constrains how we track pending events in the kernel, not how they get
marshaled to FDs to deliver to user space.

Thinking more, it makes sense that a FD would tie 1:1 with a queue in
the VM.

That way backpressure on a queue will not cause head of line blocking
to other queues because they multiplex onto a single FD.

Jason

