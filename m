Return-Path: <linux-kernel+bounces-213013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B919069D2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84FBE1F25974
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD171422D3;
	Thu, 13 Jun 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Mq4VvhZL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Stzvji1P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Mq4VvhZL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Stzvji1P"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046DC381C4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273939; cv=none; b=NXUMcZcS6ZU/trQwe8nr91yFfkfsBsBTG38gcD5XtSyIelOWaqhBlfTzFb0FG1gjTZY3FRP+cNs8GLbQLvcL7JfxRFFcJWN/RgESf05UluZ2GCdf4dwxy5iIhGcdEb1Es9+Fwi1Mn2rEasIHpefTFLGe60MJD6us5sItR2mkbo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273939; c=relaxed/simple;
	bh=Ote0HenQjRkBkUYfuAYFaItrOuFnhD0ekChqA0sDnAs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=QWa0VGYcGAP8o2aD5psYZlJz3kKUyS7VzEYNi6VQMur/ASpGp8KZ/E6U546iwM7FfXezErI6kX8/e3RpOtHURQteVQGFgA7B9Ra7xhrReL8MamaRb09z6ZQxtLNyYGoDJJrqrwge0WKh+PQKCyxUcdRAV8Pb3RfRdNbACYDsB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Mq4VvhZL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Stzvji1P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Mq4VvhZL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Stzvji1P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 066CB35247;
	Thu, 13 Jun 2024 10:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718273936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8RCRB3YurbbEs3mHLdzQrJO4OJYUQQYx4/ITny8W++c=;
	b=Mq4VvhZLjwHvruqvoTc7h61B03xRjalYJo7wNvTXJLHJUvqBjQwclbQWXBPbNO0FoI9KBj
	L9PFnX9LOJWkFaFmSUQBptmwMr84j9TCg7Dps6eKFydrTwDf42kqkiCFg586G8ZiLH1Wct
	e+0X/EHn/RuaFr5hyJb0S4d5P7LrJ3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718273936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8RCRB3YurbbEs3mHLdzQrJO4OJYUQQYx4/ITny8W++c=;
	b=Stzvji1PpPZ49Ox7CB0eYKxfFGlhP0qiwuoyrmnHLopCvhHCsEEcPD/TmP0MJ+qPgBGSM2
	bOxs3fw3gxkbV/Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718273936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8RCRB3YurbbEs3mHLdzQrJO4OJYUQQYx4/ITny8W++c=;
	b=Mq4VvhZLjwHvruqvoTc7h61B03xRjalYJo7wNvTXJLHJUvqBjQwclbQWXBPbNO0FoI9KBj
	L9PFnX9LOJWkFaFmSUQBptmwMr84j9TCg7Dps6eKFydrTwDf42kqkiCFg586G8ZiLH1Wct
	e+0X/EHn/RuaFr5hyJb0S4d5P7LrJ3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718273936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8RCRB3YurbbEs3mHLdzQrJO4OJYUQQYx4/ITny8W++c=;
	b=Stzvji1PpPZ49Ox7CB0eYKxfFGlhP0qiwuoyrmnHLopCvhHCsEEcPD/TmP0MJ+qPgBGSM2
	bOxs3fw3gxkbV/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B968913A7F;
	Thu, 13 Jun 2024 10:18:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kYpwK4/HamZ+fgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 13 Jun 2024 10:18:55 +0000
Message-ID: <209a99c3-6d44-4abc-a486-8e6d0a0c7370@suse.de>
Date: Thu, 13 Jun 2024 12:18:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fbdev-dma: fix getting smem_start
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240604080328.4024838-1-peng.fan@oss.nxp.com>
 <8f4a6d80-dd3e-422f-88af-d26f50c973ff@suse.de>
 <e307fdc0-553d-4946-9017-ed3a28e9cae2@suse.de>
 <87cyomsiqt.fsf@minerva.mail-host-address-is-not-set>
 <14a7c534-af3f-43b8-a24c-501a9af97936@suse.de>
 <Zmm4HSkia-x_oRWR@phenom.ffwll.local>
 <e1aa9785-6833-4bbb-bed7-2e01ee9634c6@suse.de>
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
In-Reply-To: <e1aa9785-6833-4bbb-bed7-2e01ee9634c6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[redhat.com,oss.nxp.com,linux.intel.com,kernel.org,gmail.com,nxp.com,lists.freedesktop.org,vger.kernel.org];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 

Hi

