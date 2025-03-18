Return-Path: <linux-kernel+bounces-566026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032FAA6723B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F361735E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530F207A0E;
	Tue, 18 Mar 2025 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xN2ZbjpB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vqAH5BzN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xN2ZbjpB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vqAH5BzN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFB209F38
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296153; cv=none; b=fnYzMuHn3GqTg5R+udN4E7svmH+s4n2h/YCJFxhlAOGesHQVAWMGcroN9gyTtVwbmKO4czZBG+Im+iytcJ4eCxbfJgdWPFs8aojjcW5/jHaysxvwiNROkm5a+CfV63QJEnJ96QK0mJuNLW3pXHXUX8vxuyHz+R5Wmwxl0tRoLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296153; c=relaxed/simple;
	bh=ybS1Y3aqUYXK2BEPzXlnl8YLtFXaX6mj4ZA+UuBqbJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmOsoo1t/RZDbyJwdVz8cGTYDY3wWFL7C7RUk8s5SPZgRyT3FoPf7HEgjLDRKHDfngSGg0ZSOmiEk4vxYeiPikt+T3HwLcnPL+h4sO9PrOv/qwocOU17bhd7Dk2xF1dnQttt71Ge3NvfkxfquK/zJN0G4GGRrJeOrLQzocXwgDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xN2ZbjpB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vqAH5BzN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xN2ZbjpB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vqAH5BzN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41A0D21D5C;
	Tue, 18 Mar 2025 11:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIGdrzZDUMR+VJuL2tT2R6UGBKpBUeZmqUgL5GhGmO8=;
	b=xN2ZbjpBtgefIVcbu4jsT/ZcKr0ddyGRTqGVjsY4wN352yTKxCt0vhE4YXjUClcr7USqj9
	zmk1oAUgN6XVkIR1o/8D/cQxehzGN6MQCmS4Mq78xvBtNNYa4E/KpUe7xtOEYZcoLO+Skw
	22VNKjBa4Dj8KG0A+oulNFY3UJwhpcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIGdrzZDUMR+VJuL2tT2R6UGBKpBUeZmqUgL5GhGmO8=;
	b=vqAH5BzNJ/dSbuc79ObjN5ytDl8BpTLWZBVTtUQkBaiyLAjxVhFIPJSqgYthcJ2bR/1Aj8
	cM0rr/bLnaf68DAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742296150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIGdrzZDUMR+VJuL2tT2R6UGBKpBUeZmqUgL5GhGmO8=;
	b=xN2ZbjpBtgefIVcbu4jsT/ZcKr0ddyGRTqGVjsY4wN352yTKxCt0vhE4YXjUClcr7USqj9
	zmk1oAUgN6XVkIR1o/8D/cQxehzGN6MQCmS4Mq78xvBtNNYa4E/KpUe7xtOEYZcoLO+Skw
	22VNKjBa4Dj8KG0A+oulNFY3UJwhpcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742296150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIGdrzZDUMR+VJuL2tT2R6UGBKpBUeZmqUgL5GhGmO8=;
	b=vqAH5BzNJ/dSbuc79ObjN5ytDl8BpTLWZBVTtUQkBaiyLAjxVhFIPJSqgYthcJ2bR/1Aj8
	cM0rr/bLnaf68DAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29F05139D2;
	Tue, 18 Mar 2025 11:09:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2XNiCVZU2WfHRAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 11:09:10 +0000
Message-ID: <db8d388a-0f15-4cd0-987a-7857ae29501b@suse.de>
Date: Tue, 18 Mar 2025 12:09:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/18] nvmet-fcloop: update refs on tfcp_req
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-7-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250318-nvmet-fcloop-v3-7-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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

On 3/18/25 11:40, Daniel Wagner wrote:
> Track the lifetime of the in-flight tfcp_req to ensure
> the object is not freed too early.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

