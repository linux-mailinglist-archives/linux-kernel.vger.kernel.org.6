Return-Path: <linux-kernel+bounces-398886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C879BF792
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BDE1C24087
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEBE20BB27;
	Wed,  6 Nov 2024 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NOgjvecs"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECA6209F38
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922439; cv=none; b=BaLLE61FF7Og/BhCh28L5RIKDI78bIG10d+CxALN6W7f80u/YLKA5BdRUcoN1tAepjw+pXWO4xIi1KnCqiWmYvWKw2/YG9z7PZDvj0txr0XnUaxZeg1QoyNUn2zp4Pbn58V3sykdXIHtXecKKoEpVPkMUg2WPUSM0K89rj8R+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922439; c=relaxed/simple;
	bh=K44yoga4VIhQeNCPZsLu88MzsWWRBcfEnjv4cEeYyfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+haGI3Kby6Q6tqCiTcku9AeOS7jhdbLS3nJ8IDC+aYbKcV/+E9QK4i8xjG37L9pLhKbqNzTVqiH/ZqRjOWMXtLIc6Rs/V6tZxyTHoecmHQ9G8yJw7WThpujlWz2RJnEBMGXI4sjxilZBi1za1g0KUNG2RG8kN3yI9r/lDCCXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NOgjvecs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 495FD40E0261;
	Wed,  6 Nov 2024 19:47:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YUTYsnELnGyw; Wed,  6 Nov 2024 19:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730922430; bh=H5Gjfn+B+EHWqSPOlyScGe2vQXYXrhjgCwEMZg7sobo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOgjvecsJ80sDcB5mT847+jD5vOS3hG6bpZT26jJR9nq/OOlyvz8AhZHmVDDkGNrc
	 atc9GbN63PGC/CTg4q76Hi8r2Jc5iMZ3dI0otuEOOIx3MiT5BeoR4mzAzfJPzDs6Sn
	 0Ha4XgVnum84tUyQe74rp7x7yOwAjGB3a+lh3mKz4U/UXJ8v96LoZsOzS1K1VZ/kWE
	 IL7NMR7t2mo1vJInph4MNEbsKLZoAUZKqfeZFuSgXsu9BokCNbw6iEPlrfYH1Ui0s2
	 jwaX3oPE7qehHAauYvBtMW0TNXMXvhSrpnm3485K2uemm2m+zYrHyWfh8UsSCCcYJQ
	 oOLj6amKLurI0bO9bHyL1arGykgcOXcUOqWwR12KTi7biGTnFPIIhhv485qKWayIXR
	 F3T4D9miNZSbgpO4GXITis7zN29H+0bLVdyueKGhB8ATit5Op/kqmSvt5l5CTwAzRu
	 mJBeWk5xARbrZNbE7FhXkJ4Mk+DR0y2qyhhnhh36QyVz41V3EfQ1itO/Yak/eAxWz/
	 wp6vWmTPbJpQjjOPbjAyQrQBv9cUuLruv0wT/c3TMMUEh9n8UlwrA2eRiBkzSpijfE
	 L1rSLm2beHJ8s3aqvSroagnPJNv3FODj3WJHTQY+JbyUgciFHVZw+Ciyk54RWT8mRe
	 sXRFJmv/JyRhGCNCjcVvxb7E=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 94B9140E0191;
	Wed,  6 Nov 2024 19:47:06 +0000 (UTC)
Date: Wed, 6 Nov 2024 20:47:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	linux-coco@lists.linux.dev
Subject: Re: [RFC PATCH] x86/sev: Cleanup vc_handle_msr()
Message-ID: <20241106194701.GKZyvHtQrLXvZOJhbP@fat_crate.local>
References: <20241106172647.GAZyum1zngPDwyD2IJ@fat_crate.local>
 <4816aded-9ac4-c55d-053c-a7c7f31d11c9@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4816aded-9ac4-c55d-053c-a7c7f31d11c9@amd.com>

On Wed, Nov 06, 2024 at 01:40:47PM -0600, Tom Lendacky wrote:
> Is the !! necessary? It should have either 0 or 1 because of the boolean
> operation used to set it, right?

I was going to be overly cautious but integer promotion will make sure there
really is a 0 or a 1. So yeah, I can drop the !!.

> 
> >  
> > -	if ((ret == ES_OK) && (!exit_info_1)) {
> > +	if ((ret == ES_OK) && (!write)) {
> 
> I guess the parentheses around "!write" can be removed while your at it.

Ack.

> Other than those two little things...
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

