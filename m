Return-Path: <linux-kernel+bounces-425486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7289DC2BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD86B20D31
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957FD19993B;
	Fri, 29 Nov 2024 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wo1TciVR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lFIssojt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wo1TciVR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lFIssojt"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699EC19922A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879351; cv=none; b=uV/cEahFADgSjmEVEOKpuEvZijLXRLfL/NhsqG16kVvRKXfLBb5u2obaYfDK9Vc1pq7oSbsQkzKrcvJCqbfsyWQWbfxeMxys2uLHP2Mf4taYgg9TYW2lXbrraNneFnqZwxkwXN+Ra5wsTJvX9VhRebfmLrBGy/JQd81tXLYD/ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879351; c=relaxed/simple;
	bh=nOEzfSOch1vU8LsCwWJj51oTq/cQS+6xmXwyYk2YBTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knBv24PYUOVk9fnUER9Abo/LkCDdpWyturd7IhQ8bH0/MuZpYfc+1HmP1qoIXMsbHQHHJCC29gdMBq7WvsUAC8fcP4z6RqMV72sOF1iRDJ5qUjxAr4ApRURAMR7T/oyxBb2TXRNvFfUej//xO7TUnn5y1q602mZXDTqeym1+NYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wo1TciVR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lFIssojt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wo1TciVR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lFIssojt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7055821194;
	Fri, 29 Nov 2024 11:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732879348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkIcuv4zvKc/Ky5+4gGdgUoFdA3gukAna1bPUsXhfUQ=;
	b=wo1TciVRtXy44E3NEdIwMLQ64DOtETKtbvsaDD6oWQ+oSGolwmIh5RQOfk3SV9kRK54Xm2
	9yJU+Q+bV4rmg3PQk0kvssmHE5MtNOyYtJ7nzkQcUgk/B1MpVkZfzcBIeCMZ2xzFjzxeRt
	MfUw39rnG20nfJasFvR324RnHKnnWwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732879348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkIcuv4zvKc/Ky5+4gGdgUoFdA3gukAna1bPUsXhfUQ=;
	b=lFIssojt/4OBLFPtdEkL66mLUi4jfunj5jo3aoVAw9hID7oEmPsBZkTdVIyMZPl4a4D2bl
	bpRKVkiRY7ZlkbCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wo1TciVR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lFIssojt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732879348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkIcuv4zvKc/Ky5+4gGdgUoFdA3gukAna1bPUsXhfUQ=;
	b=wo1TciVRtXy44E3NEdIwMLQ64DOtETKtbvsaDD6oWQ+oSGolwmIh5RQOfk3SV9kRK54Xm2
	9yJU+Q+bV4rmg3PQk0kvssmHE5MtNOyYtJ7nzkQcUgk/B1MpVkZfzcBIeCMZ2xzFjzxeRt
	MfUw39rnG20nfJasFvR324RnHKnnWwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732879348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkIcuv4zvKc/Ky5+4gGdgUoFdA3gukAna1bPUsXhfUQ=;
	b=lFIssojt/4OBLFPtdEkL66mLUi4jfunj5jo3aoVAw9hID7oEmPsBZkTdVIyMZPl4a4D2bl
	bpRKVkiRY7ZlkbCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26967139AA;
	Fri, 29 Nov 2024 11:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tXP3CPSjSWfVdQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 Nov 2024 11:22:28 +0000
Message-ID: <b8aea2c6-1bc3-4033-9d42-19d90377f4e5@suse.de>
Date: Fri, 29 Nov 2024 12:22:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nvme-tcp: remove nvme_tcp_destroy_io_queues()
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1732368538.git.chunguang.xu@shopee.com>
 <5afd7d60a07afc6f299aba8c31fe87e00484da5b.1732368538.git.chunguang.xu@shopee.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5afd7d60a07afc6f299aba8c31fe87e00484da5b.1732368538.git.chunguang.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7055821194
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,brookxu.cn:url,shopee.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 11/23/24 14:37, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Now maybe we can remove nvme_tcp_destroy_io_queues() to simplify
> the code and avoid unnecessary call of nvme_tcp_stop_io_queues().
> 
> Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
> ---
>   drivers/nvme/host/tcp.c | 32 ++++++++++++++------------------
>   1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 45cbaa7523e6..57f0f0290cc8 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2024,14 +2024,6 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   	return __nvme_tcp_alloc_io_queues(ctrl);
>   }
>   
> -static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
> -{
> -	nvme_tcp_stop_io_queues(ctrl);
> -	if (remove)
> -		nvme_remove_io_tag_set(ctrl);
> -	nvme_tcp_free_io_queues(ctrl);
> -}
> -
>   static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   {
>   	int ret, nr_queues;
> @@ -2170,15 +2162,17 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
>   static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>   		bool remove)
>   {
> -	if (ctrl->queue_count <= 1)
> -		return;
> -	nvme_quiesce_io_queues(ctrl);
> -	nvme_sync_io_queues(ctrl);
> -	nvme_tcp_stop_io_queues(ctrl);
> -	nvme_cancel_tagset(ctrl);
> -	if (remove)
> -		nvme_unquiesce_io_queues(ctrl);
> -	nvme_tcp_destroy_io_queues(ctrl, remove);
> +	if (ctrl->queue_count > 1) {
> +		nvme_quiesce_io_queues(ctrl);
> +		nvme_sync_io_queues(ctrl);
> +		nvme_tcp_stop_io_queues(ctrl);
> +		nvme_cancel_tagset(ctrl);
> +		if (remove) {
> +			nvme_unquiesce_io_queues(ctrl);
> +			nvme_remove_io_tag_set(ctrl);
> +		}
> +		nvme_tcp_free_io_queues(ctrl);
> +	}
>   }
>   
Please don't reorder the function; if you keep
the first 'if (ctrl->queue_count <= 1)' condition
you'll incur less churn and the patch is easier to read.

>   static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
> @@ -2267,7 +2261,9 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   		nvme_sync_io_queues(ctrl);
>   		nvme_tcp_stop_io_queues(ctrl);
>   		nvme_cancel_tagset(ctrl);
> -		nvme_tcp_destroy_io_queues(ctrl, new);
> +		if (new)
> +			nvme_remove_io_tag_set(ctrl);
> +		nvme_tcp_free_io_queues(ctrl);
>   	}
>   destroy_admin:
>   	nvme_stop_keep_alive(ctrl);

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

