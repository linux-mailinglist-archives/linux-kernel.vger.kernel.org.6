Return-Path: <linux-kernel+bounces-320714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB61970F6C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83260B20B04
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCCC1AE842;
	Mon,  9 Sep 2024 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxfeGGJM"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42F2AD00
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866180; cv=none; b=hIGLrTYCJWT7D095MkCnRj5LWe6xCE4JHbB/QxtcdeGPnCRnK0rXhtDtg6b4Frx8gvbEIG+uDuD3GVnzgEyDSrZEhc3+evvcF5jUZRYbf/h45/V+UsuZAJ+GjIgpjG/bguA5EHrF8rqxhYBY1rVP+HeM92cbBPC+oVeo6zUZ7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866180; c=relaxed/simple;
	bh=BjXsP4Mp690AnYXVBtGi2BkMgGrtsmKJ2olHdnk1un4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODMnGFV3cCVNAfqCsNv1Yi433B9gDOijswp3A4xZe6sQkWrbnOK5AGZsZ5gixyBzFwSIdWUqlqixvYhR7VN/EoBVSMHGyYf2/6123go3MwL3Kr8dZ/P/sh9E0QZnyVaNFQdCHMCt5coGW/bSJLfJRcS+BsvU2NDFfmpTax3OeyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxfeGGJM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42ba8928f1dso58045e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725866176; x=1726470976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VftkMC5+mYm3QQ3dWBsLEgURQE/0zJC3ZLx2ECmB1zs=;
        b=DxfeGGJMxOJvH4MbnucdhWwRaDM64KzH+fmtpW1NJsVuMsEPXnVoZdbdy2V/8ox+kj
         TTCqKzySOOBaz6lWjBoYZFEHPGTLAiFdZkii8nJYWJ9ImOnulszPMMkByd5s7VDbrdvD
         /wHnLuQu1QvR6voaR2lG6KPwicwMjx6kyN98X6PnmbAgwDhuf9z/o/qDtTrGF0yQc8N0
         Ox1XOyPlIBLXo/5FG4mIQPYTiTdhQ9rHSlC4UGA+pfDyczx/94y66HAuW8O+cYKKhFLI
         Edltq8fjBaBW8NnCzT6vW2gYSJOYL3U7LDYVwSCGZL80XSKou9rCJ+2woa6dWkWiKPmr
         LN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866176; x=1726470976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VftkMC5+mYm3QQ3dWBsLEgURQE/0zJC3ZLx2ECmB1zs=;
        b=rQMW7+4mCWlWsYEjjOwf/d4jebU4qL/dEUoUR28VEvmpK/3XnOiFj4jv7E9CqeGm2H
         bhBCXCNCFDole210rBB1N3Pm8qoFPh8cyHgTNZY13XvxLZm1eBD54LWrdwx1YtO+zd9C
         6GhsyoS+AIvAaQdSlv5GlqRqwDysfqGXZUurhnQRqPXmXk7xKnh0fkS96DZ0778eltXn
         LgYssVRt25M3cA+DXx0cwDhwuPP/2po6GgeSHpr1fV65BaHleutfG3KsxfzPzbyXlFzO
         bqRNf4STCyM+5mq0+FejYVODgAKTKDCvGvUAag/PKUSY0od2c2Kyrs0VgifMT/ibpvp7
         P8nA==
X-Forwarded-Encrypted: i=1; AJvYcCWgQWgVFd8Og/cUXp4EuCYGLiFubM5WP1vyJn1FoRu2FhdkTmxnn/jvdo1SUe6VvT5D8nP9oGvmF4l+6/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/n2otuDiJPVAWHTtmtL6iMGM25Zfj946nrLlewSLJtyx6Yrc
	ctBhc9MRlYxX/IPv3O0dfyhw0pP6OYmzoS5ywM543sZT/KxQEwyWPQHhAoHreQ==
X-Google-Smtp-Source: AGHT+IGOIkTSaWnXjE2bwYgTX4o/x860SYJOr8Q/IVHIUjLL5fLSHy00YIBudEH8NGk3Gpb6Mxcv4g==
X-Received: by 2002:a05:600c:3d17:b0:426:68ce:c97a with SMTP id 5b1f17b1804b1-42cae4bc174mr1825485e9.7.1725866175872;
        Mon, 09 Sep 2024 00:16:15 -0700 (PDT)
Received: from google.com (93.20.140.34.bc.googleusercontent.com. [34.140.20.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caf33e9b2sm65999675e9.14.2024.09.09.00.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:16:15 -0700 (PDT)
Date: Mon, 9 Sep 2024 07:16:13 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Snehal Koukuntla <snehalreddy@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Add memory length checks before it is xfered
Message-ID: <Zt6gvd4NwMmjS8JB@google.com>
References: <20240906092732.113152-1-snehalreddy@google.com>
 <86ed5wvixw.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ed5wvixw.wl-maz@kernel.org>

On Fri, Sep 06, 2024 at 05:35:39PM +0100, Marc Zyngier wrote:

Hi,

> Hi Snehal,
> 
> On Fri, 06 Sep 2024 10:27:32 +0100,
> Snehal Koukuntla <snehalreddy@google.com> wrote:
> > 
> > From: Snehal <snehalreddy@google.com>
> > 
> > Check size during allocation to fix discrepancy in memory reclaim path.
> > Currently only happens during memory reclaim, inconsistent with mem_xfer
> 
> Can you please elaborate? It doesn't seem to fail at allocation time
> here, as everything is pre-allocated. Some context would greatly help,
> as my FFA-foo is as basic as it gets (I did read the spec once and ran
> away screaming).
> 

Right, I think what happens is that we use the fragmentation API to
transfer memory to Trustzone that normally won't fit on the reclaim path
where we use an auxiliary buffer to store the descriptors.

All the descriptors are identified by the same handle and the reclaim
will try to store them into the ffa_desc_buf before nuking the FF-A
annotation from the stage-2.

> >
> > Signed-off-by: Snehal Koukuntla <snehalreddy@google.com>
> 
> The From: and Signed-off-by: tags do not match. You may want to add a
> [user] section to your .gitconfig with your full name so that this
> issue is sorted once and for all.
> 
> > ---
> >  arch/arm64/kvm/hyp/nvhe/ffa.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > index e715c157c2c4..e9223cc4f913 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > @@ -461,6 +461,11 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
> 
> /facepalm: why do we have this __always_inline here? Nothing to do
> with your patch, but definitely worth understanding why it is
> required.
>

I don't think it is needed, we can drop it. Maybe as part of this patch
?

> >  		goto out_unlock;
> >  	}
> >  
> > +	if (len > ffa_desc_buf.len) {
> > +		ret = FFA_RET_NO_MEMORY;
> > +		goto out_unlock;
> > +	}
> > +
> 
> It took some digging to understand how the various queues are sized,
> and a comment explaining the relation between ffa_desc_buf and the
> other queues would be very welcome.
> 
> I also notice that we have other places (apparently dealing with
> fragments) that do not have such checks. Do they need anything else?
>

I think we don't need that check in other parts.

> >  	buf = hyp_buffers.tx;
> >  	memcpy(buf, host_buffers.tx, fraglen);
> >  
> 
> Finally, this probably deserves a Fixes: tag and a Cc: stable so that
> it can be backported.
> 
> Thanks,
> 
> 	M.
>

Seb

> -- 
> Without deviation from the norm, progress is not possible.

