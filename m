Return-Path: <linux-kernel+bounces-190268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439FE8CFC3A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03AC1F22BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9D26A008;
	Mon, 27 May 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mW+A8a81";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AovZ2QB2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mW+A8a81";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AovZ2QB2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3301028684
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800041; cv=none; b=eTguDRi38SD017I6jybTxg/gUl4zGTFmVykHAPS3dV8pN7Z99fuZLSbcxeIpHr8CPdyi/EWSChW6BVCX/IZ/AcTs/DwpfhVcFB0V4czCcaUDpVWGgOe+zZuzLCoGEz/zUC7cFQdpiMVodjgb4PTT/2XdoTtl9ktcJbsMb+0m1NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800041; c=relaxed/simple;
	bh=/PCwCOQJpwGYnX/sOpLT7J90NpmZjtGgeaPN06REkN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3GYabu0oZ9qfjHL3k0THo6fO6Wbdra/yDUyls8cnDSuNBs/H0GaDKMJEPwd39wWH6/OtGkXDbUljVeyjjwSmktnTC0FO7uBI465rQPCpmz9wcxxcc9EvpWzl71hHoSxtc064jf+zQdlQTvP53GaG0fnyi58AGLDQkuDFaEHMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mW+A8a81; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AovZ2QB2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mW+A8a81; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AovZ2QB2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 459BB21D66;
	Mon, 27 May 2024 08:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716800037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rVC/dDk5c+fIGn0MOwcknof/hJlc/Q9eHr02ULk1Nx8=;
	b=mW+A8a81nA/4/BMW6BWQa/mUk3SVkQXftMlE+3NsmhGRELQznuJOH7vKTSedt+Ct0GinS2
	7ih0mgJotbupc43DGY7vPEychw6+XfNL1A5RQB/DTziSjp9qibMX6vhmbXKTmfPTx4UJRR
	CBilRCx95VMDGZfcWO1gtEtw+Z5dxFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716800037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rVC/dDk5c+fIGn0MOwcknof/hJlc/Q9eHr02ULk1Nx8=;
	b=AovZ2QB2O2C4eZQV4G7q3edNeGnxBtm5G0BycbrLiAfdBqMgtBaIdPLKnI7qxbK6fRxhW/
	GNr/X3cQD8n5kcAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716800037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rVC/dDk5c+fIGn0MOwcknof/hJlc/Q9eHr02ULk1Nx8=;
	b=mW+A8a81nA/4/BMW6BWQa/mUk3SVkQXftMlE+3NsmhGRELQznuJOH7vKTSedt+Ct0GinS2
	7ih0mgJotbupc43DGY7vPEychw6+XfNL1A5RQB/DTziSjp9qibMX6vhmbXKTmfPTx4UJRR
	CBilRCx95VMDGZfcWO1gtEtw+Z5dxFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716800037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rVC/dDk5c+fIGn0MOwcknof/hJlc/Q9eHr02ULk1Nx8=;
	b=AovZ2QB2O2C4eZQV4G7q3edNeGnxBtm5G0BycbrLiAfdBqMgtBaIdPLKnI7qxbK6fRxhW/
	GNr/X3cQD8n5kcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E861813A6B;
	Mon, 27 May 2024 08:53:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A/MfNiRKVGZaWAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 May 2024 08:53:56 +0000
Date: Mon, 27 May 2024 10:53:55 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Vishal Moola <vishal.moola@gmail.com>
Subject: Re: [PATCH] mm/hugetlb: Move vmf_anon_prepare upfront in hugetlb_wp
Message-ID: <ZlRKI_tJ2CYhmekw@localhost.localdomain>
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux.dev,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5]

On Tue, May 21, 2024 at 09:34:46AM +0200, Oscar Salvador wrote:
> I did not hit this bug, I just spotted this because I was looking at hugetlb_wp
> for some other reason. And I did not want to get creative to see if I could
> trigger this so I could get a backtrace.
> My assumption is that we could trigger this if 1) this was a shared mapping,
> so no anon_vma and 2) we call in GUP code with FOLL_WRITE, which would cause
> the FLAG_UNSHARE to be passed, so we will end up in hugetlb_wp().

So I checked this again and I have to confess I am bit confused.

hugetlb_wp() can be called from either hugetlb_fault() or hugetlb_no_page().

hugetlb_fault()->hugetlb_wp() upon FAULT_FLAG_{WRITE,UNSHARE}
hugetlb_no_page->hugetlb_wp()-> upon FAULT_FLAG_WRITE && !VM_SHARED

hugetlb_no_page()->vmf_anon_prepare() upon !VM_SHARED, which means that VM_SHARED
mappings do not have vma->anon_vma, while others do.

hugetlb_wp() will call set_huge_ptep_writable() right away and return if it sees
that the mapping is shared.
So the only other we have to end up in hugetlb_wp() is via FAULT_FLAG_UNSHARE.
For that to happen gup_must_unshare() must return true, which means the following
assumptions must hold.

- For Anonymous pages:
  1) !PageAnonExclusive
- For Filebacked pages:
  2) We do not have a vma
  3) It is a COW mapping

1) If gup_must_unshare() returns true for Anonymous pages because the page is not
   exclusive and must be unshared, hugetlb_wp() will already see the
   vma->anon_prepare being initialized because of the previous
   hugetlb_no_page()->vmf_anon_prepare.

2) I do not quite understand this case.
3) !VMSHARED mappings already had its anon_vma initialized in
   hugetlb_no_page()->vmf_anon_prepare.

Probably I am missing some bits here, but I cannot see how we would even
need vmf_anon_prepare() in hugetlb_wp() in the first place.


-- 
Oscar Salvador
SUSE Labs

