Return-Path: <linux-kernel+bounces-168657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF0F8BBB9A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE551C20D83
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9475522611;
	Sat,  4 May 2024 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="L0C3/398"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4FDAD55
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714827011; cv=none; b=Kv4e8dChmOjYBUYAcPi8l8a+TxgqjdiHUcOo7SN12r8kNHG5vb7xx0yHuRXBG07GnYSOincWGFv7UzjCWyUWzdSHLZFUHeZvFsg51x2OD8XpO+2jrYZcLQxaB3w5qTyMxPsQuxxBcWDywWdqwcjWfPozh8bc1i2rrKLBgbz6Qr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714827011; c=relaxed/simple;
	bh=kYRjptrSHqros01Q1vz/3AXRJUl/SkdHuuXPPuTN6dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8AHuHb1YCWbQG9nrJ3DCktGahkVIyGw8lZ5Xh8anrXm0j78Pr1r9neACdrRA+op7lchzMZi/TWrUcZ2gdLsDDqJ4nTrnUnO29QTQLuvVWXXGvi/UuY6HdNP2GbwSfODTzF3RD7BdHTAUoG19EwVR2uUUc3EUjxp+lxt801xN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=L0C3/398; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8737540E0205;
	Sat,  4 May 2024 12:50:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aUrHA8Da0kcm; Sat,  4 May 2024 12:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714827004; bh=R8hqKu4twXzDNkaRGcIA8trNt+axmGafimXuMcSBX8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0C3/398AU8Ag7kgTXEOgn0COhlk9uv5us26rsI/wDnwkPyGFfV/QUmVMvLetppez
	 ZnBE08rAF9NgEgR6Fwkc2RedwOtPkEkLtdFF8Pgxixa/ZNRLnCw/4MYb0mojfHNgg8
	 r5u7DZvMrSalU1u40i3Kca7X3TuG9Us+OLHI5TfBAtsYLqV4xw5T3dsIYq41XBW9FC
	 /CifoQqflsXGgD+Uxxn+WVxJIvBKEj3geLdOhiIqjWdexmpuOEj7/2zsQ/x6K4WC5u
	 p/PezV1yf7WIBYWPD5/Nr19izHwEfTgxcUO0Zq/rP5oH5h9y758E8VTY8RuYbP8BYb
	 No18gEek/P0BS3RGsUqR7b+PmD69HPN7m7rOqY90UjtDbTzMrRpRyuQSze74ZhwhyR
	 a7+9brUnuGO/QHe5N92K6Gs/y75C+MezpE5/+Vy+Lv38lYWdOXk5RkTPUIuC1YRer+
	 d31fLN6xnoW8tLF4W9qXtud08I/uQ/usEQ2sirywsrBtFKumKQbtrw65piboamEHEs
	 Fc6GubeVmKI5zFK4KM7VkIixAbkNMgWcziMKXgh6ImweR7vcPZ6PgCfCQZl7jdxkkE
	 8rvVNaaF1T0WKmXn371iscvSuGQYdWE4ldLsqcVSshJdSu43bV94BPdLg/h3O6tWX9
	 kXwp4OqnxSIhMqV455Iqa6/w=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9904440E01A1;
	Sat,  4 May 2024 12:49:56 +0000 (UTC)
Date: Sat, 4 May 2024 14:49:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>,
	kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
	Srikanth Aithal <sraithal@amd.com>
Subject: [PATCH 1/2] x86/alternatives: Check the correct cpu_data's caps
Message-ID: <20240504124955.GBZjYu84GHwqBc1_Ht@fat_crate.local>
References: <202404302233.f27f91b2-oliver.sang@intel.com>
 <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
 <ZjE7DkTBSbPlBN8k@google.com>
 <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
 <ZjFLpkgI3Zl4dsXs@google.com>
 <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
 <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Wed, 1 May 2024 11:26:16 +0200

Commit

  ee8962082a44 ("x86/alternatives: Catch late X86_FEATURE modifiers")

added warns for when code modifies feature flags after alternatives have
been patched.

The clearing, however, checks whether the feature flag is previously
set on the boot CPU but the @c argument supplied can be any CPU.

Make sure that other CPU's feature flag is checked instead, as it should
be.

Fixes: ee8962082a44 ("x86/alternatives: Catch late X86_FEATURE modifiers")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/cpuid-deps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 5dd427c6feb2..93fa2afc0c67 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -114,7 +114,7 @@ static void do_clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int feature)
 	if (WARN_ON(feature >= MAX_FEATURE_BITS))
 		return;
 
-	if (boot_cpu_has(feature))
+	if (c && cpu_has(c, feature))
 		WARN_ON(alternatives_patched);
 
 	clear_feature(c, feature);
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

