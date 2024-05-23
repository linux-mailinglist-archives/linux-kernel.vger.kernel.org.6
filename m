Return-Path: <linux-kernel+bounces-187543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850168CD339
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9A51F21FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C86514A4D1;
	Thu, 23 May 2024 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AUf+Lmh7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AUf+Lmh7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBC13B7A3;
	Thu, 23 May 2024 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469719; cv=none; b=kWrpuQnvHpkvjof0aCROW+jvqEa7fWwUjFpp4XqmMG/up7OkP9/QRQP8R0rpWuV31kxT/rHpeg419Gzlw0lEkgXgktxghRktU1VbBWx8Z04bcU8bEYKatnpIevIzsfDXmFg8dA17un96WzHzoCG2Ek4AnJXgO1wELAmWDXvxiA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469719; c=relaxed/simple;
	bh=xDrQGqytmmiE09OJrqy/cRCo3P9waA7SdWOA6LMaUi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TehKHHD3B8L3mxZukRLWOPT7YKjhm9Zfp0adMBOpIIwaj045R5Y06rwwwZat2MfMXQX/QNbbovjNo49KqgGH5+S7xYBDOWxnJte0bvKb4Q8xMWDHX3PwDA62zEuS68FAdTNdCbgWnMPjpKqts8uCRM+G/74pw/SBC+THh/WO4NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AUf+Lmh7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AUf+Lmh7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88158221D6;
	Thu, 23 May 2024 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716469709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8K/9FEoIHUeOKcKFSxIFhQixiarYUm7MU6Zat4dJJN4=;
	b=AUf+Lmh7m1hT3cswnKkCner6GY9o/yZ+xt15sd+mjAgVvy4H+QaUmgKEtn0ZPlofL0RDDc
	Rd8PyUJlZFGtP+j6e0sfTQdyCXTxx6LMzJCvGEWgi33i0LyGiNBOC7KSj4FDbrO6a6dqGJ
	kunAcSSE56N4Nev8/vt9XMZ5Cn0jqxk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=AUf+Lmh7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716469709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8K/9FEoIHUeOKcKFSxIFhQixiarYUm7MU6Zat4dJJN4=;
	b=AUf+Lmh7m1hT3cswnKkCner6GY9o/yZ+xt15sd+mjAgVvy4H+QaUmgKEtn0ZPlofL0RDDc
	Rd8PyUJlZFGtP+j6e0sfTQdyCXTxx6LMzJCvGEWgi33i0LyGiNBOC7KSj4FDbrO6a6dqGJ
	kunAcSSE56N4Nev8/vt9XMZ5Cn0jqxk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65B7C13A6B;
	Thu, 23 May 2024 13:08:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HgKsFs0/T2bpQQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 23 May 2024 13:08:29 +0000
Date: Thu, 23 May 2024 15:08:24 +0200
From: Michal Hocko <mhocko@suse.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Oscar Salvador <OSalvador@suse.com>, Peter Xu <peterx@redhat.com>,
	cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-36000: mm/hugetlb: fix missing hugetlb_lock for resv
 uncharge
Message-ID: <Zk8_yGttYR_zPf_J@tiehlicka>
References: <2024052023-CVE-2024-36000-cfc4@gregkh>
 <Zkto8rbtAUBql-78@tiehlicka>
 <Zkz4RRgfwUHPbQ5z@x1n>
 <Zk7ws6H0wwuiFAJW@tiehlicka>
 <Zk8bgS8IboS-7jQw@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk8bgS8IboS-7jQw@localhost.localdomain>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 88158221D6
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]

On Thu 23-05-24 12:33:37, Oscar Salvador wrote:
> On Thu, May 23, 2024 at 09:30:59AM +0200, Michal Hocko wrote:
> > Let me add Oscar,
> 
> Thanks
> 
> > 
> > On Tue 21-05-24 15:38:45, Peter Xu wrote:
> > > That commit mentioned that we rely on the lock to make sure all hugetlb
> > > folios on the active list will have a valid memcg.  However I'm not sure
> > > whether it's still required now (after all that's 2012..), e.g., I'm
> > > looking at hugetlb_cgroup_css_offline(), and hugetlb_cgroup_move_parent()
> > > looks all safe to even take empty memcg folios with the latest code at
> > > least:
> > > 
> > > 	/*
> > > 	 * We can have pages in active list without any cgroup
> > > 	 * ie, hugepage with less than 3 pages. We can safely
> > > 	 * ignore those pages.
> > > 	 */
> > > 	if (!page_hcg || page_hcg != h_cg)
> > > 		goto out;
> 
> Ok, I had a look at hugetlb_cgroup implementation.
> First time looking at that code, so bear with me.
> 
> I looked back at commit
> 
>  commit 94ae8ba7176666d1e7d8bbb9f93670a27540b6a8 (HEAD)
>  Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>  Date:   Tue Jul 31 16:42:35 2012 -0700
>  
>      hugetlb/cgroup: assign the page hugetlb cgroup when we move the page to active list.
> 
> to understand why the lock was needed.
> 
> On the theoretical part:
> 
> And we could have
> 
>      CPU0                                   CPU1
>  dequeue_huge_page_vma
>   dequeue_huge_page_node
>    move_page_to_active_list
>  release_lock
>                                            hugetlb_cgroup_pre_destroy
>                                             for_each_page_in_active_list
>                                             <-- pages empty cgroups are skipped -->
>                                              hugetlb_cgroup_move_parent
>                                              move_page_to_parent
>  hugetlb_cgroup_commit_charge <-- too late
>   page[2].lru.next = (void *)h_cg;
> 
> So, the above page should have been moved to the parent, but since by the time
> we were checking the activelist this page did not have any cgroup attach ot it,
> it was skipped.
> 
> Notice I said theoretical because I noticed that
> cgroup_call_pre_destroy()->hugetlb_cgroup_pre_destroy() is called from
> cgroup_rmdir(). I am not sure under which circumstances cgroup_rmdir()
> can succeed (does the cgroup refcount have dropped to 0?)

Now, it just cannot have any tasks attached nor any subgroups. So is the
race actually possible?
-- 
Michal Hocko
SUSE Labs

