Return-Path: <linux-kernel+bounces-523416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF92A3D67A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AC317BB09
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422651F150E;
	Thu, 20 Feb 2025 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a5+I1Lno"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73E1F12E0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047062; cv=none; b=O12gflqnxXRubUkrdFm+KPhKIcSPIHSyJ5ircg2KoJSgi47kG0fGIGkg9ZsBxnOXh7/HpoCGncFmWK4spiw+CV877SVTDX1QgdAar8o0Ty+jI4pPC1gBPZBD9dJ6IgY0owCxO5WSIxj9E/5X+xFlv5IT72Z2djt9s60aHFFDRgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047062; c=relaxed/simple;
	bh=q302bG0dYTRx3Q9MCyxwC8fqiRLPWMrMdb289xMHBhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdm502+UQEuwworJEEWJRElobILoM4StC3tR8Cx1LGMwm+0wF0On2Ez1qPOwRtBLNqm1c7YLPnNLfJ8zI4COead/WYlM8Q2VoLWeFLTTHx5dmRfsG5t3FBRKZL2ZN9mrfJHvftIG0ybNBQ294HrG9I/IlwgWXg1D0fNMs4dLbYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a5+I1Lno; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 78FC640E0177;
	Thu, 20 Feb 2025 10:24:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y6CF0GisjbJy; Thu, 20 Feb 2025 10:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740047051; bh=G7hgjesSmpA0ko/eTOgvJmvU9Qe0b+EIBkdXyjk/XSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a5+I1Lno8dQW6mPso2rBSCErDnruVQpFMduikIWDT3ExtLMEG28z92Pia9zixNyIB
	 JGKlTzGAuphWYDhZNaSa0Jwm7hTNhY/pwmUCvVRRxcJVO3hqEmtZdLU5SdCywq6FYO
	 OMLM6vIl0ogEp9I2wbk1w6HgHhXjL9y1JPLOVrWvlNonVdWR2Ye2ceGbTDe2O4lUi3
	 BADExEKmokHO1ll+EKOV5ltRK/wF4lg0c5bKXqU+fFOfUkqMHWo4jlZynGQQyEnR8u
	 jof3vQjSxbwu0NcPlrAuJIJo0Vqrbmv18+Mkx2F78jZ3UDlOhdwwI83IjjGjn0TrFs
	 OZMhilT0Lh/udTtOrfO6hahU5Mff+f4EfBVl3r4UYALmSJrbd0oSkljRe3aIuhZ0wz
	 j6LhpNPQyYlgA57mmaGgpNMDabtjLqGBp/m9AY6dBU/XWTLV/gtGb1/260wGPCvVDo
	 sh9htXGmYnnHYhju8pgpNMmBm+yu9poItopA5TDKbv3nBU8e2mHnmKRF9gvKZF3HH1
	 j89onICHQaUFLf7THUTm7vAba0+Var8ces4qGdqLaRoFE2jyZ4pvUxxYAR8QWYWeOI
	 lObdoTr2JblxajHwvt2e3BPCaEgo45yjOWzHlzNGanlO621cVnZ9JCcDoD2ViX80Fu
	 RtxTJzCmXaMKFFyeI9Sg6z98=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4430340E01A0;
	Thu, 20 Feb 2025 10:23:54 +0000 (UTC)
Date: Thu, 20 Feb 2025 11:23:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: Re: [PATCH v11 05/12] x86/mm: add INVLPGB support code
Message-ID: <20250220102352.GBZ7cCuGd_hy-OaHlK@fat_crate.local>
References: <20250213161423.449435-1-riel@surriel.com>
 <20250213161423.449435-6-riel@surriel.com>
 <20250219120441.GNZ7XI2aWWUmXh2H2m@fat_crate.local>
 <2930024a88be186faa6a0338fc003e8ffefb710b.camel@surriel.com>
 <cb55a019-50f1-4824-9a9f-9431d8b89ed7@intel.com>
 <20250219191519.GDZ7YtxzBiMxz3wwlr@fat_crate.local>
 <ac406e2cc2daaed5856df0af787bf21597b95f5c.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac406e2cc2daaed5856df0af787bf21597b95f5c.camel@surriel.com>

On Wed, Feb 19, 2025 at 09:49:01PM -0500, Rik van Riel wrote:
> I'll re-do the series without ifdefs, except for
> the one masking out X86_FEATURE_INVLPGB (on 32
> bit systems).
> 
> Then the compiler should be able to get rid of
> the other code, when the feature is hard-disabled.

Thanks.

In talking to Dave last night, I think we are fine with having the majority of
ifdeffery in headers and keep it away from .c files.

Any new Kconfig symbol adds more configurations we must build and test but...
oh well.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

