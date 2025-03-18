Return-Path: <linux-kernel+bounces-566041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C02A67270
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BA317AB26
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5821208994;
	Tue, 18 Mar 2025 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LTiKxNJD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qSKWmec1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HvqBIsaI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="75fXAQJj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D592054F4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296763; cv=none; b=em9Hqsqq4KKQaKYmdADNFUwScdKZerCENNAn/6f4KklRJgmhxztFwbn4425/mcT7wUoLNf2GxVoZdjfmIpoX8PFcp5+z5ysBGlBjgILIy/xfekGN/z3uuKutGK8OVKhkwE6tiBcQCIb7KCAoXD3cU0EjumnYDEVjjqNaw4RfSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296763; c=relaxed/simple;
	bh=IFWY9zVrDGMCmRTI0JA4DCsxWRiaSB2cyOLwGW+IpnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxtEDycdWFE6BvJxyFxo+NvSTD0bvE9YNNbWC/u4OGmpbuHTTXgrPhlwLn3cgwAVYAoWUaAwZZ7yTzbZra0mjqcgf0HBaFcKvGZtxnQYU3XdkD/HIE7Fy9b/7EC9f/IIKlp+FiTaoSoC74X77c+YMyOOQlXguWjWdSU66eZJYB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LTiKxNJD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qSKWmec1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HvqBIsaI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=75fXAQJj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F26681F387;
	Tue, 18 Mar 2025 11:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVVEUOXAQw+oDN5WJXKpb97AcCW+wxh2Mx7vA18gV7w=;
	b=LTiKxNJDBt/gjmUGD2MSIayXqATZR6f+63auAUHciLuJ+QtqP/w69I3Zidp1yQpc0Hennr
	02yVemlru+Yc3kRrz8pybdx9Wgb0YwOoAEeqvkX/g/gEWX/03re543EoUbQG1TzW/onwRD
	kx1D3qlaVUVDKxm1aMzmrsw2vj937SI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVVEUOXAQw+oDN5WJXKpb97AcCW+wxh2Mx7vA18gV7w=;
	b=qSKWmec1m6MwLm/apnwU57uI8Bbn4poZtRr1iv5pN4aaXrZY6WBGVTbln2ta3JN1aRICGE
	HCV2exoPqxJ7gMBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HvqBIsaI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=75fXAQJj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVVEUOXAQw+oDN5WJXKpb97AcCW+wxh2Mx7vA18gV7w=;
	b=HvqBIsaI/T2sb5dfliuDSx4/rDZKxINLcJ0YiFG63oOOT7k9xT8pHg7DneHQKFd+gvkLyn
	EOTrDvv74xSy8XtCeBvWy4OB7E8rFz0zWBi1mlWDwD6gCWJtbvX8d6+8CCZNIIqc4xAkh5
	sXxd1YsL25d3X4IVdEcxYEXKwlsRoE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVVEUOXAQw+oDN5WJXKpb97AcCW+wxh2Mx7vA18gV7w=;
	b=75fXAQJjwUsV/l1nP4/dL3VAZL44YWCZRud/8Aei391sCR/S0RqgpCmYFb+vw4/n8U7nx2
	w3HIUTQSjOJ3BxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEF49139D2;
	Tue, 18 Mar 2025 11:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M7PzMbZW2WckSAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 11:19:18 +0000
