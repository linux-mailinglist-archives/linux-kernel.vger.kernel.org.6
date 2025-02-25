Return-Path: <linux-kernel+bounces-531294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 593D8A43E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707397AB690
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E252E267F69;
	Tue, 25 Feb 2025 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vXQI9//s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vsO1ypZr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vXQI9//s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vsO1ypZr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560E266B7B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484788; cv=none; b=HYG+h+BKWmzPsqh6zeK1ZAh/onUneGHFNJaQpt7dnVrr9TNTTK/NAvhGmv1+eWVBCTG6a33EPyOnroxQX7ZPWv7/y4NZ/s9tsFeGHRl7AsDfay7CMCQFDqf+q0Tm7ZqpZxUOhqd8sdAjj4z9uZr0AdrLplgREpm7WDCR4Ag7P+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484788; c=relaxed/simple;
	bh=u1jDhyZRtu5R60/MIm7LROeT/pOlxDezFsxy+RV/5Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=re3I/xkGIBeQcD6kru97dzco9biUO2SEV4oFHBJDt+kHU3wSgbvR6HB0jDX0v2u+SrYAx7FbOYVapA42INndBtVpCyrztANzjzHyE/W1h1UyLw7oUGNIp6Fl0aghLT9TIReKoHs2MqpiUEfX4wIipnZDLNhEbta+rEiZjsfOtxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vXQI9//s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vsO1ypZr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vXQI9//s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vsO1ypZr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9789F2116A;
	Tue, 25 Feb 2025 11:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740484784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ulZ455PIMbfE9cqopcfTAI64PTcJtYeUpNcHevWOWFQ=;
	b=vXQI9//sBOarQ+HrIaNRtjL0JIu4j15qZiJPWINujBs60uS7oeuBsnmIpjvUT5ObyXM9W/
	dKnV95o7evQX+H9OeZ+eIBjK+Pz/FedUgHZcBJsiGyejQqe759la3lE5GHOsPWOi4arvbC
	BtbUxMAyVWURhsRFrqaBEEkX/dptalE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740484784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ulZ455PIMbfE9cqopcfTAI64PTcJtYeUpNcHevWOWFQ=;
	b=vsO1ypZrXXy3l3LQqZfqLXdrVkcDMWnx/bs7N9v93tAYNIqfcZ2s8R0eXu0LADm0iokJ78
	/dq7FZ5OrwxuoGCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="vXQI9//s";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vsO1ypZr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740484784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ulZ455PIMbfE9cqopcfTAI64PTcJtYeUpNcHevWOWFQ=;
	b=vXQI9//sBOarQ+HrIaNRtjL0JIu4j15qZiJPWINujBs60uS7oeuBsnmIpjvUT5ObyXM9W/
	dKnV95o7evQX+H9OeZ+eIBjK+Pz/FedUgHZcBJsiGyejQqe759la3lE5GHOsPWOi4arvbC
	BtbUxMAyVWURhsRFrqaBEEkX/dptalE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740484784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ulZ455PIMbfE9cqopcfTAI64PTcJtYeUpNcHevWOWFQ=;
	b=vsO1ypZrXXy3l3LQqZfqLXdrVkcDMWnx/bs7N9v93tAYNIqfcZ2s8R0eXu0LADm0iokJ78
	/dq7FZ5OrwxuoGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BF7D13888;
	Tue, 25 Feb 2025 11:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id imxkEbCwvWfYRgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 25 Feb 2025 11:59:44 +0000
Message-ID: <9efdb233-2bca-4a5d-a6bc-de81fa96efb3@suse.de>
Date: Tue, 25 Feb 2025 12:59:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 Aditya Garg <gargaditya08@live.com>
Cc: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, Kerem Karabay <kekrby@gmail.com>,
 Atharva Tiwari <evepolonium@gmail.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <3457BF95-0E50-4B70-86DE-EE5EE95D3ACE@live.com>
 <4D7C00B4-7B75-4715-8D37-0059B22C030D@live.com>
 <Z72chunE_vvxtjLQ@smile.fi.intel.com>
 <PN3PR01MB9597BF95EC490951D75748F1B8C32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z72foRL3diil9icd@smile.fi.intel.com>
 <PN3PR01MB9597B5ECF47B04E3201DD56BB8C32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z72jHeCG6-ByMyhh@smile.fi.intel.com>
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
In-Reply-To: <Z72jHeCG6-ByMyhh@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9789F2116A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[linux.intel.com,live.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,live.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,kodeit.net,vger.kernel.org,lists.freedesktop.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi

Am 25.02.25 um 12:01 schrieb andriy.shevchenko@linux.intel.com:
> On Tue, Feb 25, 2025 at 10:48:53AM +0000, Aditya Garg wrote:
>>> On 25 Feb 2025, at 4:17 PM, andriy.shevchenko@linux.intel.com wrote:
>>> On Tue, Feb 25, 2025 at 10:36:03AM +0000, Aditya Garg wrote:
>>>>>> On 25 Feb 2025, at 4:03 PM, andriy.shevchenko@linux.intel.com wrote:
>>>>> On Tue, Feb 25, 2025 at 10:09:42AM +0000, Aditya Garg wrote:
> ...
>
>>>>>> +static int appletbdrm_probe(struct usb_interface *intf,
>>>>>> +                const struct usb_device_id *id)
>>>>>> +{
>>>>>> +    struct usb_endpoint_descriptor *bulk_in, *bulk_out;
>>>>>> +    struct device *dev = &intf->dev;
>>>>>> +    struct appletbdrm_device *adev;
>>>>>> +    struct drm_device *drm;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    ret = usb_find_common_endpoints(intf->cur_altsetting, &bulk_in, &bulk_out, NULL, NULL);
>>>>>> +    if (ret) {
>>>>>> +        drm_err(drm, "Failed to find bulk endpoints\n");
>>>>> This is simply wrong (and in this case even lead to crash in some circumstances).
>>>>> drm_err() may not be used here. That's my point in previous discussions.
>>>>> Independently on the subsystem the ->probe() for the sake of consistency and
>>>>> being informative should only rely on struct device *dev,
>>>> I'm not sure how drm_err works,
>>> It's a macro.
>>>
>>>> but struct drm_device does have a struct device *dev as well.
>>> Yes, but only when it's initialized.
>>>
>>>> Anyways, this is something I'll leave for Thomas to reply.
>>> The code above is wrong independently on his reply :-)
>> I'm kinda stuck between contrasting views of 2 kernel maintainers lol,
>> so I said let Thomas reply.
> Sure. I also want him to clarify my question about potential drm_err_probe().

These threads get a little lengthy. What is the question?

Best regards
Thomas

>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


