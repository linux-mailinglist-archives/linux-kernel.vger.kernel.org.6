Return-Path: <linux-kernel+bounces-388551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CAB9B611C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A4A1C21477
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E561E3DC3;
	Wed, 30 Oct 2024 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gNhqy1wt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hk16dhIv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gNhqy1wt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hk16dhIv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83D1E285C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286588; cv=none; b=nzcx2pjNIam/fLF2OMq/dUztlDt+e/AMZwJjW888lu/EAIaw4t3sg3+k/y+2I3ycdjsrvG4WI0QRSZog5iGEAf7ksQJC9LfonOsISqy+W0b+V9rhG4TibwjRZUC2Brd9QTShPqDQzJs5pTnT5zo7/+RHvC/+rfiJgsZIVdQjosI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286588; c=relaxed/simple;
	bh=jX9/dSjw7dh6qClNqXHIGUwPuNuHwnweWINT7hIBcmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSVXhSymfGBp/LpnC7xdOoR4eoh+3IgLsz4DhC9+3jDg6MgYf7Pb9qEs3wXVnZFWilnED8D9tCIjAUwl9YMWGw5Tbpq1fIwAT246ywYBp/+W72HoM5CDwr1WR3BugAhuOGJ0oYU17EPR1xcgmkkNUKtbRM+KmElLvC6aEm/u7XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gNhqy1wt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hk16dhIv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gNhqy1wt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hk16dhIv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98BA51FB76;
	Wed, 30 Oct 2024 11:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730286584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UFyl1rCiVaml9UeEf1yOgzYMHqGLHV+uUJDew5nuIIY=;
	b=gNhqy1wtOZoHjxLHDFGoc0I3f1slCL5rpKjCCrq9rk8w5Oh115f05Lo+DMBwDmnK3bbpdR
	q5GQU09XE3bohHFXGP6hU9IMRyOxk9JBcFNeyeas7MaztN5yO5obKyOlXC5IK9X3UREsxe
	l4O5qbx9XTb4RrdoXPqvsqOKkeMpbLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730286584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UFyl1rCiVaml9UeEf1yOgzYMHqGLHV+uUJDew5nuIIY=;
	b=Hk16dhIvGF3X79xamfuYxQj/jQH/u/YTKynisbTQBJQzl8zy7lxHZITacb5MzCLm+u42RZ
	2Co+WXc5ozchj6CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730286584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UFyl1rCiVaml9UeEf1yOgzYMHqGLHV+uUJDew5nuIIY=;
	b=gNhqy1wtOZoHjxLHDFGoc0I3f1slCL5rpKjCCrq9rk8w5Oh115f05Lo+DMBwDmnK3bbpdR
	q5GQU09XE3bohHFXGP6hU9IMRyOxk9JBcFNeyeas7MaztN5yO5obKyOlXC5IK9X3UREsxe
	l4O5qbx9XTb4RrdoXPqvsqOKkeMpbLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730286584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UFyl1rCiVaml9UeEf1yOgzYMHqGLHV+uUJDew5nuIIY=;
	b=Hk16dhIvGF3X79xamfuYxQj/jQH/u/YTKynisbTQBJQzl8zy7lxHZITacb5MzCLm+u42RZ
	2Co+WXc5ozchj6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40637136A5;
	Wed, 30 Oct 2024 11:09:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DU7qDvgTImcURAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 30 Oct 2024 11:09:44 +0000
Message-ID: <c8760d0e-acbd-4fd6-b077-58b5c374cad3@suse.cz>
Date: Wed, 30 Oct 2024 12:09:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.12 v4 4/5] mm: refactor arch_calc_vm_flag_bits()
 and arm64 MTE handling
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu
 <peterx@redhat.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Yang Shi <yang@os.amperecomputing.com>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
 <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
 <f5495714-19ba-40b8-a3ac-fe395c075a36@suse.cz> <ZyIRbbA-_8duD2hH@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <ZyIRbbA-_8duD2hH@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,google.com,vger.kernel.org,kvack.org,redhat.com,kernel.org,davemloft.net,gaisler.com,hansenpartnership.com,gmx.de,os.amperecomputing.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/30/24 11:58, Catalin Marinas wrote:
> On Wed, Oct 30, 2024 at 10:18:27AM +0100, Vlastimil Babka wrote:
>> On 10/29/24 19:11, Lorenzo Stoakes wrote:
>> > --- a/arch/arm64/include/asm/mman.h
>> > +++ b/arch/arm64/include/asm/mman.h
>> > @@ -6,6 +6,8 @@
>> > 
>> >  #ifndef BUILD_VDSO
>> >  #include <linux/compiler.h>
>> > +#include <linux/fs.h>
>> > +#include <linux/shmem_fs.h>
>> >  #include <linux/types.h>
>> > 
>> >  static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>> > @@ -31,19 +33,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>> >  }
>> >  #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
>> > 
>> > -static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
>> > +static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
>> > +						   unsigned long flags)
>> >  {
>> >  	/*
>> >  	 * Only allow MTE on anonymous mappings as these are guaranteed to be
>> >  	 * backed by tags-capable memory. The vm_flags may be overridden by a
>> >  	 * filesystem supporting MTE (RAM-based).
>> 
>> We should also eventually remove the last sentence or even replace it with
>> its negation, or somebody might try reintroducing the pattern that won't
>> work anymore (wasn't there such a hugetlbfs thing in -next?).
> 
> I agree, we should update this comment as well though as a fix this
> patch is fine for now.
> 
> There is indeed a hugetlbfs change in -next adding VM_MTE_ALLOWED. It
> should still work after the above change but we'd need to move it over

I guess it will work after the above change, but not after 5/5?

> here (and fix the comment at the same time). We'll probably do it around
> -rc1 or maybe earlier once this fix hits mainline.

I assume this will hopefully go to rc7.

> I don't think we have
> an equivalent of shmem_file() for hugetlbfs, we'll need to figure
> something out.

I've found is_file_hugepages(), could work? And while adding the hugetlbfs
change here, the comment could be adjusted too, right?

> 
>> >  	 */
>> > -	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
>> > +	if (system_supports_mte() &&
>> > +	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
>> >  		return VM_MTE_ALLOWED;
>> > 
>> >  	return 0;
>> >  }
> 
> This will conflict with the arm64 for-next/core tree as it's adding
> a MAP_HUGETLB check. Trivial resolution though, Stephen will handle it.
> 


