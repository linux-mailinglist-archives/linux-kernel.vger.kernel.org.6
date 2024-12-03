Return-Path: <linux-kernel+bounces-429547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBBA9E1D9D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3321728654F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289441E5710;
	Tue,  3 Dec 2024 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bplN164b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FxuL+eFG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bplN164b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FxuL+eFG"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715E1E570E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232746; cv=none; b=osT1ZGnFzEhp+pTgscSSqNlU3ZvD+hQpXq6lmkIuXRpuIdF8FnlsgdZjT24zoShI0I9CrgAdVLFBCutRv/BkE8fUEWE0o4KbHlKsL/gvfoHVPcVJjiwnu5JBq8WHORjudC/xjDjLIm7D1qDqKcaBjUXqN3bVlBLGDVJu0OAxzZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232746; c=relaxed/simple;
	bh=7dBva3VtZP4AKj7So2nUSvx+KxlJqb30CCzPm9mvyec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzuKi2AgTNuAvsW5mQCWcYjg8G6BF4Mb2fiX31LlLaLG85n4yGEALahAjdKNuX+pFNfdaIvdWjarC51DCtzhwet6WpoNRdfr3VGNzF635feGQo19pKXEUObDqogCUQwHK+7MEUjeh3F9CVaRtDWnWztW4e+Ti9UGh9BFLgzElEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bplN164b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FxuL+eFG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bplN164b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FxuL+eFG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7E7321166;
	Tue,  3 Dec 2024 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733232742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYzXnKehfIU28laXyz2nR7XnSwW3vsPBzROaW+SYIBc=;
	b=bplN164bETmPHUoP7iZoA7j7T9mHRv5HmEb5svi0BDFjTkU9OcN0oD6JRSqmb/L2Tp9Qoh
	uNFyiWBDTKyOVMlgulztv6g9GHRgwGcWc5NgbNHd28WpX17dD0hNZE3xVFDVk1tz8Wjqy/
	408HCAqEnwgrDJliHvxeXyUFD5TLuiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733232742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYzXnKehfIU28laXyz2nR7XnSwW3vsPBzROaW+SYIBc=;
	b=FxuL+eFGyuocRThHTIynUeDZ91aSObypXM/NXnS7RDrL6njMYMPZCEm+haqm/irT04ZCFw
	zCFoyXpXKHp4/XDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733232742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYzXnKehfIU28laXyz2nR7XnSwW3vsPBzROaW+SYIBc=;
	b=bplN164bETmPHUoP7iZoA7j7T9mHRv5HmEb5svi0BDFjTkU9OcN0oD6JRSqmb/L2Tp9Qoh
	uNFyiWBDTKyOVMlgulztv6g9GHRgwGcWc5NgbNHd28WpX17dD0hNZE3xVFDVk1tz8Wjqy/
	408HCAqEnwgrDJliHvxeXyUFD5TLuiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733232742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYzXnKehfIU28laXyz2nR7XnSwW3vsPBzROaW+SYIBc=;
	b=FxuL+eFGyuocRThHTIynUeDZ91aSObypXM/NXnS7RDrL6njMYMPZCEm+haqm/irT04ZCFw
	zCFoyXpXKHp4/XDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC1D213A15;
	Tue,  3 Dec 2024 13:32:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y+J5KWYIT2d+IQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 03 Dec 2024 13:32:22 +0000
Message-ID: <48096e18-6e68-4844-904d-ada10e071f46@suse.cz>
Date: Tue, 3 Dec 2024 14:32:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 2/6] mm/page_isolation: don't pass gfp flags to
 start_isolate_page_range()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-3-david@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20241203094732.200195-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 12/3/24 10:47, David Hildenbrand wrote:
> The parameter is unused, so let's stop passing it.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


