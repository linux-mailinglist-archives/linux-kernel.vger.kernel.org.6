Return-Path: <linux-kernel+bounces-416689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB999D48C5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5678B21ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08701CB337;
	Thu, 21 Nov 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zzXGB22I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CRhSU64O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zzXGB22I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CRhSU64O"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD91CB303
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177439; cv=none; b=eCDzab2C304iK6nmTitdkfFtL80/ISPc560UUBCnkh+u/uHVhTG5eXmqcE9OSF2q7UyDyGFx0X4vb5YpNHDAbLWISdmQfN835opn5yAoVu6l8mhag9Qu/LCNxUNghu1RRj650H/x3RQytZuQEm39j7QILuZwTudAg35kSAlAbjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177439; c=relaxed/simple;
	bh=FxU/NDdwXsyL33hiVJkZBvnoW2YLJX/z+/IYSZnzCLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdkllik0pZvTwSbc0ArAmUMShIxGNqUbu41MKA1wqd1umoeyVqi8oHXuQXhoso7m8u+5o6oK05UTpY1cfkov7Sk6FsmLaTwB1+BX5Ph/lsuSF1vZ1t9Swf/SjtxvJCpp/G1cKPnphzSUGA3aPQBxjNdp/mNlrsD5FMcFZn4FQN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zzXGB22I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CRhSU64O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zzXGB22I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CRhSU64O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E0F71F7D8;
	Thu, 21 Nov 2024 08:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732177435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hapMj94p5n4VecB364V9o9nfcdpBCu+iA+vUnN+Vee0=;
	b=zzXGB22ISV9jSYVXL7n5KqN9nqwidwS+yZIYTUgCN5wFwTu/TIV6xXxXIiBuFxpTqxKIR+
	nMTZBt0KVxnssQ5Cr2fGZgGYjiEGQV7m/kFO9WIGpOzw86QwWGaEDtbvl88U1BgIn1SvsY
	3pB6qkDxN4wAnDkpY2JD1plPmtSvtOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732177435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hapMj94p5n4VecB364V9o9nfcdpBCu+iA+vUnN+Vee0=;
	b=CRhSU64Odzom7yfwcra/4y2FiyHzfCM7Qw+r1glorcFaNE0fPyp8/For4bPGdNxptz11hY
	q1IOBtCHhMGVwBCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732177435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hapMj94p5n4VecB364V9o9nfcdpBCu+iA+vUnN+Vee0=;
	b=zzXGB22ISV9jSYVXL7n5KqN9nqwidwS+yZIYTUgCN5wFwTu/TIV6xXxXIiBuFxpTqxKIR+
	nMTZBt0KVxnssQ5Cr2fGZgGYjiEGQV7m/kFO9WIGpOzw86QwWGaEDtbvl88U1BgIn1SvsY
	3pB6qkDxN4wAnDkpY2JD1plPmtSvtOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732177435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hapMj94p5n4VecB364V9o9nfcdpBCu+iA+vUnN+Vee0=;
	b=CRhSU64Odzom7yfwcra/4y2FiyHzfCM7Qw+r1glorcFaNE0fPyp8/For4bPGdNxptz11hY
	q1IOBtCHhMGVwBCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6177E137CF;
	Thu, 21 Nov 2024 08:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8g2GFhvuPmfuRQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 21 Nov 2024 08:23:55 +0000
Message-ID: <826cbef6-2e58-4800-85af-a78c8bf90dbc@suse.de>
Date: Thu, 21 Nov 2024 09:23:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bochs: Replace deprecated PCI implicit devres
To: Philipp Stanner <pstanner@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241017125145.34729-2-pstanner@redhat.com>
 <67f6b7e9ff32593bf66f72ff1269458c3733ecae.camel@redhat.com>
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
In-Reply-To: <67f6b7e9ff32593bf66f72ff1269458c3733ecae.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi


Am 20.11.24 um 15:30 schrieb Philipp Stanner:
> On Thu, 2024-10-17 at 14:51 +0200, Philipp Stanner wrote:
>> bochs uses pcim_enable_device(), which causes pci_request_region() to
>> implicitly set up devres callbacks which will release the region on
>> driver detach. Despite this, the driver calls pci_release_regions()
>> manually on driver teardown.
>>
>> Implicit devres has been deprecated in PCI in commit 81fcf28e74a3
>> ("PCI:
>> Document hybrid devres hazards").
>>
>> Replace the calls to pci_request_region() with ones to always-managed
>> pcim_request_region(). Remove the unnecessary call to
>> pci_release_regions().
> Just saw that this patch is still floating around. Anyone feeling
> responsible for bochs who could review this?

It looks like this patch is already outdated. There's been

https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/58e980c16815ce4ff8a5e036a126358afceca538

in drm-misc-next for some time.

Best regards
Thomas

>
>
> P.
>
>
>> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>> ---
>>   drivers/gpu/drm/tiny/bochs.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tiny/bochs.c
>> b/drivers/gpu/drm/tiny/bochs.c
>> index 31fc5d839e10..888f12a67470 100644
>> --- a/drivers/gpu/drm/tiny/bochs.c
>> +++ b/drivers/gpu/drm/tiny/bochs.c
>> @@ -217,7 +217,7 @@ static int bochs_hw_init(struct drm_device *dev)
>>   
>>   	if (pdev->resource[2].flags & IORESOURCE_MEM) {
>>   		/* mmio bar with vga and bochs registers present */
>> -		if (pci_request_region(pdev, 2, "bochs-drm") != 0) {
>> +		if (pcim_request_region(pdev, 2, "bochs-drm") != 0)
>> {
>>   			DRM_ERROR("Cannot request mmio region\n");
>>   			return -EBUSY;
>>   		}
>> @@ -258,7 +258,7 @@ static int bochs_hw_init(struct drm_device *dev)
>>   		size = min(size, mem);
>>   	}
>>   
>> -	if (pci_request_region(pdev, 0, "bochs-drm") != 0)
>> +	if (pcim_request_region(pdev, 0, "bochs-drm") != 0)
>>   		DRM_WARN("Cannot request framebuffer, boot fb still
>> active?\n");
>>   
>>   	bochs->fb_map = ioremap(addr, size);
>> @@ -302,7 +302,7 @@ static void bochs_hw_fini(struct drm_device *dev)
>>   		release_region(VBE_DISPI_IOPORT_INDEX, 2);
>>   	if (bochs->fb_map)
>>   		iounmap(bochs->fb_map);
>> -	pci_release_regions(to_pci_dev(dev->dev));
>> +
>>   	drm_edid_free(bochs->drm_edid);
>>   }
>>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


