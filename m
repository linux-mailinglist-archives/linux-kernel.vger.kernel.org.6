Return-Path: <linux-kernel+bounces-425483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EA39DC2B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADAAB1635B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA4F1993B4;
	Fri, 29 Nov 2024 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zCFNZLZZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u+rlv321";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zCFNZLZZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u+rlv321"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40291586C8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879188; cv=none; b=UIgxixQMI/jtEmYpTwuxR6uzVNsQtL4zHEmNIIOMm2oSFSM8s9gPHdpL8AwCOWx3LKCAXNVtbCb5f8xhb5joXHnWYVUYxnL+8BmnuTGsMwpGFnbnlbAvRP0l12vLIot5+PCwFiPS0uoJ+UOBJiyhFmab3PlMSj2oHf5Kf3PBV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879188; c=relaxed/simple;
	bh=6AJQyHfuQbPNsE8C0ZMFTxZMTxPqQ5yQNda70pagKYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CadAGSWZ8F2tHSCmzMDkVrap4DhzXoBgsukmhPH4EWxCcYftzJIRfEEQCZ/OTPY0XypZiG1FdYNmPLuY5+LhFvoRzYRNEbrsDEfUZnyWHTQ7HU/DgQO8RpTtIad3TeQ25G7uO7TVNYaFZeW92cTXzRyQxMWL7GE4phuPrvVhl0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zCFNZLZZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u+rlv321; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zCFNZLZZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u+rlv321; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B0841F391;
	Fri, 29 Nov 2024 11:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732879185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dxewv+ZQ19+cuNwv74XXnOunHnyc/SxCPMWbrvUDyE4=;
	b=zCFNZLZZxahuzDcEUvtj+1NaXmCAHVTxIAUC5kJWwpN2nkCFvU3zro17qARlMo9bV++K7D
	ASuAuKqbTyz9W77bCDxIzCSEYEfpm5jrSX2NpfmyvzTTipRb/qorOK70iTKEBhD5zMb7Lq
	2SbvEYp1wgjbbGH95TqPuOKvA5MMfUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732879185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dxewv+ZQ19+cuNwv74XXnOunHnyc/SxCPMWbrvUDyE4=;
	b=u+rlv321fG4h3Rhl7oFArLCmm5cKd8iZgsWD9jALYSvWdEDlDfsiULc8QfzC/7j/pHW56Y
	W2CBhNtxzp8FnNBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732879185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dxewv+ZQ19+cuNwv74XXnOunHnyc/SxCPMWbrvUDyE4=;
	b=zCFNZLZZxahuzDcEUvtj+1NaXmCAHVTxIAUC5kJWwpN2nkCFvU3zro17qARlMo9bV++K7D
	ASuAuKqbTyz9W77bCDxIzCSEYEfpm5jrSX2NpfmyvzTTipRb/qorOK70iTKEBhD5zMb7Lq
	2SbvEYp1wgjbbGH95TqPuOKvA5MMfUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732879185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dxewv+ZQ19+cuNwv74XXnOunHnyc/SxCPMWbrvUDyE4=;
	b=u+rlv321fG4h3Rhl7oFArLCmm5cKd8iZgsWD9jALYSvWdEDlDfsiULc8QfzC/7j/pHW56Y
	W2CBhNtxzp8FnNBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7EC3139AA;
	Fri, 29 Nov 2024 11:19:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 60ImOFCjSWcBdQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 Nov 2024 11:19:44 +0000
Message-ID: <c2ae3a29-be3c-40f0-aae2-f36123cd04f6@suse.de>
Date: Fri, 29 Nov 2024 12:19:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvme-tcp: simplify nvme_tcp_configure_admin_queue()
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1732368538.git.chunguang.xu@shopee.com>
 <c7006c36681afce811e01de7686d6e2df2c4ab0e.1732368538.git.chunguang.xu@shopee.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c7006c36681afce811e01de7686d6e2df2c4ab0e.1732368538.git.chunguang.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,brookxu.cn:url]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 11/23/24 14:37, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> As nvme_tcp_configure_admin_queue() is the only one caller of
> nvme_tcp_destroy_admin_queue(), so we can merge nvme_tcp_configure_admin_queue()
> into nvme_tcp_destroy_admin_queue() to simplify the code.
> 
> Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
> ---
>   drivers/nvme/host/tcp.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

