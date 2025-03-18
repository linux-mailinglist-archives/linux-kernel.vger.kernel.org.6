Return-Path: <linux-kernel+bounces-566037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B919A67263
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EB13AAE62
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEF5204F75;
	Tue, 18 Mar 2025 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KhCoPgYp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zKsdBgnk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KhCoPgYp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zKsdBgnk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E311EF372
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296635; cv=none; b=FPSAuXqBSvnIbXcxbGKypSbdW7VsXyNowzihzs+a4hjrScwAzcgBkzShnyjUkXSA94UvtdMT01kxjrQKW106Ot7npdkcL1P0CtKog/hQIkKqYcfzKJjD6PWdX6Rdc/Ui8WM7OEiiuUNcXy+8T4IjgnVs9vCjaqUmU0O6RDHUYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296635; c=relaxed/simple;
	bh=u9MX8Xb6I5AnGDs+7m/bLN93H8OltfgHtqh5bYMUprY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCID8510HJEXG6v3SKlY4uMJ5gzo7hViTvTKNViJDrsD6/iidTdG7tQ97XzEksMJAWXKyVsX3/ahNC1x0ALH/UY6FofI/BsCDd1gToLsBy3/RZrlKgEUDOvKzDOhvJcEE7RHdWl8hwqhDvdfnUaeNrdbAApmCfCAtfTTpxom9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KhCoPgYp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zKsdBgnk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KhCoPgYp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zKsdBgnk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 018391F441;
	Tue, 18 Mar 2025 11:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GehszHWI99/sxb/kvmlBARoadr4kOpS/NnlA1LkESrk=;
	b=KhCoPgYpGODvjWEs+MBJuyrM2lxjxuAPY0U/I1f34/Oq1pOdZgxUOhdlpPm2m6Hlxwa4ju
	5HoSEFZMBxLchydo9TFeigBt3PcUfBLtRal4zO4IfSLpPxhzaPNm8K6tg7yb+h8BIF5cVM
	EJMtGJt30xlEsuypZdJcuCazOojsUDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GehszHWI99/sxb/kvmlBARoadr4kOpS/NnlA1LkESrk=;
	b=zKsdBgnk2xli1TKL5XD80qRZsuVN8M9XC+3Fo7bNV0QuqqnCkwkSNmOUajw9HZRXyMd9M1
	N8jjhCB+NUugx5Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GehszHWI99/sxb/kvmlBARoadr4kOpS/NnlA1LkESrk=;
	b=KhCoPgYpGODvjWEs+MBJuyrM2lxjxuAPY0U/I1f34/Oq1pOdZgxUOhdlpPm2m6Hlxwa4ju
	5HoSEFZMBxLchydo9TFeigBt3PcUfBLtRal4zO4IfSLpPxhzaPNm8K6tg7yb+h8BIF5cVM
	EJMtGJt30xlEsuypZdJcuCazOojsUDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GehszHWI99/sxb/kvmlBARoadr4kOpS/NnlA1LkESrk=;
	b=zKsdBgnk2xli1TKL5XD80qRZsuVN8M9XC+3Fo7bNV0QuqqnCkwkSNmOUajw9HZRXyMd9M1
	N8jjhCB+NUugx5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB838139D2;
	Tue, 18 Mar 2025 11:17:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KvwfNTdW2WdwRwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 11:17:11 +0000
Message-ID: <603b438e-02f6-4f01-8ffa-12ab6ec8e745@suse.de>
Date: Tue, 18 Mar 2025 12:17:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/18] nvmet-fcloop: allocate/free fcloop_lsreq
 directly
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-10-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250318-nvmet-fcloop-v3-10-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 3/18/25 11:40, Daniel Wagner wrote:
> fcloop depends on the host or the target to allocate the fcloop_lsreq
> object. This means that the lifetime of the fcloop_lsreq is tied to
> either the host or the target. Consequently, the host or the target must
> cooperate during shutdown.
> 
> Unfortunately, this approach does not work well when the target forces a
> shutdown, as there are dependencies that are difficult to resolve in a
> clean way.
> 
> The simplest solution is to decouple the lifetime of the fcloop_lsreq
> object by managing them directly within fcloop. Since this is not a
> performance-critical path and only a small number of LS objects are used
> during setup and cleanup, it does not significantly impact performance
> to allocate them during normal operation.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 53 +++++++++++++++++++++++++++++---------------
>   1 file changed, 35 insertions(+), 18 deletions(-)
> 
 > diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target 
fcloop.c> index 
06f42da6a0335c53ae319133119d057aab12e07e..537fc6533a4cf5d39855cf850b82af739eeb3056 
100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -342,6 +342,7 @@ fcloop_rport_lsrqst_work(struct work_struct *work)
>   		 * callee may free memory containing tls_req.
>   		 * do not reference lsreq after this.
>   		 */
> +		kfree(tls_req);
>   
>   		spin_lock(&rport->lock);
>   	}
> @@ -353,10 +354,13 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
>   			struct nvme_fc_remote_port *remoteport,
>   			struct nvmefc_ls_req *lsreq)
>   {
> -	struct fcloop_lsreq *tls_req = lsreq->private;
>   	struct fcloop_rport *rport = remoteport->private;
> +	struct fcloop_lsreq *tls_req;
>   	int ret = 0;
>   
> +	tls_req = kmalloc(sizeof(*tls_req), GFP_KERNEL);
> +	if (!tls_req)
> +		return -ENOMEM;

This cries out for kmem_cache_alloc() ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

