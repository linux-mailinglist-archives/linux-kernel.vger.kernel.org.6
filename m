Return-Path: <linux-kernel+bounces-187094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AB88CCD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A9A1F21479
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CFE13C9D2;
	Thu, 23 May 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PYYckYVX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IvK9V8R3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCA413B284;
	Thu, 23 May 2024 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449469; cv=none; b=E8NHHvrJx3b2OWbxbT+nRCOLxNMi9HwfA/nO6vOJr8WfJTOCiNdHkctjBbYrLmfun1iQjg4AmQi1LKr2N+l+gEWBiIT3lUmO+THEEV+i9j9pguSDiD1ENC6pH7A9aVZYQgtip2lLu0mXNLfDggm3ZhAPOuzPJswVZ7tSqPtdico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449469; c=relaxed/simple;
	bh=E6KSMHkcFqMBfxwvW0aqU0sxVmzpbZ2ANCBUp28KRoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZBgXFtEvBWhKJ38IG2epV4hlEEQ+7/qIvF+p/k/Z6RHDITQrCBkvcz03oE9QnlBka8pcP0q518UzvvFm7WKuNO/uXxn+crDj4Hxnej72cX/n0DzsgJscHuZCWqE5e2R9pTrj95kj6O9cN95pg0OHfxcBw/mkZW+JkIEIoe0nzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PYYckYVX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IvK9V8R3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A207221BE;
	Thu, 23 May 2024 07:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716449461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXofB/MrwbBei8swbKQAdzf6vUd6YCUPSlTpcTrnuI8=;
	b=PYYckYVXkrSJAlsjvASJofbHz9wflc/AaIh5IEXIF568ssr4dNvTsd7gDBcw5omcxPs2vh
	MtNKZxT0F2l13DKq/xNE3xwrvMYye/zwOraPNajynCzrenmlYTndD1+Jds6dlWyDR2xDMS
	0iAnOJPcWDA3J1X9cN+CmNGLhIHZFmw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716449460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXofB/MrwbBei8swbKQAdzf6vUd6YCUPSlTpcTrnuI8=;
	b=IvK9V8R38dhZDQYWTBxFFJai+li2mt6n1f9i5aMy9D1ZFHZv1MDfuk/cRosCnhCeMhOopp
	ACOBVD/7U2zad7eXDKdKZHM2IPaXDBroqcXW7L3XatC4HrBgc2QMQNjcPwJFGyM5qozDwn
	LMOxfW8UXw2ac2xUYKNkEnWTUZqwfi8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 376CB13A6C;
	Thu, 23 May 2024 07:31:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BzjTCrTwTmZhRwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 23 May 2024 07:31:00 +0000
Date: Thu, 23 May 2024 09:30:59 +0200
From: Michal Hocko <mhocko@suse.com>
To: Oscar Salvador <OSalvador@suse.com>
Cc: Peter Xu <peterx@redhat.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-36000: mm/hugetlb: fix missing hugetlb_lock for resv
 uncharge
Message-ID: <Zk7ws6H0wwuiFAJW@tiehlicka>
References: <2024052023-CVE-2024-36000-cfc4@gregkh>
 <Zkto8rbtAUBql-78@tiehlicka>
 <Zkz4RRgfwUHPbQ5z@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zkz4RRgfwUHPbQ5z@x1n>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

Let me add Oscar,

On Tue 21-05-24 15:38:45, Peter Xu wrote:
> On Mon, May 20, 2024 at 05:14:58PM +0200, Michal Hocko wrote:
> > Peter,
> 
> Hi, Michal,
> 
> > does b76b46902c2d ("mm/hugetlb: fix missing hugetlb_lock for resv
> > uncharge") really have any security implications? I fail to see any but
> > UFFD is not really my area so I might be missing something very easily.
> 
> AFAIU that issue wasn't userfault specific, but a generic issue for hugetlb
> - I believe that can also trigger in other paths whoever try to call
> alloc_hugetlb_folio(), and UFFDIO_COPY is one user of it.
> 
> I looked at that and provided a fix only because the report originated from
> the uffd report, so Andrew normally pointing those to me, and since I
> looked anyway I tried to fix that.

OK, I see. Thanks for the clarification.

> Here in general what I can see is that the lock is needed since this
> commit:
> 
>     commit 94ae8ba7176666d1e7d8bbb9f93670a27540b6a8
>     Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>     Date:   Tue Jul 31 16:42:35 2012 -0700
> 
>     hugetlb/cgroup: assign the page hugetlb cgroup when we move the page to active list.
> 
> That commit mentioned that we rely on the lock to make sure all hugetlb
> folios on the active list will have a valid memcg.  However I'm not sure
> whether it's still required now (after all that's 2012..), e.g., I'm
> looking at hugetlb_cgroup_css_offline(), and hugetlb_cgroup_move_parent()
> looks all safe to even take empty memcg folios with the latest code at
> least:
> 
> 	/*
> 	 * We can have pages in active list without any cgroup
> 	 * ie, hugepage with less than 3 pages. We can safely
> 	 * ignore those pages.
> 	 */
> 	if (!page_hcg || page_hcg != h_cg)
> 		goto out;
> 
> In short, I don't know any further security implications on this problem
> besides LOCKDEP enabled.  But I don't think I fully understand the hugetlb
> reservation code, so please just take that with a grain of salt.  E.g.,
> right now we do the hugetlb_cgroup_uncharge_folio_rsvd(), then could it
> happen that this folio will still be used finally and got injected into the
> pgtables (after all, alloc_hugetlb_folio() will still return this folio to
> the caller with a success), and would that be a problem if this folio has
> its _hugetlb_cgroup_rsvd==NULL?  That looks like another question besides
> this specific problem, though..

Oscar, could you have a look please?

-- 
Michal Hocko
SUSE Labs

