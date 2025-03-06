Return-Path: <linux-kernel+bounces-548467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DCAA5453F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C356A3A64F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189DC1A2C04;
	Thu,  6 Mar 2025 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h7k2fhMb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rl0CY2PA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N3PNxwIy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="INFgA7+O"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E32E3369
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250770; cv=none; b=PJZ4nuanndsZUbA2vD1QF+sser0jmhjniX45rX0kyI+imEwc/tQZG1UxGe4wgqXx92SGg7jKGggQYVIepxom1wIaPAk5Ug6jUrFbnoOKxiBBS03ToiwVwzvPDUEk9geR1cTrvKnP1XajYMsqy1SH5KP3CNVZ4IJEH5KNF0vjd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250770; c=relaxed/simple;
	bh=YxUwzQyIPwn66bsGykuHv69JbCKZBfxETFPoxjMQTrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRp9rQgJd2J1f7gjuIUtJ5Go3zLhgbbqE5feIEa+thR1diBdZ7U9eYXwnAKwaFQpHOjkhYmIQYnDwW9nuMxdIYW0HE6WGEIpnSZ39G6zpaR9fbVYNPtQjSD1nOSS8JZP63462/5GCXcBVlu+421LzV/5GmvAu1njeq0sWYRXcrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h7k2fhMb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rl0CY2PA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N3PNxwIy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=INFgA7+O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0F971F385;
	Thu,  6 Mar 2025 08:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741250765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ph7TfPBy85R2mjWVTiXodriBF6gHjbLGKraFRI8yZ2U=;
	b=h7k2fhMbx8iu4i0NJzAgtlEb9xsfikP2pF8CBNGPqM+bybr2/SZR0SUMrJ9TKt6HzWCxN+
	36h+J7s6SiX4iWoaR3HPJiDD/ItQ+juoPsQARy+ws4juZBIwJ6oAf32mqhpxbrRqOjtED6
	n2bF3SxPmRe+Ae8ieFXgbeqdeJUtBnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741250765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ph7TfPBy85R2mjWVTiXodriBF6gHjbLGKraFRI8yZ2U=;
	b=rl0CY2PAx+KDVBfD6SnxoiNcQvE0HwuXfdwuSvcJVJpdC6VoHZYyO3SIJgfEYrIDWlj3O/
	avUtgMnu+7ofWaCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=N3PNxwIy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=INFgA7+O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741250763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ph7TfPBy85R2mjWVTiXodriBF6gHjbLGKraFRI8yZ2U=;
	b=N3PNxwIyWBZAWscMP9h8MiNX87FbMEZDmCgFMZ0RFr0IujJJ0UyTA+Yc1+BOXaZdn0ZWTx
	womKDriBH4y95hfN2IRqUF7lbL7aJQetYG62TbXROqBEOtNWsnt1pFDnOhZgQc6lqcfxOo
	cF/8dOmOQS3tcs0wLjEvjByzv4kqq00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741250763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ph7TfPBy85R2mjWVTiXodriBF6gHjbLGKraFRI8yZ2U=;
	b=INFgA7+O7G6NVwttv93A/QHnT26tvsX3N0IJKgK8pcQ6ne1oDafG+BpUYfTTMmAJ6aZiSd
	cJwbgRlnMBV5BXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86CDB13676;
	Thu,  6 Mar 2025 08:46:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vi2DIMtgyWc6CQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 06 Mar 2025 08:46:03 +0000
Message-ID: <bc5e97e1-9f99-4dce-9e47-40342cbcfa84@suse.cz>
Date: Thu, 6 Mar 2025 09:46:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: Adds a way to handle freelist cycle in
 on_freelist()
To: Harry Yoo <harry.yoo@oracle.com>, Lilith Gkini <lilithpgkini@gmail.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <b951acd4-5510-4d03-8f1e-accf38d909b6@suse.cz>
 <Z8XbomV9WCabATIM@Arch> <8cabcf70-d887-471d-9277-ef29aca1216b@suse.cz>
 <Z8a4r2mnIzTD2cZa@Arch> <714d353a-49c8-4cbd-88d6-e24ae8f78aaa@suse.cz>
 <Z8benEHigCNjqqQp@Arch> <c736fbe1-f3f4-49a0-b230-41f9da545fad@suse.cz>
 <Z8bvfiyLelfXskNw@Arch> <c99235b8-3859-42dc-988b-250b3f042d00@suse.cz>
 <Z8hyV4sROVDtwRDE@Arch> <Z8leHDicTjUR9850@harry>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <Z8leHDicTjUR9850@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A0F971F385
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[oracle.com,gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,oracle.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/6/25 09:34, Harry Yoo wrote:
> Hi Lilith, the patch looks good, and it's great to see the improvements
> over the revisions! I've added my Reviewed-by: tag after the '---' line.
> 
> A few nit comments are inlined below.
> 
> From Documentation/process/submitting-patches.rst:
>> Describe your changes in imperative mood, e.g. “make xyzzy do frotz”
>> instead of “[This patch] makes xyzzy do frotz” or
>> “[I] changed xyzzy to do frotz”, as if you are giving orders to the codebase
>> to change its behaviour.
> 
> nit: Per submitting-patches.rst, I think the subject could be:
> - "slub: Add a way to handle freelist cycle in on_freelist()"
> or more concisely,
> - "slub: Handle freelist cycle in on_freelist()"

Right, some of the sentences later too. I've adjusted it a bit to avoid the
need to resubmit, hope it's ok. The result is here in slab/for-next

https://web.git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=slab/for-6.15/fixes-cleanups&id=747e2cf137f44058a093d3226bf83974d9d117e7

Thanks a lot!

> On Wed, Mar 05, 2025 at 05:48:39PM +0200, Lilith Gkini wrote:
>> The on_freelist() doesn't have a way to handle the edgecase of having a
>> full freelist that doesn't end in NULL and instead has another valid
>> pointer in the slab as a result of a Use-After-Free or anything similar.
>> 
>> This case won't get caught by check_valid_pointer() and it will result in
>> nr incrementing to `slab->objects + 1`, corrupting the slab->inuse entry
>> later in the code by setting it to -1.
>> 
>> The Patch adds an if check to detect that case, notifies us and handles
>> the freelist and slab appropriately, as is the standard process in these
>> situations.
>> 
>> Furthermore the Patch changes the return type of the function from
>> int to bool as per codying style guidelines.
> 
> nit: codying -> coding
> 
>> It also moves the `break;` line inside the `if (object) {` to make it more
>> obvious that the code breaks the while loop in that branch.
>> 
>> Signed-off-by: Lilith Persefoni Gkini <lilithgkini@proton.me>
>> ---
> 
> Looks good to me,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 


