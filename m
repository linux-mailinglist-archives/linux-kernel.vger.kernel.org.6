Return-Path: <linux-kernel+bounces-185384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7833C8CB445
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB1E2851A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEBC148FF9;
	Tue, 21 May 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Qa0PguJH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dfy7rXAx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA0D1DFE8;
	Tue, 21 May 2024 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716319920; cv=none; b=KjHGywe+whT5XXi+wkQsLumt7dtmHe+pRUwNB1534XPLonS/z3ejkO/x3X0HdDMjmGI0vYt4qQ3tofaQliEbtXJeu4SMlYga+8LA42+wOTuCIn3Q9SpYJleLEqKUTab+DdqidJUeIbqLWdov7++x5aCrNANJVlTCc+PyKxO8GMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716319920; c=relaxed/simple;
	bh=oDQXQs3+I0KevbjnesJf0FJvciTtn0Zm0YVg/mU5+44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzOMXAGgkp/eDXHNJ4SChJmFEsKVkFCL9dpNjfrZitjox1p+Fa2dwzRnNO8X/HnUYOTJ8vmiX7dCM/Ss1L4RHGSst9C7l/ClbCvwm9XUf7KDwHZTceVFMoMzqTTl02w+K1X5X3qQhtZw+aUHyUKAwzTk4FU+tjlJh68KHfI6OP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Qa0PguJH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dfy7rXAx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D79CA34926;
	Tue, 21 May 2024 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716319915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jqv5tIf2GMmwwVp9SIK+mTMvcMTD2xp5tSh2Rv/alOk=;
	b=Qa0PguJHLId2cDcjdwweNHy70PGIXIoEPLZBbxycw2YbCCH8COgJDknk8BVtp5qgF/cuiD
	gj5192Ta0rYQgnUaWzMK6hkzb4MgdZOEjz+RsmH3ERIUoZXGqS0iH8ywFj60NORfjGaIv8
	7LNvBUirJiLl2Qnkc1jj88mEpdo+rjo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dfy7rXAx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716319914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jqv5tIf2GMmwwVp9SIK+mTMvcMTD2xp5tSh2Rv/alOk=;
	b=dfy7rXAxw1PhGzKeIfUAm/jKom23MoWvbtWSmH6RFDRlsbbJkVtgJbZxZeWEJM7WtE/Ifx
	WVjfcMTEJkmujyPaU/HEm3wzlKopMrlxitnLP1rP1xdpg0mefaEv6ANYy0hztKOZWov6p6
	Rtocwsl0IsZ/DtcarWs/4m2M0p0Tte8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBBD813685;
	Tue, 21 May 2024 19:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kUDPKqr2TGaFaAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 21 May 2024 19:31:54 +0000
Date: Tue, 21 May 2024 21:31:54 +0200
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: CVE-2024-26650: platform/x86: p2sb: Allow p2sb_bar() calls
 during PCI device probe
Message-ID: <Zkz2qpUP-HVROO1I@tiehlicka>
References: <20240326175007.1388794-18-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326175007.1388794-18-lee@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D79CA34926
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.01

This patch has been reverted in upstream by 03c6284df179 ("Revert
"drm/amd/amdgpu: Fix potential ioremap() memory leaks in
amdgpu_device_init()"") and based on the changelog the CVE should be
rejected.

On Tue 26-03-24 17:50:16, Lee Jones wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe
> 
> p2sb_bar() unhides P2SB device to get resources from the device. It
> guards the operation by locking pci_rescan_remove_lock so that parallel
> rescans do not find the P2SB device. However, this lock causes deadlock
> when PCI bus rescan is triggered by /sys/bus/pci/rescan. The rescan
> locks pci_rescan_remove_lock and probes PCI devices. When PCI devices
> call p2sb_bar() during probe, it locks pci_rescan_remove_lock again.
> Hence the deadlock.
> 
> To avoid the deadlock, do not lock pci_rescan_remove_lock in p2sb_bar().
> Instead, do the lock at fs_initcall. Introduce p2sb_cache_resources()
> for fs_initcall which gets and caches the P2SB resources. At p2sb_bar(),
> refer the cache and return to the caller.
> 
> Before operating the device at P2SB DEVFN for resource cache, check
> that its device class is PCI_CLASS_MEMORY_OTHER 0x0580 that PCH
> specifications define. This avoids unexpected operation to other devices
> at the same DEVFN.
> 
> Tested-by Klara Modin <klarasmodin@gmail.com>
> 
> The Linux kernel CVE team has assigned CVE-2024-26650 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 6.0 with commit 9745fb07474f and fixed in 6.1.76 with commit 2841631a0365
> 	Issue introduced in 6.0 with commit 9745fb07474f and fixed in 6.6.15 with commit 847e1eb30e26
> 	Issue introduced in 6.0 with commit 9745fb07474f and fixed in 6.7.3 with commit d281ac9a987c
> 	Issue introduced in 6.0 with commit 9745fb07474f and fixed in 6.8 with commit 5913320eb0b3
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-26650
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	drivers/platform/x86/p2sb.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/2841631a03652f32b595c563695d0461072e0de4
> 	https://git.kernel.org/stable/c/847e1eb30e269a094da046c08273abe3f3361cf2
> 	https://git.kernel.org/stable/c/d281ac9a987c553d93211b90fd4fe97d8eca32cd
> 	https://git.kernel.org/stable/c/5913320eb0b3ec88158cfcb0fa5e996bf4ef681b

-- 
Michal Hocko
SUSE Labs

