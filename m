Return-Path: <linux-kernel+bounces-428812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEED9E13D9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3123CB213BD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225E189F36;
	Tue,  3 Dec 2024 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sTFlhZC6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zbdjAzaA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sTFlhZC6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zbdjAzaA"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291CD1885B4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210365; cv=none; b=TSWsZklgbJ3Z/HkCaHE25Zo6SsgMrF6vVQXB/q78ZG5BM9zgr6D51ISvHenrTVUhKtQ5k1rJamRAzR5YBKGpcJUBOSsd4nPVBN8jO9lC1BLkypR+7YXIT+JqhbjqD2TWTReXJNsusVBA9JbDPqh7h7wa6TvbMjf1rPXb55bIMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210365; c=relaxed/simple;
	bh=L+KIBr+P2JlHeaWPFuMYtu71JGMklQf9EldIhXnWrtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTKOmLUkTct+ZOeHugk1maMc8/hoduMcf3jHQKLonA6rAYEmdYtSZB8JHlq3dKutJX3aMJt1KknvXC8xj2+EhzH+h587M9A9zDDFAkiDRdOviKmEOLkLfDkcO5l8DlGuEuE9TwlLdpbrfQR1yuG2vlzB/1CvJb6RIgXESQMqB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sTFlhZC6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zbdjAzaA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sTFlhZC6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zbdjAzaA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3281E1F445;
	Tue,  3 Dec 2024 07:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733210362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDGofa4W4irmZgNhRHaGIFQMOW+vlknfrJB9XllaAzI=;
	b=sTFlhZC61pLD+EdeHkxsxirk8UqojISVEuqXHcKKzxgQo3WNw5WDIyOf7sRGTy0mSVZ0lT
	nmxk+RFGfaOzHAyOIEI+DTSXOXE4VmIOztdb6zyFLu8Iq6llOQAzgaYyTpijBESt9OGhYo
	bwq5PcYUL3fE1z7EQLCMebLbFs+2gek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733210362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDGofa4W4irmZgNhRHaGIFQMOW+vlknfrJB9XllaAzI=;
	b=zbdjAzaACmnBIVdehhDY/7ZCam9b84JPTxuG2+nkZ5H1DyUnWOzd2dCWt7xNGDjHDTIbTw
	6SX3z9ZvLhDXthAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733210362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDGofa4W4irmZgNhRHaGIFQMOW+vlknfrJB9XllaAzI=;
	b=sTFlhZC61pLD+EdeHkxsxirk8UqojISVEuqXHcKKzxgQo3WNw5WDIyOf7sRGTy0mSVZ0lT
	nmxk+RFGfaOzHAyOIEI+DTSXOXE4VmIOztdb6zyFLu8Iq6llOQAzgaYyTpijBESt9OGhYo
	bwq5PcYUL3fE1z7EQLCMebLbFs+2gek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733210362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDGofa4W4irmZgNhRHaGIFQMOW+vlknfrJB9XllaAzI=;
	b=zbdjAzaACmnBIVdehhDY/7ZCam9b84JPTxuG2+nkZ5H1DyUnWOzd2dCWt7xNGDjHDTIbTw
	6SX3z9ZvLhDXthAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB8DE13A15;
	Tue,  3 Dec 2024 07:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z9jiM/mwTmdpKAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Dec 2024 07:19:21 +0000
Message-ID: <d1b103bb-fc9b-45dc-b637-75ce9fdb320c@suse.de>
Date: Tue, 3 Dec 2024 08:19:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] nvme-tcp: fix the memleak while create new ctrl
 failed
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: lengchao@huawei.com
References: <cover.1733196360.git.chunguang.xu@shopee.com>
 <b4957fa602ebb3af58872042d8e3bf1adf3b386b.1733196360.git.chunguang.xu@shopee.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b4957fa602ebb3af58872042d8e3bf1adf3b386b.1733196360.git.chunguang.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,lists.infradead.org,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 12/3/24 04:34, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Now while we create new ctrl failed, we have not free the
> tagset occupied by admin_q, here try to fix it.
> 
> Fixes: fd1418de10b9 ("nvme-tcp: avoid open-coding nvme_tcp_teardown_admin_queue()")
> Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 3e416af2659f..55abfe5e1d25 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2278,7 +2278,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   	}
>   destroy_admin:
>   	nvme_stop_keep_alive(ctrl);
> -	nvme_tcp_teardown_admin_queue(ctrl, false);
> +	nvme_tcp_teardown_admin_queue(ctrl, new);
>   	return ret;
>   }
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

