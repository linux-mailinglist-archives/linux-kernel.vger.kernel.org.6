Return-Path: <linux-kernel+bounces-186700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F9B8CC7D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E2EB216EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F507E0F6;
	Wed, 22 May 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RzDozfLG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tpIiFXxx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RzDozfLG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tpIiFXxx"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14C3D0A4
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411040; cv=none; b=Hph+hvpc82KzHyJxtgyLnZ99ofmolf/tZMx3sI31DC5bUd/AsL4fYcUxjAjuzknUxPs/uLB31hgpmf4z61OL7wNU37YcslsHrt6pNMzJnCFbx3omGpL27YzHZBUWOVW5hi5kaPEArA2gqX+Psu9eHBn3q0XcDU4kJci8fYyLufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411040; c=relaxed/simple;
	bh=yaccdSNuPTbm1uJ1qWv5Kk5I0tb0MT2Ksps0XB5iz64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcgj1oUteA4cGR8UWjCgD26NKkFhueK6z1IL/vi3CPaSFhY5UyiLakoZJ79cFqe1rXn9Kypc39fMXJOhPlmEXHgdL75bkw37S8kdvLlZ2At3ar2mEm6JSU6hNWHfXy8f59Ab6ydC0/dVjpZDheV1qzRCHn7W0e8mSCU/qHJ4FP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RzDozfLG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tpIiFXxx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RzDozfLG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tpIiFXxx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 723C61F7F0;
	Wed, 22 May 2024 20:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716411035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k81BDkUMU0SoIhYIGjYwahblkQTHRGipazIuGgF/byc=;
	b=RzDozfLG/85ZUGYq6ELZiJUCU0zDiNjSwanE9DlTZJrLjcDKkGYKxffylI67o2JaSjyD8y
	wM1Kd0MyA5J3adJ9cNBn0kMazCJ/nEcu++gDZYbDykMvBJsNhxsgPrpz7tW0Qa6F2c1veA
	hOwkhPt+ngir03pLfq+u0JdboWzfqVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716411035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k81BDkUMU0SoIhYIGjYwahblkQTHRGipazIuGgF/byc=;
	b=tpIiFXxxBBT5PhPVflAniTyw53477v2YV6Fw2HPIeudyJn+DERcCBkhuIxtzzp1mYieCgC
	ctIituy3ZXjXyVCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716411035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k81BDkUMU0SoIhYIGjYwahblkQTHRGipazIuGgF/byc=;
	b=RzDozfLG/85ZUGYq6ELZiJUCU0zDiNjSwanE9DlTZJrLjcDKkGYKxffylI67o2JaSjyD8y
	wM1Kd0MyA5J3adJ9cNBn0kMazCJ/nEcu++gDZYbDykMvBJsNhxsgPrpz7tW0Qa6F2c1veA
	hOwkhPt+ngir03pLfq+u0JdboWzfqVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716411035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k81BDkUMU0SoIhYIGjYwahblkQTHRGipazIuGgF/byc=;
	b=tpIiFXxxBBT5PhPVflAniTyw53477v2YV6Fw2HPIeudyJn+DERcCBkhuIxtzzp1mYieCgC
	ctIituy3ZXjXyVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17B4A13A7A;
	Wed, 22 May 2024 20:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4kD1AptaTmYIbwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 22 May 2024 20:50:35 +0000
Date: Wed, 22 May 2024 22:50:33 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Jane Chu <jane.chu@oracle.com>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] mm/memory-failure: move hwpoison_filter() higher
 up
Message-ID: <Zk5amVS9kBWi3HJx@localhost.localdomain>
References: <20240521235429.2368017-1-jane.chu@oracle.com>
 <20240521235429.2368017-5-jane.chu@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521235429.2368017-5-jane.chu@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,linux-foundation.org,kvack.org,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On Tue, May 21, 2024 at 05:54:28PM -0600, Jane Chu wrote:
> Move hwpoison_filter() higher up as there is no need to spend a lot
> cycles only to find out later that the page is supposed to be skipped
> from hwpoison handling.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

I was about to raise the point that prior to this change hwpoison_filter()
would be called after shake_folio(), which should turn some pages LRU, but
I see that shake_page() is also called in hwpoison-inject code.

 

-- 
Oscar Salvador
SUSE Labs

