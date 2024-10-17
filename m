Return-Path: <linux-kernel+bounces-369813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E869A231C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23D4B22308
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4F91DE2A6;
	Thu, 17 Oct 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="X9BCtRH3"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F51DDC3C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170489; cv=none; b=Md9g5VAMKl6ZfQWlbQE8Ml9/JWFN1bIh3BHRp3bN6Z2/mzxLLpDmUYCj2MyTqgUPtnTS1U6+tdI1Qy2PoZUrizr2NnvQPkUrNh5DyTXeMTfeGcER20YC0Jrno72N0mPu91ut3B0fFPMPPjiXxSYqsy/0kdHvuaKecT4fQeURnK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170489; c=relaxed/simple;
	bh=MCRIxE9GhA2NAkXdzXaszALYW7VA4HLq5f6MBrAaTKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfEXgPUQB5kE6LDNimAce+yVCoBTiQY3xm0srfEgjnSRx1Pg+sHPwfaLsG6LKZRgb2PULtz5ZqYcE+hTAwwaIBnlikIjDfFDS0I0ucByMbFWp4B+sRW+c0syHSgEFZUOpMylH1Zgm32O1tnsHCkxUDaZermWAU84uDlQLakSchc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=X9BCtRH3; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbf2fc28feso6108896d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729170487; x=1729775287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wq3teVnFjCQljMHeJKswAqz9sY5geo+xNzpep4xNz44=;
        b=X9BCtRH3TeoFWPVhf2hgw4oBlIvrURgP+q/T1bQ8ez8hrDb6Q8dRhjYNRP6xTWL61u
         UoMglKzV9qqi5xTYIp5oRJHGqmZz1mrAu0PGobR099Lye89l6lDSnIKENmuZzFa3J6qn
         BH9AuktFAZp0N/BEmIx2nXiWwSvRJo6f9lqanVU8L/mUPuK9KG6ebiHuJ0IfUHQt/z5/
         p6A43tFDzztNf6qLQJxbwRwWlbH9vP0XyKmCq7JiuQLwD7Uizwn6ag/wWA98R8PDgu5b
         uRQZrJL6Za84VFUcyrzx/fSVWihhp9Uocg1Ph9fjIDMScIBcL4HawNT3yfOJRXg9ZNKV
         dj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729170487; x=1729775287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wq3teVnFjCQljMHeJKswAqz9sY5geo+xNzpep4xNz44=;
        b=Nf/Ehvdo0oP3Aq141JNRSxCB+MaIKqSVrxK0FVxKtOCTBDrCO5SbhBcHFIpayZyltW
         OLpaNGAzCdCeGbShw03XRWPgK2Q7VX/tkY789oLDnbGXjlJgSb9AfE01VNFfkMs9GP60
         aZembvv4n5jTKe81mtg5LcFXhDsEbYa2oJAszTZpJmUh8tnIC+qEBnY9JdL2dR5ytR87
         vW0dKVSBsxJxyorhkFRRPQHheQctsp+I3sseQ/KlUUzi3icRlXssiu4oCI9C/A3KCj43
         yk+AtBaD5Ld4+B+1O5HZvXZIPxKizJO/fV0UGLV7e7J6nLvxyh6VDIaQ4UxPRDvW4jRJ
         9gVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx6sRnfs9wAouhjQwfpJ3XtKRqirgRIPJ1nm6Kqg7+y/PFeTAQQk+peUTxxTd6ocSy1NdtePpLr58Zoac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4OGznoEjoTi3pEURtXGyuznPe12KDxBRkoGQBidgF4oEThKh1
	suCf02yzl9GcgMxKPrm2mhQ92yjE32KnHHCnV6tMl5mgdn0WFjRSJ2WQ2wzxjag=
X-Google-Smtp-Source: AGHT+IFIWL+tda1Up3Uym74uSu9HXo+USovi7zkNskhvncDpsDguxTD9i3KfGBRjr2fW7WKmWz8dEg==
X-Received: by 2002:a05:6214:460f:b0:6cb:d558:6f00 with SMTP id 6a1803df08f44-6cc2b8dc70emr135440876d6.29.1729170486776;
        Thu, 17 Oct 2024 06:08:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2299043dsm28134646d6.136.2024.10.17.06.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:08:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1QEX-003tKN-T4;
	Thu, 17 Oct 2024 10:08:05 -0300
Date: Thu, 17 Oct 2024 10:08:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20241017130805.GA926121@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
 <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca>
 <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>

On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:

> Yes, you are right
>  I am using SRIOV vf and stall feature, so is_virtfn == true
> 
> Our ACC devices are fake pci endpoint devices which supports stall,
> And they also supports sriov
> 
> So I have to ignore the limitation.

I see, so that is more complicated. 

Lu, what do you think about also checking if the PCI function has PRI
? If not PRI assume the fault is special and doesn't follow PRI rules?

Or maybe we can have the iommu driver tag the event as a PRI/not-PRI
fault?

Jason

