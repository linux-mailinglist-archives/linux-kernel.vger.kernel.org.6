Return-Path: <linux-kernel+bounces-353661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B6B9930E3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC291F23FB2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C691D7E38;
	Mon,  7 Oct 2024 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="URpIj8EV"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2901D5CF2
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314197; cv=none; b=UlEAMUWjYC2nsMXXcI8mIy30GkGCwMoZIYOFrZz1WwfxqD5kycisJvO/Q20OjUQ6p2G5pWOXfS8uNwQkxolNGs1HNvP+lce3xUu6Qk6lIfcGlNZ7mQhGxwK0c3O7XwTJDga9pZNVDACNTTvkHT28IO7n4aaU7JGsZ8s7XyWRWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314197; c=relaxed/simple;
	bh=GD5SmuXSwVVv1nKlBg75L0EkhR8HmCkqnPOpazRcbW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HurrofRMXKfj4a1lslVwhE/OTs4JIpsrAcx+xsPBpPtvPufTdoFk/gKCONhau/64Kb7IfxAlSlNoIJ7lYoZdOO+jDMsPCE5yYZoSZW6RpmoYTBYlwarh2NEySKCDcMQlR4mppaJR7uZhyKVXGXHgUue71oIRIFw8YF9ZkTZ4idw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=URpIj8EV; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45816db2939so32165821cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728314195; x=1728918995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GD5SmuXSwVVv1nKlBg75L0EkhR8HmCkqnPOpazRcbW0=;
        b=URpIj8EVhQSE0iLTNSr0Y4O2m10VvzpmRgXkEuxVadYl3e8puq0LqKRqc56PwkhhuR
         3VrMhRfmd1OVr2HZ16osJXh4ZwJIovxL0VVCJOHxAZHauLeYocx5RcLXDFPrc7CBnB3A
         BId7pQoBrxxH5Nf9o6CzqT2xqryuaTNPW/X2QyDjX5dC4oGxuUdKFH9HOrqd3yvbLQ3u
         JZOFFhxm7l6egJNdoZg8bRWZJFDHDMyVaSMmIeYBEMFJn/7JoI4g2tKUgRg6j8U9zB8w
         XtKI7y+NRps4Jz/8tl5vJDY6PzVIiAdn5bFjD1nodYTH4SSa4Yw50BQuXuoAcdg2RKcp
         iiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314195; x=1728918995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GD5SmuXSwVVv1nKlBg75L0EkhR8HmCkqnPOpazRcbW0=;
        b=ffkaB9b+yktxpfTXYM5nFgSiiTpXAANFYAd+JedbJFxPwFOezGoip7kV4R2La+LNvL
         rfeR3Zt08YQULJLpM246BwBUgXXU1rrQ7iOmo4FjBD7bjlsjkWTCU50jlUGDFzLfBDXj
         QRwc7mXEa3pv5C7JkEiYhSagVbboKnwVwr0Zs3GQIwDta/RV+d/Kkv1voauq1b6L/iJQ
         Y8KIL5eRmrjfZ4OYnzwtlBL5xTAoyIyWSxmYxBrTRKihLbaThS8Dbcgf+93XLBf5ctn1
         xRQtfWQkgNFidCmx68ZzMMXsV64r+OjCRciyHliPMiCk+5xAikQYLAMyIveXhphhptiA
         L9mA==
X-Forwarded-Encrypted: i=1; AJvYcCVcEam4/knDjoiM4PpkM4zoHs8PwGSKDMDtQfqOjYJAU0xgWjNUssbYFuZWgG+eQ8Wvhp3sycNar5Jz6ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMr9IuyfnIOGCAvWulr6MzseGbiXMeZUDHOLi8v3JrrDyO2Ql
	d3mjayx3EiYPJVZGB/2oocnQ+jiXwRpjFRUHE6DsGpnRiXqZGWiZqEk4Y1j7Ymw=
X-Google-Smtp-Source: AGHT+IEPba2v0q8aqVC+T2ybeBD+S2XlfnHh/v+Vh0EzHqSIu/q83G/LSTFJH4H1JKueo/M8fL1zKQ==
X-Received: by 2002:ac8:7c46:0:b0:458:3b68:ce39 with SMTP id d75a77b69052e-45d9ba79546mr194075641cf.9.1728314194839;
        Mon, 07 Oct 2024 08:16:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74ea488sm27130131cf.26.2024.10.07.08.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:16:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sxpTN-002alD-Et;
	Mon, 07 Oct 2024 12:16:33 -0300
Date: Mon, 7 Oct 2024 12:16:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [RFC PATCH 05/13] iommufd: Serialise persisted iommufds and ioas
Message-ID: <20241007151633.GO2456194@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-6-jgowans@amazon.com>
 <20241002185520.GL1369530@ziepe.ca>
 <d6328467adc9b7512f6dd88a6f8f843b8efdc154.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6328467adc9b7512f6dd88a6f8f843b8efdc154.camel@amazon.com>

On Mon, Oct 07, 2024 at 08:39:53AM +0000, Gowans, James wrote:

> 2. Get userspace to do the work: userspace needs to re-do the ioctls
> after kexec to reconstruct the objects. My main issue with this approach
> is that the kernel needs to do some sort of trust but verify approach to
> ensure that userspace constructs everything the same way after kexec as
> it was before kexec. We don't want to end up in a state where the
> iommufd objects don't match the persisted page tables.

I think the verification is not so bad, it is just extracting the
physical addresses from the IOAS and comparing to what is stored in
the iommu_domain. If they don't match then the domain can't be adopted
to the IOAS.

We actually don't care about anything else, if userspace creates
different objects with different parameters who cares? All that
matters is that the radix tree contains the same expected information.

> What do you think of this 3rd approach? I can try to sketch it out and
> send another RFC if you think it sounds reasonable.

I think it is the same problem, just in a more maintainable
wrapper. You still have to serialize lots and lots of different
objects and their relationships.

> > Ie "recover" a HWPT from a KHO on a manually created a IOAS with the
> > right "memfd" for the backing storage. Then the recovery can just
> > validate that things are correct and adopt the iommu_domain as the
> > hwpt.
>
> This sounds more like option 2 where we expect userspace to re-drive the
> ioctls, but verify that they have corresponding payloads as before kexec
> so that iommufd objects are consistent with persisted page tables.

Yes

> If the kernel is doing verification wouldn't it be better for the kernel
> to do the ioctl work itself and give the resulting objects to
> userspace?

No :)

It is so much easier to validate the IOPTEs in a radix tree.

At the very worst you just create a HWPT and iommu_domain for
validation, do validation and then throw it away. Compare for two
radix trees is about 50 lines in generic pt, I have it already.

Jason

