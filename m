Return-Path: <linux-kernel+bounces-253393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6204932078
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EA51F222B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D441CAA2;
	Tue, 16 Jul 2024 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a/PpPfko";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WENOgmqs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a/PpPfko";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WENOgmqs"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859BA182DB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721111875; cv=none; b=QNSGvFbtDlxVb9mwPZ4fum+ywMCEkwceVzYoSEnlqufYlyExyCOgwmEAxxt3Yqy5vC194nK24c3hUZvrwtx8xH4o3PcNsagwcBYywF1y4hcL6hLCQtSawLqxJFdPfnP+7XFg4ksS2Sg7oAks3skCiG47cLVKjEFfc76YHQie9K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721111875; c=relaxed/simple;
	bh=RZMsYtzapgd4VTDdTakmYPesFeTxlvXWemrusJGW2YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dF/Gy3p0GzQAEmyvaO86VwnLQ2QevdRw8c0Wza4VpqT4eVxNHjtxaeVGrFU6o1Ace1JxnI2TMYAkstwemMvvI2VeaUD8j+5TV1CAATE5tow+1w5auZSWgQXNrIwcQjp80xvnfM9jzTYU+e7QTJDKVP0dmTbzllPOn9zAwve8Xtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a/PpPfko; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WENOgmqs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a/PpPfko; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WENOgmqs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 895CE21B85;
	Tue, 16 Jul 2024 06:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721111871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5FJuK6Fis1UUpg2efJbAlxag0NrAZFB4KfL5+Ws1fWg=;
	b=a/PpPfkofETW1WBPdP98fVMx01HQux4U6F8lyrkxkHCYaMkZqncG97ALZrGGKRnKdg9vh2
	L0DPIsZG4aDUBHH5LgPYq3EwZznqrz1HhjeU2B1ODW4FhcCb8CzdjQk8RujyLoOIxyuCof
	2y5cVcKvxTPKJIKTIaCb+MzJB/YWVSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721111871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5FJuK6Fis1UUpg2efJbAlxag0NrAZFB4KfL5+Ws1fWg=;
	b=WENOgmqs0gBL1zZRcJuXc/1QrYkpBNDnN/hz1+a21LeG1WST0qw7I5kjkEs8fBlSri/cq4
	R6rESkosGyXZJcBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721111871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5FJuK6Fis1UUpg2efJbAlxag0NrAZFB4KfL5+Ws1fWg=;
	b=a/PpPfkofETW1WBPdP98fVMx01HQux4U6F8lyrkxkHCYaMkZqncG97ALZrGGKRnKdg9vh2
	L0DPIsZG4aDUBHH5LgPYq3EwZznqrz1HhjeU2B1ODW4FhcCb8CzdjQk8RujyLoOIxyuCof
	2y5cVcKvxTPKJIKTIaCb+MzJB/YWVSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721111871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5FJuK6Fis1UUpg2efJbAlxag0NrAZFB4KfL5+Ws1fWg=;
	b=WENOgmqs0gBL1zZRcJuXc/1QrYkpBNDnN/hz1+a21LeG1WST0qw7I5kjkEs8fBlSri/cq4
	R6rESkosGyXZJcBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 051C813808;
	Tue, 16 Jul 2024 06:37:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oddROzwVlmbJZQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 16 Jul 2024 06:37:48 +0000
Message-ID: <c99a0d82-e76d-4ed8-afc3-e26be5497ba2@suse.de>
Date: Tue, 16 Jul 2024 08:37:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme_core: scan namespaces asynchronously
Content-Language: en-US
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Cc: Martin Wilck <martin.wilck@suse.com>,
 Ayush Siddarath <ayush.siddarath@dell.com>
References: <20240715203434.20212-1-stuart.w.hayes@gmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240715203434.20212-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,kernel.dk,lst.de,grimberg.me,lists.infradead.org];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 

