Return-Path: <linux-kernel+bounces-293489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B0695806D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7951C23B51
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79D817C988;
	Tue, 20 Aug 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZqjnSu41";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f35Oyutw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xAR6OfnL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W4V0bJK+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E9176AAE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724140985; cv=none; b=u7118sG6+QQImBaUWHdnQ7ZSZxNKRo7+GXF+z/ze12sCcoBw+0FJ77jQzk4FDWnpKlQpBAZN+luZNbXi1DD+8i18I1N4e3eh2H1iTbbuXzxXSZ+BO+wOEYFr5YBek1jddoObEUPMgYkIA6dt1krTUNj+RoPe4Cjd5R6MXsk3w8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724140985; c=relaxed/simple;
	bh=zB4HF3OGWTqBAr3bJ2ya6jk3KgkOVaImNSAQzPiwUG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AdC5GB5U5XQ6xUGjFH4XOpuR0oUEuNYGz2MK/dFvuyAD2MANO0F4JnwKUZ+JnVtVPmDqbafEfj/vYy+me//ThnTeoVWzLJxInke8j1iMq5p7R/THYoU0Arjo3avf0LI4XteeALKNfCbMJOEpey2dvj2Ky3GHtaDfDK0Zm/IgTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZqjnSu41; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f35Oyutw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xAR6OfnL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W4V0bJK+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5D4E1FFAE;
	Tue, 20 Aug 2024 08:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724140974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZygwqY9NXPgv+FaZPq5Rt9kFbR4wNFuosDtneBQ7h/I=;
	b=ZqjnSu4185JCjhMAs+r7D/5ileuZepjGZJgowlKsTNBhFxH0Q0BvCkZtE37A0XeHs+rJSB
	PGVLg1emxScy8YRK3kTu3dQh05IVEDh4jQMYeYN8lUjpHPLaJeCeyuYdeQ1rRr5FGOQS5v
	7fgXrct2Xn9P3kA6ExreuqdC1jxou88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724140974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZygwqY9NXPgv+FaZPq5Rt9kFbR4wNFuosDtneBQ7h/I=;
	b=f35OyutwlrFh8sjRUyX4Gn3zK/CdcWfsFFIjXdNlG1/5vy6o7rs59VS2Og+1cInrPUVZ+M
	6CNhbiq/sWgHT/CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xAR6OfnL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=W4V0bJK+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724140973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZygwqY9NXPgv+FaZPq5Rt9kFbR4wNFuosDtneBQ7h/I=;
	b=xAR6OfnLzJApaPHc2K3312w8ffWaMXdCSm0ZeHQt3WLDXf55NY8awdbxVSpsdzXGDih/Ar
	vKRr9Agg1WLyK+mMGe9fJ38vdsqrz+vdqCGJ0WSNl9mUEzm6ByjkWsHrNqsf8mblYDeZkd
	Xaz7FXyk3lVHOVm/4Y08XDpNnEpsQkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724140973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZygwqY9NXPgv+FaZPq5Rt9kFbR4wNFuosDtneBQ7h/I=;
	b=W4V0bJK+lxHqH+tiEZQ1/VeDXymDE5TRk67aYu4roLs9TT8JHWTjxnNhlHx7eqjXKorDfp
	rGZZdRoDNFwwDACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EC7113A17;
	Tue, 20 Aug 2024 08:02:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dkuwI61NxGawJQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 20 Aug 2024 08:02:53 +0000
