Return-Path: <linux-kernel+bounces-380350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2DE9AECBC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E525B23186
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0391F81BC;
	Thu, 24 Oct 2024 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcihC874"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E81D63E5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788916; cv=none; b=Xohdtzj440qUtjIwy9ZCTlKwwkM0DzNU/fQjPEZunr0E5DttrfRI6rlZS9GkoUoONDo/Jjp9kqR8nONaOdfz0XQr5bLEIBkur+S624urwkKKF5W3QmPpkPhDsVJomXtX5GakzsbZggSSAwY9STPsrnOU8TUASy6oxpZLXbzt3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788916; c=relaxed/simple;
	bh=GO+CYso/bTOf2xGs1upCw8Mp19VtJPjOhr62lrxsNG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHJo5HendH+bz3W1hftJyMQNZWyRxOZWFM+PJDlS74Z/nJMI9fVOXEh+YBgxgx1Wb035gHQqm5VlPjw2QjAghCUpSnkn3V4f2CeAZ6Q7l4qmHU5BdlRR2BW+7Rz/3n/WpD/xn3EiDvn/JqmTkXLS+kx8wz5Xd/dFoy+2paQ1BOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcihC874; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so7725e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729788912; x=1730393712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCdtKyQctIBSL1se9ZBXozl/8Gw/YsUba47AyHThe0Y=;
        b=mcihC874xHNrlWyFkXlnppm9CT7ZXhu1whGEKYELuJNVTJB612P9NAIaNu5f03knYF
         So//NBHpqy7I1yQCik5Y+2aCzMJbFJs5xQVruU9XA1LwKg9IS6tF3bjy6sPvwSsjBdR4
         2C86PJoIek8chu60kDGXejU3C+Z99OGXC/s11XF+eURjxho6pZVSaXa4czDWFvG5wCri
         PMNV1NfJKaFKDoExwOP9ec2KpxOGALXE+L3A0T8JC51xVw0+mHjq/3qtxZm7q1TLW58o
         ku2tQWCP5D63GhUtKetPYeegS9WIWLVGeE30q/VOpExglSKzMPs0dJdfEhzBHvtzoKws
         rbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788912; x=1730393712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCdtKyQctIBSL1se9ZBXozl/8Gw/YsUba47AyHThe0Y=;
        b=rtsILH2TwvMZ54UlNAkzaHadLbfJ4Nzo0eQWH6+9G1bvF2PPPjJ3v4ZMTEO5WBUYrS
         imn65EC+uZOqBnDTXnYua8+e7dOM1mnAOGFy1S8WcQYrj9Ru3sJBAvrk8ksWW0mUErQS
         z0X02NSM1vbncD7r453ZxQrxEFVZWaFOsmcW3PfZRC+Keah4qtpd6Avvj59glhTQ09nW
         ZZ88GcU5Gu/38eGmbXDmf87D5XqtlIl68c/PNY5h2x3BGvu4r+VcZzjuLJVZ3jwbbwk+
         NnvPoPT1ZOQSHwBtdXGytXsc145C24oIlB4MmJC1FAqSntfzSxl4H6VZ4BPBzG2BRbiU
         ErvQ==
X-Gm-Message-State: AOJu0Yy7bEjLf6oPA2nwOo0UKsnmf98HN/Ph7ncKuaTwNDlqqaEeoMHx
	zN5IIlPv6TguImT5bbB0RV92NuRQgQiknZB54Bt/B4aJwHQxVP7mAo6A1sBlY0A3yxA+zzHBFn9
	59Q==
X-Google-Smtp-Source: AGHT+IHcN7HDbw2An/mqTEn7MtXy6cHrcCtVnXaHLCdh4ENrobYlDmJPj++dv/iSVSPdnUCb+iLsTg==
X-Received: by 2002:a05:600c:1d82:b0:42b:a8fc:3937 with SMTP id 5b1f17b1804b1-4318a56d62dmr5544205e9.4.1729788912295;
        Thu, 24 Oct 2024 09:55:12 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bd69e0sm52243065e9.3.2024.10.24.09.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:55:11 -0700 (PDT)
