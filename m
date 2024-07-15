Return-Path: <linux-kernel+bounces-252293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31793111A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E717281F58
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A353323BF;
	Mon, 15 Jul 2024 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AQ3wxYEI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kt+DOhZW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yHNQSgDq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E/s76shL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470B185E64
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035340; cv=none; b=LpWH/OaiH/YsBNxlO1PZu0XSuA0f4AaYOfHz5cseyWjEFHJ3KqWazsJiAhHsB2HQLM9TZq/vupxQ+6EcDFmooQAP/hXzsrb/wJKZz+5iY10IZZk9vxEaPr9nU1qUL7NB4e2dU8Ka2he6Q2pFmd91dooBMV6dDeLCdQs6bemYWyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035340; c=relaxed/simple;
	bh=m4NxpBSLO7VFARhGPTaOQeG3iuAHyifPPyhJs9gGJ6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkTXdYp+vgAWzztHDNg+07/MAoHZ6+ws70L9nJPY1W8b70vGeMCEuxPXNB7Z+DqHtvZbQ6PYnxebvX9MpXFSxVeqK5PO9S+6gcPJkBQGzkDaKWYSF1VsokoCV53kFb0tclzgjWAYkd3OtEvo/bUJHnKTWaJ+IafFcrnx5MdITes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AQ3wxYEI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kt+DOhZW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yHNQSgDq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E/s76shL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD8E21F80F;
	Mon, 15 Jul 2024 09:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721035336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yfcU/qW6FYgT/ihp3L9ZZPatKjTgjzdIJKfoKGNBM5s=;
	b=AQ3wxYEI2FxgzDM38LEpiVS5VulMk2rybUAYvLnUFxEG4gjF372IOQygFxvrg6m7rlJgkW
	Wt94p60LC+QnOcVEy59R7x/pEs9b6OKFZ0mMQchpMlZlIACh2wVgaxW/zmq+PsQT5qmqLS
	00gKepm54nenJg+PvdrHM/QY+K2Gf/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721035336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yfcU/qW6FYgT/ihp3L9ZZPatKjTgjzdIJKfoKGNBM5s=;
	b=kt+DOhZW0mzeJ0sa/21h1C1OgShnlI0LjKMEJNjZKQ05GBDqRvMn5WZy670jtj+7EP2qpP
	sx69yJ/6US63dwAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yHNQSgDq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="E/s76shL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721035335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yfcU/qW6FYgT/ihp3L9ZZPatKjTgjzdIJKfoKGNBM5s=;
	b=yHNQSgDqOMDcKCMMtTT2Xin4jOmeP42/XgdkofDXYjzNq+nS7VNLeHeLYzn3+hrs9/HPcp
	7LonPCKq8rTWcH3ojdss9L51AVE7lqGV8qxl69gXmEmmhSyV79Xn5CcR+iIr34WxOys1aY
	yxURMAp2pwWD+62t7kTwst2VZ98bF3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721035335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yfcU/qW6FYgT/ihp3L9ZZPatKjTgjzdIJKfoKGNBM5s=;
	b=E/s76shLih1Wi5SxN0/ZsVtQExYM0TUrc+wyeIkLtIRMEQb7tx7Wm2DibmFXF13COHZLQj
	67QSVEzynuehs1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8EEE134AB;
	Mon, 15 Jul 2024 09:22:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gbACKEfqlGb1DQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 15 Jul 2024 09:22:15 +0000
Message-ID: <a01f6a7e-c56e-4a78-8605-ab5b253d9c9e@suse.de>
Date: Mon, 15 Jul 2024 11:22:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: firmware/sysfb.c device path
To: Tj <tj.iam.tj@proton.me>
Cc: Marek Olsak <Marek.Olsak@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "1075713@bugs.debian.org" <1075713@bugs.debian.org>
References: <lLyvPFC_APGHNfyGNHRpQy5izBikkaTPOpHooZIT3fFAoJPquSI31ZMueA99XTdr8ysir3X7O7IMdc6za-0m79vr_claeparHhoRouVgHOI=@proton.me>
 <1eb659d8-536e-401b-a427-19709a98953a@suse.de>
 <-sJINpD9sbYc288gXp2-Tf5w6diSusXAP8mM8l0mnLWfIXgjuNe1LBgkqQ2indMJOehVrPUPO3UMQ-AvObgCWUW9h_TepvcNy9gnqfvoyvM=@proton.me>
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
In-Reply-To: <-sJINpD9sbYc288gXp2-Tf5w6diSusXAP8mM8l0mnLWfIXgjuNe1LBgkqQ2indMJOehVrPUPO3UMQ-AvObgCWUW9h_TepvcNy9gnqfvoyvM=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.50
X-Spam-Level: 
X-Rspamd-Queue-Id: CD8E21F80F

