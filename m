Return-Path: <linux-kernel+bounces-537859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E833A491DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717D63AF3D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49781C3BFC;
	Fri, 28 Feb 2025 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QSYnNHuj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jbOfdGt3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QSYnNHuj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jbOfdGt3"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67892748F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726285; cv=none; b=UFUheq69VRA0vN4+BGob3nwvXKNeNbQ9gPI8HOam5VsyuuqjIll36sK6gH92908wUUR5Cxw4m3DOM254bzVb6hK7vGD/u2ITF1fc4MyoHXEgBhzy83f02ReZOy9Z2bezs5S+GISgrcpU7BdRMKS0H/Ry4PlxDJhG7l1plaL6kiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726285; c=relaxed/simple;
	bh=9n3T43hTF2HUVrDLIlo6QY50r87EO8+/lqxgeM65BF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVWNS0DnRzcRezsehhjt2o3zatPGF/XCZDIqjczpONn34x7pbrTx/4ghJ/JgPMJCjM0gI0zMSnBHVuwdClDIpLVE9Ke2cDhsYnmjnTZDluC1Fw8N9Ep+Wr+6htmQj1XokOkeO2BKvpZXJExPzGDlJo2AW8lycfe8xjH76Q1+O+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QSYnNHuj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jbOfdGt3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QSYnNHuj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jbOfdGt3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E9751F394;
	Fri, 28 Feb 2025 07:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740726281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMAAk6iKScc4653q+kbygEp5UruPx0mqKvGCuDffAw8=;
	b=QSYnNHujbbeHmTA5a6jMX51PUSD3siZQ8PqI12TWHTOcDgLu/zzMSjGvSUPRj9l+YU6Zl7
	3ZctCWNVKBTT6LnaffPiNsXJrg2Hkwc/4dCgOGoFZdO05ZXYBdmZYE/EPy53elNXIGwH3s
	afepmDSuZdGWtb8qOCZI4oi5gZGkHKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740726281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMAAk6iKScc4653q+kbygEp5UruPx0mqKvGCuDffAw8=;
	b=jbOfdGt3fafUQMCojCqKU9DqpJobBi9Gyn93Qm8P9MNBhSKj0H0eZeU5wANXomLxTo0zU4
	ox2Ziyx/FxEQA/Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740726281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMAAk6iKScc4653q+kbygEp5UruPx0mqKvGCuDffAw8=;
	b=QSYnNHujbbeHmTA5a6jMX51PUSD3siZQ8PqI12TWHTOcDgLu/zzMSjGvSUPRj9l+YU6Zl7
	3ZctCWNVKBTT6LnaffPiNsXJrg2Hkwc/4dCgOGoFZdO05ZXYBdmZYE/EPy53elNXIGwH3s
	afepmDSuZdGWtb8qOCZI4oi5gZGkHKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740726281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMAAk6iKScc4653q+kbygEp5UruPx0mqKvGCuDffAw8=;
	b=jbOfdGt3fafUQMCojCqKU9DqpJobBi9Gyn93Qm8P9MNBhSKj0H0eZeU5wANXomLxTo0zU4
	ox2Ziyx/FxEQA/Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D7B6137AC;
	Fri, 28 Feb 2025 07:04:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ffLAAlgwWeEHQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:04:41 +0000
Message-ID: <f757908f-a5b5-4648-a311-84ac50f02750@suse.de>
Date: Fri, 28 Feb 2025 08:04:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] nvmet-fcloop: remove nport from list on last user
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-1-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-1-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 2/26/25 19:45, Daniel Wagner wrote:
> The nport object has an association with the rport and lport object,
> that means we can only remove an nport object from the global nport_list
> after the last user of an rport or lport is gone.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

