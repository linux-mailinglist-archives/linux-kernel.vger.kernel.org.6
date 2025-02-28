Return-Path: <linux-kernel+bounces-537892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85721A4922A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293967A79BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6C71C75E2;
	Fri, 28 Feb 2025 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X8MAj09H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QhtE9e1x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wyl467bd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/o3lPyX/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DFD276D12
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727799; cv=none; b=cujfMnAMKuUZAxty76kkpzfhP0il1IbspyiJuN9Vxl/8ay8nTiKza0XXBjrU6qPrisSWo/QWFjvaPIK4xhcIKWLBDevfsK1YUlN8a7JLt8siWCaCqJi4YKxD0ma9j6Sb1lPMS+B/fBDzwRTDJtymjfKqMWrtIR5E7lbRbNS3Ma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727799; c=relaxed/simple;
	bh=0zN4f1+L9LdPrHry+A+G7fmUO0cTFvNV1tCK8DaWg+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KClJhKjuoXsJm5gj1LG3S/+iXErdP/59m1hNF3E1WDHwhevAat91zP1Z1EGPe6HerSdw7wQQ0RUAu9o55xC304Bj1gKBYr34+D3/9cAs0HcOUYmW62leSvXXX22ZdBizEti0K06mJGe9bPOT30ILnVr7783TiUBvNlOqpnXWwJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X8MAj09H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QhtE9e1x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wyl467bd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/o3lPyX/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5EC21F38F;
	Fri, 28 Feb 2025 07:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740727796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2/1IpDiGvbmm1xwAmPe6In42i/zSc4rgCKQylXwqu4=;
	b=X8MAj09HueHceDkqzcczaTMLFFjjssekxR1qFHVDpdoG94o9OEOaIXwhc5dbRw3yIzXQSG
	54qUI/e/wni5YZGxFFYVt/vY59ybVa7iz9IVA1SOyyaYL1sCXBnbk9sCv0k75HhU3KkAHE
	/QL5WqYcbSjQEzrQNnxQXUeInXxzNpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740727796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2/1IpDiGvbmm1xwAmPe6In42i/zSc4rgCKQylXwqu4=;
	b=QhtE9e1xDlWijjfK1fm6Qk63fAJmz6ZXtX0P7XNgJSZdR+6rjbJPikeoD9ao3sz0N8T/fl
	gJ0Gp+mfKqbdZqBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Wyl467bd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/o3lPyX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740727795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2/1IpDiGvbmm1xwAmPe6In42i/zSc4rgCKQylXwqu4=;
	b=Wyl467bdL1zo1AqjhSJPTQOGkHQBPdChSi1QczWPv/WfnOFwnG3YZ3vqHcjhvnrG5c/GbA
	ZBgsE/cg07TolqMvzY2YbmqtOC3YaDw9FG/jkb0zS4szW2jpYTEfBumNfwRCljkfd437K2
	ACe/xaOC7yJZbFfQdWet73a/rll1/HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740727795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2/1IpDiGvbmm1xwAmPe6In42i/zSc4rgCKQylXwqu4=;
	b=/o3lPyX/xt5PLzJIWOMqXeIaOTWef7yYgk1JusQxfsDULwWjuvu2CnrDHnxQsTainEHvCO
	s/zSFtA1I5kyqTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82C78137AC;
	Fri, 28 Feb 2025 07:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XLhtHvNlwWflJQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:29:55 +0000
