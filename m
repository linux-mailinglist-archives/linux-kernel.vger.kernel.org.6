Return-Path: <linux-kernel+bounces-230908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764C09183A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D9228277F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF68E1849D1;
	Wed, 26 Jun 2024 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bHukuL4q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="46Of8gLj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bHukuL4q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="46Of8gLj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1374018413A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410863; cv=none; b=VxNYN1QfIhdHW5wYRnGJ+ddPSzDd1Ra3AckN+ROJ76+nwvpHJJf9xmQO1Lb2vZCt1J1CWp0CDpbTZV9sF1yuphA4/K/H8ffb6ivGOx2nPTLjB5AxdbcqGCTCw6fatzz6cnoabWndcwxwxkTDs15XA04YadMEV6i2+qi6qi8mIj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410863; c=relaxed/simple;
	bh=Fp2c3dto0ROFlWfYq5NVPGPFaTl/tAgTIKT4I874dx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulXd8LihiiUV8u45cf/a7X/VPzFhQLD+cuVifygLS1ZyIAMZTFjs/OTvAJbwke0q6rbwVY2zzPFunmdi2VMiE2d8okZRDbYxHs6NGEoWeAvjKNbcb8bpTv93whTKol/H15jod7Z/Vh89aa/h4EhOMuwqGc80YSECWxjSuiV3gns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bHukuL4q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=46Of8gLj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bHukuL4q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=46Of8gLj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3921C21AA4;
	Wed, 26 Jun 2024 14:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719410860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RKgO2aXSPMPQ2zbiZ6HP2srpmQzgcc2ZoyxAEDMw+Ks=;
	b=bHukuL4qL7MfvWaAi74mNRA9dmjiUP2FdtEWPVgCTX8KaLiq3ir4t8IJlfqmNydUg9/Frd
	RpRLuQVjX/CsUzo3TnMznMUtGBFWLBQW+OsA6a0f7UHTz8aquna4RL/Js/aXUNkdYho4VY
	LAGd+XsiHByeQwl7nS4G0y+xwnEKigo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719410860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RKgO2aXSPMPQ2zbiZ6HP2srpmQzgcc2ZoyxAEDMw+Ks=;
	b=46Of8gLjJRNIFUZNnke9gq1GxTx7qSFWq2LYugSVA+u3sUVyY+xHy3RthhlQ7kB7meH1X1
	kFN+QiaDfIGsGxCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719410860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RKgO2aXSPMPQ2zbiZ6HP2srpmQzgcc2ZoyxAEDMw+Ks=;
	b=bHukuL4qL7MfvWaAi74mNRA9dmjiUP2FdtEWPVgCTX8KaLiq3ir4t8IJlfqmNydUg9/Frd
	RpRLuQVjX/CsUzo3TnMznMUtGBFWLBQW+OsA6a0f7UHTz8aquna4RL/Js/aXUNkdYho4VY
	LAGd+XsiHByeQwl7nS4G0y+xwnEKigo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719410860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RKgO2aXSPMPQ2zbiZ6HP2srpmQzgcc2ZoyxAEDMw+Ks=;
	b=46Of8gLjJRNIFUZNnke9gq1GxTx7qSFWq2LYugSVA+u3sUVyY+xHy3RthhlQ7kB7meH1X1
	kFN+QiaDfIGsGxCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECB0B13AAD;
	Wed, 26 Jun 2024 14:07:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D3OpN6sgfGaOTAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Jun 2024 14:07:39 +0000
Message-ID: <8cb41481-f44c-4615-8c1f-d38261082a10@suse.de>
Date: Wed, 26 Jun 2024 16:07:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: select DRM_GEM_DMA_HELPER if
 DRM_FBDEV_EMULATION=y
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20240620054708.2230665-1-wenst@chromium.org>
 <CAAOTY_9tLUAcw+C5D78SNwrV6kHds7JhtAoFYFmxxfAH9vtkDQ@mail.gmail.com>
 <CAGXv+5FQaJFuouB4feS4KEK+KqSZaJ=en8d9700gkqpQLOBr5g@mail.gmail.com>
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
In-Reply-To: <CAGXv+5FQaJFuouB4feS4KEK+KqSZaJ=en8d9700gkqpQLOBr5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,imap1.dmz-prg2.suse.org:helo]

Hi

Am 26.06.24 um 08:37 schrieb Chen-Yu Tsai:
> Hi Thomas,
>
> On Thu, Jun 20, 2024 at 10:20 PM Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:
>> Hi, Chen-Yu:
>>
>> Chen-Yu Tsai <wenst@chromium.org> 於 2024年6月20日 週四 下午1:47寫道：
>>> With the recent switch from fbdev-generic to fbdev-dma, the driver now
>>> requires the DRM GEM DMA helpers. This dependency is missing, and will
>>> cause a link failure if fbdev emulation is enabled.
>>>
>>> Add the missing dependency.
>> Acked-by: Chun-Kuang Hu <chunkuang.hu@mediatek.com>
> Could you help merge this?

It's merged into drm-misc-fixes.

Best regards
Thomas

>
> Thanks
> ChenYu
>
>>> Fixes: 0992284b4fe4 ("drm/mediatek: Use fbdev-dma")
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>> The commit this patch fixes is in drm-misc-next. Ideally this patch
>>> should be applied on top of it directly.
>>>
>>> CK, could you give your ack for it?
>>>
>>>   drivers/gpu/drm/mediatek/Kconfig | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
>>> index 96cbe020f493..d6449ebae838 100644
>>> --- a/drivers/gpu/drm/mediatek/Kconfig
>>> +++ b/drivers/gpu/drm/mediatek/Kconfig
>>> @@ -7,6 +7,7 @@ config DRM_MEDIATEK
>>>          depends on HAVE_ARM_SMCCC
>>>          depends on OF
>>>          depends on MTK_MMSYS
>>> +       select DRM_GEM_DMA_HELPER if DRM_FBDEV_EMULATION
>>>          select DRM_KMS_HELPER
>>>          select DRM_MIPI_DSI
>>>          select DRM_PANEL
>>> --
>>> 2.45.2.741.gdbec12cfda-goog
>>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


