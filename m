Return-Path: <linux-kernel+bounces-184022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5958CA17F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887E9281457
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4044137C43;
	Mon, 20 May 2024 17:42:31 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAEFA2D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226951; cv=none; b=twcQNwJJiZgRE1ttH3HCnxDke3Ev2liEzsMiq1xFYF271Cf036yaBJA7/+rm6LXD+7kKiA8fy42/QUcuvmG619+dq5bJZ0iDnyJkMKMHKPsI7DTvWHlLG5aZqqDW3xc2ZbnKiPhaxWDUFhNEduPRNzFNjVqpBpGvmlwdmh31ito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226951; c=relaxed/simple;
	bh=/mXDHW8VJpO6vlz6465Ksuoe/MWBFR43n1hirMX43fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zvplo0fo3djQrE1XqGACIdw8sFmpDNe0I9ow/EvZFKwGGx4JNs9OJ0reuSzFtln5HxC9ynjzNRVMhg1gaDN51RUT/jdNPcnWMwb3PMFDAFpfJec0g8iOWiQgZSxKu5dL4MSFXnF1lOa3ZEwrGqL2sdsBKy7YVhkleGljSzp1daU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2BE0E33DAC;
	Mon, 20 May 2024 17:42:28 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1DC513A6B;
	Mon, 20 May 2024 17:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3RedJIOLS2ZhUwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 20 May 2024 17:42:27 +0000
Date: Mon, 20 May 2024 19:42:26 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v2 06/20] powerpc/8xx: Fix size given to
 set_huge_pte_at()
Message-ID: <ZkuLgtujN1C2cpaH@localhost.localdomain>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <04f4e737608ea0b177b88057db138fbf0d6ab138.1715971869.git.christophe.leroy@csgroup.eu>
 <ZksUiwNaKx2n1fJO@localhost.localdomain>
 <f26807dd-bbd2-405d-9a88-c0654c525a5c@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f26807dd-bbd2-405d-9a88-c0654c525a5c@csgroup.eu>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 2BE0E33DAC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

On Mon, May 20, 2024 at 04:31:39PM +0000, Christophe Leroy wrote:
> Hi Oscar, hi Michael,
> 
> Le 20/05/2024 à 11:14, Oscar Salvador a écrit :
> > On Fri, May 17, 2024 at 09:00:00PM +0200, Christophe Leroy wrote:
> >> set_huge_pte_at() expects the real page size, not the psize which is
> > 
> > "expects the size of the huge page" sounds bettter?
> 
> Parameter 'pzize' already provides the size of the hugepage, but not in 
> the way set_huge_pte_at() expects it.
> 
> psize has one of the values defined by MMU_PAGE_XXX macros defined in 
> arch/powerpc/include/asm/mmu.h while set_huge_pte_at() expects the size 
> as a value.

Yes, psize is an index, which is not a size by itself but used to get
mmu_psize_def.shift to see the actual size, I guess.
This is why I thought that being explicit about "expects the size of the
huge page" was better.

But no strong feelings here.


-- 
Oscar Salvador
SUSE Labs

