Return-Path: <linux-kernel+bounces-533468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5D0A45AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60B41894A61
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE38826B08F;
	Wed, 26 Feb 2025 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fycxGK30";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wFau2qWV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fycxGK30";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wFau2qWV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8524DFF2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563725; cv=none; b=t15KUWbs1i0vwdL7iqBxpEof2rt9m2VS4nwJD7eXCdCfIY0+w8KZ6QrP5Vt65RExbNKR6QolywgYGKweS7J/qs20f18h6K5bVXPGREieYswDI7L9NsFmR2ebub1C6IuFzw8mDE81h9OFeteR2OEop2TJF/SsUW9wJMq3c2fU094=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563725; c=relaxed/simple;
	bh=QPAOCmQvwaCgErFjKDf4GwL8w0XhDnR4Iwcohrh6Prg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcAfL5dfS4X5a2N6H1YB088PKrkxdUVEVviPntuIJ/ZY+2u5UYjziHu7JQKywBKrp6fq3CnhEAurSZl8joXyy1szXmJ798hqejaQ8SfiaxVabdBiQs3xrnO0XGZtdqKXXVEEqMOdA5bpPF/4y6hc/ppg1N+ojGoe7hxxKIN6ehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fycxGK30; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wFau2qWV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fycxGK30; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wFau2qWV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C371D1F387;
	Wed, 26 Feb 2025 09:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740563721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5n2CNT/If87O2/WgTYuEsYzy/NIOAowhCO9ovKL/mA=;
	b=fycxGK30uI9SoB76rQO3idQAUfhKpyM5pxNWZpCMZ4UOUZ70FQ84TrMpQDnMA2iJbHOrrb
	h8QUGLJ0qDSie9Pq2nLgHf1Tt8dB/hIP5AkMuYVOg/UAW7WzxtvNNG9pD6rnYRKv+4dWpE
	E7OFxAVtGzzCoR9wOd4wtcQO5hqgmVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740563721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5n2CNT/If87O2/WgTYuEsYzy/NIOAowhCO9ovKL/mA=;
	b=wFau2qWVSX42Xd4qmtjdpVWdtpKJk7gJXmsFbr3wxdtdbd8B3gjs9y30caghAwjmOSrXta
	yBwPNfFyIKe2S4Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740563721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5n2CNT/If87O2/WgTYuEsYzy/NIOAowhCO9ovKL/mA=;
	b=fycxGK30uI9SoB76rQO3idQAUfhKpyM5pxNWZpCMZ4UOUZ70FQ84TrMpQDnMA2iJbHOrrb
	h8QUGLJ0qDSie9Pq2nLgHf1Tt8dB/hIP5AkMuYVOg/UAW7WzxtvNNG9pD6rnYRKv+4dWpE
	E7OFxAVtGzzCoR9wOd4wtcQO5hqgmVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740563721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5n2CNT/If87O2/WgTYuEsYzy/NIOAowhCO9ovKL/mA=;
	b=wFau2qWVSX42Xd4qmtjdpVWdtpKJk7gJXmsFbr3wxdtdbd8B3gjs9y30caghAwjmOSrXta
	yBwPNfFyIKe2S4Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3D4E13A53;
	Wed, 26 Feb 2025 09:55:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jbaRJwnlvmehYwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 26 Feb 2025 09:55:21 +0000
Message-ID: <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
Date: Wed, 26 Feb 2025 10:55:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Nilay Shroff <nilay@linux.ibm.com>, John Meneghini <jmeneghi@redhat.com>,
 hch@lst.de, bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
 <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
 <Z7dct_AbaSO7uZ2h@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z7dct_AbaSO7uZ2h@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 2/20/25 17:47, Keith Busch wrote:
> On Thu, Feb 20, 2025 at 01:05:04PM +0200, Sagi Grimberg wrote:
>> This discussion is not specific to RHEL, if there is a real use-case
>> that we are interested in supporting, we can change our minds and keep
>> it (and simply remove the log msg), but I haven't heard any real life
>> use-cases thus far.
> 
> One use case: ublk.
> 
> Other use cases are manufacturing and debugging. Linux has been a great
> environment for both, which don't want anything hidden behind virtual
> devices.
> 
> The module parameter makes it possible to do this with your distro's
> stock kernel that came with the CONFIG option enabled.
> 
> The device mapper multipath needed some layering violations out of the
> driver to make failover work correctly/better. That's one reason it's
> not supported here, and that's an appropriate place to draw the line on
> what kinds of patches should be accepted.
> 
Plus there are some NVMe devices out there which _despite_ being PCIe do 
report NMIC and CMIC set (I won't name names, if you came across them 
you'll know). This is causing stacking drivers (most notably MD) to 
behave vastly different on hotplug. Having the module option is an easy 
way of debugging (and, in quite some cases, fixing) the issue.

If the module option really causes issues just make it read-only; that
way you can still set if if absolutely required, and at the same time
catch installations which try to modify it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

