Return-Path: <linux-kernel+bounces-286523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C14951C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65461F25B30
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA401B1430;
	Wed, 14 Aug 2024 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ONWs1ty3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XmLbRoFk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yyy5cdXD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RKNbi6LG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F4B1B012D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642857; cv=none; b=K0FKMRFa9a5AdlxeU3r1/9TgpHc6q/UM9U/FY3LhSRIL18r2UnyECOIAhgeGuftSMrB1gAX6YjmVvL5WwVX6k4Zg7g6kg31x//owLpI0NiNPoDhZ+U6Ir3DINGvj3MoD+AsOvDoC7ceZsz9/yMLo60I3srHgkxDhPbB/kgWl+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642857; c=relaxed/simple;
	bh=Exo1mofpZR8sZHUca839qVhpqiUggeT62P2f84zvL+E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhJyaJjkosTFiZvMtgwaZdYQbF0YrCHndyr2hb5MqUmNySy3CgoxjpaqltNHbeYdhbbq/xgrQy/UMcZui3SMbixEMaCvfC/NgtDxcae/yh+FN2ZruZ/cYoTwoLoq2o4MsroI2NK+QamBoBVStLfPUQ6/ySCWm58hGeaYtWyDlSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ONWs1ty3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XmLbRoFk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Yyy5cdXD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RKNbi6LG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E55051F7F4;
	Wed, 14 Aug 2024 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723642854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg5JKtkkkM33EZLC6zyWrtvhK6J3/MeJhS520JXiFI8=;
	b=ONWs1ty3GOMoEopyoQA8dbkJzIZkDHeGtQ8SvimAQqwzEUaEnuG6kYMAx14BnSydPdsGy8
	TsweywaeSGZuf16jdx1smwRTwoPWOjo8AqH5DoTH2wnQaMt9eQCIuhCycGLcVPDmarG6aZ
	W2TtDdkv4BbKSn/NzIgMlA8KME6l+AY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723642854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg5JKtkkkM33EZLC6zyWrtvhK6J3/MeJhS520JXiFI8=;
	b=XmLbRoFkR7B1gIrTE4YvJ1Oaea2g5fWnpQB8vgNevOboMe56TMjtZMlsKN4Z5WXinH9KPs
	c3QGOJmeVi0x9qCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723642853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg5JKtkkkM33EZLC6zyWrtvhK6J3/MeJhS520JXiFI8=;
	b=Yyy5cdXDsYNV3Be7nryYyuXujKJlBSYOCP9qaMm7bGjJwyK/EhNZYg36fO+s8BAakJ0Oy3
	HGgkz7ysMUGa/W31W+PZjRdmddIhmFwFdtW7aAjM71t8BplSIuvekwi+bfVjEpJ9B3h4X8
	9CikvX8bnY6yWkvOYQZLyVffRBx1fUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723642853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg5JKtkkkM33EZLC6zyWrtvhK6J3/MeJhS520JXiFI8=;
	b=RKNbi6LGwmFer1K3pYr3PzMXCSbvrD7mFZZtLrpNbqI5M99ys38VP8TZyXeNSVynjXizbL
	H22VpVSYnC+NN7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CCA51348F;
	Wed, 14 Aug 2024 13:40:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EUo0HeWzvGbJRAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 14 Aug 2024 13:40:53 +0000
Date: Wed, 14 Aug 2024 15:41:33 +0200
Message-ID: <87o75vjk6q.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v1] ALSA: hda: tas2563: mark const variables as __maybe_unused
In-Reply-To: <20240814122043.1731-1-shenghao-ding@ti.com>
References: <20240814122043.1731-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,139.com,alsa-project.org,vger.kernel.org,intel.com,ti.com,irl.hu,fpt.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.80

On Wed, 14 Aug 2024 14:20:42 +0200,
Shenghao Ding wrote:
> 
> From: Baojun Xu <baojun.xu@ti.com>
> 
> An earlier patch changed the DECLARE_TLV_DB_SCALE declaration, but
> now there are additional static const variables that cause
> the same build warnings:
> 
> In file included from sound/pci/hda/tas2781_hda_i2c.c:23:
> include/sound/tas2563-tlv.h:21:28: error: 'tas2563_dvc_table' defined but not used [-Werror=unused-const-variable=]
>    21 | static const unsigned char tas2563_dvc_table[][4] = {
>       |                            ^~~~~~~~~~~~~~~~~                                 ^~~~~~~~~~~~~~~
> 
> Mark it as unused as well.
> 
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

This isn't found in my tree, maybe found only in Mark's tree?

In anyway, you should put Fixes tag.


Takashi

> 
> ---
> v1:
> ---
>  include/sound/tas2563-tlv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/sound/tas2563-tlv.h b/include/sound/tas2563-tlv.h
> index faa3e194f73b..bb269b21f460 100644
> --- a/include/sound/tas2563-tlv.h
> +++ b/include/sound/tas2563-tlv.h
> @@ -18,7 +18,7 @@
>  static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2563_dvc_tlv, -12150, 50, 1);
>  
>  /* pow(10, db/20) * pow(2,30) */
> -static const unsigned char tas2563_dvc_table[][4] = {
> +static const __maybe_unused unsigned char tas2563_dvc_table[][4] = {
>  	{ 0X00, 0X00, 0X00, 0X00 }, /* -121.5db */
>  	{ 0X00, 0X00, 0X03, 0XBC }, /* -121.0db */
>  	{ 0X00, 0X00, 0X03, 0XF5 }, /* -120.5db */
> -- 
> 2.43.0
> 