Message-ID: <f0e47ac3-d736-458d-8ffc-f7648174aa93@suse.de>
Date: Tue, 18 Mar 2025 12:19:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/18] nvmet-fc: take tgtport refs for portentry
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-16-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250318-nvmet-fcloop-v3-16-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F26681F387
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,traddr.pn:url];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/18/25 11:40, Daniel Wagner wrote:
> Ensure that the tgtport is not going away as long portentry has a
> pointer on it.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fc.c | 45 +++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index d10ddcb57c1b09d871152f0d9a48f93ec6dc8685..649afce908bbade0a843efc4b8b76105c164b035 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1265,6 +1265,7 @@ nvmet_fc_portentry_bind(struct nvmet_fc_tgtport *tgtport,
>   {
>   	lockdep_assert_held(&nvmet_fc_tgtlock);
>   
> +	nvmet_fc_tgtport_get(tgtport);
>   	pe->tgtport = tgtport;
>   	tgtport->pe = pe;
>   
> @@ -1284,8 +1285,10 @@ nvmet_fc_portentry_unbind(struct nvmet_fc_port_entry *pe)
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
> -	if (pe->tgtport)
> +	if (pe->tgtport) {
> +		nvmet_fc_tgtport_put(pe->tgtport);
>   		pe->tgtport->pe = NULL;
> +	}
>   	list_del(&pe->pe_list);
>   	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
>   }
> @@ -1303,8 +1306,10 @@ nvmet_fc_portentry_unbind_tgt(struct nvmet_fc_tgtport *tgtport)
>   
>   	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
>   	pe = tgtport->pe;
> -	if (pe)
> +	if (pe) {
> +		nvmet_fc_tgtport_put(pe->tgtport);
>   		pe->tgtport = NULL;
> +	}
>   	tgtport->pe = NULL;
>   	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
>   }
> @@ -1327,6 +1332,9 @@ nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtport *tgtport)
>   	list_for_each_entry(pe, &nvmet_fc_portentry_list, pe_list) {
>   		if (tgtport->fc_target_port.node_name == pe->node_name &&
>   		    tgtport->fc_target_port.port_name == pe->port_name) {
> +			if (!nvmet_fc_tgtport_get(tgtport))
> +				continue;
> +
>   			WARN_ON(pe->tgtport);
>   			tgtport->pe = pe;
>   			pe->tgtport = tgtport;
> @@ -1664,7 +1672,6 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
>   }
>   EXPORT_SYMBOL_GPL(nvmet_fc_unregister_targetport);
>   
> -
>   /* ********************** FC-NVME LS RCV Handling ************************* */
>   
>   

Empty line ...

> @@ -2901,12 +2908,17 @@ nvmet_fc_add_port(struct nvmet_port *port)
>   	list_for_each_entry(tgtport, &nvmet_fc_target_list, tgt_list) {
>   		if ((tgtport->fc_target_port.node_name == traddr.nn) &&
>   		    (tgtport->fc_target_port.port_name == traddr.pn)) {
> +			if (!nvmet_fc_tgtport_get(tgtport))
> +				continue;
> +
>   			/* a FC port can only be 1 nvmet port id */
>   			if (!tgtport->pe) {
>   				nvmet_fc_portentry_bind(tgtport, pe, port);
>   				ret = 0;
>   			} else
>   				ret = -EALREADY;
> +
> +			nvmet_fc_tgtport_put(tgtport);
>   			break;
>   		}
>   	}
> @@ -2922,11 +2934,21 @@ static void
>   nvmet_fc_remove_port(struct nvmet_port *port)
>   {
>   	struct nvmet_fc_port_entry *pe = port->priv;
> +	struct nvmet_fc_tgtport *tgtport = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
> +	if (pe->tgtport && nvmet_fc_tgtport_get(pe->tgtport))
> +		tgtport = pe->tgtport;
> +	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
>   
>   	nvmet_fc_portentry_unbind(pe);
>   
> -	/* terminate any outstanding associations */
> -	__nvmet_fc_free_assocs(pe->tgtport);
> +	if (tgtport) {
> +		/* terminate any outstanding associations */
> +		__nvmet_fc_free_assocs(tgtport);
> +		nvmet_fc_tgtport_put(tgtport);
> +	}
>   
>   	kfree(pe);
>   }
> @@ -2935,10 +2957,21 @@ static void
>   nvmet_fc_discovery_chg(struct nvmet_port *port)
>   {
>   	struct nvmet_fc_port_entry *pe = port->priv;
> -	struct nvmet_fc_tgtport *tgtport = pe->tgtport;
> +	struct nvmet_fc_tgtport *tgtport = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
> +	if (pe->tgtport && nvmet_fc_tgtport_get(pe->tgtport))
> +		tgtport = pe->tgtport;
> +	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
> +
> +	if (!tgtport)
> +		return;
>   
>   	if (tgtport && tgtport->ops->discovery_event)
>   		tgtport->ops->discovery_event(&tgtport->fc_target_port);
> +
> +	nvmet_fc_tgtport_put(tgtport);
>   }
>   
>   static ssize_t
> 
Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

