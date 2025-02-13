Return-Path: <linux-kernel+bounces-512572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4232A33AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742493AA863
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A114212D8D;
	Thu, 13 Feb 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vjWXI/Io";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E7gbKSHO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vjWXI/Io";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E7gbKSHO"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E0620E6F9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438090; cv=none; b=qYkHjR2lQk9Jm6ePxYT5v2MRjnLWM18N5uSUyX0SX/G9QUtHkYds9oUrd2LCagrzw+Qr4yXUZo5Ud3/aBZSPqRdrDAgJPXTmuzKTWaq8oe+UacIXqanBfEwGmxsa4/oWwfJ4op0mIxSs2sT5m1ikTNb3QtimlETmoufOQBC6tTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438090; c=relaxed/simple;
	bh=92IBaEFCeb59c1L/Dvak6FygRZtPJWtnPcxYGLuUZbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1KQT0fTsORhx4VAskmf6xSM3DjJqDFShFDsCLlYqKL/AbFi+KgndzPjoA+2ICzuYW3/YvxgdDD0atEzaxAlRR5tnVVaS+iOyxTmiN+NW7QS+gPm3RbGyiVpFZ9DvCI9BjQG2CekyN5/Aml9/VX82ZxtCW7CVVzFfkGuJB3RPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vjWXI/Io; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E7gbKSHO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vjWXI/Io; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E7gbKSHO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4BB91FB6C;
	Thu, 13 Feb 2025 09:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739438086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlhAx95V05ksFYdiTUnLZGUxdkhjoMbHS0kdh8Y7vzk=;
	b=vjWXI/Iokcxl66jyxMHHRmQUExJDlH+8uVTdSL0KiwI/1pFACaZL4v+lWLytkRLBIqZT8n
	r1K9HEOSDmXvWOLRLoC0WV4Vw2IAopMesfTtTLxAdqeZCufcCeSGPFt0wRubqabsjGvNEV
	6A+kwnNAJ9bmXVvKERiTEpjzmz5HOZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739438086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlhAx95V05ksFYdiTUnLZGUxdkhjoMbHS0kdh8Y7vzk=;
	b=E7gbKSHOIaPLeFNgb4YZg6Cv826KzB9a4rmQjasvHjlS66YdJFaBzG7dBZqWYzHdQ5npW5
	lgH4YAoQQz4EU4Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="vjWXI/Io";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=E7gbKSHO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739438086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlhAx95V05ksFYdiTUnLZGUxdkhjoMbHS0kdh8Y7vzk=;
	b=vjWXI/Iokcxl66jyxMHHRmQUExJDlH+8uVTdSL0KiwI/1pFACaZL4v+lWLytkRLBIqZT8n
	r1K9HEOSDmXvWOLRLoC0WV4Vw2IAopMesfTtTLxAdqeZCufcCeSGPFt0wRubqabsjGvNEV
	6A+kwnNAJ9bmXVvKERiTEpjzmz5HOZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739438086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlhAx95V05ksFYdiTUnLZGUxdkhjoMbHS0kdh8Y7vzk=;
	b=E7gbKSHOIaPLeFNgb4YZg6Cv826KzB9a4rmQjasvHjlS66YdJFaBzG7dBZqWYzHdQ5npW5
	lgH4YAoQQz4EU4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C257413874;
	Thu, 13 Feb 2025 09:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CzOHLga4rWd1fAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 13 Feb 2025 09:14:46 +0000
Date: Thu, 13 Feb 2025 10:14:46 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, hch <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] nvme-fc: do not ignore connectivity loss during
 connecting
Message-ID: <6b6fea1e-671c-4a6a-98ba-a27bb2a4a95a@flourine.local>
References: <20250109-nvme-fc-handle-com-lost-v4-0-fe5cae17b492@kernel.org>
 <20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org>
 <denqwui6sl5erqmz2gvrwueyxakl5txzbbiu3fgebryzrfxunm@iwxuthct377m>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <denqwui6sl5erqmz2gvrwueyxakl5txzbbiu3fgebryzrfxunm@iwxuthct377m>
X-Rspamd-Queue-Id: D4BB91FB6C
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Feb 13, 2025 at 07:16:31AM +0000, Shinichiro Kawasaki wrote:
> On Jan 09, 2025 / 14:30, Daniel Wagner wrote:
> > When a connectivity loss occurs while nvme_fc_create_assocation is
> > being executed, it's possible that the ctrl ends up stuck in the LIVE
> > state:
> >
> [...]
> > 
> > There is already the ASSOC_FAILED flag to track connectivity loss event
> > but this bit is set too late in the recovery code path. Move this into
> > the connectivity loss event handler and synchronize it with the state
> > change. This ensures that the ASSOC_FAILED flag is seen by
> > nvme_fc_create_io_queues and it does not enter the LIVE state after a
> > connectivity loss event. If the connectivity loss event happens after we
> > entered the LIVE state the normal error recovery path is executed.
> 
> I found many test cases in blktests nvme group fail with v6.14-rc2 kernel with
> fc transport. I bisected and found this patch, as the commit ee59e3820ca9, is
> the trigger. When I revert the commit from v6.14-rc2, the failure disappears.
> 
> Here I share the kernel message log observed at the test case nvme/003. The
> kernel reported "BUG: sleeping function called from invalid context".

Thanks for digging into it.

The problem is that the patch moves the nvme_change_ctrl_state call
under the ctrl->lock and nvme_change_ctrl_state is also
cancel_delayed_work_sync which doesn't work:

  spin_lock_irqsave
    nvme_change_ctrl_state
      nvme_stop_failfast_work
        cancel_delayed_work_sync

I've checked if there is another caller of nvme_change_ctrl_state is
taking a lock, all looks fine. If there would be way to move the
failfast code bits out of the nvme_change_ctrl_state function would be a
nice solution.

That means the idea to synchronize the state change with the
ASSOC_FAILED bit under the lock is not going to work. I am trying to
figure out a solution.

