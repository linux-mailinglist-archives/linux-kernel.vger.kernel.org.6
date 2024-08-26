Return-Path: <linux-kernel+bounces-300884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726C795EA05
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3A6280E41
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E9A129E93;
	Mon, 26 Aug 2024 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cXrmkmeR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T20gYIe3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66DF85270
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656287; cv=none; b=j1oZDLRozKK+rSlFYuSoUIXGtOt+BRoAWV9Dzbp/mOj7XXYW4TE1/Iff/PKUYJzURWHp0AVpgkC+X+ddp0hEkwq0r2TYtmwVzIRG+gpI6c7hfMNLKmq0D3M9+02AjprrCrUmPNJAGf+hYBIOuI0sowQcp106H8giHrT7pgHSPCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656287; c=relaxed/simple;
	bh=vaqXwIfLnKIH52QHQUbxfQeH4mfM4vRtssD8yZyEb+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chkeJA0wKWmtnY9kvA1KiFWldTf/OOUn1HZByXFxWInsu1zxaPffW8Oz+mHvdCDvrjW4zuoH3S1Az0wZva0aYicGWWHzhgchJ/maFuPaQv0E8JsNwWs9//jXijIz9+AyLr+iM8LBi8zAsMPZzsc6rZ+e+e1a3+JTeC/JVsitgZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cXrmkmeR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T20gYIe3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Aug 2024 09:11:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724656283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g46RXz25EG/tDHSxyQpu6a8JT4ayEJq99k3eM3BtBYM=;
	b=cXrmkmeRyoT78pMMekcZc3nc67McgwgHmXmOETFm5WsKGGV7kZzxcZUhEx4F56bdWSVdA8
	JBzcOeCk6FunvcHai4n7B6cfih4O1e28BQnU1KWrIS+LdLE4BLhzhyAnZo4pxn9ohdCI4s
	eRT6VR8+dl8WaAeqML8W/SHXJKw8XCUagYbKGVnUHbiKLoI/lLGZDp9dv0Y9o9n9oueedi
	RFWokNYzhKIbR37hPbMBTcS5oFZTl9Y5wgD0C7MjBhvBAzDK2hqr28vLYPFKwta9vjKokW
	4+mhN4gEjkq6vYSgEb7HB0IwoNRBElNoBnUwGEC1pcS8wxp0ERj97PVhiCmRuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724656283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g46RXz25EG/tDHSxyQpu6a8JT4ayEJq99k3eM3BtBYM=;
	b=T20gYIe3Z38c7pHt/15SdQ/hrKsJ9fLlGIjbvdyzsGiai3Q1M2QQsHrf4wzGV2rf4SxWob
	sPD82AtwhMCMhOAQ==
From: Nam Cao <namcao@linutronix.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, bigeasy@linutronix.de
Subject: Re: [PATCH] x86/mm/pat: Support splitting of virtual memory areas
Message-ID: <20240826071103.7xq5iOjF@linutronix.de>
References: <20240825152403.3171682-1-namcao@linutronix.de>
 <8ed51ba1-a844-483a-9eea-36571ec635ff@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ed51ba1-a844-483a-9eea-36571ec635ff@lucifer.local>

On Sun, Aug 25, 2024 at 05:04:44PM +0100, Lorenzo Stoakes wrote:
> On Sun, Aug 25, 2024 at 05:24:03PM GMT, Nam Cao wrote:
> 
> [snip]
> 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index d0dfc85b209b..64067ddb8382 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2486,6 +2486,12 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	if (err)
> >  		goto out_free_mpol;
> >
> > +	if (unlikely(vma->vm_flags & VM_PFNMAP)) {
> > +		err = track_pfn_split(vma, addr);
> > +		if (err)
> > +			goto out_vma_unlink;
> > +	}
> > +
> >  	if (new->vm_file)
> >  		get_file(new->vm_file);
> >
> > @@ -2515,6 +2521,8 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  		vma_next(vmi);
> >  	return 0;
> >
> > +out_vma_unlink:
> > +	unlink_anon_vmas(vma);
> >  out_free_mpol:
> >  	mpol_put(vma_policy(new));
> >  out_free_vmi:
> > --
> > 2.39.2
> >
> 
> Right from the start the 6.11rc cycle mm-unstable and therefore -next has
> moved this function out to mm/vma.c, so you will need to make this change
> there rather than against mm/mmap.c (or whichever tree this is intended to
> come through needs to sync up, especially as there's a fairly substantial
> amount of change going on right now in VMA handling).
> 
> Sorry about that!

Ah okay, thanks for lettimg me know.

We could wait for 6.12-rc1 to be out, and then let this patch go to x86
tree. Or we could let it go to mm tree, if x86 maintainers are okay with
that?

Best regards,
Nam

