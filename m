Return-Path: <linux-kernel+bounces-188587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EBC8CE3F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43B3281720
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9887684FBE;
	Fri, 24 May 2024 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XhRmepdG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mm108XQm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XhRmepdG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mm108XQm"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693855E73;
	Fri, 24 May 2024 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716544933; cv=none; b=M7Ks7+6Eq3oeNTcJZBqPicJEZCZ+GPSk4qZtIQVZsIxtwHfV2YgMjEENBbZQ0nhVfZh584fztWzk/NAXeG9qryVlqgF4ozyJHkjGmiaH0/22sZJli/2+S6G1bnL0UxGOJLFdrlFlkrdnllqOwW+S3++HkP3NpwUznZC1g8pTrqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716544933; c=relaxed/simple;
	bh=WGWTQ88lZDy9oTdVJgnyIUfB1dQtFV5h7aTFZonsxc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEQbCMhmr8wItNhVFbulOVOgn+XsNbpisL9cDHUEoXO/e4KjSXSitTZ0aBHa0dVdhrC8uQvQLUNUS1Sp5o3vu4J6zlWLqPq8mD/lvd6OYPqO+kte6pIb9YFGmdO413+wx95sJMZq78j77yTheNIw0VXu/jiyvppi+4+Uy4Ic43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XhRmepdG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mm108XQm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XhRmepdG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mm108XQm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 3686D339FD;
	Fri, 24 May 2024 10:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716544930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/OEvrzWeGwb1dUHEq64+dHG7ZwZd+5GEDO1Ba+pFW4=;
	b=XhRmepdGTrrFnqxO+ClvvJHopazd1ctZTY8rYZEh7ZSjX3gtbirDqMCdhsffm3L2f2IbRo
	5nLL/RiI/xU3qYdsnvPwOIS5xfSElPEUHP6SQhBiKdgxpOfSBWQHXPZOLvRtWMmX0s6Ink
	2TbcJeOeXMaJMy3cohOlYyOgAn22wRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716544930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/OEvrzWeGwb1dUHEq64+dHG7ZwZd+5GEDO1Ba+pFW4=;
	b=Mm108XQmAJJG6HE75E4M537VgfCYxaPopdC2tzOKUEioGzeAIg5vJg/J2em9jrR1aKmFO8
	V55JzhDyP4Ks1oAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716544930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/OEvrzWeGwb1dUHEq64+dHG7ZwZd+5GEDO1Ba+pFW4=;
	b=XhRmepdGTrrFnqxO+ClvvJHopazd1ctZTY8rYZEh7ZSjX3gtbirDqMCdhsffm3L2f2IbRo
	5nLL/RiI/xU3qYdsnvPwOIS5xfSElPEUHP6SQhBiKdgxpOfSBWQHXPZOLvRtWMmX0s6Ink
	2TbcJeOeXMaJMy3cohOlYyOgAn22wRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716544930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/OEvrzWeGwb1dUHEq64+dHG7ZwZd+5GEDO1Ba+pFW4=;
	b=Mm108XQmAJJG6HE75E4M537VgfCYxaPopdC2tzOKUEioGzeAIg5vJg/J2em9jrR1aKmFO8
	V55JzhDyP4Ks1oAQ==
Date: Fri, 24 May 2024 12:02:10 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Subject: Re: CVE-2023-52823: kernel: kexec: copy user-array safely
Message-ID: <ZlBlorsBMPK0RdnR@dwarf.suse.cz>
References: <2024052106-CVE-2023-52823-3d81@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052106-CVE-2023-52823-3d81@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.47 / 50.00];
	BAYES_HAM(-2.17)[96.01%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -3.47
X-Spam-Flag: NO

On Tue, May 21, 2024 at 05:31:59PM +0200, Greg Kroah-Hartman wrote:
> kernel: kexec: copy user-array safely
> 
> Currently, there is no overflow-check with memdup_user().

This is false. 
Therefore, I'd like to dispute this CVE.

The overflow check is in the kexec_load_check()
function called shortly before the memdup_user() call:


	SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
			struct kexec_segment __user *, segments, unsigned long, flags)
	{
		result = kexec_load_check(nr_segments, flags);
		if (result)
			return result;
	...
		ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
	...
	}

	#define KEXEC_SEGMENT_MAX 16
	static inline int kexec_load_check(unsigned long nr_segments,
					   unsigned long flags)
	{
	...
		if (nr_segments > KEXEC_SEGMENT_MAX)
			return -EINVAL;
	}



Thanks,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


