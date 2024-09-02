Return-Path: <linux-kernel+bounces-311393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B0D96888D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52449B22C3C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BF520125B;
	Mon,  2 Sep 2024 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFab/gZ8"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8DC1DAC5A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282739; cv=none; b=gOwGmJJ3ewl0gUW6XPqLzoZLvZsRND+GFhnQaohKRoaaUOq/uyf/4/kLCDaiqSRbuZFg479dV+Znu/09SYhbuHTTEXkJRm7IifwraMniZkDMszaj20i39ylCRDN4HAwFHGe40Zz2RaFrXQvjrSH3bnb0WcGotuOddkOHn7ec/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282739; c=relaxed/simple;
	bh=x3yBT1ILkrDC8U5ubafV1b/0dDVsDNgbt6yll5nIIvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgNGKga+OV0fbdqlwPr8UkTKKW1ulZ18C2LT/+Ajl40j08c0JFLhu65YobwoCqKpJfNjArI/rMwtunlWfoR4SIUy/S+A/NkE78OKmmfdwcSiyssqhKfkkUXWYSyaDr/L0VdvqXJCbzUPO0h+pN63TvjADEA/yN50N8ZnviHAFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GFab/gZ8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c25dd38824so1546647a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725282736; x=1725887536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=musVNQDKvzmrv2Dd3oJkXY3EwmSYf6C9caJmbUgvyp8=;
        b=GFab/gZ8Y17c4PwH3FQa+JZ8PsORfI/NIca106d0Hqxp7oErP2CEhlmLKWnipl1gVj
         AYmfslyzdW4nV/i8v1IXRftzynuB5OZ/16Du2CRuEHvJ/4PNqquX6+UXIvNjx1haucEG
         ReaHM1CYB/EJNZPaNVOF85FmF50E7ZjZ4v9zq273DimsndyPnhmrvWqiEdSHgC4cGB9U
         YqiLvE61/O2HmOKKgcyJESV6FTh3Tgivn6dNziUbknBaBnH/28pJLu8soRr3PNkP/Hxv
         +HLOCPu/sIgG3GeshY0wrPiFXCvF6pUmuFJ5xqJi+tB2llVFd7ob4G3nBkC0Qt2ymOVh
         htag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282736; x=1725887536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=musVNQDKvzmrv2Dd3oJkXY3EwmSYf6C9caJmbUgvyp8=;
        b=D+4syzV27DE9H27puPLOaBvbL8iJq64kh/rbIEv7neMOa51gHP+GuXIPkaQWc92VX8
         yq2+dionoeI8kEdHtvZTe1X0T/WWBkKcEJ9hKInQ/5XcNe3Jpa3OfWVlQ0IbAua/tn1H
         WULODDsFocEGipBSlJqBnqTKhNZhxwiyUfBjhu2X0VioqegwNhOHfg1RNb1x/NXjN1Co
         9bGIat+8mhDRmcFtd1f9UMUVLqBe7sSTTdwW54iLRpNjidimFstZMg/0c73qGCBoXClF
         6EdmJSUn39rTQ1XAJiQdhwcQnt2Rjf1CZtW3i0FAkA77WTA2v4JBn7k3JLVk0pI+lmDJ
         iUtw==
X-Forwarded-Encrypted: i=1; AJvYcCUA8pKB5KH4d3mvcjHsPo33w6ALX6uMpZfsUV3GA4TbJap5isKPABR95FYb0XyaSavHOyFHO97ndl/8UAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoBUIS2qryvMtpmgURbWH9EGAs8zVYo4E9bl2gOHGVWpmHigal
	cTzvFYgRuHisGFKqIG8SJzk6KnZLayybC1y0XLsIo5ImX01UOQb3oHV1k8Lz2HA=
X-Google-Smtp-Source: AGHT+IFuVJPmt8V5CC71tl0q99QkKgR32iEzanxYFTNzoe7L94Odr6KgEieHvZGyvtKwdV9FR7zC6w==
X-Received: by 2002:a05:6402:440b:b0:5be:fa76:55b4 with SMTP id 4fb4d7f45d1cf-5c2201ba0cemr16397334a12.16.1725282736097;
        Mon, 02 Sep 2024 06:12:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c7c32dsm5240007a12.48.2024.09.02.06.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:12:15 -0700 (PDT)
Date: Mon, 2 Sep 2024 16:12:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 1/4] driver core: Ignore 0 in dev_err_probe()
Message-ID: <29f8532e-324a-4e06-b257-3ef9a037f93f@stanley.mountain>
References: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
 <20240822130722.1261891-2-andriy.shevchenko@linux.intel.com>
 <ce59c3c6-8729-469f-a0df-b6844792e324@stanley.mountain>
 <96a19237-9380-4173-9e52-e8295a0f4883@stanley.mountain>
 <ZtWQcXerriSnWgf1@smile.fi.intel.com>
 <4e8fa6fa-89aa-422f-b603-e2a3e1a2c704@stanley.mountain>
 <ZtWjqkQUi74JFN1s@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtWjqkQUi74JFN1s@smile.fi.intel.com>

On Mon, Sep 02, 2024 at 02:38:18PM +0300, Andy Shevchenko wrote:
> > > I believe the number is only a few at most, which means that you may easily
> > > detect this still with this change being applied, i.e. "anything that
> > > terminates function flow with code 0, passed to dev_err_probe(), is
> > > suspicious".
> > 
> > I think you mean the opposite of what you wrote?  That if we're passing zero to
> > dev_err_probe() and it's the last line in a function it's *NOT* suspicious?
> 
> Yes, sorry, I meant "...terminates function flow _in the middle_...".
> 

I don't think that works.  There are lots of success paths in the middle of
functions.  Smatch already has code to determine whether we should return an
error code or not.

1) Was there a function that returned NULL
2) Was there a function that returned an erorr code/error pointer
3) Was there a bounds check where x >= y?
4) Did we print an error code?
Etc..

I'd end up re-using this code.  This heuristic is more error prone, so there
would be false positives and missed bugs but I can't predict the future so I
don't know how bad it would be.  Looking through the warnings, we still would be
able to detected a number of these because Smatch warnings when you pass NULL to
IS_ERR() or PTR_ERR().

Probably the worse thing from a Smatch perspective is that now I can't just
assume that dev_err_probe() is always an error path.  So for example, we know
that *foo is always initialized on success so we can eliminate all the
"return dev_err_probe();" paths because those are failure path.

I'm never going to like this patch because I always want to make the error paths
more separate and more clear.

regards,
dan carpenter


