Return-Path: <linux-kernel+bounces-329865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613B79796D4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08417281D4E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAFD1C6890;
	Sun, 15 Sep 2024 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n9JhpjlF"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6811C3F2D
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726407301; cv=none; b=K3uL10AP81yGXt/cxDjYfRFr/WtRebAkvU73I37chDAuQiUqeGSAJ4iqO2P1nAJ90LTdfOKydKPbkGsWmpG/KkgvK51VBSaItZEoYrZBq1WXiIuwLDmjBfvcMOtMUqn9K5B1JtggMRTVDxGkTZzsFaUKi+MBYOApCrIdbhv+nf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726407301; c=relaxed/simple;
	bh=X2wD22xk7tFXAwR63ETP7DqDd/DUgEhE0FiZJsfQzSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjydrTE8ODWFbUuQQYobpnlv7b5QMeGDq02tLkCQO3LAfGgQ3YgvxUHkeoiw86B+8oqxvbK6CWwOaWbtTPvh7jQUzDtYL1ihYRKuPI9ubv5Qh/8jMWQqJFWPUQzFQR0GljUpyjRdwx0uLyzvhqWNCDvdMax86H/387JacbB6Li4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n9JhpjlF; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a9ad8a7c63so280939485a.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726407298; x=1727012098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sNVaybNfCclOWFZMEk5kFAnFK+GkHudEqnaQn3thCwE=;
        b=n9JhpjlFG0qIS5gVzRPV+Y+UCHWtz07I4VgqDWZRyv2TGZmxXqDcmmdxOY9xc6qigK
         Bc38mFsfK24psYaybJlpip7HS5RK0K+4+xfjHiw0sV7L0/LjOD8MbkBDrN4loUvMQr2O
         AaqQ3n182xkPDUD91NEjvBEmZryxYibdM8krQRQPSRosX+Z7KD9BbiJBZoqBHS3PyyZt
         AyL3qXudJu8JE4J+hF3VVFWkKh9ATzOSotbXxAtcyQMLoxvE9k9QC2mbgNfigOocs1m+
         GyTLNziaFsB9+2cN/rO77wn9hBYflYb1sWeM6nqJ3CUZemvGPDWxTKbpAYx3yTk0Q2/6
         qU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726407298; x=1727012098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNVaybNfCclOWFZMEk5kFAnFK+GkHudEqnaQn3thCwE=;
        b=nF5EeeTcxBfMYJb6YqI4r5V4g/cJ1galu2S6WS0EK0EFL0FRAe99dER0/hSe9ke7BJ
         Wj1zuNfy9pbVjlI5vmPEuq701H6Y2qcJPhwyMfPt2+RAI96ze7vJguy/1GUrrIPtdRPH
         XFiPzJJRZVLbaw2aQ3nYweq6vhdzwOCVQ6j6Sn16vip3KkTM4Eg3sCLkHRsUmS8WPkvK
         a2vPrlmVNtoIss9/HhnHVyENot7TBpNpx34PzyrcFe5EWjVq9kWZOLjriJ4NxOATawIw
         Iem5TsH2f/OTeKxm61K0D96YZTrWAonv5KT2LpDPLjskssjROmB2SkineE6n67z/ut9g
         UU5A==
X-Forwarded-Encrypted: i=1; AJvYcCUma3Wh+nImYOl7bLGcUgky0Ds4010wLrKDMsoeGg639GjF4b7Xuist6LAnA4gGhcL5R4c2uV8ZQWyQwQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUXm+MOLcHb7tqhXg3uTHU/w0H+7qKrmkkXTCdokGBPig7lHX
	OxlkrCfyd5oTF1vzEhavM5onujR93onI39oe09CkZP0kvwn3PWwPqP8SMPTbsnUg8idtnRRd5W4
	O
X-Google-Smtp-Source: AGHT+IGpejFQSxVNUXQgQSyVFrKAp7XcRW2C1H1uKGdGS4EVAxAOTeB5gcQr8nfsTUmJFDjWMYNKSg==
X-Received: by 2002:a05:620a:1a2a:b0:7a9:bd67:f12a with SMTP id af79cd13be357-7ab30dcb639mr1436556185a.62.1726407297921;
        Sun, 15 Sep 2024 06:34:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c6421b7sm15792096d6.58.2024.09.15.06.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 06:34:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sppOy-007akf-J7;
	Sun, 15 Sep 2024 10:34:56 -0300
Date: Sun, 15 Sep 2024 10:34:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 for-next 1/2] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
Message-ID: <20240915133456.GA869260@ziepe.ca>
References: <20240905131155.1441478-1-huangjunxian6@hisilicon.com>
 <20240905131155.1441478-2-huangjunxian6@hisilicon.com>
 <ZtxDF7EMY13tYny2@ziepe.ca>
 <d76dd514-aceb-b7cb-705a-298fc905fae3@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d76dd514-aceb-b7cb-705a-298fc905fae3@hisilicon.com>

On Mon, Sep 09, 2024 at 04:41:00PM +0800, Junxian Huang wrote:
> On 2024/9/7 20:12, Jason Gunthorpe wrote:
> > On Thu, Sep 05, 2024 at 09:11:54PM +0800, Junxian Huang wrote:
> > 
> >> @@ -698,11 +700,20 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
> >>  	ucontext = ib_uverbs_get_ucontext_file(file);
> >>  	if (IS_ERR(ucontext)) {
> >>  		ret = PTR_ERR(ucontext);
> >> -		goto out;
> >> +		goto out_srcu;
> >>  	}
> >> +
> >> +	mutex_lock(&file->disassociation_lock);
> >> +	if (file->disassociated) {
> >> +		ret = -EPERM;
> >> +		goto out_mutex;
> >> +	}
> > 
> > What sets disassociated back to false once the driver reset is
> > completed?
> > 
> > I think you should probably drop this and instead add a lock and test
> > inside the driver within its mmap op. While reset is ongoing fail all
> > new mmaps.
> > 
> 
> disassociated won't be set back to false. This is to stop new mmaps on
> this ucontext even after reset is completed, because during hns reset,
> all resources will be destroyed, and the ucontexts will become unavailable.

That isn't really the model we are going for, the ucontext should be
recoverable even if the objects are not.

If you want to really fully destroy and fence things then you have to
unregister the whole ib_device

> > I think this doesn't need the hw_destroy_rwsem anymore since you are
> > using this new disassociation_lock instead. It doesn't make alot of
> > sense to hold the hw_destroy_rwsem for read here, it was ment to be
> > held for write.
> 
> Then it seems we should remove the lockdep_assert_held() here?

Yes

Jason