Date: Thu, 24 Oct 2024 16:55:08 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, corbet@lwn.net,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] Documentation: Update the behaviour of "kvm-arm.mode"
Message-ID: <Zxp77Es8BCnHcAHk@google.com>
References: <20241024160614.1894599-1-smostafa@google.com>
 <86o73930ze.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86o73930ze.wl-maz@kernel.org>

On Thu, Oct 24, 2024 at 05:43:49PM +0100, Marc Zyngier wrote:
> Hi Mostafa,
> 
> On Thu, 24 Oct 2024 17:06:14 +0100,
> Mostafa Saleh <smostafa@google.com> wrote:
> > 
> > Commit 5053c3f0519c ("KVM: arm64: Use hVHE in pKVM by default on CPUs with
> > VHE support") modified the behaviour of "kvm-arm.mode=protected" without
> > the updating the kernel parameters doc.
> > 
> > Update it to match the current implementation.
> > 
> > Also, update required architecture version for nested virtualization as
> > suggested by Marc.
> > 
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > 
> > ---
> > v2: Update nested value also
> 
> Thanks for that. However...
> 
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 1518343bbe22..d5b771e5cb5b 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2740,12 +2740,16 @@
> >  			nvhe: Standard nVHE-based mode, without support for
> >  			      protected guests.
> >  
> > -			protected: nVHE-based mode with support for guests whose
> > +			protected: hVHE-based mode with support for guests whose
> >  				   state is kept private from the host.
> > +				   In case hVHE is not supported in hardware, it will
> > +				   boot with protected nVHE.
> > +				   nVHE protected mode can still be forced on VHE systems
> > +				   using "kvm_arm.mode=protected arm64_sw.hvhe=0 id_aa64mmfr1.vh=0"
> 
> 
> I probably didn't explain myself very well. I would like to avoid
> mentioning hVHE at all, because this is pretty confusing (and really
> an implementation detail). Instead, we can talk about VHE/nVHE, which
> are real architectural features.

Agh, my bad, it makes more sense to talk in terms or architecture.

> 
> Also, I just realised that we can use your command-line magic for
> downgrading from VHE to nVHE in all cases, so I'd be suggesting
> something like this:
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1518343bbe223..2bb19f1331fed 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2740,8 +2740,9 @@
>  			nvhe: Standard nVHE-based mode, without support for
>  			      protected guests.
>  
> -			protected: nVHE-based mode with support for guests whose
> -				   state is kept private from the host.
> +			protected: Mode with support for guests whose state is
> +				   kept private from the host, using VHE or
> +				   nVHE depending on HW support.
>  
>  			nested: VHE-based mode with support for nested
>  				virtualization. Requires at least ARMv8.3
> @@ -2749,8 +2750,11 @@
>  
>  			Defaults to VHE/nVHE based on hardware support. Setting
>  			mode to "protected" will disable kexec and hibernation
> -			for the host. "nested" is experimental and should be
> -			used with extreme caution.
> +			for the host. To force nVHE on VHE hardware, add
> +			"arm64_sw.hvhe=0 id_aa64mmfr1.vh=0" to the
> +			command-line.
> +			"nested" is experimental and should be used with
> +			extreme caution.
>  
>  	kvm-arm.vgic_v3_group0_trap=
>  			[KVM,ARM,EARLY] Trap guest accesses to GICv3 group-0
> 
> 
> >
> >  			nested: VHE-based mode with support for nested
> > -				virtualization. Requires at least ARMv8.3
> > -				hardware.
> > +				virtualization. Requires at least ARMv8.4
> > +				hardware (with FEAT_NV2).
> 
> That part looks good!
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

Thanks,
Mostafa

