Return-Path: <linux-kernel+bounces-522197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC27A3C749
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247297A7678
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBA3215052;
	Wed, 19 Feb 2025 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BwE8op6y"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A537214A91
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989267; cv=none; b=RTZGAjfyOQOPtB738YSnKJbSo+4pE7LVKoyrMwm8nPPeIbxWV6HD7rPwP03o+Las5UDiTQAYio1XjbkMUI/Yiocw+LV2y/vTH5lUUh03SnezP/0V16Oi9MZ/b+HwYhTvfTU8Ep7oUYnD89jU2c38sv0Fm1E/6+qvQUzfWu/8OUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989267; c=relaxed/simple;
	bh=8CgxNFyMM7zmFDu9EisOs7jtPU4pHFGMxPxBbuPvqOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOTklPlRcY7QUGgkkGxxu4iiFJB9KTVApQf3W1ldKgon8TnzTsttAG4KMUp49Tzi3+XbrYSvc2nQXAQQOu2UuA5Pz4A9IWyOpoK03idtc1ntZBOvnKhpqIhJICIIuj9tOBY2p333PTkNnqwksoLGF15xBxdpJ+ki1WfQFymduDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BwE8op6y; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AE63340E015F;
	Wed, 19 Feb 2025 18:21:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zmtvIYp5kkgb; Wed, 19 Feb 2025 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739989257; bh=ATO75li95qD/O2WQMMZ9TytqExWfoWWTxFG2Bb0yENQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BwE8op6ynPbNPhzPkCqY9XBmtMaxuvE7/JuEnaPopXjClTXqGVxKinHkv/KlUcBr9
	 c0bZ9mnvzHcLE8Hs6NTuhX8t8QQKTBbcKsCM6v1gtLNj+Pd3hBDc83MFo2YfFqqWhU
	 he/5GEa3bL3ou04JQX4mAEPQXPd4SPdjUPjI+eTCivizg0YgQ1lrDi+iNR2p29Y1dz
	 urUjNRjvxtuXGJgVC6JtIONyN1U1oO6fgQusxDWzJjUxY0WSQXehQ+RWkhTEgGdARS
	 jtksNZICB9Wy/omBI/GICo4APOeZcW+oFf68MwTbi/rAqLAyu2LN82TWE9BZONGc0Y
	 hL1N4RyvvGKpmidXrv8qATHM7jI0pBjjqi99Vr7J3IU+2eSH5hq9Vakv+ydFIAcgZB
	 psNaENzHh93XyDA5ya2lIjKKQeexCSMoNnedTQoFXKC1boZcoefL8/CNTP0J8TziT0
	 owPGdRLuXXsXjB0JIyKEUfHXUR42wLobWNKBrErVzajsyM+BeIod5Na2ypFSuAQ3qB
	 mSI3WRdgKjM+xym1KgXiXU4v59wflB/JMJYfajtaXDQutIUb9UPzR6g8O9EOTGvap5
	 Z9RnlJoSAMBkgKsZ2Qezsg8CbJ/IC6TDxyklNYfPfhKN+qg4Po04OQGyPSZVC8YN1m
	 2ApBS8iVNR7a81GWPmmlMQg8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A52A040E0176;
	Wed, 19 Feb 2025 18:20:47 +0000 (UTC)
Date: Wed, 19 Feb 2025 19:20:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/35] x86/bugs: Restructure mmio mitigation
Message-ID: <20250219182041.GOZ7Yg-VlXLdgX7-3Z@fat_crate.local>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-7-david.kaplan@amd.com>
 <20250210232951.x4mbmpjy57jpunb5@jpoimboe>
 <LV3PR12MB926503692B759DF39113626294FD2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250211231839.bmcgj4vnvjyba74d@jpoimboe>
 <LV3PR12MB9265E88D27667AE6BAD9F7F394FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250212231646.gyf4zbqlq7f6kqqf@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212231646.gyf4zbqlq7f6kqqf@jpoimboe>

On Wed, Feb 12, 2025 at 03:16:46PM -0800, Josh Poimboeuf wrote:
> static bool __init verw_mitigation_enabled(void)
> {
> 	return mds_mitigation != MDS_MITIGATION_OFF ||
> 		(taa_mitigation != TAA_MITIGATION_OFF && taa_vulnerable()) ||
> 		(mmio_mitigation != MMIO_MITIGATION_OFF && mmio_needs_verw());
> 		(rfds_mitigation != RFDS_MITIGATION_OFF && !rfds_needs_ucode());
> }

Instead of turning it into a head-scratching madness, it might be a lot easier
if all the places which enable VERW mitigation, would do

	verw_mitigation_enabled = true;

and then the code can simply check that static var...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

