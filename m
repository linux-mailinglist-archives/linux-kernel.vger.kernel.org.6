Return-Path: <linux-kernel+bounces-554390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2085DA59722
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBAB3AA690
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9BC22B595;
	Mon, 10 Mar 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o7nmY7Ah";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G18JgTle";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o7nmY7Ah";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G18JgTle"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6559222B59D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615865; cv=none; b=GKEF+BA85nym6qkDPi3F2f+Idfw9yB34e4i1uoScECtSP3zeXvdABzLq6rChHJX9MWjBuzmuX6+8BN8GnHkIX29UqF14HwzSTTInGf0UPCJd+Es9ti1X+ZkZpOtxza5+xemeOV7VfiDfGLTS2CfEcTnPG6YtZ3JawqQbnDsUk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615865; c=relaxed/simple;
	bh=qUa1zS+VD2LhPub2QGy6GIsn4ZaZT4mSAa+DNt8l2ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChHtp1UHAZHGv3k45P2zD3w2Nd5u1LGOoMHD3haU9rGtju7ztfZGK6txudO2siE+JhAX++KSAFs8LlKSOO0vIYz6V2b9d9MWxvHd0B+A2BcJnDDWetm5MEWrCC41B1NHEy6zXte/rswL/OFuNENfXxRdIryobwCOIAzFqi/1LE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o7nmY7Ah; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G18JgTle; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o7nmY7Ah; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G18JgTle; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D3921F387;
	Mon, 10 Mar 2025 14:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741615861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXW35WTC2goxr/by3s/1EBLUYqBHtpHzMVCqoIBP9M8=;
	b=o7nmY7AhbjPN4t9I3OIRv5IQEDpUEEd1XgXg8zXSu/Y61bMy2IG2W7Kib0Y6Mr86AJpVBv
	/5fKQh1HaqMFe7fElPkmfhddoAG90IYdZFLGqlcY0XJdUiTdjcshR7WoaLD2QKl97m98f6
	VZD9gDrgh+d3E5JA+rg3yswU5VfsPRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741615861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXW35WTC2goxr/by3s/1EBLUYqBHtpHzMVCqoIBP9M8=;
	b=G18JgTleuIVzXzNXkqaNEIGuol3qpqYL9SuiQglXzWLUPqSSZiA+hHBh5NrI69OzufdMAP
	SU3euoVGY8um+4Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741615861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXW35WTC2goxr/by3s/1EBLUYqBHtpHzMVCqoIBP9M8=;
	b=o7nmY7AhbjPN4t9I3OIRv5IQEDpUEEd1XgXg8zXSu/Y61bMy2IG2W7Kib0Y6Mr86AJpVBv
	/5fKQh1HaqMFe7fElPkmfhddoAG90IYdZFLGqlcY0XJdUiTdjcshR7WoaLD2QKl97m98f6
	VZD9gDrgh+d3E5JA+rg3yswU5VfsPRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741615861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXW35WTC2goxr/by3s/1EBLUYqBHtpHzMVCqoIBP9M8=;
	b=G18JgTleuIVzXzNXkqaNEIGuol3qpqYL9SuiQglXzWLUPqSSZiA+hHBh5NrI69OzufdMAP
	SU3euoVGY8um+4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 471C8139E7;
	Mon, 10 Mar 2025 14:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NAEOEfXyzmdYMgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Mar 2025 14:11:01 +0000
Message-ID: <92b633f0-1ac0-4074-ae7e-a8486052377b@suse.cz>
Date: Mon, 10 Mar 2025 15:11:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] mm/mremap: initial refactor of move_vma()
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
 <93193b2b45f6e95da6e8c7a2776e2d8c43a346e7.1741256580.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <93193b2b45f6e95da6e8c7a2776e2d8c43a346e7.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 3/6/25 11:34, Lorenzo Stoakes wrote:
> Update move_vma() to use the threaded VRM object, de-duplicate code and
> separate into smaller functions to aid readability and debug-ability.
> 
> This in turn allows further simplification of expand_vma() as we can
> simply thread VRM through the function.
> 
> We also take the opportunity to abstract the account charging page count
> into the VRM in order that we can correctly thread this through the
> operation.
> 
> We additionally do the same for tracking mm statistics - exec_vm,
> stack_vm, data_vm, and locked_vm.
> 
> As part of this change, we slightly modify when locked pages statistics
> are counted for in mm_struct statistics.  However this should cause no
> issues, as there is no chance of underflow, nor will any rlimit failures
> occur as a result.
> 
> This is an intermediate step before a further refactoring of move_vma() in
> order to aid review.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Can't wait what the bots report what I've missed in this one.


