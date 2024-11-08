Return-Path: <linux-kernel+bounces-401760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA67E9C1ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FA61C215CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31621EF083;
	Fri,  8 Nov 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kfEhoUV9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tOV8HOS2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kfEhoUV9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tOV8HOS2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1501E32D7;
	Fri,  8 Nov 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074881; cv=none; b=YlFxzvzFSDrC8ooDlV3g7yDUdhwGoBcx3fwyNOXdefhS9TeOL7tpXQ6Sm0BhNE1OIQ0FD5i8BZ3xFuGvQGGqoHs0P4vYGRAUC2k5d3GPtffyJT1g88LyNlYiIrBAp9kDRRPQmQ8LMwja1S6fTKEpjh+rL6NFaC6jZ7ZE8h14PHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074881; c=relaxed/simple;
	bh=yEB0ixQ2FQKEODmu1H0Aet99x/l/xA6L0j8PawSuz+Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtDdY+5CWzE0W/cHMyysBk+gxTc1gOad/sPxwLoMHnT6nZ0gTGVIK1W/yBKNYOzsFqQ0k5IAoSbKm4C0INtPRV/+QLhO5kz73dyht7T0RBJBxdSjZB9q87jZo/UZt7uMKBb0AzOuVhUUomrpUQgGNeXKAGmUJ2MEWuEBcUsubNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kfEhoUV9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tOV8HOS2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kfEhoUV9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tOV8HOS2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B92FE21EC4;
	Fri,  8 Nov 2024 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731074876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPRz//sSce/Y0PtOshnTUPOvEHHgoXeNRqLxyNKmPQI=;
	b=kfEhoUV9IRnmO0njd/KHKdziVcfRdWvIEmKLsbC3YMX+TpD9sn6x8S72J3uotRp8NZgKiq
	2riNkFHfz4Jwr186zNJ9UWZdm9czspCQW98bemB3CHL7YJM1nwaSvsjddhOlINKU+kEdmg
	wHpbI7pyJW4gNGyFnDJtCceDzrg2cZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731074876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPRz//sSce/Y0PtOshnTUPOvEHHgoXeNRqLxyNKmPQI=;
	b=tOV8HOS2fOEp8Ua66TGaTk7zAEhd0CaCamvfa03wJtnvbHaPyKqaQ5Vx6l1GsCYmvOzu8U
	tfysTs8VfNkbvkDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731074876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPRz//sSce/Y0PtOshnTUPOvEHHgoXeNRqLxyNKmPQI=;
	b=kfEhoUV9IRnmO0njd/KHKdziVcfRdWvIEmKLsbC3YMX+TpD9sn6x8S72J3uotRp8NZgKiq
	2riNkFHfz4Jwr186zNJ9UWZdm9czspCQW98bemB3CHL7YJM1nwaSvsjddhOlINKU+kEdmg
	wHpbI7pyJW4gNGyFnDJtCceDzrg2cZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731074876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPRz//sSce/Y0PtOshnTUPOvEHHgoXeNRqLxyNKmPQI=;
	b=tOV8HOS2fOEp8Ua66TGaTk7zAEhd0CaCamvfa03wJtnvbHaPyKqaQ5Vx6l1GsCYmvOzu8U
	tfysTs8VfNkbvkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B78F13967;
	Fri,  8 Nov 2024 14:07:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6LWrIDwbLmcBfgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 08 Nov 2024 14:07:56 +0000
Date: Fri, 08 Nov 2024 15:07:56 +0100
Message-ID: <87bjypg6o3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: ump: remove unnecessary check on blk
In-Reply-To: <20241108032702.217168-1-luoyifan@cmss.chinamobile.com>
References: <20241108032702.217168-1-luoyifan@cmss.chinamobile.com>
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 08 Nov 2024 04:27:02 +0100,
Luo Yifan wrote:
> 
> The unsigned expression 'blk' will never be negative, so remove the
> unnecessary check.
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>

Thanks, applied now.


Takashi

