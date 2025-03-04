Return-Path: <linux-kernel+bounces-543533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F1DA4D6D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67540165BC1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1265D1FC0EE;
	Tue,  4 Mar 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSBerVUx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7198C1F560D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077849; cv=none; b=tp9pPsfOOeNPCDBHvFhAm91+lOZ7Po4HDgk0gXnkHog4yG0Dze0/Sy6zC6CTve9BaxhOEuWlpAdjhWKSHEMwhvgbH107vK/modKUE/T9PaLaXe4gMEv/1wl2Rv1ZwIKzLqsyeiJXzsKxJRIIIcc7utfHWNIXMrv7IAasnjXueaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077849; c=relaxed/simple;
	bh=CxR7iaGSF1kTFB/w3UvXwYwURxSLrDsxj95Sim0Fz7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAWoT0v57Zl1PjRMhF3MTRFfqHfI945H8v8Rg7DPTpdzY/aPxV4Ru/8o+TMFcuHFnTbGCTZaXXdpAf/czBrtCGtmOVs0m9g5aGUeRUWNWglzOodRe5NYDj4mu0c98h9dDeSS1kI0+9WB7mopBRHMjt989gUFs2dHlZ0s53UjhLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSBerVUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C932DC4CEE8;
	Tue,  4 Mar 2025 08:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741077848;
	bh=CxR7iaGSF1kTFB/w3UvXwYwURxSLrDsxj95Sim0Fz7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PSBerVUxQW/Tfe3E5l/eUgfUOvl0Xrowyh9HzNRXWzaR/0iHe1dEVI3yIHclNOHe/
	 lBr3rbRepy4r2Wznsyb4tQIt0YeHPClx1/uq8X077mBEwl0Sfs1ArOxhdeKM9kfHYf
	 O9VZh6HwMP7vzwQAZszA5fcKlo2+pDG1hbNZ/gaBA/CEVdNLyxr/lBaAV0YVAxWwUy
	 6/oVMZ3EI4oSnS6nrL5jyd67utHmxTjopD6iG0XSpEWH2JegR/I477iw3ZOLDC7pXr
	 tJHNS1D4XDIi0Eg5hGU/iRo6iXPl2XgRUR3XjM5QRgVxP4qpPtiLyndDmClDR80LGf
	 Za2xmNItS+sCw==
Date: Tue, 4 Mar 2025 09:44:02 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	willy@infradead.org, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, lucas.demarchi@intel.com
Subject: Re: [PATCH v2 19/24] perf: Simplify perf_mmap() control flow
Message-ID: <Z8a9Uro1rrRgIBai@gmail.com>
References: <20250205102120.531585416@infradead.org>
 <20250205102450.350989371@infradead.org>
 <932e26ff-0654-442e-b6a9-166a7da03fd7@amd.com>
 <Z8WQPds5x8-9ABOm@gmail.com>
 <61d3449e-d5f4-4099-a25b-cc8925b80e30@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61d3449e-d5f4-4099-a25b-cc8925b80e30@amd.com>


* Ravi Bangoria <ravi.bangoria@amd.com> wrote:

> Hi Ingo,
> 
> >>> -
> >>>  		/* We need the rb to map pages. */
> >>
> >>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> This comment should also go up. Keeping it here is misleading.
> > 
> > Yeah, I did that in the conflict resolution (which conflicted in this 
> > very area), so the end result in tip:perf/core (or tip:master) should 
> > be fine as-is, correct?
> 
> Yes, tip:perf/core looks good.

Great, thank you for checking!

I also picked up:

  bfd33e88addd perf/core: Fix perf_mmap() failure path

and have added your Reviewed-by tags to the series.

Thanks,

	Ingo

