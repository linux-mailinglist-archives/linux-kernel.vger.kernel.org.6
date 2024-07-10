Return-Path: <linux-kernel+bounces-247245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBDE92CD04
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2771F25262
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77DC12C465;
	Wed, 10 Jul 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IuO0akwV"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67F12BEBE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600146; cv=none; b=Tsz+9GtsA3WQh+1ycQpPY2yZNEKe1lxOSEcXs3XsUfaY7lXFbExhxhdPwnRKaCONUBn2eoqWvYDE0GC4LDqnYvJi2/4uScGwijSrCk/RlLX/VUAvo/DiWtw9nNPRRTy/Ozb2LwGIcbLVHNezOSBzZELOJjBx1J4oGlNZDb7EJKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600146; c=relaxed/simple;
	bh=82PcTa7bx+K/Hz+Gpu2UxrwKXT57bQ+Qj7JMg8Nc1DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcZhrPXE8MJXo7ECjd0x3Waf+nQ8R9yRDN7o7PwjCIQyXQxj/1aNnvbOsPG43nPZjsDAylAo+ZVnSLJd9WIh1qLP0WeAPj+Si3bEtV+BYyjclgNvSVFDRDuvys4xjg78Wg9cNSxxAdJ9Uq+IAmZs48ythA4fKqXZHwrZB07/8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IuO0akwV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 71CC340E019C;
	Wed, 10 Jul 2024 08:29:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xMQNtBnnzLfi; Wed, 10 Jul 2024 08:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720600131; bh=Gz8zpmUEOhXBICxhQhA3WF7pBmoNmpOGJgO4k4XQxAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IuO0akwVKy5z31sjLRq37o5//4P9THV4bjwFbH+DQBREdWvV/6GZxCa6NidC09lr9
	 VUOQs7bh1ZZsUUQDmtYLJXpcKvMjHhkOGnbEaYpRPCMWlP7ngK+VVdZoT3iEJU36XL
	 6/oM3GNNAo3HP26hW2rLnMHJ7FHvccgvRofuCpX1dYyEK35tar5gBCqOyuxaUTIZEc
	 gGw1rMC5hMjvXJiF1ns2BNlOLQscFuIDGp3aOlQ7UOi2RoEqf9XQ6Ivq6x2aXnEOk/
	 jqK8R/DJF8H9/jR4Wi8YfunQyhtEQ8kuPmKcu0bFemB+RpKnbjBkdjletCO3zhk8S2
	 Y4x+SHXVoHR7j888B+l9zF3qDXO7ExasIcMZgt6H4A+VhV3FWwNCw0p/gNKQgAdcSH
	 fXDt7Ouup8bf+TmWEU/c52HN+H1V2eJKzOSTA2uQlA2aZ4A8IEIq4+KamMQy8knx5o
	 sqSsG57JqQ4yVgafh/IkuU3rFAAlHGs4+ZTbydaJ7OLrzE/GisTb2BHCpufUBCT96X
	 /QM+72ZVQhGBD3R6+rUv9e38Ki1mooZpoGk4NZQZ2uKstg8lXB0ww9+yJhh7h3abRN
	 naxA61CJigscHqkGEpdjmTf9ZPmdMyE4TT9Tz+EiJ1WPUCdFINxFDw388W0PDUqtYm
	 6vnsTFOeIKQqp3YZMMxvfp60=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89D7340E0206;
	Wed, 10 Jul 2024 08:28:44 +0000 (UTC)
Date: Wed, 10 Jul 2024 10:28:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, Nikunj A Dadhania <nikunj@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [tip:x86/sev] [x86/sev]  06685975c2:
 BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
Message-ID: <20240710082838.GBZo5GNvuxJbTjG1TZ@fat_crate.local>
References: <202407091342.46d7dbb-oliver.sang@intel.com>
 <20240709090323.GAZoz822G64Mr9M9lV@fat_crate.local>
 <Zo3oOK6RH2OJO3rC@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zo3oOK6RH2OJO3rC@xsang-OptiPlex-9020>

On Wed, Jul 10, 2024 at 09:47:36AM +0800, Oliver Sang wrote:
> no. when this bisect done, we tested the branch tip 8434cf006ceae,
> the issue is still persistent.

Ok, I think that should fix it:

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Wed, 10 Jul 2024 10:16:18 +0200
Subject: [PATCH] x86/coco/sev: Disable KCSAN too

The SEV guest code was moved to x86/coco/ along with the instrumentation
exclusion bits. However, there is a blanket KCSAN disable in
arch/x86/kernel/Makefile due to boot hangs.

Copy that disable to the coco's sev Makefile too.

Fixes:  Fixes: 06685975c209 ("x86/sev: Move SEV compilation units")
Closes: https://lore.kernel.org/oe-lkp/202407091342.46d7dbb-oliver.sang@intel.com
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/coco/sev/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index 5f72e92b37ff..4e375e7305ac 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -9,3 +9,7 @@ endif
 KASAN_SANITIZE_core.o	:= n
 KMSAN_SANITIZE_core.o	:= n
 KCOV_INSTRUMENT_core.o	:= n
+
+# With some compiler versions the generated code results in boot hangs, caused
+# by several compilation units. To be safe, disable all instrumentation.
+KCSAN_SANITIZE		:= n
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

