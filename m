Return-Path: <linux-kernel+bounces-257015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078BC937407
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7528F1F2178D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1064341C72;
	Fri, 19 Jul 2024 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MmQERhQU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mgsPp+kI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i7nmXu9w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UehNu/3K"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61FB29CE6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721370510; cv=none; b=dj4MTrJ3tmWdJiLjBJik1WPh8Y2IVyB0TsfJyXym3lwS6V5IzZHfBw+6tjP1fc82Nt6S7sAzDdB7dfcaoJ0UAgTah2wTdCuZoc2Wi83jN4PgIg9+6J210a5fG9aczNA4jiUhtr4dj7FQ+3grphMJxLEzCSDmWzpiN1gy8+F8uX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721370510; c=relaxed/simple;
	bh=UpQ73GjSiU5btK+MzhJAaafGEuLkTTIyAkkqtJ/EwuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUv7KkraqldALDy86g2iJHmrho4QoTxKvF6EdkiW538Ve0q+j/2iCTH3kkt7MsJVnm1y1gGh5BiW1DRnAr5xaLFwp7LOxiYJfYm1eGcaXsPMHtnACfuPfkh8VZjwq0tfNFItO98z7N1jOGvnUL5KURard7ByNzSxxiJY/wMDIig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MmQERhQU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mgsPp+kI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i7nmXu9w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UehNu/3K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB7202189C;
	Fri, 19 Jul 2024 06:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721370507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB/u0ZTlPX+YZObQGncZtGwwHoboXsssQbVeUBR0mc8=;
	b=MmQERhQUvwJd5ThS+9bBTyjkuEvOaWBt437lxgjVG5h5DywEw7rYF0YdozVZG50XsdCRwk
	h4RSdxMgrwPBMBnJcYOHokpaDo+90zTwEhdKe70UC5j6nEchf/WhzFEgAn1xtPIjxmJoaw
	el7IfZeQSZTZuUgxCaWvnCDy9nVjLCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721370507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB/u0ZTlPX+YZObQGncZtGwwHoboXsssQbVeUBR0mc8=;
	b=mgsPp+kIBYw9nkS8oMLQ6OjjRJpp1RgBuhCqKIIuwNePkLDFkybdrJrfkF8GGcRJDAE+8E
	OdJz/PTM8NNopYBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721370506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB/u0ZTlPX+YZObQGncZtGwwHoboXsssQbVeUBR0mc8=;
	b=i7nmXu9w/OSW9dGFbrJsgvse/S04zvFcPvCMsTu0zU+ljpnFjWwhOhqeFMLvb0mgzQn2S5
	hRH/QJSJkIOthZKPjYAx5COJbm9K600dc8exPXU/xgV4z8UC9OjTT/Vr7XxEgGPMVBhlFV
	iwWoG+fVkfi5B9bHKHj2GTims0YSJLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721370506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB/u0ZTlPX+YZObQGncZtGwwHoboXsssQbVeUBR0mc8=;
	b=UehNu/3Kgr3YijA81JSZyCRGf9DpeLTIWI3v5pN45JPNnMb/jlcdczd80GDsDYclnLbZDP
	x7WyMhNgaF+GOXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A53A9132CB;
	Fri, 19 Jul 2024 06:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9txzJooHmmY6EwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 19 Jul 2024 06:28:26 +0000
Message-ID: <0f15a932-1a42-4c51-a267-3f765866edc4@suse.de>
Date: Fri, 19 Jul 2024 08:28:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] nvmet: support unbound_wq for RDMA and TCP
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Ping Gan <jacky_gam_2001@163.com>
Cc: sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, ping.gan@dell.com
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
 <20240719053116.GA21474@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240719053116.GA21474@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -0.29
X-Spamd-Result: default: False [-0.29 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_TO(0.00)[lst.de,163.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 7/19/24 07:31, Christoph Hellwig wrote:
> On Wed, Jul 17, 2024 at 05:14:49PM +0800, Ping Gan wrote:
>> When running nvmf on SMP platform, current nvme target's RDMA and
>> TCP use bounded workqueue to handle IO, but when there is other high
>> workload on the system(eg: kubernetes), the competition between the
>> bounded kworker and other workload is very radical. To decrease the
>> resource race of OS among them, this patchset will enable unbounded
>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>> get some performance improvement. And this patchset bases on previous
>> discussion from below session.
> 
> So why aren't we using unbound workqueues by default?  Who makea the
> policy decision and how does anyone know which one to chose?
> 
I'd be happy to switch to unbound workqueues per default.
It actually might be a left over from the various workqueue changes;
at one point 'unbound' meant that effectively only one CPU was used
for the workqueue, and you had to remove the 'unbound' parameter to
have the workqueue run on all CPUs. That has since changed, so I guess
switching to unbound per default is the better option here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


