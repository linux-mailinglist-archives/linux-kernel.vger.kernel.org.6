Return-Path: <linux-kernel+bounces-566045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4360A67276
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657BE17E41D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C073D209F41;
	Tue, 18 Mar 2025 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sOeD/N6K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5mt6eYlr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sOeD/N6K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5mt6eYlr"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2635F1FCF47
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296810; cv=none; b=SM+Irf26qqagBA4X3PUGpOL5oOXn4t1x73jFdQg6984BJNGY4t6WliPLMSndLESiD9c3ZeXzXp1wf41Ym2dwAUqCnr+zDBnZLn/1TUwj6XZRRo3MTvYaw9IG1lfwYLC7AHFobC1P/19AbZuJ7keEbAaYFuWaJznhk57LK7YRP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296810; c=relaxed/simple;
	bh=6wpY+XDOn6KsOXqrYw1f8Gq4QpQhhshPGEthKg6Z9dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LC3hRAplFSzKkzJy/5bABcaBJdmze4fLiUleQNfojvV51WCzQPH938VoIpr8/X5JNomDJ+PkcfucSP+PcBfIcuvOEEP+4Z8S6OfuUXOlkzUU8XDbdq0ZtNUX24G25dnf9totyXD4FjSQ2m6br5Epw0E1+ylRMW1q1tQWBYMfGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sOeD/N6K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5mt6eYlr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sOeD/N6K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5mt6eYlr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E78E1F770;
	Tue, 18 Mar 2025 11:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkpWcV8vjw1AxUR4xh5y235IjxQ4E0Apreu9leHckp4=;
	b=sOeD/N6Kz9hSpx20SOy5JjfJdm2/krmFkfDpsQsm9qdnJQB8voNOeXhBdu86l/Ud7DUu3X
	3R+gDSdUlWi3eEoKWXj3RrwePsZc02FWhnmmv15MNWyoOliyxOjulc5ujKqjUNNF7WhI0p
	AWXsGG/mQGJZhtlWzQBtRu5+kRtCTCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkpWcV8vjw1AxUR4xh5y235IjxQ4E0Apreu9leHckp4=;
	b=5mt6eYlrmlShuWhqr9+sGQwa0BA4jJVWDuMSYjDKDkFhHs0nwPL70JAXIQJNUxn8NcI7KU
	oOMKkYzneNr2J3AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="sOeD/N6K";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5mt6eYlr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkpWcV8vjw1AxUR4xh5y235IjxQ4E0Apreu9leHckp4=;
	b=sOeD/N6Kz9hSpx20SOy5JjfJdm2/krmFkfDpsQsm9qdnJQB8voNOeXhBdu86l/Ud7DUu3X
	3R+gDSdUlWi3eEoKWXj3RrwePsZc02FWhnmmv15MNWyoOliyxOjulc5ujKqjUNNF7WhI0p
	AWXsGG/mQGJZhtlWzQBtRu5+kRtCTCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkpWcV8vjw1AxUR4xh5y235IjxQ4E0Apreu9leHckp4=;
	b=5mt6eYlrmlShuWhqr9+sGQwa0BA4jJVWDuMSYjDKDkFhHs0nwPL70JAXIQJNUxn8NcI7KU
	oOMKkYzneNr2J3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16823139D2;
	Tue, 18 Mar 2025 11:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gpUaBeZW2WdsSAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 11:20:06 +0000
Message-ID: <7c3f8b96-2629-4bac-b089-96437355ac91@suse.de>
Date: Tue, 18 Mar 2025 12:20:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/18] nvmet-fc: put ref when assoc->del_work is
 already scheduled
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-17-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250318-nvmet-fcloop-v3-17-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E78E1F770
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
> Do not leak the tgtport reference when the work is already scheduled.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 649afce908bbade0a843efc4b8b76105c164b035..e027986e35098acbe5f97dcbcc845b9d46b88923 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1087,7 +1087,8 @@ static void
>   nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
>   {
>   	nvmet_fc_tgtport_get(assoc->tgtport);
> -	queue_work(nvmet_wq, &assoc->del_work);
> +	if (!queue_work(nvmet_wq, &assoc->del_work))
> +		nvmet_fc_tgtport_put(assoc->tgtport);
>   }
>   
>   static bool
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

