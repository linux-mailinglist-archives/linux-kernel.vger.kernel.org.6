Return-Path: <linux-kernel+bounces-270853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE2D944640
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9931C225A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF60208A4;
	Thu,  1 Aug 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VGEFkM00";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JEFVdWbh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VGEFkM00";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JEFVdWbh"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B50EEB3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500072; cv=none; b=KAN50MW+tVyFiHNcJmWSxmfF8WHBgajprar9Wx0g+YMOyEz7t+Ekd54yC3zFeYY6jDx9SOwFhjpbf8CvcC+ZeEqsOJUgz9HmR6o1067ZjaS8zLhce60b95DR8MjTsy8T5+5/8ddPpjMMnsOWzEV5QGraM07pFcL2Jci4xmX4Im4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500072; c=relaxed/simple;
	bh=KUx/21XfXl2HYHbhncoQsiOfvFh4RodlYK/bGzeYRec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkyMp9Myn7MfW+DwkxrLQUaRHvWhBfrouP0Xrmeq4U5fR4oAZ80Vz//OWbMyYYgASipShM9RbCN6hkwwdPRbQBQAqm9k4B+PXcr+/fZi8QOIOfNhjEFiuFA7MyfrFRItzBNOg9h6JDN/3t8l6pGcWvrGlbgNr3ihGYtYj9o/4Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VGEFkM00; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JEFVdWbh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VGEFkM00; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JEFVdWbh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A83621F7D2;
	Thu,  1 Aug 2024 08:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722500068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PuOBoMHoL0nRrZcOf7WZnQe1+A4etiuqLVtmsrs52QM=;
	b=VGEFkM00OOcW6hnc4rAVqYiQoqTBYSfxZrm/CZpWQdKdYRrdPM3b5tZh/XUgLV3kvnh5Is
	sh/QuiK+bBTuUUc6W9YxuSUVBci9QA8gR7astASsa0GneFhRwMeGJC3UbZI2N9kztk9Xl0
	qzQVoS0uf2db4i2rAmbimqoJEGoFohQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722500068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PuOBoMHoL0nRrZcOf7WZnQe1+A4etiuqLVtmsrs52QM=;
	b=JEFVdWbhK65eZXD5/PJHzXr1SOzlVQZYsLEtNq+x6ZbvHzI3d3mwA9MBp4bbGuvYNoNghl
	qEKzSmkGO27j/4CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VGEFkM00;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JEFVdWbh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722500068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PuOBoMHoL0nRrZcOf7WZnQe1+A4etiuqLVtmsrs52QM=;
	b=VGEFkM00OOcW6hnc4rAVqYiQoqTBYSfxZrm/CZpWQdKdYRrdPM3b5tZh/XUgLV3kvnh5Is
	sh/QuiK+bBTuUUc6W9YxuSUVBci9QA8gR7astASsa0GneFhRwMeGJC3UbZI2N9kztk9Xl0
	qzQVoS0uf2db4i2rAmbimqoJEGoFohQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722500068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PuOBoMHoL0nRrZcOf7WZnQe1+A4etiuqLVtmsrs52QM=;
	b=JEFVdWbhK65eZXD5/PJHzXr1SOzlVQZYsLEtNq+x6ZbvHzI3d3mwA9MBp4bbGuvYNoNghl
	qEKzSmkGO27j/4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C59013AEA;
	Thu,  1 Aug 2024 08:14:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zKNFAORDq2bzDgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 01 Aug 2024 08:14:28 +0000
Date: Thu, 1 Aug 2024 10:14:26 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 6/9] mm: Make hugetlb mappings go through
 mm_get_unmapped_area_vmflags
Message-ID: <ZqtD4idp0IyHgSp5@localhost.localdomain>
References: <20240729091018.2152-1-osalvador@suse.de>
 <20240729091018.2152-7-osalvador@suse.de>
 <8a57e184-4994-4642-959d-44dc7efbceca@lucifer.local>
 <ZqpTaKHdrYt61HYy@localhost.localdomain>
 <354e4db4-e257-48a4-9e05-7f0595728ec6@lucifer.local>
 <ZqpgdBk-3Bcl3Mvr@localhost.localdomain>
 <47de87e4-47df-4024-a313-03cc14b8e248@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47de87e4-47df-4024-a313-03cc14b8e248@lucifer.local>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A83621F7D2
X-Spam-Score: -4.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Wed, Jul 31, 2024 at 05:15:41PM +0100, Lorenzo Stoakes wrote:
> I've not got the vm debug on in my build, so it's blowing up here for me:
> 
> static unsigned long shm_get_unmapped_area(struct file *file,
> 	unsigned long addr, unsigned long len, unsigned long pgoff,
> 	unsigned long flags)
> {
> 	struct shm_file_data *sfd = shm_file_data(file);
> 
> 	return sfd->file->f_op->get_unmapped_area(sfd->file, addr, len,
> 						pgoff, flags);
> }
> 
> Notice that that doesn't check whether sfd->file->f_op->get_unmapped_area
> is NULL.

I see now, thanks.

> So since you remove this from the f_ops, it causes a NULL pointer deref.
...
> static const struct file_operations shm_file_operations = {
> ..
> 	.get_unmapped_area	= shm_get_unmapped_area,
> ...
> };
> 
> Then this get_area() is invoked, which calls shm_get_unmapped_area(), which
> calls f_op->get_unmapped_area() on your hugetlbfs_file_operations object
> which you just deleted and it's NULL.
> 
> This is why you have to be super careful here, there's clearly stuff out
> there that assumes that this can't happen, which you need to track down.
> 
> A quick grep however _suggests_ this might be the one landmine place. But
> you need to find a smart way to deal with this.

Probably, the most straightforward way to fix this is to instead of
setting .get_unmapped_area to NULL for hugetlbfs_file_operations, would
be to have it re-defined like:

 .get_unmapped_area = mm_get_unmapped_area_vmflags

Which is what we call after this patchset.
So no more things have to tweaked.

On a more correct way, __maybe__ have something like:


 diff --git a/ipc/shm.c b/ipc/shm.c
 index 3e3071252dac..222dca8a3716 100644
 --- a/ipc/shm.c
 +++ b/ipc/shm.c
 @@ -648,8 +648,11 @@ static unsigned long shm_get_unmapped_area(struct file *file,
  {
  	struct shm_file_data *sfd = shm_file_data(file);
  
 -	return sfd->file->f_op->get_unmapped_area(sfd->file, addr, len,
 +	if (sfd->file->f_op->get_unmapped_area)
 +		return sfd->file->f_op->get_unmapped_area(sfd->file, addr, len,
  						pgoff, flags);
 +
 +	return mm_get_unmapped_area_vmflags(sfd->file, addr, len, pgoff, flags);
  }
  
  static const struct file_operations shm_file_operations = {

 
Still unsure about which approach looks more correct though.

-- 
Oscar Salvador
SUSE Labs

