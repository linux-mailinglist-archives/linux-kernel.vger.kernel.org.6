Return-Path: <linux-kernel+bounces-516057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9866BA36C7E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 08:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E7816FC20
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 07:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD0C199E89;
	Sat, 15 Feb 2025 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SRGyeX0p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jxnMBqVd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SRGyeX0p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jxnMBqVd"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6238194A66
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739605251; cv=none; b=dsjf4aeIK577ldz9McHrjoDXYeF6WrUM5dEPYXyWyNDKq5mq1OWC2U09VJHhwgV1jwRC/ftkQPehERny5QcA8joIhxsk3yH4WAhyUSo6MDbmp9+z/rYQMgYwhAGeG7EPgVE2LA3fUyhRI/PWnWNuhxSMxn22K0NoteMKxgcbIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739605251; c=relaxed/simple;
	bh=tyAe1G4vozOH8CQNR+XXtkERMsRznPA5f9eHnzagxu8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0cbVkZRx/ilfHhRdj3QngYi+J4r0Y9X93O6Oaf8GM5D1vNXC9zz2uNpmVdlQVW+R3TFGKmK15vt7+amZVg9sjzKhFpdD8VpCR8y9OuUsgJEB9EDA4VdRM3MT3scEkOqQ7oGyxW5TLefL8qR8iJvZnM10LQtjtK+DubMFdy7Dr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SRGyeX0p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jxnMBqVd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SRGyeX0p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jxnMBqVd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA2D31F381;
	Sat, 15 Feb 2025 07:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739605247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UtA3nSwz8qGNQKPcMWpiYZ5PIhInc0gt1HKYHJ3suHY=;
	b=SRGyeX0pE7lPj1OAv41DcBKfOvNfPJ2dHB8LpvebKI/BqHhzpB3Oys4WCeTbG+j7AvyE/X
	eXnlmGIwxc9eafSOehTKKUAJAKXT2AGEMuETPUqvQOC+TdeQGnszGtj9lgJKkClwGCX/d1
	tCPrwVfkzo0ySajQMtXCVypSEv6H8A8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739605247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UtA3nSwz8qGNQKPcMWpiYZ5PIhInc0gt1HKYHJ3suHY=;
	b=jxnMBqVd5iSQlVYaIHcjO5dmGuVOtpn7y4Yv5UKtZ3GWYCGgnrQkvghDPsvlYyIYMhm8id
	+mkYkXNEPNsyeOCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739605247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UtA3nSwz8qGNQKPcMWpiYZ5PIhInc0gt1HKYHJ3suHY=;
	b=SRGyeX0pE7lPj1OAv41DcBKfOvNfPJ2dHB8LpvebKI/BqHhzpB3Oys4WCeTbG+j7AvyE/X
	eXnlmGIwxc9eafSOehTKKUAJAKXT2AGEMuETPUqvQOC+TdeQGnszGtj9lgJKkClwGCX/d1
	tCPrwVfkzo0ySajQMtXCVypSEv6H8A8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739605247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UtA3nSwz8qGNQKPcMWpiYZ5PIhInc0gt1HKYHJ3suHY=;
	b=jxnMBqVd5iSQlVYaIHcjO5dmGuVOtpn7y4Yv5UKtZ3GWYCGgnrQkvghDPsvlYyIYMhm8id
	+mkYkXNEPNsyeOCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49F3C13782;
	Sat, 15 Feb 2025 07:40:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HGjoDv9EsGcgQAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 15 Feb 2025 07:40:47 +0000
Date: Sat, 15 Feb 2025 08:40:42 +0100
Message-ID: <87seofpsed.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] ALSA: hda/cirrus: Reduce codec resume time
In-Reply-To: <20250214162354.2675652-2-vitalyr@opensource.cirrus.com>
References: <20250214162354.2675652-1-vitalyr@opensource.cirrus.com>
	<20250214162354.2675652-2-vitalyr@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 14 Feb 2025 17:23:26 +0100,
Vitaly Rodionov wrote:
> 
> This patch reduces the resume time by half and introduces an option to
> include a delay after a single write operation before continuing.
> 
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Applied now.  Thanks.


Takashi

