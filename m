Return-Path: <linux-kernel+bounces-326564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 792F8976A14
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E1C1F23B22
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B405D1AB52D;
	Thu, 12 Sep 2024 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OTrCnIy8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MwbdIc9x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OTrCnIy8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MwbdIc9x"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22204210FB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146646; cv=none; b=D9y+qb1LOjraE00QPR4xpbpljyiX1jUAZAqF5iNuSgz88ptyfiAY2o55ISdt2LkHpFRQjiCrPUZgRAosCkb+ji/azFdDRgZyPA43oYBTgN7IeyE2wtGXL0CdFMc2QbT1TtQQn2X8v2SK4TSUTQ4/SWWpLrMcpa03Sjb3HuBFH5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146646; c=relaxed/simple;
	bh=2s3P/qawkbtDcoSdN1nRWQSbybplrUYP6j6eCw9HM7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQSN8c/HZJVYqqDNufQNNWzfWYtN59SoeWALfv/s6h7R5jsJwX809rOvKEVrTNTZhTO4NC97pVRIcyXm4yBK9zL4OUu2yVyfyudUextY12At4Tvw+xvvHpIPhJCHsL3YZ599E6CSLF+VGcgLzOEiFP3oa/aoacNNrQZ8okSkINY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OTrCnIy8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MwbdIc9x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OTrCnIy8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MwbdIc9x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5048921AEF;
	Thu, 12 Sep 2024 13:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726146642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7t6MzumqzqCdwegoUnGthXs+e27vzUpQ278onbeKBNo=;
	b=OTrCnIy8GLpVPoUUd8dcXy2vejRcpZKAT7TIWt8ElF7DfXimbB+1DxvtmMbYDug+OxtA14
	C3KuO9RTRbqkVZ9baR9U+YDC/VSH9CFJyS+0hOBzsuFKLp9pWLGqeWHUEr+5SpvTyhIIB1
	jIDtAnBEYlaDmguGh5GvoFmM14M33gc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726146642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7t6MzumqzqCdwegoUnGthXs+e27vzUpQ278onbeKBNo=;
	b=MwbdIc9xOInhvJkTnCp84ocWE3WqgQ5/2MepFFgi6eM//A+fBojKmmqVXfCtdyjgUrx23Z
	HpfuSm1ToYFIKFCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726146642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7t6MzumqzqCdwegoUnGthXs+e27vzUpQ278onbeKBNo=;
	b=OTrCnIy8GLpVPoUUd8dcXy2vejRcpZKAT7TIWt8ElF7DfXimbB+1DxvtmMbYDug+OxtA14
	C3KuO9RTRbqkVZ9baR9U+YDC/VSH9CFJyS+0hOBzsuFKLp9pWLGqeWHUEr+5SpvTyhIIB1
	jIDtAnBEYlaDmguGh5GvoFmM14M33gc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726146642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7t6MzumqzqCdwegoUnGthXs+e27vzUpQ278onbeKBNo=;
	b=MwbdIc9xOInhvJkTnCp84ocWE3WqgQ5/2MepFFgi6eM//A+fBojKmmqVXfCtdyjgUrx23Z
	HpfuSm1ToYFIKFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02D2413AD8;
	Thu, 12 Sep 2024 13:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aB98OlHo4mYOagAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 12 Sep 2024 13:10:41 +0000
Message-ID: <1d16c1ae-2e27-4daa-b8a6-5eab179ef551@suse.de>
Date: Thu, 12 Sep 2024 15:10:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/gma500: replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Tejas Vipin <tejasvipin76@gmail.com>, Laurent.pinchart@ideasonboard.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240911180650.820598-1-tejasvipin76@gmail.com>
 <b0f77fcc-5d84-4727-9a17-9d1f1e2c5b76@suse.de> <87o74ti7g5.fsf@intel.com>
 <87ldzxi71s.fsf@intel.com> <988bb389-13e6-4465-ab37-3ed94ecee9be@suse.de>
 <87y13xgqj3.fsf@intel.com> <57016d01-4525-4685-b029-41e03b0abbda@suse.de>
 <87bk0tgll7.fsf@intel.com>
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
In-Reply-To: <87bk0tgll7.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_TO(0.00)[linux.intel.com,gmail.com,ideasonboard.com,kernel.org,ffwll.ch];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi

Am 12.09.24 um 13:25 schrieb Jani Nikula:
> On Thu, 12 Sep 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Hi
>>
>> Am 12.09.24 um 11:38 schrieb Jani Nikula:
>>> On Thu, 12 Sep 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>> Am 12.09.24 um 10:56 schrieb Jani Nikula:
>>>>> Moreover, in this case .detect() only detects digital displays as
>>>>> reported by EDID. If you postpone that to .get_modes(), the probe helper
>>>>> will still report connected, and invent non-EDID fallback modes. The
>>>>> behaviour changes.
>>>> The change in behavior is intentional, because the current test seems
>>>> arbitrary. Does the driver not work with analog outputs?
>>> Not on a DVI/HDMI port. Same with i915.
>>>
>>> That's possibly the only way to distinguish a DVI-A display connected to
>>> DVI-D source.
>> That's a detect failure, but IMHO our probe helpers should really handle
>> this case.
> How? Allow returning detect failures from .get_modes()?

Something like that, I guess.

For the specific problem it would be enough to read the first 20 bytes 
of EDID data on DVI connectors and test the digital-input flag bit 
against the exact connector requirements. drm_probe_ddc() could do this. 
Non-DVI connectors would continue to read a single bytes to detect the DDC.

For more sophisticated problems, it would be good to introduce an 
intermediate callback that updates the connector state. So the probe 
logic would look like:

  1) call ->detect to read physical connector status
  2) return if physical status did not change
  3) increment epoch counter
  4) call ->update to update connector state and properties (EDID, etc) 
get new connector status
  5) call ->get_modes if connected

The initial ->detect would be minimal. The ->update, if implemented, 
could do more processing and error checking. It's result would be the 
connector's new status.

On a side note, I've recently spend quite a few patches on getting the 
BMC output for ast and mgag200 usable. Something like the above logic 
would have helped, I think. Because with the current probe logic, I had 
to implement steps 1 to 4 in ->detect itself. The result has to maintain 
physical status and epoch counter by itself. [1]

Best regards
Thomas

[1] 
https://gitlab.freedesktop.org/drm/kernel/-/commit/2a2391f857cdc5cf16f8df030944cef8d3d2bc30

>
> BR,
> Jani.
>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


