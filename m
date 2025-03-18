Return-Path: <linux-kernel+bounces-566022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F352FA67230
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6355D3A60B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8CF208989;
	Tue, 18 Mar 2025 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m40Xapsn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="68Du1+8E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ifrQOdj2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RB8Ytt3e"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE72080DB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296071; cv=none; b=j3mcEAqtasPKDVvCgVAOi0aJrlDDWy84xkluD0pVOqri4v7hlgC+GofCIO3tXtUcX74nTMgW6lxbEPM4cZK7YOsq05J21J03gxTyotiNX2hLAmcp2uLqAZYI83y3PEbdrxTXpY0gnLfua/yMKLoMyKqi+TSLYq+WvtO5/1TQUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296071; c=relaxed/simple;
	bh=qurSG2wtoT0SuIpw7x1lmKgxChkikWXIT1mXE8ZLYLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qiNKFlOpBXGqFldrLYHU6ZFaCaxMNrJuj0BUGRHIxGqe382z02OPzECSKIFSN9jrRURZdsnvWLvMSFBs6/5DeXLNf48hqI7XMSydCweVqqbVGmrXiTonyQlS/TtgTeuRssYnwB8DQmPKBFoUk0q9xlqdC7SdAHrIOOpsO3Q1/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m40Xapsn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=68Du1+8E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ifrQOdj2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RB8Ytt3e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E188E1F770;
	Tue, 18 Mar 2025 11:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/WpjUHUtGdaDqbnmCpkWrWmAJhxJemIw0zzHySCAVxk=;
	b=m40XapsnikFlOpmcZd1nDvPnTaNVcn6Or81ILt5UvXWQOh+kOVsziu1tPE7owvkVfskAYS
	3216+OHXlcWIpcuJf18QViCAXzJkWmCVoQGanqPOUQV8PkRaalT+3cFD3m5OXfn5m2sHmf
	oGqlHmKMXrn3bCi1UsK6PEP4J6AwD24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/WpjUHUtGdaDqbnmCpkWrWmAJhxJemIw0zzHySCAVxk=;
	b=68Du1+8ECHI9kHYmAQHBci5PBIRwxFPoq5W8rm1iZmq9WRW2kOKXvbdsUz+7V6z3ANntg1
	O4MvBR1BApWpyeBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ifrQOdj2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RB8Ytt3e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/WpjUHUtGdaDqbnmCpkWrWmAJhxJemIw0zzHySCAVxk=;
	b=ifrQOdj2bz6QW+/4WJ9l0MjEXf5LRAcBx5/vMR11F0aN6vjb6+EsTOfsuagi1ZskZARWlW
	cildu01vpICOu3AZGf/rJ5kxO7769bjEAABLdtI74f/t0+gB21u5csxmjE5WIko2gipKR4
	n15oBsj+kRI9cnLIOzzUWD1+jVKryQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/WpjUHUtGdaDqbnmCpkWrWmAJhxJemIw0zzHySCAVxk=;
	b=RB8Ytt3eHePj/YQTrU1QXK0FENQF+GGzdiZ/eQf4VxYdmK40VREH9OQ7qs0HPBUwlucaBA
	RgOklbMXqxQFuGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8E5C139D2;
	Tue, 18 Mar 2025 11:07:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mReKMANU2WdeRAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 11:07:47 +0000
Message-ID: <f1083a89-44af-4bce-ab09-4260f727a551@suse.de>
Date: Tue, 18 Mar 2025 12:07:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/18] nvmet-fcloop: sync targetport removal
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-6-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250318-nvmet-fcloop-v3-6-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E188E1F770
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/18/25 11:40, Daniel Wagner wrote:
> The nvmet-fc uses references on the targetport to ensure no UAFs
> happens. The consequence is that when the targetport is unregistered,
> not all resources are freed immediately. Ensure that all activities from
> the unregister call have been submitted (deassocication) before
> continuing with the shutdown sequence.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 69121a5f0f280936d1b720e9e994d6e5eb9186ff..cddaa424bb3ff62156cef14c787fdcb33c15d76e 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -239,6 +239,7 @@ struct fcloop_nport {
>   	struct fcloop_rport *rport;
>   	struct fcloop_tport *tport;
>   	struct fcloop_lport *lport;
> +	struct completion tport_unreg_done;
>   	struct list_head nport_list;
>   	refcount_t ref;
>   	u64 node_name;
> @@ -1078,6 +1079,8 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
>   	tport->nport->tport = NULL;
>   	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
> +	complete(&tport->nport->tport_unreg_done);
> +
>   	/* nport ref put: tport */
>   	fcloop_nport_put(tport->nport);
>   }
> @@ -1507,7 +1510,17 @@ __unlink_target_port(struct fcloop_nport *nport)
>   static int
>   __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
>   {
> -	return nvmet_fc_unregister_targetport(tport->targetport);
> +	int ret;
> +
> +	init_completion(&nport->tport_unreg_done);
> +
> +	ret = nvmet_fc_unregister_targetport(tport->targetport);
> +	if (ret)
> +		return ret;
> +
> +	wait_for_completion(&nport->tport_unreg_done);
> +
> +	return 0;
>   }
>   
>   static ssize_t
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

