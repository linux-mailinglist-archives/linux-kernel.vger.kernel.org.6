Return-Path: <linux-kernel+bounces-436914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BA19E8C8E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FD2280D9B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4918214A96;
	Mon,  9 Dec 2024 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VtHVFlu+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BttWni2S";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VtHVFlu+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BttWni2S"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A7715573D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730498; cv=none; b=IODyhx2MyOuxO+3vRdeaX+gb3+JPdUabS7VmCjiWJEIr4ZKu/EluX2k4z+aWIswL6w3O1ZsXnd9ddyzJjz0Us1X8kMgFxZ3eFtIQlGqDFbaHpvVXR3TsS85vHDPJ+Z4Cva8vs52EivrCL/OT6r0k6gy9fnpKZvYE7kC/24KO0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730498; c=relaxed/simple;
	bh=g/XGOcNNAX9SgQhKn3hREJo7TqTn90SPrvz/2qeEY3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIq28mog8qy4jNf301AkR/G3+YWcOmvSbPwHzrS+GYiTc2HOICiRRVMCYHTqMeWRbVa+yvmeyz/vFsrDYFIngnUmSmACu5VzF9ep9Sh3hz7K8de0R2u4jx2SLa5Xjtn2NP9MWHlGt6NggD4gI7+2yrHWriWWY5FVm8MBC0EgC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VtHVFlu+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BttWni2S; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VtHVFlu+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BttWni2S; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B48031F456;
	Mon,  9 Dec 2024 07:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733730494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULbQDbETi+vHyvngL1vqd7supW/fBFyBw5YnpQYENZg=;
	b=VtHVFlu+dJztCBpA4fzlKJNRo0wVGjpos6GhCjgCrStGmGQuwUZA2vmhpIsSiNQbabD7UO
	xaw50JlfXHVvec0zhzKCVx8HhUurq8DKjoCCB80+luJK2VEFSvkrhk4sTTzNjpbQpbXyFX
	mxBrU0BT1ocuWHGnK+3uTJz7uD86NbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733730494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULbQDbETi+vHyvngL1vqd7supW/fBFyBw5YnpQYENZg=;
	b=BttWni2ShKnLgiccL4AUxEGCkGB5TBuf4GwKUIK6567se5viQVTim0j45KVt9SChh/f4k1
	BoaxbzLIjsY1rmCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733730494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULbQDbETi+vHyvngL1vqd7supW/fBFyBw5YnpQYENZg=;
	b=VtHVFlu+dJztCBpA4fzlKJNRo0wVGjpos6GhCjgCrStGmGQuwUZA2vmhpIsSiNQbabD7UO
	xaw50JlfXHVvec0zhzKCVx8HhUurq8DKjoCCB80+luJK2VEFSvkrhk4sTTzNjpbQpbXyFX
	mxBrU0BT1ocuWHGnK+3uTJz7uD86NbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733730494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULbQDbETi+vHyvngL1vqd7supW/fBFyBw5YnpQYENZg=;
	b=BttWni2ShKnLgiccL4AUxEGCkGB5TBuf4GwKUIK6567se5viQVTim0j45KVt9SChh/f4k1
	BoaxbzLIjsY1rmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 541ED138D2;
	Mon,  9 Dec 2024 07:48:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OLWeEb6gVmdMfgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 09 Dec 2024 07:48:14 +0000
Date: Mon, 9 Dec 2024 08:48:08 +0100
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v1 2/2] mm/memory_hotplug: don't use __GFP_HARDWALL when
 migrating pages via memory offlining
Message-ID: <Z1aguIT-Br920uey@localhost.localdomain>
References: <20241205085217.2086353-1-david@redhat.com>
 <20241205085217.2086353-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205085217.2086353-3-david@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, Dec 05, 2024 at 09:52:17AM +0100, David Hildenbrand wrote:
> We'll migrate pages allocated by other context; respecting the cpuset of
> the memory offlining context when allocating a migration target does not
> make sense.
> 
> Drop the __GFP_HARDWALL by using GFP_KERNEL.
> 
> Note that in an ideal world, migration code could figure out the cpuset
> of the original context and take that into consideration.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

