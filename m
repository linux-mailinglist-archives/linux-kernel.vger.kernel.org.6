Return-Path: <linux-kernel+bounces-566021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03685A67231
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E219B17C15C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822EB208983;
	Tue, 18 Mar 2025 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BpqEAS66";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sypVbuX6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BpqEAS66";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sypVbuX6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03911DE4E7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296021; cv=none; b=BrkOi1ynUoZ2qtJ5CzVqRFHcFmMwU38XIa7uKsUUxxVL45Aif2c68tkqd2UK+uP7CW4DJLMh1IaoJbLtG8SD/Fsa7sJvkLm620+d+vwIlb8P75Pn/YwhYTu+GDb1je5gYoSlwQ0jOwiuLPAOqkPJFxnA0yOyXngJRh6/Mi6o65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296021; c=relaxed/simple;
	bh=s7ylQF5Ys9iFektCJs9596H4bZ66v9QutLBC4iC6u1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JL3hxNxn7sfvM7T3rh7ZIKysYapCOhnBVurTMvQ61vp/0Nz3GKC2YRdzdcFAWayYBAHbIZdVlvOVEiLPieVJdDimMqPiIVC8LWEXdZmAf8sDNSN1B44H3wiEGxpei1PIzMBDgilJI8ArS/DN9Urq8H2c29rxTJ8KCkfXDZ11Omw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BpqEAS66; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sypVbuX6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BpqEAS66; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sypVbuX6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD5331F770;
	Tue, 18 Mar 2025 11:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PuMTPonpPJmHV1v2fDSmSVJP5xTGkBAfXbpqqvSQF4=;
	b=BpqEAS66T+gKxvDD18aT3JEsiM6kA4Gu1Wl4YSJLcE7O5YsDmwRnhsOgL3StDMyFtBP0LG
	qfCD+DI6WjJSB/IdmQ6qggd2ByGtu7Ea9+Fm1/jqd7b7+qvw+VD0WT5JrWy8yVFHwBEah8
	pPGzvwrhCMmRiniaSc+3kj1MWD/802w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PuMTPonpPJmHV1v2fDSmSVJP5xTGkBAfXbpqqvSQF4=;
	b=sypVbuX6vD7Kp7khMdlBom+vkPrePeopjlZR7LxktteCDcj5OPZuUdM8Jzy5gwdpLbWXts
	L6dA69p9z7oBb1Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BpqEAS66;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sypVbuX6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PuMTPonpPJmHV1v2fDSmSVJP5xTGkBAfXbpqqvSQF4=;
	b=BpqEAS66T+gKxvDD18aT3JEsiM6kA4Gu1Wl4YSJLcE7O5YsDmwRnhsOgL3StDMyFtBP0LG
	qfCD+DI6WjJSB/IdmQ6qggd2ByGtu7Ea9+Fm1/jqd7b7+qvw+VD0WT5JrWy8yVFHwBEah8
	pPGzvwrhCMmRiniaSc+3kj1MWD/802w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PuMTPonpPJmHV1v2fDSmSVJP5xTGkBAfXbpqqvSQF4=;
	b=sypVbuX6vD7Kp7khMdlBom+vkPrePeopjlZR7LxktteCDcj5OPZuUdM8Jzy5gwdpLbWXts
	L6dA69p9z7oBb1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABE55139D2;
	Tue, 18 Mar 2025 11:06:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N2f3KM5T2WcdRAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 11:06:54 +0000
Message-ID: <181c5e4c-f25c-46aa-9be0-06e515f14543@suse.de>
Date: Tue, 18 Mar 2025 12:06:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/18] nvmet-fcloop: track ref counts for nports
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-5-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250318-nvmet-fcloop-v3-5-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD5331F770
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/18/25 11:39, Daniel Wagner wrote:
> A nport object is always used in association with targerport,
> remoteport, tport and rport objects. Add explicit references for any of
> the associated object. This ensures that nport is not removed too early
> on shutdown sequences.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 106 +++++++++++++++++++++++++------------------
>   1 file changed, 63 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 245bfe08d91ec81f1979251e8c757a0d46fd09e9..69121a5f0f280936d1b720e9e994d6e5eb9186ff 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -1054,8 +1054,15 @@ static void
>   fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
>   {
>   	struct fcloop_rport *rport = remoteport->private;
> +	unsigned long flags;
>   
>   	flush_work(&rport->ls_work);
> +
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	rport->nport->rport = NULL;
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
> +	/* nport ref put: rport */
>   	fcloop_nport_put(rport->nport);
>   }
>   
The comment is a bit odd; obviously fcloop_nport_put() puts the nport 
reference for the rport.
Maybe just remove them?

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

