Return-Path: <linux-kernel+bounces-211536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA84905354
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614AA1F232D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98628179675;
	Wed, 12 Jun 2024 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NCMiPt5i"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A601D54B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197863; cv=none; b=oehs67wYfpQ4xI3WE2DBrWC/AXeCsx+QlopUOgEcokkUYMYoUtg3lpeFGreuAq+3utCMypxp74lzp3bUQGCZ9ANOaCXLR9NlzXl/t1nXt4gBHb3EGbKRca5TNS2mxz6D60UwYLOqernoPl/OWhYNYRpK9EhUFg8k2L941ejIn4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197863; c=relaxed/simple;
	bh=65xpeURwcmOmVb9HhCKWlX4HTGmbshxZsViqDHmAa2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX9ePOgObk7orOrd4gQO8QoIJ7o4Ha0SlCYnN3vLuG9LGz5vsfu4jx7wG1DEBF5NdTGdXLbpe+fLdGwzCANJXDA5qNmCLzi1jDnH6hepjQVrinylDqb/W0ZyCZSR87+kRYMurD0kRfW4po5cbGERIJhkiHS6NUGvfXTZCpJzSVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NCMiPt5i; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f9a7120d9dso1861519a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718197861; x=1718802661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDxonTYHz9nxQaqpOoNfBlOFb36tO8nlEtyL7Ho8AwQ=;
        b=NCMiPt5iGp6YvsEsl3pJcU182eV2jurw/oDGrQcmxVW957B0NI0HDDD3ApNNFKRRw7
         v8UPGo1opUnU5QckySmAVt68zCttnRppzAQov+4kDsUb+ZstbyyOqgNezvJ5JJIZEbYq
         At3UpapJ2gejLRGC+8Jznfunrz9F0juGzdiTZ0/uZ8cY6wkiWdeq/sa5/vJJY1kY3rao
         bKfhZswDaemfKUCLGsjtSF2U0Nf+WWIm3GXu8Xza0yxIPZG/pLO7AzCzV0BFsJnGNhPr
         wLKR0YrbgWYQyW/Q+xow4rSJ3Xlj9J6Kjt5chYoEcl83wQd2F5IL6jDidx7zr93NmjUs
         zoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197861; x=1718802661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDxonTYHz9nxQaqpOoNfBlOFb36tO8nlEtyL7Ho8AwQ=;
        b=q5irdcBdhXUFiHnFv/DYDCBMGLrDduT3TzTh3/Vnqn1JDFaQCnAo4xqpBR+U86+cXO
         q37rrEOzMDcra4bZ16jBt/JSJn33vIqhEgEIqldmWsu9liW2rw0LqzntA3wLd2R7XuJ2
         ocB+c47xKlvjWdbKe2YDmzDV8q7J4qQ3/wfxU3Vm1OHEgS0GxT2DBcQiicwMLiltJvhv
         3jVut67PRipxv2EgKPW342J2OW6EqMUwlRBRVsi5+F6gcnftOujBpSkz0daIk1gAcsKx
         N//N3jiR4O2v1gsF73NzRxgvY1Mww8BN+NgDNYfWGHkRD3KWZtymKTK1m6nnP4P8CMlm
         fWMw==
X-Forwarded-Encrypted: i=1; AJvYcCVAXnSV9lAHZ20DT9BR/5vhx1Rpc4zE4ztWRUM5xUiBOoV00d+0ON0fvPJZmpNp8n56CbjORcZ1lpxq/NKI5SKtEA09Dh7F7RPWeEHW
X-Gm-Message-State: AOJu0YwcTuECtVTgu3f6sADWoqAogQdVNpSQ/FmarU5TK5JcxWv7SG41
	0WL9ghD5YdEumaK/QOnzxDstFBABCuYIWKj1unyyicnInKZt/u7w2UanakAqWr0=
X-Google-Smtp-Source: AGHT+IGl8HcoadNuoHnllo+K1b1rGMd1ZFrjzpRpn566P4vS2gHW66FG2Ie4jvGYbR3pikDM/mmSHg==
X-Received: by 2002:a05:6830:1e04:b0:6f9:b580:e420 with SMTP id 46e09a7af769-6fa1c43951emr1549072a34.37.1718197861362;
        Wed, 12 Jun 2024 06:11:01 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7954f6f337dsm444526785a.42.2024.06.12.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:11:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHNkh-008pLb-LU;
	Wed, 12 Jun 2024 10:10:59 -0300
Date: Wed, 12 Jun 2024 10:10:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 01/10] iommu: Introduce domain attachment handle
Message-ID: <20240612131059.GS791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52767B3B1F441D9AA656AC258CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ae7c05b0-104e-4c71-99aa-fed2a4f209fb@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7c05b0-104e-4c71-99aa-fed2a4f209fb@linux.intel.com>

On Thu, Jun 06, 2024 at 01:33:29PM +0800, Baolu Lu wrote:

> > But if certain path (other than iopf) in the iommu core needs to know
> > the exact domain pointer then this change breaks it.
> 
> The iommu core should not fetch the domain pointer in paths other than
> attach/detach/replace. There is currently no reference counter for an
> iommu domain, hence fetching the domain for other purposes will
> potentially lead to a use-after-free issue.

If you are doing this then we should get rid of
iommu_get_domain_for_dev_pasid, and always return the handle
there. Making it clear that all those flows require handles to work.

But is this really OK? What happened to the patch fixing the error
unwind in attach_pasid? Doesn't it always need the domain to undo a
failed attach?

Jason

