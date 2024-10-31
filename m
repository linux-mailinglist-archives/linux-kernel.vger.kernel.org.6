Return-Path: <linux-kernel+bounces-390270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765DE9B77C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229261F2332E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D4195FEC;
	Thu, 31 Oct 2024 09:42:18 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79D194C65
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367738; cv=none; b=LWweu/Ceyg6EgywpNIRfUZpKsNr6b0WIbF3J/RuNiuoYfJe2yOfiBU6GDVwX749ZGZVBOWyId1jkLjVKc2HaL4Tj4QGh6fqQIkWxnmP3mm+Yn3gbS9UfHYMObrNVw1JAW+xzl0w12OscoiYmgSbSitPOdrgQ75pLvrK+qKfKemE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367738; c=relaxed/simple;
	bh=A2IaCG+DDz9Mkq2IEmOoYi35S55ux1K8Km4pU5hqmBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXK0m4XwgPc8upywd2/I397dFcLPrtXLPOHoK9WSft/sNvRvLifCu7dMdynAlh35eE2R83pX7pRad0v0J+vWusqWwR6+uqP16sichLCHjN0Fc4+ZXfJll3eBU0C2knE9Gi28BxyHCxAYKKTDh/nMVOPNZpWy/hdidCO7I89k4w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0472306cso93172666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730367735; x=1730972535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3gbF0jbVNATgdlKALkxAF4j3DYG+tZbqUqbaS3H890=;
        b=TI5izCSn3NP20qaTlWxkKvO2VWr4ZmTxH8wyoU71a8N4JYZoScXCFiGq18ZOnqQjWM
         iN/kXiJgXz1Sg4aW9CuRoh7hIVYEG31ebSIN1+jOXZVmZdNN+rssjHGO93r0QRVvTjzc
         yqqwBOO6v5MmM7dMipPlZCOti5womzz+o0nQJ8vJPqNCRKZT6NZPr2fZMcu4b6t4qMf3
         rdXUtvXLTs1OE43ahNxU6YAZ55zWWwYvv+2UljGqM7aqRtdxBseb+/R9H5wBDoHse/CD
         T+JNuGN7BAWZCPtFDSOMWUGTcHZvNrfngJCWLRheD4eT445ucCfIQHSaI0lMqih4vCWC
         IUpg==
X-Forwarded-Encrypted: i=1; AJvYcCX7qGi9epcB/C3ik/rnxnvNtggOk+cTs5LmJHRDvCmQ7/b1KpUakDJifCdi4mgKK4o5geByJrASqlRoEG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxczXefI6nEsM9OcoDAnq9n2eqfB36QKbkDB3OtXalnYruVsKi5
	Ff6H2niTMH9UlxIBBwOUYUTz2u9yrvLtRqzO0H4juBi4eoyDnvbx
X-Google-Smtp-Source: AGHT+IFH6dXFVyTgu3CJIoORadnJQZzAQnBsT133x+mK+vd53zFt0Lh5GFERCXyDz8dWXQsOI8aq4Q==
X-Received: by 2002:a17:906:dac1:b0:a9a:66a9:2c55 with SMTP id a640c23a62f3a-a9e508aade9mr256692366b.6.1730367734630;
        Thu, 31 Oct 2024 02:42:14 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5663cd43sm47016666b.143.2024.10.31.02.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 02:42:14 -0700 (PDT)
Date: Thu, 31 Oct 2024 02:42:12 -0700
From: Breno Leitao <leitao@debian.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: bp@alien8.de, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/bugs: spectre user default must depend on
 MITIGATION_SPECTRE_V2
Message-ID: <20241031-romantic-active-spider-5bccd8@leitao>
References: <20241015105107.496105-1-leitao@debian.org>
 <20241015105107.496105-3-leitao@debian.org>
 <20241028143453.govo3bnbayc7rqjj@desk>
 <20241029-large-perfect-bulldog-ce53b3@leitao>
 <20241030183920.s4lk33ckvqtkguzm@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030183920.s4lk33ckvqtkguzm@desk>

Hello Pawan,

On Wed, Oct 30, 2024 at 11:40:53AM -0700, Pawan Gupta wrote:
> On Tue, Oct 29, 2024 at 02:19:12AM -0700, Breno Leitao wrote:
> > > If this is the intention it should be
> > > clearly documented that enabling kernel mitigation does not enable user
> > > mitigation. And an explicit spectre_v2_user= is required to enable user
> > > mitigation.
> > 
> > That is fair. I didn't find a place where to document about diferent
> > behavior when CONFIG_MITIGATION_X is disabled. What would you suggest?
> 
> You could describe the behavior in the commit message and update kernel
> parameter documentation.
> 
> With that:
> 
> Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> ---
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1518343bbe22..f8bc02cd10ec 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6241,6 +6241,8 @@
>  
>  			Selecting 'on' will also enable the mitigation
>  			against user space to user space task attacks.
> +			Selecting specific mitigation does not force enable
> +			user mitigations.
>  
>  			Selecting 'off' will disable both the kernel and
>  			the user space protections.

Sure, I will update it.

Thanks for the review!
--breno

