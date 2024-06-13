Return-Path: <linux-kernel+bounces-213150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE45906D64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CF81C23314
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45641474C6;
	Thu, 13 Jun 2024 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvmZNRGA"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83596145A05
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279748; cv=none; b=i9tW6hkfTUums/JrXMjYfg7NoUFpnORSxeK3QY4SQLl/ZytnQGFaVxdQDrwzJydbPXlCwoo8tSSFINAFImy8w8s6Lii1wYLf8+pnArpDY7tzh9DqCgib556sggWwlv3JDzk3CwMI/0ZWsrTQOxddQrpE3nHsWNTSDHG4TAniBLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279748; c=relaxed/simple;
	bh=zayRYx0j0HIZLKsRyHeMaNEFZNZDwo5WpQ/cssi8WOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se8pdFCcJQNPF1Pvi2oed403u3FZKV+TtYdogWw52H2iGnuuO6xJygA8BTEw3rqbnXZvkpZ4YMInRognHjwS8u9PotI6JYfI39r8MleqisZ/92h93Q7uCTCTEwC17BneLw+RdW0WngvNaCeTC0GbkmoNYomHn65YXa6rXtC6G8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvmZNRGA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f70fdc9645so118465ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718279746; x=1718884546; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EE1nN/bbZGwmk0UpB/fAkY4ALv0H3P02C8XfuKC6Rwo=;
        b=CvmZNRGAM5ryQxgIe6QTvQxoR9l/od9P5NRCCu1jf1h4xEeaA8wCrvbRUtstfgJYva
         Yb8/QJmak30frX+Bx4M+jJhHvqiIf8DvlOc8qkNCVWA52pMVBm+o7tq5fazTsYXSnPJt
         Vb67+PuF2snwxzj/NYo8Rhil3MMrjHGNPmxZlIMty4BfNWTxm/bJJuOB8R6HH28Exyei
         5arbxgymO5cjEc+g3XZPjJD4qTw1M2VfTA0ZvpiJ7qaD2beGbuEQSozgjsz6bfh9449H
         OgaEA7qK/ccjtrGpe3UYa9RgZboJSmoVhlgbqNnnWDNppXDoHXAtH3E32EnGx8F8zepH
         iCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279746; x=1718884546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EE1nN/bbZGwmk0UpB/fAkY4ALv0H3P02C8XfuKC6Rwo=;
        b=jNtK4bG1TQWsvZNnbtEOx68Wbv9OdaJ2x8sfRcqK3zSPpLV73zpX8QWnO5mqpYKR7g
         FqvegJ/WKRoh/9EuH3n9y2l84jwYTNxwLxnzuMBCLRTCEB/KmAw2zEzX8Bqk2TGING5l
         YdNNhpJIiCSqC2CbuXSSqh8WXW22y/aIYGKJFtMdUbbnmTo/qV3boBbs/yDEPZOFx75b
         +eq3RJ3xSSqw5/37v27tNJ4jrft5QgIJBwO3IMhj3vbsngIHjYjWYnuWdm+mX8J8ksxV
         855KQ4vFb0373lX8LTgc9hqBTxHb5us6YuF7Pogr9e+7pRY/9GpnqdQhwijpnYJQblBz
         n4hg==
X-Forwarded-Encrypted: i=1; AJvYcCULmhgEDrvp2X6UdCJ2KD+uL3cREgp3gp8AYBtKMY/tWob1U9V0XHHp6CB/JdJSsaWFJIA3ynOTxnYTSCAylaQXMXSJhB8cRX5S+k7H
X-Gm-Message-State: AOJu0YwXX3a1DkzoNssTpKVjP7pVjNpPW9fByQrvHcvbX+uDPmnZKbAi
	Je3+fUcbUtGn7hqmeAng/HprF/+m/qMJH6fcztVwkUBy6+DAqoSndihbkC3Sqw==
