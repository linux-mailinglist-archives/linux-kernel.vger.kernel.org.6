Return-Path: <linux-kernel+bounces-537890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C21EA49227
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A14316C429
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2568D1C760D;
	Fri, 28 Feb 2025 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z9g/o0+9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PX3Hpkdq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z9g/o0+9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PX3Hpkdq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6AE276D12
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727665; cv=none; b=obQv0DUsbULOUXOBEZenNacVD27z4Dh6O+v3zTWswmDUWV4DDRF/Q+Pp6uMMTiD1ieIUAqDu5NbTwH8oGi5II3F8kbtK3bD6hPg91B4BaWu/4YkrPY82XBbP4l3b631ftbGOv8kauKGgVNzA9umbq0HbiRllIDGVpnn7++Q5iLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727665; c=relaxed/simple;
	bh=iWo47aJ9cndVExb6GhPf6rY7UoX90UL2h9Of9czB3XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1YqeLHyyXNpadhOlRaALSfbS9rMlU8wbure1GGbWnz/952itU0OGTK0E/nAV6s4TPRE1xBJFZgu8P3+CVEvcTnprBGemHGYzf9QS341OZsc1hALudoAbWVnVrrTtvAHfRjvyg6Ql3hpeDNEr7jN5D2fG/gufMcs/KYRxx1psIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z9g/o0+9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PX3Hpkdq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z9g/o0+9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PX3Hpkdq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE3431F38F;
	Fri, 28 Feb 2025 07:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740727661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knzWe52WSa1rRZ0mJ2t5rcWq0B869J97x4mlC48ma3s=;
	b=Z9g/o0+9/2Ks5DBNGrdcFwvnAV2nlyO0dErx4PPpM9sVPmcNvX5jtZYSmhQoz9yhq9i0gu
	BvvebHcGcTYMugDC1xo8H8fAZZKHdScjJKODjs9OBn4Usk4dHtifBi8W6AL4xGbBsnHt8O
	QscgnZN9tBK6ttYWqc09hCtLRW2cScU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740727661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knzWe52WSa1rRZ0mJ2t5rcWq0B869J97x4mlC48ma3s=;
	b=PX3HpkdqF1/P/EWs+LuAMGJH0OllHS/YtA4rr3pe2aQwBTKkZ67u1YNDFQge828dAeX5BV
	hIsVVGZLxLFWlsAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740727661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knzWe52WSa1rRZ0mJ2t5rcWq0B869J97x4mlC48ma3s=;
	b=Z9g/o0+9/2Ks5DBNGrdcFwvnAV2nlyO0dErx4PPpM9sVPmcNvX5jtZYSmhQoz9yhq9i0gu
	BvvebHcGcTYMugDC1xo8H8fAZZKHdScjJKODjs9OBn4Usk4dHtifBi8W6AL4xGbBsnHt8O
	QscgnZN9tBK6ttYWqc09hCtLRW2cScU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740727661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knzWe52WSa1rRZ0mJ2t5rcWq0B869J97x4mlC48ma3s=;
	b=PX3HpkdqF1/P/EWs+LuAMGJH0OllHS/YtA4rr3pe2aQwBTKkZ67u1YNDFQge828dAeX5BV
	hIsVVGZLxLFWlsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58238137AC;
	Fri, 28 Feb 2025 07:27:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mH40E21lwWc2JQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:27:41 +0000
