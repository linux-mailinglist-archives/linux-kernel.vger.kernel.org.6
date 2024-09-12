Return-Path: <linux-kernel+bounces-326355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623B3976719
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03004285121
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A55A19F436;
	Thu, 12 Sep 2024 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rw3XyZgH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A01917E9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138785; cv=none; b=H2Fhikabq3t/u9BbvsrFofUsUOei4mmm8M7xuShcyacKMyRmvDO3+AydNx+DlKbYj69RTYEvAhtO7/ZPQcQZMmn6hkrr8gI0diHYbiS2IOTn+fw8XMWwVRmcG8DUxoqFMovth0YpIlw0dh3IAFVeFE8qU0MsCggvRLfNz/XGUGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138785; c=relaxed/simple;
	bh=VZZ7uZM82VLdy3ctQk1FXMl3TZiKwSrNvb8gGxaGNm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBGrb3gSEvHPwbu8S+wDfxvs0vKv873SRE4P1JsVwqGlhR3H5hPyMZqk9LVu6RB2ci0rTeB8tkB3xZ5/WXxVuxTBdtP423U+hUfBIT/R9zGVe3k8VbTkIhnVyM25RC+Hp3VS5vHSadBZpLLxVyXj1oUmaGZno2pcsHyg+ZPZwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Rw3XyZgH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4663F40E0081;
	Thu, 12 Sep 2024 10:59:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AjzXOd9xJtGB; Thu, 12 Sep 2024 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1726138777; bh=4CW4dS8LJjFe3/o+6RYr7BQ1B8c7f0qe+Qtwyr8k9Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rw3XyZgHiyj5Hn7OnetUSFY/wlbZSflqRCCnoX9/y7pcQq5U/p0h3Q0xp5xxBa1PH
	 NTGJznBj+pS6JDmnXbVyQSs0n76sn9l9+wMp2a98zMx157uQKesdilG2ytJk4hUTah
	 Wemfa+JvoudDOA3U1qs7hyj99EVCj2eDA82E/++E5n5hcijUgjU9hu/qcNY7CdqRLw
	 9YAGGh1yCwsXbSslGplI/A9a5iTKH8lvTJHR73WUqhvFYMtsAdATXuNj36amTwJRrH
	 TtaA/qaXFqgs8lblTEsyziOuHYArB23hIfQ7px0eM3hVVE+KwdIdkQxAKacVOtRWG8
	 tyTd3BcixoLL0mTWfN3uVFMJT5l2l6VDXv0zVpy+P4FeYn/vdCidUl/C61Z5O6Qcip
	 klVTfGTNWguvHsUkHNfV8rzPcYuhTG0gTNlmSjrhsWPSAfEYchCRwUOFPfNgGGD7UH
	 sGu7pFLzSkg4wIgQrX8vgifcTMr5LeKvoyJVswsILufMYThI9XAYMPS9r7lWFDTaFv
	 UEKW8cyZGsHAfuUOkzFzRiviE/pSe41tscTqJ7XyiFLzIh1qPpGCMG0lEopIsa8c0H
	 HzwGszbJwNolxhMc4E3nlnPR1PeDFc6keYDsKccw1+Rr1tQUsIK0KiqkokAotzYW/H
	 ihW5YcNNQSbocJtZF6p3i8wE=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E6A9A40E0288;
	Thu, 12 Sep 2024 10:59:18 +0000 (UTC)
Date: Thu, 12 Sep 2024 12:59:18 +0200
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
Subject: Re: [PATCH v6 2/4] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Message-ID: <20240912105918.GBZuLJhtVBHKK54KFD@fat_crate.local>
References: <20240905060036.5655-1-ricardo.neri-calderon@linux.intel.com>
 <20240905060036.5655-3-ricardo.neri-calderon@linux.intel.com>
 <20240911140844.GFZuGkbHQ_E-K5LW1q@fat_crate.local>
 <20240911233410.GA7043@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911233410.GA7043@ranerica-svr.sc.intel.com>

On Wed, Sep 11, 2024 at 04:34:10PM -0700, Ricardo Neri wrote:
> Yes, both patches address issues during CPU hotplug (both NULL-pointer
> dereference). However, IHMO, they are separate issues. Patch 1/4 fixes
> a missing allocation check. Patch 2/4 causes the allocation to happen in
> case early allocation is not used.
> 
> If I did not convince you, I am happy to merge together patches 1 and 2.

Well, what is easier to handle by stable and/or backporters: one patch or two
patches fixing two very similar CPU hotplug isuses in cacheinfo?

IOW, what is the benefit in having two patches instead of one?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

