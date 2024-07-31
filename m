Return-Path: <linux-kernel+bounces-269367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF2A943214
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E268CB21A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284D71BBBE1;
	Wed, 31 Jul 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iXk3zk9c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ecbcVxn1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LvgIanw4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qx9vmHyB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D91BBBC9;
	Wed, 31 Jul 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436490; cv=none; b=ZtbzYhDmbfqUMvFEL6FV92jTQVTDykUj6qPCu6h7OT5P999hlXeGkqfRlLNH2JV7UaE3Z8LXQcEUr5HMXMVWFk0I5sXkxGpwwxYKEvAWmKaBdnVGqmEm1DWtNi3N2zGBS3wgqd/B7YtkZgbdvPV0ol96ol8iXktf6At8Mtss0cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436490; c=relaxed/simple;
	bh=rF/KoJx6Mv7SSb4ZW4Rik/jXymofGZYQ1Vx3VIYgVqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSU4iVIVoB77fTZZl0cKvdYe6LS+Ri+GL52JDBaXzC/AGfb0A6i/DcZgUJQjqx+eBK0DXu90/PaUJlla4Rn5QDnmNmY9jMIuPLF8yBS9a0g4U5EcaLIp3MjqrK4Lk6feBgVue//KcmGqEmTBD8q8j0wOIMNohKQ6ieFjNzTVV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iXk3zk9c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ecbcVxn1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LvgIanw4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qx9vmHyB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9986521A4B;
	Wed, 31 Jul 2024 14:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722436485;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BNU5wdcqSqIdL9rgOFxNmJ1P6cnpnQAItmiHrNWk580=;
	b=iXk3zk9c8yTT17E3Aa6N+EE459YFJm2sH9xUHyk0yowugqvpI+EW5i9NhB4SPIgp6Fn5j1
	4ByZHBr9MA7fdTEW+nOgyT09PvyervYJ/XN8hW4qhtc1wLvGHj4vmKaHjf9p4l6m+AMahr
	laYssmIbYwOInoByMujccU9KpU48QQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722436485;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BNU5wdcqSqIdL9rgOFxNmJ1P6cnpnQAItmiHrNWk580=;
	b=ecbcVxn1TSEz3dnGrd9kTKB/Mox9dgYqfsEbNYHULnyekrzfG+Mzq62c7Zt2sbPj+H6ulg
	2NU9ZKgQO08tymDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722436484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BNU5wdcqSqIdL9rgOFxNmJ1P6cnpnQAItmiHrNWk580=;
	b=LvgIanw4+4BW9e7ovli5gy24nljpaloRMOs+LCzccsxAJPCBauM0XKbCf6su1sVdtJfEoL
	twPaTz+Ww2bCEL5hbsKb3jmeEZvqF/NgqPF6LqiINebB8cCJB0aEpDnDvXIt6sQPD0XR4U
	YmY4/M6mJXNntSCg96jF5Q4pDuX680k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722436484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BNU5wdcqSqIdL9rgOFxNmJ1P6cnpnQAItmiHrNWk580=;
	b=qx9vmHyBG0n5ZWRKbVj4Z2ZnAaczjlNgwaYfUdi/strYI02GvA62beGEXgNrhhTV00kvcu
	F87SKzwEz7qQZYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FCE513297;
	Wed, 31 Jul 2024 14:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aTz9HoRLqmYqdgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jul 2024 14:34:44 +0000
Date: Wed, 31 Jul 2024 16:34:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-41067: btrfs: scrub: handle RST lookup error correctly
Message-ID: <20240731143441.GO17473@suse.cz>
Reply-To: dsterba@suse.cz
References: <2024072907-CVE-2024-41067-bc18@gregkh>
 <20240729205503.GT17473@twin.jikos.cz>
 <2024073030-vagabond-imprudent-8ea2@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024073030-vagabond-imprudent-8ea2@gregkh>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue, Jul 30, 2024 at 06:53:40AM +0200, Greg Kroah-Hartman wrote:
> > > The Linux kernel CVE team has assigned CVE-2024-41067 to this issue.
> > 
> > Please drop the CVE. It's a fix for feature that's still in development
> > and is not enabled on production kernels (requires CONFIG_BTRFS_DEBUG).
> 
> We do not know people's use case, and can not "gate" CVE ids based on
> difference config options like this.

The use case are early adopters for a known unfinished feature where
instabilty could happen and there are known problems like lockups.  It's
behind the config option for that purpose so bugs are reported but don't
have to be treated as security.

> > There was even a recent on-disk format change (mkfs required), this is
> > not really for environments where security matters. Thanks.
> 
> It's a fix for a vulnerability, so I think it should stay assigned.  If
> your system does not enable that config option, then there is nothing to
> worry about, right?

It's not a vulnerability unless you define that very extensively. My
systems don't enable that, distro kernels don't enable that, so there's
nothing to worry about. Conclusiion is not to assign a CVE, right.
Otherwise it only increases paperwork.

