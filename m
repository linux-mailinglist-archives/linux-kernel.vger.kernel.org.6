Return-Path: <linux-kernel+bounces-522292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C9FA3C859
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E81188B82A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF15B22A4EF;
	Wed, 19 Feb 2025 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aS1KptYa"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265C1FCCE4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992549; cv=none; b=PkJk1HwiyLVN7Ir2rVgkN1FBfGeoaBEal27l00Pf8nzEq0w1f2WNrTSYogq0nGY2txnilG6Dcyitcj3NppxTgAPmbssqC7TwN/lbYDryask5TKQOzx/qDVBb/Ih2WV10SagnakKsXBDFPtCLgCvvK05hS23naE5uGsJ2L2jLa9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992549; c=relaxed/simple;
	bh=6GjeiMlcBQkMiICgrbnKaNfeb3KYt/3xgEOZ/XboP3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBBbilM63Xq5byHUFS9mkKsMCyv6g9/JJPKGM2DrkDxDu8BpmKAGAhGRtCrIHAZYUA4Qkzj41kLdpEPKoCcBcMdgmJc2xo710J0eZXDpX3QZfSmW2Q76maEm+QfMxYmHfQP6nm073nc9SuESG1XRAH/RuX2fSNrRsuHf2CEmZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aS1KptYa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 19FCB40E015D;
	Wed, 19 Feb 2025 19:15:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FByxDcaAGTRa; Wed, 19 Feb 2025 19:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739992541; bh=/Sm9f8CosVKerH6dIT1y6KUA7xfRLyxObBsshfAZM1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aS1KptYa6T4FSZsPmIBAg2jfpj+xpns2ARKi+2GWSwMiv2sqJxBhCQb853+G8SMOm
	 BPEUY1y7eeHmFDhB63IQhEtxMfBluBqdPd9bgL+wOgqs3NJXrF7CvIFYi+5QsO73fu
	 +pR5bI2PsdkRS7w9vF1P+s0/ow0P3SrVlP8L6h8US2TY2pAZC5ZlTq7EU75/uRhV2D
	 mDzYJwdV+dGq4NYOlMImLojcf2jeAQ+OGvxdgBo3yCVlsKHIgs2apkJ7QSMKL71NWC
	 gCgTymr9HTn+vXmXB5+odAP0WGhWT1l9vVJDSKVlgWfdgvXYm+xfvGgipteZO9iPZL
	 BCGf40y0Iw6Lbt0Rs2H5qWYM9ut2fHDldThihY3JoZ8a3yvcMV69iMrqhdXL7q/yqt
	 Eoi4dhp2eIyflN6cg5hNeCaWPK4o9t8gLytG9PBHoJD+xGuxcfcPkC1JsymRooHfvR
	 J8XQ5eE4M6Yx9SozAmC/oRXru4LuFDGcEH3oEQgSBZslscPoclAbwfjlsMA20tBzWN
	 Dj9FgqQlsK4VntZq3GBGjcd+RQJFHMRDq5kB+NimaR51vJbc4bjicGL7Mz+bweThTL
	 yjdFtMa6N9FQGh0Bc4v0/n0nNWKeLUrxPFYoyUTnzg7yEJOUXvTOhe+EezN2wv/n9U
	 eRZ1OtkFpPNdV/34Cpdjcf1Y=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0385240E0191;
	Wed, 19 Feb 2025 19:15:23 +0000 (UTC)
Date: Wed, 19 Feb 2025 20:15:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: Re: [PATCH v11 05/12] x86/mm: add INVLPGB support code
Message-ID: <20250219191519.GDZ7YtxzBiMxz3wwlr@fat_crate.local>
References: <20250213161423.449435-1-riel@surriel.com>
 <20250213161423.449435-6-riel@surriel.com>
 <20250219120441.GNZ7XI2aWWUmXh2H2m@fat_crate.local>
 <2930024a88be186faa6a0338fc003e8ffefb710b.camel@surriel.com>
 <cb55a019-50f1-4824-9a9f-9431d8b89ed7@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb55a019-50f1-4824-9a9f-9431d8b89ed7@intel.com>

On Wed, Feb 19, 2025 at 11:01:17AM -0800, Dave Hansen wrote:
> But, either way, #ifdefs are a sign of weakness. Less so in a header and
> more so in a .c file.

... and, as we just discussed and agreed on chat, we don't need the Kconfig
option either.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

