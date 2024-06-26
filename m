Return-Path: <linux-kernel+bounces-230912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C1E9183B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CC01C20FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82481849EF;
	Wed, 26 Jun 2024 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S3ciBK8J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zkJ3di6W";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JFhZ6PfP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dg1Uf2ry"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C98A18412F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411074; cv=none; b=UDEIr5z2+0gnyboX7eRvyHf3WV3SpfmWy8Oj4ZV9KTvZBCCi/P5aN/DVwfA7pxnxhYehCyoN1Ibz5ilD6rbcckNtfleLfv1kaoktpIhOEBwej2J52K2537faPDXQoBKM3bWQaXU9edfIxrD2e6nOtS1DvuMuvGKWid784T9i4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411074; c=relaxed/simple;
	bh=iL4EPvfHXVSEXD+fKi2d/HzoEbSC5P2OgSN8lP64ssU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RiNIKPrtqU7iMbpezejTO5nOT6+2ChHecvZmQp6fZF320AL+SFnpm54KyIezrv6AUgUzwtSi0dmQC2F4RC2+s5O0PPS6k7W2Fssv9Az3NutOKUdkh1oMR+8Mr5fisF7Vj1SmFZ1ocOQdrhu+lwHDyd+2Rgb1H0n2VNqTv1L7g2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S3ciBK8J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zkJ3di6W; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JFhZ6PfP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dg1Uf2ry; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 287FD1FB53;
	Wed, 26 Jun 2024 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719411071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dWoxlCDIe+rD5CzZ0z0C215A8LG7XgazoeYUuCuXoqU=;
	b=S3ciBK8JO9LhtvrFdSNe+gIeWBiw0eLG9Jvj4G6O2furAP8gKbbn1mLLJJAwwnKKtKrcjN
	HrLgR0KlEmd9TyEn94KuU6umDutkdJ542GdM637O09dSkMSRjzUMIv5JHmUGwOtRFQSFNy
	FXzTMCI9weqYyWKpXcchmVnzxSN3qxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719411071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dWoxlCDIe+rD5CzZ0z0C215A8LG7XgazoeYUuCuXoqU=;
	b=zkJ3di6WZYOskG3jTwbR5g7D3AgyMsHhf/Oixx/yOEJsDGf+RZEObU/XmUC5zlpo5C3CNy
	4yLqBONU0AuXjXAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719411070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dWoxlCDIe+rD5CzZ0z0C215A8LG7XgazoeYUuCuXoqU=;
	b=JFhZ6PfPw2iEu92zzfWR4wx/ES76LIWMHiD4oWloY53IkP38Y+/WXQdT0dIV9GHao2Vx2U
	xALZQWgEesbl96YhNzJZtB+h7kiDmorhhjzuI57jLglxM+GK8Y/uOoEzv+LMv2aodsOxIm
	iKiSdVOJ2KJzj7//8e8Em7F5ifOfNGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719411070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dWoxlCDIe+rD5CzZ0z0C215A8LG7XgazoeYUuCuXoqU=;
	b=dg1Uf2ryca843gx82lY3XrY/kOWT2DlYWdVM28K49AlZVeq3y8HoZB9x4ZBOdcdolqCRZO
	acqMriiCv+tC7kAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3CCB13AAD;
	Wed, 26 Jun 2024 14:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hTliMn0hfGaMTQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Jun 2024 14:11:09 +0000
Message-ID: <dac6562e-2542-410d-909a-c1a15e5daa2c@suse.de>
Date: Wed, 26 Jun 2024 16:11:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: select DRM_GEM_DMA_HELPER if
 DRM_FBDEV_EMULATION=y
From: Thomas Zimmermann <tzimmermann@suse.de>
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
 <8cb41481-f44c-4615-8c1f-d38261082a10@suse.de>
Content-Language: en-US
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
In-Reply-To: <8cb41481-f44c-4615-8c1f-d38261082a10@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,chromium.org:email,mediatek.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 



Am 26.06.24 um 16:07 schrieb Thomas Zimmermann:
> Hi
>
> Am 26.06.24 um 08:37 schrieb Chen-Yu Tsai:
>> Hi Thomas,
>>
>> On Thu, Jun 20, 2024 at 10:20 PM Chun-Kuang Hu 
>> <chunkuang.hu@kernel.org> wrote:
>>> Hi, Chen-Yu:
>>>
>>> Chen-Yu Tsai <wenst@chromium.org> 於 2024年6月20日 週四 下午1:47寫道：
>>>> With the recent switch from fbdev-generic to fbdev-dma, the driver now
>>>> requires the DRM GEM DMA helpers. This dependency is missing, and will
>>>> cause a link failure if fbdev emulation is enabled.
>>>>
>>>> Add the missing dependency.
>>> Acked-by: Chun-Kuang Hu <chunkuang.hu@mediatek.com>
>> Could you help merge this?
>
> It's merged into drm-misc-fixes.

drm-misc-next

>
> Best regards
> Thomas
>
>>
>> Thanks
>> ChenYu
>>
>>>> Fixes: 0992284b4fe4 ("drm/mediatek: Use fbdev-dma")
>>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>>> ---
>>>> The commit this patch fixes is in drm-misc-next. Ideally this patch
>>>> should be applied on top of it directly.
>>>>
>>>> CK, could you give your ack for it?
>>>>
>>>>   drivers/gpu/drm/mediatek/Kconfig | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/mediatek/Kconfig 
>>>> b/drivers/gpu/drm/mediatek/Kconfig
>>>> index 96cbe020f493..d6449ebae838 100644
>>>> --- a/drivers/gpu/drm/mediatek/Kconfig
>>>> +++ b/drivers/gpu/drm/mediatek/Kconfig
>>>> @@ -7,6 +7,7 @@ config DRM_MEDIATEK
>>>>          depends on HAVE_ARM_SMCCC
>>>>          depends on OF
>>>>          depends on MTK_MMSYS
>>>> +       select DRM_GEM_DMA_HELPER if DRM_FBDEV_EMULATION
>>>>          select DRM_KMS_HELPER
>>>>          select DRM_MIPI_DSI
>>>>          select DRM_PANEL
>>>> -- 
>>>> 2.45.2.741.gdbec12cfda-goog
>>>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


