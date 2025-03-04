Return-Path: <linux-kernel+bounces-543004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82384A4D069
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C20B3ABDF5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59A02AEF1;
	Tue,  4 Mar 2025 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4D4wiS7d"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B276AAD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741049612; cv=none; b=C4h9WuwW1RARlWX4/+oz2HkjWAI74d6XLc7EUWXHn1gESpgu/Lwe3MQvO3knw3EsPd7um8m1ZCYChycoXIpSCQ+UMu12jloS61eitSZNKqvSicqZ1SK7c0SHWZRVohYnPvxJlzkomBfPL5rNOpdgHRMbnaY68vxfokXk2oTM68k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741049612; c=relaxed/simple;
	bh=0+mIMIMzFWzCOIWniwtvw+BDMmwo8z0nfLGggh6sfXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnJfd4GZqKfn1k95xUtOJQiOpfuMvBs5HZFOA2IibyAklmxPeP8FFQPB1FbWONbWc5hRCWV0DgqX24AN1vpZ+TVaGSqjk5Rr+Gd+EgyophpXzrPDpRH1IQPXi2oGDQ2b2wd5Y/Tbz9h4zNNLi8NbRP76tVNOUlY1xgOnCHTZ2xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4D4wiS7d; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso24675e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741049609; x=1741654409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QcGW3hftQvU3jMggm2moyLYr9Q6yInAQjdzrqRR3vjc=;
        b=4D4wiS7df92mNr2QgS0p55CGathGXzqSUOVVp/Hi3DlenyOnCi9bRnPqfm2UJziwD+
         gLZoq6iteIZGkOIZ9weeSZmHZzbsOrxGK8B+KmWJ7qSIvDdGH2+ler4pdvVTGGHy7UVs
         MyXE1/si54ZHEAqtgePuaJZdEAFNS6hk7whQ7RWW/1DtfOX4ROFiF+dPh+rRm18LnCA2
         7E2fnS34LJrPqbpL3q7HVX2o152tXaLerhnbeZ3jrzpiKQfoDCsdAvoFQGJQFapG3z4N
         lZxYykJpzTR/ihIabq516z3vSp1i+XGoCNy0+MCYKWr94LNJYK/vhRMu2+celgK3Qsmr
         eBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741049609; x=1741654409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcGW3hftQvU3jMggm2moyLYr9Q6yInAQjdzrqRR3vjc=;
        b=fX8dNZKig1ksJcYpMWIAt9wPxY+KqQKtwSo+PNm9g4HrtmpGQZrWeSyji95FNInNy3
         juFvZtxMpDehrODtAcLMGpyzT5+bCYmTKEpqZ1JOwYcSGkQigP4R/ixSlrNt9cY/ISSq
         LBb4pm4AR7e5C1Nmmlzz84WFz+8j65W9RAJFXFhiCOoek8Xv54YGaoLYlnbVXPYKgiOw
         zbOS1yI/PmCPsIR2YVVAW+1gBuAURLc8NsOT7+UxWJJAGyu6fkcBDowu/p+7N4fj7mdt
         iRKSTWOHvo+LDrczQCP25Gc6C0Cxj7m8CVkbSHQwOseMoLYLlFsqCDiqaWbL4ac/lsd9
         hC/A==
X-Forwarded-Encrypted: i=1; AJvYcCXtX+jaXjklYL9C+JzCRqlRbxco82nwETh4jwLLcId9BzVv1q9uXLsCPgcUmPty2EhmF1UG9asfcinMpxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRHsMZUqC92EBjazO/yXO/1pMKnQXw3vh5ngjwjMt9ShgZzkWc
	F+gzqC/0YVCf94C/+cacUFRYTLOySRwelI/teIzQPYmLMxL/XBuBkez84j++wA==
X-Gm-Gg: ASbGncs8/yzCX/lKMUVPQgRX/vP1I8wQPW/QMJt8Inw7zXyiGRRnJcmPi9i8JqmSYU5
	Iv6tBYxdAa0KXhCzAQz7yWPAnsoy6HXi44859d4NH/plBBFcE9G77CfvGRO8bppCLQ8fUQUacTf
	Xm2rtKLBIZRbadF+3Z5jhbMjEi++5rH9ADf4Qua7wLqIoBiLhkviQZ6Cd6bppzspaS0DJ6i2T+t
	KI30D33Dkn1O4W3lMlxb5FOXzoOOPFU09XvHOcRkmbU15kkOd6uL10GgfJiSOKkdS/Pd376hqvk
	fG5eQMBVsXXjFjEr9b5VI2ln+pApczyl40qRBPgXMTq3dDSFmyihq6VJ5RtQbQZo5hTjIJAxx09
	ml6PgRSzLqX1B
X-Google-Smtp-Source: AGHT+IGGyKa5a4dpqv99Cmt1pAVAafiGZn4JUYC2/5rtkoVDs1twq+6HqnYQlt8PwwJ67CJIVwLsOA==
X-Received: by 2002:a05:600c:43d4:b0:439:9434:1b66 with SMTP id 5b1f17b1804b1-43bcbe262d7mr265745e9.1.1741049608743;
        Mon, 03 Mar 2025 16:53:28 -0800 (PST)
Received: from google.com (100.235.22.34.bc.googleusercontent.com. [34.22.235.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4847fe5sm16074903f8f.73.2025.03.03.16.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:53:27 -0800 (PST)
Date: Tue, 4 Mar 2025 00:53:25 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, snehalreddy@google.com,
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v2 3/4] KVM: arm64: Map the hypervisor FF-A buffers on
 ffa init
Message-ID: <Z8ZPBZF7J-qKdb_i@google.com>
References: <20250227181750.3606372-1-sebastianene@google.com>
 <20250227181750.3606372-4-sebastianene@google.com>
 <20250303234259.GA30749@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303234259.GA30749@willie-the-truck>

On Mon, Mar 03, 2025 at 11:43:03PM +0000, Will Deacon wrote:
> On Thu, Feb 27, 2025 at 06:17:48PM +0000, Sebastian Ene wrote:
> > Map the hypervisor's buffers irrespective to the host and return
> > a linux error code from the FF-A error code on failure. Remove
> > the unmap ff-a buffers calls from the hypervisor as it will
> > never be called.
> > Prevent the host from using FF-A directly with Trustzone
> > if the hypervisor could not map its own buffers.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/ffa.c | 46 +++++++++++++----------------------
> >  1 file changed, 17 insertions(+), 29 deletions(-)
> 
> [...]
> 
> > @@ -861,6 +842,7 @@ int hyp_ffa_init(void *pages)
> >  {
> >  	struct arm_smccc_res res;
> >  	void *tx, *rx;
> > +	int ret;
> >  
> >  	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
> >  		return 0;
> > @@ -911,5 +893,11 @@ int hyp_ffa_init(void *pages)
> >  		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
> >  	};
> >  
> > +	/* Map our hypervisor buffers into the SPMD */
> > +	ret = ffa_map_hyp_buffers();
> > +	if (ret)
> > +		return ret;
> 
> Doesn't calling RXTX_MAP here undo the fix from c9c012625e12 ("KVM:
> arm64: Trap FFA_VERSION host call in pKVM") where we want to allow for
> the host to negotiate the version lazily?

We still have the same behaviour where we don't allow memory
sharing to happen until the version is negotiated but this
separates the hypervisor buffer mapping part from the host.

> 
> Will

Thanks,
Sebastian

