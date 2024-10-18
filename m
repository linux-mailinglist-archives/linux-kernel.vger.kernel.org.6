Return-Path: <linux-kernel+bounces-371720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFB79A3F25
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB95A1C22295
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982EB18C34C;
	Fri, 18 Oct 2024 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gWQiRQus"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE01433B5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256806; cv=none; b=dBGCeg7KQR3SotH3ZLq7wB5PRxqmisGk4Vb0iIWZ2oTcqZhgBc2FWcostBjqS3+i4K1EG7QJlHMPnJy+7TgYtY/vK8VUSfSdqc9lvr4b1i5DuRFbkaAbSMHZjblEOF7jVvpgH3KiCYAW4wosXIITkqGV2bXuD5LXbsBssa4vGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256806; c=relaxed/simple;
	bh=eUh/cHHLMM/78AgNa9IVlyH0A/lP5ncJnRCi9gLKujg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfBGnVj5JE/JyjLanwk8XQMSWIJe459AaPFRBAjQg8ObnG6KySauuXkIYpG0OwoCH/I65KDQ5dlcdaOJOuOJzgBvbm2tWRDAjKZsHxqvhsxDzmDqaUy6lu+sCqC5R2KUcj1HhPcaob7F2XMY8lgXO3w48lgbWGJJcAJL26H3C5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gWQiRQus; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 59A7940E015F;
	Fri, 18 Oct 2024 13:06:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gvvjCxpt8Met; Fri, 18 Oct 2024 13:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729256797; bh=JtdIWLWZDVEeW4J70S03R+bvFhrG9dIGV9T4TK7gMFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWQiRQusl2hFONKZbJX4xiXAksJUPjnv/My+xwtkFcIvbqtIuYptn+j0A+fezedib
	 b4rKsZxwl1RJ+4QK9KKnfLtM1MoUSJ1VnrP9wR7nMLxvehFuHl9Vi1lSTdP5tv7ia2
	 qFzlHm6MjeV4QdHXgk/GEcRu1j+Lw8PtlhAEs1EH2FubIEHzNp8z++qUVhBmXB+k3n
	 YieJZJGNclmxRodBWwC7giF/SZw0mCW/3QdEMt1j80yYdGPLTulEJeLeDM/L9RuGZ4
	 hEvQU6RtxzAYq5wDfv+PLOkqtGby+h/41kPZZkm7jD0l35Fbkjg1AYF3loldpzzyM3
	 7esvzXY08wXVUcM60htXKFXQ/Sejny84F9z51IypvrLirxZZ+0PtvI4cAyC9iQ6k35
	 L6RkyQf4y844doKjzG8LpG3n+++o5LKg7itDdftAzl8cPOjyeuDx9Wi/eeKXG7GCd8
	 wZ+leLQm+mzXQQiTBISfJz7QqataG1aYAea4yp8s0kugQgEDEeBQ7PARl2HkFmLeb5
	 3AHrIQEzf907+8iLZ9JERYHpzuzTdbrDOq3yPo9NMt24Y5/ynYT3bpVf4l7uzVWHe6
	 VmOGc/5/gUpDhUO2AD/raC5LGSDxnglzg6lGLpcABulZDLu31GEjkZGV3OtvVrwEOx
	 d8Wo7jDSHvfA4rEt4w/X5Z28=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E6F5940E0263;
	Fri, 18 Oct 2024 13:06:27 +0000 (UTC)
Date: Fri, 18 Oct 2024 15:06:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 3/8] x86/sev: Require the RMPREAD instruction after
 Fam19h
Message-ID: <20241018130618.GBZxJdSmQXOOgBRDLK@fat_crate.local>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <a8aa2542fb1b65371ca08ce2be40a5179aec6dca.1727709735.git.thomas.lendacky@amd.com>
 <ce1f252a-9ef1-4cf1-9d4e-bedab43fd7e1@intel.com>
 <45d69348-44bf-94c8-528d-9f5ac1aea163@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45d69348-44bf-94c8-528d-9f5ac1aea163@amd.com>

On Mon, Sep 30, 2024 at 01:59:54PM -0500, Tom Lendacky wrote:
> The one issue we run into is that family 0x19 contains both Milan (zen3)
> and Genoa (zen4), so I'm not sure what to use as a good #define name. We
> have the same problem with family 0x17 which contains zen1 and zen2.
> 
> I might be able to change the if statement to something like:
> 
> 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
> 	    (cpu_feature_enabled(X86_FEATURE_ZEN3) ||
> 	     cpu_feature_enabled(X86_FEATURE_ZEN4) ||
> 	     cpu_feature_enabled(X86_FEATURE_RMPREAD)) &&
> 	    snp_probe_rmptable_info()) {
> 
> which might make the intent clearer.
> 
> But, yes, I get your point about making grepping much easier, along with
> code readability. Maybe Boris and I can put our heads together to figure
> something out.

Right, that's why I'm adding the synthetic feature flags - for things like
that.

I think it is very readable this way and if this check needs to be repeated,
we can carve it out into a separate helper or so...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

