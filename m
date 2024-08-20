Return-Path: <linux-kernel+bounces-293742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379089583E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7518287844
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A9118C356;
	Tue, 20 Aug 2024 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T6uX1e1Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qtctbdnX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="njhYoTUj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9bRvnyPf"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C601586F2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148915; cv=none; b=Vkd/Rux+aovAhMXQ3F2fZ+prpws4NGdAoJqyPT7QhK4ivIQ1q29/12nUplhi38GMnXmtqnAyCjmpOmFqVAVJuzIitlOj3h2dpAYgBKMsDmme/1Wc0OBfdrTbUccT30cl4bZdkXYq+EF7nTCtSb73RHYnPLhfPg6AakwatpLqN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148915; c=relaxed/simple;
	bh=dsChw9/xns4xW9F7tQ2Ss8UzMsGHv789hwKND0doFHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2Ei/wruBMIeL5fZkCIIyP8FiOHVCFoLxOl8gwXrLbHw/+NfiZ33xmeSqJ9IZfTJXxKLiLW14aVBeOU3tWULtNaMVjr3tpXMCjMntbbyEQi88PPG3wj8XAq8jXaivP0wcPDajzdZxLfkClt4899Is7vV6R64G3Va8ekKKH5Qlz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T6uX1e1Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qtctbdnX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=njhYoTUj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9bRvnyPf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 102191FFCB;
	Tue, 20 Aug 2024 10:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724148912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+lfdqfFj/R1LaWHAGnf3jFlwh1vTl96qIjSZz7PlMLY=;
	b=T6uX1e1QXt/ujB9hYSC7osZUi0a5Q7Mj57iImKBfzq/Stav8sDQRWNGdx34CJzltPBM5zR
	emjQRwp8UrL0taswO64KvKNycb2OvydMeNuoXXB0aHW/Y4bFyVyTgL9zXsFMe2RO6y6kL+
	wi2kfe3ehsDDiA/h598nvl3jsrD2Vuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724148912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+lfdqfFj/R1LaWHAGnf3jFlwh1vTl96qIjSZz7PlMLY=;
	b=qtctbdnXQpxFAPXYh2H1xmKHIIbt7zQO6AZDTd+QUly2Fg1oXqd/mSJh6g+0v5LKQ7+QOr
	ceOP6bwGo/L8eRDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=njhYoTUj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9bRvnyPf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724148911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+lfdqfFj/R1LaWHAGnf3jFlwh1vTl96qIjSZz7PlMLY=;
	b=njhYoTUjIMMRYCaCxp2wULPnYBZGz8kvhWz16IzJZuYtzWpSY7zZYIvlrPK3NG6l+muG5c
	+hzz7ZICYnAHRdCYrJDSb8IAVzLj2BDGaoBEnYMmN6tQYhbUneglbvN+q7LmVYlLrrVuD4
	gZKP0BINuneR6l3WvKtNvXM0Jep1nMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724148911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+lfdqfFj/R1LaWHAGnf3jFlwh1vTl96qIjSZz7PlMLY=;
	b=9bRvnyPf1chMGZ7oTe9RdooRHOd6UUPcse6Mn3PpzX+cEiCPD6yYwqbDpFJsYQqVbjb8a6
	r8BOvXIPACwJcUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E788D13A17;
	Tue, 20 Aug 2024 10:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XIbsNa5sxGbtUQAAD6G6ig
	(envelope-from <iivanov@suse.de>); Tue, 20 Aug 2024 10:15:10 +0000
Date: Tue, 20 Aug 2024 13:20:05 +0300
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: corey@minyard.net
Cc: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi:ssif: Exit early when there is a SMBus error
Message-ID: <20240820102005.4l2j73jpt7lmwloh@localhost.localdomain>
References: <20240816065458.117986-1-iivanov@suse.de>
 <Zr+Up+94gmPEHwcJ@mail.minyard.net>
 <84eb700ee647cc40e9e99b086a8648e3@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84eb700ee647cc40e9e99b086a8648e3@suse.de>
X-Rspamd-Queue-Id: 102191FFCB
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,localhost.localdomain:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 08-18 12:27, Ivan T. Ivanov wrote:
> 
> > 
> > 3) It appears the response to the GET_DEVICE_ID command, though a
> > response is returned, is not valid.  The right way to handle this would
> > be to do more validation in the ssif_detect() function.  It doesn't do
> > any validation of the response data, and that's really what needs to be
> > done.
> > 
> 
> do_cmd() in ssif_detect() already do validation. Perhaps,
> ssif_probe() should just not return ENODEV in case of error.
> 

Oh, I wanted to say ssif_detect, not ssif_probe. 

Regards,
Ivan


