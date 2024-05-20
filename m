Return-Path: <linux-kernel+bounces-183891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E13B88C9F71
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8901C20358
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415C6136E0E;
	Mon, 20 May 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VLevcejG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VLevcejG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A306F136E26;
	Mon, 20 May 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218103; cv=none; b=fJr0RryyMEZQN8OdpwPxUZv9Bl4fZp8Wh8UJnZGa+6Z/vw9Y+rWj3zNujlq0Ogf9aQIsxxI+tzGfoYE/RwOxvsqe0qCWdtgBvdpIew3DayoJwSgpaxrTOoCCXnAKuY5ESPWjHgD0hsRZYQSNf9VHpt53Rvk9W9M/lhm4wQDm6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218103; c=relaxed/simple;
	bh=BSQq3nH6BbvG3GwwX7KXj9SSGpe+oFenzMH/FHArVAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULSn3828PVOyGietuhCl0T6/r67/rvNyGxxps7qc9XhHEyFSXpfFFXKACrA/oj8RRgunlj5sWbbu6n6/UM/fBJnbUC7Tm2wkBx9LLRem9PYKSRJm687JzCX3UU1oVlFTxccjpmt4MSMY4D+Nte5lyjNmx7SEb4mRRw7KmuNRwZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VLevcejG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VLevcejG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96A1B20E0B;
	Mon, 20 May 2024 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716218099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=txH8gRBcmiZ+FPDAMq+kB7RXfbCSffpiS23t4sam29M=;
	b=VLevcejGINAYhrq4LcJ2vAGg8pRqCHvTRldomG8OwDpFInxqFfL3EYvwryIgX2JmepIfO4
	Zt1IHePJE+Eav9WY/OzvFEr8qyDurbrgaCcXkKOFAHocomCCy4zFiB6QGBBNB0U6WKlYlv
	Rej9p3mFPN0LBXLYTMPCP1zm1MahUcA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716218099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=txH8gRBcmiZ+FPDAMq+kB7RXfbCSffpiS23t4sam29M=;
	b=VLevcejGINAYhrq4LcJ2vAGg8pRqCHvTRldomG8OwDpFInxqFfL3EYvwryIgX2JmepIfO4
	Zt1IHePJE+Eav9WY/OzvFEr8qyDurbrgaCcXkKOFAHocomCCy4zFiB6QGBBNB0U6WKlYlv
	Rej9p3mFPN0LBXLYTMPCP1zm1MahUcA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7849113A6B;
	Mon, 20 May 2024 15:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jmNjGvNoS2ZaJwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 20 May 2024 15:14:59 +0000
Date: Mon, 20 May 2024 17:14:58 +0200
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org,
	Peter Xu <peterx@redhat.com>
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-36000: mm/hugetlb: fix missing hugetlb_lock for resv
 uncharge
Message-ID: <Zkto8rbtAUBql-78@tiehlicka>
References: <2024052023-CVE-2024-36000-cfc4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052023-CVE-2024-36000-cfc4@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Peter,
does b76b46902c2d ("mm/hugetlb: fix missing hugetlb_lock for resv
uncharge") really have any security implications? I fail to see any but
UFFD is not really my area so I might be missing something very easily.

On Mon 20-05-24 11:48:36, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> mm/hugetlb: fix missing hugetlb_lock for resv uncharge
> 
> There is a recent report on UFFDIO_COPY over hugetlb:
> 
> https://lore.kernel.org/all/000000000000ee06de0616177560@google.com/
> 
> 350:	lockdep_assert_held(&hugetlb_lock);
> 
> Should be an issue in hugetlb but triggered in an userfault context, where
> it goes into the unlikely path where two threads modifying the resv map
> together.  Mike has a fix in that path for resv uncharge but it looks like
> the locking criteria was overlooked: hugetlb_cgroup_uncharge_folio_rsvd()
> will update the cgroup pointer, so it requires to be called with the lock
> held.
> 
> The Linux kernel CVE team has assigned CVE-2024-36000 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 5.10 with commit 79aa925bf239 and fixed in 6.1.91 with commit 4c806333efea
> 	Issue introduced in 5.10 with commit 79aa925bf239 and fixed in 6.6.30 with commit f6c5d21db16a
> 	Issue introduced in 5.10 with commit 79aa925bf239 and fixed in 6.8.9 with commit 538faabf31e9
> 	Issue introduced in 5.10 with commit 79aa925bf239 and fixed in 6.9 with commit b76b46902c2d
> 	Issue introduced in 5.9.7 with commit f87004c0b2bd
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-36000
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	mm/hugetlb.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/4c806333efea1000a2a9620926f560ad2e1ca7cc
> 	https://git.kernel.org/stable/c/f6c5d21db16a0910152ec8aa9d5a7aed72694505
> 	https://git.kernel.org/stable/c/538faabf31e9c53d8c870d114846fda958a0de10
> 	https://git.kernel.org/stable/c/b76b46902c2d0395488c8412e1116c2486cdfcb2

-- 
Michal Hocko
SUSE Labs

