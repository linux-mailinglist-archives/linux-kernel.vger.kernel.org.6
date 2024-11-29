Return-Path: <linux-kernel+bounces-425471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76B69DC289
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524C016090B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C20C1990BB;
	Fri, 29 Nov 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sz3ZbBAh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nEdJY8ZY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sz3ZbBAh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nEdJY8ZY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B8155726
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732878637; cv=none; b=MPe+unaJ/EGHaBT8p2/x3DcZW4iMAbGl19WRtZ1Pt4/1EvszkWHhR7lVyxeqBMuL/FpSexOslONdyC/8Y0OfkU+fpYJQlNPbdeq0uUiTmc5zzF/VPLWxCp4nQFqluooSlb63+luWzg2CjYxre70cY2oFSVzrFOf42Cjq/2Nn5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732878637; c=relaxed/simple;
	bh=jcYe9ZSpCAYGrpJ8DH0Yk80WSwa14u24SDm8MDzrVa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HU6BM6HQvlMUHPASUYvzltblc+QXjH935J462EUEC7ZQGwz7D4ld0lnuJdNYBk26jA2SpKG2vf/tJo7avdxetoDa8XEQgyJHTUN6r8nB/4asHUWiMKOh/+rapKQNlJN0EzmHcJBOqgAkbmnkF0stq+iCIBF65qepbE4G5YtFM5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sz3ZbBAh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nEdJY8ZY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sz3ZbBAh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nEdJY8ZY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F29A41F441;
	Fri, 29 Nov 2024 11:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732878634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2S6TBTKDPxzVGSQs9OZvrP05SS/MmouEfTAv0pNjxk=;
	b=sz3ZbBAh2Er5Cpt48LlZbWsWtT3p9XLZjAJ0mI9LVA8hlxzltRA2ngFjwc1K8lzsYkpYiQ
	URcRHBC2u3kgB7rMzoW6+Bd3kM1Y+7WLV8fbqUdGMzYc+pS/NOkSS7qVtdH2aY59I+JXGH
	6ILvEr1iuJ0jjStVtTWTP58T7D/Jnrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732878634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2S6TBTKDPxzVGSQs9OZvrP05SS/MmouEfTAv0pNjxk=;
	b=nEdJY8ZY60WKY3QC9QV2eArF5QkkVKSqcCZD3O96gdbsFqxzUqqT5AjKBR238GrC21F+K+
	lahj86XXD8wsuUCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732878634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2S6TBTKDPxzVGSQs9OZvrP05SS/MmouEfTAv0pNjxk=;
	b=sz3ZbBAh2Er5Cpt48LlZbWsWtT3p9XLZjAJ0mI9LVA8hlxzltRA2ngFjwc1K8lzsYkpYiQ
	URcRHBC2u3kgB7rMzoW6+Bd3kM1Y+7WLV8fbqUdGMzYc+pS/NOkSS7qVtdH2aY59I+JXGH
	6ILvEr1iuJ0jjStVtTWTP58T7D/Jnrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732878634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2S6TBTKDPxzVGSQs9OZvrP05SS/MmouEfTAv0pNjxk=;
	b=nEdJY8ZY60WKY3QC9QV2eArF5QkkVKSqcCZD3O96gdbsFqxzUqqT5AjKBR238GrC21F+K+
	lahj86XXD8wsuUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA1AB139AA;
	Fri, 29 Nov 2024 11:10:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xZS+LymhSWf7cQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 Nov 2024 11:10:33 +0000
Message-ID: <e89d0b3b-e4a1-4ae5-8250-c15e3a843e76@suse.de>
Date: Fri, 29 Nov 2024 12:10:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 11/29/24 10:28, Daniel Wagner wrote:
> When the set feature attempts fails with any NVME status code set in
> nvme_set_queue_count, the function still report success. Though the
> numbers of queues set to 0. This is done to support controllers in
> degraded state (the admin queue is still up and running but no IO
> queues).
> 
> Though there is an exception. When nvme_set_features reports an host
> path error, nvme_set_queue_count should propagate this error as the
> connectivity is lost, which means also the admin queue is not working
> anymore.
> 
> Fixes: 9a0be7abb62f ("nvme: refactor set_queue_count")
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/core.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2a07c2c540b26c8cbe886711abaf6f0afbe6c4df..aa2a7c7d4d0ae7bd1f7fb704e55c0a8d724b9d56 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1677,7 +1677,12 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>   
>   	status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, NULL, 0,
>   			&result);
> -	if (status < 0)
> +	/*
> +	 * It's either a kernel error or the host observed a connection
> +	 * lost. In either case it's not possible communicate with the
> +	 * controller and thus enter the error code path.
> +	 */
> +	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
>   		return status;
>   
>   	/*
> 
Hmm. Maybe checking for NVME_SC_DNR, too?

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

