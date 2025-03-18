Return-Path: <linux-kernel+bounces-566035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2B0A67259
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C0D17B450
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1CA20AF74;
	Tue, 18 Mar 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Up/CP2Pc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jsAclGyC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Up/CP2Pc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jsAclGyC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002920ADEE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296511; cv=none; b=ui0mRcJ9ObqDsePy4X6pxDc36M5oBeKvel+TXDmeitsy+3tPgFLSAawaKtDVUvBOOUVscWriWkyt7tHkSEkh7X8qpxy67AifSi355veZUQN2vb2bgj6kTkAps9ktBjjWcVb9n7m/sVFzGaOnr6JqWdP0Kycl3b91vrtvhc1QSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296511; c=relaxed/simple;
	bh=lqM6h0WMipjB41dnk7gBbxBRN0uNy/SV5KE5M7hRihg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNMAvctRuoFtfdBc3mCJsqF5CcA0LZKhfzWHxVqMUZ2rCyU2c1g2uJFcmn7Pg3jZRxL7WsJan5Add/TNRm5Umt8ibJ3FWCUL8TwsZP3i8drZLZ4s8Wqj7GMVisWBw4zUiQSQHyo/EPeIJ2s6r0rvBJw1ZEsPwZRFkJN4BBd8H1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Up/CP2Pc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jsAclGyC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Up/CP2Pc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jsAclGyC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 760DB1F441;
	Tue, 18 Mar 2025 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lK4FI6TBa99gPApOkSgZRZPCkffoUDzt5gGtF1HAjQ8=;
	b=Up/CP2PctqYJVqC+gPSb9JGabGiWAFQUey5Hvrs1fLfOJYnjz71kt6WuIoHPtWhyBDd2NQ
	N1Yr4zYxe9smzHvv34ha1HaeJU9LtezwOSngNtDgWudbtf0/3VL3v6lIux7VHiBmpQMx2Y
	ecUwUipoHUkSWoF617WtK1KGhLiXhf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lK4FI6TBa99gPApOkSgZRZPCkffoUDzt5gGtF1HAjQ8=;
	b=jsAclGyCDERXY0hsJz0U9MHcrXH8dX4dcXQEk2tgGxJPAv0cigUcek4XoVk9/sM5+Je7ou
	vsVKLD72p5AOLfCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Up/CP2Pc";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jsAclGyC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lK4FI6TBa99gPApOkSgZRZPCkffoUDzt5gGtF1HAjQ8=;
	b=Up/CP2PctqYJVqC+gPSb9JGabGiWAFQUey5Hvrs1fLfOJYnjz71kt6WuIoHPtWhyBDd2NQ
	N1Yr4zYxe9smzHvv34ha1HaeJU9LtezwOSngNtDgWudbtf0/3VL3v6lIux7VHiBmpQMx2Y
	ecUwUipoHUkSWoF617WtK1KGhLiXhf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lK4FI6TBa99gPApOkSgZRZPCkffoUDzt5gGtF1HAjQ8=;
	b=jsAclGyCDERXY0hsJz0U9MHcrXH8dX4dcXQEk2tgGxJPAv0cigUcek4XoVk9/sM5+Je7ou
	vsVKLD72p5AOLfCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A970139D2;
	Tue, 18 Mar 2025 11:15:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rx5hFbhV2We9RgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 11:15:04 +0000
Message-ID: <e5c91532-6f35-4124-b32d-a47aa4ce972b@suse.de>
Date: Tue, 18 Mar 2025 12:15:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/18] nvmet-fcloop: prevent double port deletion
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-9-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250318-nvmet-fcloop-v3-9-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 760DB1F441
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

On 3/18/25 11:40, Daniel Wagner wrote:
> The delete callback can be called either via the unregister function or
> from the transport directly. Thus it is necessary ensure resources are
> not freed multiple times.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index de23f0bc5599b6f8dd5c3713dd38c952e6fdda28..06f42da6a0335c53ae319133119d057aab12e07e 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -215,6 +215,8 @@ struct fcloop_lport_priv {
>   	struct fcloop_lport *lport;
>   };
>   
> +#define PORT_DELETE	0
> +
>   struct fcloop_rport {
>   	struct nvme_fc_remote_port	*remoteport;
>   	struct nvmet_fc_target_port	*targetport;
> @@ -223,6 +225,7 @@ struct fcloop_rport {
>   	spinlock_t			lock;
>   	struct list_head		ls_list;
>   	struct work_struct		ls_work;
> +	unsigned long			flags;
>   };
>   
>   struct fcloop_tport {
> @@ -233,6 +236,7 @@ struct fcloop_tport {
>   	spinlock_t			lock;
>   	struct list_head		ls_list;
>   	struct work_struct		ls_work;
> +	unsigned long			flags;
>   };
>   
>   struct fcloop_nport {
> @@ -1062,14 +1066,20 @@ static void
>   fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
>   {
>   	struct fcloop_rport *rport = remoteport->private;
> +	bool delete_port = true;
>   	unsigned long flags;
>   
>   	flush_work(&rport->ls_work);
>   
>   	spin_lock_irqsave(&fcloop_lock, flags);
> +	if (test_and_set_bit(PORT_DELETE, &rport->flags))
> +		delete_port = false;
>   	rport->nport->rport = NULL;
>   	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
Can't you just check for a NULL rport->nport->rport pointer
and do away with the PORT_DELETE flag?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

