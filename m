Return-Path: <linux-kernel+bounces-252859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5BF9318FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2775B20F75
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4D73EA76;
	Mon, 15 Jul 2024 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VX0+vnb5"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C9481CE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063481; cv=none; b=fDRxmtrryjkaZ9dqt7MBfJY+aV1Djyv5z2R8+q0tBHQGwrd4S6I3tz/DwCjlDPNfAMcXTxmVAcnAOTpdawEPtsEIRMO7KF1O/cR2I03ebKhEXpif65CHZyhaYM5f4vN73pGiQ8OwJQHLZRxsu5l2iyfM0YMTUvXrtn9wcglHx8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063481; c=relaxed/simple;
	bh=LW9qJPi1pyF5KeBuCOkgBiLO+cfrlARunEDSaY9b8yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vu7x8RS4X0R+ka5LT0n7DyUjFeq29LWiR6DPiJFZWC3uXAwyu07mDoTq3hOuy4tSG/Tk7s8IwLtBn45L6oLulasu7uLdfQtjkpnU3nibGLa/xY/y8ovCt9+jo4ejNCmMBfgqldgk4hf7Zn52VaLJbDI1KuNKE25YFiuMsQzslZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VX0+vnb5; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ccfdc3157dso1297013eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721063479; x=1721668279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9lkVsVegZWb4nDKyM/hEerXFr2vdLkv9KD3h/brW3Bc=;
        b=VX0+vnb5D8cmCefhsQAPB7E7SxZqBB4JNlsWhXhiXia4uFXgY2zAXA1VV7GcSWRmoE
         WNJN41VaiEBSqc0jBxa+SlYKM8DhKX6B74Zb8facMVP2Xqlr6rSx4nEarTj9mMJu6m5b
         6ERzKP/OBEk5r5ks/o62chcRc9kP2WGZajQAB4kon9beHUmj01uhOLu91S8brwAH+otn
         kWcSR15cjfUCk69JbYvGL5HDWycRm0UwJLTqyvwo44kykarPdehpD+pono4sV5u6Uo5Y
         IlE6xFwH5QsBgf2w/6W7OfFDO/uR2RTsC0S0uo+E6+7MczVmGqSphI71jHve+vrcs2hy
         pGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721063479; x=1721668279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lkVsVegZWb4nDKyM/hEerXFr2vdLkv9KD3h/brW3Bc=;
        b=LZXobEFsgbcpit4zUCiv6eENiv6eG5x0YNrIfaHG6dqeUa10f4HAy4oDyYj90Z/U84
         At+gDVn/mxQc6epcdMl6vYrPW98G7bv1aSnZeAe6LLnWQYkK7Ncw49q3nLxrpjyDOd/E
         b44Mdft0QEkbygqj7idwyIIJiuxIdWfT+X/8bdZ7bOlHPi6LK8AlnnBhSDEPgQroFkY+
         AUxbe7ui2mWGqaeCPP/KAX6zbQHMd3h0Dc4fmdnK7SlKis6YUDpNOiLNi2zEt1Keghmo
         BjhqNPe5wnRPmMRIlMISarBNrPVVAVg3lgYZ12oYDuehVnUu8JxV0hULhOz2GKOudCdM
         Hntg==
X-Forwarded-Encrypted: i=1; AJvYcCVtRjPI5cY5BnI0QWx+19dBQEGkoclq7WUuwJjtYKz2DPYoEKehn0yE36kfujFAa5Su2faA8eMz6nupRH0Ag/i+3rC5NuYXoOzRPs7t
X-Gm-Message-State: AOJu0YxWnOhxSNTNVIIgGP00kmwsnL5oFgqzv4bg9FHfq1OWgewT8L0c
	lu6P1PscfzhTrPNSQAlcbS1HgmUfzQ+DUgfp6JtUKvpEn/+o62InkAJpx+YA33Y=
X-Google-Smtp-Source: AGHT+IF3Y5r7ANdidB8C985shaZ7Y4HsbOHKtwwiZnz6qoF9sy+jIhyV9aA0zqaSYAUY8dPs31frdQ==
X-Received: by 2002:a4a:c3cc:0:b0:5c6:989b:a1ca with SMTP id 006d021491bc7-5cc99922016mr4589202eaf.3.1721063478879;
        Mon, 15 Jul 2024 10:11:18 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:750c:19a4:cf5:50a9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ce753d22ccsm897578eaf.15.2024.07.15.10.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 10:11:18 -0700 (PDT)
Date: Mon, 15 Jul 2024 12:11:10 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ma Ke <make24@iscas.ac.cn>, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
	arnd@arndb.de, gregkh@linuxfoundation.org, manoj@linux.vnet.ibm.com,
	imunsie@au1.ibm.com, clombard@linux.vnet.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] cxl: Fix possible null pointer dereference in
 read_handle()
Message-ID: <6630fb82-9836-453d-a8bb-cf8f19b5665f@stanley.mountain>
References: <20240715025442.3229209-1-make24@iscas.ac.cn>
 <87y163w4n4.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y163w4n4.fsf@mail.lhotse>

On Mon, Jul 15, 2024 at 04:28:15PM +1000, Michael Ellerman wrote:
> Ma Ke <make24@iscas.ac.cn> writes:
> > In read_handle(), of_get_address() may return NULL if getting address and
> > size of the node failed. When of_read_number() uses prop to handle
> > conversions between different byte orders, it could lead to a null pointer
> > dereference. Add NULL check to fix potential issue.
> >
> > Found by static analysis.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>

The bug is real and the fix looks okay to me. I'm surprised that Smatch doesn't
print a warning about "size" being uninitialized.  I must not have it enabled
in the .configs that I test.  But I also wouldn't have reported that because
it's from 2016 so it's too old.

> > ---
> > Changes in v4:
> > - modified vulnerability description according to suggestions, making the 
> > process of static analysis of vulnerabilities clearer. No active research 
> > on developer behavior.
> > Changes in v3:
> > - fixed up the changelog text as suggestions.
> > Changes in v2:
> > - added an explanation of how the potential vulnerability was discovered,
> > but not meet the description specification requirements.
> > ---
> >  drivers/misc/cxl/of.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
> > index bcc005dff1c0..d8dbb3723951 100644
> > --- a/drivers/misc/cxl/of.c
> > +++ b/drivers/misc/cxl/of.c
> > @@ -58,7 +58,7 @@ static int read_handle(struct device_node *np, u64 *handle)
> >  
> >  	/* Get address and size of the node */
> >  	prop = of_get_address(np, 0, &size, NULL);
> > -	if (size)
> > +	if (!prop || size)
> >  		return -EINVAL;
> >  
> >  	/* Helper to read a big number; size is in cells (not bytes) */
> 
> If you expand the context this could just use of_property_read_reg(),
> something like below.
> 

You're a domain expert so I trust you, but as a static checker person, there is
no way I'd feel comfortable sending a patch like that...  It's way too
complicated and I wouldn't be able to test it.  If this were my patch I would
ask you to handle send that patch and give me Reported-by credit.

regards,
dan carpenter


