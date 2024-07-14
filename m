Return-Path: <linux-kernel+bounces-251906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2491930B64
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 21:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB12B21476
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 19:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC76F13C810;
	Sun, 14 Jul 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FRtQs3CZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MoLc2458";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FRtQs3CZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MoLc2458"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2689BFC11
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720986395; cv=none; b=j5X7TdysTQXfkB9+4tTFaMxHOGEnjse41tJ1G/9rI6YSVWwRLmNObuSZuJbiTOBHAPdptnrkXTGUBgIAnb0YbFqIUtuKZAJNsD73MwPUAQ7dcW5W63o3f19bGBX69pAfsE/ytMLondr6gbEy3r9XVW1GyzflsWKRK1W3DuRPtlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720986395; c=relaxed/simple;
	bh=IgaWGcqMOb9hEeIZtVJyGa7b7L5Uh7ySnsWjHrGMFlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXC991M7YI+uppvjvhOAOPY/YueYrT/Ir5fpnA41kvja0XCpC5RXLn6V4PP0zY0DDEtY8z08HBUD2lu/QcPqgFpHro1B5hU0HchGCzEh9JiCVwGtn57e9BjQHAuW1+ngX2EnpdyNivUDGx81o54PY67r8bA/zewGaHz8hr3e+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FRtQs3CZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MoLc2458; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FRtQs3CZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MoLc2458; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 259AF1F7E1;
	Sun, 14 Jul 2024 19:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720986391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SpTPrcvzLw21CaUEXnRoKLN1V/iiKhIJH6ZOvC0Kgeo=;
	b=FRtQs3CZsi1ZkiQzCT2ICQTvyuc02MawAVyceD2gLYk4CScYnihGcr6r0rhL91JahcIQuM
	CWvPpM/M9O9qEL9F/lwWz3S5Vf0oxWQ0IZyr+ZIFwhDZS2HkzMENNOdxIulVDwCJYOVvzv
	wwbZCDa9YHgmhmuJrbZ6OQoBQn7GT+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720986391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SpTPrcvzLw21CaUEXnRoKLN1V/iiKhIJH6ZOvC0Kgeo=;
	b=MoLc245889+OUyXKSXgNw4YIsHrTooBjBR52X0NJnOsb02tRtRde2l+yraI0AJ8chn5rCo
	FHFKmWNP2MluF0BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FRtQs3CZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MoLc2458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720986391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SpTPrcvzLw21CaUEXnRoKLN1V/iiKhIJH6ZOvC0Kgeo=;
	b=FRtQs3CZsi1ZkiQzCT2ICQTvyuc02MawAVyceD2gLYk4CScYnihGcr6r0rhL91JahcIQuM
	CWvPpM/M9O9qEL9F/lwWz3S5Vf0oxWQ0IZyr+ZIFwhDZS2HkzMENNOdxIulVDwCJYOVvzv
	wwbZCDa9YHgmhmuJrbZ6OQoBQn7GT+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720986391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SpTPrcvzLw21CaUEXnRoKLN1V/iiKhIJH6ZOvC0Kgeo=;
	b=MoLc245889+OUyXKSXgNw4YIsHrTooBjBR52X0NJnOsb02tRtRde2l+yraI0AJ8chn5rCo
	FHFKmWNP2MluF0BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 031BD137AC;
	Sun, 14 Jul 2024 19:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A0uZOhYrlGYoQQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Sun, 14 Jul 2024 19:46:30 +0000
Message-ID: <7ca66c39-cbeb-42c6-bfb4-f381b77cf920@suse.de>
Date: Sun, 14 Jul 2024 21:46:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: firmware/sysfb.c device path
To: Tj <tj.iam.tj@proton.me>, Marek Olsak <Marek.Olsak@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "1075713@bugs.debian.org" <1075713@bugs.debian.org>
References: <lLyvPFC_APGHNfyGNHRpQy5izBikkaTPOpHooZIT3fFAoJPquSI31ZMueA99XTdr8ysir3X7O7IMdc6za-0m79vr_claeparHhoRouVgHOI=@proton.me>
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
In-Reply-To: <lLyvPFC_APGHNfyGNHRpQy5izBikkaTPOpHooZIT3fFAoJPquSI31ZMueA99XTdr8ysir3X7O7IMdc6za-0m79vr_claeparHhoRouVgHOI=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 259AF1F7E1

Marek, could this also be the cause of your reported bug?

Am 13.07.24 um 19:20 schrieb Tj:
> The recent commits to add the parent device path broke Debian's kvm based QA workers for testing installer ISOs after a kernel upgrade from v6.8.12 to v6.9.7. For the details:
>
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1075713
>
> It took some time to  track it down since the superficial symptom appeared to involve the QXL driver. It turned out however to be the fbdev driver; specifically the change in the parent device path in sysfs reported between the two kernels:
>
> 6.8.12:
>
> /sys/class/graphics/fb0 -> ../../devices/platform/vesa-framebuffer.0/graphics/fb0
>
> 6.9.7:
>
> /sys/class/graphics/fb0 -> ../../devices/pci0000:00/0000:00:01.0/vesa-framebuffer.0/graphics/fb0
>
> This breaks xserver-xorg-core's libfbdevhw.so because it differentiates code-paths based on whether "devices/pci" is matched in the symlink.
>
> See hw/xfree86/fbdevhw/fbdevhw.c::fbdev_open()
>
> https://gitlab.freedesktop.org/xorg/xserver/-/blob/master/hw/xfree86/fbdevhw/fbdevhw.c?ref_type=heads#L381

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


