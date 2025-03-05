Return-Path: <linux-kernel+bounces-546720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652F9A4FDFF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28BB3ACE7D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A13241675;
	Wed,  5 Mar 2025 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GrCfQRoX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U0TBO7sY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pniK9WiP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ax36neJN"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D490D23496F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175429; cv=none; b=a545mO5N1LwJeTwMjDE3sM47bDIKUR0irCpMWSeC79vAwVkyXN5hz9krh0E1caggB7l432fwH7D7ROe17G716lQsTIvYvIw6e0w1leRi/BYbgefF/O4YB9SuoGr8R1LKKuNXhhCjAnUctoW4AtBAVIFAfEs9GFGVNLf3SpfKtSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175429; c=relaxed/simple;
	bh=jyoNX4nuZNqlxOlG/rbU5bEkUoXF93qV9j14in4vLv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAS//OdD5e3bainjO3/ZTFSHg1T16vVKo7Xup7+aJE9NPjYwFm4Ks7PpYOzqy8wdiazKh7KRgVDufBoNJVOeFAnUW0z1bPaJKdwRok2lbDLSRgYs6uqVPNj3D7PQteCR3d1lFwwESIS8PtOr2UwVxgvixUEvBfX5NqrseDY4zPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GrCfQRoX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U0TBO7sY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pniK9WiP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ax36neJN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C73B01F455;
	Wed,  5 Mar 2025 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741175426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3f3VdzoziqsgQJInzerCEHtK2u+7JEUeYs2lcx+d5wM=;
	b=GrCfQRoX2KrAWcZpHVq9njgw6AUthyrpP+yhxLuUSw7zANJaVGwtMULPJ8Mp+JMRMptPU6
	FZ5jLG7m6icTF/6YHajUX7raw4Cq2pfLt70pnzr1DPRu4cFGHNdgJb2IkaDh2zU2m7bda2
	WoF2CmA7KUT/RG3RhZiHL5byWPs4dL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741175426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3f3VdzoziqsgQJInzerCEHtK2u+7JEUeYs2lcx+d5wM=;
	b=U0TBO7sY9/sXTWpe0h3WtVkTBGGMf0RdM1MeMboyWSJ7PPXc/OQj4BqyJ+iSo7x8fU/Dwc
	SPuyF6y0QdkI6JBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pniK9WiP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ax36neJN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741175425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3f3VdzoziqsgQJInzerCEHtK2u+7JEUeYs2lcx+d5wM=;
	b=pniK9WiPI2HGuxdQ6Vk3YFGM7FFf/HNFXVHJ2AhSEsPDlkcy7P/U7xhaigNI1jLo55ZgTI
	48KmffAUQkBjwoZ2JQa/ulaoe6IAUlVFaXwIBxMtdO3n/c1GE9/UP6oNINaara3JWFwVIj
	oJMs+6CzljPX5NTNUIqDPtxI50vMYTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741175425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3f3VdzoziqsgQJInzerCEHtK2u+7JEUeYs2lcx+d5wM=;
	b=ax36neJNYtfl02IWqcMzcVSHVDqxo4r3e39ABXc0jXx8TFTUWimjTWqUVDX8TPP/CK0cYb
	MqW9hKIPSDAAu/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B53971366F;
	Wed,  5 Mar 2025 11:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nJ/kK4E6yGcRGwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 05 Mar 2025 11:50:25 +0000
Message-ID: <0a4b2608-2dc2-42fa-b30c-1c1a62b56bbf@suse.cz>
Date: Wed, 5 Mar 2025 12:50:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] mm/mremap: correctly handle partial mremap() of VMA
 starting at 0
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <195c3956c70a142b12465e09b4aa5e33a898b789.1740911247.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <195c3956c70a142b12465e09b4aa5e33a898b789.1740911247.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C73B01F455
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/3/25 12:08, Lorenzo Stoakes wrote:
> Consider the case of a a partial mremap() (that results in a VMA split) of
> an accountable VMA (i.e. which has the VM_ACCOUNT flag set) whose start
> address is zero, with the MREMAP_MAYMOVE flag specified and a scenario
> where a move does in fact occur:
> 
>        addr  end
>         |     |
>         v     v
>     |-------------|
>     |     vma     |
>     |-------------|
>     0
> 
> This move is affected by unmapping the range [addr, end). In order to
> prevent an incorrect decrement of accounted memory which has already been
> determined, the mremap() code in move_vma() clears VM_ACCOUNT from the VMA
> prior to doing so, before reestablishing it in each of the VMAs post-split:
> 
>     addr  end
>      |     |
>      v     v
>  |---|     |---|
>  | A |     | B |
>  |---|     |---|
> 
> Commit 6b73cff239e5 ("mm: change munmap splitting order and move_vma()")
> changed this logic such as to determine whether there is a need to do so by
> establishing account_start and account_end and, in the instance where such
> an operation is required, assigning them to vma->vm_start and vma->vm_end.
> 
> Later the code checks if the operation is required for 'A' referenced above
> thusly:
> 
> 	if (account_start) {
> 		...
> 	}
> 
> However, if the VMA described above has vma->vm_start == 0, which is now
> assigned to account_start, this branch will not be executed.
> 
> As a result, the VMA 'A' above will remain stripped of its VM_ACCOUNT flag,
> incorrectly.
> 
> The fix is to simply convert these variables to booleans and set them as
> required.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Fixes: 6b73cff239e5 ("mm: change munmap splitting order and move_vma()")
> Cc: stable@vger.kernel.org

Looks like the variables would be more accurately named account_prev and
account_next? But maybe it's refactored later anyway. Keeps the diff to
stable backport smaller.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