Hi

Am 15.07.24 um 11:03 schrieb Tj:
> On Monday, 15 July 2024 at 07:44, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
>>> See hw/xfree86/fbdevhw/fbdevhw.c::fbdev_open()
>>>
>>> https://gitlab.freedesktop.org/xorg/xserver/-/blob/master/hw/xfree86/fbdevhw/fbdevhw.c?ref_type=heads#L381
>>
>> Amazing debugging skills!
>>
>> The patch that causes the regression in X sets the PCI device as parent
>> for the VESA framebuffer. That means that the PCI device won't be
>> unplugged or suspended while the VESA framebuffer is still in use.
>> Without, results are undefined.
>>
>> Therefore, could this be fixed in X' fbdev driver?
> I was in two minds about this one. On the 'perfection' side I agree Xorg should not rely on a symbolic link at all - though that is easy to say; I wasn't the one that had to find a way to do what fbdevhw has to do at the time!
>
> But the other me argues that kernel ought not to break userspace and as it is a pretty common scenario across distros that userspace stays relatively stable (sans security bugs) but kernels can and do move on quite rapidly and frequently the kernel ought to play nice here :)
>
> With this in mind I can foresee many systems that work perfectly fine will break when only the kernel is upgraded and thus it'll have the finger of blame pointed at it.
>
> Since this is more likely to strike in automated test harness scenarios (due to it being relatively obscure) as well there may well be circumstances where changing a userspace library immediately is extremely problematical.
>
> I wonder if there's some half-way deprecation measure here that would allow a period of transition?
>
> I can imagine one way would be a custom udev rule (for systemd-udevd hosts - not sure about non-udevd) that replaces the new symlink with the old - but if a distro does that it's almost as easy to patch and rebuild fbdevhw - and far more brittle.

I agree with the assessment. Luckily not too many systems use fbdevhw 
these days and updating X isn't much more effort than updating the kernel.

And OTOH the kernel patch fixes a real problem. If the PCI device 
suspends or does a hotunplug, the state of the VESA/EFI framebuffers 
becomes undefined (with undefined results). So reverting it is not a 
good option either.

>
>> A fix could look like this:
>>
>> 1) readlink /sys/class/graphics/fb0/device/subsystem
>>   2) strcmp to "bus/pci"
> This works and doesn't cause a regression in v6.8.12:

These device/subsystem paths have been stable since forever. That should 
most likely not change.