X-Google-Smtp-Source: AGHT+IG5IOEOepR0qdMVRmtxHZM0ZHQKWE+MvnTBo2aRyqmr9Ec2NAfOXkaUKM2+xp4/pE/pves/TA==
X-Received: by 2002:a17:902:968d:b0:1f7:3764:1e19 with SMTP id d9443c01a7336-1f84fde613cmr2805325ad.20.1718279745485;
        Thu, 13 Jun 2024 04:55:45 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45f8690sm1455192a91.33.2024.06.13.04.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:55:44 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:55:40 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, suzuki.poulose@arm.com, tabba@google.com,
	will@kernel.org, yuzenghui@huawei.com, lpieralisi@kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/4] KVM: arm64: Trap FFA_VERSION host call in pKVM
Message-ID: <ZmrePPCdc28OLyPb@google.com>
References: <20240515172258.1680881-1-sebastianene@google.com>
 <20240515172258.1680881-2-sebastianene@google.com>
 <Zmmph6YlIsBhJQqd@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zmmph6YlIsBhJQqd@bogus>

On Wed, Jun 12, 2024 at 02:58:31PM +0100, Sudeep Holla wrote:
> On Wed, May 15, 2024 at 05:22:55PM +0000, Sebastian Ene wrote:
> > The pKVM hypervisor initializes with FF-A version 1.0. The spec requires
> > that no other FF-A calls to be issued before the version negotiation
> > phase is complete. Split the hypervisor proxy initialization code in two
> > parts so that we can move the later one after the host negotiates its
> > version.
> 
> Blank line here would be nice.
> 

Added blank line.

> > Without trapping the call, the host drivers can negotiate a higher
> > version number with TEE which can result in a different memory layout
> > described during the memory sharing calls.
> >
> 
> LGTM(apart from minor nits),
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 

Thanks Sudeep, I will incorporate the tag it in v3.

> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/ffa.c | 123 +++++++++++++++++++++++++---------
> >  1 file changed, 92 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > index 320f2eaa14a9..72f1206c85fb 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > @@ -1,4 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> > +//
> 
> It should be OK but still spurious for $subject 😉
> 
> [...]
> 

Dropped this.

> > @@ -700,7 +789,6 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
> >  int hyp_ffa_init(void *pages)
> >  {
> >  	struct arm_smccc_res res;
> > -	size_t min_rxtx_sz;
> >  	void *tx, *rx;
> >
> >  	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
> > @@ -726,35 +814,7 @@ int hyp_ffa_init(void *pages)
> >  	if (FFA_MAJOR_VERSION(res.a0) != 1)
> >  		return -EOPNOTSUPP;
> >
> > -	arm_smccc_1_1_smc(FFA_ID_GET, 0, 0, 0, 0, 0, 0, 0, &res);
> > -	if (res.a0 != FFA_SUCCESS)
> > -		return -EOPNOTSUPP;
> > -
> > -	if (res.a2 != HOST_FFA_ID)
> > -		return -EINVAL;
> > -
> > -	arm_smccc_1_1_smc(FFA_FEATURES, FFA_FN64_RXTX_MAP,
> > -			  0, 0, 0, 0, 0, 0, &res);
> > -	if (res.a0 != FFA_SUCCESS)
> > -		return -EOPNOTSUPP;
> > -
> > -	switch (res.a2) {
> > -	case FFA_FEAT_RXTX_MIN_SZ_4K:
> > -		min_rxtx_sz = SZ_4K;
> > -		break;
> > -	case FFA_FEAT_RXTX_MIN_SZ_16K:
> > -		min_rxtx_sz = SZ_16K;
> > -		break;
> > -	case FFA_FEAT_RXTX_MIN_SZ_64K:
> > -		min_rxtx_sz = SZ_64K;
> > -		break;
> > -	default:
> > -		return -EINVAL;
> > -	}
> > -
> > -	if (min_rxtx_sz > PAGE_SIZE)
> > -		return -EOPNOTSUPP;
> > -
> > +	hyp_ffa_version = FFA_VERSION_1_0;
> >  	tx = pages;
> >  	pages += KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE;
> >  	rx = pages;
> > @@ -773,8 +833,9 @@ int hyp_ffa_init(void *pages)
> >  	};
> >
> >  	host_buffers = (struct kvm_ffa_buffers) {
> > -		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
> > +		.lock   = __HYP_SPIN_LOCK_UNLOCKED,
> 
> Spurious or intentional whitespace change ? I can't make out from the mail.
> 
> --

I dropped this, it was a spurious whitespace change.

> Regards,
> Sudeep

Cheers,
Seb

