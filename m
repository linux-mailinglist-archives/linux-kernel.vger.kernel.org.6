Return-Path: <linux-kernel+bounces-556401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BC2A5C6B6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2095F164E78
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE30225DD06;
	Tue, 11 Mar 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V61EZph/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8vov8tjM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V61EZph/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8vov8tjM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22CA846D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706708; cv=none; b=gaHTkghcrpUaUs1xLmL0TF3WBMYKBSfOzMbZZLte1a86lwRKjmiG/Awt15V9wEema33Oc5VlioiLlgJlpVE3pjhy30hYBrjyD/UTC7eRaYttHh7gsVqJ3Ye731kzG87SLrH5uCSAHy2fg6MzhxcNzqDUTHu/outeuE9kPh0yA0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706708; c=relaxed/simple;
	bh=GuS748bHNIZWY2yvXfgc1D7SOWu0vbLuPh5n3pXHbCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSBPA7+RzLptMuec6IyvzXopmJQOgQyNcOLXlk92da6W9z+wCUq2I8K1j5V9BTeUoWDa1xVzeyGT0t2zo+5edL+6p8bqBEqYwmBIe9tS0SYtsLwOb2gY7V2VDZiMubpgQ9hQl6qltQlGJ4OrP1OREV/wO0Km46t6qa6RQNA2XF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V61EZph/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8vov8tjM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V61EZph/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8vov8tjM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7AF41F388;
	Tue, 11 Mar 2025 15:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741706704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=POc6T+mAoJ4qDMhcmbOtW7KExFZF7URkjUCqOS4qsXo=;
	b=V61EZph/Y76ROrq5uN8vo4cHNsoCtJuiJMzhOID5nvyW/tTDUkADof1iCJW9pRB4YvOCr3
	T5QbnW15Sekt/sj38/DwTIv9uWhPAsA6pjypFnvfxmkH1sGqzKzc6gEbt5QKOupHGAWdKy
	FR/mhYOQWor/y9zjNi6JK+r03taZphI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741706704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=POc6T+mAoJ4qDMhcmbOtW7KExFZF7URkjUCqOS4qsXo=;
	b=8vov8tjMk8sg0VFc6CkonkGqVOm1sOfopgaPvkSYJ6+ZwoQBN8Q4dlh5gI6aD6PGUu1EM2
	mUTRztpupOxAqqDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="V61EZph/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8vov8tjM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741706704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=POc6T+mAoJ4qDMhcmbOtW7KExFZF7URkjUCqOS4qsXo=;
	b=V61EZph/Y76ROrq5uN8vo4cHNsoCtJuiJMzhOID5nvyW/tTDUkADof1iCJW9pRB4YvOCr3
	T5QbnW15Sekt/sj38/DwTIv9uWhPAsA6pjypFnvfxmkH1sGqzKzc6gEbt5QKOupHGAWdKy
	FR/mhYOQWor/y9zjNi6JK+r03taZphI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741706704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=POc6T+mAoJ4qDMhcmbOtW7KExFZF7URkjUCqOS4qsXo=;
	b=8vov8tjMk8sg0VFc6CkonkGqVOm1sOfopgaPvkSYJ6+ZwoQBN8Q4dlh5gI6aD6PGUu1EM2
	mUTRztpupOxAqqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33674134A0;
	Tue, 11 Mar 2025 15:25:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id beSPCNBV0GfiawAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 11 Mar 2025 15:25:04 +0000
Date: Tue, 11 Mar 2025 16:24:54 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Gavin Shan <gshan@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	akpm@linux-foundation.org, shan.gavin@gmail.com
Subject: Re: [PATCH v2 2/3] drivers/base/memory: Improve
 add_boot_memory_block()
Message-ID: <Z9BVxpyi_FUCnig3@localhost.localdomain>
References: <20250311004657.82985-1-gshan@redhat.com>
 <20250311004657.82985-3-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311004657.82985-3-gshan@redhat.com>
X-Rspamd-Queue-Id: C7AF41F388
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,redhat.com,linuxfoundation.org,kernel.org,linux-foundation.org,gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,localhost.localdomain:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Tue, Mar 11, 2025 at 10:46:56AM +1000, Gavin Shan wrote:
> It's unnecessary to count the present sections for the specified
> block since the block will be added if any section in the block
> is present. Besides, for_each_present_section_nr() can be reused
> as Andrew Morton suggested.
> 
> Improve by using for_each_present_section_nr() and dropping the
> unnecessary @section_count.
> 
> No functional changes intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs

