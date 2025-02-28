Return-Path: <linux-kernel+bounces-537900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9757A49244
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A0E1893051
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622F31C5D6C;
	Fri, 28 Feb 2025 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BTFEsKs+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JDdx/Ggg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BTFEsKs+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JDdx/Ggg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF141ABEC1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740728104; cv=none; b=INJ79eZTb6eCH1O2ZkFcoyB7QYAztMXkayaBDJSrjrfVl9SR5/mUCq888E6U0ivZCn8P7wI246gfQ3sN7+JrIvnMBBOoUlcfS85av/MIXz6rzOEOqMIO1y2RRnpeIVpTDSpbchq4KkpVqRDlzmeQO5HeZIbOm+sWgdYeep0pZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740728104; c=relaxed/simple;
	bh=DCn1CtLOxMU3KQoUhuot2DB7PkwuZr+H6DQWq2rmtY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrOnnlJga2iDy0HICBrdFIZWg4x9OCFuqtvuBhx2bX67SEy80iRlsfuXpLlny72nu6V0k2aRrA9wDC4/C005nC8RWrujJvsda4JYK8BG1FUZbPSSZOAGt11o/XGzSaGA6pDGQUvlFDE/hVP5366x5+5cL7IrljVUuQRh7LsbL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BTFEsKs+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JDdx/Ggg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BTFEsKs+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JDdx/Ggg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4D512116F;
	Fri, 28 Feb 2025 07:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740728100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMH+Ct4cSLyr91tMN/c0O0+iDa4wkLGmUlBFVGM9kkQ=;
	b=BTFEsKs+VT0/B0sYogDR5QVmVYT2ys/bNuymWNjIDqZibBihV1nWnsOMdoCX0N44Y3ixXW
	rLEDRtkhg9LWrN5alZA2u0x2ldRpZXOd6TO1tnLVWELvrHmBcC8ePpZ/IQvrY1IcrjfQnm
	6g1ceYB3HDh61eY3OCrw/4sWdMBT8nQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740728100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMH+Ct4cSLyr91tMN/c0O0+iDa4wkLGmUlBFVGM9kkQ=;
	b=JDdx/GggYnLEmJB8UB/UxxE7jDqmhI26BQ24mJV/pzr7lra9mbs7NzF3MMFyuk3PAqGJ/l
	HcUZpD00ZQ3w1iDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740728100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMH+Ct4cSLyr91tMN/c0O0+iDa4wkLGmUlBFVGM9kkQ=;
	b=BTFEsKs+VT0/B0sYogDR5QVmVYT2ys/bNuymWNjIDqZibBihV1nWnsOMdoCX0N44Y3ixXW
	rLEDRtkhg9LWrN5alZA2u0x2ldRpZXOd6TO1tnLVWELvrHmBcC8ePpZ/IQvrY1IcrjfQnm
	6g1ceYB3HDh61eY3OCrw/4sWdMBT8nQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740728100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMH+Ct4cSLyr91tMN/c0O0+iDa4wkLGmUlBFVGM9kkQ=;
	b=JDdx/GggYnLEmJB8UB/UxxE7jDqmhI26BQ24mJV/pzr7lra9mbs7NzF3MMFyuk3PAqGJ/l
	HcUZpD00ZQ3w1iDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B848137AC;
	Fri, 28 Feb 2025 07:35:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vVeMGCRnwWd5JwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:35:00 +0000
Message-ID: <f944fdb3-081f-474a-9193-f482fe87f72b@suse.de>
Date: Fri, 28 Feb 2025 08:34:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] nvmet-fc: take tgtport reference only once
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-8-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-8-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/26/25 19:46, Daniel Wagner wrote:
> The reference counting code can be simplified. Instead taking a tgtport
> refrerence at the beginning of nvmet_fc_alloc_hostport and put it back
> if not a new hostport object is allocated, only take it when a new
> hostport object is allocated.
> 
Can it really?
Main point of this operation is that 'tgtport' isn't going away during 
while we're figuring out whether we need it.

With this patch it means that

> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fc.c | 18 +++---------------
>   1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index b807b4c05cac7fe4764df3df76f8fa50f4bab6ba..391917b4ce0115dbc0ad99d1fb363b1af6ee0685 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1046,29 +1046,16 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   	if (!hosthandle)
>   		return NULL;
>   
> -	/*
> -	 * take reference for what will be the newly allocated hostport if
> -	 * we end up using a new allocation
> -	 */
> -	if (!nvmet_fc_tgtport_get(tgtport))
> -		return ERR_PTR(-EINVAL);
> -
 >   	spin_lock_irqsave(&tgtport->lock, flags);>   	match = 
nvmet_fc_match_hostport(tgtport, hosthandle);
>   	spin_unlock_irqrestore(&tgtport->lock, flags);
>   

'tgtport' might be invalid here, causing a crash when taking the lock.

> -	if (match) {
> -		/* no new allocation - release reference */
> -		nvmet_fc_tgtport_put(tgtport);
> +	if (match)
>   		return match;
> -	}
>   
>   	newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
> -	if (!newhost) {
> -		/* no new allocation - release reference */
> -		nvmet_fc_tgtport_put(tgtport);
> +	if (!newhost)
>   		return ERR_PTR(-ENOMEM);
> -	}
>   
>   	spin_lock_irqsave(&tgtport->lock, flags);
>   	match = nvmet_fc_match_hostport(tgtport, hosthandle);
> @@ -1077,6 +1064,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   		kfree(newhost);
>   		newhost = match;
>   	} else {
> +		nvmet_fc_tgtport_get(tgtport);
>   		newhost->tgtport = tgtport;
>   		newhost->hosthandle = hosthandle;
>   		INIT_LIST_HEAD(&newhost->host_list);
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

