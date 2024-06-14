Return-Path: <linux-kernel+bounces-214996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6835908D19
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78001C25C71
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0075C82;
	Fri, 14 Jun 2024 14:15:07 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E078F59
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374506; cv=none; b=Epfg7awkCNGexRybzS5kKgMl/sZGL9tnhh+dFMKShwkCSOLYOAfO/thiTakrM9EZR4esJ+iHQVs3OMf/Py6PuKEbLznnQsL/K9H6wsqZiLqEPjmPwX9s6Wd6H3AlXvZf/EUvPYmUtAt2qGmC0IwJ8vQe7TC+l08RZKsZVWCzyVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374506; c=relaxed/simple;
	bh=LwRD+raK9x1T5XyPzgTcT4RDvNuQlknMTk7JzpIBg74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dmpa82DHwBM7o14auTh0dxlRsjYcnhLAGxmajEDZVrW87f3UA9aWDtSQywPVResU851LF4b4cVJLRQkeq9V2hrfyCxxx972aZ4NlNpu7NLIyK96/XGf8rtwKCpndZFw0gdLAU9+1H9ZmurgE3FGR8/eDocExeyCqf0mhRSzO3aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5270720599;
	Fri, 14 Jun 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBC3213AAF;
	Fri, 14 Jun 2024 14:15:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7r8vL2ZQbGYhTAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 14 Jun 2024 14:15:02 +0000
Date: Fri, 14 Jun 2024 16:14:57 +0200
From: Oscar Salvador <osalvador@suse.de>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v5 02/18] mm: Define __pte_leaf_size() to also take a PMD
 entry
Message-ID: <ZmxQYTEOqtxuEthT@localhost.localdomain>
References: <cover.1717955558.git.christophe.leroy@csgroup.eu>
 <172b11c93e0de7a84937af2da9f80bd17c56b8c9.1717955558.git.christophe.leroy@csgroup.eu>
 <ZmgaHyS0izhtKbx6@localhost.localdomain>
 <ZmhcepJrkDpJ7mSC@x1n>
 <ZmhofWIiMC3I0aMF@localhost.localdomain>
 <ZmhrIdh3PLzvZU07@x1n>
 <Zmh282yJjxc7zqbL@localhost.localdomain>
 <e9583aa5-4ad7-4bcf-b3ff-f42b983231f5@cs-soprasteria.com>
 <Zmqdl1aqmU9BgYzo@localhost.localdomain>
 <0b52260d-28b2-4b33-b73e-88c5e5bfce66@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b52260d-28b2-4b33-b73e-88c5e5bfce66@cs-soprasteria.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5270720599
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Thu, Jun 13, 2024 at 04:43:57PM +0000, LEROY Christophe wrote:
> I can test whatever you want on my 8xx boards.
> 
> I have two types of board:
> - One with MPC866 microcontroller and 32Mbytes memory
> - One with MPC885 microcontroller and 128Mbytes memory

That is great.
I will code up some tests, and once you have the pmd_* stuff on 8xx we
can give it a shot.

Thanks!


-- 
Oscar Salvador
SUSE Labs

