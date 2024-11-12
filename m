Return-Path: <linux-kernel+bounces-405747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1C19C5689
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0FD2817B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61291CD1E2;
	Tue, 12 Nov 2024 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jadU7NWf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7XWNgOmN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jadU7NWf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7XWNgOmN"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBBC1A76CC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410652; cv=none; b=If7W7KdZFI54xnN4QREUeewgR/moLcai7YNx4jjoLcMUtCYRkVaWgNe/aGdNS/NEUv34UroUEYi83f6Xds6b4nBeD6y/FNKjKgMOOXFXTO7xvjsQORQy6vhOyXXNE34bskbaBdc3SoiFVEL4GmzEKnN1Xj1bnJRDK2W1PpT4gUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410652; c=relaxed/simple;
	bh=t2eq7MJmUxxX2LGGqh6cMABuGApVPpbrzKUP1iwKu+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6HC3uyAsznddjKq6M3+4ZpMfWIcIP/Z1/MYqx2S+KaPBtcsYFs+ddnSCWlLK5ZZYvT1AX1G3UdeJNYTyfq2axQS9hf0KBJnxRKYCK8tAuSl6XQ5X6Se0SzYYx4iR1NCLjW0KcD58FRohbl58RjsT2RvyB4wItIXqJlnbN1Z6VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jadU7NWf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7XWNgOmN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jadU7NWf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7XWNgOmN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E25E1F451;
	Tue, 12 Nov 2024 11:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731410646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M3maZGpP1+h3ml9nQ674zOyaaMAhmGct+5CBHPa7DBw=;
	b=jadU7NWf04aiYHrSUFQCiIVaSkS/DppnyXZkMEJ/h8xkUS0F1A7tOuc0rGPYJhH8GZIi7a
	Mrxk5vk7QYroh53eKPj9YTsY5HT15x+IKgTdx/gQs105Ddzu1S5Zh/SuRPUkXn1zxMOscq
	OanHqYZwvpgFIYqUgjZ86I9LWgvUSUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731410646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M3maZGpP1+h3ml9nQ674zOyaaMAhmGct+5CBHPa7DBw=;
	b=7XWNgOmNdYOzxSXGHTkMBOtcSGOjGrSHK66I6iie3g7WMlvrk7MkjWche24fZQa7x5YoKx
	MJhfxw+cPlC/I8Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731410646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M3maZGpP1+h3ml9nQ674zOyaaMAhmGct+5CBHPa7DBw=;
	b=jadU7NWf04aiYHrSUFQCiIVaSkS/DppnyXZkMEJ/h8xkUS0F1A7tOuc0rGPYJhH8GZIi7a
	Mrxk5vk7QYroh53eKPj9YTsY5HT15x+IKgTdx/gQs105Ddzu1S5Zh/SuRPUkXn1zxMOscq
	OanHqYZwvpgFIYqUgjZ86I9LWgvUSUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731410646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M3maZGpP1+h3ml9nQ674zOyaaMAhmGct+5CBHPa7DBw=;
	b=7XWNgOmNdYOzxSXGHTkMBOtcSGOjGrSHK66I6iie3g7WMlvrk7MkjWche24fZQa7x5YoKx
	MJhfxw+cPlC/I8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA90213721;
	Tue, 12 Nov 2024 11:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i4z6NdU6M2cfQwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 12 Nov 2024 11:24:05 +0000
Date: Tue, 12 Nov 2024 12:24:00 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: riel@surriel.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	muchun.song@linux.dev, mike.kravetz@oracle.com, leit@meta.com,
	willy@infradead.org, stable@kernel.org,
	Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH 2/4] hugetlbfs: extend hugetlb_vma_lock to private VMAs
Message-ID: <ZzM60CLkWKwFzWqa@localhost.localdomain>
References: <20231006040020.3677377-1-riel@surriel.com>
 <20231006040020.3677377-3-riel@surriel.com>
 <Zy0gqwIw5Y3IuNTD@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy0gqwIw5Y3IuNTD@x1n>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Nov 07, 2024 at 03:18:51PM -0500, Peter Xu wrote:
> +Ackerley +Oscar
> 
> I'm reading the resv code recently and just stumbled upon this. So want to
> raise this question.
> 
> IIUC __vma_private_lock() will return false for MAP_PRIVATE hugetlb vma if
> the vma is dup()ed from a fork(), with/without commit 187da0f8250a
> ("hugetlb: fix null-ptr-deref in hugetlb_vma_lock_write") which fixed a
> slightly different issue.
> 
> The problem is the current vma lock for private mmap() is based on the resv
> map, and the resv map only belongs to the process that mmap()ed this
> private vma.  E.g. dup_mmap() has:
> 
>                 if (is_vm_hugetlb_page(tmp))
>                         hugetlb_dup_vma_private(tmp);
> 
> Which does:
> 
> 	if (vma->vm_flags & VM_MAYSHARE) {
>                 ...
> 	} else
> 		vma->vm_private_data = NULL; <---------------------
> 
> So even if I don't know how many of us are even using hugetlb PRIVATE +
> fork(), assuming that's the most controversial use case that I'm aware of
> on hugetlb that people complains about.. with some tricky changes like
> 04f2cbe35699.. Just still want to raise this pure question, that after a
> fork() on private vma, and if I read it alright, lock/unlock operations may
> become noop..

I have been taking a look at this, and yes, __vma_private_lock will
return false for private hugetlb mappings that were forked .

I quickly checked what protects what and we currently have:

hugetlb_vma_lock_read - copy_hugetlb_page_range (only sharing)
hugetlb_vma_lock_read - hugetlb_wp (only for HPAGE_RESV_OWNER)
hugetlb_vma_lock_read - hugetlb_fault , protects huge_pmd_unshare?
hugetlb_vma_lock_read - pagewalks

hugetlb_vma_lock_write - hugetlb_change_protection
hugetlb_vma_lock_write - hugetlb_unshare_pmds
hugetlb_vma_lock_wirte - move_hugetlb_page_tables
hugetlb_vma_lock_wirte - _hugetlb_zap_begin (unmap_vmas)

the ones taking the hugetlb_vma_lock in write (so, the last four) also
take the i_mmap_lock_write (vma->vm_file->f_mapping), and AFAIK, hugetlb
mappings, private or not, should have vma->vm_file->f_mapping set.

Which means that technically we cannot race between hugetlb_change_protection
and move_hugetlb_page_tables etc.

But, checking 

 commit bf4916922c60f43efaa329744b3eef539aa6a2b2
 Author: Rik van Riel <riel@surriel.com>
 Date:   Thu Oct 5 23:59:07 2023 -0400
 
     hugetlbfs: extend hugetlb_vma_lock to private VMAs

which its motivation was to protect MADV_DONTNEED vs page_faults, I do
not see how it gets protected with private hugetlb mappings that were
dupped (forked).

 madvise_dontneed_single_vma
  zap_page_range_single
   _hugetlb_zap_begin
    hugetlb_vma_lock_write - noop for mappings that do not own the reservation
    i_mmap_lock_write

But the hugetlb_fault path only takes hugetlb_vma_lock_*, so theorically
we still could race between page_fault vs madvise_dontneed_single_vma?

A quick way to prove would be map a hugetlb private mapping, fork it and
have two threads tryong to madvise(MADV_DONTNEED) and the other trying
to write to it?

I do not know, maybe we are protected in some other way I cannot see
right now.

I will have a look.

 

-- 
Oscar Salvador
SUSE Labs