Am 13.06.24 um 12:14 schrieb Thomas Zimmermann:
> Hi
>
> Am 12.06.24 um 17:00 schrieb Daniel Vetter:
>> On Wed, Jun 12, 2024 at 10:37:14AM +0200, Thomas Zimmermann wrote:
>>> Hi Javier
>>>
>>> Am 12.06.24 um 09:49 schrieb Javier Martinez Canillas:
>>>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>>>
>>>> Hello Thomas,
>>>>
>>>>> Hi
>>>>>
>>>>> Am 10.06.24 um 10:47 schrieb Thomas Zimmermann:
>>>>>> Hi
>>>>>>
>>>>>> Am 04.06.24 um 10:03 schrieb Peng Fan (OSS):
>>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>>
>>>>>>> If 'info->screen_buffer' locates in vmalloc address space, 
>>>>>>> virt_to_page
>>>>>>> will not be able to get correct results. With CONFIG_DEBUG_VM and
>>>>>>> CONFIG_DEBUG_VIRTUAL enabled on ARM64, there is dump below:
>>>>>> Which graphics driver triggers this bug?
>>>>>>
>>>>>>> [    3.536043] ------------[ cut here ]------------
>>>>>>> [    3.540716] virt_to_phys used for non-linear address:
>>>>>>> 000000007fc4f540 (0xffff800086001000)
>>>>>>> [    3.552628] WARNING: CPU: 4 PID: 61 at 
>>>>>>> arch/arm64/mm/physaddr.c:12
>>>>>>> __virt_to_phys+0x68/0x98
>>>>>>> [    3.565455] Modules linked in:
>>>>>>> [    3.568525] CPU: 4 PID: 61 Comm: kworker/u12:5 Not tainted
>>>>>>> 6.6.23-06226-g4986cc3e1b75-dirty #250
>>>>>>> [    3.577310] Hardware name: NXP i.MX95 19X19 board (DT)
>>>>>>> [    3.582452] Workqueue: events_unbound deferred_probe_work_func
>>>>>>> [    3.588291] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT 
>>>>>>> -SSBS
>>>>>>> BTYPE=--)
>>>>>>> [    3.595233] pc : __virt_to_phys+0x68/0x98
>>>>>>> [    3.599246] lr : __virt_to_phys+0x68/0x98
>>>>>>> [    3.603276] sp : ffff800083603990
>>>>>>> [    3.677939] Call trace:
>>>>>>> [    3.680393]  __virt_to_phys+0x68/0x98
>>>>>>> [    3.684067] drm_fbdev_dma_helper_fb_probe+0x138/0x238
>>>>>>> [    3.689214] 
>>>>>>> __drm_fb_helper_initial_config_and_unlock+0x2b0/0x4c0
>>>>>>> [    3.695385]  drm_fb_helper_initial_config+0x4c/0x68
>>>>>>> [    3.700264]  drm_fbdev_dma_client_hotplug+0x8c/0xe0
>>>>>>> [    3.705161]  drm_client_register+0x60/0xb0
>>>>>>> [    3.709269]  drm_fbdev_dma_setup+0x94/0x148
>>>>>>>
>>>>>>> So add a check 'is_vmalloc_addr'.
>>>>>>>
>>>>>>> Fixes: b79fe9abd58b ("drm/fbdev-dma: Implement fbdev emulation for
>>>>>>> GEM DMA helpers")
>>>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>>> I'm taking back my r-b. The memory is expected to by be physically
>>>>> contiguous and vmalloc() won't guarantee that.
>>>>>
>>>> Agreed.
>>> These smem_ fields are clearly designed for PCI BARs of traditional 
>>> graphics
>>> cards. So can we even assume contiguous memory for DMA? That was my
>>> assumption, but with IOMMUs it might not be the case. Fbdev-dma only 
>>> sets
>>> smem_start to support a single old userspace driver. Maybe we should 
>>> further
>>> restrict usage of this field by making it opt-in for each driver. Best
>>> regards Thomas
>> We could make it all conditional on CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM, and
>> remove the FBINFO_HIDE_SMEM_START flag. The reason I've done the flag is
>> that with the old fb_mmap code we had to always fill out smem_start to
>> make mmap work. But now that the various drm fbdev helpers have all 
>> their
>> own mmap implementation, we could make this a lot cleaner.
>
> Enabling CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM would still crash the NXP 
> driver. I think I'll add a flag to drm_fbdev_dma_setup() to set 
> smem_start from within lima, which is the only driver that requires 
> it.I'd like to remove CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM and all that, 
> but I fear that it would break someone's setup. Best regards Thomas

I've been looking at

https://lore.kernel.org/dri-devel/20240318-dark-mongoose-of-camouflage-7ac6ed@houat/

and I'm now confused to find that lima doesn't even set up fbdev support.


Best regards
Thomas

>>
>> If I haven't missed anything, that is.
>> -Sima
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


