Return-Path: <linux-kernel+bounces-172907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC9B8BF877
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC731C22CEB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5271D45C14;
	Wed,  8 May 2024 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Lx37t//3"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCE02BB11
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156695; cv=none; b=RgQk/iO3LB1WKk41ZALnBrKAYgoCSEVbhW8HaUNug6vWuLC8AwmDYr1nnXnvz+UsQAuD/iU3r/d+0C6Gr/FNrXw/Fc5B93MIbgik/QLtJXPn7jpnDwATsblwdvK4Couo9A7uzpQiju0UNSjLzb8tOo0GRd5JQk9xy2lJwI2/+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156695; c=relaxed/simple;
	bh=4RnyJU4AtrXrc/uDoIgp3W1VJfd/uJ9jgFiWFzAshHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGplqSmEBMlhcrbe1EMSDkZL9llZPOtM2z5/gf69ooXZDxlRZhvDDBs/Z+9LEE3oSBxOMOpzYKU5d97XrQUrF+LthZoJwjPoXja3Fa/oy6orfKz/sF4pnOwAp2IsD72UtxjmoY9j8hE0po5/luewNN6/YSURXQmRHAqGj7G/6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Lx37t//3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 260C440E024C;
	Wed,  8 May 2024 08:24:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4eVKPAL546f7; Wed,  8 May 2024 08:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715156689; bh=4XAZ/wIYgWolSZJSRlwndi6e3nnKe+xC3HFhMSHclag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lx37t//3UMdyCh6XQbdnd5oRGOKpFljkUivPePVGVE5b5boN/rD/k3gjqkb2FXP0Q
	 hi9iJkKai7QPF549Dab2ZGyqGTXcNfW4vM9OVu89b2yzN9zIW4o152FJdSJxkQEsHp
	 oTYzobQv2zQ4y0M8rCNHlScHXiOiwgvnltn7hnpEDbHdoHN8Z/Py3t2Zh7V5w1IFk8
	 juHtNF0t+Ui2WX1InYvw/Kic/Ry4bKik+PKPOGNE4gRmu0yB2rkaI92k/czru6d6kN
	 T1ObQCYDS2YFdlSlKkXLIpnfs5/4lH8aCgDcX+k4SMgDQcm0JTMxvjG0UofG5G9PQd
	 SAW6c5/u3XX1ziIKsN4TFDE+Ewt4Xd6T2jqzio6Aiy5VX1vmfYgzsogePBG4fyHrpz
	 3T7iEmPikzXPIXEfC1+wk2wiDY22je4TlsCTDyV+DOK3GJ/W5yzSja8wzqECTcoBNk
	 OcY52w3KLNWrr0WCA/m+qbomxaYg5QJroE4LrycWSDM1jt8EjUHgP9vgnQ/FcXVC2J
	 y+6w8twLwU54w/Zy/XTbl7zQebWBjlVQhg3XSnPSEMSN+74nPZeu//38bdwzY6NSY3
	 V8F3sLv+tG5FxFk7PQWso76yVQPEL/CAwZ44Mun9Ai/7r8wWsSbMskGFdnrSrzCLrE
	 5v/EwvoDGF4c3aRtKgsHLBHA=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D7FEF40E0177;
	Wed,  8 May 2024 08:24:38 +0000 (UTC)
Date: Wed, 8 May 2024 10:24:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Oliver Sang <oliver.sang@intel.com>,
	Sean Christopherson <seanjc@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
	Srikanth Aithal <sraithal@amd.com>, fengwei.yin@intel.com,
	yujie.liu@intel.com
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <20240508082438.GBZjs2xsn4diYXU4ud@fat_crate.local>
References: <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
 <ZjFLpkgI3Zl4dsXs@google.com>
 <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
 <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>
 <ZjiCJz4myN2DLnZ5@xsang-OptiPlex-9020>
 <Zjj3Lrv2NNHLEzzk@google.com>
 <20240506155759.GOZjj-B_Qrz4DCXwmb@fat_crate.local>
 <ZjnTW4XQwVHEiSaW@xsang-OptiPlex-9020>
 <20240507114814.GBZjoU_u5kYBhLips3@fat_crate.local>
 <Zjsy8v0pZHPMkjPY@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zjsy8v0pZHPMkjPY@xsang-OptiPlex-9020>

On Wed, May 08, 2024 at 04:08:18PM +0800, Oliver Sang wrote:
> we really don't do any manual change recently, however, per your reminding,
> we rerun tests on both ee8962082a and its parent v6.9-rc3 again.
> 
> while we made original report, we always saw below for both commits.
> "x86/cpu: VMX (outside TXT) disabled by BIOS"
> 
> by rerun today, we cannot see it again, on both commits.

Yeah, from the last dump you shouldn't be seeing it.

> then for ee8962082a, the reported
>   WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
> disappeared also while no "x86/cpu: VMX (outside TXT) disabled by BIOS"

Yeah, it does feel like something underneath the OS has changed/is
changing for this to happen.

> we are using kexec to boot into kernel, and the kernel images keep same,
> so we are sure this strage phenomenon is not caused by kernel build.

Hmm, kexec won't go through BIOS so I can imagine if the kernel has left
FEAT_CTL in some weird state... but then if it has been locked, nothing
should change it anymore.

> now we doubt it's really a bios issue, we found another similar machine,
> which also show "x86/cpu: VMX (outside TXT) disabled by BIOS", but after
> several rounds of cold reboot, the message disappeared, too.

If you see that again, please run my branch with the debug patch - that
should at least tell us what's weird in FEAT_CTL.

> we will investigate this BIOS further and avoid this kind of misleading
> report in the future.
> 
> sorry again :(

No worries, thanks for testing kernels and thanks Sean too. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

