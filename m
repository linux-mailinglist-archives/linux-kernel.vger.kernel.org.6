Return-Path: <linux-kernel+bounces-221789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EEC90F892
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E979DB22A97
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FD415ADA9;
	Wed, 19 Jun 2024 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="Yn0KyH3R"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5586255884
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718833183; cv=none; b=RefUY7zm4JZ6ke8F61ODktWW3o6ghVDTcBGbaK8sn/CNBMfh74szZgBtvGG0F9d0doS4PcB2Ua5UuMlj/F6EYFt5oAfCsaYAuIcW4js4xPFJX2c/l8g9mvcRE8gNkneblxnhFuDYKcgplnjv5/sCLSd+JQP45Foxmjkyld8uhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718833183; c=relaxed/simple;
	bh=W+anAt20EGRZVFKzpD76Y/OqfiPApnoplAdX8AMISno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kViDQV6Dg854T3bUIEEiySb293qiXvGDNZNwIRO3XzMO/7mVlZUt1l+lKNJEZsJlTclBi2RjtYifNZF5N25ZM2xIKYI+WTa4UhHwEpnvb7DMFDw433BhcnusQSWUn725Kyh7+f/bz4E6fVYrK4PrI70TcSIukbJvQR0N9aXGnAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=Yn0KyH3R; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7eb85e80661so5546739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718833179; x=1719437979; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c7tGRLKrGc6OgGWImJ/uYEBqxWissmKQjKNBWsuhVCQ=;
        b=Yn0KyH3RBdXZifaNP3RnI7LPOjNnOwaK15hRjilYx+TNBo3BhG+/sJFrSxQhQT+jLs
         PRW3sFYmDwPI9SgdE6iDvOcCdCHljGxx2dfucoYt9+qXbezW83OA9L7YpqPBTMBs7bq4
         GVW4fcJs095evTcRQwLjOjgx3sls7VeeqaanxN9PBWTj8SexLbE/dkLeEvcU7Z6RzuAv
         m7azuZnBF9CCvt19FMToJPp5aRCAGvGK1CcbdwJbVWmy3c/qHsTClxlOka3XCLX2u4Fb
         1rEnZnYUozsJYi5e3FHcCugEkzIjC1VHwk2wvC5uhcOGoINyW9OJDW4CxD9Ex16YwpdQ
         CIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718833179; x=1719437979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7tGRLKrGc6OgGWImJ/uYEBqxWissmKQjKNBWsuhVCQ=;
        b=XcrbJpVRY9/jIHWbXWcf7MiYJ1o6elJzvUwTYs9FdawbT3m4z6kz+mikyX+5n10Xry
         vlXMMJkCHeuphbK4oLLLvkmY3E2BoDIkhZPiDh043BamCK+bOy3eLx+7wUeURKBg/5bm
         owJjEs2tcLHTa8e2Q/IhXarwUvkipoDZANaEh12UEJZGk5PFToMJN7ML/Q6JS9BsJGXA
         aydzlVUMpFbYEcHxsRxT2RBZaSu8NblYl2OihIm80vpu0yD6yPmgKXlaZbXJqsawkD5X
         jbPOkEBzXt4soTbunFlhqq0ouXpBVyk3qgqy20Rz0nwoZZLszo7e7VnpwMVSesxMu+VN
         P0pA==
X-Forwarded-Encrypted: i=1; AJvYcCXUiNx2F3XQQAKbg5iX1O629IktmC7iFIK7CAZpgH20mT4uNYrfqxwUtLQ7brgkLQvKmBy7LlFQOm0PVjhQUwxh2F+PZuVTwdxqfXKJ
X-Gm-Message-State: AOJu0Yxk75ge0aTzBANtmfTaEbEgh8N1FIW2HcSu3GWw7SzeCl9yUBc7
	3k2lIdo5P+C+6rSac7DMv3QsMTEUqMybtND4OsAY1HE6NLKj3iiJZMYZJmyekI8=
X-Google-Smtp-Source: AGHT+IGkdDZC+RExE+prPoHZuIg2VP7EK/gbvWWUQwJpe6TkHACdm1Rq8oMGE5XKDlQ4aI6cGr5m1Q==
X-Received: by 2002:a05:6602:2c8c:b0:7eb:c85b:f19b with SMTP id ca18e2360f4ac-7f13edd0004mr458718339f.7.1718833179434;
        Wed, 19 Jun 2024 14:39:39 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:212e:5310:572e:1126])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956917131sm4119193173.44.2024.06.19.14.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:39:39 -0700 (PDT)
