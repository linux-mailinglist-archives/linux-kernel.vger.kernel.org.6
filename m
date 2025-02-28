Return-Path: <linux-kernel+bounces-538697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2A1A49C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937B5189535B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B664226E636;
	Fri, 28 Feb 2025 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IQyT3UtT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RHY54wjV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IQyT3UtT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RHY54wjV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9249825DB1E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753086; cv=none; b=fm+kwRc+TOy8BmyX1n1l8LHesu4pon8EdoQOQIqYW5Iwhe1JiaoKDMIW2vSufM3gcmd+Buj3BBC7+diBRO393o2oEcijO0RBucQNG+vdOH4CVe8RaxQSUyeI7sEZulEj+2nNw59VPjanj3z68VH+z7/ypopklnaR6AiNdIicPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753086; c=relaxed/simple;
	bh=nUk6SUrdY4aUpslHGVCo2dqPiYq4ZEyTeRGdaNOXMM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRz2RsSQ3cQidfHGK9Y9ZrMe4QOHT0u+dFrCeJH57vgsKd7wJz/KYf+xYQ7nDkQ68vGVKZW8tSq5OHYmlPZMJ32In2wW1OAqDI/o+254WQYCvGjh+myXMObr9HBbKCrLbiBZ0bjV3YADY9a3pwyxEkRZIEOGAezUqlAlaXFgtNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IQyT3UtT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RHY54wjV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IQyT3UtT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RHY54wjV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A2091F37E;
	Fri, 28 Feb 2025 14:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740753082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMLGrhDi6I//lMI70sCRAXVQHhjEiCASJ/hozkyQ65E=;
	b=IQyT3UtTBrut9gl6hUC3wLMpvrfJYYd5ZPs95v6dOCztxJGZjLDmx+SlzhgyVdTAR6UlQD
	DR4kNBRe8/zHjC279NFxn83Y5sEZv998e6Tar5hbdFG4iIhbcjyTls8Ebhd9b4RkDdM+HQ
	RH8a75M3cjZgb8BLar3iXz5b5p0hlDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740753082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMLGrhDi6I//lMI70sCRAXVQHhjEiCASJ/hozkyQ65E=;
	b=RHY54wjV1LBMfN5p7wDFT+hjqV92hJshVP5jcLxwfUw41k/p2cOX6XYj+1QFR7Qbk/6QPB
	nYz0hnYq+7LXZJBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IQyT3UtT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RHY54wjV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740753082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMLGrhDi6I//lMI70sCRAXVQHhjEiCASJ/hozkyQ65E=;
	b=IQyT3UtTBrut9gl6hUC3wLMpvrfJYYd5ZPs95v6dOCztxJGZjLDmx+SlzhgyVdTAR6UlQD
	DR4kNBRe8/zHjC279NFxn83Y5sEZv998e6Tar5hbdFG4iIhbcjyTls8Ebhd9b4RkDdM+HQ
	RH8a75M3cjZgb8BLar3iXz5b5p0hlDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740753082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMLGrhDi6I//lMI70sCRAXVQHhjEiCASJ/hozkyQ65E=;
	b=RHY54wjV1LBMfN5p7wDFT+hjqV92hJshVP5jcLxwfUw41k/p2cOX6XYj+1QFR7Qbk/6QPB
	nYz0hnYq+7LXZJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B23E137AC;
	Fri, 28 Feb 2025 14:31:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7EopHbrIwWdZNwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 28 Feb 2025 14:31:22 +0000
Date: Fri, 28 Feb 2025 15:31:22 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] nvmet-fcloop: track tport with ref counting
Message-ID: <771a6319-75cc-4026-9c7f-d2c31f303bf5@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-5-c0bd83d43e6a@kernel.org>
 <ceb7e531-cc0b-4a4a-a97d-c578daf9d5b2@suse.de>
 <adb0bdc1-f4be-4004-8651-7f8393276f46@flourine.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb0bdc1-f4be-4004-8651-7f8393276f46@flourine.local>
X-Rspamd-Queue-Id: 8A2091F37E
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
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Feb 28, 2025 at 09:30:42AM +0100, Daniel Wagner wrote:
> On Fri, Feb 28, 2025 at 08:27:40AM +0100, Hannes Reinecke wrote:
> > >   	if (!tport->remoteport) {
> > >   		tls_req->status = -ECONNREFUSED;
> > >   		spin_lock(&tport->lock);
> > >   		list_add_tail(&tls_req->ls_list, &tport->ls_list);
> > >   		spin_unlock(&tport->lock);
> > > -		queue_work(nvmet_wq, &tport->ls_work);
> > > +		if (queue_work(nvmet_wq, &tport->ls_work))
> > > +			fcloop_tport_get(tport);
> > 
> > Don't you need to remove the 'tls_req' from the list, too, seeing that
> > it'll never be transferred?
> 
> Good point. I'll add the error handling.

In fact, I think a WARN_ONCE is the better choice here, as the element
should not be on the list (an error in the code) and queue_work will only
return false if the work item is already scheduled.

