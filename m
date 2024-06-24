Return-Path: <linux-kernel+bounces-227560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE2915337
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04377B235B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE76119D8A5;
	Mon, 24 Jun 2024 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BkmcATCy"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA6512FF84
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245574; cv=none; b=ciVNTtLAM4gO+eIV/m+YURxj6M5QWUI7RfDSqi5LCbflUCHOYMOmqmGCNCkyTlxX24hpXlsu5npDk4fWLnrCmEAfWUOgnouQGNzHnIhahoqQl62/Z5Sj5bEVoQXlzGbun+qKHEeAEE4nkPNDKcevpFuAhFVReKTdZajFdkGp2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245574; c=relaxed/simple;
	bh=pG1yk7b6XhBcVzpKA4KQz9xCQgnJK5mEnEdrdNWSzC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Et4WyqiNIsQJB8CVA4krbHuFwVfqlIxK9mqvUZ6FhABK5Q8wGWclTXTKQ5vd5OK2ZCiUuVpKVSbLOb7K9PxU/7GdnPAiPOshhDyXyTGX2QIVDK9+Ca3QCyjfwRn70TUi+NRewwOSNljzGcwhMF0mKyYHrFskP2DWfalV/81HkXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BkmcATCy; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b4f7541d7eso21438576d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719245572; x=1719850372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9KVh08w6ZHcJMoEyUgVFbZt4nC3NusyFRhTL7+nVKCM=;
        b=BkmcATCyzTvpgISdaGGiGreQpjvOZrW079lDrrB5T6kErVFhm1fc7h0wtP9gmckBca
         OibtIbpsU3a3awAxP3VVJWNITTGDW0sGYq/1UrLF5z+8E7K9b/ebHU55LeOQV0TVb0WE
         w8dqidy8Wl4Zjsy5m4sV8d82+sw6jY0qkcfQq0upVaThv/B/n9WBS2CQOSzUxNdVepVO
         x24grslKpcnM1Sef0pziAW7PND6XKlm/enPpLzgeZXuBNnS1psqLawFvyHYtgbqMleAP
         bkjVTowjRi0R0EVeEO3gPPgFNK6rmasby9xw3WBspO4iMlfUCc6YCmQx4q72OEMibDX/
         8XNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719245572; x=1719850372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KVh08w6ZHcJMoEyUgVFbZt4nC3NusyFRhTL7+nVKCM=;
        b=faFRd7TtYDBv4dzynbh300/ZIuM0td7oysNVTPKDNgNb0aS5iUelMQ8PxG7Y/6KQZM
         8Z1MIKzVIIsIXl9BdHkrJTfwIwrE+ZctaLTJFDXh+B0JE0UYdxn8/1KMLInUG12l4QHb
         J+PVMkdrdmDD4Cg4TKGHY8SnMBE5gcAQC/vl8PbYmFpl/Co4u/srU/S/RjcQYNMVFd8u
         yUezHZO5j3u4quUIqjHR+pNfW8Uu2Uv87n48CuadROE173cY13UeKijGLgW8D9nJ5dZq
         3V+S4rt8TWVTJ37Y2F8eEGSjkhdDOnTC1clGl4SVfAYKsf6x7i2o1B036EknlAawW7Gr
         d9JA==
X-Forwarded-Encrypted: i=1; AJvYcCXx5QjqCVAWxeLNqOBbKTAZp0NhgYIKr8jDOWHrZQOLgsfKldB0Veeihu/WfgtCzU5Ou2LL/HnSEP+4nZoVb0xVdLjzrBNChvqzUchV
X-Gm-Message-State: AOJu0YzJtsc5jkXrchBuaLAGnVP4WzdGfGWnifnSDxpbqfeN13brBilT
	CIRYAfn56g/4o9FA0QtP7TwS8tzm45JJxCLL0i5rKTJ1m75oY69XBvb5MPbdeE8=
X-Google-Smtp-Source: AGHT+IEtjMLppvm95Bhcr6Fo3t4bK3e43HafSl6y57NwQxCwuLvy186WvvSNAQulnuXL3iP6wdnezw==
X-Received: by 2002:ad4:4f42:0:b0:6b5:51c2:9808 with SMTP id 6a1803df08f44-6b551c299e1mr33223666d6.26.1719245572248;
        Mon, 24 Jun 2024 09:12:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef5c330sm35415686d6.118.2024.06.24.09.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 09:12:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sLmJH-006FXA-6y;
	Mon, 24 Jun 2024 13:12:51 -0300
Date: Mon, 24 Jun 2024 13:12:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
Message-ID: <20240624161251.GS791043@ziepe.ca>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
 <20240619164620.GN791043@ziepe.ca>
 <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
 <BN9PR11MB5276F76798E61D231D861A2F8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <976d4054-6306-4325-a112-5cf69b0c6f34@linux.intel.com>
 <bdbb40da-faa5-4321-a58b-5fcffcbc818c@amd.com>
 <8c78f966-539c-4c81-92a6-32d32bb10e8b@linux.intel.com>
 <657c7e03-91ef-4765-be7c-1f57eb45e467@amd.com>
 <20240620140815.GO791043@ziepe.ca>
 <92033ab6-fb55-4206-9cb9-f81b5b6eede6@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92033ab6-fb55-4206-9cb9-f81b5b6eede6@amd.com>

On Mon, Jun 24, 2024 at 07:56:03PM +0530, Vasant Hegde wrote:

> >> I remember of this discussion. May be we can provide API from IOMMU driver so
> >> that individual driver can enable/disable ATS (like iommu_dev_enable_feature()).
> > 
> > But I have a feeling if we do that it should be done by re-attaching
> > the domain.
> 
> Right. By default IOMMU will enable the ATS.. But if device driver decides to
> disable it (say due to HW bug), then we have to re-attach domain (in AMD case we
> have to update the DTE and flush the TLB).

SMMUv3 is the same, this is why I like doing it via the existing
re-attach domain interface since it already composes nicely with the
mechanisms the driver should have to update the DTE/etc.

> > Having an additional input to domain attach "inhibit ats", as a flag
> > would be all the support the driver would need to provide for the core
> > code to manage this with some kind of global policy.
> 
> You mean for attach_dev() ?

Yes
 
> .. and what about PRI and PASID? Don't device driver needs similar interface ?

PRI is enabled by attaching a PRI capable domain

PASID should be assumed to be required if the device supports PASID.

Inhibiting PASID support would have to be done during domain
allocation. Soon the dev will always be available there and we could
do a policy like that via the dev structs? Not sure how much value
there is..

Jason