Date: Wed, 19 Jun 2024 16:39:35 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lenb@kernel.org, mmikowski@kfocus.org, Perry.Yuan@amd.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnNQF0ussBRSAt1g@kf-XE>
References: <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
 <ZnJfmUXmU_tsb9pV@kf-XE>
 <CAJZ5v0gOBH7OKF3KXwxYfWkGkC45rzDguR4VmSnoZDKpm+KPSg@mail.gmail.com>
 <12457165.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12457165.O9o76ZdvQC@rjwysocki.net>

On Wed, Jun 19, 2024 at 07:30:55PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, June 19, 2024 7:09:35 PM CEST Rafael J. Wysocki wrote:
> > On Wed, Jun 19, 2024 at 6:33 AM Aaron Rainbolt <arainbolt@kfocus.org> wrote:
> > >
> > > acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> > >
> > > The _OSC is supposed to contain a bit indicating whether the hardware
> > > supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> > > be considered absent. This results in severe single-core performance
> > > issues with the EEVDF scheduler on heterogenous-core Intel processors.
> > 
> > While some things can be affected by this, I don't immediately see a
> > connection between CPPC v2, Intel hybrid processors and EEVDF.
> > 
> > In particular, why would EEVDF alone be affected?
> > 
> > Care to explain this?
> 
> And the reason why I am asking is because I think that you really need
> something like this (untested beyond compilation):

Alright, our team has compiled and tested the patch.

Results were mixed - with my patch, both CPPC and ITMT were enabled. This
patch appears to enable only ITMT. (To be specific, running
"find /proc /sys | grep '(cppc|itmt)'" shows only ITMT enabled under
/proc, and no CPPC directories under /sys.) This causes a performance hit
in benchmarking - using my patch with 'ignore_osc_cppc_bit', we were
getting Geekbench 5 scores of at least 1907 single-core, and 10500
multi-core. With this patch, we only are getting approximately 1700
single-core, and less than 9000 multi-core. (With an entirely unpatched
kernel, we were getting less than 1000 single-core, and about 10000
multi-core.)

Ultimately this is an upgrade over unpatched performance, but a
downgrade from the previous patch. It seems having CPPC and ITMT
available at the same time made things work noticeably faster.

Is there some way that can get both CPPC and ITMT to work with an approach
like this? Our hardware does support both, it just has an incorrectly set
bit in _OSC.

> ---
>  drivers/cpufreq/intel_pstate.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -355,16 +355,16 @@ static void intel_pstate_set_itmt_prio(i
>  	int ret;
>  
>  	ret = cppc_get_perf_caps(cpu, &cppc_perf);
> -	if (ret)
> -		return;
> -
>  	/*
> -	 * On some systems with overclocking enabled, CPPC.highest_perf is hardcoded to 0xff.
> -	 * In this case we can't use CPPC.highest_perf to enable ITMT.
> -	 * In this case we can look at MSR_HWP_CAPABILITIES bits [8:0] to decide.
> +	 * If CPPC is not available, fall back to MSR_HWP_CAPABILITIES bits [8:0].
> +	 *
> +	 * Also, on some systems with overclocking enabled, CPPC.highest_perf is
> +	 * hardcoded to 0xff, so CPPC.highest_perf cannot be used to enable ITMT.
> +	 * Fall back to MSR_HWP_CAPABILITIES then too.
>  	 */
> -	if (cppc_perf.highest_perf == CPPC_MAX_PERF)
> -		cppc_perf.highest_perf = HWP_HIGHEST_PERF(READ_ONCE(all_cpu_data[cpu]->hwp_cap_cached));
> +	if (ret || cppc_perf.highest_perf == CPPC_MAX_PERF)
> +		cppc_perf.highest_perf =
> +			HWP_HIGHEST_PERF(READ_ONCE(all_cpu_data[cpu]->hwp_cap_cached));
>  
>  	/*
>  	 * The priorities can be set regardless of whether or not
> 
> 
> 

