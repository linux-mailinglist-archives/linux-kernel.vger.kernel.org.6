Return-Path: <linux-kernel+bounces-545218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA688A4EA68
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E6417C161
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09AA2980B4;
	Tue,  4 Mar 2025 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIrD7qTQ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F6250C16
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109889; cv=none; b=KUDIEsQrj0LhCiWlOfG+s3o0sGzSujX+qx5NIu/CdJ91ygq9aEp5Hvp/a1zmXVOhx9uQRZI9z21zyPLd4+GsL6MltNLy7Intlwup+51JUlREX5cI1w+tm3BCUm2oKhjCqe85ID6oNPVwUJ0qSxhUu60DXW1fhCNTf1kMAlZecF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109889; c=relaxed/simple;
	bh=YBkjs7x4M5DA1yV1fs8+DwMnIWeKn75JE8veC9jpzm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0WaVk5P3KUSrUvIsk2pXIXTLZU0rcHUCnWKCS0GdFNXwCOxOjjF6gT8z1Otnp3QLNE1/Ni8mFaXkHciztteHd0+t0Gwqk0+E61TfhtDWv3XIwEcs/RaO1ArG8MZlJPPCgDtjcMhkJ6JwZ8Hlxqf/9RU+P+othwPN63YnZ9mfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIrD7qTQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ba8a87643so425e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741109885; x=1741714685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hL600D2Vd4+7j33RPgiVpKbsOkzk21To6aEbWxtha+U=;
        b=PIrD7qTQjpprxTmIkDqc7CVUQigYvKCseMPinBjFSv2zywziTKRDrr8rWJmQXfG8AZ
         1+dgBB+Qds/n65dG1Viz/6rakSVE06WpPHZCc6d2vuQmcnDQ+R3QxylEQbxEZjpnB8Vx
         revi006iFEIs73/RtYdblXb3rlIPUWSRva2jboUICdLkUzoaYrEQO1Gs1kgfTA2xiWXa
         F2/WVqVyVyhTNdIsV/Y6/KtwbSXKAkSMKehcUaa6TEKrU757pAWLMq7JNZ3p/ILKBhqj
         +TPa12cWnmvaNPGd4mHgKFKGm4GRQ5KqcFNOFXFMWgrAj2Bz1aUngoJq5CYV5X3OCW0+
         tWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741109885; x=1741714685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL600D2Vd4+7j33RPgiVpKbsOkzk21To6aEbWxtha+U=;
        b=OHLc6ejNBjjiJWeOuO5RRSxrqJRB0Gk3SMIuDKMDOw0PoRKhBeXmnUtEPQ6ZbjUGVt
         uA9eMvwLu081/mCdwEl/dP3lw4SPbE2fSFGGjwa8XQkz59EjpT8lW0zJMZVuBPNlnF3w
         /xjQ+rbW3h4OUz93GIjaW4B2dSOrsk0/j1GXbaVbixtgnRLoLnzE4jbRAm8KucwL+iIz
         1dwP+xICGZn799buThs7wPc1Cq+HG86tJD37alR6VloG620+MYJf2WmRJZR8OKwF19sK
         yYLWnyuPvEMuT1iJHE5Ddd59jpH4agTgIV9dW6UB7erDcidayWVEWCgtApzijx3FS2yD
         FmXw==
X-Forwarded-Encrypted: i=1; AJvYcCW/xHT4RUDEs48FtyK0ySmtRrIGigLYGOgU7+tsNJK5K07UJkP6xWNoeIeIo0ozdspZxpJNn4pnpaBKFns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWVdbto9E572JbZFGL99yTsQ+aUhfjuCbddbik5fRvwDj6p0Nu
	dxKTJ1gZnFjSccqgc8BE0OdzWSjK10ZXqHItLdzI3lKn7fEHxHZ35mATxO1uUw==
X-Gm-Gg: ASbGncvYN6OgofSCMvWFOCtAYzAYhs2uoAV/87ZFpWu1zTD1QGoiMuvvSQ5uYdPEI0k
	0o805TVFaW/FRVwUo9poeud8JY9V8I4zSXwPXWxjbHJkfhojRuOxJUx42MIUV6itR5RQ6XJr2ip
	TEqYzbhhZunqk21fO8hWGrqTmC4F+zX8Vz1TXTQ53zyfVpG/2hl7O1kTQ4ecEuhR6zPDrqYdd3s
	eo4P6Mm4T1cY6u6vli+7YSAygCEB649XJ2pkRtb2uvtfFg3tF7QgoK9jyYX+EkyTCNTMJsGT93o
	LNpOryIvNUFe/vhYvVxmE10MlNC4DnUYxKDMU6GdPYM8ofd4EgnTcEaGuiOSnmkc1Exvih5Xczc
	ivhpPGcVvDLin
