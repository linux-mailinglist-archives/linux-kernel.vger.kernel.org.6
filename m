Return-Path: <linux-kernel+bounces-284674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766FE9503F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2939B1F26702
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765CC1991AA;
	Tue, 13 Aug 2024 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fiCN1956";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aWDHmumI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iz6DxFO+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JHCU7YQO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EBD170A2B;
	Tue, 13 Aug 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549392; cv=none; b=qykxC/dd1UcD421TpPCHJkAtmTx29/EUmn9JFox+5m5djpVPbf0ZSzk+oWekDaVYhIZrzuN1Yk8R3bphi58+ABDFbO7ah3C6woTGmOArCou6rpObVYaeOWlOQsxByLyJKsxkz9/45eK7SZ+gH7PO5yYVUWeOBSG7DJkkfdn+D9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549392; c=relaxed/simple;
	bh=pjUfrEENcwPiuW1gXWM710zyRSsutznZkJKROw7R1o8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnGYEGxw1lMpVqjOALXkQakg3AvoSbeZrquvwayRnOep0kYOjG5CIUxUunKK/lOTNcy0kBIJWRxuKKGxRoc8yNL65p9vPaV7vITfuvH3mtTegydGEHBSUDLK+NxktLNhAMz9DxJIi/upaZ9JMlXL5P/46bx5T/SqPC7aVoUpdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fiCN1956; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aWDHmumI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iz6DxFO+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JHCU7YQO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4DEE227A1;
	Tue, 13 Aug 2024 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723549389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hyhXYO2osn1IltdLcMAc23cZGDHEk3jzE+nzBzn+GDU=;
	b=fiCN19565Qx1VSqMY3NU3oGaDboK4WMsqd0cMyY0zj4awButn3o4sW19YqtyP4jnyWFLn5
	nnHKY/gRgaWfk0XJ8QKY2Ouygk21GsFMPuCYfUOaXvAYymzQFbnm+14GeyGcfYkH3praeW
	HcNRdnnxumb4q4siY2ccIwsnVVhTh9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723549389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hyhXYO2osn1IltdLcMAc23cZGDHEk3jzE+nzBzn+GDU=;
	b=aWDHmumIq+Opn/9js5XTCoHB2g5u5xXSpYKhLNW35qkp/6xnRb4SkMWXOhE3joFyHNG2XO
	Jt3zqhqJOq/H0uCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723549387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hyhXYO2osn1IltdLcMAc23cZGDHEk3jzE+nzBzn+GDU=;
	b=iz6DxFO+HoJwOsKmBRRGP1rbhrPYIt1XTB8TujjiOCkjkAY4zoiJPRLNEbq10+oNsCuTo7
	PwD7MP8eJ//44kx2DRr7oRfXkrC45NK2sdvLD9YgPCmDWQqdgmrm9OfJaEPi/5zPQ87MV0
	N4wfDhlycX+WdT6pGsPP3aEwIli6ykQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723549387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hyhXYO2osn1IltdLcMAc23cZGDHEk3jzE+nzBzn+GDU=;
	b=JHCU7YQOcjSUu1tkgKer3oiB/OuC09UZafAtKAYdYuHvXlu1wgg+568BdETGCWVyxDJ2cZ
	qnUUFuTSTCH5vODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C605013ABD;
	Tue, 13 Aug 2024 11:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VwbDL8tGu2Y4cgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Aug 2024 11:43:07 +0000
Date: Tue, 13 Aug 2024 13:43:44 +0200
Message-ID: <87le10myvj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l41: Remove redundant call to hda_cs_dsp_control_remove()
In-Reply-To: <20240813113209.648-1-rf@opensource.cirrus.com>
References: <20240813113209.648-1-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,cirrus.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 13 Aug 2024 13:32:09 +0200,
Richard Fitzgerald wrote:
> 
> The driver doesn't create any ALSA controls for firmware controls, so it
> shouldn't be calling hda_cs_dsp_control_remove().
> 
> commit 312c04cee408 ("ALSA: hda: cs35l41: Stop creating ALSA Controls for
> firmware coefficients") removed the call to hda_cs_dsp_add_controls() but
> didn't remove the call for destroying those controls.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: 312c04cee408 ("ALSA: hda: cs35l41: Stop creating ALSA Controls for firmware coefficients")

Applied now.  Thanks.


Takashi

