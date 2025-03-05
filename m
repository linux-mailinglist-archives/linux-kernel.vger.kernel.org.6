Return-Path: <linux-kernel+bounces-547416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526A0A506E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D03BB7A29BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C081946C7;
	Wed,  5 Mar 2025 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="lrm+Rk88"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD26D198A0D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197084; cv=none; b=Zet/MGNFGR7iB21uRb7EqGZm2/odo8Qkwy2mOVC8XHnizZM7Vs451QyzwhPBILetfXaNSb2becNoKgiA0U/7pvQWE9keLyRQNiEfIV0Q1WmTZm3r0Ogpi2an60h2Y31MtQ9yr3I76V7/VDZK0sOhoiId0V5Bs19F/AhbiLueIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197084; c=relaxed/simple;
	bh=zVwZulNw1CsNHQ6jd2ytvhUZIENaAwcy0LwBcv+CQfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0bXxvCrYGEl66TkkojZ5vcW//sDNa/n7r3dtmTQ90PKqr3Xn1AgovmIkZA2j9yUbGV2CBapqTGyx9e2QngJJxpRHFm9YG/CF7X06+kiimJHec4T465/e+NVcgFlveN8VCZ5fmFIADob4N79lqwJxly+uzSPmcrfldDpfyF0gGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=lrm+Rk88; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 357EC42EB0;
	Wed,  5 Mar 2025 18:51:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741197078;
	bh=zVwZulNw1CsNHQ6jd2ytvhUZIENaAwcy0LwBcv+CQfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrm+Rk881XFBf0to81/mRbEkqEP/nIAmkl9MpzFgcxaZgw7HgjYUiIYWLL7ibO1nb
	 Jdr1AqFt5+hItFCoBNsJ/tjjK6Jb/cUSWbBe5oS3pqoJQCX7wtMmk4TlIdsXeQ7GAX
	 miaGNyXkfLN7ewAe+U25sHGHYHmdi5iIbJMw7RwWQVth5gy38PdTtBTgC8kBjPqRva
	 DqyWHLupZ0A6NWWGFY5dRDB6j6fMrnf9Er1DrwWboZ5tKwVJmALxJ1DaVRkj1HywZw
	 VZ/beaLqm7ANXJ6cLeMTJ5HP829TpP+SngC8GaCppmZ61K6qa2YnDForlwGsWVUbr5
	 1ziXfkmcd+QEg==
Date: Wed, 5 Mar 2025 18:51:17 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Joerg Roedel <jroedel@suse.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z8iPFYx4q9VSttiV@8bytes.org>
References: <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <20250305165502.GLZ8iB5kAtQmW6fu1F@fat_crate.local>
 <e2f9c22d-d09c-46b5-9695-a052859d04d2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2f9c22d-d09c-46b5-9695-a052859d04d2@intel.com>

On Wed, Mar 05, 2025 at 09:09:47AM -0800, Dave Hansen wrote:
> They are documented as coming straight from the TDX module when TDX is
> in place. But there's nothing stopping an evil hypervisor from faking
> them, except attestation.

That is the same for MSR_SEV_STATUS. A malicious HV can emulate it on
older hardware and give fake values to the guest. The only trusted proof
is attestation.

> Joerg, why do folks care if they're running under SEV? What kind of
> stuff are they doing after they do the rdmsr and see that SEV is in play?

So people started to use tooling which tells them whether the VM runs
with SEV (and what level of SEV). One of these tools is snpguest which has
the 'ok' subcommand that basically takes the SEV_GUEST MSR and dumps its
bits in a human readable form. The tool can also do full attestation,
but for a first check it only relies on the MSR. I think the tool is
also called by some remote management tooling to fetch information about
the VM.

Regards,

	Joerg

