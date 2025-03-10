Return-Path: <linux-kernel+bounces-554525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE84A59944
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC6E16E6E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA6F22D7AF;
	Mon, 10 Mar 2025 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nNv/ixMA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="If69XtfG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IZlzDh+5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ClK6Yobt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE3D22B584
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619523; cv=none; b=O8hTC7KIbuqC/W5uoM9kaY+5BxJ/cDfL/WtxZ8vUg7eJ0oPJq3Rj/WjOXCW+CSEaU31PTDMMcviOvYO83w45uq0NRmbYMx8/AG/uTyiLvytfsqkRGWlrqRvR2HZyR4SUFfXZB298eldsviqAa99qHvUEvoixLkB2U2yeY9Q5eWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619523; c=relaxed/simple;
	bh=9Mlz++vw/dnnUYgVg1BWC8kIgqJ2SUdgg1lOkajDUCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RR6QSYCc2TEr8D3ME1FeRWJUM7LLEIwQAntIMGubZzIn6svG+F+gGG5RrZ8vvlWY64S7/jgz8tDbF17sc014iHEavbgFFCh6XrbzrrKu89X4yem+GAtYQLHJxl34Fmznts+bMSOAXEeQ01tlt7CzQ+ASfgw5pgTiyOu5cq9fc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nNv/ixMA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=If69XtfG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IZlzDh+5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ClK6Yobt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFF121F441;
	Mon, 10 Mar 2025 15:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741619520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tyvzamKgKRqyxRt5U6QPdn/vabNysXQhbfHATPS8cPY=;
	b=nNv/ixMAXtw5zZW7wRyqkTqnDHPVmvTQjluHZ8Eoy+3pRHn5TNaDnfOeMk9VNsSPphNdWw
	eC7zZs1ywRDGnSRK287KnLyIx+zICE5Q3a8tTQAk5kMrKnE1o812j1yiV1/fnZpnLZyBjt
	bGKCxg08/04Iuv7l4psCvSv1zjUsArs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741619520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tyvzamKgKRqyxRt5U6QPdn/vabNysXQhbfHATPS8cPY=;
	b=If69XtfGXGpne+R5FJTRZgorUjnuVxrjeL8LxRyZ7K4WYsjkD59rPQ1ytu7NJdTVDUJQTo
	72FjJwb026eIbSBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IZlzDh+5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ClK6Yobt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741619519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tyvzamKgKRqyxRt5U6QPdn/vabNysXQhbfHATPS8cPY=;
	b=IZlzDh+53qGN29M9vgdmB0y6ZGROZu6ynz+smH3ytfkgh/jJVrcTdy8H185u4lQ3pWfeKL
	+4iU/W/AWiL6ElP75/p16aqXjZLTEl+xcUQDFeKcIyIEQhhMj9k88s6TI0OubSx/uB+HBS
	vo10v+47WH5B4x73ZJ4TXCbgmYqh3ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741619519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tyvzamKgKRqyxRt5U6QPdn/vabNysXQhbfHATPS8cPY=;
	b=ClK6YobtRI92Py7ruEYqR+C8AuyfKOHojTiwRa7A8IplFAMydvflG/30u5WMNFiptqg1m4
	+FGNfHet1kVcWdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2BA11399F;
	Mon, 10 Mar 2025 15:11:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XBjRMj8Bz2e4RgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Mar 2025 15:11:59 +0000
