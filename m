Return-Path: <linux-kernel+bounces-322899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9779732B6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424641F224B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B5419994B;
	Tue, 10 Sep 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qFPjlhpL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NmB4QdfZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qFPjlhpL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NmB4QdfZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3A199920
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963589; cv=none; b=oryX9LYls+goN5l/7O+RY9fh8VNLL+qWI2uI/4GzRXWNM82ZysvbcmI8guJXMmTL9CAEJGTyMHEEyRrrJjAXCb9TJUwTxkTbcVrtDT3rNPRZ1aGpIaSAyXokwe7eVO4vDFaAu0T72Knj0bC0bqgTrzI9Qmw2gcnbyZx5TZgaEWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963589; c=relaxed/simple;
	bh=LEwgT1CUdMGxMTx2CBj6jmHHPJejQp1TnXVmhR6DgX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAj6nfaPX14GP+8ahFGcdOPg/norkhBaE1aBjQgKbnyDdZJ5SvJtuaaCs1ZEVCLPNeOYGKITfGMYgM6oVc2f1n+uEztgXnwCJcCJFSaLDDHVz4IyUf2xvU+fpBJOGu1LWISpP25aDYjJ3B/dSMvOEr+/rlHpnwSZxWUVtIZAwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qFPjlhpL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NmB4QdfZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qFPjlhpL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NmB4QdfZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9829421A2A;
	Tue, 10 Sep 2024 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725963585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsSIwaqc0VB7URYBD4dQqIcMT8+sfQC9FPAWs4P+03A=;
	b=qFPjlhpLpAmdzqW1Vt/FFYP7HvMm5q554lNQTOTdByCf7d0wPXb3gp6wSdPS3BMQBFbGdb
	YPjyMY5scX42C1ubj8ykHLyH0EwoGdHYWTUavsHE3y0Mw+I6O83WRXRhLm2vpq1WyxPWYz
	GUkndQoe4J+ZKFyxhSR0HJqfl5Zb7Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725963585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsSIwaqc0VB7URYBD4dQqIcMT8+sfQC9FPAWs4P+03A=;
	b=NmB4QdfZe40w7/v78v15mXtDZYcWuiWoKjfcwBGP8IIDK+eTnrAWWnf38wKBavrc5W6wDj
	l2a9d8k3Fwyi7mAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qFPjlhpL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NmB4QdfZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725963585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsSIwaqc0VB7URYBD4dQqIcMT8+sfQC9FPAWs4P+03A=;
	b=qFPjlhpLpAmdzqW1Vt/FFYP7HvMm5q554lNQTOTdByCf7d0wPXb3gp6wSdPS3BMQBFbGdb
	YPjyMY5scX42C1ubj8ykHLyH0EwoGdHYWTUavsHE3y0Mw+I6O83WRXRhLm2vpq1WyxPWYz
	GUkndQoe4J+ZKFyxhSR0HJqfl5Zb7Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725963585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsSIwaqc0VB7URYBD4dQqIcMT8+sfQC9FPAWs4P+03A=;
	b=NmB4QdfZe40w7/v78v15mXtDZYcWuiWoKjfcwBGP8IIDK+eTnrAWWnf38wKBavrc5W6wDj
	l2a9d8k3Fwyi7mAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F8C9132CB;
	Tue, 10 Sep 2024 10:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8r7eHEEd4Ga2XQAAD6G6ig
	(envelope-from <iivanov@suse.de>); Tue, 10 Sep 2024 10:19:45 +0000
Date: Tue, 10 Sep 2024 13:25:31 +0300
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi:ssif: Improve detecting during probing
Message-ID: <20240910102531.grjtn2rdmagcgphb@localhost.localdomain>
References: <20240816065458.117986-1-iivanov@suse.de>
 <ZsU9SRlQgzQn8bDs@mail.minyard.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsU9SRlQgzQn8bDs@mail.minyard.net>
X-Rspamd-Queue-Id: 9829421A2A
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi Corey,

On 08-20 20:05, Corey Minyard wrote:
> 
> If an IPMI SSIF device is probed and there is something there, but
> probably not an actual BMC, the code would just issue a lot of errors
> before it failed.  We kind of need these errors to help with certain
> issues, and some of the failure reports are non-fatal.
> 
> However, a get device id command should alway work.  If that fails,
> nothing else is going to work and it's a pretty good indication that
> there's no valid BMC there.  So issue and check that command and bail
> if it fails.
> 
> Reported-by: Ivan T. Ivanov <iivanov@suse.de>
> Signed-off-by: Corey Minyard <corey@minyard.net>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

Do you plan to merge this fix?

Regards,
Ivan


