Return-Path: <linux-kernel+bounces-196826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469E48D623A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82A11F268F2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5664E158869;
	Fri, 31 May 2024 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OUyqM52d"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507271E51E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160125; cv=none; b=Mk9mMahDOAGEIURxf2ZmhO1Ltu2O5jwo0duqo5f2iToihy/oR2p33tjSWSIAOYtQpZluuNpjlRCw4XWf8RJ46o97SU7WOvqAk9mXHdwiaTc7jnFk1l5MOEiB8I2pbM5zc433i/EBQAQI68rE2BqmOCVfQN+T1s9doFolWukNk/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160125; c=relaxed/simple;
	bh=a/D3i575KXmjs7d3uP7ukJ/cbXpnBh5AO1m+44Pxc8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJzPYo9gIG4IODbIvrxgdDdgfL5/WtE66o6fvea0OZtYBZSt7wmUygdnjfpFxlEIXo6yrTEKM9rBIF+AG4uQ8zYqodNBuTKpGDs8kmiSc5c2wNcBEhjMAPu6cXVA+1+x6rcw1QhC1vLreM2kQfLokZXZVjr0eHhAO4FI2U/3Mio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OUyqM52d; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 301C740E0192;
	Fri, 31 May 2024 12:55:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Luq9wZmn7Uji; Fri, 31 May 2024 12:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717160118; bh=h5Et4vSVp4DVw+C0adJbFGCQ6V6GUn+XWLm+lVGgBnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUyqM52dum33Rm4bkKvFV9lT4IMRj5P2NLWy6zTjXV+somuQez7U/iNXj4yGu9+5Z
	 QKLIswBH5ncCK/roq29gfqXlpblnYKR+4w3IzICvXJlgdd1udwQt4j5WES8uwaq9A7
	 35n6J8MslwWOXlkHXbHJpSyRljZmJprqx8S7ohXHtS+imtVNyU2G9nSlAdn2U/WryH
	 GjVsdhMrfa6toXJkT5IZ/C3kvq+FNmOk4c1bcbij8+m+hRQWVg5uGkaggdb5Q56mP6
	 cT6X8V6OjNi5ZBuh2A+1A+CiK3Cww8N93/SSLFtTuZkTBlFYfBzB0WgIVTqWJ54i3i
	 Rz1IZDKQC0p90Uonjpm17cWhpQoBin+uYYMCUwgsH5u9N31xR8sbQkUJCUBMH/0ccX
	 sNZKooRz1SAXICFiE6w6Pgrv1aNrhO1s/iIBm76y20pKXbX5B/DJpUp9pprMjXDeZo
	 r8k27UzJpUFmJ/2VF9TA8TZfH6F2RbylTbmOWVQLzLjVGwQPDoUdIjKppi5Lt1//k3
	 fe4YKzPawWQtBKC7eBG2cB2oBlG8BjiETj4rtIw/4zQrtm5gIZBUnsltJ5CMl/Ey0c
	 rTt9f9XT4oLKZ0I6z1Jn74FJ3c0p2p4LlDov/8kf+UcA8jOfZ27Ij477oqRMvD5r1L
	 iLFIl0TfRKO3Q+VyYlXzLkPI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE71140E0177;
	Fri, 31 May 2024 12:55:04 +0000 (UTC)
Date: Fri, 31 May 2024 14:55:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 10/15] virt: sev-guest: Choose the VMPCK key based on
 executing VMPL
Message-ID: <20240531125503.GEZlnIp7YobFu7g9iS@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <b8508f57712e3194484aa8695494eea26abe1b73.1713974291.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8508f57712e3194484aa8695494eea26abe1b73.1713974291.git.thomas.lendacky@amd.com>

On Wed, Apr 24, 2024 at 10:58:06AM -0500, Tom Lendacky wrote:
> +int snp_get_vmpl(void)
> +{
> +	return vmpl;

The vmpl doesn't change after init, right?

If so, you can make that vmpl variable __ro_after_init and drop yet
another parrotting accessor.

> -static u32 vmpck_id;
> -module_param(vmpck_id, uint, 0444);
> +static int vmpck_id = -1;
> +module_param(vmpck_id, int, 0444);
>  MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");

Can the driver figure out the vmpck_id from the kernel directly instead
of having to supply it with a module param?

This is yet another silly module param which you have to go and engineer
into the loading and have to know what you're doing.

If you can automate that, then it is a win-win thing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

