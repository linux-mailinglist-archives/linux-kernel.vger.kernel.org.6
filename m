Return-Path: <linux-kernel+bounces-187337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F098CD067
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DC11C21E27
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7970013F001;
	Thu, 23 May 2024 10:33:47 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF213C9CF;
	Thu, 23 May 2024 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460427; cv=none; b=jASMf0CFhc8DlIs4N9j1i0dfAisxK5d+KELz3ix5/PEOe8whh0/Hv6a7wpxc9jtTIB27qUNs37MTL8XRx3bMxG8Fs91Zvpy8yztgFQZOMGKF2vXf4B2Ii5cta5oFLvbRs/zkV3M93ZwNaM6OMP7KmnyVr17Z/FbzC8SzbfWf4x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460427; c=relaxed/simple;
	bh=si0cTviqyFaCa2SEBHn4eiiiNNjPB29Dn0RB1yfSjjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hdd/5C8Vy7u5P/Gzt6wgKkD/Ocsf8+dWIks0EGUcF3bIGOiKos2Dqf9b45dWRIqs4vqeiwMDQheySgajSl9XPXOtA8gENmnw1nbJtOu96i5q5mBJ4Lnw0eH3HMweAvVxpBTWqEeUNpJDLcou0rw3JYarjI4Xr74t/p5NGvEFzRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 67E98224F7;
	Thu, 23 May 2024 10:33:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFBA413A6B;
	Thu, 23 May 2024 10:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TtEJOIYbT2ZaQwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 23 May 2024 10:33:42 +0000
Date: Thu, 23 May 2024 12:33:37 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <OSalvador@suse.com>, Peter Xu <peterx@redhat.com>,
	cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-36000: mm/hugetlb: fix missing hugetlb_lock for resv
 uncharge
Message-ID: <Zk8bgS8IboS-7jQw@localhost.localdomain>
References: <2024052023-CVE-2024-36000-cfc4@gregkh>
 <Zkto8rbtAUBql-78@tiehlicka>
 <Zkz4RRgfwUHPbQ5z@x1n>
 <Zk7ws6H0wwuiFAJW@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk7ws6H0wwuiFAJW@tiehlicka>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 67E98224F7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

On Thu, May 23, 2024 at 09:30:59AM +0200, Michal Hocko wrote:
> Let me add Oscar,

Thanks

> 
> On Tue 21-05-24 15:38:45, Peter Xu wrote:
> > That commit mentioned that we rely on the lock to make sure all hugetlb
> > folios on the active list will have a valid memcg.  However I'm not sure
> > whether it's still required now (after all that's 2012..), e.g., I'm
> > looking at hugetlb_cgroup_css_offline(), and hugetlb_cgroup_move_parent()
> > looks all safe to even take empty memcg folios with the latest code at
> > least:
> > 
> > 	/*
> > 	 * We can have pages in active list without any cgroup
> > 	 * ie, hugepage with less than 3 pages. We can safely
> > 	 * ignore those pages.
> > 	 */
> > 	if (!page_hcg || page_hcg != h_cg)
> > 		goto out;

Ok, I had a look at hugetlb_cgroup implementation.
First time looking at that code, so bear with me.

I looked back at commit

 commit 94ae8ba7176666d1e7d8bbb9f93670a27540b6a8 (HEAD)
 Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
 Date:   Tue Jul 31 16:42:35 2012 -0700
 
     hugetlb/cgroup: assign the page hugetlb cgroup when we move the page to active list.

to understand why the lock was needed.

On the theoretical part:

And we could have

     CPU0                                   CPU1
 dequeue_huge_page_vma
  dequeue_huge_page_node
   move_page_to_active_list
 release_lock
                                           hugetlb_cgroup_pre_destroy
                                            for_each_page_in_active_list
                                            <-- pages empty cgroups are skipped -->
                                             hugetlb_cgroup_move_parent
                                             move_page_to_parent
 hugetlb_cgroup_commit_charge <-- too late
  page[2].lru.next = (void *)h_cg;

So, the above page should have been moved to the parent, but since by the time
we were checking the activelist this page did not have any cgroup attach ot it,
it was skipped.

Notice I said theoretical because I noticed that
cgroup_call_pre_destroy()->hugetlb_cgroup_pre_destroy() is called from
cgroup_rmdir(). I am not sure under which circumstances cgroup_rmdir()
can succeed (does the cgroup refcount have dropped to 0?)


Now onto the current days.

After Peter's fix, we had:

        CPU0                                 CPU1
 dequeue_huge_page_vma
  dequeue_hugetlb_folio_node_exact
   move_page_to_active_list
 hugetlb_cgroup_commit_charge
  : folio->_hugetlb_cgroup = cgroup
 hugetlb_cgroup_commit_charge_rsvd
  : folio->_hugetlb_cgroup_rsvd = cgroup
 release lock
                                          hugetlb_cgroup_css_offline
                                           take lock
                                           for_each_page_in_active_list
                                            hugetlb_cgroup_move_parent
                                             : set folio->_hugetlb_cgroup
                                             : _hugetlb_cgroup_rsvd is not set
                                             : still contains the old value
					    release lock
 __hugetlb_cgroup_uncharge_folio_rsvd
  hugetlb_cgroup_from_folio_rsvd
  ...
  folio->_hugetlb_cgroup_rsvd = NUL


So, as you can see, we charged a folio to the parent, and this folio still
contains the previous _hugetlb_cgroup_rsvd, when it should have been NULLed.
All this meaning that since no page_counter_uncharge() was called for
the _hugetlb_group_rsvd, parent still has the old page_counter's for cgroup_rsvd.

Then, if before hugetlb_cgroup_from_folio_rsvd() gets called, someone allocates a
new cgroup under this parent, it will get both the page_counters from the
_hugetlb_cgroup and the _hugetlb_cgroup_rsvd.
And then page_counter_set_max() gets called for both counters.

What implies for that new cgroup to have those page_counters?
I do not really know. 

Maybe it does not let it allocate a new page when it should? Or it does look like
it has more memory reserved than it actually does?


-- 
Oscar Salvador
SUSE Labs

