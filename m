Return-Path: <linux-kernel+bounces-253643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F15932438
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556D61F21A30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CFA198A37;
	Tue, 16 Jul 2024 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DG7X1yhQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rmyNpWo1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DG7X1yhQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rmyNpWo1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797A13A416
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126212; cv=none; b=LRWjtkbfWo5lslDsudch+dNYrM6gQaksS8TjKSHGmyGfe1dfnjenddHsxiKynd4Uzl/EoLI2P9UQDEJTfO9uP6XjLlmi+BbkBNMeHPYs8ahSFsizLgunrmw2mH+7lFxHFYv/XxPuctl5C5JfROV4sW0+P89GmmlAz8MbvrFbupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126212; c=relaxed/simple;
	bh=lVup5S/0ROdJB4XQiLGDWEc3gnUiLNZNUd6FdionrsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyuUOWtAgCS73rdSV4LcUFJhESsQM0cE1RlocEbazk8YpFTGyqsLdLmxlSoFD5SnbIy3Rt/zSxQuyr76OBODGGRgZU4zrRotbupFiEgzA+vKoCPuVW3mGgD05N8rKcGFw75B0LOrHE7VqwP1D82j9Gqxt4fiZoJKfXkqT116MRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DG7X1yhQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rmyNpWo1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DG7X1yhQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rmyNpWo1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2EFD21F8AC;
	Tue, 16 Jul 2024 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721126208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdKtjRTwOIt7k4JaJtjnwT0KE/WaLnugRaqQ1yyt8i8=;
	b=DG7X1yhQ7idojnjCzNdAZte2vI35I8Mu/YYl044QpI9L4LvrpsjBsm+gdt0UvJoLTJ6Ke/
	bG4UfuTwujKMnaMoeypNzC6WG5Tx5r1Zwailv/cd09N3W0MBce0j13eKEmU5isYeViFyki
	L5wcPliVjW1pYtLDj/h6ZqXuVKvBgpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721126208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdKtjRTwOIt7k4JaJtjnwT0KE/WaLnugRaqQ1yyt8i8=;
	b=rmyNpWo1Sf0GEd3e7ZegGR4stQXjg3QV5mnlHVnUKpeT5VAAZVMauTejznBpJzd5Ylb/88
	XHC4yzunV7TnC6CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DG7X1yhQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rmyNpWo1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721126208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdKtjRTwOIt7k4JaJtjnwT0KE/WaLnugRaqQ1yyt8i8=;
	b=DG7X1yhQ7idojnjCzNdAZte2vI35I8Mu/YYl044QpI9L4LvrpsjBsm+gdt0UvJoLTJ6Ke/
	bG4UfuTwujKMnaMoeypNzC6WG5Tx5r1Zwailv/cd09N3W0MBce0j13eKEmU5isYeViFyki
	L5wcPliVjW1pYtLDj/h6ZqXuVKvBgpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721126208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdKtjRTwOIt7k4JaJtjnwT0KE/WaLnugRaqQ1yyt8i8=;
	b=rmyNpWo1Sf0GEd3e7ZegGR4stQXjg3QV5mnlHVnUKpeT5VAAZVMauTejznBpJzd5Ylb/88
	XHC4yzunV7TnC6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3185136E5;
	Tue, 16 Jul 2024 10:36:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IkVaOT9NlmYIMgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 16 Jul 2024 10:36:47 +0000
Message-ID: <af243508-e5f3-4835-8d8e-c1bb741e22f3@suse.de>
Date: Tue, 16 Jul 2024 12:36:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvmet: support polling task for RDMA and TCP
To: Ping Gan <jacky_gam_2001@163.com>, sagi@grimberg.me, hch@lst.de,
 kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <12556163-9efa-461f-826d-264350f4ca58@grimberg.me>
 <20240704081015.63584-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240704081015.63584-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_TO(0.00)[163.com,grimberg.me,lst.de,nvidia.com,lists.infradead.org,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 2EFD21F8AC

On 7/4/24 10:10, Ping Gan wrote:
>> On 02/07/2024 13:02, Ping Gan wrote:
[ .. ]
>>> And the bandwidth of a node is only 3100MB. While we used the patch
>>> and enable 6 polling task, the bandwidth can be 4000MB. It's a good
>>> improvement.
>>
>> I think you will see similar performance with unbound workqueue and
>> rps.
> 
> Yes, I remodified the nvmet-tcp/nvmet-rdma code for supporting unbound
> workqueue, and in same prerequisites of above to run test, and compared
> the result of unbound workqueue and polling mode task. And I got a good
> performance for unbound workqueue. For unbound workqueue TCP we got
> 3850M/node, it's almost equal to polling task. And also tested
> nvmet-rdma we get 5100M/node for unbound workqueue RDMA versus 5600M for
> polling task, seems the diff is very small. Anyway, your advice is good.
> Do you think we should submit the unbound workqueue patches for nvmet-tcp
> and nvmet-rdma to upstream nvmet?

Please do. I have been using pretty much the same patch during
development of my nvme-tcp scalability patchset, and using WQ_UNBOUND
definitely improves the situation here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


