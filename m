Return-Path: <linux-kernel+bounces-372753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42A79A4CB5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 11:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C583284699
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A4E1DE3B8;
	Sat, 19 Oct 2024 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iEzAFHIi"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DBF18A6D5
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729331362; cv=none; b=AdWoHQyMVBaU9SF1cVwKoIZIv/i8fd4Hmt7+LakbbvDzv0TF3sqp9k4fnfF6bi8jzC3C3yc2bJD2bOEefF/002tPv6BSeQH2eX2uL5qkyxizzLnOv7ZeNxNCCIIROsBnkKJDvA/X+mJc+F0NeJhlKFVkIuEN9tDTitxTnYiO7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729331362; c=relaxed/simple;
	bh=KdRRrdfxOsxFkMNPK+2L/N5jq7O5fFXuSwYnktpXVIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPC2zYzo+ipeR48f4IOSDyp3HnAcoGInbr56g5/uEq0i7UkzLHt2vo8CBysiYASMcPFmwu0/1jbWdr7OKNGbN7Wu1HX1EwIcFhw50y6NoNG5xRoStQmGxMEeM6UVAlYOiiVYjs2PWlp63aClK9qOExQz0392wnusDQt74xgcbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iEzAFHIi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E0BEB40E0263;
	Sat, 19 Oct 2024 09:49:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DBfWlFqW7xXi; Sat, 19 Oct 2024 09:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729331353; bh=1LzGwMCPr0rKWMNsv7I1BDJwgYNv+rQJmqePVjQkhSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iEzAFHIi7GDjIeTXw+bbddhSNReahIB9tqFSMr1tAYVTZvw7+9fn5JPAczF9Mhe93
	 qsxaC5csZRG7pqOnmnTXkIMKNPeJrwvM9ENnuK4V+pzizFKwlZa5pSEbmWOJNgHe7i
	 IptmRvt3r1Q6jQywBlLrhfxzJBdlA9t5Szaf3T5LL+wiq6l1K4ssfjxT8Wx3r0A9Ox
	 Cr44gIg108YnPpQuq07aAVh8QaYJ5qlkRgco7Ebssls8LniEbXPT/MA8sF2k6UaW9K
	 ACw4ktq+eWBlJf07ZG+6a8G308RWu/tU/h3C0gAYUKEo4+L15e8hA2JI3+utcjj+30
	 jEZsw9ayI5lfskg81gPdj9qP4xnmXc2QsXFNTJY8gDoEtgLAGbHfmMiCiWPU/2iO+o
	 rdu4kc+XwpdgRgnNIWvtVZHDJRfiP7WuMuvOp+5GtDNseiaumSjSEOubosw29L+xDS
	 Uzd6Q1s5J2Wgoh2do5dNu9HhX8blAvWAp9R54CqQo1q3U9qB0BP1FhxmAyqCnQuqX1
	 E2rCowOWAd0z+aXipIiL6XyBrdvmdPacS40kUgCQ8VhEKSnfWpIF2x7XJbYdI91wW0
	 RptEO9WhQ/M+/eVTYLoW9r+h08xCxFo7l/0PtKjq5egOjDe2qfnYV2EJZc9RFBLUzS
	 ir95mJG5xf/siG+5kJfkLi9Q=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C778F40E0184;
	Sat, 19 Oct 2024 09:49:06 +0000 (UTC)
Date: Sat, 19 Oct 2024 11:49:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Oerg866 <oerg866@googlemail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/microcode: Fix crashes on early 486 CPUs due to
 usage of 'cpuid'.
Message-ID: <20241019094900.GBZxOAjKWsvPpHJQ0w@fat_crate.local>
References: <CANpbe9Wm3z8fy9HbgS8cuhoj0TREYEEkBipDuhgkWFvqX0UoVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpbe9Wm3z8fy9HbgS8cuhoj0TREYEEkBipDuhgkWFvqX0UoVQ@mail.gmail.com>

On Sat, Oct 19, 2024 at 08:29:04AM +0200, Oerg866 wrote:
> They assume the host CPU supports the CPUID instruction, which
> the pre-"enhanced" 486 type ones do not.

"host"?

How exactly are you triggering this?

Are you running some weird guest or is it real hardware?

Any chance you can share details so that I can try to reproduce here in a VM?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

