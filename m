Return-Path: <linux-kernel+bounces-173197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010338BFCDC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA59282682
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F282A839E6;
	Wed,  8 May 2024 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y4uLYFcO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HR8V28Ws";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y4uLYFcO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HR8V28Ws"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8472BB03
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169981; cv=none; b=YaJxXFCebvEBJUq2qMeG5kzl1uSfr8qfvJvmsIxy5mjAkCasbF5P6jD+RTKMDBQ+JdLKNkyeKCbQNRKyCe4WOk4OOiZuD5X9HehzpKTgQTC21vX6v8A+/wRO31grLgEN+/lCFcelpMmWtuSTgZJyh0tv54UrtgmA9AfPffm84wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169981; c=relaxed/simple;
	bh=DAq0FKr/+NmtX+hZwH5MQCoD8HE64LmLJ2RqsXTP3qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKU/e2fWsF0/wc8LFW2/BDVmRcCYcUAzLGM9CE4aHGQfzOY6H13XA73UE7Wz1wHLO9qx9R41C8dZdA7bolXfD/3Bvidc0t8HPASRakvjYsyEAGOztqbnbtmJ/5bBz9gB/hpQ2uZMPtGRPxaFLXJYaPSsEsc5oUvEm46lf0j94RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y4uLYFcO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HR8V28Ws; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y4uLYFcO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HR8V28Ws; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5DD925C957;
	Wed,  8 May 2024 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715169972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68hbW9gYizUDai3T3A56zWcq1/g6QV4Reg9/PJBK5D0=;
	b=y4uLYFcOcTbYI3KtqYZhp0FFKBggqNW8Vc59RUA1bjDtuNaRcfxscx8PGeMqrwcf5sGi1/
	lHob8P23IEy9T0k0aemZM1bxzNsAIniUBP3ieCtayL3I3bR58w8OU2SAw8P3QL8rWr0luS
	7cwx27r2n4ZEfvYrtfaanPag4KCicv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715169972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68hbW9gYizUDai3T3A56zWcq1/g6QV4Reg9/PJBK5D0=;
	b=HR8V28WsE60zZnkVwunurD3a4BqCpYY6I28P7smGWRu0VYst2Zd9KcNLHi/kRfHpHR7YpO
	lhIq0c+POvVIf5AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y4uLYFcO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HR8V28Ws
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715169972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68hbW9gYizUDai3T3A56zWcq1/g6QV4Reg9/PJBK5D0=;
	b=y4uLYFcOcTbYI3KtqYZhp0FFKBggqNW8Vc59RUA1bjDtuNaRcfxscx8PGeMqrwcf5sGi1/
	lHob8P23IEy9T0k0aemZM1bxzNsAIniUBP3ieCtayL3I3bR58w8OU2SAw8P3QL8rWr0luS
	7cwx27r2n4ZEfvYrtfaanPag4KCicv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715169972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68hbW9gYizUDai3T3A56zWcq1/g6QV4Reg9/PJBK5D0=;
	b=HR8V28WsE60zZnkVwunurD3a4BqCpYY6I28P7smGWRu0VYst2Zd9KcNLHi/kRfHpHR7YpO
	lhIq0c+POvVIf5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECE8413A27;
	Wed,  8 May 2024 12:06:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LKroNrNqO2b5UwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 08 May 2024 12:06:11 +0000
Date: Wed, 8 May 2024 14:06:02 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Jane Chu <jane.chu@oracle.com>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/memory-failure: try to send SIGBUS even if unmap
 failed
Message-ID: <Zjtqqs_ImPIn7I-B@localhost.localdomain>
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-2-jane.chu@oracle.com>
 <ZjnuJgUVVnwYrr5p@localhost.localdomain>
 <2f965887-19b5-47bf-98ca-d40b3ec05e75@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f965887-19b5-47bf-98ca-d40b3ec05e75@oracle.com>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5DD925C957
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,linux-foundation.org,kvack.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Tue, May 07, 2024 at 10:54:10AM -0700, Jane Chu wrote:
> I actually managed to hit the re-access case with an older version of Linux
> -
> 
> MCE occurred, but unmap failed,  no SIGBUS and test process re-access
> 
> the same address over and over (hence MCE after MCE), as the CPU
> 
> was unable to make forward progress.   In reality, this issue is fixed with
> 
> kill_accessing_processes().  The comment for this patch refers to comment
> made

So we get a faulty page and we try to unmap it from all processes that
might have it mapped in their pgtables.
Prior to this patch we would kill the processes right away and now we
deliver a SIGBUS.

Seems safe as upon-reaccesing kill_accessing_process() will be called
for already hwpoisoned pages.

I think the changelog could be made more explicit about this scenario
and state the role of kill_accessing_process more clear.

With that: Reviewed-by: Oscar Salvador <osalvador@suse.de>
 

-- 
Oscar Salvador
SUSE Labs

