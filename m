Return-Path: <linux-kernel+bounces-547484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E227A50A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2BD7A539B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BD42512D8;
	Wed,  5 Mar 2025 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0v6V4HFR"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179E11FE471
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199768; cv=none; b=NQ49Dp+cIHm/GTM7jo2fGBzVgEKYkdmZsUb01uHStz5918x9ppKOaf2BQZHH51BaN2lp2h6pXPcz7MyJh/lDb0x6rr/4XG2fogxEsqljCQxkhhc6/0Rw9G7a1BWm6dcL4fjhS24Veed9AYU9GGcrxvXzCajQrbg2iGWH5q750k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199768; c=relaxed/simple;
	bh=jWgHSsvysebCfA2IEKJdsbWxkPfFdu8pzBR+/gIGIoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hx5UXrCiV5/g18vts1Jkz+bqdyCnzSGpFFCr/xGvH3dkbQd/lHZKP9avFRlRxwHEETcamb7sBrExlhkQpE0HEC9I4ia6JVnTNdOcCYgR/xDP8GRae6nBzpCIapQG0sOqLd5P/GKR/3NI2W74OFPbL5KRMlh5NDtoTbpq93KjqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0v6V4HFR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4393ee912e1so4795e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 10:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741199764; x=1741804564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a2OFT2OoedTJTEmeRVIN9FPGz/gwRD13KVUXjlzrTxU=;
        b=0v6V4HFRz2LuYzLPiClmWqWx44Kpmps34Un8JV1Lra3gvlYOnNm5/j/Zsyvxo286yT
         yr4LD7N7nUOhj/zL1pFhITtkLtxwbxxxdEFZOZkqLRzBZY0B9jf1yYPlkqcQiQuJBJgm
         D/BnUs9I2sYQHTe5ZHPNw1Y64pmzkzmWapgOm3mA/GGJK3IgnA4nSYMO+TkrXIlZz8k/
         y3fawhIxyk3hqEQd0OuVj1X4K6A6paoAfngRzSaYf/qDfj+4ctkDt0IQ/wZqkWRQPmEm
         BSp4hQlN6gGgYDijL74rOS2lSvGzwBv3NZ3UKHgvtGpc+N8MFbPs92bbQh13F2MnkhL/
         uXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741199764; x=1741804564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2OFT2OoedTJTEmeRVIN9FPGz/gwRD13KVUXjlzrTxU=;
        b=oh9uck2RLHQr70dWyZl9LMBpsNNL5b61hejM2tRTGBKNyFbZ7yR1chUOUq+X0bicHG
         M4V6EPi6TLU3w9Wpe8+GOKxtmxXbIiZW2CHtX7/wAE/lKUD8/3t4yAQsNNXY7PLLyZP6
         O8FtItCs2dnGkUF81mFkbhLDq9Q2hFvdjZT8WeI0HD/Qrhc8qdZdefNa/zfYBWqjE0fw
         ak0TOa6AtkyAMqfLP/QtIjbBMfFkQzA6V78G0WVTfmezqwmpePoUVHK8/pAnJ6SNJu+a
         aPn24UIuS4+kWZZnEYQReJYy+EoBs0ektB5njmPJYZYv9VUtBx4g8eZYHFjZpGYPfVEa
         tU6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeaZBxPPBIoCwNynP3Aa2VOQ4E0epR9YfEfEiTskwNGBoTgbzzIRxsbK/YnubUiLaT/R0++KAOK4q2ChU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztbWo5iaiqnv25uWsXt2q9Q3qdCe8mHbOHDmLoxrEDv0ZR+YdH
	MLxhRGYyxOk6xxB0IYmqJ3r7udvsOpU8tqMLqV7kB1Yywfjda0rvjyklONDk/mdTGIA8myPv01O
	+oZcH
X-Gm-Gg: ASbGnctsFgZxJtBhDz4CSawQknvxB7an3O8LDUZduwtk6DT1BkhUaTsAKzZt1NypFao
	SeemzZmzXb0BIeLBH+INIlqVy5DuogAUoeGY/7OrvEmgFjdYWVjIJMxDlRwdfUkLMDpdetsWeyX
	EcsJ/7hZrwlK8ToQnK/iesc+MWo5gQbvE6Y3W+z0R9+3VR694Hm27fRpCNdVnaA7uVNzJOCwI8v
	1dpd076J/eijvdZBlgTnUhwA5UK6UXshIxMJgSZ+YVSWWno6QR9gCiwGg8Nm5ZTwjWj0fzn2b2p
	SMMKQdbykSzo3o0oD+pQrAtry9bPvowbV0X13vlbp6xSUENcSauC+c52MQ1N7AK275nJ7qZziXz
	LWK5StqW1mznL
X-Google-Smtp-Source: AGHT+IGuoCdVlssAi/H3pLNOEjzh/d6m6UEnCFgp+MZSf4rv9zgHb14AznLZkDz+7g00rolvyanVzA==
X-Received: by 2002:a05:600c:22d0:b0:43b:bfe6:d898 with SMTP id 5b1f17b1804b1-43bdbac5f6dmr43995e9.0.1741199763997;
        Wed, 05 Mar 2025 10:36:03 -0800 (PST)
