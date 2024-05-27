Return-Path: <linux-kernel+bounces-190029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C68CF88F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B07280FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F8BD2E6;
	Mon, 27 May 2024 04:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TPmoAr1l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Scjl48Op";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TPmoAr1l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Scjl48Op"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6879F6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716785575; cv=none; b=TGnQzy4h58XzhVyFOf7pZKlGwS/zRLPA6s3zEg5zwFxwpBvmrXakAy1/loA0GELWV2esTejy2EYkLU2oyWCF0za33TJ+wayslmcdRwaBSrUDk99bSSkCCwVfqAr7AlGEtNkUnfm7Zph0KrfWxUwiyXAGzU6qMGL2Th7QceCnozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716785575; c=relaxed/simple;
	bh=trA99P4Lpp/M25QZgj3714Wgbnap79vY/GMoCj32Ml0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZE/yNicf70eFgOsTNsguzT2wlHnZvJ8PR3uUa/3BwHyrWqwUz5g95wO6PhD1gjXDppMOpOLx4Mdx0RH2H0HCZtqPi6AUrn44U5jPOYqmwPEF/fw0O2qO7M169xh2121bqQXos6I3FkFQPxKToIBWOBULOybwIqzDWVeDXs9XxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TPmoAr1l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Scjl48Op; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TPmoAr1l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Scjl48Op; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08E9221C1A;
	Mon, 27 May 2024 04:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716785572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q7vYNtWXHN0koVdw3jOnpPUhzKwJD0gqc9GMNDmYMko=;
	b=TPmoAr1lDAbCuGfjGQ25qRi+zi53ga379HbEw0aCCymei9yBEPcYHUdypqr8Ab/nvFbv7e
	ImZZowl2gG+o9RcUWIRHmMnfTzk3EowJlf97dYga/plmFw9q+06uhC3BG2mJ7mhnPXWXzx
	LC1tU38b/9UF7lqAoz/BIaW7Y2R4ksI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716785572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q7vYNtWXHN0koVdw3jOnpPUhzKwJD0gqc9GMNDmYMko=;
	b=Scjl48OpI2hWkaKl8/2sLYSiB1b27PD+WTh54BW9jwOAoBCou9NuPc4fyRzPe/wH0cW2sP
	Td7UF6+/HvUuPsAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716785572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q7vYNtWXHN0koVdw3jOnpPUhzKwJD0gqc9GMNDmYMko=;
	b=TPmoAr1lDAbCuGfjGQ25qRi+zi53ga379HbEw0aCCymei9yBEPcYHUdypqr8Ab/nvFbv7e
	ImZZowl2gG+o9RcUWIRHmMnfTzk3EowJlf97dYga/plmFw9q+06uhC3BG2mJ7mhnPXWXzx
	LC1tU38b/9UF7lqAoz/BIaW7Y2R4ksI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716785572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q7vYNtWXHN0koVdw3jOnpPUhzKwJD0gqc9GMNDmYMko=;
	b=Scjl48OpI2hWkaKl8/2sLYSiB1b27PD+WTh54BW9jwOAoBCou9NuPc4fyRzPe/wH0cW2sP
	Td7UF6+/HvUuPsAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71D9F13A6B;
	Mon, 27 May 2024 04:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OupCGaMRVGaZOQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 May 2024 04:52:51 +0000
Date: Mon, 27 May 2024 06:52:45 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 02/16] mm: Define __pte_leaf_size() to also take a
 PMD entry
Message-ID: <ZlQRnSAtxL7l-8Mx@localhost.localdomain>
References: <cover.1716714720.git.christophe.leroy@csgroup.eu>
 <cab4f087fa6f5933be4f5673d015da6887546ebd.1716714720.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cab4f087fa6f5933be4f5673d015da6887546ebd.1716714720.git.christophe.leroy@csgroup.eu>
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.976];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -8.30
X-Spam-Flag: NO

On Sun, May 26, 2024 at 11:22:22AM +0200, Christophe Leroy wrote:
> On powerpc 8xx, when a page is 8M size, the information is in the PMD
> entry. So allow architectures to provide __pte_leaf_size() instead of
> pte_leaf_size() and provide the PMD entry to that function.
> 
> When __pte_leaf_size() is not defined, define it as a pte_leaf_size()
> so that architectures not interested in the PMD arguments are not
> impacted.
> 
> Only define a default pte_leaf_size() when __pte_leaf_size() is not
> defined to make sure nobody adds new calls to pte_leaf_size() in the
> core.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

thanks, this looks much cleaner.

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

