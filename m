Return-Path: <linux-kernel+bounces-537861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DE3A491DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1C93AEF28
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CAE1C5496;
	Fri, 28 Feb 2025 07:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xXbDeQJ+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SONULh4V";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xXbDeQJ+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SONULh4V"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D8748F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726328; cv=none; b=H34AEtB0GEHkALYpPKPsnklfxm/F4TpxM3FDzUfO3pRyo7S7HAsWOTwCWy9QWAAMQbG3bLFZ0sXl+GZccg6LcXVx/2NQ3faNqfuJu4K8CT7YYAfSjhPGNgSti5m1wEyGXnBLbpqmQeAPZojOXX5afwCo8YwxEZIPQ9P3K/5eViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726328; c=relaxed/simple;
	bh=wbfWUxfN49elDRwxZVeTSvxHjccKY+GWftHii8xCfuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTkqd42P+LzcXuvmX09+Mcda05zsHi+ZMvTXyUrkLIvBPDovGwHJC8jzpw+/wTrwf8O3DODWPFDw/vvA+ILQdOEFmFhvi66ZjHQCslu+yx4Wz+1fP6EYdkvLfo0Gf+9MHkucpL/6HL2nLfrZQfkiRAfPpeiJjC7Sk2AbH0mUnm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xXbDeQJ+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SONULh4V; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xXbDeQJ+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SONULh4V; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 36E172116F;
	Fri, 28 Feb 2025 07:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740726325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sajlqXM1VU15cSJhxFMcZuxoHZ5mYWQTRWYsc2NGQaE=;
	b=xXbDeQJ+kcIoOQlEJoOBg7afLuv87MVjuX04iBvICEB0HzfP1eV4ihARYqsCg6dQuOzICI
	ha+xvDCU4a+KpMpzEUZYrtFjU+xlRAVwABQoQasK/rSwPWejk588hlOE2V3c8wS7NYeDVi
	gSu3vMSgjIQjxROpnskQ4OgJ2ujVh24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740726325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sajlqXM1VU15cSJhxFMcZuxoHZ5mYWQTRWYsc2NGQaE=;
	b=SONULh4V92zBZRJeO1ULDAkRrVzRQ+GyZVvdri7xe3ZyjFUh82BLYZCFh0ro83lOydUSfA
	yNums/NO/iFWHgDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xXbDeQJ+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SONULh4V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740726325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sajlqXM1VU15cSJhxFMcZuxoHZ5mYWQTRWYsc2NGQaE=;
	b=xXbDeQJ+kcIoOQlEJoOBg7afLuv87MVjuX04iBvICEB0HzfP1eV4ihARYqsCg6dQuOzICI
	ha+xvDCU4a+KpMpzEUZYrtFjU+xlRAVwABQoQasK/rSwPWejk588hlOE2V3c8wS7NYeDVi
	gSu3vMSgjIQjxROpnskQ4OgJ2ujVh24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740726325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sajlqXM1VU15cSJhxFMcZuxoHZ5mYWQTRWYsc2NGQaE=;
	b=SONULh4V92zBZRJeO1ULDAkRrVzRQ+GyZVvdri7xe3ZyjFUh82BLYZCFh0ro83lOydUSfA
	yNums/NO/iFWHgDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E71E1137AC;
	Fri, 28 Feb 2025 07:05:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AcHqNjRgwWe5HQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:05:24 +0000
Message-ID: <a75ad2a9-d8f7-4b84-aea0-12be785e249e@suse.de>
Date: Fri, 28 Feb 2025 08:05:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] nvmet-fcloop: add ref counting to lport
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-2-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-2-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 36E172116F
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 2/26/25 19:45, Daniel Wagner wrote:
> The fcloop_lport objects live time is controlled by the user interface
> add_local_port and del_local_port. nport, rport and tport objects are
> pointing to the lport objects but here is no clear tracking. Let's
> introduce an explicit ref counter for the lport objects and prepare the
> stage for restructuring how lports are used.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 47 +++++++++++++++++++++++++++++++++-----------
>   1 file changed, 35 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

