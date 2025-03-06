Return-Path: <linux-kernel+bounces-548321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03EEA54358
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0610A170789
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCAD1A840E;
	Thu,  6 Mar 2025 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NUj1C150";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YNfY1JPx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NUj1C150";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YNfY1JPx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D2D19D892
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245129; cv=none; b=bCSIErb9iPYhFtfAyh79jc8Hcke/yzysUzGrJgt/eQ2Me6UHsUcFQk5ywWu8hiWpuATlCVzajVYFP7QRR/8ZTS/RaXe7bIKCrayS8As2yeZTS1IGr+wYtd+KZiNHSz0EjL0xjUIKsip13uEvczepHuG+y06LKPkxE/Gg/qLy7dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245129; c=relaxed/simple;
	bh=NyNM+qYK2C/JsmQenpPWiWO0RxEmy36xN73x4kjhlhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ca++q+6NYndzhEtbuPXUOsdaG53VUf6LCWfUM+Zrg608aWkXPbYGAOM/e5PMoYDMByU+fmEnP8mFIrOVnuSZqh6d33/+IxskvvepdjzPwQ1XJUkmLH2/Aeot67B/wamHyQaBpsybOTV1oR7+KYh/VcA9ZPIoiTmFOZdR1IgZdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NUj1C150; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YNfY1JPx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NUj1C150; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YNfY1JPx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8898421197;
	Thu,  6 Mar 2025 07:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741245125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btwXWJeiuH6RkYwrUlziz8O8gADeHxdSBWZsmqwxI20=;
	b=NUj1C150ROtfb0iZ36i67LHLiHH1eEabFacd/bXWJByThNGFmryJwibIBuaF3VgBL2YiR4
	wORKlBKUHjrqTlXtBYWMPBkxdsF6QfFjOK76DYIQQWQWGXFJKUMIShJS8dvKwFSuTRgHC9
	sCzax4Jt9z31HwZNbc/Z+BGL0g5A9aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741245125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btwXWJeiuH6RkYwrUlziz8O8gADeHxdSBWZsmqwxI20=;
	b=YNfY1JPxqvEGDwpGH3kW4pYy7R6CrxSV+7ILxcGHbCTQSE/IeAKyVR96bTXan7VKsknDBq
	oHiYRRlk4La25uDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NUj1C150;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YNfY1JPx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741245125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btwXWJeiuH6RkYwrUlziz8O8gADeHxdSBWZsmqwxI20=;
	b=NUj1C150ROtfb0iZ36i67LHLiHH1eEabFacd/bXWJByThNGFmryJwibIBuaF3VgBL2YiR4
	wORKlBKUHjrqTlXtBYWMPBkxdsF6QfFjOK76DYIQQWQWGXFJKUMIShJS8dvKwFSuTRgHC9
	sCzax4Jt9z31HwZNbc/Z+BGL0g5A9aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741245125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btwXWJeiuH6RkYwrUlziz8O8gADeHxdSBWZsmqwxI20=;
	b=YNfY1JPxqvEGDwpGH3kW4pYy7R6CrxSV+7ILxcGHbCTQSE/IeAKyVR96bTXan7VKsknDBq
	oHiYRRlk4La25uDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C71D13A61;
	Thu,  6 Mar 2025 07:12:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YUgnIMRKyWfAaQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 06 Mar 2025 07:12:04 +0000
Message-ID: <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
Date: Thu, 6 Mar 2025 08:12:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
 Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
 axboe@kernel.dk
References: <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
 <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
 <Z7dct_AbaSO7uZ2h@kbusch-mbp> <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
 <20250305141554.GA18065@lst.de> <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
 <20250305235119.GB896@lst.de> <Z8jk-D3EjEdyBIU5@kbusch-mbp>
 <20250306000348.GA1233@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250306000348.GA1233@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8898421197
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/6/25 01:03, Christoph Hellwig wrote:
> On Wed, Mar 05, 2025 at 04:57:44PM -0700, Keith Busch wrote:
>>>> Obviously he's not talking about multiported PCIe.
>>>
>>> Why is that obvious?
>>
>> No one here would think a multiported device *wouldn't* report CMIC.
> 
> I hopes so.
> 
>> The
>> fact Hannes thinks that's a questionable feature for his device gives
>> away that it is single ported.
> 
> Well, his quote reads like he doesn't know about multiport PCIe devices.
> But maybe he just meant to say "despite being single-ported"
> 
Single ported.
There is a range of Samsung NVMe where one is a normal, single ported,
NVMe, and one with a nearly identical model number reporting CMIC.

Causing _quite_ a lot of confusion with the customer (and L3) when
used under MD, as for the first hotplug works, for the second ... not so 
much.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

