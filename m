Return-Path: <linux-kernel+bounces-169426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5727F8BC880
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CEFDB20D91
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE6913FD91;
	Mon,  6 May 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LxseSu9t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RciozrXG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LxseSu9t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RciozrXG"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC84F1EE
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981444; cv=none; b=s/rt/b7kP8Eln0UWtipxhaxOwaPUFFLfx9I/txOcKHMqWzsrIf9E6F8D0bVJIvvj8gYPZdxLDfJFfS2CsTdDNzhHY/H8zPu5ffHE/6AEMphnPmC+ML2TnrHYxgj/OoGMFozVy6/K3f8xSKUPACDro5NmN/oG2e266mr8wScybQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981444; c=relaxed/simple;
	bh=h/+3mmcN4ggtpP++IT6mRKpHt8jDBGI5L76LmwjqGNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/PBwkA0CyC5kdbDR+CcIaSpHhs0IDro6y6Es/a1QnB6fxF0J6N7IeZMrxC2MoFHQ+56bTz6BlGN/EQdl+Pk+AlZ5PJOTFurI5763srPbksjOOTT7EWTo5nhW/obOk5nlXnbsxQdEpDWK7GGhe7mvQZcM6D6nwXUksCnl3j80IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LxseSu9t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RciozrXG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LxseSu9t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RciozrXG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EE2D37FD0;
	Mon,  6 May 2024 07:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714981441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QB7X6b8uZ129mfCOeXo2JK4nhvfmoN+Tgyx+uJLesB0=;
	b=LxseSu9tNynavL8G6eU1ywrNTJ/WGNepkH2nPFBJViNaeQKr9lUzrpQmLARbxmG4kAroAJ
	3vSgqRKPWquUBjIC04ZNZSIP7ZL7FV7TOVfMk0fqK3s5G11eSyXqAikx8VRaJ7cpSnsPhA
	HkOjbefBaqvugvqIhF0sqK3X0gX8phk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714981441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QB7X6b8uZ129mfCOeXo2JK4nhvfmoN+Tgyx+uJLesB0=;
	b=RciozrXGAx66sR2lNyVMX4NKFI+ZQAA82jTVhmhDUO8DzBfTAv0JEOcZEjSPeRRBSz/Wt+
	MbcJsNJduqWj/mBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LxseSu9t;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RciozrXG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714981441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QB7X6b8uZ129mfCOeXo2JK4nhvfmoN+Tgyx+uJLesB0=;
	b=LxseSu9tNynavL8G6eU1ywrNTJ/WGNepkH2nPFBJViNaeQKr9lUzrpQmLARbxmG4kAroAJ
	3vSgqRKPWquUBjIC04ZNZSIP7ZL7FV7TOVfMk0fqK3s5G11eSyXqAikx8VRaJ7cpSnsPhA
	HkOjbefBaqvugvqIhF0sqK3X0gX8phk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714981441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QB7X6b8uZ129mfCOeXo2JK4nhvfmoN+Tgyx+uJLesB0=;
	b=RciozrXGAx66sR2lNyVMX4NKFI+ZQAA82jTVhmhDUO8DzBfTAv0JEOcZEjSPeRRBSz/Wt+
	MbcJsNJduqWj/mBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1BDC13A25;
	Mon,  6 May 2024 07:44:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MOklLkCKOGZ2XgAAD6G6ig
	(envelope-from <jroedel@suse.de>); Mon, 06 May 2024 07:44:00 +0000
Date: Mon, 6 May 2024 09:43:59 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <jroedel@suse.de>
To: Borislav Petkov <bp@alien8.de>
Cc: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Roth <michael.roth@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	svsm-devel@coconut-svsm.dev
Subject: Re: [svsm-devel] [PATCH v4 15/15] x86/sev: Allow non-VMPL0 execution
 when an SVSM is present
Message-ID: <ZjiKP4Z6nBbvOEQB@suse.de>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <e377d148acac799f6905fc544fbb8bf2ed76e078.1713974291.git.thomas.lendacky@amd.com>
 <ZjTMcC7KTP9xRAqk@8bytes.org>
 <20240503160419.GAZjULA7HhinTfCWZ6@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503160419.GAZjULA7HhinTfCWZ6@fat_crate.local>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1EE2D37FD0
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Fri, May 03, 2024 at 06:04:19PM +0200, Borislav Petkov wrote:
> On Fri, May 03, 2024 at 01:37:20PM +0200, Jörg Rödel wrote:
> > Nit: Can this be formated more like "SNP running at VMPL-%u"? That makes
> > it easier to parse for me when looking into dmesg :)
> 
> Hmm, except that all documentation is without a "-"... The APM talks
> about VMPL%d everywhere...

No strict opinion, I just wanted to point out that there are more
readable ways of printing the VMPL level than what is used in the APM.

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany
https://www.suse.com/

Geschäftsführer: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG Nürnberg)

