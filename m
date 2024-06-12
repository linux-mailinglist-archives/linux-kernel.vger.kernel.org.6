Return-Path: <linux-kernel+bounces-212221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FC1905CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADEAA1F25213
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B0F84A51;
	Wed, 12 Jun 2024 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HwgdMkpr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r+CigeT+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HwgdMkpr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r+CigeT+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75F84A56
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718224026; cv=none; b=AC2wYnT5/1g4EZE0EHf7MgaYTCJpUuXapcMCrWTE4XHpn/vPWhZAm12wDfzx+m9bbXOFXHqdMI4M7CnYXs/vlZmMwWDjFqNixQT78EwFQju9FfhF8gRen67hLajNptvcss7WhbcdGkpkN70b6ywpA9MDroe+xirh9vRlwB+y8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718224026; c=relaxed/simple;
	bh=D9xEEAQmTsgEo9UDUmSclz/a0tD4gHdbLxDsMPCyR4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jda25kE8F7Vqjp43mEdRD/CuoEiFurWZ4nAJ2mfjcuZtG7d//k/tL1azQYY+/jGzJansgjtcMqh+3sIkKaC4c2FbRpElq+hP+Pw2qbgvPw6gGkT4rUZgrmDNtxkklCoxv6E6gUU86D4857fEb8jPks81I+acoGzCLXzm/EKxexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HwgdMkpr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r+CigeT+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HwgdMkpr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r+CigeT+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FB255C700;
	Wed, 12 Jun 2024 20:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718224022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1VFuCUnuEepepF/nbFXGdMItjf3Q4jDShXXipYKEUy8=;
	b=HwgdMkprsrWlowzdN0AurD8/qlL6BHBjM6iGkmzEsFQj49bK4dWsgjwEQhzNU8IjlliE2P
	q8Rj948CkYMq6aAJEv9T7SQdsJ7kZMcySRHaWDAyoY/4FG0eNN5Yy9CjqLmw8RV01AeIgi
	jCGk7koUgSzmqlnbp255TDiGsLoh2TY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718224022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1VFuCUnuEepepF/nbFXGdMItjf3Q4jDShXXipYKEUy8=;
	b=r+CigeT+ebgc3nxPN7HvLvku6DTB0GTcJ722AIQzu2pPI/HhvI7fPocDaWO2+mvfHPDoDO
	RJ7SUIc0ePmkmVCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HwgdMkpr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=r+CigeT+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718224022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1VFuCUnuEepepF/nbFXGdMItjf3Q4jDShXXipYKEUy8=;
	b=HwgdMkprsrWlowzdN0AurD8/qlL6BHBjM6iGkmzEsFQj49bK4dWsgjwEQhzNU8IjlliE2P
	q8Rj948CkYMq6aAJEv9T7SQdsJ7kZMcySRHaWDAyoY/4FG0eNN5Yy9CjqLmw8RV01AeIgi
	jCGk7koUgSzmqlnbp255TDiGsLoh2TY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718224022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1VFuCUnuEepepF/nbFXGdMItjf3Q4jDShXXipYKEUy8=;
	b=r+CigeT+ebgc3nxPN7HvLvku6DTB0GTcJ722AIQzu2pPI/HhvI7fPocDaWO2+mvfHPDoDO
	RJ7SUIc0ePmkmVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47F9C1372E;
	Wed, 12 Jun 2024 20:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IbqSDpYEambxKgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 12 Jun 2024 20:27:02 +0000
Date: Wed, 12 Jun 2024 22:27:00 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Vishal Moola <vishal.moola@gmail.com>
Subject: Re: [PATCH] mm/hugetlb: Move vmf_anon_prepare upfront in hugetlb_wp
Message-ID: <ZmoElLHB4BAOXD7c@localhost.localdomain>
References: <20240521073446.23185-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521073446.23185-1-osalvador@suse.de>
X-Rspamd-Queue-Id: 9FB255C700
X-Spam-Score: -5.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux.dev,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, May 21, 2024 at 09:34:46AM +0200, Oscar Salvador wrote:
> hugetlb_wp calls vmf_anon_prepare() after having allocated a page, which
> means that we might need to call restore_reserve_on_error() upon error.
> vmf_anon_prepare() releases the vma lock before returning, but
> restore_reserve_on_error() expects the vma lock to be held by the caller.
> 
> Fix it by calling vmf_anon_prepare() before allocating the page.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Fixes: 9acad7ba3e25 ("hugetlb: use vmf_anon_prepare() instead of anon_vma_prepare()")

Let me just revamp this and run away
 

-- 
Oscar Salvador
SUSE Labs

