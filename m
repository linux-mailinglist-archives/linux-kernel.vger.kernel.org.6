Return-Path: <linux-kernel+bounces-565996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EBBA671E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EC23B02E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E292080C3;
	Tue, 18 Mar 2025 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bj9MdbBF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="99blsUTt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bj9MdbBF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="99blsUTt"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAE2EAC6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295416; cv=none; b=f/M9ouP9+Gl3G3J2P0Bwn2ef1VydZ2IB+pKauiZRDcIMcg1nYdsqU89BkiHqIHL2Xyi5KUpmtfNjuSdpfjIfL+fn036o3NPX36gMjsYFX8aLFvpCTP5fX/yNQPOjzTX4Ccp0b7Ep+te0tAV8eI8JLQkO8hAHYlZlepyf6x1UUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295416; c=relaxed/simple;
	bh=LuLL4lR25oOKrwVndZrnR8HPdpqeDBig+eQBkWNLacs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0hCbJIKPUg7VBRTcQUvBVW4gDmiXyf1ud+3WmdUxZfjb9dDFKFl2vgTqj9MwS4Ux4q8uGUqa25+CqH8LoIUAmzUezTwysy1RnbwqFxeEoELlBbXgJQKPb2E2AK/blj4L4IC15K+S+HVAuYlzmCEyBEaCPRXJK/pmjqp7Mpb/9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bj9MdbBF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=99blsUTt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bj9MdbBF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=99blsUTt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77D3221B85;
	Tue, 18 Mar 2025 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742295411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtC//Wk5So92EDZ1/8rtKLulhOPoMLt/y1uBzCl4a/k=;
	b=bj9MdbBFPmIz2uEqQMdWLLuBZ3ZEJnrjqv6Z2hFhMh0VoJtTwSFyMuMDVBhrmXsCJGqjre
	vg0Pq/A7C0QT4e1Tno0Aozn37Exx1UqrHWr3WN2mcD/mhAKj39/8ZlWhtFBz9aIuxTdqTq
	Gjn9MwRNpE+crTNBGSyytrF38vGng2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742295411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtC//Wk5So92EDZ1/8rtKLulhOPoMLt/y1uBzCl4a/k=;
	b=99blsUTtfcQmAeLwHLz6TNtdOfrg8XaLDZ7yIOFlmI9qKl9C895BBi1eEuv4PSLRhsGWSt
	7zUyOXwTcl3/W6Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bj9MdbBF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=99blsUTt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742295411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtC//Wk5So92EDZ1/8rtKLulhOPoMLt/y1uBzCl4a/k=;
	b=bj9MdbBFPmIz2uEqQMdWLLuBZ3ZEJnrjqv6Z2hFhMh0VoJtTwSFyMuMDVBhrmXsCJGqjre
	vg0Pq/A7C0QT4e1Tno0Aozn37Exx1UqrHWr3WN2mcD/mhAKj39/8ZlWhtFBz9aIuxTdqTq
	Gjn9MwRNpE+crTNBGSyytrF38vGng2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742295411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtC//Wk5So92EDZ1/8rtKLulhOPoMLt/y1uBzCl4a/k=;
	b=99blsUTtfcQmAeLwHLz6TNtdOfrg8XaLDZ7yIOFlmI9qKl9C895BBi1eEuv4PSLRhsGWSt
	7zUyOXwTcl3/W6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48CBA13A43;
	Tue, 18 Mar 2025 10:56:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9gNYEXNR2WfAQAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 10:56:51 +0000
Message-ID: <e94a7fab-3811-449b-9999-7641b9274b07@suse.de>
Date: Tue, 18 Mar 2025 11:56:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/18] nvmet-fcloop: replace kref with refcount
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-2-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250318-nvmet-fcloop-v3-2-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 77D3221B85
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/18/25 11:39, Daniel Wagner wrote:
> The kref wrapper is not really adding any value ontop of refcount. Thus
> replace the kref API with the refcount API.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 37 +++++++++++++------------------------
>   1 file changed, 13 insertions(+), 24 deletions(-)
> 
Can you split this in two, one for the nport and one for fcpreq?
That way it's easier to follow what has been modified.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

