Return-Path: <linux-kernel+bounces-433524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5A19E5985
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69982282823
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5C21C9F8;
	Thu,  5 Dec 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aDdcjQka"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000621A45F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411724; cv=none; b=F63KsJNzePatygQddqbl3VBZdcuaCEbPS2eCFiZDk/aXXIj8MhHTkMQw1gL/Y/GYEV+TvJFpMW3ajSGGzQi0KypVjsK/uRmUSCmIGZlhEQr18F31MWLBaKdTsKKYgVhiDtzahTNtEUkI8u+X86qunBj2uX6SGK8Tw/6+KYypGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411724; c=relaxed/simple;
	bh=QY66S0/OlC0hzDjXfLpKbfycUP7XRp0OZtnYSFpzHM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyVJD+MBI9Ux6xp50cUazqRSL+ZJppgvdZ3L5JV848aJvTcWCUvMOIQa2O2K+sBQymS8AvfiI+iYcy32idH6VAWiZWsXC0FCRDzCB8t0VizwuNMVA+IIQSA6tzUL3wSjwPKhMK4AO7vwdYgoCALf8VqoqjZx6K/C1jJwdyXeu/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aDdcjQka; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3B7DA40E028B;
	Thu,  5 Dec 2024 15:15:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fBJvNDmaYx0H; Thu,  5 Dec 2024 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733411709; bh=VfgJ1XSNdQEO3/mI8kapBp+m0+BHrRwGFhksEYNHnYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDdcjQkaJsR9sU9Wcv9B0UsQZHZEaeqeQDQNAMIZqB+XzaaFglIfodNcyhNzOD+I1
	 BPUTThV/A92/b2yAtv4D/GWUdtZgvbsNr2f0GqWNU7GOFcM+yqZ32wnw6k5V5axGTK
	 wtY/StWs8VdR9OROABcjmir5KObE/yi/TdcTqk+5sGzhdQ1SSu9IfO6u77FUSoKazE
	 88jD7z5295f8NXbGl5u9p1bUoNCwTMhf4dkk+CRkEi5cW4yCnbtO1OIVybHi7+6iqc
	 yP3uQfmPnkgtJ9cIsQtCl6jJdtkVLT0cm1CIABChiHfxo2iEWisRF1xBH4mx5XOjsA
	 P/2HgOY5jKivYYNIiToH4GLIZ3XaWHI0iNC4zzPj6T/Ul8CmRaQ9o9tFD4L8J60Pir
	 +BPfMAKeFpcQUgjE6It3u5TKn0ANpKUh7RcXyET5HrD99xgZmi51LJCIhQN8iTnCiz
	 mN/mydXLdvoS8izapfPozaxoE3exnTr+x/mqgHBFC0JRKoFmU2XPRINRiLno9UaBo9
	 2YS9yLkLYd7fiSotYN19UGJIs1RlrnHLhXbV6T4mERtxEYPOFESRIqTgOi8ahYwR9V
	 2q/tCju1FOmU2BhZUEZpoKiIyi2x5Tg1IiWHARCP+uGRWAUyu3xjlTkASQWXUmARa7
	 l6bjWGzoEVhWhIlauXZTcCZM=
Received: from zn.tnic (p200300ea971f93C5329C23FfFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93c5:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 476B140E0269;
	Thu,  5 Dec 2024 15:14:51 +0000 (UTC)
Date: Thu, 5 Dec 2024 16:14:45 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] x86/cacheinfo: Delete global num_cache_leaves
Message-ID: <20241205151445.GAZ1HDZYWWRUFvuVBA@fat_crate.local>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <20241128002247.26726-3-ricardo.neri-calderon@linux.intel.com>
 <20241204143206.GAZ1Bn5jsTCvI_1ci0@fat_crate.local>
 <20241204163911.GA31633@ranerica-svr.sc.intel.com>
 <20241204193205.GBZ1CuNX-6hIDibZam@fat_crate.local>
 <20241204222238.GA31904@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204222238.GA31904@ranerica-svr.sc.intel.com>

On Wed, Dec 04, 2024 at 02:22:38PM -0800, Ricardo Neri wrote:
> Sure! Thanks! I can test it on Meteor Lake and non-Meteor Lake.

Ok, pls run this:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-urgent-wip

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

