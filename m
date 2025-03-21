Return-Path: <linux-kernel+bounces-571404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EB2A6BCBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0D43AE6B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D0219C54B;
	Fri, 21 Mar 2025 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kg4YUDwq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c+lekYuW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kg4YUDwq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c+lekYuW"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4613AD38
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566577; cv=none; b=FUkKZh652dE/MLOJt4+NKlPXcY1XCizzkP79KY0MYrfAnZf9BCMRq2ns1JepTTfwtJwoNLCxBel6eDExMlPsaNv3iIr5kW13TQJ6s/upKFXdRHq+3a7Gg0gxeREgrBDA8SSADh2DPvAqktucZ4i/1Br+87MbuieRWdSb9JGqlKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566577; c=relaxed/simple;
	bh=XhV9HMs0pNleIbsmmnAAfU/ymXlMZd0p/SE1TQewLXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwlKUbn47yZemykSl7rhLn0TXetsJSPXmwXwq6zZ1f+n3N5am64Z1aYMCJu9mQvoEmj8z3ZdY8m9Yj7ta+EffQmFzzjkGjk8ZwCt15LzTBR2T75SBiYsgdY4ilcvW/vrm+0DFoKv7B1WRLbVBBfNwzGi1AOb20ut7FSbXqYVbpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kg4YUDwq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c+lekYuW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kg4YUDwq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c+lekYuW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7EAB51FEEF;
	Fri, 21 Mar 2025 14:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742566573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+jBj4B5vc20HmZfhqTDcfMyY8bZxeLupkiMIpuVn60=;
	b=Kg4YUDwqBajqcf2HB7uFrBDNPMBZKEbjRoRUaEcBPXqcM9HP+9LXCeF7+YstB784ogSRQo
	/Z9ypV60U6oF0717GrImHakVPIBvz8nBEbzcGE+mpOQxsDvDTv3+VtF/V8M6dD8f2hfoRf
	IGcSCUcaMxWW5XYGE6LWoMNsXAfNvU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742566573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+jBj4B5vc20HmZfhqTDcfMyY8bZxeLupkiMIpuVn60=;
	b=c+lekYuW/fH5RmtoidjfFyQRWAp06Pvh71Udey3hIOuB4NDMMH49d4UEcCi1d0q+oS9Vo5
	obu0Da7JqwU6BsDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742566573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+jBj4B5vc20HmZfhqTDcfMyY8bZxeLupkiMIpuVn60=;
	b=Kg4YUDwqBajqcf2HB7uFrBDNPMBZKEbjRoRUaEcBPXqcM9HP+9LXCeF7+YstB784ogSRQo
	/Z9ypV60U6oF0717GrImHakVPIBvz8nBEbzcGE+mpOQxsDvDTv3+VtF/V8M6dD8f2hfoRf
	IGcSCUcaMxWW5XYGE6LWoMNsXAfNvU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742566573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+jBj4B5vc20HmZfhqTDcfMyY8bZxeLupkiMIpuVn60=;
	b=c+lekYuW/fH5RmtoidjfFyQRWAp06Pvh71Udey3hIOuB4NDMMH49d4UEcCi1d0q+oS9Vo5
	obu0Da7JqwU6BsDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 031F913A2C;
	Fri, 21 Mar 2025 14:16:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1M5UOax03WdoewAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 21 Mar 2025 14:16:12 +0000
Message-ID: <b3645684-fbb7-4f8c-b702-ccb803cbda9a@suse.de>
Date: Fri, 21 Mar 2025 15:16:12 +0100
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
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
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

