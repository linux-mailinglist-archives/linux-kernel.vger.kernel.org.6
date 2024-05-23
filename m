Return-Path: <linux-kernel+bounces-187046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218868CCC3B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC62428398F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E11F13B7A6;
	Thu, 23 May 2024 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0lU0AnUz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6lp5MI/h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0lU0AnUz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6lp5MI/h"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DE913B59C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716445420; cv=none; b=E8L9K4EoxGz7qxyijOwtHXOf2uUTc2SskHrzj80Y2tm08btCA8LkOyGzAzwv8hKyKX/TC6UEVcPmITQaRmZLV5yM6J4gf2YPwEDd0l9vvV5aSO8Nho0loWTxfJpNg6CEQSZqhUcjtosVNF5r2kqweKkJMjM0q2caOMVhwxnjdP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716445420; c=relaxed/simple;
	bh=BsMXxU2oDvNb0FaRJ1CDaOlj6Db2mw0DLOdkJ4DqKDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4j7J52lyHKdg6uT8neStxvZDoA8fao4sx0v2d51WakLKLYocnvK9YAyChCE0sXPnMQEIOMECelbstPJk5CMNaXJ091P3Z3cK5vNvrRc9GonyWDVGUZI1pakvoAtoWpanoulg7TVXt95YG/xGzcBxqF5+Ir6MYHzxHcuNyqcjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0lU0AnUz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6lp5MI/h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0lU0AnUz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6lp5MI/h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 533B01FF36;
	Thu, 23 May 2024 06:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716445415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7Gts9Vg8RtGmmioiiv1kJL4aLEq43DIkM9Z5kvDsLU=;
	b=0lU0AnUzGoUPbqFIEi9C1bRROOQLa/YFMWhecRgQ7Xt7DQPSe1hFNxa73R3/wMtXHIdkvW
	nbRoyPnKT66A0skaI/WAwnHOwSDS8aE+ivmXbp+WHuUIyeWjxAj2CJyGDIlZQqQ/1LNoIe
	fifsrwj9nTH4y9g8QSLktavGPykMRpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716445415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7Gts9Vg8RtGmmioiiv1kJL4aLEq43DIkM9Z5kvDsLU=;
	b=6lp5MI/h/l7kqkNgOoBe5IpKTTLWdRzWtlBTcQtPpwI+WgarnsqFHRy3s0zsYKs6TMP1Ui
	kPYKE+pbv5k/JbDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0lU0AnUz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="6lp5MI/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716445415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7Gts9Vg8RtGmmioiiv1kJL4aLEq43DIkM9Z5kvDsLU=;
	b=0lU0AnUzGoUPbqFIEi9C1bRROOQLa/YFMWhecRgQ7Xt7DQPSe1hFNxa73R3/wMtXHIdkvW
	nbRoyPnKT66A0skaI/WAwnHOwSDS8aE+ivmXbp+WHuUIyeWjxAj2CJyGDIlZQqQ/1LNoIe
	fifsrwj9nTH4y9g8QSLktavGPykMRpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716445415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7Gts9Vg8RtGmmioiiv1kJL4aLEq43DIkM9Z5kvDsLU=;
	b=6lp5MI/h/l7kqkNgOoBe5IpKTTLWdRzWtlBTcQtPpwI+WgarnsqFHRy3s0zsYKs6TMP1Ui
	kPYKE+pbv5k/JbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E86EB13A6B;
	Thu, 23 May 2024 06:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cxggN+bgTmaRUAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 23 May 2024 06:23:34 +0000
Message-ID: <d3732423-6a13-4399-bcb1-7baddbe4d363@suse.de>
Date: Thu, 23 May 2024 08:23:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Content-Language: en-US
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240522154212.643572-1-jmeneghi@redhat.com>
 <20240522154212.643572-2-jmeneghi@redhat.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240522154212.643572-2-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 533B01FF36
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On 5/22/24 17:42, John Meneghini wrote:
> From: "Ewan D. Milne" <emilne@redhat.com>
> 
> The round-robin path selector is inefficient in cases where there is a
> difference in latency between paths.  In the presence of one or more
> high latency paths the round-robin selector continues to use the high
> latency path equally. This results in a bias towards the highest latency
> path and can cause a significant decrease in overall performance as IOs
> pile on the highest latency path. This problem is acute with NVMe-oF
> controllers.
> 
> The queue-depth policy instead sends I/O requests down the path with the
> least amount of requests in its request queue. Paths with lower latency
> will clear requests more quickly and have less requests in their queues
> compared to higher latency paths. The goal of this path selector is to
> make more use of lower latency paths which will bring down overall IO
> latency and increase throughput and performance.
> 
> Signed-off-by: Thomas Song <tsong@purestorage.com>
> [emilne: patch developed by Thomas Song @ Pure Storage, fixed whitespace
>        and compilation warnings, updated MODULE_PARM description, and
>        fixed potential issue with ->current_path[] being used]
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> [jmeneghi: vairious changes and improvements, addressed review comments]
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
> Tested-by: Marco Patalano <mpatalan@redhat.com>
> Reviewed-by: Randy Jennings <randyj@purestorage.com>
> Tested-by: Jyoti Rani <jrani@purestorage.com>
> ---
>   drivers/nvme/host/core.c      |  2 +-
>   drivers/nvme/host/multipath.c | 91 +++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h      |  8 +++
>   3 files changed, 96 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


