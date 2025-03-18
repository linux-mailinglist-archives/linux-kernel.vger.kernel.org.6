Return-Path: <linux-kernel+bounces-566072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526D8A672CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86D217B22F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05DE20B1FC;
	Tue, 18 Mar 2025 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XhZx3e3O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0zPd2rH4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XhZx3e3O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0zPd2rH4"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA631598F4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297610; cv=none; b=tWeuFHFbcofu6vuyEUdhIbeOCW5mUCQtiOCOGIiYQSktDf3copfNP97gOF4+hZyQ+Stk/GoHnb0Dh1RMesBeVAj+98PnKYWvLHkomJ7GmqWzPH090VtjApuWH25WdZa60PUPyr5S7+NibZ3yQbQb43JcsmUORznzWQfBLeYb7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297610; c=relaxed/simple;
	bh=0JJ4RDM1xE0FaGWSYaJr2Q4a5ZuSqx1CdMya5vjvDgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sp2CCkiUPyaRWuZiXHTPaigFSUY2LBL4c01K97e4AZXM3SQ4USguhL/FzorqopOtIzPv+CaWCfD1ckebngOOC4JVe29Pe7lXN+02Irflda2ROGkVVkdagwr90u8wkabWINt/At/pcM11S86J0ObiJmn1hOkk+P/BYacDZIWki8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XhZx3e3O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0zPd2rH4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XhZx3e3O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0zPd2rH4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F33321D45;
	Tue, 18 Mar 2025 11:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742297602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjNhfMgF5cB11e+1pTaUZPvaIvwkrpM75jYbR3au4EQ=;
	b=XhZx3e3O2pLIIQx8g+cUMz6/kEc+p8ChY4CPX+ldvbByem2Kvc5jBtKLV1LRKL9MIWod69
	pmwcR1SkfygTpzshgEOa426uOZkR+SQKaVm8flPXyodJxdnUyXvi7WRuNT7yINAYCI52lD
	vEKXKRYVIWkukmhVXsGM2gmtfYYmpgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742297602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjNhfMgF5cB11e+1pTaUZPvaIvwkrpM75jYbR3au4EQ=;
	b=0zPd2rH4KkQm9rljCX+os8+YVNdD7D0xaBTznwtzgyKJxcDyy5dSy5H1VqRkFq9Ab9ojzk
	XxrFqyNYXhxVd5CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XhZx3e3O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0zPd2rH4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742297602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjNhfMgF5cB11e+1pTaUZPvaIvwkrpM75jYbR3au4EQ=;
	b=XhZx3e3O2pLIIQx8g+cUMz6/kEc+p8ChY4CPX+ldvbByem2Kvc5jBtKLV1LRKL9MIWod69
	pmwcR1SkfygTpzshgEOa426uOZkR+SQKaVm8flPXyodJxdnUyXvi7WRuNT7yINAYCI52lD
	vEKXKRYVIWkukmhVXsGM2gmtfYYmpgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742297602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjNhfMgF5cB11e+1pTaUZPvaIvwkrpM75jYbR3au4EQ=;
	b=0zPd2rH4KkQm9rljCX+os8+YVNdD7D0xaBTznwtzgyKJxcDyy5dSy5H1VqRkFq9Ab9ojzk
	XxrFqyNYXhxVd5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75F60139D2;
	Tue, 18 Mar 2025 11:33:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oHleHAJa2WemTAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 11:33:22 +0000
Message-ID: <e4d7f84a-dd29-4b7a-a831-a8555125bf43@suse.de>
Date: Tue, 18 Mar 2025 12:33:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/18] nvme-fc: do not reference lsrsp after failure
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-18-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250318-nvmet-fcloop-v3-18-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F33321D45
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/18/25 11:40, Daniel Wagner wrote:
> The lsrsp object is maintained by the LLDD. The lifetime of the lsrsp
> object is implicit. Because there is no explicit cleanup/free call into
> the LLDD, it is not safe to assume after xml_rsp_fails, that the lsrsp
> is still valid. The LLDD could have freed the object already.
> 
> With the recent changes how fcloop tracks the resources, this is the
> case. Thus don't access lsrsp after xml_rsp_fails.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fc.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index b9929a5a7f4e3f3a03953379aceb90f0c1a0b561..2c32ba9ee688d7a683bbbf8fc57a5f9b32b2ab8d 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1410,9 +1410,8 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
>   }
>   
>   static void
> -nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
> +nvme_fc_xmt_ls_rsp_free(struct nvmefc_ls_rcv_op *lsop)
>   {
> -	struct nvmefc_ls_rcv_op *lsop = lsrsp->nvme_fc_private;
>   	struct nvme_fc_rport *rport = lsop->rport;
>   	struct nvme_fc_lport *lport = rport->lport;
>   	unsigned long flags;
> @@ -1433,6 +1432,14 @@ nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
>   	nvme_fc_rport_put(rport);
>   }
>   
> +static void
> +nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
> +{
> +	struct nvmefc_ls_rcv_op *lsop = lsrsp->nvme_fc_private;
> +
> +	nvme_fc_xmt_ls_rsp_free(lsop);
> +}
> +
>   static void
>   nvme_fc_xmt_ls_rsp(struct nvmefc_ls_rcv_op *lsop)
>   {
> @@ -1450,7 +1457,7 @@ nvme_fc_xmt_ls_rsp(struct nvmefc_ls_rcv_op *lsop)
>   		dev_warn(lport->dev,
>   			"LLDD rejected LS RSP xmt: LS %d status %d\n",
>   			w0->ls_cmd, ret);
> -		nvme_fc_xmt_ls_rsp_done(lsop->lsrsp);
> +		nvme_fc_xmt_ls_rsp_free(lsop);
>   		return;
>   	}
>   }
> 
Hmm. That is a weird change. 'lsop->lsrsp' clearly _was_ valid just before:

         ret = lport->ops->xmt_ls_rsp(&lport->localport, &rport->remoteport,
                                      lsop->lsrsp);
         if (ret) {
                 dev_warn(lport->dev,
                         "LLDD rejected LS RSP xmt: LS %d status %d\n",
                         w0->ls_cmd, ret);
                 nvme_fc_xmt_ls_rsp_done(lsop->lsrsp);
                 return;
         }

so ->xmt_ls_rsp() would have invalidated one of the arguments.
Plus 'nvme_fc_xmt_ls_rsp_done()' is now a wrapper around
'nvme_fc_xmt_ls_rsp_free()'.
So why not go the full length and kill nvme_fc_xmt_ls_rsp_done()
completely?
Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

