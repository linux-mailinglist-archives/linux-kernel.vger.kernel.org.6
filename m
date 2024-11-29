Return-Path: <linux-kernel+bounces-425480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AD09DC2AD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3656281DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CDC199254;
	Fri, 29 Nov 2024 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fv+mCb7t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4SNVyG6f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QJzsne8p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KyWikaCs"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057341586C8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879092; cv=none; b=d95I8LOkcnHRmnnJUErNyKGwWbnZw/1JZZLsumIn+FBME9CAr2h/wxVBlGpBWmrrseaLSi01Ob5le92fKz39DVBcLYDIgRRomgo5Gi1AfHU4l3NMInsgnJJBLykCnCMFRYqJLyrebmB5mzdIwmYfPZrxSYWHPp3vKsOwibiuvdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879092; c=relaxed/simple;
	bh=3RovqooUo+PIuRrtiEHtlJI+kTlptyhV00BBqysLBb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZPiAQ8BxZWgE4Z7eq5WImIixliXAlY4lPVubLqtcegFL/YorqBFNdBSvLy+irMlUA8DkUtseCFNpzO58oH7vkFkHPasdcA0PtX06PVdPyesrwHSXbltYm1K6Y0Xz38PR42TXhacZffNsOerFaePgpjw8m8JzbI0sCIRVieiAwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fv+mCb7t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4SNVyG6f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QJzsne8p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KyWikaCs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3AFD621197;
	Fri, 29 Nov 2024 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732879089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1Br6gKgS6fdL0INNJuCKNg12N758dkumekrEVk6lDk=;
	b=fv+mCb7tXQlaixleEODXnkPMZAXZAtmQlARaw34olChGLtzZa5K5hMTf6wBMEKJdNsY2Pd
	K4I8HJS+oFKj+E+OneBseGCMr9CkxMPVDpi5LM41XLgo+oNHeAUSaXHxPrUQhGmzp9BHWY
	HxL4X3BaPiQcERkHWhwu237Cs76JGII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732879089;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1Br6gKgS6fdL0INNJuCKNg12N758dkumekrEVk6lDk=;
	b=4SNVyG6fgofRN6bDsXppyue/2JVCBLvnt+tYnmUyS5S/OzKMrPWFUNVwxMy312S4o6tN/a
	NywUhbktkVLnsgAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732879088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1Br6gKgS6fdL0INNJuCKNg12N758dkumekrEVk6lDk=;
	b=QJzsne8pwKChjl/SD6WevgaQYgU/E2/uC9ps3tnOJjVVRmtwkh0dHP5E/OA0uogkzTVZF7
	WgALFIOS4zy60mP4FgcZr+4tOl+r/2hxB8/yaSyUfhwmeStOwpE9EivGjb5DHGHdglLDe0
	q3g9nfzpFKCSPK99Cm/w8Vsa/Xmy080=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732879088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1Br6gKgS6fdL0INNJuCKNg12N758dkumekrEVk6lDk=;
	b=KyWikaCsAwQLbqV6QGUbkOG0Ul5Y67D5JntY+AZXcAu0ewZ+6E8s4WNjdqgCVmrTORgdYw
	+O9kxsegzH9DC6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23758139AA;
	Fri, 29 Nov 2024 11:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SeEoCPCiSWeGdAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 Nov 2024 11:18:08 +0000
Message-ID: <6fb58b24-cb51-4287-a66c-61eabc4412c8@suse.de>
Date: Fri, 29 Nov 2024 12:18:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] nvme-rdma: unquiesce admin_q before destroy it
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1732368538.git.chunguang.xu@shopee.com>
 <9379940137a8dfddb451917c1d069eebaf3c209e.1732368538.git.chunguang.xu@shopee.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <9379940137a8dfddb451917c1d069eebaf3c209e.1732368538.git.chunguang.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/23/24 14:37, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Kernel will hang on destroy admin_q while we create ctrl failed, such
> as following calltrace:
> 
> PID: 23644    TASK: ff2d52b40f439fc0  CPU: 2    COMMAND: "nvme"
>   #0 [ff61d23de260fb78] __schedule at ffffffff8323bc15
>   #1 [ff61d23de260fc08] schedule at ffffffff8323c014
>   #2 [ff61d23de260fc28] blk_mq_freeze_queue_wait at ffffffff82a3dba1
>   #3 [ff61d23de260fc78] blk_freeze_queue at ffffffff82a4113a
>   #4 [ff61d23de260fc90] blk_cleanup_queue at ffffffff82a33006
>   #5 [ff61d23de260fcb0] nvme_rdma_destroy_admin_queue at ffffffffc12686ce [nvme_rdma]
>   #6 [ff61d23de260fcc8] nvme_rdma_setup_ctrl at ffffffffc1268ced [nvme_rdma]
>   #7 [ff61d23de260fd28] nvme_rdma_create_ctrl at ffffffffc126919b [nvme_rdma]
>   #8 [ff61d23de260fd68] nvmf_dev_write at ffffffffc024f362 [nvme_fabrics]
>   #9 [ff61d23de260fe38] vfs_write at ffffffff827d5f25
>      RIP: 00007fda7891d574  RSP: 00007ffe2ef06958  RFLAGS: 00000202
>      RAX: ffffffffffffffda  RBX: 000055e8122a4d90  RCX: 00007fda7891d574
>      RDX: 000000000000012b  RSI: 000055e8122a4d90  RDI: 0000000000000004
>      RBP: 00007ffe2ef079c0   R8: 000000000000012b   R9: 000055e8122a4d90
>      R10: 0000000000000000  R11: 0000000000000202  R12: 0000000000000004
>      R13: 000055e8122923c0  R14: 000000000000012b  R15: 00007fda78a54500
>      ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
> 
> This due to we have quiesced admi_q before cancel requests, but forgot
> to unquiesce before destroy it, as a result we fail to drain the
> pending requests, and hang on blk_mq_freeze_queue_wait() forever. Here
> try to reuse nvme_rdma_teardown_admin_queue() to fix this issue and
> simplify the code.
> 
> Reported-by: Yingfu.zhou <yingfu.zhou@shopee.com>
> Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
> Signed-off-by: Yue.zhao <yue.zhao@shopee.com>
> ---
>   drivers/nvme/host/rdma.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

