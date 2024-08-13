Return-Path: <linux-kernel+bounces-284191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A3394FE26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D2C284AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD999433CB;
	Tue, 13 Aug 2024 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G1fiGImM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vhslKYMn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G1fiGImM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vhslKYMn"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CCF41C69
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532341; cv=none; b=mGa7WuoKRFvPGDbSoCLnC/KfM5qnUaem61kLBqLxB/ilB9RjwyjdauHdtCFC2I5Z3hBAaDpoQC8PRAdCSyhWci79Mx+pcbhlvQTY9xDmiwL4gIpWzLJ4G3JmukzUTJCN4/WYdxZtewucn/bnmwIVodqoRo5zxr/CKDWjX7XtvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532341; c=relaxed/simple;
	bh=ERnCb7GNxRzZmUj1NsQxVVH1zhVfW4u5qmEkAr0fYZg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pfo8fPONrZa/vlOMJxlVnRoNYUNu1rDr0R2Crr+v4J4V50OpAAHf+J8RTiiwqAqYnal6a/lR3KB+rFBakjNq/geeMl5px2tijKUvNTUcWBGWiRiVUIQ9/e6TAnyglVWMg1IKGCnNLRF5PpQehaqQoYw9X+BaLmZ4w79sbgaMsb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G1fiGImM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vhslKYMn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G1fiGImM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vhslKYMn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8C3622725;
	Tue, 13 Aug 2024 06:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723532331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYv3HXyrUd9oqACj2L8eRTsJyUQpj3b67JE2bftMn28=;
	b=G1fiGImM9scQXcwgIoi1bPsCRVwMqIVqnpo1pMAnELagGHvcjR7TRt0Xw79pCPQOW9y+n0
	P9f7JqKUVLo7gJr+etHqCCZVXTr8m3nIFgxAXBh+Xu1MX4fIv48j/wK+/QwJwRNcWSrb5Q
	qRci2IFugbkFcDn0dyY3sWmYVUdofEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723532331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYv3HXyrUd9oqACj2L8eRTsJyUQpj3b67JE2bftMn28=;
	b=vhslKYMnWH/XoTFRVabBsX/dDSZ5L4xZsGXLafNfzJ/GvAdCUxZPn3o7mmBNWxmDFOWD9d
	4+tnFC7MiNyY1YBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G1fiGImM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vhslKYMn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723532331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYv3HXyrUd9oqACj2L8eRTsJyUQpj3b67JE2bftMn28=;
	b=G1fiGImM9scQXcwgIoi1bPsCRVwMqIVqnpo1pMAnELagGHvcjR7TRt0Xw79pCPQOW9y+n0
	P9f7JqKUVLo7gJr+etHqCCZVXTr8m3nIFgxAXBh+Xu1MX4fIv48j/wK+/QwJwRNcWSrb5Q
	qRci2IFugbkFcDn0dyY3sWmYVUdofEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723532331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rYv3HXyrUd9oqACj2L8eRTsJyUQpj3b67JE2bftMn28=;
	b=vhslKYMnWH/XoTFRVabBsX/dDSZ5L4xZsGXLafNfzJ/GvAdCUxZPn3o7mmBNWxmDFOWD9d
	4+tnFC7MiNyY1YBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60F7313983;
	Tue, 13 Aug 2024 06:58:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3KjtFCsEu2YaGgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Aug 2024 06:58:51 +0000
Date: Tue, 13 Aug 2024 08:59:31 +0200
Message-ID: <87bk1wdi24.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<pierre-louis.bossart@linux.intel.com>,
	<13564923607@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<cameron.berkenpas@gmail.com>,
	<baojun.xu@ti.com>,
	<soyer@irl.hu>,
	<Baojun.Xu@fpt.com>,
	<robinchen@ti.com>
Subject: Re: [PATCH v2] ALSA: ASoC/tas2781: fix wrong calibrated data order
In-Reply-To: <20240813043749.108-1-shenghao-ding@ti.com>
References: <20240813043749.108-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: C8C3622725
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,139.com,alsa-project.org,vger.kernel.org,intel.com,ti.com,irl.hu,fpt.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 13 Aug 2024 06:37:48 +0200,
Shenghao Ding wrote:
> 
> From: Baojun Xu <baojun.xu@ti.com>
> 
> Wrong calibration data order cause sound too low in some device.
> Fix wrong calibrated data order, add calibration data converssion
> by get_unaligned_be32() after reading from UEFI.
> 
> Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>

Applied to for-linus branch now.
I corrected the subject prefix, as this is clearly no ASoC change.


thanks,

Takashi

