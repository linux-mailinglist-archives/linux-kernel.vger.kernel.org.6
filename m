Return-Path: <linux-kernel+bounces-289498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 697899546C4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254FD28279C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DCF18FDCA;
	Fri, 16 Aug 2024 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="udvAt+ZB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4rPWYq8F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="udvAt+ZB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4rPWYq8F"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025851741D2;
	Fri, 16 Aug 2024 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804075; cv=none; b=bVarNzdcRF0E/89LDs6BEoMnhPhDo4Fv3DCspOJ5/bPtzi0VS5PoYbmiwmlplKjSALr+HEh8a53BIrIV8wee6194/UcfxdiBjzXPZx3o3OraHtO+taKmq08Iuf0OZW954wcLj7NLXq+0Ppx+jsjkm6azDnR7CQ7YW+NeQuo5hBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804075; c=relaxed/simple;
	bh=YHrptwsZaS9hvW19+MpQbcuCeMwG5IUwM1h+DS+Ust0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7n/b0d2h2m6K3VKkGmMk6sFZC+FbKVPMbDQ57ENVjgOhtlHFkPNnYGLDO6FQ9lR87QHpQDyVF2mW5eKcBT62vDEr8FyERPCt7Njs7ZkVdwcQfjJ+U3QJGk0zabBt9ks+KYBxIkG0a1aPfVveOFUwaCgae94tXBsxSYj+/6s7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=udvAt+ZB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4rPWYq8F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=udvAt+ZB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4rPWYq8F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AA1520093;
	Fri, 16 Aug 2024 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723804066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42Pd8RLvLd3pYPuxEBwi0XMdktWMsznABFXa0p+lH4o=;
	b=udvAt+ZBCamB3vqXzN0TR57eIiNpFGWK1te/qECAIJnFSflpqWDV3VZhixPL3HQntA/9sn
	THhQzMC6uTZYPllX/9UIi+ta9fwJGUh0hwsoT0yLNr+Nmi/NgIMnl/s6vOr29M5AS/SKfW
	J3dJ7z7mNb+SKrYIL0HGtEFs5gshBBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723804066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42Pd8RLvLd3pYPuxEBwi0XMdktWMsznABFXa0p+lH4o=;
	b=4rPWYq8FABmPF5cHFQpuF/ReDslpF6Ne5Zd6voeNdN2+SXkrDnTSyb65qmy1v1H9CsDqfu
	OypRSEjSpkzE1dDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723804066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42Pd8RLvLd3pYPuxEBwi0XMdktWMsznABFXa0p+lH4o=;
	b=udvAt+ZBCamB3vqXzN0TR57eIiNpFGWK1te/qECAIJnFSflpqWDV3VZhixPL3HQntA/9sn
	THhQzMC6uTZYPllX/9UIi+ta9fwJGUh0hwsoT0yLNr+Nmi/NgIMnl/s6vOr29M5AS/SKfW
	J3dJ7z7mNb+SKrYIL0HGtEFs5gshBBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723804066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42Pd8RLvLd3pYPuxEBwi0XMdktWMsznABFXa0p+lH4o=;
	b=4rPWYq8FABmPF5cHFQpuF/ReDslpF6Ne5Zd6voeNdN2+SXkrDnTSyb65qmy1v1H9CsDqfu
	OypRSEjSpkzE1dDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20B761397F;
	Fri, 16 Aug 2024 10:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bLVBBqIpv2YuRAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 16 Aug 2024 10:27:46 +0000
Date: Fri, 16 Aug 2024 12:28:26 +0200
Message-ID: <87le0w3gol.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: <perex@perex.cz>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] ALSA: oss: Remove unused declarations
In-Reply-To: <20240816100209.879043-1-yuehaibing@huawei.com>
References: <20240816100209.879043-1-yuehaibing@huawei.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,huawei.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Fri, 16 Aug 2024 12:02:09 +0200,
Yue Haibing wrote:
> 
> These functions is never implemented and used.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Thanks, applied.


Takashi