Message-ID: <ceb7e531-cc0b-4a4a-a97d-c578daf9d5b2@suse.de>
Date: Fri, 28 Feb 2025 08:27:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] nvmet-fcloop: track tport with ref counting
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-5-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-5-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 2/26/25 19:45, Daniel Wagner wrote:
> The tport object is created via nvmet_fc_register_targetport and freed
> via nvmet_fc_unregister_targetport. That means after the port is
> unregistered nothing should use it. Thus ensure with refcounting
> that there is no user left before the unregister step.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 52 +++++++++++++++++++++++++++++---------------
>   1 file changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 80693705c069dd114b2d4f15d0482dd2d713a273..2269b4d20af2ef9bb423617b94a5f5326ea124bd 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -233,8 +233,12 @@ struct fcloop_tport {
>   	spinlock_t			lock;
>   	struct list_head		ls_list;
>   	struct work_struct		ls_work;
> +	struct kref			ref;
>   };
>   
> +static int fcloop_tport_get(struct fcloop_tport *tport);
> +static void fcloop_tport_put(struct fcloop_tport *tport);
> +
>   struct fcloop_nport {
>   	struct fcloop_rport *rport;
>   	struct fcloop_tport *tport;
> @@ -426,6 +430,7 @@ fcloop_tport_lsrqst_work(struct work_struct *work)
>   		spin_lock(&tport->lock);
>   	}
>   	spin_unlock(&tport->lock);
> +	fcloop_tport_put(tport);
>   }
>   
>   static int
> @@ -444,12 +449,16 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
>   	tls_req->lsreq = lsreq;
>   	INIT_LIST_HEAD(&tls_req->ls_list);
>   
> +	if (!tport)
> +		return -ECONNABORTED;
> +
>   	if (!tport->remoteport) {
>   		tls_req->status = -ECONNREFUSED;
>   		spin_lock(&tport->lock);
>   		list_add_tail(&tls_req->ls_list, &tport->ls_list);
>   		spin_unlock(&tport->lock);
> -		queue_work(nvmet_wq, &tport->ls_work);
> +		if (queue_work(nvmet_wq, &tport->ls_work))
> +			fcloop_tport_get(tport);

Don't you need to remove the 'tls_req' from the list, too, seeing that
it'll never be transferred?

>   		return ret;
>   	}
>   
> @@ -481,7 +490,8 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
>   		spin_lock(&tport->lock);
>   		list_add_tail(&tport->ls_list, &tls_req->ls_list);
>   		spin_unlock(&tport->lock);
> -		queue_work(nvmet_wq, &tport->ls_work);
> +		if (queue_work(nvmet_wq, &tport->ls_work))
> +			fcloop_tport_get(tport);

Same argument here.

>   	}
>   
>   	return 0;
> @@ -1496,6 +1506,8 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
>   
>   	/* success */
>   	tport = targetport->private;
> +	kref_init(&tport->ref);
> +
>   	tport->targetport = targetport;
>   	tport->remoteport = (nport->rport) ?  nport->rport->remoteport : NULL;
>   	if (nport->rport)
> @@ -1526,21 +1538,30 @@ __unlink_target_port(struct fcloop_nport *nport)
>   	return tport;
>   }
>   
> -static int
> -__targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
> +static void
> +fcloop_targetport_unreg(struct kref *ref)
>   {
> -	int ret;
> +	struct fcloop_tport *tport =
> +		container_of(ref, struct fcloop_tport, ref);
> +	struct fcloop_nport *nport;
>   
> -	if (!tport) {
> -		ret = -EALREADY;
> -		goto out;
> -	}
> +	nport = tport->nport;
> +	nvmet_fc_unregister_targetport(tport->targetport);
>   
> -	ret = nvmet_fc_unregister_targetport(tport->targetport);
> -out:
>   	/* nport ref put: targetport */
>   	fcloop_nport_put(nport);
> -	return ret;
> +}
> +
> +static int
> +fcloop_tport_get(struct fcloop_tport *tport)
> +{
> +	return kref_get_unless_zero(&tport->ref);
> +}
> +
> +static void
> +fcloop_tport_put(struct fcloop_tport *tport)
> +{
> +	kref_put(&tport->ref, fcloop_targetport_unreg);
>   }
>   
>   static ssize_t
> @@ -1576,8 +1597,7 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
>   	if (!nport)
>   		return -ENOENT;
>   
> -	ret = __targetport_unreg(nport, tport);
> -
> +	fcloop_tport_put(tport);
>   	fcloop_nport_put(nport);
>   
Hmm. Are we sure that the 'tport' reference is always > 1 here? 
Otherwise we'll end up with a funny business when the tport is deleted
yet the nport still has a reference ..

>   	return ret ? ret : count;
> @@ -1696,9 +1716,7 @@ static void __exit fcloop_exit(void)
>   
>   		spin_unlock_irqrestore(&fcloop_lock, flags);
>   
> -		ret = __targetport_unreg(nport, tport);
> -		if (ret)
> -			pr_warn("%s: Failed deleting target port\n", __func__);
> +		fcloop_tport_put(tport);
>   
>   		ret = __remoteport_unreg(nport, rport);
>   		if (ret)
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

