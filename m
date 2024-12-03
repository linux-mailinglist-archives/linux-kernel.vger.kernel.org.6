Return-Path: <linux-kernel+bounces-429216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1D49E18E4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C713D2810FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAB31E0E06;
	Tue,  3 Dec 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rjsCm3QQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q6VuBIcD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rjsCm3QQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q6VuBIcD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAC41E0DE9;
	Tue,  3 Dec 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220632; cv=none; b=J15BwJKgfgW5P4dSgN6XpBVUWFkXQzKU5uxfUp1ZydruaiUWdmSPDIyqvfBBRyHxD4b8iWHeeIX+EIxipaAoG+59Bgnq0AM6fnWCgHpLx8p0F/OOqyttbK3673b35nLuBRs0s1nmAdCetH4K7DtTz1tB6J6EPb6uwi6lSXTSPD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220632; c=relaxed/simple;
	bh=kl9IXqQtfUNMolIZ4nsl5x6MLsUPrqnZTxsGkW20ibg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDrUm3M+wsG0GzM7pM9AFH0FnJfAbYoPH+mXsxelqpKldzy/bdzlN3ElBa5DmsRehMAUC0UoL8ad6RJTPp0QJhmcHaWECAi+riY+TzthCMgp5hue3GbMRmI21KscWv6SFU3QB8AvgOXpz7iMnoLwZiHeK6TVIGLMVa/7uiZL9mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rjsCm3QQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q6VuBIcD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rjsCm3QQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q6VuBIcD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BC011F451;
	Tue,  3 Dec 2024 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733220628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGOtYroFEEmWBohtSYm6T7wP7eFGiEBQnJJHoGI4RDM=;
	b=rjsCm3QQVlHu8eqFLvR+yeDoL8UbVm9ZVg7iwN+WwGP5a8apJ7TkbCHqXtm151o3c862wE
	TGWwxrLYTTXAv5yj48BmITGTL4C/WeIpOmHh1aeqiib/NWylsd2EpuaheRZ6UIU3HL232t
	BVpxR06gLWJXtSg0xTdK+EBI5DydQGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733220628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGOtYroFEEmWBohtSYm6T7wP7eFGiEBQnJJHoGI4RDM=;
	b=Q6VuBIcDzqJQIXEjDfpO5Sg0ZccVvn2FQmY+FZ4mUlrM00jmKnffm38Ma5ijPDJS8+lqZs
	bebnitd9hzHS7iCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733220628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGOtYroFEEmWBohtSYm6T7wP7eFGiEBQnJJHoGI4RDM=;
	b=rjsCm3QQVlHu8eqFLvR+yeDoL8UbVm9ZVg7iwN+WwGP5a8apJ7TkbCHqXtm151o3c862wE
	TGWwxrLYTTXAv5yj48BmITGTL4C/WeIpOmHh1aeqiib/NWylsd2EpuaheRZ6UIU3HL232t
	BVpxR06gLWJXtSg0xTdK+EBI5DydQGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733220628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGOtYroFEEmWBohtSYm6T7wP7eFGiEBQnJJHoGI4RDM=;
	b=Q6VuBIcDzqJQIXEjDfpO5Sg0ZccVvn2FQmY+FZ4mUlrM00jmKnffm38Ma5ijPDJS8+lqZs
	bebnitd9hzHS7iCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D12113A15;
	Tue,  3 Dec 2024 10:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X+coFhTZTmdJXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 03 Dec 2024 10:10:28 +0000
Date: Tue, 03 Dec 2024 11:10:28 +0100
Message-ID: <87bjxtyt4b.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Fix typo in hda_sysfs.h
In-Reply-To: <20241203094250.8312-1-zhujun2@cmss.chinamobile.com>
References: <20241203094250.8312-1-zhujun2@cmss.chinamobile.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinamobile.com:email,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Tue, 03 Dec 2024 10:42:50 +0100,
Zhu Jun wrote:
> 
> The word 'accodingly' is wrong, so fix it.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Thanks, applied now.


Takashi