Received: from google.com (100.235.22.34.bc.googleusercontent.com. [34.22.235.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796600sm21673887f8f.20.2025.03.05.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:36:03 -0800 (PST)
Date: Wed, 5 Mar 2025 18:36:01 +0000
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
Message-ID: <Z8iZkQHknZfY7mpn@google.com>
References: <20250227181750.3606372-1-sebastianene@google.com>
 <20250227181750.3606372-4-sebastianene@google.com>
 <20250303234259.GA30749@willie-the-truck>
 <Z8ZPBZF7J-qKdb_i@google.com>
 <20250304015633.GA30882@willie-the-truck>
 <Z8c6enoolJe7Zeqk@google.com>
 <20250305003808.GA31667@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305003808.GA31667@willie-the-truck>

On Wed, Mar 05, 2025 at 12:38:08AM +0000, Will Deacon wrote:
> On Tue, Mar 04, 2025 at 05:38:02PM +0000, Sebastian Ene wrote:
> > On Tue, Mar 04, 2025 at 01:56:35AM +0000, Will Deacon wrote:
> > > On Tue, Mar 04, 2025 at 12:53:25AM +0000, Sebastian Ene wrote:
> > > > On Mon, Mar 03, 2025 at 11:43:03PM +0000, Will Deacon wrote:
> > > > > On Thu, Feb 27, 2025 at 06:17:48PM +0000, Sebastian Ene wrote:
> > > > > > Map the hypervisor's buffers irrespective to the host and return
> > > > > > a linux error code from the FF-A error code on failure. Remove
> > > > > > the unmap ff-a buffers calls from the hypervisor as it will
> > > > > > never be called.
> > > > > > Prevent the host from using FF-A directly with Trustzone
> > > > > > if the hypervisor could not map its own buffers.
> > > > > > 
> > > > > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > > > > ---
> > > > > >  arch/arm64/kvm/hyp/nvhe/ffa.c | 46 +++++++++++++----------------------
> > > > > >  1 file changed, 17 insertions(+), 29 deletions(-)
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > @@ -861,6 +842,7 @@ int hyp_ffa_init(void *pages)
> > > > > >  {
> > > > > >  	struct arm_smccc_res res;
> > > > > >  	void *tx, *rx;
> > > > > > +	int ret;
> > > > > >  
> > > > > >  	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
> > > > > >  		return 0;
> > > > > > @@ -911,5 +893,11 @@ int hyp_ffa_init(void *pages)
> > > > > >  		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
> > > > > >  	};
> > > > > >  
> > > > > > +	/* Map our hypervisor buffers into the SPMD */
> > > > > > +	ret = ffa_map_hyp_buffers();
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > 
> > > > > Doesn't calling RXTX_MAP here undo the fix from c9c012625e12 ("KVM:
> > > > > arm64: Trap FFA_VERSION host call in pKVM") where we want to allow for
> > > > > the host to negotiate the version lazily?
> > > > 
> > > > We still have the same behaviour where we don't allow memory
> > > > sharing to happen until the version is negotiated but this
> > > > separates the hypervisor buffer mapping part from the host.
> > > 
> > > Sadly, the spec doesn't restrict this to the memory sharing calls:
> > > 
> > >   | [...] negotiation of the version must happen before an invocation of
> > >   | any other FF-A ABI
> > > 
> > 
> > We do that, as the hypervisor negotiates its own version in
> > hyp_ffa_init.
> 
> hyp_ffa_init() only issues FFA_VERSION afaict, which is the one call
> that you're allowed to make during negotiation. So the existing code is
> fine.
> 
> > I think the host shouldn't be allowed to overwrite the
> > hyp_ffa_version obtained from _init, this feels wrong as you
> > can have a driver that forcefully downgrades the hypervisor to an old
> > version.
> 
> I think that's also fine. The FFA code in the hypervisor exists solely
> to proxy requests from the host; it's not used for anything else and so,
> from the host's persective, FFA should behave identically to the case in
> which the proxy is not present (e.g. if we were just using VHE). That
> means that we're doing the right thing by deferring to the host for
> version negotation.
> 
> Are you saying there's a bug in the current code if the host negotiates
> the downgrade?

It is an issue *only* for doing guest-ffa (which isn't posted here yet).
If we allow the host to dictate the version & there is an issue with TZ
FF-A dispatcher in that version => the guests will be affected by this
as well.

> 
> > We need to do three things, Sudeep & Will please correct me if I am
> > wrong, but this is how I see it:
> > 
> > - the hypervisor should act as a separate entity (it has a different ID and
> > in the current implementation we don't do a distinction between host/hyp) and
> > it should be able to lock its own version from init.
> 
> I strongly disagree with that. The hypervisor isn't using FFA for
> anything other than proxying the host and so we don't need to negotiate
> a separate version.
> 
> What would we gain by doing this? Is there a bug with what we're doing
> at the moment?

I think we need to make a distinction between the host and the
hypervisor when we are adding support for guest-ffa. We currently have
the same id (== 0) for both of them.

> 
> > - keep a separate version negotiated for the host
> > - trap FFA_ID_GET from the host and return ID=1 because
> >   currently we forward the call to the TZ and it returns the same ID
> >   as the (hypervisor == 0).
> 
> Why is this beneficial? It just looks like complexity at EL2 for no gain
> to me, but maybe I'm missing something.
>

Because the host can impersonate the hypervisor using ff-a direct calls atm.
and we are in a position to restrict the host from playing nasty games
with TZ.

> Will

Thanks,
Sebastian

