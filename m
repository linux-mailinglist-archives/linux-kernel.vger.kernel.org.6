Return-Path: <linux-kernel+bounces-186239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F158CC188
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3252BB212A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1233442F;
	Wed, 22 May 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nYE3fXlZ"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C13EA50
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381922; cv=none; b=rjTvFcRT3w0owEP9DfW+HrVybGlLLMD2114Ay0Y6L1Zq/F4wweHRBgiTUmhUZj/72B1HzM56/10Wz+1Deaa0pmcLQ3nUgvTIOe0MBFfIIU6+/bfNwJNcOfD2JNO7a/J3R1GXrF49tPX6hSEf+eTLfSD8XTSAVEzgSec/tDB/bkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381922; c=relaxed/simple;
	bh=6h+DlmyiNaZDu8EDvDasz+c9qX1zA+VxQ63Rp9dwApI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1Fhx7vKTFV4ZC56c/b+atySOIia395wz+O+oP+n87GYotQ7ELg8Xdkk+fyMzoO4jAqUqlqVvkRHUuoqvCtvm+MryZ8xIWbWTgitKug9ipL1qVJwugK6RB+iljvhDIE73DO2ru7thq8cRPvYYTXDOtzKT1kpYPWMhpbo3mJLFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nYE3fXlZ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6a8d467aa23so23297086d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 05:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716381920; x=1716986720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4PMQO4MVXhDYxg8A5GdJyXIRUDNYHsFb/4hfxxANEPE=;
        b=nYE3fXlZNVRput4ncgS6kkReGbiItk9osD3AT7Paqp0pelPsxS2M1YEGeAPdtq0Myi
         XygwgldkjsQVVUd3C6/92P7dt98LTjlmKzdI7jGjjp0FVzwwnKkg6n+uey4643qVC4/S
         U2+02UGJYrfpR/x55hhyzGbfmdmZkPRIDOoCgPiGVo94c7uIGl+ffSLX6OCXarCUk27q
         JM2UCwsCcLusoiEnax9w7RE+oYaQEeMh2V9mh/V4/S0uAkN6WLn2a5uI6MVF1nBucOCH
         T769aeWZNGB4NgydOquM3P3oZmghP8lAaYdYlCB5kRaaSsXldEPiZc1baxBI02l4wjg4
         1mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716381920; x=1716986720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PMQO4MVXhDYxg8A5GdJyXIRUDNYHsFb/4hfxxANEPE=;
        b=dSPsIvgYtQa+jLJ2zGMJyDpM59IKPTDFA/J8ljs0RzkbnAT87mVqz2RvxPod08FXHD
         nA+o/13KUCW6CA+gkPgIqr++vhEMADGgcZoEkF0zqt4Ts4RwFeLDHwkBOUEHtU09n6la
         LlyJQw526azmgN7p9Hs4l8Bx1BxQEfLD2Oz/fhl0UfX2GdMgvXmOkF0CO+SwdKBSiCY+
         udospkvhu3/zcWvhRubiAgi/8DRizgl+bPlZT+8ROwIOrrTUoT82y6NK5SuFsasRzsKH
         MvlsD2OBcSeaUBQOoOduPBcWjdMdMYkd9yysHBTeRhZtzzOPzMTIiyIQRBXyMQCeVsd3
         +Img==
X-Forwarded-Encrypted: i=1; AJvYcCUE4Ba12A/PeM2uSEC21sZHiuQehvVESWcQiRXFiCB8LIASL0ICqMkKhIwew3QCJsQYQiA1FA/vwVToJoOz1vOUpp2JG5faOWi1eJRU
X-Gm-Message-State: AOJu0YzteRB0NQnGYmja56D4mCbBpvflZkTh+wiHT2jKZO+V0fO0Erd5
	PISJGowRBgOpTKYsXy3dkhCendXXN77PAMhQiqzOXh6LR2hrgBRMC7iz+kHZtIfYc551jl+gbfl
	UdGI=
X-Google-Smtp-Source: AGHT+IGIOccHjWonqMh6MgWpEykK9Anbf2pkSPXkUY1K9SY7GpTRp/S1Mt8fo5h3PG7O1Tk4y5aQ1A==
X-Received: by 2002:a05:6214:459d:b0:6a0:a7a9:4988 with SMTP id 6a1803df08f44-6ab7f33865fmr20129356d6.13.1716381919783;
        Wed, 22 May 2024 05:45:19 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f17b4cfsm131592176d6.26.2024.05.22.05.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 05:45:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s9lLJ-00C8xv-OI;
	Wed, 22 May 2024 09:45:17 -0300
Date: Wed, 22 May 2024 09:45:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/3] iommufd: Use atomic_long_try_cmpxchg() in
 incr_user_locked_vm()
Message-ID: <20240522124517.GB69273@ziepe.ca>
References: <20240522082729.971123-1-ubizjak@gmail.com>
 <20240522082729.971123-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522082729.971123-3-ubizjak@gmail.com>

On Wed, May 22, 2024 at 10:26:49AM +0200, Uros Bizjak wrote:
> Use atomic_long_try_cmpxchg() instead of
> atomic_long_cmpxchg (*ptr, old, new) != old in incr_user_locked_vm().
> cmpxchg returns success in ZF flag, so this change saves a compare
> after cmpxchg (and related move instruction in front of cmpxchg).
> 
> Also, atomic_long_try_cmpxchg() implicitly assigns old *ptr
> value to "old" when cmpxchg fails. There is no need to re-read
> the value in the loop.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommufd/pages.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This patch may as well go through Joerg's tree with the whole series

Thanks,
Jason

