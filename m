Return-Path: <linux-kernel+bounces-549216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8808A54F14
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D848175CA3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28691221554;
	Thu,  6 Mar 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dqBp/7Bj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jUkQfPAn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ynNXvnwL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LsmDZdnF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28EB20E700
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274803; cv=none; b=MOeLEf4xyl/2dr81jWSQhXisKe7UComSnImE9x08Zo/9dJGdxW+eyMdV7NvjLRIHlDNyESg4+L6CJeIewpxI6U6/JGt/cKLi4nZfeoc/bq7JQ9BEcIpyEF8wxbrhyNF+TkUEsi7pn8JMJZA86Y1GYQOdwOmaWo2cWn35OzIywE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274803; c=relaxed/simple;
	bh=eh2FeV9qhFEaUS33PUyQ7DGC+NPypK7Mr6XdNiontW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjTbxQkVBoKxv3q2iZgCZLRX35f+6QhHG4Q4dX68YRT5BPgHhS+udKvDRP53vqLZaXj5GADC5I4/6KS/WfTUMhK2tWBPTxyxz1p+VKV7Tq9bsJ6VWwoi606zed9SGoftl2R+lQvlBhhSpiFriaJFsyerEWO00NKXHp+fZlBpIYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dqBp/7Bj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jUkQfPAn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ynNXvnwL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LsmDZdnF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF2DE1F449;
	Thu,  6 Mar 2025 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741274800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHd/QnzWREQK3Zss6xONiTXxlEVjHm5W37lzvfY3lPA=;
	b=dqBp/7BjOAuRnVQmI1pEgYy1/r8afNJZ/82F6j0nIzt8g2bTLy9pBYeVIlmrVAc9P87Lbg
	zYis9rSh1E0ZNRkwWRWv8OySVYglyWCQAAwi9aPiechXuhAfJHMMVv/eO3YM+Vo5JH071k
	YnN4cOKYv2+8oaZEgdxKl6RuYhh79Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741274800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHd/QnzWREQK3Zss6xONiTXxlEVjHm5W37lzvfY3lPA=;
	b=jUkQfPAnJJ19ZdsWyJ7lzUC9AOFOkS8ErIoOUHpewxwvoR4A7o/WSN1B6sXrRHaFxDHCt9
	O9RxfbIyaRN4PcDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741274799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHd/QnzWREQK3Zss6xONiTXxlEVjHm5W37lzvfY3lPA=;
	b=ynNXvnwLvzEEXs9DOZWyEg8+J798q7l0zalGyrGvhx8Qrj8QK9DY+ekGakKAUZqzRSaY72
	khoTbfr9VLiWmByNicWcS6OGj55cPA1hHzjLaAoMmM1kPojY3kRcvqn3Bn5ZsJefSIk5KD
	KZLdnY+fW3ZUZJ/A+rpR4VRS5pmiha0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741274799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHd/QnzWREQK3Zss6xONiTXxlEVjHm5W37lzvfY3lPA=;
	b=LsmDZdnFxE7289PnLJFgyFAhUUREEh89U5ARtGGQrfUCiItiBqHRKARIbFZ6ZpiW/9F1eG
	qr1O/loCNMLvzoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9202813A61;
	Thu,  6 Mar 2025 15:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1biFIa++yWfDFAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 06 Mar 2025 15:26:39 +0000
Message-ID: <15c0d1be-4caa-4d72-bad0-b559d9cd8ddc@suse.cz>
Date: Thu, 6 Mar 2025 16:26:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] mm/mremap: introduce and use vma_remap_struct
 threaded state
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
 <1aeadc40d377fff8796b7c114cb0351c92a68f20.1741256580.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1aeadc40d377fff8796b7c114cb0351c92a68f20.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,oracle.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 3/6/25 11:33, Lorenzo Stoakes wrote:
> A number of mremap() calls both pass around and modify a large number of
> parameters, making the code less readable and often repeatedly having to
> determine things such as VMA, size delta, and more.
> 
> Avoid this by using the common pattern of passing a state object through
> the operation, updating it as we go.  We introduce the vma_remap_struct or
> 'VRM' for this purpose.

Small children here make such a 'VRM' sound when imitating a car.

> This also gives us the ability to accumulate further state through the
> operation that would otherwise require awkward and error-prone pointer
> passing.
> 
> We can also now trivially define helper functions that operate on a VRM
> object.
> 
> This pattern has proven itself to be very powerful when implemented for
> VMA merge, VMA unmapping and memory mapping operations, so it is
> battle-tested and functional.
> 
> We both introduce the data structure and use it, introducing helper
> functions as needed to make things readable, we move some state such as
> mmap lock and mlock() status to the VRM, we introduce a means of
> classifying the type of mremap() operation and de-duplicate the
> get_unmapped_area() lookup.
> 
> We also neatly thread userfaultfd state throughout the operation.
> 
> Note that there is further refactoring to be done, chiefly adjust
> move_vma() to accept a VRM parameter.  We defer this as there is
> pre-requisite work required to be able to do so which we will do in a
> subsequent patch.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


