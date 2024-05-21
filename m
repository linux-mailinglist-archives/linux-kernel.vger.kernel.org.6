Return-Path: <linux-kernel+bounces-184916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F3B8CADC1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C73282EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A3577F08;
	Tue, 21 May 2024 11:57:26 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FFA7710F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292645; cv=none; b=nOUTpOwS2Aq16v394ydHVJVw+KRz8fxPOOFRVaiDrvFgoOi/nsNY08aZ45CcrcGhbyuyxaRGTJKWBeInoDKxMxgjE5KG3vNm+VZL1EvjUcWrOn893n5eywQSq9MIhJ/eFdlsuWmsC/MW+3XQQTOVk1lstLCkKHENlgXcGE89dfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292645; c=relaxed/simple;
	bh=bf3ANCvFz6G43u67m8NYWZRX5TZ8iz1p0YKTdXCKx5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af+DUW61UDKDyw0LlhOhkyoCIsAUOjN5On0Md/yYa3JyUEWcHk8ULcY3wIRpe4DMGEj2dNWuhEO6NvJC+UGoSmLdjagPCLrVCr6x/DjAHhSBqqpPp0u5n+UHLAiwzc5DhEQ/vrc47Q8D6GlU1xvUOF0h3PKFwVvV7uw/EQvHATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 64D505C0FA;
	Tue, 21 May 2024 11:57:22 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D202413A21;
	Tue, 21 May 2024 11:57:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2qi3MCGMTGZncgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 21 May 2024 11:57:21 +0000
Date: Tue, 21 May 2024 13:57:20 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v2 01/20] mm: Provide pagesize to pmd_populate()
Message-ID: <ZkyMIOs76sZI5GsV@localhost.localdomain>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <91159d49bcbee0526ca6235ff7ef1ee7d378d013.1715971869.git.christophe.leroy@csgroup.eu>
 <ZksRfAXja0fhNePD@localhost.localdomain>
 <dc66eff8-4371-4685-9dd8-3dacd3744e73@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc66eff8-4371-4685-9dd8-3dacd3744e73@csgroup.eu>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 64D505C0FA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

On Mon, May 20, 2024 at 04:24:51PM +0000, Christophe Leroy wrote:
> I had a quick look at that document and it seems to provide a good 
> summary of MMU features and principles. However there are some 
> theoritical information which is not fully right in practice. For 
> instance when they say "Segment attributes. These fields define 
> attributes common to all pages in this segment.". This is right in 
> theory if you consider it from Linux page table topology point of view, 
> hence what they call a segment is a PMD entry for Linux. However, in 
> practice each page has its own L1 and L2 attributes and there is not 
> requirement at HW level to have all L1 attributes of all pages of a 
> segment the same.

Thanks for taking the time Christophe, highly appreciated.

 
> rlwimi = Rotate Left Word Immediate then Mask Insert. Here it rotates 
> r10 by 23 bits to the left (or 9 to the right) then masks with 
> _PMD_PAGE_512K and inserts it into r11.
> 
> It means _PAGE_HUGE bit is copied into lower bit of PS attribute.
> 
> PS takes the following values:
> 
> PS = 00 ==> Small page (4k or 16k)
> PS = 01 ==> 512k page
> PS = 10 ==> Undefined
> PS = 11 ==> 8M page

I see, thanks for the explanation.

> That's a RFC, all ideas are welcome, I needed something to replace 
> hugepd_populate()

The only user interested in pmd_populate() having a sz parameter
is 8xx because it will toggle _PMD_PAGE_8M in case of a 8MB mapping.

Would it be possible for 8xx to encode the 'sz' in the *pmd pointer
prior to calling down the chain? (something like as we do for PTR_ERR()).
Then pmd_populate_{kernel_}size() from 8xx, would extract it like:

 unsigned long sz = PTR_SIZE(pmd)

Then we would not need all these 'sz' parameters scattered.

Can that work?


PD: Do you know a way to emulate a 8xx VM? qemu seems to not have
support support.

Thanks


-- 
Oscar Salvador
SUSE Labs