Message-ID: <99922cca-ed8e-4996-8833-a89264783b28@suse.cz>
Date: Mon, 10 Mar 2025 16:11:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] mm/mremap: complete refactor of move_vma()
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
 <bb6fa26fe29c5ff6cdbb162fd9ffdb0b050dfefe.1741256580.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <bb6fa26fe29c5ff6cdbb162fd9ffdb0b050dfefe.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EFF121F441
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/6/25 11:34, Lorenzo Stoakes wrote:
> We invoke ksm_madvise() with an intentionally dummy flags field, so no
> need to pass around.
> 
> Additionally, the code tries to be 'clever' with account_start,
> account_end, using these to both check that vma->vm_start != 0 and that we
> ought to account the newly split portion of VMA post-move, either before
> or after it.
> 
> We need to do this because we intentionally removed VM_ACCOUNT on the VMA
> prior to unmapping, so we don't erroneously unaccount memory (we have
> already calculated the correct amount to account and accounted it, any
> subsequent subtraction will be incorrect).
> 
> This patch significantly expands the comment (from 2002!) about
> 'concealing' the flag to make it abundantly clear what's going on, as well
> as adding and expanding a number of other comments also.
> 
> We can remove account_start, account_end by instead tracking when we
> account (i.e.  vma->vm_flags has the VM_ACCOUNT flag set, and this is not
> an MREMAP_DONTUNMAP operation), and figuring out when to reinstate the
> VM_ACCOUNT flag on prior/subsequent VMAs separately.
> 
> We additionally break the function into logical pieces and attack the very
> confusing error handling logic (where, for instance, new_addr is set to
> err).
> 
> After this change the code is considerably more readable and easy to
> manipulate.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Some nits below:

> +/*
> + * Unmap source VMA for VMA move, turning it from a copy to a move, being
> + * careful to ensure we do not underflow memory account while doing so if an
> + * accountable move.
> + *
> + * This is best effort, if we fail to unmap then we simply try

this looks like an unfinished sentence?

> @@ -1007,51 +1157,15 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
>  	 */
>  	hiwater_vm = mm->hiwater_vm;

This...

> -	/* Tell pfnmap has moved from this vma */
> -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> -		untrack_pfn_clear(vma);
> -
> -	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP))) {
> -		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
> -		vm_flags_clear(vma, VM_LOCKED_MASK);
> -
> -		/*
> -		 * anon_vma links of the old vma is no longer needed after its page
> -		 * table has been moved.
> -		 */
> -		if (new_vma != vma && vma->vm_start == old_addr &&
> -			vma->vm_end == (old_addr + old_len))
> -			unlink_anon_vmas(vma);
> -
> -		/* Because we won't unmap we don't need to touch locked_vm */
> -		vrm_stat_account(vrm, new_len);
> -		return new_addr;
> -	}
> -
> -	vrm_stat_account(vrm, new_len);
> -
> -	vma_iter_init(&vmi, mm, old_addr);
> -	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, vrm->uf_unmap, false) < 0) {
> -		/* OOM: unable to split vma, just get accounts right */
> -		if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP))
> -			vm_acct_memory(old_len >> PAGE_SHIFT);
> -		account_start = account_end = false;
> -	}
> +	vrm_stat_account(vrm, vrm->new_len);
> +	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP)))
> +		dontunmap_complete(vrm, new_vma);
> +	else
> +		unmap_source_vma(vrm);
> 
>  	mm->hiwater_vm = hiwater_vm;

... and this AFAICS only applies to the unmap_source_vma() case. And from
the comment it seems only to the "undo destination vma" variant. BTW this
also means the unmap_source_vma() name is rather misleading?

So I think the whole handling of that hiwater_vm could move to
unmap_source_vma(). It should not matter if we take the snapshot of
hiwater_vm only after vrm_stat_account() bumps the total_vm. Nobody else can
be racing with us to permanently turn that total_vm to a hiwater_vm.

(this is probably a potential cleanup for a followup-patch anyway)

> 
> -	/* Restore VM_ACCOUNT if one or two pieces of vma left */
> -	if (account_start) {
> -		vma = vma_prev(&vmi);
> -		vm_flags_set(vma, VM_ACCOUNT);
> -	}
> -
> -	if (account_end) {
> -		vma = vma_next(&vmi);
> -		vm_flags_set(vma, VM_ACCOUNT);
> -	}
> -
> -	return new_addr;
> +	return err ? (unsigned long)err : vrm->new_addr;
>  }
> 
>  /*
> --
> 2.48.1


