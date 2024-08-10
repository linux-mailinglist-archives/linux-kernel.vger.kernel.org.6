Return-Path: <linux-kernel+bounces-281804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD2994DB85
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2CE1C20F8E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DCE14C583;
	Sat, 10 Aug 2024 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RxQTC84H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L9SKZ51N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RxQTC84H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L9SKZ51N"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842D14A619;
	Sat, 10 Aug 2024 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723279485; cv=none; b=LPrgh8dwax4JYteMmxhAmLnfWztNrgeSqVWDVMax1HBxK11Fzi2M8U1oKYhiXyi1OztkQqmn/dvlKtrmjS1ptsrEdLUB0hvnkQ4Us+S4hmp+f1/m/6xGZWQWOBviWCP0dknFtGNzoIQTvqtt1PDgRuIix/GPZGD6CB3wwwF7vHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723279485; c=relaxed/simple;
	bh=c/RwEOaUSKi72KfqmIBZa825Bnw3eHT31tA7kOS3oH0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afxXS17r0UgSM4b0BvWj+VPBBhw7L73ZLsR1ITdrveV2an1SKpEU/w5VXpkidtESHgpTnK8rv3KIQnonFSQhpu2wQulitBC6WmMUa+QJtMhQ103xnqUAQTN5f+wDAjYJEMxxhkThhTEHo6fGnAOpZgdflYeff/ZPU3/Z9wTtKhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RxQTC84H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L9SKZ51N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RxQTC84H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L9SKZ51N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE70B22190;
	Sat, 10 Aug 2024 08:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723279481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxsbgKosTuzCKczBe+icPm36tufV1HnIqOg/8PB14oM=;
	b=RxQTC84HcXmhzwzzN4gobnLun34okD6A3xUEeNboNuEsaS5tFmh3VEqLZrtopkp9rmMVoo
	QYKhW+kHLVyzQY337QPCusCBEHD7hX/W0tJbgLwJXxuSI221zO1Q8Y1NO3GGzn9tojZNHv
	H+Xr5dXAAR7cMO3P55voaWI9Fadevfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723279481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxsbgKosTuzCKczBe+icPm36tufV1HnIqOg/8PB14oM=;
	b=L9SKZ51NdjMHhH087N0BgdqmAwZCJ/xAiL/z711h/wiD5r0j4tPS6DFZo7dUYytYIHjPdX
	vL0992pcTgbVrsAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RxQTC84H;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=L9SKZ51N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723279481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxsbgKosTuzCKczBe+icPm36tufV1HnIqOg/8PB14oM=;
	b=RxQTC84HcXmhzwzzN4gobnLun34okD6A3xUEeNboNuEsaS5tFmh3VEqLZrtopkp9rmMVoo
	QYKhW+kHLVyzQY337QPCusCBEHD7hX/W0tJbgLwJXxuSI221zO1Q8Y1NO3GGzn9tojZNHv
	H+Xr5dXAAR7cMO3P55voaWI9Fadevfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723279481;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxsbgKosTuzCKczBe+icPm36tufV1HnIqOg/8PB14oM=;
	b=L9SKZ51NdjMHhH087N0BgdqmAwZCJ/xAiL/z711h/wiD5r0j4tPS6DFZo7dUYytYIHjPdX
	vL0992pcTgbVrsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6274113704;
	Sat, 10 Aug 2024 08:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X4bcFnkot2arJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 10 Aug 2024 08:44:41 +0000
Date: Sat, 10 Aug 2024 10:45:21 +0200
Message-ID: <878qx4lqam.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?GB2312?B?uvrBrMfa?= <hulianqin@vivo.com>
Cc: "perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"mbarriolinares@gmail.com" <mbarriolinares@gmail.com>,
	"wangdicheng@kylinos.cn" <wangdicheng@kylinos.cn>,
	"sean@mess.org"
	<sean@mess.org>,
	"alexander@tsoy.me" <alexander@tsoy.me>,
	"xristos.thes@gmail.com" <xristos.thes@gmail.com>,
	"knuesel@gmail.com"
	<knuesel@gmail.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>,
	"akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject: Re: [PATCH] ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710 HEADSET
In-Reply-To: <PUZPR06MB6224FEB85F27A5AB7A59A1BCD2BA2@PUZPR06MB6224.apcprd06.prod.outlook.com>
References: <PUZPR06MB6224FEB85F27A5AB7A59A1BCD2BA2@PUZPR06MB6224.apcprd06.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: BE70B22190
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,kylinos.cn,mess.org,tsoy.me,vger.kernel.org,vivo.com,linux-foundation.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On Fri, 09 Aug 2024 12:38:52 +0200,
ºúÁ¬ÇÚ wrote:
> 
> From: Lianqin Hu <hulianqin@vivo.com>
> 
> Audio control requests that sets sampling frequency sometimes fail on
> this card. Adding delay between control messages eliminates that problem.
> 
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> ---
>  sound/usb/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> index ea063a14cdd8..4c7f0f9d15de 100644
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -2119,6 +2119,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
>  		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
>  	DEVICE_FLG(0x07fd, 0x000b, /* MOTU M Series 2nd hardware revision */
>  		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
> +	DEVICE_FLG(0x2d95, 0x8021, /* VIVO USB-C-XE710 HEADSET */
> +		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
>  	DEVICE_FLG(0x08bb, 0x2702, /* LineX FM Transmitter */
>  		   QUIRK_FLAG_IGNORE_CTL_ERROR),
>  	DEVICE_FLG(0x0951, 0x16ad, /* Kingston HyperX */

The quirk table entry is sorted in the ID number order.
Could you try to put the new entry at the right position?


thanks,

Takashi

