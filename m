Return-Path: <linux-kernel+bounces-557394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA869A5D855
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1DC3B0DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F0A23536B;
	Wed, 12 Mar 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="udsTIskL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RlNclRxr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="udsTIskL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RlNclRxr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B7423278D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768660; cv=none; b=uVx9puFpLjgNi06o4E95oGwC9IFruWHaDbTZx1y3XLcB/arnZRdG7mj3FtxfQ1suAjMdMCp5EuCdDszrlt49tb/OqD4HrF1IR1ndMj2SfUlCeXXyL4rB8a15OIwNZ+/FO+dYv3T67SdESvOFLHVExcU1HSdmj/jMrEZ+43g32gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768660; c=relaxed/simple;
	bh=2wbiqFqqWZMjSHcLrYzN3FIwQO0Lt39FnojFVkME+8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkAwuUcfvT9a1Qw4o2YJb5YCHZA0iOFYwJ7l2qjNbipElGIfhPu0pkGGTJxxOFay19/e+6/+yYfXuqepp39GEjLT18nZyzq5lUOcxYuOt2ExT2PxlW/4nQk7tDQtWCQK+XaOi0dtE9ZFwLO/RRIdH8uMyDLtCzWD/4/26Z62Jvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=udsTIskL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RlNclRxr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=udsTIskL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RlNclRxr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73A0021125;
	Wed, 12 Mar 2025 08:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741768657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cML1HaDhpWYa4lNsyeiZh6Uj2uXAn/7WR60HtEXBSU=;
	b=udsTIskLFEPzW1RX2Vwr12kVaDq/lwisonjukBuQ7o2eWbloNIUGSJkXYejiWt7AyWLImB
	tQukdc+twxTvIEwbvopsKyiRUC1AGWX7VURNYolm/Txl8y2VofWZ+HdyhQ+qfxq7HwM8Lq
	rYRDCy/myg5NoHcXdMqPnY7XpCqA//g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741768657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cML1HaDhpWYa4lNsyeiZh6Uj2uXAn/7WR60HtEXBSU=;
	b=RlNclRxrD9JNT5ht7MWOzsyavnEBmLiHGOlyrGp9xZl/tyl8Inlq5+dDkZIv51bnrIQzYH
	Qo+jkq30b2P12hCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=udsTIskL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RlNclRxr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741768657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cML1HaDhpWYa4lNsyeiZh6Uj2uXAn/7WR60HtEXBSU=;
	b=udsTIskLFEPzW1RX2Vwr12kVaDq/lwisonjukBuQ7o2eWbloNIUGSJkXYejiWt7AyWLImB
	tQukdc+twxTvIEwbvopsKyiRUC1AGWX7VURNYolm/Txl8y2VofWZ+HdyhQ+qfxq7HwM8Lq
	rYRDCy/myg5NoHcXdMqPnY7XpCqA//g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741768657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cML1HaDhpWYa4lNsyeiZh6Uj2uXAn/7WR60HtEXBSU=;
	b=RlNclRxrD9JNT5ht7MWOzsyavnEBmLiHGOlyrGp9xZl/tyl8Inlq5+dDkZIv51bnrIQzYH
	Qo+jkq30b2P12hCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20727132CB;
	Wed, 12 Mar 2025 08:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9kI1BdFH0WdBAQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 12 Mar 2025 08:37:37 +0000
Date: Wed, 12 Mar 2025 09:37:31 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Liu Ye <liuye@kylinos.cn>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v2] mm/debug: Fix minor issues in mm
Message-ID: <Z9FHy8O154ds0QVK@localhost.localdomain>
References: <20250312032344.297946-1-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312032344.297946-1-liuye@kylinos.cn>
X-Rspamd-Queue-Id: 73A0021125
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Mar 12, 2025 at 11:23:44AM +0800, Liu Ye wrote:
> This patch includes several minor fixes:
> 
> - Simplify compound page judgment conditions.
> - Missing a newline character at the end of the format string.
> 
> Each change is independent.

If each change is indepenent, send a patch per change.

Also CC Willy since he has been dealing with __dump_page lately.

 

-- 
Oscar Salvador
SUSE Labs

