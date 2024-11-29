Return-Path: <linux-kernel+bounces-425482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D3E9DC2B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00319B22011
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB111993B7;
	Fri, 29 Nov 2024 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pBLkYiO/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PBKpaYy1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rn3hSR8l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VfAawE1X"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF881993A3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879139; cv=none; b=f6t/F5h66rzlpvUORO+im8pPHiX8f+1slrNqxS/OuR5PIxrLhSh/7v1PYN3A1LLn9CPUawztRFGGnIR1nzd6wgPHJ6kj3uTYIM43vsBWN7CJkorEkP3FoHnQeGcYtelbrlW/zSIER0sDgMvruK2L9Jh8Ek/jljmCnL4TC634znI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879139; c=relaxed/simple;
	bh=Ac0yHvP/MJY4OnUOA6dlp9nx4KaF79jMCWG0lCTBpeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyBkhuScsopn6GhTdhREJ1tmF3duPak3KJkieR/zpCMSMbNCDDqXA7Ras9dbjJL+vL2Hh8xcR0REO6jzNJ3AmMKF18oE68/KIibDskGV31LOJgDKxitmeSra0yFqwWQTy248yjEKrklnT2vtpEwlCrXrAy4oTcoR4OdqR+VfZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pBLkYiO/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PBKpaYy1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rn3hSR8l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VfAawE1X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1F751F391;
	Fri, 29 Nov 2024 11:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732879135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6NbRZTiMaRHXP3i5mnvV0WgISU2CGtziKf9MHF1EoQ=;
	b=pBLkYiO/0MtDqCFO5eX9uDoh8UeLUsI0Xq81UIEc4YEnmpSBGN6dN35gBNsAfx58wmYKcI
	eDSvJUPQmjm4ot5UcpBa1fOSEeq+5JxAnEyfozUICjnHFqhEQUHGAlRSTtQ1VJIGl+h4Cn
	Os3YGBJ3qHtrLaulCFFogQ7MUp6Eqaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732879135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6NbRZTiMaRHXP3i5mnvV0WgISU2CGtziKf9MHF1EoQ=;
	b=PBKpaYy1NkeZX2Ib8THmNz0sk/73By0eb7FpBhQEhzTSpsX93M4ry5No+aZYkqphPbhuPL
	pw1hjRSlcTo6ksAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rn3hSR8l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VfAawE1X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732879134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6NbRZTiMaRHXP3i5mnvV0WgISU2CGtziKf9MHF1EoQ=;
	b=rn3hSR8l1pQpDRTgX2qZjbS0USlnpAxGci/67kOdr09eM8qyD8FR8CBNcyq3N6xf99rRks
	tpLmb9sBchqJrJLwC/xwTwal9Df2obyQClZvhsfCPgNllhh8aUknikp7dQbesKohEPdz1J
	vgpMhFmOHcrX8x0bQH7XrkUYrPCgahY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732879134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6NbRZTiMaRHXP3i5mnvV0WgISU2CGtziKf9MHF1EoQ=;
	b=VfAawE1X91EPKw6EOaA/vi3sAd1q1YOHFcS6e3iq2E+ofWEeO1iwpygXBc0xyvnpqBMno3
	a8SCkDr2jdsMvoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0C4F139AA;
	Fri, 29 Nov 2024 11:18:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p+CaJh6jSWfHdAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 Nov 2024 11:18:54 +0000
Message-ID: <d0d17416-bcf2-415d-bc8c-ba2589e048ad@suse.de>
Date: Fri, 29 Nov 2024 12:18:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] nvme-tcp: no need to quiesec admin_q in
 nvme_tcp_teardown_io_queues()
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1732368538.git.chunguang.xu@shopee.com>
 <e7c1d7b531cef5fdd2764719e4ca824477579083.1732368538.git.chunguang.xu@shopee.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e7c1d7b531cef5fdd2764719e4ca824477579083.1732368538.git.chunguang.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C1F751F391
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 11/23/24 14:37, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> As we quiesec admin_q in nvme_tcp_teardown_admin_queue(), so we should no
> need to quiesec it in nvme_tcp_reaardown_io_queues(), make things simple.
> 

quiesce ...

> Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
> ---
>   drivers/nvme/host/tcp.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 3e416af2659f..47d8f10b1f75 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2178,7 +2178,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>   {
>   	if (ctrl->queue_count <= 1)
>   		return;
> -	nvme_quiesce_admin_queue(ctrl);
>   	nvme_quiesce_io_queues(ctrl);
>   	nvme_sync_io_queues(ctrl);
>   	nvme_tcp_stop_io_queues(ctrl);

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

