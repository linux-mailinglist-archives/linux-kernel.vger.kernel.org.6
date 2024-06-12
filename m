Return-Path: <linux-kernel+bounces-211596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 495E1905426
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB633281358
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7E217CA1D;
	Wed, 12 Jun 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bd3bqXvg"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF7176ACE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200226; cv=none; b=FmJ5KRq6xZlobECXjSLpeuANkMYqFZ7auWJK9+ey0mvUtydFFzDVzO81X6tWiRbW9NCJ7M/bityGIHAkZmh5vf3pdCV3gmFleORF2zhVhKGyVSzrAuMevlmGTcmY36wqVpYG1QvU53tf0dMRXA3u6UxbdgvfkLjcbhP/qPEmCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200226; c=relaxed/simple;
	bh=hXC97HFGx9ulznhCQ/2sutiUlN20FWDeS6s8GSoSCz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKtjMurHlBJlC4AYmYTb6oITTlcj4aD0zpt3RInGwtVAh4Wpg2jUgxiHKwRbsgaIxGTUbhUQl+396zNEdy9EkjTmpfRWwaW5p8szXsae/1W24n72AVKGboHJTa4QzJRBl28xsmSYzFGbDtWfVM5XnmHpa7C5dKkYvVFV3ZUAosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bd3bqXvg; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-795569eede0so229154485a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718200224; x=1718805024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFYWkqrPwpmWXwb+4x3mhR3bmPCPe0lnYFyAxL0zKS8=;
        b=bd3bqXvg1B7FIoxwWcaNMmATWz0ycSltrVUiHxJRc4LGEbNZ34ousjy5Sk7AmZl91d
         ku187smL9rnHjBNu1zqmESMWtXyXLwxWphYXnvV99v3B+xsDQg2vutp5RZBwO7O/fkc3
         ELk6+yOAZLGp//fKJZX6TuBuqRfXAsrZoBETtuV4ryIt+ixcBF/DYqhU/1WlHnjllTBX
         Ij+q52L+p17uk+DrW16vvVSlmWoYLYwc8QHkuFwiJ2ZgV95rj2j9dH9kVvDvrl/O4QzZ
         eIe5rBYsbIoMY/9F+nMlqkybIvraF8KJkbijDTEQ1YoLuMqyRdYzX2Gxx/wj0ta2twDW
         hLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200224; x=1718805024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFYWkqrPwpmWXwb+4x3mhR3bmPCPe0lnYFyAxL0zKS8=;
        b=WBwJgA2tFaOcMyqUZdVdkXILeMuZB5ZyELqKC2i/OnsB7GBTm5aBdrFPxq7s5S4/Cn
         QdgTKG8n7pRwUBxSo9pyaAj4AGa+kfqjXk1EPHYlFlTS5/aGpiV9U3fBsJUp9vZdjSym
         XGccr7afmQgpFWZEvPmfk7J3+f6kr+8rLTxHIwiWBIfkzRnhihPAfwJ6I8K1O3Co2HrR
         KDRiz/S8X2nOG6OcgbAlsk3kvkH0bCE6AAlzL7Go1+9jofj38baO4CjGavQW4mtRK2xw
         E9rMwnQgOItaYqWSYQzLio+q3CBRGGWaqxPM+D6nn8cO4LhjewlIvSWdevdvco+ug+/H
         2Gwg==
X-Forwarded-Encrypted: i=1; AJvYcCWT7fPZ1J1o+j4ml2ESyiMvU5PqQx9bWtYMM/Udo3JrJPteuRsDj8nQV17UXNRwowAz28ZjwA65HqnPxDH2zzZjPRg45oPeA8JqKXt8
X-Gm-Message-State: AOJu0YzEg0rSx3Ie81f24H8+pbPb6dQt4z80JZCVuH516FQULOzToszb
	uFqdmumeB8rtpLmGNoCQG451X2jXJgrVDQrO+TdGF/x9lL+SHzcG+OqraTotCmA=
X-Google-Smtp-Source: AGHT+IFqkOQ425CZ9HmV0W9cSIsAGs7sDRjX0/G/h21LJTdrIAx//TCFVCjqyP6rhlEYuwiQiSdwcw==
X-Received: by 2002:a05:6214:5d0e:b0:6b0:72ef:2877 with SMTP id 6a1803df08f44-6b1a7ad4ca7mr21677346d6.40.1718200223971;
        Wed, 12 Jun 2024 06:50:23 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b075e37080sm39031086d6.46.2024.06.12.06.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:50:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHOMn-0090iX-Nk;
	Wed, 12 Jun 2024 10:50:21 -0300
Date: Wed, 12 Jun 2024 10:50:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
Message-ID: <20240612135021.GY791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3ee41c29-46bb-4897-9e93-5982c43736cb@linux.intel.com>
 <BN9PR11MB52764D7EF1EEDA95B694E8B68CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240612131946.GT791043@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612131946.GT791043@ziepe.ca>

On Wed, Jun 12, 2024 at 10:19:46AM -0300, Jason Gunthorpe wrote:
> > > I prefer not to mess the definition of user API data and the kernel
> > > driver implementation. The kernel driver may change in the future, but
> > > the user API will remain stable for a long time.
> > 
> > sure it remains stable for reasonable reason. Here we defined some
> > fields but they are even not used and checked in the kernel. IMHO it
> > suggests redundant definition. If there is value to keep them, do we
> > need to at least verify them same as the completion record?
> 
> They are not here for the kernel, they are here for userspace.
> 
> A single HWPT and a single fault queue can be attached to multiple
> devices we need to return the dev_id so that userspace can know which
> device initiated the PRI. Same with PASID.
> 
> The only way we could remove them is if we are sure that no vIOMMU
> requires RID or PASID in the virtual fault queue PRI fault message.. I
> don't think that is true?
> 
> Cookie is not a replacement, cookie is an opaque value for the kernel
> to use to match a response to a request.

Oh I got this wrong, the above is the response, yeah we can ditch
everything but the cookie, and code right?

struct iommu_hwpt_page_response {
       __u32 cookie;
       __u32 code;
};

What is the workflow here? We expect the VMM will take the vIOMMU
response and match it to a request cookie for the kernel to complete?

Jason

