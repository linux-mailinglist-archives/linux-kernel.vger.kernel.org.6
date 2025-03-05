Return-Path: <linux-kernel+bounces-546957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53650A50124
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC963ABC17
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C62248885;
	Wed,  5 Mar 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wW1CZrDr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="//hmQCzE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wW1CZrDr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="//hmQCzE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363DA241115
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182999; cv=none; b=p0FZLxKnSMBdAaDCgLNNdOFXQmin44c6Oi4MamsZiASYFZ0rzONyjRtbcY4AJ/KWFlo5eOEGrugzuqgKIeulWFrRI2W6aqsrsBMeHIS4ZISvrPLMmBFBPKdLgPGYsDf84AoGn3i2QzOVRq4RHIXuUL2KszZ0gU/4onhSDacZRP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182999; c=relaxed/simple;
	bh=x5GZvqEyjPxYci1yeQahkLFKC/PP49zU+3UqaaXbv4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJg7ppWDOejImvkWDA5o1bwaAzi2lQfBwkHD+4G5Tmpwp6oOVpJdBIlXuaR1/zI5boS41ldboosaqPfSLoEkcHyDu5NOszTD1siZoqb30Mbpo2xEmhH+8HRQmAfHfIzgVo0qK+ntF2hVmzIQqw6aiBDhRTwWq4OSTH+lZvtOehE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wW1CZrDr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=//hmQCzE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wW1CZrDr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=//hmQCzE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 355111F455;
	Wed,  5 Mar 2025 13:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741182996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NA7w+8HwVnxezc+u0WsqyH0kS9riFFet/vx3/FY0nT0=;
	b=wW1CZrDrodriR82dEGmN++82HBumdYQ95XCquivNR+BPrfUmfxHd6IEgL/uYuqZ78gl346
	Es+WfN/CTYcvnSmyjVS1dlfr8Fgagx3reG9KxjQtV6U1VgUPWPTjw3YZDKD5qQK2ZTwR4N
	sl+fygCzh45GBVu9bt7F8YcnL1sAvB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741182996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NA7w+8HwVnxezc+u0WsqyH0kS9riFFet/vx3/FY0nT0=;
	b=//hmQCzEF4CNOCAJHIO0/UDeF5SY3+SnpJQychqMnj+fjQKp5gwEkhiceJjtJmhroRLeqo
	OoiY9wZqXytxqSAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wW1CZrDr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="//hmQCzE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741182996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NA7w+8HwVnxezc+u0WsqyH0kS9riFFet/vx3/FY0nT0=;
	b=wW1CZrDrodriR82dEGmN++82HBumdYQ95XCquivNR+BPrfUmfxHd6IEgL/uYuqZ78gl346
	Es+WfN/CTYcvnSmyjVS1dlfr8Fgagx3reG9KxjQtV6U1VgUPWPTjw3YZDKD5qQK2ZTwR4N
	sl+fygCzh45GBVu9bt7F8YcnL1sAvB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741182996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NA7w+8HwVnxezc+u0WsqyH0kS9riFFet/vx3/FY0nT0=;
	b=//hmQCzEF4CNOCAJHIO0/UDeF5SY3+SnpJQychqMnj+fjQKp5gwEkhiceJjtJmhroRLeqo
	OoiY9wZqXytxqSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED5981366F;
	Wed,  5 Mar 2025 13:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NDy2OBNYyGfxRgAAD6G6ig
	(envelope-from <jroedel@suse.de>); Wed, 05 Mar 2025 13:56:35 +0000
Date: Wed, 5 Mar 2025 14:56:34 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z8hYEsHvwUwlOold@suse.de>
References: <20250305105234.235553-1-joro@8bytes.org>
 <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
X-Rspamd-Queue-Id: 355111F455
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,suse.com:url];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Mar 05, 2025 at 12:50:35PM +0100, Borislav Petkov wrote:
> On Wed, Mar 05, 2025 at 12:42:41PM +0100, Ingo Molnar wrote:
> > So if the convenience of tooling is the argument, the raw feature mask 
> > exposed is the best option overall.
> 
> The convenience of tooling *and* user. I want both. I want to be able to boot
> a guest and see what features are enabled without needing a tool.
> 
> And, at the same time, tools should be able to use the same interface.
> 
> Exactly like we *and glibc* use /proc/cpuinfo today. Now think the same thing
> but for confidential guests.

So this question boils down to whether the parsing of the bits happens
in kernel- or user-space. Actually there is already parsing in
kernel-space to print the status bits into the kernel log:

	SEV: Status: SEV SEV-ES SEV-SNP

... which is great for a quick glance without needing any tools. The
user-space tools which already exist have their own parsing of the bits
and for them it is much easier to consume the raw value of the
SEV_STATUS MSR. See my changes to snpguest:

	https://github.com/virtee/snpguest/pull/88/files

Btw, what is the equivalent on the Intel TDX side for these feature
bits?

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany
https://www.suse.com/

Geschäftsführer: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG Nürnberg)

