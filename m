Return-Path: <linux-kernel+bounces-533286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C555A457D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCE11609F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84A01E1E19;
	Wed, 26 Feb 2025 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M52k0xCi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8iRN0KEK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M52k0xCi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8iRN0KEK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEAD1E1E0F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557512; cv=none; b=i5yRANgehEed7tiJOtge3Qs3A5N3Co59+/rhzfWIS0+n7xu0AuU4XkTO1ymFXft1dYwD55pvasQRtYAXRaHKfmayLPbrhhrosDGXrrNrUN/u/SWks06+l3L+ADnlnk3/BVZPfY3s0vEf/5gwKdYMzPj7YDWIhrH3ZACT7QBAlQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557512; c=relaxed/simple;
	bh=ngVPVzEoGTQofPb2IuC5RPQf+fnemEe3saOAh3C/qTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTfDUkGbVeiJ1eAZIPyjj3SrPOGhrZCpg6n6EimFuB6kG2MfDKnn60QHt6GsNi3NJEO8bEYG6+9rlhQpOQJ16SFRj+2cqbFpRaVwL/ZpKY13Hh+oyYHWb9NmfQd7p9M6kGnbTtlyMsY8CZaoFX0N9yXJcMzL5RMX/7t2c8IIfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M52k0xCi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8iRN0KEK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M52k0xCi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8iRN0KEK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B7A831F38A;
	Wed, 26 Feb 2025 08:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740557508;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5oSK5a0wXtrsCNbcDCNVM2B7YuQM4YVWXEKgiWoGr4g=;
	b=M52k0xCidBShUQAUieS3yPeEKYbp9SkWFdE1T3Y9LN5qr+qoYQf7ZkLHS+lGpskYFmX84o
	rj9MORggsjWLOOWi/wz2wycGn+wJaTmZBjktZaO+KZUIC3AmoqtrO/rEulVAIrr84IJswA
	fagXdOSFcorVbEFOJXuRji/5Ut1Z0Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740557508;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5oSK5a0wXtrsCNbcDCNVM2B7YuQM4YVWXEKgiWoGr4g=;
	b=8iRN0KEKaA2TzYhRyiJviHM7S5ocd8Wgx3odRIDBHuMEw1X2YH9ID+lMEUobTzWCFcCrsV
	lywwqivyW5oEyPCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740557508;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5oSK5a0wXtrsCNbcDCNVM2B7YuQM4YVWXEKgiWoGr4g=;
	b=M52k0xCidBShUQAUieS3yPeEKYbp9SkWFdE1T3Y9LN5qr+qoYQf7ZkLHS+lGpskYFmX84o
	rj9MORggsjWLOOWi/wz2wycGn+wJaTmZBjktZaO+KZUIC3AmoqtrO/rEulVAIrr84IJswA
	fagXdOSFcorVbEFOJXuRji/5Ut1Z0Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740557508;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5oSK5a0wXtrsCNbcDCNVM2B7YuQM4YVWXEKgiWoGr4g=;
	b=8iRN0KEKaA2TzYhRyiJviHM7S5ocd8Wgx3odRIDBHuMEw1X2YH9ID+lMEUobTzWCFcCrsV
	lywwqivyW5oEyPCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DD6F1377F;
	Wed, 26 Feb 2025 08:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O2tbIsTMvmf5QAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 26 Feb 2025 08:11:48 +0000
Date: Wed, 26 Feb 2025 09:11:42 +0100
From: David Sterba <dsterba@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-hardening@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Replace deprecated strncpy() with strscpy()
Message-ID: <20250226081142.GR5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250225192613.330409-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225192613.330409-2-thorsten.blum@linux.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Feb 25, 2025 at 08:26:14PM +0100, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers. Use
> strscpy() instead and don't zero-initialize the param array.
> 
> Compile-tested only.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Added to for-next, thanks.

