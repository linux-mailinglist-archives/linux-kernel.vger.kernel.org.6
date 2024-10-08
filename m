Return-Path: <linux-kernel+bounces-355230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22E5994CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67561C250E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDF21DF25D;
	Tue,  8 Oct 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lUDijd/O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="de/xni6+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lUDijd/O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="de/xni6+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915791DED64
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392272; cv=none; b=YRqkvqwF06YmdFmrvPFUUlMcBZ6Sa4kIxnuV61q0DvkOXhDsrNbP8XnQeHt8kwBix2T1wDF/sqmIhbNabqXrFRkOUut/Kvwmv6Zpkx1xH276Qy6LapT5Qwy5hKaCLnTt6xAyPv/Gpv4/TT2bVN9kO2r/PG5XkQuFhLErDybfXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392272; c=relaxed/simple;
	bh=FP6GYyrNzHY3Z2ftG+QQs9S11yZwcUsLEVNfKwWfV7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaEppOLn8Rr8MRR4tY0DK8jJhw5yeBWMWm/qZjBmVmeH5ZZH/9DuBrWKneGclPTSlzrM8CZdL5BtMg4vKQuLNDgge0c63ypLdTyDJfA8kjgRFTGqrI5z82oO1ZAQBf+uTvT6VENnalBlqsgcd1HORToC8qepxFb+iqvRlCLUe6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lUDijd/O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=de/xni6+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lUDijd/O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=de/xni6+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AAA71FB53;
	Tue,  8 Oct 2024 12:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728392268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHNP9INoNCBmPOSJpiOK8YZZ1XwabaP1uf1xaEwjuKs=;
	b=lUDijd/OgQR/9fXkmUdKSa1ii/ZTQGfO7gNY1yBwqo+EYdXdaiJcTnIrBoZ+IenCDbLp6g
	pHefgUDs4FcgN3xBX69w37sc6R3dJwmIKUO4TKRH67VLM3ZoZ3SRKPuW2zzQT13t+2fjNf
	ZV6JVi6pdfOGpQW4d/A680WLqAFdLtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728392268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHNP9INoNCBmPOSJpiOK8YZZ1XwabaP1uf1xaEwjuKs=;
	b=de/xni6+TOL5AOpGWdRaONUZ7sgMLb9HoOKvyjkXVyjoG/eLFVmvVXoajZFbWQz2nI7vAe
	TpoeX9259vZzE2CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="lUDijd/O";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="de/xni6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728392268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHNP9INoNCBmPOSJpiOK8YZZ1XwabaP1uf1xaEwjuKs=;
	b=lUDijd/OgQR/9fXkmUdKSa1ii/ZTQGfO7gNY1yBwqo+EYdXdaiJcTnIrBoZ+IenCDbLp6g
	pHefgUDs4FcgN3xBX69w37sc6R3dJwmIKUO4TKRH67VLM3ZoZ3SRKPuW2zzQT13t+2fjNf
	ZV6JVi6pdfOGpQW4d/A680WLqAFdLtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728392268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHNP9INoNCBmPOSJpiOK8YZZ1XwabaP1uf1xaEwjuKs=;
	b=de/xni6+TOL5AOpGWdRaONUZ7sgMLb9HoOKvyjkXVyjoG/eLFVmvVXoajZFbWQz2nI7vAe
	TpoeX9259vZzE2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BACF137CF;
	Tue,  8 Oct 2024 12:57:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BdunFUwsBWfLfwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 08 Oct 2024 12:57:48 +0000
Message-ID: <be1a1c1b-4630-41e2-a79a-57447851017d@suse.cz>
Date: Tue, 8 Oct 2024 14:57:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: avoid clearing user movable page twice with
 init_on_alloc=1
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
 Kees Cook <keescook@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 linux-kernel@vger.kernel.org
References: <20241007182315.401167-1-ziy@nvidia.com>
 <9e4e3094-00a2-43bc-996f-af15c3168e3a@redhat.com>
 <84D24C40-AC10-4FF7-B5F6-63FADD523297@nvidia.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <84D24C40-AC10-4FF7-B5F6-63FADD523297@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7AAA71FB53
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 10/8/24 13:52, Zi Yan wrote:
> On 8 Oct 2024, at 4:26, David Hildenbrand wrote:
> 
>>
>> I remember we discussed that in the past and that we do *not* want to sprinkle these CONFIG_INIT_ON_ALLOC_DEFAULT_ON checks all over the kernel.
>>
>> Ideally, we'd use GFP_ZERO and have the buddy just do that for us? There is the slight chance that we zero-out when we're not going to use the allocated folio, but ... that can happen either way even with the current code?
> 
> I agree that putting CONFIG_INIT_ON_ALLOC_DEFAULT_ON here is not ideal, but

Create some nice inline wrapper for the test and it will look less ugly? :)

> folio_zero_user() uses vmf->address to improve cache performance by changing
> subpage clearing order. See commit c79b57e462b5 ("mm: hugetlb: clear target
> sub-page last when clearing huge page”). If we use GFP_ZERO, we lose this
> optimization. To keep it, vmf->address will need to be passed to allocation
> code. Maybe that is acceptable?

I'd rather not change the page allocation code for this...

> Best Regards,
> Yan, Zi


