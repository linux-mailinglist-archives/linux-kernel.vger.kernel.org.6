Return-Path: <linux-kernel+bounces-448828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF3A9F4622
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BEC3188CC75
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B461DB92A;
	Tue, 17 Dec 2024 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gSibJZUt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="llS1gONu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gSibJZUt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="llS1gONu"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7936A1D5AD1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424524; cv=none; b=FT14qEw7w0onaK6233t17uTuiZHCC3CDUITn+wHHaJhrVQbBeCkc7wQD0o10tDM2H35Bx9WU7PPCa6Z+iuXc4132BE5dj7y46+gj+w/9XK6PQQWVhMuGbuaxgG0HarhugxeEAJZg+51+CVTDXJ6xvSJSCBl3i/3k8Ivqbf3T4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424524; c=relaxed/simple;
	bh=JPoOy3nthwNOBCGjUshID+CTYrUOkCC0HSnxnNjeIhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9lXYFjyMSR+6ZLPvsTgf1cJY9wj0/VkX3CnGmCxB9/Syt6+j5d5F04Be2JsyUxE6t9In7NXaCY3P92ApTxTWnmmKpTt/t34fA/eZqlF9lqMjijNlJze/AM5S48/CgKiM7kywKgZDwzHKuj6flsIdxcuWfvPNFvAjsJTGHvZ7PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gSibJZUt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=llS1gONu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gSibJZUt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=llS1gONu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52A6F1F395;
	Tue, 17 Dec 2024 08:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734424520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01Q64F9KTf+PicDnwbH51hugRA1VlP8bh1nrgdSZkLg=;
	b=gSibJZUteznBOl6KyxEb22KP7q8MP/I4ZTBvNW84XNDh0A7ygcQt6U25KXvv4pfSdHbonC
	KX1iB3vsDi4CcDpiBbtSk9WEJurzIK/Oyjf132E2ETVxOKQD5LPQD6Nr0GMA17w1eiemer
	ZhFasOrNUGxGtY0r/lfk4qRPVLuAQic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734424520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01Q64F9KTf+PicDnwbH51hugRA1VlP8bh1nrgdSZkLg=;
	b=llS1gONuEeSJfHjELm33FLRhC08nIDfuA9Nw/FuO7UxP7TkgaLkuqcV17wyrIdieQ56qz8
	gcOWU0KC9DhocICA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gSibJZUt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=llS1gONu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734424520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01Q64F9KTf+PicDnwbH51hugRA1VlP8bh1nrgdSZkLg=;
	b=gSibJZUteznBOl6KyxEb22KP7q8MP/I4ZTBvNW84XNDh0A7ygcQt6U25KXvv4pfSdHbonC
	KX1iB3vsDi4CcDpiBbtSk9WEJurzIK/Oyjf132E2ETVxOKQD5LPQD6Nr0GMA17w1eiemer
	ZhFasOrNUGxGtY0r/lfk4qRPVLuAQic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734424520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01Q64F9KTf+PicDnwbH51hugRA1VlP8bh1nrgdSZkLg=;
	b=llS1gONuEeSJfHjELm33FLRhC08nIDfuA9Nw/FuO7UxP7TkgaLkuqcV17wyrIdieQ56qz8
	gcOWU0KC9DhocICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30563132EA;
	Tue, 17 Dec 2024 08:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lu6YCcg3YWf5HQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 17 Dec 2024 08:35:20 +0000
Date: Tue, 17 Dec 2024 09:35:19 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Paul Ely <paul.ely@broadcom.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
Message-ID: <bef1a7ac-2614-4a70-945d-e691e9107089@flourine.local>
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
 <e89d0b3b-e4a1-4ae5-8250-c15e3a843e76@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89d0b3b-e4a1-4ae5-8250-c15e3a843e76@suse.de>
X-Rspamd-Queue-Id: 52A6F1F395
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,flourine.local:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, Nov 29, 2024 at 12:10:33PM +0100, Hannes Reinecke wrote:
> > +	/*
> > +	 * It's either a kernel error or the host observed a connection
> > +	 * lost. In either case it's not possible communicate with the
> > +	 * controller and thus enter the error code path.
> > +	 */
> > +	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
> >   		return status;
> >   	/*
> > 
> Hmm. Maybe checking for NVME_SC_DNR, too?

if no one complains I'll update the check to:

	if (status < 0 || (status > 0 && (status & NVME_STATUS_DNR)) ||
	    status == NVME_SC_HOST_PATH_ERROR)
		return status;

okay?