Message-ID: <81f2d0d9-386a-4535-af1a-e9fff18ead8e@suse.de>
Date: Tue, 20 Aug 2024 10:02:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression: 9eac534db001 ("firmware/sysfb: Set
 firmware-framebuffer parent device") broke nomodeset boot?
To: Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>
References: <af56820e03d9a52a472ec914a17310d11f8d0227.camel@gmx.de>
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
In-Reply-To: <af56820e03d9a52a472ec914a17310d11f8d0227.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C5D4E1FFAE
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmx.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

Hi

Am 20.08.24 um 03:31 schrieb Mike Galbraith:
> Greetings,
>
> I normally use nouveau so I can suspend, but it's horrid for RT, so
> when doing RT latency tracing, I boot with nomodeset.  Yesterday I
> decided to check out master-rt cyclictest numbers, but found that X
> will no longer start, tracked it back to a v6.9 issue, then bisected
> v6.8..v6.9, which fingered $subject.
>
> I haven't yet tried reverting the series the fingered commit is part
> of, but did try turning on CONFIG_SYSFB_SIMPLEFB/CONFIG_FB_SIMPLE, and
> even the once upon a time used CONFIG_FB_NVIDIA for grins, but alas,
> config twiddling did not revive fbdev X.

Please see
   https://lists.x.org/archives/xorg-devel/2024-July/059269.html

or
https://gitlab.freedesktop.org/xorg/xserver/-/merge_requests/1612/diffs?commit_id=a745f59bb193c7a87959fddade9b637278e5528e

for the fix. We need to make Xorg's fbdev backend look at the correct 
values and everything works.

Best regards
Thomas

>
> nomodeset/fbdev X nogo==>go startup log diff:
> --- yy	2024-08-20 02:40:05.003271212 +0200
> +++ xx	2024-08-20 02:39:06.532061201 +0200
> @@ -1,9 +1,9 @@
> - (--) Log file renamed from "/var/log/Xorg.pid-2439.log" to "/var/log/Xorg.0.log"
> + (--) Log file renamed from "/var/log/Xorg.pid-2298.log" to "/var/log/Xorg.0.log"
>
>   X.Org X Server 1.21.1.4
>   X Protocol Version 11, Revision 0
> - Current Operating System: Linux homer 6.9.12-stable #6 SMP Mon Aug 19 09:53:59 CEST 2024 x86_64
> - Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.9.12-stable root=UUID=891c2a1f-cc1a-464b-a529-ab6add65aa21 scsi_mod.use_blk_mq=1 ftrace_dump_on_oops skew_tick=1 nortsched nodelayacct nowatchdog audit=0 mitigations=off noresume panic=60 ignore_loglevel showopts crashkernel=204M nomodeset
> + Current Operating System: Linux homer 6.8.12-stable #7 SMP Mon Aug 19 11:12:36 CEST 2024 x86_64
> + Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.8.12-stable root=UUID=891c2a1f-cc1a-464b-a529-ab6add65aa21 scsi_mod.use_blk_mq=1 ftrace_dump_on_oops skew_tick=1 nortsched nodelayacct nowatchdog audit=0 mitigations=off noresume panic=60 ignore_loglevel showopts crashkernel=204M nomodeset
>
>    Current version of pixman: 0.40.0
>    	Before reporting problems, check http://wiki.x.org
> @@ -11,7 +11,7 @@ X Protocol Version 11, Revision 0
>    Markers: (--) probed, (**) from config file, (==) default setting,
>   	(++) from command line, (!!) notice, (II) informational,
>   	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
> - (==) Log file: "/var/log/Xorg.0.log", Time: Tue Aug 20 02:33:32 2024
> + (==) Log file: "/var/log/Xorg.0.log", Time: Tue Aug 20 02:30:29 2024
>    (==) Using config directory: "/etc/X11/xorg.conf.d"
>    (==) Using system config directory "/usr/share/X11/xorg.conf.d"
>    (==) No Layout section.  Using the first Screen section.
> @@ -40,7 +40,7 @@ X Protocol Version 11, Revision 0
>    (WW) Ignoring unrecognized extension "XFree86-DGA"
>    (II) The server relies on udev to provide the list of input devices.
>   	If no devices become available, reconfigure udev or disable AutoAddDevices.
> - (II) Loader magic: 0x556d72b5ede0
> + (II) Loader magic: 0x56547fcffde0
>    (II) Module ABI versions:
>    	X.Org ANSI C Emulation: 0.4
>    	X.Org Video Driver: 25.2
> @@ -111,20 +111,282 @@ X Protocol Version 11, Revision 0
>    (II) Module fbdevhw: vendor="X.Org Foundation"
>    	compiled for 1.21.1.4, module version = 0.0.2
>    	ABI class: X.Org Video Driver, version 25.2
> - vesa: Refusing to run, Framebuffer or dri device present
> + (II) FBDEV(2): using default device
>    (EE) Screen 0 deleted because of no matching config section.
>    (II) UnloadModule: "modesetting"
>    (EE) Screen 0 deleted because of no matching config section.
>    (II) UnloadModule: "fbdev"
>    (II) UnloadSubModule: "fbdevhw"
> - (EE) Device(s) detected, but none match those in the config file.
> - (EE)
> -Fatal server error:
> - (EE) no screens found(EE)
> - (EE)
> -Please consult the The X.Org Foundation support
> -	 at http://wiki.x.org
> - for help.
> - (EE) Please also check the log file at "/var/log/Xorg.0.log" for additional information.
> - (EE)
> - (EE) Server terminated with error (1). Closing log file.
> + (II) FBDEV(0): Creating default Display subsection in Screen section
> +	"Default Screen Section" for depth/fbbpp 24/32
> + (==) FBDEV(0): Depth 24, (==) framebuffer bpp 32
> + (==) FBDEV(0): RGB weight 888
> + (==) FBDEV(0): Default visual is TrueColor
> + (==) FBDEV(0): Using gamma correction (1.0, 1.0, 1.0)
> + (II) FBDEV(0): hardware: EFI VGA (video memory: 8640kB)
> + (DB) xf86MergeOutputClassOptions unsupported bus type 0
> + (II) FBDEV(0): checking modes against framebuffer device...
> + (II) FBDEV(0): checking modes against monitor...
> + (II) FBDEV(0): Virtual size is 1920x1080 (pitch 1920)
> + (**) FBDEV(0):  Built-in mode "current": 207.4 MHz, 85.3 kHz, 77.2 Hz
> + (II) FBDEV(0): Modeline "current"x0.0  207.38  1920 1952 2192 2432  1080 1084 1088 1104 -hsync -vsync -csync (85.3 kHz b)
> + (==) FBDEV(0): DPI set to (96, 96)
> + (II) Loading sub module "fb"
> + (II) LoadModule: "fb"
> + (II) Module "fb" already built-in
> + (**) FBDEV(0): using shadow framebuffer
> + (II) Loading sub module "shadow"
> + (II) LoadModule: "shadow"
> + (II) Loading /usr/lib64/xorg/modules/libshadow.so
> + (II) Module shadow: vendor="X.Org Foundation"
> + 	compiled for 1.21.1.4, module version = 1.1.0
> + 	ABI class: X.Org ANSI C Emulation, version 0.4
> + (II) UnloadModule: "vesa"
> + (II) Unloading vesa
> + (II) FBDEV(0): FBIOBLANK: Invalid argument (Screen blanking not supported by kernel - disabling)
> + (==) FBDEV(0): Backing store enabled
> + (==) FBDEV(0): DPMS enabled
> + (II) Initializing extension Generic Event Extension
> + (II) Initializing extension SHAPE
> + (II) Initializing extension MIT-SHM
> + (II) Initializing extension XInputExtension
> + (II) Initializing extension XTEST
> + (II) Initializing extension BIG-REQUESTS
> + (II) Initializing extension SYNC
> + (II) Initializing extension XKEYBOARD
> + (II) Initializing extension XC-MISC
> + (II) Initializing extension SECURITY
> + (II) Initializing extension XFIXES
> + (II) Initializing extension RENDER
> + (II) Initializing extension RANDR
> + (II) Initializing extension COMPOSITE
> + (II) Initializing extension DAMAGE
> + (II) Initializing extension MIT-SCREEN-SAVER
> + (II) Initializing extension DOUBLE-BUFFER
> + (II) Initializing extension RECORD
> + (II) Initializing extension DPMS
> + (II) Initializing extension Present
> + (II) Initializing extension DRI3
> + (II) Initializing extension X-Resource
> + (II) Initializing extension XVideo
> + (II) Initializing extension XVideo-MotionCompensation
> + (II) Initializing extension GLX
> + (II) AIGLX: Screen 0 is not DRI2 capable
> + (II) IGLX: Loaded and initialized swrast
> + (II) GLX: Initialized DRISWRAST GL provider for screen 0
> + (II) Initializing extension XFree86-VidModeExtension
> + (II) Initializing extension XFree86-DGA
> + (II) Initializing extension XFree86-DRI
> + (II) Initializing extension DRI2
> + (II) config/udev: Adding input device Power Button (/dev/input/event1)
> + (**) Power Button: Applying InputClass "evdev keyboard catchall"
> + (**) Power Button: Applying InputClass "libinput keyboard catchall"
> + (**) Power Button: Applying InputClass "system-keyboard"
> + (II) LoadModule: "libinput"
> + (II) Loading /usr/lib64/xorg/modules/input/libinput_drv.so
> + (II) Module libinput: vendor="X.Org Foundation"
> + 	compiled for 1.21.1.4, module version = 1.2.1
> + 	Module class: X.Org XInput Driver
> + 	ABI class: X.Org XInput driver, version 24.4
> + (II) Using input driver 'libinput' for 'Power Button'
> + (**) Power Button: always reports core events
> + (**) Option "Device" "/dev/input/event1"
> + (II) event1  - Power Button: is tagged by udev as: Keyboard
> + (II) event1  - Power Button: device is a keyboard
> + (II) event1  - Power Button: device removed
> + (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1/event1"
> + (II) XINPUT: Adding extended input device "Power Button" (type: KEYBOARD, id 6)
> + (**) Option "xkb_model" "pc105"
> + (**) Option "xkb_layout" "de"
> + (**) Option "xkb_variant" "nodeadkeys"
> + (**) Option "xkb_options" "terminate:ctrl_alt_bksp"
> + (II) event1  - Power Button: is tagged by udev as: Keyboard
> + (II) event1  - Power Button: device is a keyboard
> + (II) config/udev: Adding input device Power Button (/dev/input/event0)
> + (**) Power Button: Applying InputClass "evdev keyboard catchall"
> + (**) Power Button: Applying InputClass "libinput keyboard catchall"
> + (**) Power Button: Applying InputClass "system-keyboard"
> + (II) Using input driver 'libinput' for 'Power Button'
> + (**) Power Button: always reports core events
> + (**) Option "Device" "/dev/input/event0"
> + (II) event0  - Power Button: is tagged by udev as: Keyboard
> + (II) event0  - Power Button: device is a keyboard
> + (II) event0  - Power Button: device removed
> + (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0/event0"
> + (II) XINPUT: Adding extended input device "Power Button" (type: KEYBOARD, id 7)
> + (**) Option "xkb_model" "pc105"
> + (**) Option "xkb_layout" "de"
> + (**) Option "xkb_variant" "nodeadkeys"
> + (**) Option "xkb_options" "terminate:ctrl_alt_bksp"
> + (II) event0  - Power Button: is tagged by udev as: Keyboard
> + (II) event0  - Power Button: device is a keyboard
> + (II) config/udev: Adding input device HDA NVidia HDMI/DP,pcm=3 (/dev/input/event9)
> + (II) No input driver specified, ignoring this device.
> + (II) This device may have been added with another device file.
> + (II) config/udev: Adding input device HDA NVidia HDMI/DP,pcm=7 (/dev/input/event10)
> + (II) No input driver specified, ignoring this device.
> + (II) This device may have been added with another device file.
> + (II) config/udev: Adding input device HDA NVidia HDMI/DP,pcm=8 (/dev/input/event11)
> + (II) No input driver specified, ignoring this device.
> + (II) This device may have been added with another device file.
> + (II) config/udev: Adding input device HDA NVidia HDMI/DP,pcm=9 (/dev/input/event12)
> + (II) No input driver specified, ignoring this device.
> + (II) This device may have been added with another device file.
> + (II) config/udev: Adding input device GASIA PS2toUSB Adapter (/dev/input/event2)
> + (**) GASIA PS2toUSB Adapter: Applying InputClass "evdev keyboard catchall"
> + (**) GASIA PS2toUSB Adapter: Applying InputClass "libinput keyboard catchall"
> + (**) GASIA PS2toUSB Adapter: Applying InputClass "system-keyboard"
> + (II) Using input driver 'libinput' for 'GASIA PS2toUSB Adapter'
> + (**) GASIA PS2toUSB Adapter: always reports core events
> + (**) Option "Device" "/dev/input/event2"
> + (II) event2  - GASIA PS2toUSB Adapter: is tagged by udev as: Keyboard
> + (II) event2  - GASIA PS2toUSB Adapter: device is a keyboard
> + (II) event2  - GASIA PS2toUSB Adapter: device removed
> + (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.0/0003:0E8F:0020.0001/input/input2/event2"
> + (II) XINPUT: Adding extended input device "GASIA PS2toUSB Adapter" (type: KEYBOARD, id 8)
> + (**) Option "xkb_model" "pc105"
> + (**) Option "xkb_layout" "de"
> + (**) Option "xkb_variant" "nodeadkeys"
> + (**) Option "xkb_options" "terminate:ctrl_alt_bksp"
> + (II) event2  - GASIA PS2toUSB Adapter: is tagged by udev as: Keyboard
> + (II) event2  - GASIA PS2toUSB Adapter: device is a keyboard
> + (II) config/udev: Adding input device GASIA PS2toUSB Adapter Mouse (/dev/input/event3)
> + (**) GASIA PS2toUSB Adapter Mouse: Applying InputClass "evdev pointer catchall"
> + (**) GASIA PS2toUSB Adapter Mouse: Applying InputClass "libinput pointer catchall"
> + (II) Using input driver 'libinput' for 'GASIA PS2toUSB Adapter Mouse'
> + (**) GASIA PS2toUSB Adapter Mouse: always reports core events
> + (**) Option "Device" "/dev/input/event3"
> + (II) event3  - GASIA PS2toUSB Adapter Mouse: is tagged by udev as: Mouse
> + (II) event3  - GASIA PS2toUSB Adapter Mouse: device is a pointer
> + (II) event3  - GASIA PS2toUSB Adapter Mouse: device removed
> + (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.1/0003:0E8F:0020.0002/input/input3/event3"
> + (II) XINPUT: Adding extended input device "GASIA PS2toUSB Adapter Mouse" (type: MOUSE, id 9)
> + (**) Option "AccelerationScheme" "none"
> + (**) GASIA PS2toUSB Adapter Mouse: (accel) selected scheme none/0
> + (**) GASIA PS2toUSB Adapter Mouse: (accel) acceleration factor: 2.000
> + (**) GASIA PS2toUSB Adapter Mouse: (accel) acceleration threshold: 4
> + (II) event3  - GASIA PS2toUSB Adapter Mouse: is tagged by udev as: Mouse
> + (II) event3  - GASIA PS2toUSB Adapter Mouse: device is a pointer
> + (II) config/udev: Adding input device GASIA PS2toUSB Adapter Mouse (/dev/input/mouse0)
> + (II) No input driver specified, ignoring this device.
> + (II) This device may have been added with another device file.
> + (II) config/udev: Adding input device GASIA PS2toUSB Adapter System Control (/dev/input/event4)
> + (**) GASIA PS2toUSB Adapter System Control: Applying InputClass "evdev keyboard catchall"
> + (**) GASIA PS2toUSB Adapter System Control: Applying InputClass "libinput keyboard catchall"
> + (**) GASIA PS2toUSB Adapter System Control: Applying InputClass "system-keyboard"
> + (II) Using input driver 'libinput' for 'GASIA PS2toUSB Adapter System Control'
> + (**) GASIA PS2toUSB Adapter System Control: always reports core events
> + (**) Option "Device" "/dev/input/event4"
> + (II) event4  - GASIA PS2toUSB Adapter System Control: is tagged by udev as: Keyboard
> + (II) event4  - GASIA PS2toUSB Adapter System Control: device is a keyboard
> + (II) event4  - GASIA PS2toUSB Adapter System Control: device removed
> + (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.1/0003:0E8F:0020.0002/input/input4/event4"
> + (II) XINPUT: Adding extended input device "GASIA PS2toUSB Adapter System Control" (type: KEYBOARD, id 10)
> + (**) Option "xkb_model" "pc105"
> + (**) Option "xkb_layout" "de"
> + (**) Option "xkb_variant" "nodeadkeys"
> + (**) Option "xkb_options" "terminate:ctrl_alt_bksp"
> + (II) event4  - GASIA PS2toUSB Adapter System Control: is tagged by udev as: Keyboard
> + (II) event4  - GASIA PS2toUSB Adapter System Control: device is a keyboard
> + (II) config/udev: Adding input device GASIA PS2toUSB Adapter Consumer Control (/dev/input/event5)
> + (**) GASIA PS2toUSB Adapter Consumer Control: Applying InputClass "evdev keyboard catchall"
> + (**) GASIA PS2toUSB Adapter Consumer Control: Applying InputClass "libinput keyboard catchall"
> + (**) GASIA PS2toUSB Adapter Consumer Control: Applying InputClass "system-keyboard"
> + (II) Using input driver 'libinput' for 'GASIA PS2toUSB Adapter Consumer Control'
> + (**) GASIA PS2toUSB Adapter Consumer Control: always reports core events
> + (**) Option "Device" "/dev/input/event5"
> + (II) event5  - GASIA PS2toUSB Adapter Consumer Control: is tagged by udev as: Keyboard
> + (II) event5  - GASIA PS2toUSB Adapter Consumer Control: device is a keyboard
> + (II) event5  - GASIA PS2toUSB Adapter Consumer Control: device removed
> + (II) libinput: GASIA PS2toUSB Adapter Consumer Control: needs a virtual subdevice
> + (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.1/0003:0E8F:0020.0002/input/input5/event5"
> + (II) XINPUT: Adding extended input device "GASIA PS2toUSB Adapter Consumer Control" (type: MOUSE, id 11)
> + (**) Option "AccelerationScheme" "none"
> + (**) GASIA PS2toUSB Adapter Consumer Control: (accel) selected scheme none/0
> + (**) GASIA PS2toUSB Adapter Consumer Control: (accel) acceleration factor: 2.000
> + (**) GASIA PS2toUSB Adapter Consumer Control: (accel) acceleration threshold: 4
> + (II) event5  - GASIA PS2toUSB Adapter Consumer Control: is tagged by udev as: Keyboard
> + (II) event5  - GASIA PS2toUSB Adapter Consumer Control: device is a keyboard
> + (II) config/udev: Adding input device Logitech K330 (/dev/input/event7)
> + (**) Logitech K330: Applying InputClass "evdev keyboard catchall"
> + (**) Logitech K330: Applying InputClass "libinput keyboard catchall"
> + (**) Logitech K330: Applying InputClass "system-keyboard"
> + (II) Using input driver 'libinput' for 'Logitech K330'
> + (**) Logitech K330: always reports core events
> + (**) Option "Device" "/dev/input/event7"
> + (II) event7  - Logitech K330: is tagged by udev as: Keyboard
> + (II) event7  - Logitech K330: device is a keyboard
> + (II) event7  - Logitech K330: device removed
> + (II) libinput: Logitech K330: needs a virtual subdevice
> + (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb3/3-2/3-2:1.2/0003:046D:C52B.0005/0003:046D:4016.0007/input/input20/event7"
> + (II) XINPUT: Adding extended input device "Logitech K330" (type: MOUSE, id 12)
> + (**) Option "AccelerationScheme" "none"
> + (**) Logitech K330: (accel) selected scheme none/0
> + (**) Logitech K330: (accel) acceleration factor: 2.000
> + (**) Logitech K330: (accel) acceleration threshold: 4
> + (II) event7  - Logitech K330: is tagged by udev as: Keyboard
> + (II) event7  - Logitech K330: device is a keyboard
> + (II) config/udev: Adding input device Logitech M215 2nd Gen (/dev/input/event6)
> + (**) Logitech M215 2nd Gen: Applying InputClass "evdev pointer catchall"
> + (**) Logitech M215 2nd Gen: Applying InputClass "libinput pointer catchall"
> + (II) Using input driver 'libinput' for 'Logitech M215 2nd Gen'
> + (**) Logitech M215 2nd Gen: always reports core events
> + (**) Option "Device" "/dev/input/event6"
> + (II) event6  - Logitech M215 2nd Gen: is tagged by udev as: Mouse
> + (II) event6  - Logitech M215 2nd Gen: device is a pointer
> + (II) event6  - Logitech M215 2nd Gen: device removed
> + (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb3/3-2/3-2:1.2/0003:046D:C52B.0005/0003:046D:401B.0006/input/input19/event6"
> + (II) XINPUT: Adding extended input device "Logitech M215 2nd Gen" (type: MOUSE, id 13)
> + (**) Option "AccelerationScheme" "none"
> + (**) Logitech M215 2nd Gen: (accel) selected scheme none/0
> + (**) Logitech M215 2nd Gen: (accel) acceleration factor: 2.000
> + (**) Logitech M215 2nd Gen: (accel) acceleration threshold: 4
> + (II) event6  - Logitech M215 2nd Gen: is tagged by udev as: Mouse
> + (II) event6  - Logitech M215 2nd Gen: device is a pointer
> + (II) config/udev: Adding input device Logitech M215 2nd Gen (/dev/input/mouse1)
> + (II) No input driver specified, ignoring this device.
> + (II) This device may have been added with another device file.
> + (II) config/udev: Adding input device HDA Intel PCH Front Mic (/dev/input/event13)
> + (II) No input driver specified, ignoring this device.
> + (II) This device may have been added with another device file.
> + (II) config/udev: Adding input device HDA Intel PCH Rear Mic (/dev/input/event14)
> + (II) No input driver specified, ignoring this device.
> + (II) This device may have been added with another device file.
> + (II) config/udev: Adding input device HDA Intel PCH Line (/dev/input/event15)
> + (II) No input driver specified, ignoring this device.
> + (II) This device may have been added with another device file.
> + (II) config/udev: Adding input device HDA Intel PCH Line Out (/dev/input/event16)
> + (II) No input driver specified, ignoring this device.
> + (II) This device may have been added with another device file.
> + (II) config/udev: Adding input device HDA Intel PCH Front Headphone (/dev/input/event17)
> + (II) No input driver specified, ignoring this device.
> + (II) This device may have been added with another device file.
> + (II) config/udev: Adding input device PC Speaker (/dev/input/event8)
> + (II) No input driver specified, ignoring this device.
> + (II) This device may have been added with another device file.
> + (**) GASIA PS2toUSB Adapter Consumer Control: Applying InputClass "evdev keyboard catchall"
> + (**) GASIA PS2toUSB Adapter Consumer Control: Applying InputClass "libinput keyboard catchall"
> + (**) GASIA PS2toUSB Adapter Consumer Control: Applying InputClass "system-keyboard"
> + (II) Using input driver 'libinput' for 'GASIA PS2toUSB Adapter Consumer Control'
> + (**) GASIA PS2toUSB Adapter Consumer Control: always reports core events
> + (**) Option "Device" "/dev/input/event5"
> + (II) libinput: GASIA PS2toUSB Adapter Consumer Control: is a virtual subdevice
> + (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.1/0003:0E8F:0020.0002/input/input5/event5"
> + (II) XINPUT: Adding extended input device "GASIA PS2toUSB Adapter Consumer Control" (type: KEYBOARD, id 14)
> + (**) Option "xkb_model" "pc105"
> + (**) Option "xkb_layout" "de"
> + (**) Option "xkb_variant" "nodeadkeys"
> + (**) Option "xkb_options" "terminate:ctrl_alt_bksp"
> + (**) Logitech K330: Applying InputClass "evdev keyboard catchall"
> + (**) Logitech K330: Applying InputClass "libinput keyboard catchall"
> + (**) Logitech K330: Applying InputClass "system-keyboard"
> + (II) Using input driver 'libinput' for 'Logitech K330'
> + (**) Logitech K330: always reports core events
> + (**) Option "Device" "/dev/input/event7"
> + (II) libinput: Logitech K330: is a virtual subdevice
> + (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000:00:14.0/usb3/3-2/3-2:1.2/0003:046D:C52B.0005/0003:046D:4016.0007/input/input20/event7"
> + (II) XINPUT: Adding extended input device "Logitech K330" (type: KEYBOARD, id 15)
> + (**) Option "xkb_model" "pc105"
> + (**) Option "xkb_layout" "de"
> + (**) Option "xkb_variant" "nodeadkeys"
> + (**) Option "xkb_options" "terminate:ctrl_alt_bksp"
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


