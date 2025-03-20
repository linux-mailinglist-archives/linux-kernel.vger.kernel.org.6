Return-Path: <linux-kernel+bounces-569361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B950A6A1E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDD81744BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FD621C9E1;
	Thu, 20 Mar 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bin6yOCT"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4052AE74
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460822; cv=none; b=pYHoedhMzBz8UFsEFyMBB0ZlHlyRPR7B3wFCthD3zuqzJcrmxU4Ml+2CjMl1LpGy6VyeUrVfXEBUikA7P2IcQjjaX92iNDZMxnidZnI5AfrxnBfEqMqmbtFB2pYmN+SS4/P32cmmmyPi6cvcyR6YiGSb5lE+l/odB9C4CMvqrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460822; c=relaxed/simple;
	bh=y3Cp/rR1QpScC+x03y/C76tenIDZqGYsuw2cyuaBGnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJ1ZR4cOWyXS84d7fOPkUuIssc4IAZJ7y4sbwHGIa4PJRArne7Fwvlnsq0pThTHEsHzr7GZc7FINFqAHGBc9AhnfWe1K3K3jvKeM3bnlqTsqYM8SrQL7hKxgJ7SWg1BL+49xytgOpG2jEOD+8AY7KhruJS+aL+FLOHQLVcsqZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bin6yOCT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso2993035e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742460818; x=1743065618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KnFSXct6epNrQpkkv+yjVEVzsh1c64Flg8Y81A0Hvc8=;
        b=bin6yOCTCmeuGJUEor0aS6iLGL47XUdDOJ8RwXES39JFNWxSI1rLgIYG9uWXykKjq4
         cIFf6O6D/0WbInEEqU0tN5/w0pn99RNp+hOFtrSyx8E0WjVPMSBKj942Sb2spQLtt87t
         yZE4JUkK1kQuLtKc2e6N66ZZU2vCrb/qXnBqqNknKNKrpBZOB4B86hQvtt6c8hUX+1IC
         BcWD1j6/VjebpTifxi6ULOh8XjLUPbEggnVOWaVu9WargHqser6AHAEZMyvmNmJMvedB
         5zXUJ8XYtmLjJLPddbJFIn4R+VhdsegffQUV7u/Ed9p6uE6gKKO2eGAP6+SgyFg40Qbz
         N7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742460818; x=1743065618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnFSXct6epNrQpkkv+yjVEVzsh1c64Flg8Y81A0Hvc8=;
        b=uKshUSYuACxQ69FirafXZujbBmx6SSPRLdyfGOnjnJsi44M2E8busd68q/lSdNl21A
         ghso5Yxbrkd+4GNYr0eJs00P/DTj+1hbhbcTOuTRtbmzhlwEnH/AsjrhCa2KflqQVzHN
         K7zmd9OOBFO9lNSqZ1ySfq5SLSsYkfpRmWtBJI9P8moK2EcUkiHjJsvFPdpGGPpLu3vw
         9OzVwpH4SEdf+QwgXSPdWEowO9Jj2isObiV4vmYe6CFvW+timXzMyJyKh6hfTUn7WeXQ
         S6fUFTxn8YVkU1mr3+TRNsOBSpp/MAuUP/znVNboZ2hR69cB9E8ixQpYSKLIvJl+vhHa
         vWzg==
X-Forwarded-Encrypted: i=1; AJvYcCUBADl+rb1W5aaG4LjyDSe5lDXbWektodkdXOLq7g0XXkrh/1kfsu3+pj06oTr6VZraH3U4vrDl2iLcFC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypxC5aLGkTMhx280m9Z+yXg/4lhBIU9FhA/RxndCXo/TG25QY+
	shw2OFJFpVDWob+/1hVMIC14QBhcSMKGQY198DG4/lViKL7AZ0dZ0/8KC6m+IQxhwzTxb59SbZ3
	G
X-Gm-Gg: ASbGncuJuvQXEXce/YcQAzoPT2Lj5G6aCbTgbh8SvkQZMBWLRrjwFmaJ6AdQt6erNjc
	vow6byAjjMuXfaatRsAo8mXmreQqOYugj6J+BFSipNysOBtJfNab534Wjg2djPQLheirzu7ZbCV
	4N3InRBcxjqNe+d+ISCRTTCeEUQnHH2cuIg+zCGnX/z5awTuqvDXy85wYbCPu59XbuLmZFLXrpQ
	LBwlslv6ATdkRU6Nf8Ow6w19P4+ufHZ8b1J+qbFQBOSMsXtXM5LRrA/0pdkzds76w+8D7ULR8bM
	jzIcEGSLxLZ2GWKQkglg5DHHDXyfZH1xUGeAf44SvO6ee4GGDw==
X-Google-Smtp-Source: AGHT+IE5XfB71cllV/n5EH1T284eA4sduFcvd6HSLYQ1/iWgIzjCRYet+uoDCJ/LzmZ1nTW11RBTYQ==
X-Received: by 2002:a05:600c:cc8:b0:43d:186d:a4bf with SMTP id 5b1f17b1804b1-43d490d2411mr21934425e9.0.1742460818458;
        Thu, 20 Mar 2025 01:53:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f37665sm42436645e9.2.2025.03.20.01.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:53:37 -0700 (PDT)
Date: Thu, 20 Mar 2025 11:53:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/amd: Return a literal in init_gcr3_table()
Message-ID: <f688c2a2-a4d9-42c4-bf09-5ecbdbe9c9b5@stanley.mountain>
References: <960a6d1a-63d6-49e8-890c-5e8a66e50c45@stanley.mountain>
 <faa7edf4-a757-4390-8226-2604ef6476d6@stanley.mountain>
 <Z9vLuWvzVJOyuuWu@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9vLuWvzVJOyuuWu@8bytes.org>

On Thu, Mar 20, 2025 at 09:03:05AM +0100, Joerg Roedel wrote:
> On Mon, Mar 17, 2025 at 09:43:32AM +0300, Dan Carpenter wrote:
> > This code intentionally returns zero but it does it as "return ret;"
> > Returning ret looks like an error path where return 0 is more
> > clear and looks more intentional.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/iommu/amd/iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index ce2626801ddf..7cbcc4933c8b 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -2150,7 +2150,7 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
> >  
> >  	/* Setup GCR3[0] only if domain is setup with v2 page table mode */
> >  	if (!pdom_is_v2_pgtbl_mode(pdom))
> > -		return ret;
> > +		return 0;
> 
> There is another case of this a couple lines above in the same function.
> Mind changing that as well?

Thanks.  Happy to.  I'll resend.

regards,
dan carpenter


