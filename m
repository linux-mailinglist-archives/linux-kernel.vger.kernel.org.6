Return-Path: <linux-kernel+bounces-537907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F423FA49251
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BABE16E19D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2491CAA99;
	Fri, 28 Feb 2025 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XrpMOq+g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J8CccUAe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XrpMOq+g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J8CccUAe"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E95E1C5D69
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740728246; cv=none; b=GSY6K99eM5C6R/Sb3vjOLZ1w1gI2mT8GgXVpMMPWUm/dilmzwgZWhBiY7VF8ogGK9C0U6GR93+AYni732hcfg+lJBmFUZKUk2cIK3a7iptUJej6BnoPRO8qHU3uRe0WzB0wgb7XPVN++WvdZohVbm4qqlS9wyVtU6aQE5r201oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740728246; c=relaxed/simple;
	bh=Tw1a7bkGe+H2OKv7L4i9hNdXfSruu1vCDWHZsJXkgBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HudI5SkYskZmGbn2IKwFg03u0MHjXzrpJAUtdCOWuDV1T+tp8QAqdad2plgrTR6zc+y3xX1zeKudyvUXUYMBHm33t5mmocLSDInT9ei76rit8aYod8mj/wEp6AjKZIkHiUlFvtxiD2Qd8CZW43hlB7Y2QPZhVUmiszSKvoHqeOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XrpMOq+g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J8CccUAe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XrpMOq+g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J8CccUAe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9DEDA2116F;
	Fri, 28 Feb 2025 07:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740728241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VkvJiMBqRwXIFM4Za5TQdUxmuJ426aRJUYRegaej+w=;
	b=XrpMOq+g7vAwTK4X4OfcEjmI6ehDGN7j64nutqIefZxL7W1pNXEsCMmiHuYin/SrI9bGXy
	17Te76YjNMq0NgtFAfrJK/P7ERrkNXT4JMHrm3Hqw1+NDMedXHDKtU7TROAk4S+LBr+3Od
	75uGNyRYcKY/vgz5cSS6nebvLVruCgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740728241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VkvJiMBqRwXIFM4Za5TQdUxmuJ426aRJUYRegaej+w=;
	b=J8CccUAePnNMVDmcS1aQV1LESfSgwBVgQGo/J04SrONKMd3aw/cJFLXDdvm6dM0VfqcMRn
	TyDzKTbkp9/gT5DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740728241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VkvJiMBqRwXIFM4Za5TQdUxmuJ426aRJUYRegaej+w=;
	b=XrpMOq+g7vAwTK4X4OfcEjmI6ehDGN7j64nutqIefZxL7W1pNXEsCMmiHuYin/SrI9bGXy
	17Te76YjNMq0NgtFAfrJK/P7ERrkNXT4JMHrm3Hqw1+NDMedXHDKtU7TROAk4S+LBr+3Od
	75uGNyRYcKY/vgz5cSS6nebvLVruCgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740728241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VkvJiMBqRwXIFM4Za5TQdUxmuJ426aRJUYRegaej+w=;
	b=J8CccUAePnNMVDmcS1aQV1LESfSgwBVgQGo/J04SrONKMd3aw/cJFLXDdvm6dM0VfqcMRn
	TyDzKTbkp9/gT5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F246137AC;
	Fri, 28 Feb 2025 07:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8g/wDbFnwWdRKAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:37:21 +0000
Message-ID: <94bbeb52-8bc3-4ee0-a163-f3e61fb7e1cb@suse.de>
Date: Fri, 28 Feb 2025 08:37:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] nvmet-fc: inline nvmet_fc_free_hostport
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-11-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-11-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/26/25 19:46, Daniel Wagner wrote:
> No need for this tiny helper with only user, let's inline it.
> And since the hostport ref counter needs to stay in sync, it's not
> optional anymore to give back the reference.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fc.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

