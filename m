Return-Path: <linux-kernel+bounces-221566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679C090F58C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BEE41C219C5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA5815667C;
	Wed, 19 Jun 2024 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="qssnXKt/"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF82153820
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819768; cv=none; b=CSUE45q1nAYsuvFgTjjworkyVzaE7y8RFWW/oQ2MphYIIbjyKiCjb7VfEDvmpLjJcezyKaXB1gcSETRzX0cw1GDR7LsxW8SmLEKAI/TLLXl5Xc4rJAetXHQ0vubPx2rkot7G4VrG9XbhP6ZJe13iwXcvzzGJrgkAESfk9FuiIbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819768; c=relaxed/simple;
	bh=qZLAW1L5M56DwbKoi1/YqdkTRNLosZQ9XhdG7pPvBuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql8iBqoA167QO/EBxgCahLXpGjxzUEUQL2JVeFYZseDHW6nMY5V+lmNQz3sHbqWk+HESmYbb1fWLXH2fphoFTacBGpV8WYCvcofbXca76kJSCn8j6OkS49VhWFREdZNcBERSPyV6BiGkHj+Ag0sjh0byeJUGaARZFDKHNvA1664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=qssnXKt/; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7eb01106015so299602839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718819765; x=1719424565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mbjif+WJ/551UA6yF5H6wna1Ibvk9vV1Wcfn2sMlCyY=;
        b=qssnXKt/BrjOKDUTCiK3f3cKtEd5fS30IbK3v9TaUs7so1EnQMWguUzWfM5fFHcwQv
         aseKZb/j8S7N1OFjOjwOjpRBxI2NYptCqVeaAqZ/g2+h/dQCy4uD5HVInzvWf9TjQX3F
         9H8EcmId/6tdxjSUS/OIvg95c3qKeDhbg3ZTY6FNEnEngG2OT8XX2jzyZoerUFpfc+hm
         DIJCiu0Lwpqbj//+fvrRUjrpkGn6g+vjQPxVlTfgxIl/ftfKsH7711u/ahwsotzNWmVO
         BEST826VkUWgslJrX7qqp/LB+qU+5NjSsjpT4WwtrDtsr95/oADpBi8clhtDEkHKcQkL
         +d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718819765; x=1719424565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbjif+WJ/551UA6yF5H6wna1Ibvk9vV1Wcfn2sMlCyY=;
        b=krxY1CtDE1fNCFAgqJ5xW2Mc+FO0ROrHymZWwkjzb13HTckSSxPVVKuuCLxwvTl5+r
         DK4EImLjV9w8jBsBxK+XM5dqgfTnhUBZgdjXL4nDuSWDX53Q8vSdkZLHQFiTodyVtR6I
         bswoTpaSsk3jRj8NqIwVNUzmHHvQEt5GiDqB2G4amNMsNtrn9/FF0bfmkroBNyflTknv
         iGfYRkPmiPtLv3w/A0b2nAJHSbW3R8m7z4H8WyrEXF5rsRTniHja1HV3u8iHIrehW1Qa
         RAcBb6qH3wM11INrBM3nlHVoXZRP0nTRiBd+r7TCLSofT/0Mb+HnzpZeIhN/4SzinO5B
         gCsg==
X-Forwarded-Encrypted: i=1; AJvYcCULET7OnCn5mrJKDSQID8GCg5g8Ck0MQyTQQjoLOM3QMhFIQDDknYH3UPmZkt60L+Yyi+06tG4dXQK2GUaaYNT+OA4zF66sfAXvAxnF
X-Gm-Message-State: AOJu0YyT913BnN4oHxqOCCHyyJn1ORjglaPSmXqvHmeuHnU4VHVD4rfb
	Zk6I/hIDnIecRoCqjngOyfdgMgiG37zhVMlhfVeOoGBfMLSE4SAxsFkfliofxn4=
X-Google-Smtp-Source: AGHT+IF9TsY8NVv2B42kRpxvrVeMm3R5ONdANb6gDSHycKGPhfTbgx+nCs8+HifwJCTtlx5q0X8U3A==
X-Received: by 2002:a05:6602:640c:b0:7eb:c972:dee2 with SMTP id ca18e2360f4ac-7f13ee0e286mr404164839f.3.1718819765360;
        Wed, 19 Jun 2024 10:56:05 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:212e:5310:572e:1126])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b957bb0c0csm3978084173.87.2024.06.19.10.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 10:56:05 -0700 (PDT)
Date: Wed, 19 Jun 2024 12:56:02 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lenb@kernel.org, mmikowski@kfocus.org, Perry.Yuan@amd.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnMbshMhyoSKyClb@kf-XE>
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
> 
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

Gah. I can't read apparently. That patch may very well work because I
just realized the "if (ret) return;" means to return if ret is NOT 0. I
had it confused with "return if ret is 0".

That patch looks like it may very well work, and better than what I had
because it doesn't require manually setting a kernel parameter. I'll apply
it and test it. (That may take me a bit, I don't have access to the
hardware with the problem, only my boss does, but I should be able to get
it done before the end of today.)