>
> ~ # uname -r; grep fbdev /var/log/Xorg.0.log
> 6.9.7-amd64
> [    31.376] (==) Matched fbdev as autoconfigured driver 2
> [    31.377] (II) LoadModule: "fbdev"
> [    31.377] (II) Loading /usr/lib/xorg/modules/drivers/fbdev_drv.so
> [    31.377] (II) Module fbdev: vendor="X.Org Foundation"
> [    31.377] (II) FBDEV: driver for framebuffer: fbdev
> [    31.410] fbdev trace: FBDevPciProbe()
> [    31.410] (II) Loading sub module "fbdevhw"
> [    31.410] (II) LoadModule: "fbdevhw"
> [    31.410] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
> [    31.410] (II) Module fbdevhw: vendor="X.Org Foundation"
> [    31.410] fbdev trace: FBDevPciProbe() return
> [    31.410] (WW) Falling back to old probe method for fbdev
> [    31.410] fbdev trace: FBDevProbe()
> [    31.410] (II) Loading sub module "fbdevhw"
> [    31.410] (II) LoadModule: "fbdevhw"
> [    31.410] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
> [    31.410] (II) Module fbdevhw: vendor="X.Org Foundation"
> [    31.410] fbdev: FBDevProbe() for() numDevSection=0
> [    31.410] fbdev: FBDevProbe() isPci0 isISA=0
> [    31.410] fbdev: FBDevProbe() calling fbdevHWProbe(NULL, '(null)', NULL)
> [    31.410] (II) fbdev_open(scrnIndex=-1, dev=(null), namep=(nil))
> [    31.410] (II) fbdev_open() using dev from env FRAMEBUFFER=(null)
> [    31.410] (II) fbdev_open() using default dev=/dev/fb0
> [    31.410] (II) fbdev_open() sysfs_path=/sys/class/graphics/fb0/device/subsystem
> [    31.410] (II) fbdev_open() buf=../../../../bus/platform
> [    31.410] (II) fbdev_open() returning file descriptor 11
> [    31.410] fbdev trace: FBDevProbe() fbdevHWProbe()
> [    31.410] fbdev trace: FBDevProbe() else xf86ClaimFbSlot()
> [    31.410] fbdev trace: FBDevProbe() return
> [    31.410] (II) UnloadModule: "fbdev"
> [    31.410] (II) UnloadSubModule: "fbdevhw"
> [    31.410] fbdev: PreInit 0
> [    31.410] (II) FBDEV(0): fbdev_open(scrnIndex=0, dev=(null), namep=(nil))
> [    31.410] (II) FBDEV(0): fbdev_open() using dev from env FRAMEBUFFER=(null)
> [    31.410] (II) FBDEV(0): fbdev_open() using default dev=/dev/fb0
> [    31.410] (II) FBDEV(0): fbdev_open() sysfs_path=/sys/class/graphics/fb0/device/subsystem
> [    31.410] (II) FBDEV(0): fbdev_open() buf=../../../../bus/platform
> [    31.410] (II) FBDEV(0): fbdev_open() returning file descriptor 12
>
> ~ # uname -r; grep fbdev /var/log/Xorg.0.log
> 6.8.12-amd64
> [    14.225] (==) Matched fbdev as autoconfigured driver 2
> [    14.225] (II) LoadModule: "fbdev"
> [    14.225] (II) Loading /usr/lib/xorg/modules/drivers/fbdev_drv.so
> [    14.225] (II) Module fbdev: vendor="X.Org Foundation"
> [    14.225] (II) FBDEV: driver for framebuffer: fbdev
> [    14.252] fbdev trace: FBDevPciProbe()
> [    14.252] (II) Loading sub module "fbdevhw"
> [    14.252] (II) LoadModule: "fbdevhw"
> [    14.252] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
> [    14.252] (II) Module fbdevhw: vendor="X.Org Foundation"
> [    14.253] fbdev trace: FBDevPciProbe() return
> [    14.253] (WW) Falling back to old probe method for fbdev
> [    14.253] fbdev trace: FBDevProbe()
> [    14.253] (II) Loading sub module "fbdevhw"
> [    14.253] (II) LoadModule: "fbdevhw"
> [    14.253] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
> [    14.253] (II) Module fbdevhw: vendor="X.Org Foundation"
> [    14.253] fbdev: FBDevProbe() for() numDevSection=0
> [    14.253] fbdev: FBDevProbe() isPci0 isISA=0
> [    14.253] fbdev: FBDevProbe() calling fbdevHWProbe(NULL, '(null)', NULL)
> [    14.253] (II) fbdev_open(scrnIndex=-1, dev=(null), namep=(nil))
> [    14.253] (II) fbdev_open() using dev from env FRAMEBUFFER=(null)
> [    14.253] (II) fbdev_open() using default dev=/dev/fb0
> [    14.253] (II) fbdev_open() sysfs_path=/sys/class/graphics/fb0/device/subsystem
> [    14.253] (II) fbdev_open() buf=../../../bus/platform
> [    14.253] (II) fbdev_open() returning file descriptor 11
> [    14.253] fbdev trace: FBDevProbe() fbdevHWProbe()
> [    14.253] fbdev trace: FBDevProbe() else xf86ClaimFbSlot()
> [    14.253] fbdev trace: FBDevProbe() return
> [    14.253] (II) UnloadModule: "fbdev"
> [    14.253] (II) UnloadSubModule: "fbdevhw"
> [    14.253] fbdev: PreInit 0
> [    14.253] (II) FBDEV(0): fbdev_open(scrnIndex=0, dev=(null), namep=(nil))
> [    14.253] (II) FBDEV(0): fbdev_open() using dev from env FRAMEBUFFER=(null)
> [    14.253] (II) FBDEV(0): fbdev_open() using default dev=/dev/fb0
> [    14.253] (II) FBDEV(0): fbdev_open() sysfs_path=/sys/class/graphics/fb0/device/subsystem
> [    14.253] (II) FBDEV(0): fbdev_open() buf=../../../bus/platform
> [    14.253] (II) FBDEV(0): fbdev_open() returning file descriptor 12
>
> I'll propose this patch in Debian Xorg for Unstable/Testing but not sure if it'll be accepted for Stable.

It should not be a problem, as only 6.9 is affected. Debian stable does 
update to such newer kernels, right?

We should definitely get your patch into the Xorg upstream.

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


