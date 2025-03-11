Return-Path: <linux-kernel+bounces-556369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D244A5C4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290903A4887
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434D825E454;
	Tue, 11 Mar 2025 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fRZBDhXR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nbQn4Dwp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fRZBDhXR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nbQn4Dwp"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF3B25DCE3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705595; cv=none; b=OzZ8bsbwBQ8Mfw9QdKHWSkpOl+3x7rJ7S3XIY54YXnw2z5TH5EbpgzVcFfgsQxKzLZK3UuHEtraw+QBozX69bnKN1AS1FuvKJ0RTJLjKvSFifco/HUrJT0uDDJe4HaIohIAs5chIZuIkAPINU87Z965zfp6YUohVZmxl4t9yKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705595; c=relaxed/simple;
	bh=N/Q5yCArb0lZ1alwloBHl6BW2oXOvExRNHwIvb5JVz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgvddxynRHqTAaU/+mtDwn6l3cnOoCmNfCzl+GJCK1MlQI4Wu1XRwyvixRviTkZeV1GoDRM/ZqzoMNyWKQLd/K8ctR3AX6gz/nliZ61AcujjBHqciqvEu2ryrz/Ib+7W1xzIRJ6Qc+bR3WD7Dyc8okPKzkH3p3v9BOCHnqWzwWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fRZBDhXR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nbQn4Dwp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fRZBDhXR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nbQn4Dwp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17F9F1F388;
	Tue, 11 Mar 2025 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741705587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNm4pytyaoe7ANX3uVAZTOUpMB40I2SmkL4njmoWVMY=;
	b=fRZBDhXRcR8zxQB7E4FtNgsDK/tAdjw6IGbvkC8RdHfaWFXARN8h4l4GoPFR7i5qXOEo2V
	SGNRbY5/+x5EM0lDrYff6RexFqOWC/6Xa7/kdFNpmr/mkYUIqrhIRU0N/QKPi+LRnIbvUn
	g0bv1m887pAOKLcNVC1XKMRcncHxyco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741705587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNm4pytyaoe7ANX3uVAZTOUpMB40I2SmkL4njmoWVMY=;
	b=nbQn4Dwpf6FmN3viwh5m0UZsz+M8ZBE4ZVeZyK1hDdIYSIlxytRaG+MrQcxAe2eue1ErQc
	ilnfx+189PwC6XAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fRZBDhXR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nbQn4Dwp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741705587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNm4pytyaoe7ANX3uVAZTOUpMB40I2SmkL4njmoWVMY=;
	b=fRZBDhXRcR8zxQB7E4FtNgsDK/tAdjw6IGbvkC8RdHfaWFXARN8h4l4GoPFR7i5qXOEo2V
	SGNRbY5/+x5EM0lDrYff6RexFqOWC/6Xa7/kdFNpmr/mkYUIqrhIRU0N/QKPi+LRnIbvUn
	g0bv1m887pAOKLcNVC1XKMRcncHxyco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741705587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNm4pytyaoe7ANX3uVAZTOUpMB40I2SmkL4njmoWVMY=;
	b=nbQn4Dwpf6FmN3viwh5m0UZsz+M8ZBE4ZVeZyK1hDdIYSIlxytRaG+MrQcxAe2eue1ErQc
	ilnfx+189PwC6XAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 063E0132CB;
	Tue, 11 Mar 2025 15:06:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MqE2AHNR0GcoZgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 11 Mar 2025 15:06:27 +0000
Date: Tue, 11 Mar 2025 16:06:26 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/15] nvmet-fcloop: update refs on tfcp_req
Message-ID: <48b56e21-2ccf-42ad-83ff-3cd97415e661@flourine.local>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
 <20250311-nvmet-fcloop-v2-7-fc40cb64edea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-nvmet-fcloop-v2-7-fc40cb64edea@kernel.org>
X-Rspamd-Queue-Id: 17F9F1F388
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Tue, Mar 11, 2025 at 11:11:33AM +0100, Daniel Wagner wrote:
> @@ -930,6 +932,8 @@ fcloop_fcp_req_release(struct nvmet_fc_target_port *tgtport,
>  {
>  	struct fcloop_fcpreq *tfcp_req = tgt_fcp_req_to_fcpreq(tgt_fcpreq);
>  
> +	if (!fcloop_tfcp_req_get(tfcp_req))
> +		return;
>  	queue_work(nvmet_wq, &tfcp_req->tio_done_work);
>  }

The ref is already taken in fcloop_fcp_req, so this is wrong and is the
reason for memory leak I observed.

