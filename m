Return-Path: <linux-kernel+bounces-349943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B1E98FDA5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A279A1C215E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED77135A54;
	Fri,  4 Oct 2024 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eFaHnsLn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="usps7IjM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eFaHnsLn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="usps7IjM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5841D5AC1;
	Fri,  4 Oct 2024 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728025495; cv=none; b=PDwj/3T2e6D1gzom2PcZwoHFpLY/yYBODCDXC5SBStvrZTbHiXz314GWH+nSeJnqLyAmqCXVVyqj5vnztkweCPO9tTHr1Icat8t1uqjHVUKUBly9u5fOcRz1fGrL7umAUA87fQSVxRWdM2udXDlkPQzH91P24VWJN30yHifhHSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728025495; c=relaxed/simple;
	bh=02OxzDxOgls4GMwzupW0yz4DITd3y+pOaJC6zYFXW0g=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EceSeVUTmiOqeiVYCH9ztuRpmFqTEwZnMotORtgVTuN4O7+DIa7ipSP3ANrCS7msP48Mj5MWcZghgq26TXcXGTTVYxef7mbWO+2y/HocEzMkjtUfIVnC0f2YRSwr05H//XtE2A2t5yL3hOo/Hv1IG8VN/sMkjVXxPmDUYuyaZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eFaHnsLn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=usps7IjM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eFaHnsLn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=usps7IjM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 115041FEE5;
	Fri,  4 Oct 2024 07:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728025492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2z4otWxjdPcCdjNkRrjOiTHRc7iq16jflnfryrKXjII=;
	b=eFaHnsLnYdZy2PimhDJm+qNMBxNLpV14HT0WyLhiXzQ0M1jmoTQOXg555pJk6XLlZuOZYu
	BpGxZbOL1MzpgDIOAuYwOL1Idq9dhJziQhafXTs9w91qZ5Oc1g5/q9AJZP+1sichxUkQQE
	bp3DS7MkxWzQTbM8l2dSFJbCyhCHoPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728025492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2z4otWxjdPcCdjNkRrjOiTHRc7iq16jflnfryrKXjII=;
	b=usps7IjMJKFoHI56HNPTW0VP7UK3pT/r/Recm9iuzU83Zu+g72pClf5T3ySuJDq9fsuuj7
	lLf/lIsWaWbo1kBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eFaHnsLn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=usps7IjM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728025492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2z4otWxjdPcCdjNkRrjOiTHRc7iq16jflnfryrKXjII=;
	b=eFaHnsLnYdZy2PimhDJm+qNMBxNLpV14HT0WyLhiXzQ0M1jmoTQOXg555pJk6XLlZuOZYu
	BpGxZbOL1MzpgDIOAuYwOL1Idq9dhJziQhafXTs9w91qZ5Oc1g5/q9AJZP+1sichxUkQQE
	bp3DS7MkxWzQTbM8l2dSFJbCyhCHoPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728025492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2z4otWxjdPcCdjNkRrjOiTHRc7iq16jflnfryrKXjII=;
	b=usps7IjMJKFoHI56HNPTW0VP7UK3pT/r/Recm9iuzU83Zu+g72pClf5T3ySuJDq9fsuuj7
	lLf/lIsWaWbo1kBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E009D13A55;
	Fri,  4 Oct 2024 07:04:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ONKbNZOT/2YqXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 04 Oct 2024 07:04:51 +0000
Date: Fri, 04 Oct 2024 09:05:45 +0200
Message-ID: <87ttdsmjp2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hans P Moller <hmoller@uc.cl>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: line6: add hw monitor volume control to POD HD500X
In-Reply-To: <20241003232828.5819-1-hmoller@uc.cl>
References: <20241003232828.5819-1-hmoller@uc.cl>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 115041FEE5
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Fri, 04 Oct 2024 01:28:28 +0200,
Hans P Moller wrote:
> 
> Add hw monitor volume control for POD HD500X. This is done adding
> LINE6_CAP_HWMON_CTL to the capabilities
> 
> Signed-off-by: Hans P. Moller <hmoller@uc.cl>

Applied now.  Thanks.


Takashi

