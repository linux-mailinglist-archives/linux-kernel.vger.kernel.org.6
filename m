Return-Path: <linux-kernel+bounces-558935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19724A5ED52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F073B6CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D821725FA1B;
	Thu, 13 Mar 2025 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d3f+Ib2h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vIiANh1P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d3f+Ib2h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vIiANh1P"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB851FBCB1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852289; cv=none; b=Y4stEp2uTVbGyd+3ElS9feK67b6sUF9VGB7sy4axFdsLWxm5RSZ0xQx9QSoIfZJ6YfvTZvzlyeKJukbSMfKkIXZ1y3BNlR3MaOFxP0trTcuNwWAeU+juP6Ge/3p58rIu6whx3pbFliGZQb4EzD0bUpA0YtdkkKWxFI3QBehSV20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852289; c=relaxed/simple;
	bh=6LE7xktakEC0NfoWDOJaDQw/3bV9KQop0BZOx1Kq8ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgvQixC6+1GclF99HTexPI6U2Tas//8pc8l8YwY4ECl7nSDMtynyGA4Tdmw0lQlPC67FBtbBb47cWPUJbIbOtaO1MKSupkONw5U6NpbMttZfu/eUeZpG6mv5EKLvoSfP8IyTuW1zdI+NPTgD5q1DlXN37Wl4PAb2efS3V1Tf258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d3f+Ib2h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vIiANh1P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d3f+Ib2h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vIiANh1P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 353C921180;
	Thu, 13 Mar 2025 07:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741852284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCJnaYfBV+bCveHsvLRPGjY00SQjzI4tFLM4k70eHG8=;
	b=d3f+Ib2hYiNQFRoP0LDfkid1rYwpV9Zec21KuIvdFIoiFt0o5uezAIxHRJWp2srC2df/ZW
	71DuQMIWGK0fXK6z9VpPWyhSn/VWkL6TTv7m2e7KHBdl5a3VB90GdHlkQhZBhqM0INa/cL
	7XYw/jRgrLe59vFn9KkprNLtuk/h5Ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741852284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCJnaYfBV+bCveHsvLRPGjY00SQjzI4tFLM4k70eHG8=;
	b=vIiANh1PBpqaqyWRcdGDgYPapfK3QDPw/xVwPB3zdoN+/N7EVZqWk1b5JsE0+aOTMhhoUc
	rHTNRMlEscRrblBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d3f+Ib2h;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vIiANh1P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741852284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCJnaYfBV+bCveHsvLRPGjY00SQjzI4tFLM4k70eHG8=;
	b=d3f+Ib2hYiNQFRoP0LDfkid1rYwpV9Zec21KuIvdFIoiFt0o5uezAIxHRJWp2srC2df/ZW
	71DuQMIWGK0fXK6z9VpPWyhSn/VWkL6TTv7m2e7KHBdl5a3VB90GdHlkQhZBhqM0INa/cL
	7XYw/jRgrLe59vFn9KkprNLtuk/h5Ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741852284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCJnaYfBV+bCveHsvLRPGjY00SQjzI4tFLM4k70eHG8=;
	b=vIiANh1PBpqaqyWRcdGDgYPapfK3QDPw/xVwPB3zdoN+/N7EVZqWk1b5JsE0+aOTMhhoUc
	rHTNRMlEscRrblBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEC48137BA;
	Thu, 13 Mar 2025 07:51:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OilfMHuO0mfrGQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 13 Mar 2025 07:51:23 +0000
Message-ID: <deb1584c-67b8-4543-9017-9ca18a9ee7d8@suse.de>
Date: Thu, 13 Mar 2025 08:51:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_nvme-tcp=3A_fix_a_possible_UAF_when_failing_to_send?=
 =?UTF-8?B?IHJlcXVlc3TjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFzYWdpZ3JpbUBnbWFpbC5j?=
 =?UTF-8?B?b23ku6Plj5HjgJE=?=
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>,
 Maurizio Lombardi <mlombard@bsdbackstore.eu>, sagi <sagi@grimberg.me>,
 mgurtovoy <mgurtovoy@nvidia.com>, kbusch <kbusch@kernel.org>,
 sashal <sashal@kernel.org>, "chunguang.xu" <chunguang.xu@shopee.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>
References: <2025021015413817916143@cestc.cn>
 <aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>
 <202503071810452687957@cestc.cn> <D8DDP6LIPOKB.2ACTHLE9FPI2A@bsdbackstore.eu>
 <2025031309485746586710@cestc.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <2025031309485746586710@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 353C921180
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/13/25 02:48, zhang.guanghui@cestc.cn wrote:
> Yes, the problem here is that,  despite the nvme_tcp_try_send() failure, the target sends a response capsule for the command, leading to a UAF in the host.
> 
> Is it more reasonable to disable queue->rd_enabled to prevent receiving. Thanks
>   
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index be04c5f3856d..17407eb12ad9 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1203,8 +1203,9 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>          } else if (ret < 0) {
>                  dev_err(queue->ctrl->ctrl.device,
>                          "failed to send request %d\n", ret);
> -               nvme_tcp_fail_request(queue->request);
>                  nvme_tcp_done_send_req(queue);
> +              queue->rd_enabled = false;
> +              nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>          }
>   out:
>          memalloc_noreclaim_restore(noreclaim_flag);
> 
> 
> 
Hmm. In principle, yes. Problem is that network is a bi-directional 
communication, and a failure on one side doesn't necessarily imply
a failure on the other.
In particular when the send side fails we should _continue_ to read
as we should be flushing the read side buffer before closing.

So I agree with starting error recovery, but not with disabling the 
reading side (as we haven't encountered a read error).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

