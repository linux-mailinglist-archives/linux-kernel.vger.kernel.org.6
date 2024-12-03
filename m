Return-Path: <linux-kernel+bounces-429674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 049C09E1FA1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E75284AB5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF2A1F473A;
	Tue,  3 Dec 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vq28cfdE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XdwHkbb6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vq28cfdE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XdwHkbb6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254DE1F4283
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236790; cv=none; b=mMW4Si21IlyNGWiyW5rMjjl5Anv85eKV5Els4lkck3BamEo287iQT9mqR+TarLGRPaTkl+0rEWF6z1n6g65b1HB3Hz3dCSQn8pKOigQECVzg5flaI/vmVjD6gmkn+RmBwhcQ1y2LXvI8CO19fpVcSilKCwEzO/wmk01s3+5pCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236790; c=relaxed/simple;
	bh=KpLEW6aa0GBjlCnAgPfI9jl9IdTnQZaCITA3LOC3CSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YX5kbuMLMuyZphWl1vKrLitYN+GecuXgh3l86Exmu9JaS8RqDHfbvUSFbJZn3nEx+HAoKo+8Y4zzGh0mhYJD78IfAjlCBjOvsEK27lFAY0VNkK8LftYnX6oBlWLMe8S22RV/nfVIr2uWV2RDrUoeuhMaoAOZ8ZgGLRnEZslMXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vq28cfdE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XdwHkbb6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vq28cfdE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XdwHkbb6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 323A12115C;
	Tue,  3 Dec 2024 14:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733236787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lr3ksZI6LdpKDlNaXZve1Yy2t+rHyGnN7Z6NmVzlQ5M=;
	b=vq28cfdE9QpLZjJd9xKohuqguE5R+sMEoERq0/qtZNwMbM+iG3SnaQZPbkx+RgRgYloC+B
	jLxvIBjrHdMEuJ89Qeh6opSQQl1W63LH9aUsyN3i/xgBDn54ryr1xjhbEUSUkS4+d6XMAJ
	FbTgv4axm/q54dU+xobeI7/eFs7qaXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733236787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lr3ksZI6LdpKDlNaXZve1Yy2t+rHyGnN7Z6NmVzlQ5M=;
	b=XdwHkbb63uqIS1ACFyjUKQRV5Ecc5ixtvGlF8t+21xNlZ5ok2DtOZJzeY4Oi4eIy2fwLXb
	MfZoldDy4zbT+aBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733236787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lr3ksZI6LdpKDlNaXZve1Yy2t+rHyGnN7Z6NmVzlQ5M=;
	b=vq28cfdE9QpLZjJd9xKohuqguE5R+sMEoERq0/qtZNwMbM+iG3SnaQZPbkx+RgRgYloC+B
	jLxvIBjrHdMEuJ89Qeh6opSQQl1W63LH9aUsyN3i/xgBDn54ryr1xjhbEUSUkS4+d6XMAJ
	FbTgv4axm/q54dU+xobeI7/eFs7qaXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733236787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lr3ksZI6LdpKDlNaXZve1Yy2t+rHyGnN7Z6NmVzlQ5M=;
	b=XdwHkbb63uqIS1ACFyjUKQRV5Ecc5ixtvGlF8t+21xNlZ5ok2DtOZJzeY4Oi4eIy2fwLXb
	MfZoldDy4zbT+aBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13350139C2;
	Tue,  3 Dec 2024 14:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2nscBDMYT2d2NwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 03 Dec 2024 14:39:47 +0000
Message-ID: <7cd822c5-ca20-4d95-9751-c10f0ea98542@suse.cz>
Date: Tue, 3 Dec 2024 15:39:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 6/6] powernv/memtrace: use __GFP_ZERO with
 alloc_contig_pages()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-7-david@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20241203094732.200195-7-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,lists.ozlabs.org,linux-foundation.org,suse.de,nvidia.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,linux.ibm.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 12/3/24 10:47, David Hildenbrand wrote:
> alloc_contig_pages()->alloc_contig_range() now supports __GFP_ZERO,
> so let's use that instead to resolve our TODO.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


