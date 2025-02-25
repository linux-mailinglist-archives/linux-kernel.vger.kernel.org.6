Return-Path: <linux-kernel+bounces-531290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8D3A43E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7DA77A8C39
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E811C267B98;
	Tue, 25 Feb 2025 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hD8M3+2P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="54M5y1Ui";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hD8M3+2P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="54M5y1Ui"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3CD1C861B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484702; cv=none; b=qtlau00Dhyv5Ge9zB1q80iC90QWaYWBiuvFp3mh61e1slXt4OCKicq14GetkS2BQWEoUT+63YJsIvUvYrtVd0wDXTQeJBESRT3Ku5mJBPDBHqo6pnE39AgiI0ef2DQOtWiZ8Q6yLttmSLs/Gp1IdcONvkAeRJ9/4FUCEHJ66mKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484702; c=relaxed/simple;
	bh=r6875Ufr1YtSuAWpxko7YCgQbRxxoTMsoP5oOSmbW88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOcdp/1q4yKaPEtsytGlyqB6HKJCJPlTGCQ3UJfrSMOgJdxgcru+LT5EOcNXePorBgHL95CVpUkEJh5kdgL4zlER6f9SCOTBcWkqIwshG2r3JWbq2ToCeSUK1lT3UF3QFws7uE/naUkIduSooz7Q7bDCmMPlmOKihXclcqid6I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hD8M3+2P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=54M5y1Ui; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hD8M3+2P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=54M5y1Ui; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26F352116A;
	Tue, 25 Feb 2025 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740484698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jh8MVDz39OwecAZp/7HIGitwnLQCkwTN0crf5zZ3TP4=;
	b=hD8M3+2PHeRZOb7tYnptgG9PRQJsGwKau1ceVYMDIAI+qWug2fcgwq0osKfcSwJhXzo9Y2
	WDBU82ZvZlDQ3fKmnV9xnXgdo+1nqNIhzChgRaSuzbDGQpN/RpQENzDz0sG0kGJF/Rcrqx
	zF+TBMt7TXGQbOefNR86Cth7oAhnB1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740484698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jh8MVDz39OwecAZp/7HIGitwnLQCkwTN0crf5zZ3TP4=;
	b=54M5y1UiYvdlSGzgCZiGgC/9uEQQYL4qDPH3lY+5kBu/4wvtV7bND/Dhne1wjqiZpq1i4H
	vaWuLHhVXMVTdNBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740484698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jh8MVDz39OwecAZp/7HIGitwnLQCkwTN0crf5zZ3TP4=;
	b=hD8M3+2PHeRZOb7tYnptgG9PRQJsGwKau1ceVYMDIAI+qWug2fcgwq0osKfcSwJhXzo9Y2
	WDBU82ZvZlDQ3fKmnV9xnXgdo+1nqNIhzChgRaSuzbDGQpN/RpQENzDz0sG0kGJF/Rcrqx
	zF+TBMt7TXGQbOefNR86Cth7oAhnB1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740484698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jh8MVDz39OwecAZp/7HIGitwnLQCkwTN0crf5zZ3TP4=;
	b=54M5y1UiYvdlSGzgCZiGgC/9uEQQYL4qDPH3lY+5kBu/4wvtV7bND/Dhne1wjqiZpq1i4H
	vaWuLHhVXMVTdNBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDBA513888;
	Tue, 25 Feb 2025 11:58:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RUULMVmwvWdYRgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 25 Feb 2025 11:58:17 +0000
Message-ID: <c0249cd8-68e4-4860-b5c3-e054df10ae30@suse.de>
Date: Tue, 25 Feb 2025 12:58:17 +0100
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
In-Reply-To: <Z72chunE_vvxtjLQ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,live.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.intel.com,live.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,kodeit.net,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

Hi

Am 25.02.25 um 11:33 schrieb andriy.shevchenko@linux.intel.com:
> On Tue, Feb 25, 2025 at 10:09:42AM +0000, Aditya Garg wrote:
>> From: Kerem Karabay <kekrby@gmail.com>
>>
>> The Touch Bars found on x86 Macs support two USB configurations: one
>> where the device presents itself as a HID keyboard and can display
>> predefined sets of keys, and one where the operating system has full
>> control over what is displayed.
>>
>> This commit adds support for the display functionality of the second
>> configuration. Functionality for the first configuration has been
>> merged in the HID tree.
>>
>> Note that this driver has only been tested on T2 Macs, and only includes
>> the USB device ID for these devices. Testing on T1 Macs would be
>> appreciated.
>>
>> Credit goes to Ben (Bingxing) Wang on GitHub for reverse engineering
>> most of the protocol.
>>
>> Also, as requested by Andy, I would like to clarify the use of __packed
>> structs in this driver:
>>
>> - All the packed structs are aligned except for appletbdrm_msg_information.
>> - We have to pack appletbdrm_msg_information since it is requirement of
>>    the protocol.
>> - We compared binaries compiled by keeping the rest structs __packed and
>>    not __packed using bloat-o-meter, and __packed was not affecting code
>>    generation.
>> - To maintain consistency, rest structs have been kept __packed.
>>
>> I would also like to point out that since the driver was reverse-engineered
>> the actual data types of the protocol might be different, including, but
>> not limited to, endianness.
> ...
>
>> +static int appletbdrm_probe(struct usb_interface *intf,
>> +			    const struct usb_device_id *id)
>> +{
>> +	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
>> +	struct device *dev = &intf->dev;
>> +	struct appletbdrm_device *adev;
>> +	struct drm_device *drm;
>> +	int ret;
>> +
>> +	ret = usb_find_common_endpoints(intf->cur_altsetting, &bulk_in, &bulk_out, NULL, NULL);
>> +	if (ret) {
>> +		drm_err(drm, "Failed to find bulk endpoints\n");
> This is simply wrong (and in this case even lead to crash in some circumstances).
> drm_err() may not be used here. That's my point in previous discussions.
> Independently on the subsystem the ->probe() for the sake of consistency and
> being informative should only rely on struct device *dev,

That's never going to work with DRM. There's so much code in a DRM probe 
function that uses the DRM error functions.

This specific instance here is wrong, as the drm pointer hasn't been 
initialized. But as soon as it is, it's much better to use drm_err() and 
friends. It will do the right thing and give consistent output across 
drivers.

Best regards
Thomas

>
>> +		return ret;
>> +	}
>> +
>> +	adev = devm_drm_dev_alloc(dev, &appletbdrm_drm_driver, struct appletbdrm_device, drm);
>> +	if (IS_ERR(adev))
>> +		return PTR_ERR(adev);
>> +
>> +	adev->in_ep = bulk_in->bEndpointAddress;
>> +	adev->out_ep = bulk_out->bEndpointAddress;
>> +	adev->dmadev = dev;
>> +
>> +	drm = &adev->drm;
>> +
>> +	usb_set_intfdata(intf, adev);
>> +
>> +	ret = appletbdrm_get_information(adev);
>> +	if (ret) {
>> +		drm_err(drm, "Failed to get display information\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = appletbdrm_signal_readiness(adev);
>> +	if (ret) {
>> +		drm_err(drm, "Failed to signal readiness\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = appletbdrm_setup_mode_config(adev);
>> +	if (ret) {
>> +		drm_err(drm, "Failed to setup mode config\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = drm_dev_register(drm, 0);
>> +	if (ret) {
>> +		drm_err(drm, "Failed to register DRM device\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = appletbdrm_clear_display(adev);
>> +	if (ret) {
>> +		drm_err(drm, "Failed to clear display\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


