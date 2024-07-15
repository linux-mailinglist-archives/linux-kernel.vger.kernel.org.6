Return-Path: <linux-kernel+bounces-252090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C759C930E37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467751F2167C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF031836D4;
	Mon, 15 Jul 2024 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UA1FbGo+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YvXCLaYB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UA1FbGo+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YvXCLaYB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777013BC3D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721025894; cv=none; b=lm1E/L1m5Ttbat0T/AcVpopDo9Is6oJ0/7KlpKFtgWSJ32bXFUvEkpNx3KR7BK4KfvqHufOVw3/bGhrZoT6aPJV58eZmQdy8Wpkz+/gda/yQcbK88/whtzGNxScKqa9jToow4pchXWoB+Fok4ku4qGcdgIco04xZ7lfLzfFlDU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721025894; c=relaxed/simple;
	bh=i0AYzfiaIPrcbcTelMzlVhPu2RCu/AtHiYchbK56MYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyzv99VTcRheNd8qhs69jGaxTr38647WvvY4KqoHg25UZEa5OGaNXeL5FqdXPJ5D7t48jYL+HopX4J+72j3b3I83IQR5iA06O632Q7vqllhvf2RPJ8Q9BxY6cHGuBnURj2zFmJePc3DaRbACSDMcLp0p8IWR/rj5hVSA+fTNioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UA1FbGo+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YvXCLaYB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UA1FbGo+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YvXCLaYB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4015421B17;
	Mon, 15 Jul 2024 06:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721025891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=olWryrWLUTw/NaU1LCVxjCF3Nl9ZRhEuoQ6ZHzfEPMA=;
	b=UA1FbGo+QN1hWTWLXuOCYg7pkiqKscO8OE7T8V/2jx+psVi9spy9TAdlvvRhMGyi1oPB8J
	zsDlyVeNm2zsi+1ddzH4c9h0eZyoswMR1fp847Y+eFGoDm+JR+4H8LE3MgSN1SEB4avWL8
	yTmDY8d+uAivV0Zsjg6BLsaxuTEbLQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721025891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=olWryrWLUTw/NaU1LCVxjCF3Nl9ZRhEuoQ6ZHzfEPMA=;
	b=YvXCLaYBWdiFkxrjEopqvv+snwZ65lpXLRIw/0CN7XVnok8LF1lkEDqghKRbvXf3t1pb6F
	hFq/sfPioMXCBrDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721025891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=olWryrWLUTw/NaU1LCVxjCF3Nl9ZRhEuoQ6ZHzfEPMA=;
	b=UA1FbGo+QN1hWTWLXuOCYg7pkiqKscO8OE7T8V/2jx+psVi9spy9TAdlvvRhMGyi1oPB8J
	zsDlyVeNm2zsi+1ddzH4c9h0eZyoswMR1fp847Y+eFGoDm+JR+4H8LE3MgSN1SEB4avWL8
	yTmDY8d+uAivV0Zsjg6BLsaxuTEbLQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721025891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=olWryrWLUTw/NaU1LCVxjCF3Nl9ZRhEuoQ6ZHzfEPMA=;
	b=YvXCLaYBWdiFkxrjEopqvv+snwZ65lpXLRIw/0CN7XVnok8LF1lkEDqghKRbvXf3t1pb6F
	hFq/sfPioMXCBrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A6ED134AB;
	Mon, 15 Jul 2024 06:44:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q6K0BGPFlGaMWgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 15 Jul 2024 06:44:51 +0000
Message-ID: <1eb659d8-536e-401b-a427-19709a98953a@suse.de>
Date: Mon, 15 Jul 2024 08:44:50 +0200
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 

Hi

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

Amazing debugging skills!

The patch that causes the regression in X sets the PCI device as parent 
for the VESA framebuffer. That means that the PCI device won't be 
unplugged or suspended while the VESA framebuffer is still in use. 
Without, results are undefined.

Therefore, could this be fixed in X' fbdev driver?

It currently tests against the sysfs path of the fbdev device. A fix 
could look like this:

  1) readlink /sys/class/graphics/fb0/device/subsystem 2) strcmp to 
"bus/pci" fb0 is the fbdev device fb0/device/ is the Linux device (the 
VESA/EFI framebuffer or native PCI graphics device) fb0/device/subsystem 
is the Linux devices' subsystem.

The subsystem string is the path to the underlying bus. For PCI graphics 
cards it's something like

../../../bus/pci

and for VESA/EFI framebuffer devices it's

../../../bus/platform

That's more correct, reliable and also keeps the correct organization of 
the devices within the kernel.

Best regards
Thomas


-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


