Return-Path: <linux-kernel+bounces-281084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EAB94D2DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485761F230CE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE046198E9C;
	Fri,  9 Aug 2024 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pu6jsVFx"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB7197A9E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215635; cv=none; b=uc4XMDbOSfs1KtXiyJgE/CLEgjmijX2tbOlJwH+0BBZFhnWdu22vNtVDzNEhCXCt/4n38LlKWNx5hautt6LtUIQBz45mwUn09vGANjvi2pVYk4SvoOZS8m88z0qjqn8lJZHcuByGuJEO2ePYe+pd+7QT9ihQD+7tbkgybr6Np5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215635; c=relaxed/simple;
	bh=dawj/tBNKTzYnHcU/KDys36vwXq748o8gOQyRKuQV4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IytObKhDp1X89hy7891RsZlIYzPsY35p1y0ee5ZIy1SbK6izZl0UHHrHsSa8Dwp++A0MCpNzy8YfDFgerv8xQqD+4Zvan33xRIIdam2PUdy6oRNlDRCx9ji1rLp57XxW7ST986l8uCQilWQ8W6Fwv0TwlAgb4nqXVkDH+30rhV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pu6jsVFx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a728f74c23dso246799766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723215632; x=1723820432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0rn7UZ3HG/DD0FX2FGCBFvCYFqEktL4MovS3L/vtSM=;
        b=pu6jsVFxeu9KHsfCJ0Bb4BP1fBJoncgmFgHbvZM9htHbwGrgalwHtfMZ5z8dtJ8tLz
         2dg03SMNiXWLyOqeL7MgrOaca7zj+stUs2ZHgQbz3M8TMJx/kAgKVXjpY905D5CSqDCI
         CfVNF44RByA2FFI9srO+1iGac47Pff0Ly6e+CPwyJpnaJ3QrUWH3cGglfEXvVXtREY41
         ceFoqBXRkmP4EqhoBHl6lutSbP6YTGmzh8yHr5wTqzLqcRhhOgvRctitUN3SmbM2D6NX
         UKilkjLbU42L2Vx+dNvAtfR1TzWJw8kun0pGwwIenf2kmb8qP5FX7pxanLFKzoJ1UAwR
         tiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723215632; x=1723820432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0rn7UZ3HG/DD0FX2FGCBFvCYFqEktL4MovS3L/vtSM=;
        b=fvqqGkWRK6CvdIOK6IKIFfgXuEESrMpRs/OIrpr0kKJ2E07iSJ/0JoX2sYFX+5HaG3
         spacRT+rmd19G8qU61O8IwKHp9yMA2ktQ1a527W2yP4TKzR14On8ODJNjI+oZv7g5WMN
         hnQj1X5mrm0hPoaaE/Q1ytjBK06zu/j+IKr5Hhmx/2fbWp7lWjrOOm+ll8riM/oxBYYY
         hgsY9IqODKIMTYgfv6K2OfNzKKOlEg9SPOEsTNAsyK2H1/QQ6SdU2rMxJpShVdySoetB
         JhVsafHwo/5r9NahVS5h6w7abH46Awz/w2GR9z/FAyiSHjFgUowx0KwZmCm8e+/8ENQQ
         U7cA==
X-Forwarded-Encrypted: i=1; AJvYcCUm7+VjoDW/MEGsuNduAvtFkqTd9Nz3+v9CtAHXX25zSOS5qlPRKiBkam9ScvcZdiZsPZyK8yx81ZQ6iTU9oqV7jwTVDLWR3Y389vNE
X-Gm-Message-State: AOJu0Yy/oV/JOzgSRGUP/Phj0BfND2N6I1IZgFlctBf1RImpEvM4rznd
	DEHy6KFV61rqQGpBwQ2SL/rPxQ2eOSuNP7a88FsrCrQaOiqt6bHxs7zbRfJytUY=
X-Google-Smtp-Source: AGHT+IGimyb61sKhw+mRuQVbC3bE2Obmy5HP7cvL4gIjsSjX8fXY+fkEjJOzQlmt3WtZxu0/FhFwCQ==
X-Received: by 2002:a17:907:c7e2:b0:a7a:1d35:4106 with SMTP id a640c23a62f3a-a80aa557a83mr159871766b.5.1723215631262;
        Fri, 09 Aug 2024 08:00:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3c6esm866125566b.15.2024.08.09.08.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 08:00:30 -0700 (PDT)
Date: Fri, 9 Aug 2024 18:00:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>, David Howells <dhowells@redhat.com>
Cc: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com,
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com,
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
	justinstitt@google.com, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] smb/client: avoid possible NULL dereference in
 cifs_free_subrequest()
Message-ID: <893f2ebb-2979-4e34-bdab-a7cbb0c7e7b8@stanley.mountain>
References: <20240808122331.342473-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808122331.342473-1-suhui@nfschina.com>

On Thu, Aug 08, 2024 at 08:23:32PM +0800, Su Hui wrote:
> Clang static checker (scan-build) warning:
> 	cifsglob.h:line 890, column 3
> 	Access to field 'ops' results in a dereference of a null pointer.
> 
> Commit 519be989717c ("cifs: Add a tracepoint to track credits involved in
> R/W requests") adds a check for 'rdata->server', and let clang throw this
> warning about NULL dereference.
> 
> When 'rdata->credits.value != 0 && rdata->server == NULL' happens,
> add_credits_and_wake_if() will call rdata->server->ops->add_credits().
> This will cause NULL dereference problem. Add a check for 'rdata->server'
> to avoid NULL dereference.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>

Needs a Fixes tag.

Also when you add a Fixes tag, then get_maintainer will add the David Howells
automatically.  I've added him manually.

> ---
>  fs/smb/client/file.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index b2405dd4d4d4..45459af5044d 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -315,7 +315,7 @@ static void cifs_free_subrequest(struct netfs_io_subrequest *subreq)
>  #endif
>  	}
>  
> -	if (rdata->credits.value != 0)
> +	if (rdata->credits.value != 0) {
>  		trace_smb3_rw_credits(rdata->rreq->debug_id,
>  				      rdata->subreq.debug_index,
>  				      rdata->credits.value,
> @@ -323,8 +323,12 @@ static void cifs_free_subrequest(struct netfs_io_subrequest *subreq)
>  				      rdata->server ? rdata->server->in_flight : 0,
>  				      -rdata->credits.value,
>  				      cifs_trace_rw_credits_free_subreq);
> +		if (rdata->server)
> +			add_credits_and_wake_if(rdata->server, &rdata->credits, 0);
> +		else
> +			rdata->credits.value = 0;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^
Why do this?

regards,
dan carpenter


