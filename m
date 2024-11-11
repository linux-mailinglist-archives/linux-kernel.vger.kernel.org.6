Return-Path: <linux-kernel+bounces-403779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FCE9C3ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A907B2822FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812215DBBA;
	Mon, 11 Nov 2024 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xb3YGT3+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NkTbxvYn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xb3YGT3+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NkTbxvYn"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE774146A6B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316777; cv=none; b=K/U26xlr6xvHDDERAhWdajWILHIk0SQz8IWsY0VdhUBnaXGgiXL7geI+A3LFwHrKO4CwGYN/Gb2ibxo57zXnKyd0gpvX6Kw2UpyU6jhSG1XaJ6XKKwSfqX8nclNOcsS+J9reMbYCs9XISvYk1htikkuzgXI0ej+arJgb1qiZysI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316777; c=relaxed/simple;
	bh=gjFKRkg7+UL4G1F+DIQlCjuH4AL2ll8O0s15B/ds1dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gx2ro/bGIb+T+fWcn30lgZeRNmtYFLfFIdvz3NIzlb7wxKRRNxbs/EYlrAy+BsScL9m11BVv72vay0gx8nea4zqPOzT2Qpc9k7gY+N5SRR3YIwareCOgs3X1UkxK+oPY/+QUcu67PsfYIo5QD/GeDnpa0ZvfjJw1/7H75YPU0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xb3YGT3+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NkTbxvYn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xb3YGT3+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NkTbxvYn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 012DF219AE;
	Mon, 11 Nov 2024 09:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731316773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZpFZqEeNUo0RNOS01WLG212re3rhrvrASd53kvI70g=;
	b=xb3YGT3+fOoqCtaVa8cXlmSqv1SOpgQT9G094A4H47Cjv7N4Jq0p6UMsKo4nL1DZaYl+ZF
	HLCV5gLQnWGxgM3gw6sR+QB0XGNjZ2AaSuP5i8voyU0yTmvtRqGElZ08pyHQQejx3jsxQi
	FVSjMw5FA2B4YE02ZHr14HxxIJfBKV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731316773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZpFZqEeNUo0RNOS01WLG212re3rhrvrASd53kvI70g=;
	b=NkTbxvYnYFRu4Sx1Cf2htZWNk543Nce/EerOmsqL7DDGYCRn/X6N9mn+TT22+cO2Mb2HWA
	mbbkFYCK/O9tO5Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xb3YGT3+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NkTbxvYn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731316773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZpFZqEeNUo0RNOS01WLG212re3rhrvrASd53kvI70g=;
	b=xb3YGT3+fOoqCtaVa8cXlmSqv1SOpgQT9G094A4H47Cjv7N4Jq0p6UMsKo4nL1DZaYl+ZF
	HLCV5gLQnWGxgM3gw6sR+QB0XGNjZ2AaSuP5i8voyU0yTmvtRqGElZ08pyHQQejx3jsxQi
	FVSjMw5FA2B4YE02ZHr14HxxIJfBKV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731316773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZpFZqEeNUo0RNOS01WLG212re3rhrvrASd53kvI70g=;
	b=NkTbxvYnYFRu4Sx1Cf2htZWNk543Nce/EerOmsqL7DDGYCRn/X6N9mn+TT22+cO2Mb2HWA
	mbbkFYCK/O9tO5Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6C40137FB;
	Mon, 11 Nov 2024 09:19:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XH3rKSPMMWejAQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 11 Nov 2024 09:19:31 +0000
Date: Mon, 11 Nov 2024 10:19:26 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Ackerley Tng <ackerleytng@google.com>, muchun.song@linux.dev,
	akpm@linux-foundation.org, rientjes@google.com, fvdl@google.com,
	jthoughton@google.com, david@redhat.com, isaku.yamahata@intel.com,
	zhiquan1.li@intel.com, fan.du@intel.com, jun.miao@intel.com,
	tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
	jgg@nvidia.com, jhubbard@nvidia.com, seanjc@google.com,
	pbonzini@redhat.com, erdemaktas@google.com, vannapurve@google.com,
	pgonda@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/3] mm: hugetlb: Refactor vma_has_reserves() to
 should_use_hstate_resv()
Message-ID: <ZzHMHuhCAM0vtrzf@localhost.localdomain>
References: <cover.1728684491.git.ackerleytng@google.com>
 <3d1946d01f63104de913c0979b5a596e2add1672.1728684491.git.ackerleytng@google.com>
 <ZypoDzm2XdfnG1if@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZypoDzm2XdfnG1if@x1n>
X-Rspamd-Queue-Id: 012DF219AE
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Tue, Nov 05, 2024 at 01:46:39PM -0500, Peter Xu wrote:
> I wonder if this patch could be merged with the 3rd, IIUC this can
> fundamentally be seen as a movement of what patch 3 was removed.

I think it makes sense to merge it, yes.

> Furthermore, I do feel like should_use_hstate_resv() could be redundant on
> its own on many things.

...
 
> Then let's look at chg==0 processing all above: what does it say?  I
> suppose it means "we don't need another global reservation".  It means if
> chg==0 we always will use an existing reservation.  From math POV it also
> is true, so it can already be moved out ahead, IIUC, like this:
> 
> static bool should_use_hstate_resv(struct vm_area_struct *vma, long chg,
> 				   bool avoid_reserve)
> {
> 	if (avoid_reserve)
> 		return false;
> 
>         if (chg == 0)
>                 return true;
> 
> 	if (vma->vm_flags & VM_NORESERVE)
>                 return false;
> 
> 	if (vma->vm_flags & VM_MAYSHARE)
>                 return false;
> 
> 	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER))
>                 return false;
> 
> 	return false;             <--------------------- [1]
> }
> 
> Move on.  If I read it right, above [1] is exactly for avoid_reserve==1
> case, where it basically says "it's !NORESERVE, private, and it's not the
> vma resv owner, either fork() or CoW".  If my reading is correct, it means
> after your patch 2, [1] should never be reachable at all.. I would hope
> adding a panic() right above would be ok.
> 
> And irrelevant of whether my understanding is correct.. math-wise above is
> also already the same as:
> 
> static bool should_use_hstate_resv(struct vm_area_struct *vma, long chg,
> 				   bool avoid_reserve)
> {
> 	if (avoid_reserve)
> 		return false;
> 
>         if (chg == 0)
>                 return true;
> 
> 	return false;
> }

I have been looking into this because hugetlb reservations always make
me uneasy, but I think you are right.

CoW and fork both set avoid_reserve to 1,

 copy_hugetlb_range
  ...
  alloc_hugetlb_folio(dst_vma, addr, 1)

 hugetlb_wp
  outside_reserve = 1
  alloc_hugetlb_folio(..., outside_reserve)

So I think you are right and this can be simplified.

I would not add a panic though, maybe some kind of warning (VM_DEBUG?).


-- 
Oscar Salvador
SUSE Labs

