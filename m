Return-Path: <linux-kernel+bounces-186429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA208CC410
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28840B218DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B3770F1;
	Wed, 22 May 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="A8fJFvta"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E4200DE
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391661; cv=none; b=Vc38reJaZPhAclu0ObwybEefXhm/cH80CjXY5U61bq9lP2RCVYvbX96CHpddJewCN94xVvsVbo2PNaXsDMLtWi3YcEwJZwJN82h2jt4C5RwgI3OMZbe5qHllRL7A1fyXPapkte/Jc6RRzrIK+Y2vldwkK1Dav8a7eo0Bi0YY78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391661; c=relaxed/simple;
	bh=MfXp2+EG7ERX2DY/SopiVU4eFwkrfqmHs9m9kRKheAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uryZjXht1vRyupYcniw1Kl7qXVbDITYoFQDrKYk+TG64OpqlBKgXjqhIVeIYeLlcTyIePolocvZ3rjDCVQTCvMkTf+4wl3bmVzR49yN9s/lPwsu+IX4t2piZVFdF9W4rxsQlUFZ3A2Dq+iNhpajTGMAlgX+X8oZi30mQ9H5F4V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=A8fJFvta; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D4EDD40E0254;
	Wed, 22 May 2024 15:27:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id W8sZeqrRUy6c; Wed, 22 May 2024 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716391651; bh=OB6gaqSjxiAFW2RlpmSCnZD7Qhpu4drPtRMxzaVxZVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8fJFvtaQXZh+IL0mQwaxVMveFNb0QaGouYARbnD32GFsrOSxHs2vSfrlSvWx8b3q
	 8lGZBwsSfTj864KzXx/ix/EpMEfgk/n3juA6cjSkdyBf+id1aSxWyi8j3oIjWbeSNE
	 cpCYADDFi2pVs5ywMf9m2E9QdQY5NER4FJnDXqa4t+tNnVN3Pz61c/dFlDY6ormuQa
	 98znUkYr3r8VPxX1Pc7y+142KbgLiAuAq2UJsNC08fY+PyDsIs36f8bGSjl6UYCRVc
	 j278zltej0G+BTKXXM7U7zLosQMjnK1c7/U+jBDXqU69V9LqNPFydqbeSs+ryv+Dhq
	 9BysgszjnuutjF0s0gZeNyZMv9/RCs7Ej5R5iB4ega8J0ZLrVu8ojtE3VU9wQARuAB
	 czOq3WxNbEuEbyV8kTylOrU/hHikgLwVXG/TKCShxqNwat1Aac6twPuYzpbHdzCL2r
	 IKxAYL1MSZe4TMnZczgyFvjt3OnKc9U1CZHqab36ipRTvI3cQeu7D+w9FRDaL25tqZ
	 jpWxJd2DSePTMNKR+dJS2k18uMiae1r3Gt6lfAu8/jo6Fq1/kZBpXQLn+vV3GWI4Jo
	 USwLrSY/1tkfpdTWR84zycBGaOnwsuAkFue5w0hwMrZYb7GB4sFrD1DUXHOc9TFdeu
	 bbY2n7Ph8A+OoBSJWeKq9mFg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 929BE40E023A;
	Wed, 22 May 2024 15:27:17 +0000 (UTC)
Date: Wed, 22 May 2024 17:27:12 +0200
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
Subject: Re: [PATCH v4 04/15] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
Message-ID: <20240522152712.GBZk4O0LIl2r0dH--H@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <6cf54cac47f212f4c2b59b123855d8c183989022.1713974291.git.thomas.lendacky@amd.com>
 <20240502093520.GRZjNeWLXU5j2UMOAM@fat_crate.local>
 <66928741-aa5c-4bbb-9155-dc3a0609c50a@amd.com>
 <20240517155858.GDZkd-wkWmYegos-eT@fat_crate.local>
 <f8a92b19-9090-40ea-c2cf-707005f583a5@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8a92b19-9090-40ea-c2cf-707005f583a5@amd.com>

On Mon, May 20, 2024 at 08:57:43AM -0500, Tom Lendacky wrote:
> So this will be a new shared directory in the top level include directory
> (as PAGE_ALIGNED is defined in include/linux/mm.h), not just in the
> arch/x86/include directory like the others (io.h, msr.h and tdx.h). Is that
> what you want?

You can actually do this - it is a lot easier and still clean:

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index cb771b380a6b..5ee53a7a060e 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -12,7 +12,6 @@
  */
 #include "misc.h"
 
-#include <linux/mm.h>
 #include <asm/bootparam.h>
 #include <asm/pgtable_types.h>
 #include <asm/sev.h>
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 46ea4e5e118a..bd4bbb30ef0c 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1329,7 +1329,12 @@ static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
 	vmpl = secrets_page->svsm_guest_vmpl;
 
 	caa = secrets_page->svsm_caa;
-	if (!PAGE_ALIGNED(caa))
+
+	/*
+	 * Open-code PAGE_ALIGNED() to avoid pulling in the world and
+	 * more by including linux/mm.h.
+	 */
+	if (caa & (PAGE_SIZE - 1))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
 
 	/*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

