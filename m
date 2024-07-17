Return-Path: <linux-kernel+bounces-254883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015CE9338E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFBA282215
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ABB2557F;
	Wed, 17 Jul 2024 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PKj866Z+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wHhfBbOm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PKj866Z+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wHhfBbOm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221B1BF2A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204469; cv=none; b=sYv7j6t3746+vSJvmI/SLELDScv6Cwpe07J/VaXaJPAjXyI4X+XsBYP/FSFAJB7JoI0e4icTO0tCQ+AREWgODzGAEOsv1quiPSqgEs+4JYVghdY3W/wW61T0GE2tcc50S5P7CQD7UubhcPrSq/v5ZFU92Ryb2UjcAfeWAhtWGRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204469; c=relaxed/simple;
	bh=BjGJIwogDbcHg0VD/xArgy4rC9X8D/KEjxV1EOim80s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdMm7JqyFoT/lEjyATR3jef/ZH4Vm5xXN5k7//WgBJV2vVCO2YU0mggmRXxPFK6uc0CMrmhRdfnh4NiNOG51zUbmjM6ZlhJru5ccMCeX6QJgUDXKa678xQrCMD3zMPUwqHrIiA2gdDe+qlVZbZ+yV0zF7rqATypEm+dGAEqQTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PKj866Z+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wHhfBbOm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PKj866Z+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wHhfBbOm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1917D1FB63;
	Wed, 17 Jul 2024 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721204465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yC1TLKwZPfaoUmpNkD4Zu/cKeQIXK2W3+LfpE091dUo=;
	b=PKj866Z+VbsH81NFfgmLFdfxAtQSLR90l2rDYqnrg1IzH5r82Ysp4KN1n7PlnoibqgnJLp
	K+PVkaC63vZASkDELdGChckgYrjvQm6wdy+by6TjKuxZnTm02hADvmwjE6WW9hU5LOpxAx
	UcUaVty/913T4WeWTtBYEjVGwksVlAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721204465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yC1TLKwZPfaoUmpNkD4Zu/cKeQIXK2W3+LfpE091dUo=;
	b=wHhfBbOmBQd0gwipNXDmlnk3nCxo/FudEa/xo50Piq3/XNpppFVmnHxpdaKZE5PKTzyjOb
	yelmNb6k4QtCgJBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PKj866Z+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wHhfBbOm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721204465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yC1TLKwZPfaoUmpNkD4Zu/cKeQIXK2W3+LfpE091dUo=;
	b=PKj866Z+VbsH81NFfgmLFdfxAtQSLR90l2rDYqnrg1IzH5r82Ysp4KN1n7PlnoibqgnJLp
	K+PVkaC63vZASkDELdGChckgYrjvQm6wdy+by6TjKuxZnTm02hADvmwjE6WW9hU5LOpxAx
	UcUaVty/913T4WeWTtBYEjVGwksVlAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721204465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yC1TLKwZPfaoUmpNkD4Zu/cKeQIXK2W3+LfpE091dUo=;
	b=wHhfBbOmBQd0gwipNXDmlnk3nCxo/FudEa/xo50Piq3/XNpppFVmnHxpdaKZE5PKTzyjOb
	yelmNb6k4QtCgJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2FD31368F;
	Wed, 17 Jul 2024 08:21:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xtX5LvB+l2bHEAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 17 Jul 2024 08:21:04 +0000
Message-ID: <dfd1220d-1c99-4bc5-ac76-2fac7583bfa2@suse.de>
Date: Wed, 17 Jul 2024 10:21:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet-rdma: add unbound_wq support for nvmet-rdma
To: Ping Gan <jacky_gam_2001@163.com>, sagi@grimberg.me, hch@lst.de,
 kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <20240717075208.87324-1-jacky_gam_2001@163.com>
 <20240717075208.87324-3-jacky_gam_2001@163.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240717075208.87324-3-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[163.com,grimberg.me,lst.de,nvidia.com,lists.infradead.org,vger.kernel.org];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 1917D1FB63

On 7/17/24 09:52, Ping Gan wrote:
> To define a module parameter use_unbound_wq to enable unbound
> workqueue to handle RDMA's IO of CQ.
> 
> Signed-off-by: jackygam2001 <jacky_gam_2001@163.com>

Similar here, please use your real name as the author name.

> ---
>   drivers/nvme/target/rdma.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 1eff8ca6a5f1..bfd7106316bc 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -155,6 +155,10 @@ static int nvmet_rdma_srq_size = 1024;
>   module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size, 0644);
>   MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size, should >= 256 (default: 1024)");
>   
> +static bool use_unbound_wq;
> +module_param(use_unbound_wq, bool, 0444);
> +MODULE_PARM_DESC(use_unbound_wq, "use unbound workqueue to handle IO request: Default false");
> +
>   static DEFINE_IDA(nvmet_rdma_queue_ida);
>   static LIST_HEAD(nvmet_rdma_queue_list);
>   static DEFINE_MUTEX(nvmet_rdma_queue_mutex);
> @@ -1259,7 +1263,11 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
>   	 */
>   	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
>   
> -	queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
> +	if (use_unbound_wq)
> +		queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
> +				   queue->comp_vector, IB_POLL_UNBOUND_WORKQUEUE);
> +	else
> +		queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
>   				   queue->comp_vector, IB_POLL_WORKQUEUE);
>   	if (IS_ERR(queue->cq)) {
>   		ret = PTR_ERR(queue->cq);

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


