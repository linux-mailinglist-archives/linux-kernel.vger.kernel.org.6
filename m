Return-Path: <linux-kernel+bounces-566033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641ADA6724F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78217188A5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7A4209F32;
	Tue, 18 Mar 2025 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kc/jFaQc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jFN+f2lV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UJe0+rvu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yz5n/f5m"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014D620A5DA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296380; cv=none; b=AyWciIoqF4aC4sz2ulAt5dRRk6cfgQfVI7m6SoERRxBSaC9MvU4XgaOMt7+4ab47cmw63hPRH7sYnpTwNVf2XPGQ4hz6GkQU0ron//nAk/pQrTg2TWlf50tKrwkRqCGJM/ovQHQN17SG3ds0F6m8VmDgqSTRtZ+gmBtlAc0BX34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296380; c=relaxed/simple;
	bh=wx2dKFebsqZvpsPvAL2QBtRvq4I5qZBmzFoFGZ4kmnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTrhNoHYQo4l+b7dIsPbAUCMGDKTOnaCGroub21PWYt1Zrp+fNJkBp4tRvjB+Y6hHsoaVRbCuKL3ByVDBeZrB9gz9l5HL3ABy7Cv8QCtFrz4Y5AVKhWxe0ZIBy2bDUEeXpJ+YUUqum7JTEQPHs5XgDPvwudoR0NOBhLTdBX2o5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kc/jFaQc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jFN+f2lV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UJe0+rvu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yz5n/f5m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDEEB21D70;
	Tue, 18 Mar 2025 11:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GrTPr+9H+uTMuotGDlXGlcKau+e/ayYakcC6kEnp0U=;
	b=kc/jFaQcoT91AMmy1Gugsf1Sd+nox9MrunLKlnBQKE3s0wr+F3nNrqCg9DNjheKhqvuvCT
	1aNdS/ZXwn/iWo9r4XobPF3lmDBt8usy/M9nlkcP/oFQm+F3FlcKMrvPd99ev2sDtvMuuX
	3tDy2KEL2Et1oxDP5TfmU185GlikhME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GrTPr+9H+uTMuotGDlXGlcKau+e/ayYakcC6kEnp0U=;
	b=jFN+f2lVR0hJIKBsZ1i+6sykIk19UOdMUMffAPKnniAocUKHyQloC9r6HjOIqDXgK7SMlr
	QJz/RpC24JO/ibBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UJe0+rvu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="yz5n/f5m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GrTPr+9H+uTMuotGDlXGlcKau+e/ayYakcC6kEnp0U=;
	b=UJe0+rvuz5bALWxnBzvPFyKHDB3uZs6bbIrhe2FGTAgKjFELgx4Ctwr6pPMb9lVHPbqwIh
	Qf4APy/owk0RkPTZDzvT8uwAsHKvhXU91qk5qL8Y8Npw1EfCAIfbib1q1xaKjzqLqp3eu8
	kuP+PSme4j+/x56RPv6QahugJ9qSc7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GrTPr+9H+uTMuotGDlXGlcKau+e/ayYakcC6kEnp0U=;
	b=yz5n/f5mFVlyA8GB+hk0wmDg2idH1mSZnuGh2h6AqZkFt8lOnVGDudYpSm4w7eLwg6psta
	9B6RZeOVRrYuDMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF0AC139D2;
	Tue, 18 Mar 2025 11:12:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h/PILTRV2Wf1RQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 11:12:52 +0000
Message-ID: <931e5618-f85c-43ed-96a2-696c23a57857@suse.de>
Date: Tue, 18 Mar 2025 12:12:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/18] nvmet-fcloop: add missing
 fcloop_callback_host_done
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-8-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250318-nvmet-fcloop-v3-8-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EDEEB21D70
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/18/25 11:40, Daniel Wagner wrote:
> Add the missing fcloop_call_host_done calls so that the caller
> frees resources when something goes wrong.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index cadf081e3653c641b0afcb0968fc74299ab941d1..de23f0bc5599b6f8dd5c3713dd38c952e6fdda28 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -966,9 +966,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
>   	}
>   	spin_unlock(&inireq->inilock);
>   
> -	if (!tfcp_req)
> +	if (!tfcp_req) {
>   		/* abort has already been called */
> +		fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);

Am I misreading things or will fcloop_call_host_done() crash on a NULL 
tfcp_req ?
In patch 3 fcloop_tfcp_req_put() doesn't check for a NULL argument...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

