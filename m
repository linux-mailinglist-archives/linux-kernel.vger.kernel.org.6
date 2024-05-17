Return-Path: <linux-kernel+bounces-182564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2038C8CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260741C2125B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A369140363;
	Fri, 17 May 2024 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Qt+77uYT"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0E13FD8D
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715973849; cv=none; b=V3Zl27UddB8oYUINds7QQFjb4qY83Rz2iKVDbfRwASRM5K9XLapzo/NgRNPopUvQJel67GD40X1gDsCf/ZdVSDqBhF6L5GA40+fm/e0MrNQHownhopjN4eX6DzvEdqBAQUcgWwu04FJWF8Kj6CqeJrqRLkPdxfMgk6nMJLxoESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715973849; c=relaxed/simple;
	bh=jqEKv9YQWGDI6y6rk0fH+p2w4mRzFWQV7kfY811W3+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9FrCjKFqFu4jMD/tOUWnV2j0orkkq0/TdMq8UaN9ZNrMo98T3Sal83//AgE8a1cVd175khQuA6zUDiXyqLggdoRPlyZ4/PbYnownrWCui36vkRmpFYeFNBtWPkXT1stlnAaOL3HjYLEh9+IzNK4OR9zi/xRjkg6nIWeex3+ApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Qt+77uYT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7863E40E02A7;
	Fri, 17 May 2024 19:24:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UwbL3muqleYo; Fri, 17 May 2024 19:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715973842; bh=J7Crj1QNIeK8QjGNMpKjSRCjOYd0KfF9nXq4uixkpfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qt+77uYTuH9Iju/AJGYrr2JQWEWTgnbtg+yQ6REinUitmOS9zxjWx1jcQ2ytOTS0e
	 LNGVS7d3EEt4kLnAMkac4MY9ll6nyKsa0h08GUYpryhFxCdXQIWc2cce02E/waclyg
	 DebsHPsfMCan4EbeLdPMQmf9lZa/ZpfmmBoka1gIjPcj7YP2/BmledV08TtOpchUtB
	 5VNtX/G3Mab8A1BVjNKq9VXPOox8KzFgWL2pxoPRL3yD1YUMRRwc49WbRdamQQCyDZ
	 fVNNHbAvn5DMZoS4MskXg7kIXZ+Rm4WpCg0/+XpFfpVEUFe9NJq6nWxjPqwCEnZO5U
	 Ac/96sF2Ms0zJFJyYuPqkmhvozYMKAhsFxNMDK8Vm5mXTXTxPGqSQ+drVjxmrVrPHw
	 T0y/R85jwFogGURtSsskwuvklF1RVsD+/tg2snjm/6wXeW9fgMhB+VzFPwBQefmODS
	 6BtpiKmgSTy1YeWyy3lIOa1xzEN4eQL6cdbA18AX13yGA1hAh+OrQmXpDHpaZxUt7R
	 v5MOGiscTRL9O09BPmq+QeWfwmPdU4vCmvtE73foxAXyP/9xy6IaFoLfVapOIpBvn3
	 ZX0ovKIWwFY+af9zxf6GLq/Sh9UspGQWqimMmKu8DZNOcXmGJVFcfq11IZ3CU7ASOC
	 OASwOB+HfTsJJTQnOJ73fiuc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1824840E025E;
	Fri, 17 May 2024 19:23:48 +0000 (UTC)
Date: Fri, 17 May 2024 21:23:41 +0200
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
Subject: Re: [PATCH v4 05/15] x86/sev: Use kernel provided SVSM Calling Areas
Message-ID: <20240517192341.GXZkeuvZmXug5gSbH7@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <07266b47e749267ef9a9ccbc9e8e9df78ed54857.1713974291.git.thomas.lendacky@amd.com>
 <20240508080509.GWZjsyNS0xBXUzKPUG@fat_crate.local>
 <22dc9ceb-4b16-be68-ed8e-c6a222619032@amd.com>
 <20240508195842.GIZjvZcpRz0bdkiPWA@fat_crate.local>
 <d3b59450-fdbd-2813-bbc0-58f9dc2ba817@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3b59450-fdbd-2813-bbc0-58f9dc2ba817@amd.com>

On Wed, May 08, 2024 at 03:09:02PM -0500, Tom Lendacky wrote:
> If we're not running at VMPL0 (based on the RMPADJUST check) and if the SVSM
> doesn't advertise a non-zero VMPL value, we will self-terminate. So those
> values are only set if we are not running at VMPL0 and the SVSM has provided
> a non-zero value to us.
> 
> I'm going to turn the function into a bool function so that the call
> becomes:
> 
> 	if (!svsm_setup_caa(cc_info))
> 		return;

Sure, I guess I'm misled by the

	if (bla)
		sev_es_terminate()

which is a function call but I need to read its name to realize that
after that point we're either terminated or we have all the stuff
required to run on a SVSM.

> I do. I think you're missing the RMPADJUST check that causes the function to
> return early if we're running at VMPL0.

Yap.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

