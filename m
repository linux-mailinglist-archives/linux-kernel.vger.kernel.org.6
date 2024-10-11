Return-Path: <linux-kernel+bounces-361895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B8999AE91
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65C9B23B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B9E1D1E95;
	Fri, 11 Oct 2024 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MEuyn4Nf"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF204194A73;
	Fri, 11 Oct 2024 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728685007; cv=none; b=bZW/oTwUd7F5RYIkVAFPCZGewChhE/pQZdCjpRxb3OWlRshQSiSZDm/wHCBBxiSVF5gPzo8B7VrpZPTcfQ5xkXhjpfR0kLS/uXzF6RLk00iRHtbBknhZSxPJacK0n7ch/HdAstvEu1OfbKZWKc320Xt0bOK6urZWjd62EQV3iKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728685007; c=relaxed/simple;
	bh=WONhSOWCi175/80TtK3cWU+gWBvXyU9qlzVf+sT8ipw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoCM33eSpNEsNIjPJ30J05SOJz9pJ55WKo5FzXXjuvBIjJcwUEN53lgHTvgDdeuEIqxOA6MSX/47O9aeHKy1ckok9NiB/NpKPfseFdZBq1WNneh6kH8PWi6/4x6TKrH0CEcKQ3ooO2m1RG/RVWzqOEg2vWcD2XpxB3MmTRiGwBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MEuyn4Nf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C9CC40E021E;
	Fri, 11 Oct 2024 22:16:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VDBdf3Bmymee; Fri, 11 Oct 2024 22:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728684997; bh=uwVjeJX5+wiYDsRJY0b3ge6c8EGQGnn07CLN6ApCP0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEuyn4NfBQbLLjOUokVGZMEhRsuS7zK7TpjEjCVDuygbw201c+oSWZz7akfmDfLFs
	 bCwRB1maYRIXGkXktXtXKm/IIVPNgAgv10Wif5eoe6AQlAbpQG4w6pOjT805WFI1s8
	 zDqlYYgiUJAG+fWZsgYdABwpIDGK8H0489HXt5CGXtd6dQ0KZKCZvpRaNUUVJQgBvH
	 r1aWh4e4/lTZMdgOKDKTADlXj7TrnX+uFjQrAPSRvUg7OjgNSVSIaDZWQ6/2K07Cka
	 u291VH9QHCVkZXsKhZnyC4IUjlukRky9JSonCHXh3dvU+O3uXE7GP4/99WsJI84bJp
	 crVqzdwZ5BIu19UHuaSjPBVgCQMmKRgvvcN4qVkxhtcnyrAePx2Tt+ZNhD4toJ3vrL
	 EZSiRfc9q2sVex1QLLdQKD+HCqtlruTaXjRQU4ayUZukp5I7w8gyzmwA6/teyH+TGG
	 XRbS37ZkH9JpuV7wjCMBIWDtIZBpNX3zY7xp6Cq+LTzK3i533dZkq8elb9fWN7kgOZ
	 WyS3l9DofBd3C3Yk8qDF4ZPnDwjyLUqZk2aYERtiEZl20fus0zXHlclo5syo7tJMX4
	 bzjdatPgv1w3aD3DBS+79RG8bRpspLPLHZIp67qwsCvS5XOa+bkLb19j1Pv61N/6WV
	 OekJ6AYJRGGuVRrTX2P9GzL8=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9727340E0169;
	Fri, 11 Oct 2024 22:16:23 +0000 (UTC)
Date: Sat, 12 Oct 2024 00:16:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Paluri, PavanKumar" <papaluri@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-coco@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dhaval Giani <dhaval.giani@amd.com>
Subject: Re: [PATCH v6 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
Message-ID: <20241011221617.GHZwmjseuoz1fOKtps@fat_crate.local>
References: <20241010121455.15795-1-papaluri@amd.com>
 <20241010121455.15795-2-papaluri@amd.com>
 <20241011162120.GDZwlQgKTFi22JZ5If@fat_crate.local>
 <f8a3a683-0cdd-d1bb-1904-521ce5a96dac@amd.com>
 <20241011164825.GEZwlW2XggpAMsZ3P9@fat_crate.local>
 <7df1961f-f120-3914-ef23-9e466cda6248@amd.com>
 <20241011165912.GAZwlZYDO_kz3HQ_ie@fat_crate.local>
 <07b4dd67-9e09-eb0c-86d2-92fa68938129@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07b4dd67-9e09-eb0c-86d2-92fa68938129@amd.com>

On Fri, Oct 11, 2024 at 12:08:34PM -0500, Paluri, PavanKumar wrote:
> On building the patchset (1 and 2 together), I do not see the error, so this
> should have occurred on just building Patch #1.

You always, *always* must build-test each patch. 

Imagine someone is bisecting the kernel and bisection lands at your patch
which doesn't even build...

We can't have that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

