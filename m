Return-Path: <linux-kernel+bounces-207871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71057901D41
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1D11B20AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211DD6F30D;
	Mon, 10 Jun 2024 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZRrpjJXM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AQZ7svCh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fo7tJJP3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KUJ48zzg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972484B5CD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009244; cv=none; b=IPYTbFJEGN2ymRK/DsHABNugDu4c6Mcvtg7k5+e3HUedlloCQjYxLRzGaATas629XJ2RK+9Y+zG0EdePRvvltUfJCiJ8zoUIXb5I2ksEGd36OTsnDEV0FIjxXrg9gsq45xOBEXVjbVBDIsA7kZbs1nNo7/DEeiokmGkZ3b1J8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009244; c=relaxed/simple;
	bh=D33CFqj0WRwlSuzd/n+shOHlDfyqWxLaaA1OmQSplHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrOnGWoVu95s2WO+WBzdW3qMjFMtqets3fdmojPV7hjmc2piXQk4F6B16RuPyfotTOuBy9UYVlEYNyx1MIIY/SFdje/3x3tzdGh5aaMR/aKtap3/soYVCk6I+SQaQuvR454lH8WlLppOsXw0+1qKFR0rSxkyY0EPYmOZuCvcYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZRrpjJXM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AQZ7svCh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fo7tJJP3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KUJ48zzg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 88FE31F797;
	Mon, 10 Jun 2024 08:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718009240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lo+k0GTKV+OGRokoL/+zJhcUO3Cl25axj4NK7XKbC9I=;
	b=ZRrpjJXMa8KBXDZIKGw86r9P3H/bjzMRN32FIM9axwevX8o9yyyn1lbXnHkEH4hAl2jGmr
	HMYwgww4CaVfmovzLrQdj5eW9YyIZstl7ATr2Qx+zXHtEy3+75gS65iSSSoYgFDzbtUX9a
	2nNDPVDN2wwcG4UIFwSbHBe8uXbPqgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718009240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lo+k0GTKV+OGRokoL/+zJhcUO3Cl25axj4NK7XKbC9I=;
	b=AQZ7svChc5BMKfQPS0lAmM55CeKw6HsjAGroSbGcmUOXNZ79vpG0UG7UhACmIx+XB8uxl1
	njMHKNvy0Im82hDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Fo7tJJP3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KUJ48zzg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718009238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lo+k0GTKV+OGRokoL/+zJhcUO3Cl25axj4NK7XKbC9I=;
	b=Fo7tJJP3TBKKWIUpg9GVXVASVLy1ute3eZZOW4CN92cGzGXBvZTRx+2SMSC3T20WnZAMrU
	l6k2jk3bCIhat/4zVDwcACyzO9k/0PXRMB4e9WfPYzuPtC5O2NBSwAt9c3ZC79r2zIQU1e
	xAy93smdXzglvKAKfo53yYSiRp/z/JA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718009238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lo+k0GTKV+OGRokoL/+zJhcUO3Cl25axj4NK7XKbC9I=;
	b=KUJ48zzg8t2r1g3nlcM6MdotTNyP/QvDrEHkSLLl/ivWDd/pNLTHskQsU6b9quWa/wq0NC
	atfmQWCWaWpHsHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E5F113A51;
	Mon, 10 Jun 2024 08:47:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id flnOEZa9ZmbkXQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 10 Jun 2024 08:47:18 +0000
Message-ID: <8f4a6d80-dd3e-422f-88af-d26f50c973ff@suse.de>
Date: Mon, 10 Jun 2024 10:47:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fbdev-dma: fix getting smem_start
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Peng Fan <peng.fan@nxp.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240604080328.4024838-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20240604080328.4024838-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 88FE31F797
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[oss.nxp.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,nxp.com:email,suse.de:dkim,suse.de:email]

Hi

Am 04.06.24 um 10:03 schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
>
> If 'info->screen_buffer' locates in vmalloc address space, virt_to_page
> will not be able to get correct results. With CONFIG_DEBUG_VM and
> CONFIG_DEBUG_VIRTUAL enabled on ARM64, there is dump below:

Which graphics driver triggers this bug?

> [    3.536043] ------------[ cut here ]------------
> [    3.540716] virt_to_phys used for non-linear address: 000000007fc4f540 (0xffff800086001000)
> [    3.552628] WARNING: CPU: 4 PID: 61 at arch/arm64/mm/physaddr.c:12 __virt_to_phys+0x68/0x98
> [    3.565455] Modules linked in:
> [    3.568525] CPU: 4 PID: 61 Comm: kworker/u12:5 Not tainted 6.6.23-06226-g4986cc3e1b75-dirty #250
> [    3.577310] Hardware name: NXP i.MX95 19X19 board (DT)
> [    3.582452] Workqueue: events_unbound deferred_probe_work_func
> [    3.588291] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    3.595233] pc : __virt_to_phys+0x68/0x98
> [    3.599246] lr : __virt_to_phys+0x68/0x98
> [    3.603276] sp : ffff800083603990
> [    3.677939] Call trace:
> [    3.680393]  __virt_to_phys+0x68/0x98
> [    3.684067]  drm_fbdev_dma_helper_fb_probe+0x138/0x238
> [    3.689214]  __drm_fb_helper_initial_config_and_unlock+0x2b0/0x4c0
> [    3.695385]  drm_fb_helper_initial_config+0x4c/0x68
> [    3.700264]  drm_fbdev_dma_client_hotplug+0x8c/0xe0
> [    3.705161]  drm_client_register+0x60/0xb0
> [    3.709269]  drm_fbdev_dma_setup+0x94/0x148
>
> So add a check 'is_vmalloc_addr'.
>
> Fixes: b79fe9abd58b ("drm/fbdev-dma: Implement fbdev emulation for GEM DMA helpers")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas

> ---
>   drivers/gpu/drm/drm_fbdev_dma.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
> index 6c9427bb4053..9e2eddb6eb5c 100644
> --- a/drivers/gpu/drm/drm_fbdev_dma.c
> +++ b/drivers/gpu/drm/drm_fbdev_dma.c
> @@ -130,7 +130,12 @@ static int drm_fbdev_dma_helper_fb_probe(struct drm_fb_helper *fb_helper,
>   		info->flags |= FBINFO_READS_FAST; /* signal caching */
>   	info->screen_size = sizes->surface_height * fb->pitches[0];
>   	info->screen_buffer = map.vaddr;
> -	info->fix.smem_start = page_to_phys(virt_to_page(info->screen_buffer));
> +
> +	if (is_vmalloc_addr(info->screen_buffer))
> +		info->fix.smem_start = page_to_phys(vmalloc_to_page(info->screen_buffer));
> +	else
> +		info->fix.smem_start = page_to_phys(virt_to_page(info->screen_buffer));
> +
>   	info->fix.smem_len = info->screen_size;
>   
>   	return 0;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


