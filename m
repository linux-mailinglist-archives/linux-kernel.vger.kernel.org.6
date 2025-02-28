Return-Path: <linux-kernel+bounces-537903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 355FCA49249
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57DA1893964
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E34C1C5D6C;
	Fri, 28 Feb 2025 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AXFSpdRh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/tzdDutD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AXFSpdRh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/tzdDutD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEDB18CC15
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740728203; cv=none; b=jr8yk7ZUqHJl7nRi2WkMqA/Q/IrrhHDOISrrzonb0Yr8PtFA1HOOWAYLAvKJhUsCWFU+eENH4/DBMX+laiDsHO8bCFo/M1hSkEwNISjOSRKzIrIG6RiqYdsMZgtfwQFfzfrVedFhO6avjVLp/pbrqV97OevdjsBiWbLovMdz0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740728203; c=relaxed/simple;
	bh=DPaO9XP/TgRwYjW5miFJkDnz0yRbf8A2MrwadvMC+qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0Qydod7ROwDLSQz16CnwLYMWZ9I7DnmUIw/j+dXI0Qx4pPlBnfgFjf5VdaNt8I1CpYrG080veBEfGDMCMX7vRyyaB9RFB8W0dkWlhSCqxZET41zVTdkheUCgv9jj6tpI5+FHTMiPDKSSDusf/HU53OvpM3DG2FvHeePHuR/SiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AXFSpdRh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/tzdDutD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AXFSpdRh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/tzdDutD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45F421F38F;
	Fri, 28 Feb 2025 07:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740728200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHG9IWymsbAXOiqL6b/BqstO5zPJX9KPvKAy7Q9m6f0=;
	b=AXFSpdRhb7L5O9Vs0RDvQ9QU8c3CqzMmXXm2XpZkhOJFK/poxrr9ljlMdgAM7Fw+bkHq43
	L5YeroXonWf3G8j8jEZZPU5wULqM2Pcb0n1k9iqD1FJB8z1fVNazV/fe6D8L6rq76Lf9Lr
	b9hDOKAvIGbDNr5tqt/giP8LNuioDfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740728200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHG9IWymsbAXOiqL6b/BqstO5zPJX9KPvKAy7Q9m6f0=;
	b=/tzdDutDEG5KYgHAEaC7ezKyWtFSxwDvsGv9Cb3EnCPzrKPCIClei6sL7nBVVDSlz+3RT0
	4UdBi13zIS6q9oAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AXFSpdRh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/tzdDutD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740728200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHG9IWymsbAXOiqL6b/BqstO5zPJX9KPvKAy7Q9m6f0=;
	b=AXFSpdRhb7L5O9Vs0RDvQ9QU8c3CqzMmXXm2XpZkhOJFK/poxrr9ljlMdgAM7Fw+bkHq43
	L5YeroXonWf3G8j8jEZZPU5wULqM2Pcb0n1k9iqD1FJB8z1fVNazV/fe6D8L6rq76Lf9Lr
	b9hDOKAvIGbDNr5tqt/giP8LNuioDfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740728200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHG9IWymsbAXOiqL6b/BqstO5zPJX9KPvKAy7Q9m6f0=;
	b=/tzdDutDEG5KYgHAEaC7ezKyWtFSxwDvsGv9Cb3EnCPzrKPCIClei6sL7nBVVDSlz+3RT0
	4UdBi13zIS6q9oAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA8EB137AC;
	Fri, 28 Feb 2025 07:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LqLENodnwWciKAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:36:39 +0000
Message-ID: <157bb905-0ffb-4d8c-ad82-0ea74b6aa423@suse.de>
Date: Fri, 28 Feb 2025 08:36:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] nvmet-fc: inline nvmet_fc_delete_assoc
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-10-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-10-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 45F421F38F
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 2/26/25 19:46, Daniel Wagner wrote:
> There is only one user for this helper function, just inline it.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fc.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
But maybe a comment is in order.
Other than that:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

