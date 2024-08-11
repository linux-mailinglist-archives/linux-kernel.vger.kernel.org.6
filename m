Return-Path: <linux-kernel+bounces-282176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968F794E07A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540272819D3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 08:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A057200CB;
	Sun, 11 Aug 2024 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VYrvX+u4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NLKNsctY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VYrvX+u4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NLKNsctY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907722318;
	Sun, 11 Aug 2024 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723364384; cv=none; b=RsSI8rITxjPCuyNVlfXt9+OXx52/dBHLH0DkwBGQoSFIEci5OLHvn9DcdJzlOXOaOROPOmjevPFzA1HjRrOi6IYJOB64Cz2FWLXxyNgJ9HoqfTtqrBritPAban4NrxNUMI6GG1SMBJcmnMaDPsGN2+890vNppNtF+nbrO8cZhsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723364384; c=relaxed/simple;
	bh=J/oTH7SbqDYGU2L3X3VBsW81vFLkWXTntqluh6Wj4zU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiXAtuPcxqMtz9EB/jsltMashSClkpB54LxainLJ1ESrpvw51AuBckA8TjTrZ7u1pYTHy1hedwoJWRZPy1hk9OoXzYgdpTxsD8yEKTKMOAXtQbx0EG5sVl6JtY4H/mp7dC0T2EW9SjsWht2Y8bJK2Y0ToWHNatNgM24tO0/4uwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VYrvX+u4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NLKNsctY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VYrvX+u4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NLKNsctY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 415B31F8CD;
	Sun, 11 Aug 2024 08:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723364380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhdX4OmzmGa+AI7l1skQVviwc0dFYFUY5L46RBOYieo=;
	b=VYrvX+u4J8WeAIudYTpNefB27erlw5U1fl86U7N9eEpqkh0//ef2bQ4VXQCaYxSYJdsIaE
	93oNAYxL59FEbVjIdev/j6tm7zPpfaXsgRB71hTcPPvYur//+oEn81Ht0ifVuRioOrptxb
	GySgE8y3yF9r8Yr9vr5cqz7br0BZUHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723364380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhdX4OmzmGa+AI7l1skQVviwc0dFYFUY5L46RBOYieo=;
	b=NLKNsctYfREtK7wl8dKlJhgAvyxr072KZg9IwL/wy1PYKAbIDE/TvxYH8eoNZArOYSyrHD
	QCDyMPjRPL01dqDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VYrvX+u4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NLKNsctY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723364380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhdX4OmzmGa+AI7l1skQVviwc0dFYFUY5L46RBOYieo=;
	b=VYrvX+u4J8WeAIudYTpNefB27erlw5U1fl86U7N9eEpqkh0//ef2bQ4VXQCaYxSYJdsIaE
	93oNAYxL59FEbVjIdev/j6tm7zPpfaXsgRB71hTcPPvYur//+oEn81Ht0ifVuRioOrptxb
	GySgE8y3yF9r8Yr9vr5cqz7br0BZUHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723364380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhdX4OmzmGa+AI7l1skQVviwc0dFYFUY5L46RBOYieo=;
	b=NLKNsctYfREtK7wl8dKlJhgAvyxr072KZg9IwL/wy1PYKAbIDE/TvxYH8eoNZArOYSyrHD
	QCDyMPjRPL01dqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA1AF13704;
	Sun, 11 Aug 2024 08:19:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R4v4Lxt0uGYYVwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 11 Aug 2024 08:19:39 +0000
Date: Sun, 11 Aug 2024 10:20:19 +0200
Message-ID: <87r0avjwsc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?GB2312?B?uvrBrMfa?= <hulianqin@vivo.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	"perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"mbarriolinares@gmail.com" <mbarriolinares@gmail.com>,
	"wangdicheng@kylinos.cn" <wangdicheng@kylinos.cn>,
	"sean@mess.org"
	<sean@mess.org>,
	"alexander@tsoy.me" <alexander@tsoy.me>,
	"xristos.thes@gmail.com" <xristos.thes@gmail.com>,
	"knuesel@gmail.com"
	<knuesel@gmail.com>,
	"linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	opensource.kernel
	<opensource.kernel@vivo.com>,
	"akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject: Re: =?GB2312?B?tPC4tDo=?= [PATCH v1] ALSA: usb-audio: Add delay
 quirk for VIVO USB-C-XE710 HEADSET
In-Reply-To: <TYUPR06MB6217A8E5ABC66AECA2598F69D2842@TYUPR06MB6217.apcprd06.prod.outlook.com>
References: <TYUPR06MB6217A8E5ABC66AECA2598F69D2842@TYUPR06MB6217.apcprd06.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.de,perex.cz,suse.com,gmail.com,kylinos.cn,mess.org,tsoy.me,vger.kernel.org,vivo.com,linux-foundation.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: 415B31F8CD

On Sun, 11 Aug 2024 06:19:55 +0200,
ºúÁ¬ÇÚ wrote:
> 
> From: Lianqin Hu <hulianqin@vivo.com>
> 
> Audio control requests that sets sampling frequency sometimes fail on
> this card. Adding delay between control messages eliminates that problem.
> 
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> ---
> v1:
>   - Modify the code position and sort by ID

A new patch shouldn't be a reply.  The Subject line contains a prefix
'´ð¸´:' which makes it invalid for tools.
Please submit from a new thread, not as a reply.


thanks,

Takashi