Message-ID: <1ee44bb6-df3c-4903-9bdd-0c7728500c18@suse.de>
Date: Fri, 28 Feb 2025 08:29:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] nvmet-fcloop: track rport with ref counting
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-6-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-6-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E5EC21F38F
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 2/26/25 19:45, Daniel Wagner wrote:
> The rport object is created via nvme_fc_register_remote and freed
> via nvme_fc_unregister_remoteport. That means after the port is
> unregistered nothing should use it. Thus ensure with refcounting
> that there is no user left before the unregister step.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 53 ++++++++++++++++++++++++++------------------
>   1 file changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 2269b4d20af2ef9bb423617b94a5f5326ea124bd..d64f5fba136e13c9e4e545acecd905c31542d442 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -223,8 +223,12 @@ struct fcloop_rport {
>   	spinlock_t			lock;
>   	struct list_head		ls_list;
>   	struct work_struct		ls_work;
> +	struct kref			ref;
>   };
>   
> +static int fcloop_rport_get(struct fcloop_rport *rport);
> +static void fcloop_rport_put(struct fcloop_rport *rport);
> +
>   struct fcloop_tport {
>   	struct nvmet_fc_target_port	*targetport;
>   	struct nvme_fc_remote_port	*remoteport;
> @@ -346,6 +350,7 @@ fcloop_rport_lsrqst_work(struct work_struct *work)
>   		spin_lock(&rport->lock);
>   	}
>   	spin_unlock(&rport->lock);
> +	fcloop_rport_put(rport);
>   }
>   
>   static int
> @@ -365,7 +370,8 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
>   		spin_lock(&rport->lock);
>   		list_add_tail(&tls_req->ls_list, &rport->ls_list);
>   		spin_unlock(&rport->lock);
> -		queue_work(nvmet_wq, &rport->ls_work);
> +		if (queue_work(nvmet_wq, &rport->ls_work))
> +			fcloop_rport_get(rport);

Same argument than previously: don't we need to remove 'tls_req' from 
the list on failure?

>   		return ret;
>   	}
>   
> @@ -398,7 +404,8 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
>   		spin_lock(&rport->lock);
>   		list_add_tail(&tls_req->ls_list, &rport->ls_list);
>   		spin_unlock(&rport->lock);
> -		queue_work(nvmet_wq, &rport->ls_work);
> +		if (queue_work(nvmet_wq, &rport->ls_work))
> +			fcloop_rport_get(rport);

Same here.

>   	}
>   
>   	return 0;
> @@ -1078,9 +1085,6 @@ fcloop_localport_delete(struct nvme_fc_local_port *localport)
>   static void
>   fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
>   {
> -	struct fcloop_rport *rport = remoteport->private;
> -
> -	flush_work(&rport->ls_work);
>   }

Empty function.

>   
>   static void
> @@ -1386,6 +1390,8 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
>   
>   	/* success */
>   	rport = remoteport->private;
> +	kref_init(&rport->ref);
> +
>   	rport->remoteport = remoteport;
>   	rport->targetport = (nport->tport) ?  nport->tport->targetport : NULL;
>   	if (nport->tport) {
> @@ -1418,21 +1424,30 @@ __unlink_remote_port(struct fcloop_nport *nport)
>   	return rport;
>   }
>   
> -static int
> -__remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
> +static void
> +fcloop_remoteport_unreg(struct kref *ref)
>   {
> -	int ret;
> +	struct fcloop_rport *rport =
> +		container_of(ref, struct fcloop_rport, ref);
> +	struct fcloop_nport *nport;
>   
> -	if (!rport) {
> -		ret = -EALREADY;
> -		goto out;
> -	}
> +	nport = rport->nport;
> +	nvme_fc_unregister_remoteport(rport->remoteport);
>   
> -	ret = nvme_fc_unregister_remoteport(rport->remoteport);
> -out:
>   	/* nport ref put: remoteport */
>   	fcloop_nport_put(nport);
> -	return ret;
> +}
> +
> +static int
> +fcloop_rport_get(struct fcloop_rport *rport)
> +{
> +	return kref_get_unless_zero(&rport->ref);
> +}
> +
> +static void
> +fcloop_rport_put(struct fcloop_rport *rport)
> +{
> +	kref_put(&rport->ref, fcloop_remoteport_unreg);
>   }
>   
>   static ssize_t
> @@ -1468,8 +1483,7 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
>   	if (!nport)
>   		return -ENOENT;
>   
> -	ret = __remoteport_unreg(nport, rport);
> -
> +	fcloop_rport_put(rport);
>   	fcloop_nport_put(nport);
>   
>   	return ret ? ret : count;
> @@ -1717,10 +1731,7 @@ static void __exit fcloop_exit(void)
>   		spin_unlock_irqrestore(&fcloop_lock, flags);
>   
>   		fcloop_tport_put(tport);
> -
> -		ret = __remoteport_unreg(nport, rport);
> -		if (ret)
> -			pr_warn("%s: Failed deleting remote port\n", __func__);
> +		fcloop_rport_put(rport);
>   
>   		spin_lock_irqsave(&fcloop_lock, flags);
>   	}
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

