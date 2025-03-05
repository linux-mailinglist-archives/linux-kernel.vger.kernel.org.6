Return-Path: <linux-kernel+bounces-546686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C7A4FDA6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4713A7B33
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2701022154B;
	Wed,  5 Mar 2025 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T6Qf3J16"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34438233D98
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174338; cv=none; b=YDrcwGjBiL66hxB+UuQmHraWDTwLdWn8g8ZGWW7YZec/Kutm1Np7xkLEgwlvcqiSL7xwhbtUvh75Tgg+dflKepL1nSFEISPtJ4CgQ08y2kSvwNt9qAfzGSoIB4OHRXffpohUd+E0+k2YW4BZIQtCcmNwnH4rvwgWpi/skeO/tU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174338; c=relaxed/simple;
	bh=TBuQZ+E7NbRLslxayK95jJR+DlTqhUnTVK28bckaJ3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik1MKFzPDdB98E1E2qox3PkouDmeVKwh6TKYnCNpK3AtZsZkuRRbtDm+D6QvYgyBeIbXggslIjQ/LifOs2MQaAsQAmbQOJG+bygQOvhG+hCt6VIxYjEgw2z6gvl5uUpzJo7wUjdLly92QA5CeW4iGQNsF/J/Go3rFKgIHiiUmu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=T6Qf3J16; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3DBC440E0176;
	Wed,  5 Mar 2025 11:32:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jWaunfXrpJ11; Wed,  5 Mar 2025 11:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741174330; bh=QWrmXwMWd7f6Az6UZQ7dtBbxsckRMuPuVSLJbHOMLU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6Qf3J16gW6WBJlv0q3GL6lae4GDIC8dTFSnT8tgm5Yyg+efg5ncSw6bHOQYHmdXQ
	 W7dzGLA+dXG0z7XtG0ESy1bDXKTpQ7ZbKeZYqpuCwvAlBmkX+bqA7aXq+2/vmUXhm0
	 BUXakxv5A8M2b9m2JhVs4SpNy3AV36IlhB9TmwqOSgpTR7yXEsAXOWXpGF+kfa0rlV
	 Hzk7iq4QnHswazyogOea2ixWNyKeRFjQ1jpuRmnTflT7OvSsVYVEZt5S1SQpSF/hXy
	 jptMJqf28UpOwIfC1WeMP169vd2fqDJkOtqz1yZvhs5r5q/Z3zommo5Z6t/fDlXQDF
	 FGxKyPRccSd4YbjelhZj4oD6HPd579I1+W4Wp1O3ZTCkqYUalq8U+XauskaMwMrncl
	 cB357XeicPv1C+8AGYPddBYEqSmDrCCR/ynQR7tt5dE3dPvsNaBxbWesiM7oqh+dh1
	 3TudG0+93IoIG/CCdv1MxU0cAtXBSTS7dXPzgzYtPd5pFOMoDCIH3FgEkrCVV0ZHDv
	 6Bu8JW5K7sab9/tmorDWNx/r5g0aN3emaRp81rhLO0BdaN6E+WfKcLUKVrb9bix5R3
	 3SUe00di1fTxqDOLrjJY3RKN2w425bneqajPvJdvHF3j8eGRm5W1D/Ku3h3MnlkRP0
	 wzWu8udNNKcrBuk/AOI44Jq0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5F3C40E016D;
	Wed,  5 Mar 2025 11:32:00 +0000 (UTC)
Date: Wed, 5 Mar 2025 12:31:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
References: <20250305105234.235553-1-joro@8bytes.org>
 <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8g01YhM_FtdB5n6@gmail.com>

On Wed, Mar 05, 2025 at 12:26:13PM +0100, Ingo Molnar wrote:
> It's *far* better to expose this via a targeted sysfs entry than 
> polluting /proc/cpuinfo with it that everyone and their dog is parsing 
> all the time ...

Pasting what we're talking on IRC:

- we don't want to expose a naked MSR u64 to userspace. Might as well use
  msr-tools

- the backstory is, there are a bunch of tools which wanna know this so we
  need to agree on how to supply it to them

- I think /proc/cpuinfo is the best option right now

- and then TDX can use the same thing too

- we have a general need to expose what a confidential guest supports

- a .../sev sysfs file clearly doesn't cut it because TDX doesn't have "sev"
  - it is the Intel version of a confidential guest

- and I don't want to have "0xdeadbeef" in some sys file but "SEV SEV-ES TDX
  SecureTSC" and so on user-readable strings

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