On 7/15/24 22:34, Stuart Hayes wrote:
> Use async function calls to make namespace scanning happen in parallel.
> 
> Without the patch, NVME namespaces are scanned serially, so it can take
> a long time for all of a controller's namespaces to become available,
> especially with a slower (TCP) interface with large number of
> namespaces.
> 
> It is not uncommon to have large numbers (hundreds or thousands) of
> namespaces on nvme-of with storage servers.
> 
> The time it took for all namespaces to show up after connecting (via
> TCP) to a controller with 1002 namespaces was measured on one system:
> 
> network latency   without patch   with patch
>       0                 6s            1s
>      50ms             210s           10s
>     100ms             417s           18s
> 
> Measurements taken on another system show the effect of the patch on the
> time nvme_scan_work() took to complete, when connecting to a linux
> nvme-of target with varying numbers of namespaces, on a network of
> 400us.
> 
> namespaces    without patch   with patch
>       1            16ms           14ms
>       2            24ms           16ms
>       4            49ms           22ms
>       8           101ms           33ms
>      16           207ms           56ms
>     100           1.4s           0.6s
>    1000          12.9s           2.0s
> 
> On the same system, connecting to a local PCIe NVMe drive (a Samsung
> PM1733) instead of a network target:
> 
> namespaces    without patch   with patch
>       1            13ms           12ms
>       2            41ms           13ms
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
> changes from V2:
>    * make a separate function nvme_scan_ns_async() that calls
>      nvme_scan_ns(), instead of modifying nvme_scan_ns()
>    * only scan asynchronously from nvme_scan_ns_list(), not from
>      nvme_scan_ns_sequential()
>    * provide more timing data in the commit message
> 
> changes from V1:
>    * remove module param to enable/disable async scanning
>    * add scan time measurements to commit message
> 
> 
>   drivers/nvme/host/core.c | 48 +++++++++++++++++++++++++++++++++-------
>   1 file changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 782090ce0bc1..dbf05cfea063 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4,6 +4,7 @@
>    * Copyright (c) 2011-2014, Intel Corporation.
>    */
>   
> +#include <linux/async.h>
>   #include <linux/blkdev.h>
>   #include <linux/blk-mq.h>
>   #include <linux/blk-integrity.h>
> @@ -3952,6 +3953,30 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	}
>   }
>   
> +/*
> + * struct async_scan_info - keeps track of controller & NSIDs to scan
> + * @ctrl:	Controller on which namespaces are being scanned
> + * @next_idx:	Index of next NSID to scan in ns_list
> + * @ns_list:	Pointer to list of NSIDs to scan
> + */
> +struct async_scan_info {
> +	struct nvme_ctrl *ctrl;
> +	atomic_t next_idx;
> +	__le32 *ns_list;
> +};
> +
> +static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
> +{
> +	struct async_scan_info *scan_info = data;
> +	int idx;
> +	u32 nsid;
> +
> +	idx = (u32)atomic_fetch_add(1, &scan_info->next_idx);
> +	nsid = le32_to_cpu(scan_info->ns_list[idx]);
> +
> +	nvme_scan_ns(scan_info->ctrl, nsid);
> +}
> +
>   static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   					unsigned nsid)
>   {
> @@ -3975,12 +4000,14 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>   {
>   	const int nr_entries = NVME_IDENTIFY_DATA_SIZE / sizeof(__le32);
> -	__le32 *ns_list;
> +	struct async_scan_info scan_info;
>   	u32 prev = 0;
>   	int ret = 0, i;
> +	ASYNC_DOMAIN(domain);
>   
> -	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
> -	if (!ns_list)
> +	scan_info.ctrl = ctrl;
> +	scan_info.ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
> +	if (!scan_info.ns_list)
>   		return -ENOMEM;
>   
>   	for (;;) {
> @@ -3990,28 +4017,33 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>   			.identify.nsid		= cpu_to_le32(prev),
>   		};
>   
> -		ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd, ns_list,
> -					    NVME_IDENTIFY_DATA_SIZE);
> +		ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd,
> +					   scan_info.ns_list,
> +					   NVME_IDENTIFY_DATA_SIZE);
>   		if (ret) {
>   			dev_warn(ctrl->device,
>   				"Identify NS List failed (status=0x%x)\n", ret);
>   			goto free;
>   		}
>   
> +		atomic_set(&scan_info.next_idx, 0);
>   		for (i = 0; i < nr_entries; i++) {
> -			u32 nsid = le32_to_cpu(ns_list[i]);
> +			u32 nsid = le32_to_cpu(scan_info.ns_list[i]);
>   
>   			if (!nsid)	/* end of the list? */
>   				goto out;
> -			nvme_scan_ns(ctrl, nsid);
> +			async_schedule_domain(nvme_scan_ns_async, &scan_info,
> +						&domain);
>   			while (++prev < nsid)
>   				nvme_ns_remove_by_nsid(ctrl, prev);
>   		}
> +		async_synchronize_full_domain(&domain);

Let me see if I get this right ...
You allocate 'scan_info' on the stack, so every call to
'async_schedule_domain()' in the loop will be using the same
scan_info context, right?
So each instance of nvme_scan_ns_async() will be using
whichever value is in 'next_idx', right?
Effectively making 'nvme_scan_ns_async()' completely free-floating,
spawning 'nr_entry' instances, and letting each instance pick whichever
nsid is (at the time of execution) the next one.

If that's the case then I would welcome some comments in the code, as
this is somewhat non-obvious. And it also spells out clearly why the
atomic 'next_idx' value is absolutely crucial to that mechanism, and
we don't want anyone getting wrong ideas by 'optimizing' that away.

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


