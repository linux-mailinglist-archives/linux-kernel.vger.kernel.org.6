Return-Path: <linux-kernel+bounces-203161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7614B8FD757
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2820B28597C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A4C158855;
	Wed,  5 Jun 2024 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="V4qtiawH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6060E1586F1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618497; cv=none; b=R3Ai6YhLBxiyqRFl95aaHuxaozu0UNLb8IKTSaUFuRVpDMDEJnDGtRGOaJSw+PM38ikJRCUMdgYKdZSnJPb0C+UfxDR5/nsNkXjFOZ0a9/MaU2BOEkgtM/7TkwEg7Z5bwDo3NlsUJb2nRTVeC1EaWxEYVzRaHPtqagRhBAj25So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618497; c=relaxed/simple;
	bh=MJpZTQzGpoT56odaKR7gLwW9Mb39tmJgeXmBqYhefKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SswmRcBU5onVmvJi/DPBBrrrpGE8uFp71ZkT7U5wpn1WT2aAVDHFqnm6QmGrmMNADKFkt6GkRJXpBFTbx360rWu2J66ljY2YrcKaJkVFHay4gxFXQ2hE6h65SdMQMxI0EHKNJm1KrBmts53mBVo1FOfVQ4D5E8B+YdGry/yUR2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=V4qtiawH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8BCA240E0177;
	Wed,  5 Jun 2024 20:14:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8zifVUZdnrvr; Wed,  5 Jun 2024 20:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717618488; bh=qZG3f/DmbJHa7xvgS2GeAG2D5DGmpu+ILLLLB6UEuR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4qtiawH2MYeOTIyka2HhiqpEQ+lB3CFYPtNRKcpHzU/RDvOw/XNmRxkzDndptqSV
	 Qs9mArBgjw/IFCrKmtUZyCCuX3UErjmfR8qMCaffGEHdYKDGd49sy5GgoCdonecEIZ
	 DuoejzzWW4AHjQaYPEPzWke4YeahLqyTcYz7VECSLJdSClODpi9Y7VI2hmzKVwkCKZ
	 i7SC42+21K5NfMJsEl6n/B+HgDzL0hH2WlZ7j8fsb92RdbhrAi5cSLBCHlKqEhMAC2
	 j0l4IxoxAigb9mrsc9AsdpEjALw8ENQKQPXUKXWeUOWNyG4qq/FCjMTFPS3gzp5hEq
	 Lz8nDpS6ADk6Bs/wjlTsc+uteKumWWaljQ1sDtFkRO8Jg0ZI8/srdNLxRybzCOzukz
	 Yri5q7Lc3oLN3yrAiQGA2lrsAJR+SRn0L2seHkhWSGzq1SA2xT+QO5Gt5r/mcSrWTN
	 D/dUp4Wtylc3+i6I3nISnzmKhX/IigvhLZ+mBW6lqFoTgTS7Agqif+JZ+dDVYxe0ET
	 RAv72qvNA1GkyrmYpdoEOQZjqU5dVj/JxMhYuWnDSBBQ8x9TpxilYemPu4v/r4ZXJw
	 wW1irkVmMk0XT4leNy7sAec1uJ5n2SKSA3vx0R939WXMoVh2skr6SlFG2MHnl/1+xP
	 Meqs6haSXEfuBHXivleOsbzU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 52C6440E016A;
	Wed,  5 Jun 2024 20:14:21 +0000 (UTC)
Date: Wed, 5 Jun 2024 22:14:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] x86/boot/compressed: Skip Video Memory access in
 Decompressor for SEV-ES/SNP.
Message-ID: <20240605201415.GZZmDHF9-lThZ6XQOz@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <75a313a44bfaf3f97027393665d625be2f881e66.1717111180.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75a313a44bfaf3f97027393665d625be2f881e66.1717111180.git.ashish.kalra@amd.com>

On Thu, May 30, 2024 at 11:37:14PM +0000, Ashish Kalra wrote:
> -	lines = boot_params_ptr->screen_info.orig_video_lines;
> -	cols = boot_params_ptr->screen_info.orig_video_cols;
> +	if (!(sev_status & MSR_AMD64_SEV_ES_ENABLED)) {
> +		lines = boot_params_ptr->screen_info.orig_video_lines;
> +		cols = boot_params_ptr->screen_info.orig_video_cols;
> +	}

By now I get an allergic reaction from this sprinkling of "if sev..."
everywhere in the code.

>  	init_default_io_ops();

<--- right here there's a call to

	early_tdx_detect();

You can add a early_sev_detect() counterpart here and clear lines and
cols in it along with an explanation why it is being done.

This is at least a bit cleaner than this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

