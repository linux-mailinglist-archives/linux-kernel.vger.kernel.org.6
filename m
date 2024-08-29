Return-Path: <linux-kernel+bounces-306982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8998A964672
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A98D4B29172
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E141A76A8;
	Thu, 29 Aug 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZDnUaWz9"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CAE192B6F;
	Thu, 29 Aug 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937902; cv=none; b=Hzw4GQYfpJH6nFt2P2sQV8v7qKreQKOSTIu/BHtO88K0rmnm+/U/5mMlTbBruz6C63k9+RcDnmd6DVz0+066xN9xB8HLBRDwWNlaf5lITPK7Yahn7Pmt5zV0y03rT3c+pSD983zj2PwveHoAYI2o5HsNqDijH2+ZD6X9XEit1Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937902; c=relaxed/simple;
	bh=GV60B7TnA6DnC3HM8+W6F2D5ilvKsXaFmGtCwJfJZaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9uq6obTBJgXbNt93P80sa/79HXrDRWDV/4xxrBlhFboKNNvVMKw09JRXBEFjOI5E2Ci5c6etzY68XdTtTcunqm2IOw05vYNZW/ACzfq5HwCG9JMEtcCvf/rEhQStYSoA0Ov68ppPwSEINDK/GWd7h/oN5tEUmAojq+s26sR96s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZDnUaWz9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6950C40E0288;
	Thu, 29 Aug 2024 13:24:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RLZtmtQE7s3y; Thu, 29 Aug 2024 13:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1724937892; bh=vNtQxJkHxft4astBfVL5KicdSbzbOp9p9GXUzMP7v+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZDnUaWz9X/E9xmg3UH8tRu4v44eG1CImcZvlSx/eqNtKxY1qS8SnEK58fLTHjPZje
	 aKb/XjUwAnfyWJEAWToV1v9aykcJCpJMjkEzdTsYeA1AIZeyEoxOSSEo5jfIllFRpR
	 DM5pFQyW7obJ5D3nHZGP9a5uuBVrP2Tg0/PeGTqH4EF0UfGR2T9hF3Mfm5CVSf37uy
	 hmdSvh8z2/RhoEgP1hhgwYD3QaAKY1SfteFViArQMKlCqSKEiUrdYm3bN/w3MBskTL
	 S8MeqtsDpZg+T4OE1KltFIdFPt1Cz5lSWmRJVIo1fMOCFlOrAVwTlyL4ADY7Q0+5VQ
	 mMQcMJ4a1xX2EeqGLrIerf7SxDVsWpxT6r7nT88bEAY6FKffIXhZqjmzSgnCCf3nPa
	 5/kIjhrBSleRvPxQ6WqLZsrLL4nkHviueKIlKpLUDgDKqhwM9XHsfri5alpqZ611VX
	 sX8aoML67u40katcGp8s8qrX4Uvp1fgdpGCXYmJkElHK3a1d+c5k21r3E2PJkgJVx3
	 4cNsUidy2tIlJVpNu5x6U2+CdRelRQSXgpjZTUzYCDKPZ+0bKIM/EsNCv0rtQZ4pD7
	 vlABlzJ1pkAdnOyp389tjEHURbdlCEj2K2iCBr6eyxQ2pgNuLfSt4tzrM+xrJO74IW
	 SqyPtt1c+BQsX9up7As4GSbA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3ABA140E0275;
	Thu, 29 Aug 2024 13:24:39 +0000 (UTC)
Date: Thu, 29 Aug 2024 15:24:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pavan Kumar Paluri <papaluri@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
Message-ID: <20240829132438.GCZtB2lqeYpleYk9c4@fat_crate.local>
References: <20240801205638.6603-1-papaluri@amd.com>
 <20240801205638.6603-2-papaluri@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801205638.6603-2-papaluri@amd.com>

On Thu, Aug 01, 2024 at 03:56:37PM -0500, Pavan Kumar Paluri wrote:
> +#include <linux/memblock.h>

What's the idea of adding some random include here?

Does this file use memblock?

I don't think so.

You need to resolve include visibility by including the headers where you need
them:

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index dd302fe49f04..d3e7f97e2a4a 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -8,6 +8,9 @@
 #ifndef __ASM_X86_SEV_COMMON_H
 #define __ASM_X86_SEV_COMMON_H
 
+#include <asm/cache.h>
+#include <asm/pgtable_types.h>
+
 #define GHCB_MSR_INFO_POS		0
 #define GHCB_DATA_LOW			12
 #define GHCB_MSR_INFO_MASK		(BIT_ULL(GHCB_DATA_LOW) - 1)
diff --git a/arch/x86/virt/svm/cmdline.c b/arch/x86/virt/svm/cmdline.c
index 507549a9c793..f0a532108f49 100644
--- a/arch/x86/virt/svm/cmdline.c
+++ b/arch/x86/virt/svm/cmdline.c
@@ -5,11 +5,8 @@
  * Copyright (C) 2023 - 2024 Advanced Micro Devices, Inc.
  *
  * Author: Michael Roth <michael.roth@amd.com>
- *
  */
 
-#include <linux/memblock.h>
-
 #include <asm/sev.h>
 
 struct sev_config sev_cfg;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

