Return-Path: <linux-kernel+bounces-566282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834FFA675CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B063A9B11
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E920E03C;
	Tue, 18 Mar 2025 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v9hqxq63";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0+KX8ytf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v9hqxq63";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0+KX8ytf"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CDB20DD71
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306496; cv=none; b=WBVsnQWriDvxQwEQXixfkneIzT1KTwonyck0n5drdufRcHvwpOS85FtZQfM/HrJS/7bAfqHme4xPiJbWK+jYq44vZTz4RLaDQBbTp0QsI9KimyQQo/85z5laFrlmKUvykb3Dt514gj1p7tRofcQ8hI+CjKrwRMAP3EQSs95U/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306496; c=relaxed/simple;
	bh=BDaWRU99uiV2M6mUh3+uoHB8WVlTs2nkHZItIDLjaHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZgpSLWex9d63NnAq0oQXjksk1Mnq26ZxJdvgKT/ZMtC7FJQ2n8WpDTXocvBHfQ21B0OzcCf6OYkz5qUMV2ZCMw2qnLvbw29tSti66BwxSw9p5Mk4DQU3BFT97QpFG4NMR2Qb1sf94KU9Ds9QEsugGgi0Jlm+sJyu0y+ZtNmSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v9hqxq63; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0+KX8ytf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v9hqxq63; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0+KX8ytf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CB011FD16;
	Tue, 18 Mar 2025 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742306492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWr7o71sQMwFqcKXA8+RJoouKBa8brCDPFdGjvFtJOs=;
	b=v9hqxq63DCxLTradvk/kwqurZlTJk+077UFHE/GHhtN9JKCtoz+AUMe74KaF/jBDD/9eZW
	I1fI7soJi0CR6JaZFIUtUspE/KS6qBu1rh6IHI3tRolj6fZp3CFC7vHBLSeteOq0Gjfk7c
	eU/QqaLdf7CUeehpYjNJ8oeD67J9l+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742306492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWr7o71sQMwFqcKXA8+RJoouKBa8brCDPFdGjvFtJOs=;
	b=0+KX8ytfF0yZw007bk9QxkJYretMKbViZ8s9sjUpLRUKogNStSL/X0YysMoXNMrlY4N9QE
	Y/DK4qT4Ggd03BAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=v9hqxq63;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0+KX8ytf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742306492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWr7o71sQMwFqcKXA8+RJoouKBa8brCDPFdGjvFtJOs=;
	b=v9hqxq63DCxLTradvk/kwqurZlTJk+077UFHE/GHhtN9JKCtoz+AUMe74KaF/jBDD/9eZW
	I1fI7soJi0CR6JaZFIUtUspE/KS6qBu1rh6IHI3tRolj6fZp3CFC7vHBLSeteOq0Gjfk7c
	eU/QqaLdf7CUeehpYjNJ8oeD67J9l+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742306492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWr7o71sQMwFqcKXA8+RJoouKBa8brCDPFdGjvFtJOs=;
	b=0+KX8ytfF0yZw007bk9QxkJYretMKbViZ8s9sjUpLRUKogNStSL/X0YysMoXNMrlY4N9QE
	Y/DK4qT4Ggd03BAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E660F13A82;
	Tue, 18 Mar 2025 14:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DPhSN7t82WdlAgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 18 Mar 2025 14:01:31 +0000
Date: Tue, 18 Mar 2025 15:01:31 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/18] nvme-fc: do not reference lsrsp after failure
Message-ID: <9ad5635d-48b2-45d5-9ba2-9e1fead2ea14@flourine.local>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-18-05fec0fc02f6@kernel.org>
 <e4d7f84a-dd29-4b7a-a831-a8555125bf43@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d7f84a-dd29-4b7a-a831-a8555125bf43@suse.de>
X-Rspamd-Queue-Id: 0CB011FD16
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,flourine.local:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Mar 18, 2025 at 12:33:22PM +0100, Hannes Reinecke wrote:
>         ret = lport->ops->xmt_ls_rsp(&lport->localport, &rport->remoteport,
>                                      lsop->lsrsp);
>         if (ret) {
>                 dev_warn(lport->dev,
>                         "LLDD rejected LS RSP xmt: LS %d status %d\n",
>                         w0->ls_cmd, ret);
>                 nvme_fc_xmt_ls_rsp_done(lsop->lsrsp);
>                 return;
>         }
> 
> so ->xmt_ls_rsp() would have invalidated one of the arguments.
> Plus 'nvme_fc_xmt_ls_rsp_done()' is now a wrapper around
> 'nvme_fc_xmt_ls_rsp_free()'.
> So why not go the full length and kill nvme_fc_xmt_ls_rsp_done()
> completely?

nvme_fc_xmt_ls_rsp_done will be called when the LS has been processed.
We still need it.

> Hmm?

It is very confusing with all these callbacks and the name scheme.

