Return-Path: <linux-kernel+bounces-537894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FD9A4922E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57727A7953
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19661A315E;
	Fri, 28 Feb 2025 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E5C+Spbg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AjTiQVwA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tACEYTI9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e/PWWNlu"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB7D70825
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727834; cv=none; b=GJxmFGyZ4vkuj9ElW7WaLuMEvZtBjAowpIHfK1o9pxZtYHS5ahjXGquACUocfuSDiPHMefB2pWtsaJjTWEAZXPBRr8aTkYt2Pxqv1biv5nagyyTIXsDi3Fl3DwvPFzZFxl9509VJZMSQ9XJAr+i5uctEQxIg92EULDjI2P4qZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727834; c=relaxed/simple;
	bh=5dhoBDNWmoUVbAtg7wQyl41dhQLzcTgQyGOUzwlfomc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFs0vXTZ2xsF6IoiqPYfHU99MGlCjTkME8K+Pi8r0CDyF/SDHI3SxVPqerRk1ekBakz5OkvVxY5T42CcA7jJmrFwqFHe1I1gY+oOPS/QeERJwey8ewb+J+IC/qGRVHq18HuzHNaRxELxyvVl0RsstqTFB8Vd/jwxgm7vVkgc29E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E5C+Spbg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AjTiQVwA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tACEYTI9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e/PWWNlu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9CA21F38F;
	Fri, 28 Feb 2025 07:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740727831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2y/c0l2fHNq7KB68P4bfrfS/sguf5lbwgb6Rj2LL9E=;
	b=E5C+SpbgRjd7KiorQoWRK4DrjJhSRjojXdvA5L1yXqWW7XSm6/064OLV6ZWWRnUgusa5wI
	7kUUIBm6gTvW0IECJHQ2Fh3Smn1BX9/+0C5Z9iM/Y1n9M7rfZP+R26MMh0MZaZ5F9Es4V/
	/RtlUJaMWwBgbwYAK431w3IbyyRPvQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740727831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2y/c0l2fHNq7KB68P4bfrfS/sguf5lbwgb6Rj2LL9E=;
	b=AjTiQVwAbvuJUEhI3lrONt1uCpDnCqOzBku1zUnxT0FOSmRYRKO1U/bBbi+6tjUuJQ6GvJ
	rLVuiILc+11+nWDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tACEYTI9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="e/PWWNlu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740727830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2y/c0l2fHNq7KB68P4bfrfS/sguf5lbwgb6Rj2LL9E=;
	b=tACEYTI9+X1rnJ7QJ3eKuGNCbLj/hRfoRC3CmWaqleL3CYvwAqPkcHY8Md+waplfIjp0VQ
	Ol6C6sEZP0VL2msIuDZcEah9aBRLPKdIUEMIHW2LxeV0EqZP3up4dHOTsRlmCv3rUNfMrO
	zn+W9tg2JVcsRvR9Y41WxzQ0GE6sX8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740727830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2y/c0l2fHNq7KB68P4bfrfS/sguf5lbwgb6Rj2LL9E=;
	b=e/PWWNluLXo+gKEd4nrZy3CRUN4YMhRJiZcMCJkDqDEvHI3z7tB/idzZhMWLpVcMGS5v+H
	uT4zcF89hkmvygBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86A17137AC;
	Fri, 28 Feb 2025 07:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XeQ1HxZmwWciJgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:30:30 +0000
Message-ID: <fbb3f6c7-a66d-4266-9fcd-ab82d14df5ed@suse.de>
Date: Fri, 28 Feb 2025 08:30:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] nvmet-fc: update tgtport ref per assoc
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-7-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-7-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9CA21F38F
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
> We need to take for each unique association a reference.
> nvmet_fc_alloc_hostport for each newly created association.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 3ef4beacde3257147a59321e8f13451326302de0..b807b4c05cac7fe4764df3df76f8fa50f4bab6ba 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1157,6 +1157,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   		goto out_ida;
>   
>   	assoc->tgtport = tgtport;
> +	nvmet_fc_tgtport_get(tgtport);
>   	assoc->a_id = idx;
>   	INIT_LIST_HEAD(&assoc->a_list);
>   	kref_init(&assoc->ref);
> @@ -1258,6 +1259,8 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
>   	dev_info(tgtport->dev,
>   		"{%d:%d} Association deleted\n",
>   		tgtport->fc_target_port.port_num, assoc->a_id);
> +
> +	nvmet_fc_tgtport_put(tgtport);
>   }
>   
>   static struct nvmet_fc_tgt_assoc *
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

