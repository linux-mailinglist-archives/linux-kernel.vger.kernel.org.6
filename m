Return-Path: <linux-kernel+bounces-559084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F84A5EF59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12EE817512D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D359A264A71;
	Thu, 13 Mar 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2sTirQ1o"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1038D261566
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857399; cv=none; b=EfzlTMJHlxDn0ox1U92MIaNyhxODO8o2ztc7qOO8sop8OTkTXZkAqiudsusxID/qzilAbQKlXyX9rGNQR9yrBBijHRwX9T/DrhTKLLiD8hb3X/tuzekfKn6P7OgORH4A4BB15/nq0k/lZLsmMAXKiCVGW5JElaNv7DfUZLihvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857399; c=relaxed/simple;
	bh=vnGU6xsEnDEuWbgq4Zq5jcvdO7OIoOn4KRQG+0RDXz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muizIOEhkEtnwwpx/c1xsdwfaymath+Xu9MuJhckaKk/yO49LYH3pCTMMOF+Hu1X3GUNchYQyVmEQz3A11vgV3xU/rR6ZdlBmbbdsPKYeWTfOhqS41iVwwmX3sZ5l/2cuMMqhQXQ+Db+YV9z6zS9D2RSrLbve7u5gkRZYJOmKjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2sTirQ1o; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-391342fc1f6so644596f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741857395; x=1742462195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxWaN40Gu0y4wmPgUEJqr+nQuSXPrmjIwZFj0rXa2nA=;
        b=2sTirQ1o/3vW8TQy/uRARNLSxO/pio+bTr3u8xKGBmOMQ3cWHTh3sKxASKR8aKePfQ
         GQm98dY3MvL7gm2XLJOxqxDjQ0AmQBhLj9e7i4wBFbckJpn4bvy5pi4bda3FHdYdLUHB
         pAZukIwceMI0b03F/1xJSUHju8Ma1oE9W1OfFWFb4UMWdlWPeJjkLEtvWck2tG+seZIP
         O0VzIg+OiG5HYkr4mgMxqjPa+TRCLSk2NCoJd6eeEP7Jv2KubCrRS9OZ8xtQnYqgR3BF
         ewQ/pwxFzdBgz6dF6KYqcRIQM2dcLAf4OUwKsntjLn73fQCDM8GSqjU9Tx9a8oV55AeX
         0bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741857395; x=1742462195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxWaN40Gu0y4wmPgUEJqr+nQuSXPrmjIwZFj0rXa2nA=;
        b=niVvnjQhTT9e5oR6ZQafUAot8b+ZoGKKhPQ0ABu477lh5iwQC95kfPOv17qwzyFTTN
         80WHyQO1qS8dy8Xbrpzyy56ZL4sy72HgT5bCfdhhY/U7wBv9PV3EhliYJtnI1wgTpAPF
         29hL1xane0gPrmi/JWFLBl2H/Gvd0pK81MJTqRklmmBtSvbuWzU+AB4o9QpyHw1+gpIQ
         FFXJDBo9T/povIcEsVH3MolHAPm7VUrp7ZoBu23bbJD8L0Ckg6ez/tixRkBVhQcaJQjR
         Ciu46kKdYRYgNEZcoe5r0lswsk8//bjgKY2tz3HIIKbIdryRudBWfkDubWs55OMGEw9R
         cJ8w==
X-Forwarded-Encrypted: i=1; AJvYcCWdL1dpf+Z+qEwUVv2mH3v8oTeQMgUGPLgytpUdlmhFaRfR3XUxJomoI7bM5PRqFE0WKgKMpmmsTnMJDXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvI60aLuZ14qE5y/f6IwC24eWGiLVnq2bvvE5hVOBVySe880RD
	eM2Q6V+XsvPGv8BisfFVqWXD0ixDHoirNzvGGQovRd4GXPtuccRU29ge9eB69g==
X-Gm-Gg: ASbGnctqzBnvvKN8iZVoFeNjt4Rf1kOymSL4/OJ2uvGpZVHKZlTx5hPMicU2vlH4ZQl
	6EWf7T+LJQ1EiP6bg0Ro4OEnq4IHbZg8UVaJ7b+7xTelrqGmbKGIxKiGjspD7Dvn5c/KZjg/AC/
	aBn5r8WDVa1fRlzloPRbAUiOoTj6lubKXGszuS2r6SoaQGmQK4/gAW03OLtaHHUinibrsuaedQz
	W3dlNs/rU2SUtkVL638rXsVh95ItvwlkZtw28OMkaiMnnudDUjUvg8MCagcAWeq9vdAgl1kA0EA
	+D7hT4+1T7L951V/holqNFhxgEy0lapcSrAvKPK2gYF1TAg8RUmS3HDB3BE2Adg/hgWZyPcXO/y
	KcLNaobyWaVnV
X-Google-Smtp-Source: AGHT+IHyTZmg9ER74S1drTjoF85PA6dZOdC3TWCeZ2nKybqjldE81KW9q1fSH09TLkfQNscM9Dnofg==
X-Received: by 2002:a5d:5f45:0:b0:38d:ca55:76c3 with SMTP id ffacd0b85a97d-39132d2ac3amr18093999f8f.11.1741857394994;
        Thu, 13 Mar 2025 02:16:34 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb8c2sm1397573f8f.85.2025.03.13.02.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:16:34 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:16:30 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	qperret@google.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v3 1/3] KVM: arm64: Add flags to kvm_hyp_memcache
Message-ID: <Z9KiboTJy9A6qvbK@google.com>
References: <20250307113411.469018-1-vdonnefort@google.com>
 <20250307113411.469018-2-vdonnefort@google.com>
 <87r0327iek.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0327iek.wl-maz@kernel.org>

[...]

> > @@ -1102,7 +1102,7 @@ void free_hyp_memcache(struct kvm_hyp_memcache *mc)
> >  		return;
> >  
> >  	kfree(mc->mapping);
> > -	__free_hyp_memcache(mc, hyp_mc_free_fn, kvm_host_va, NULL);
> > +	__free_hyp_memcache(mc, hyp_mc_free_fn, kvm_host_va, (void *)mc);
> 
> Why the cast? It looks superfluous to me.

Ha yes it is now I pass mc and not mc->flags.

> 
> >  }
> >  
> >  int topup_hyp_memcache(struct kvm_hyp_memcache *mc, unsigned long min_pages)
> > @@ -1117,7 +1117,7 @@ int topup_hyp_memcache(struct kvm_hyp_memcache *mc, unsigned long min_pages)
> >  	}
> >  
> >  	return __topup_hyp_memcache(mc, min_pages, hyp_mc_alloc_fn,
> > -				    kvm_host_pa, NULL);
> > +				    kvm_host_pa, (void *)mc);
> 
> Same here.
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

