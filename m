Return-Path: <linux-kernel+bounces-530682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA9EA436C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F8317D8BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6303C25B69B;
	Tue, 25 Feb 2025 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EzyWEVRQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qGyz5QXD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EzyWEVRQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qGyz5QXD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55625B663
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470219; cv=none; b=schfhhuNF4/cDBrSLiXAn/aP7s5dI852D0Loui3Cx8F9l0v0c/VikK5jVs5gi6Lgpm0DOHpuhRcmSjS8evKslvLj1LI0gzKFpicmUOyt+2e9CH21TBlcmy3gmz6OAfPtgt4Zv90qfiHA1Ynb5Z7Nvi3fYD3cQbSGe/5NgQMIhg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470219; c=relaxed/simple;
	bh=bnZu2k770XGz1ImbTs7d6caUXSm3vDdiM4kXHsNJ6K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgaaphikV7wOPviy26TcphKO8VBMxYeUqaFdFI6HL6bAvH+5TUVH27k8Ig+M3HE0sYjVLKKFQXzrTNZK36hhyVVppJt5lwhjD0IqJGEJec2EXVLFFUt+rKwW1bCf9DGksDI77szxX3MsM3VLveTckfa+o+jRIy4wAd5NIIglE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EzyWEVRQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qGyz5QXD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EzyWEVRQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qGyz5QXD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44DE21F455;
	Tue, 25 Feb 2025 07:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740470215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bj+HqoBdeB+D17FV8Rc/yp4mFvMUt/gU4PJu7xO4HR4=;
	b=EzyWEVRQlRU69pMmLnE4VBFFHd8ckt4wvZLrqA69KIoCa4FHR2QdGYUTbYJN8pVrP/Kx4c
	vdy87DG7y0BaydJCQurVcM1nWiF0bNca902jlIk17fHCjLsCCFIDyPeZmJydyc0ITojDDL
	rqIQ1cNaJm21+a1ltOTt+XIvdQOKCEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740470215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bj+HqoBdeB+D17FV8Rc/yp4mFvMUt/gU4PJu7xO4HR4=;
	b=qGyz5QXDreHBoHEgiwzHD2BPkldJbPBrh3dNaG/JP4wlVlwR6DYlK55sfwiiQ83owDppAc
	U1KFFng6BurAEHDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740470215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bj+HqoBdeB+D17FV8Rc/yp4mFvMUt/gU4PJu7xO4HR4=;
	b=EzyWEVRQlRU69pMmLnE4VBFFHd8ckt4wvZLrqA69KIoCa4FHR2QdGYUTbYJN8pVrP/Kx4c
	vdy87DG7y0BaydJCQurVcM1nWiF0bNca902jlIk17fHCjLsCCFIDyPeZmJydyc0ITojDDL
	rqIQ1cNaJm21+a1ltOTt+XIvdQOKCEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740470215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bj+HqoBdeB+D17FV8Rc/yp4mFvMUt/gU4PJu7xO4HR4=;
	b=qGyz5QXDreHBoHEgiwzHD2BPkldJbPBrh3dNaG/JP4wlVlwR6DYlK55sfwiiQ83owDppAc
	U1KFFng6BurAEHDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F238813A61;
	Tue, 25 Feb 2025 07:56:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qOrWOcZ3vWc2dAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 25 Feb 2025 07:56:54 +0000
Message-ID: <ca34309a-f2b2-4082-92df-86a775952348@suse.de>
Date: Tue, 25 Feb 2025 08:56:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
To: Aditya Garg <gargaditya08@live.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Cc: Kerem Karabay <kekrby@gmail.com>, Atharva Tiwari <evepolonium@gmail.com>,
 Aun-Ali Zaidi <admin@kodeit.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <B08444CD-38A8-4B82-94B2-4162D6D2EABD@live.com>
 <844C1D39-4891-4DC2-8458-F46FA1B59FA0@live.com>
 <PN3PR01MB95974D5EB5A25386A8BF6FDAB8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
In-Reply-To: <PN3PR01MB95974D5EB5A25386A8BF6FDAB8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[live.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kodeit.net,vger.kernel.org,lists.freedesktop.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,live.com]
X-Spam-Flag: NO
X-Spam-Level: 

Hi

Am 24.02.25 um 17:58 schrieb Aditya Garg:
[...]
>>
>> +config DRM_APPLETBDRM
>> +    tristate "DRM support for Apple Touch Bars"
>> +    depends on DRM && USB && MMU
>> +    select DRM_GEM_SHMEM_HELPER
>> +    select DRM_KMS_HELPER
>> +    select HID_APPLETB_BL
> Btw I have a doubt regarding this dependency. While hid-appletb-bl has made into the linux-next tree, it has still not been merged into Linus' tree, and neither the drm tree I assume. It potentially could cause issues?

Yes. We cannot merge this driver until we have this symbol in our tree. 
But that will happen sooner or later.

More problematic is that your driver selects HID_APPLETB_BL. From what 
I've seen, this symbol is user configurable, so the driver shouldn't 
select it. You need to use 'depends on' instead of 'select' here.

Best regards
Thomas

>
>> +    select HID_MULTITOUCH
>> +    help
>> +      Say Y here if you want support for the display of Touch Bars on x86
>> +      MacBook Pros.
>> +
>> +      To compile this driver as a module, choose M here: the
>> +      module will be called appletbdrm.
>> +

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