X-Google-Smtp-Source: AGHT+IEpl5KnI/AmOBYa3wPD1FFPvleHPCRAbMj/fSXQ1+Q66fw7eWALywPcXdmGSME1S33/iyh4Iw==
X-Received: by 2002:a05:600c:329b:b0:439:9434:1b6c with SMTP id 5b1f17b1804b1-43bd15f3ffamr165995e9.3.1741109885428;
        Tue, 04 Mar 2025 09:38:05 -0800 (PST)
Received: from google.com (100.235.22.34.bc.googleusercontent.com. [34.22.235.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d906sm18464176f8f.90.2025.03.04.09.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:38:04 -0800 (PST)
Date: Tue, 4 Mar 2025 17:38:02 +0000
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
Message-ID: <Z8c6enoolJe7Zeqk@google.com>
References: <20250227181750.3606372-1-sebastianene@google.com>
 <20250227181750.3606372-4-sebastianene@google.com>
 <20250303234259.GA30749@willie-the-truck>
 <Z8ZPBZF7J-qKdb_i@google.com>
 <20250304015633.GA30882@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304015633.GA30882@willie-the-truck>

On Tue, Mar 04, 2025 at 01:56:35AM +0000, Will Deacon wrote:
> On Tue, Mar 04, 2025 at 12:53:25AM +0000, Sebastian Ene wrote:
> > On Mon, Mar 03, 2025 at 11:43:03PM +0000, Will Deacon wrote:
> > > On Thu, Feb 27, 2025 at 06:17:48PM +0000, Sebastian Ene wrote:
> > > > Map the hypervisor's buffers irrespective to the host and return
> > > > a linux error code from the FF-A error code on failure. Remove
> > > > the unmap ff-a buffers calls from the hypervisor as it will
> > > > never be called.
> > > > Prevent the host from using FF-A directly with Trustzone
> > > > if the hypervisor could not map its own buffers.
> > > > 
> > > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > > ---
> > > >  arch/arm64/kvm/hyp/nvhe/ffa.c | 46 +++++++++++++----------------------
> > > >  1 file changed, 17 insertions(+), 29 deletions(-)
> > > 
> > > [...]
> > > 
> > > > @@ -861,6 +842,7 @@ int hyp_ffa_init(void *pages)
> > > >  {
> > > >  	struct arm_smccc_res res;
> > > >  	void *tx, *rx;
> > > > +	int ret;
> > > >  
> > > >  	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
> > > >  		return 0;
> > > > @@ -911,5 +893,11 @@ int hyp_ffa_init(void *pages)
> > > >  		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
> > > >  	};
> > > >  
> > > > +	/* Map our hypervisor buffers into the SPMD */
> > > > +	ret = ffa_map_hyp_buffers();
> > > > +	if (ret)
> > > > +		return ret;
> > > 
> > > Doesn't calling RXTX_MAP here undo the fix from c9c012625e12 ("KVM:
> > > arm64: Trap FFA_VERSION host call in pKVM") where we want to allow for
> > > the host to negotiate the version lazily?
> > 
> > We still have the same behaviour where we don't allow memory
> > sharing to happen until the version is negotiated but this
> > separates the hypervisor buffer mapping part from the host.
> 
> Sadly, the spec doesn't restrict this to the memory sharing calls:
> 
>   | [...] negotiation of the version must happen before an invocation of
>   | any other FF-A ABI
> 

We do that, as the hypervisor negotiates its own version in
hyp_ffa_init. I think the host shouldn't be allowed to overwrite the
hyp_ffa_version obtained from _init, this feels wrong as you
can have a driver that forcefully downgrades the hypervisor to an old
version.

We need to do three things, Sudeep & Will please correct me if I am
wrong, but this is how I see it:

- the hypervisor should act as a separate entity (it has a different ID and
in the current implementation we don't do a distinction between host/hyp) and
it should be able to lock its own version from init.
- keep a separate version negotiated for the host
- trap FFA_ID_GET from the host and return ID=1 because
  currently we forward the call to the TZ and it returns the same ID
  as the (hypervisor == 0).

> We're also probing the minimum rxtx size in hyp_ffa_post_init() so doing
> this here is doubly wrong.
> 

Those operations should happen before the current ffa_map_hyp_buffers()
call, I agree.

Thanks,
Sebastian

> So I think we should probably just drop this patch.
> 
> Will

