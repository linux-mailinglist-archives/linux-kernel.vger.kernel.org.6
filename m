Return-Path: <linux-kernel+bounces-326937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59536976ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6951C23A02
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49211187874;
	Thu, 12 Sep 2024 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHyXS37M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36A1865F7
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158845; cv=none; b=Xe4OAAGN1kQvjMqoB7rykoZJW+VMJ1axsA3o9xo9DWo/D5+Wsgk+R8nJiv518DZ4ThMzRmA8Gpv47mAQ9mifNJi5pv6a7iN1upghZllySmriPtqEV9+UeqSvvV3UBLgbKU1OmJdiylaMCj/26IvIO82ZaPYyqoitVyrcu7uTIvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158845; c=relaxed/simple;
	bh=XQG7wonhC6R1YdTQNDlE3VJtJ10vFf+cAJlA/RvoZf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JZIlGY4tGBM4c/KbDd95ALtDj+vOggRhfcsfR7CwvfB1RuqBMZolR2RC5D++ClRKs97d+wEdvBvSMiRYKZgi7w2Yb9sLnfqXEx7WZYIULYt7+wT+bZwje9mTwuVM9laJmFx4Zqr00gZdqjxrMAy28u56os2QAOH5Lz5CsS8hpAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHyXS37M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726158843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EOmdO+b7gYLR4VAcBUs89Ub1sXD9TFu8fmoSrmDCcEU=;
	b=DHyXS37McYLD8iW4fcBsEVDN1OKuoJ+eL7QusXLyqwBa93UTo29jVUQghok8sVpfRz0Ljm
	dAUh4S9nibBDrhAEOKTDzaprxk4rCHXy8ksdWJKWLT5qPajeaN+vUOgFQUMrcKpctep5En
	pW1xdd0nXOvWU+7WUq/kKSzY6f0Y6us=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-UYRTsvViO--3gtUcM1LFGg-1; Thu, 12 Sep 2024 12:34:02 -0400
X-MC-Unique: UYRTsvViO--3gtUcM1LFGg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374c90d24e3so12201f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726158840; x=1726763640;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOmdO+b7gYLR4VAcBUs89Ub1sXD9TFu8fmoSrmDCcEU=;
        b=mFbrzJKxjD+LzbtKhiCq/ykGgAAE4mqi7qdDmE+CLyufnExTkxsS/y3GINJmuBtsHP
         x7AdvSfFExgMhHBH0v3X4vvGlBdBqyLdaAuJIFuxqiBr5QID5f1BdTNBylApiACHr5o3
         tfPaFSrjaY36UppbemEzm3ibWjGie3x0m/aoeCJ70Etyv99IkKzgsvMSUHb3e5PjnQa1
         CtyzpMYCrXeVTbJdKd/KcZN9H029WeLWpUA6iOzABq2StXloB65KTSwYYxOamUvWmxeH
         +aCweJMZuW99m2Pzu6ylm9ii7uQSGNGvPHVfqAQ+Tas2BL6QZy7aWaQ6EWm14gwo3Bm8
         eNmw==
X-Forwarded-Encrypted: i=1; AJvYcCXIZyWE6WDftMK7eRZJKd7VMAEEhxkqJe2aGF2lQcOkSr5oQGitEgExm7JTkvTpXqy+wGGIB91AJBBv3u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkhXm0CogyOiI6TQbuUEI2LbKfWToi5jpysNddmbGBHZd/grR/
	j/jK4F9CG1B0cZQk+bxG2OE9Yp0zSMGWSht5Q+lNOU2VDWgtnTsJBalH9rYEkB+IfpLihir4lHm
	isxLQE7IjEUYd6cnMFC1rBDduyheV1Bq8YXh4liyv13DN3EsolB5Yl/o+T2DM1g==
X-Received: by 2002:a05:6000:c81:b0:374:bde8:66af with SMTP id ffacd0b85a97d-378c2d581camr2869424f8f.57.1726158840262;
        Thu, 12 Sep 2024 09:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHykV9DHzv3qV6R6EuPD0pzt9S/Yjo+tEE1Jd7G9+MiD3zDj61TCo7+RJHhLaEraT38VncGGg==
X-Received: by 2002:a05:6000:c81:b0:374:bde8:66af with SMTP id ffacd0b85a97d-378c2d581camr2869405f8f.57.1726158839736;
        Thu, 12 Sep 2024 09:33:59 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956653f9sm14798656f8f.31.2024.09.12.09.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 09:33:59 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>, Borislav Petkov <bp@alien8.de>,
 Hugues Bruant <hugues.bruant@gmail.com>, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org, Fenghua Yu
 <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, Tony
 Luck <tony.luck@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>, Julius
 Werner <jwerner@chromium.org>, chrome-platform@lists.linux.dev, Jani
 Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [NOT A REGRESSION] firmware: framebuffer-coreboot: duplicate
 device name "simple-framebuffer.0"
In-Reply-To: <CAODwPW8P+jcF0erUph5XyWoyQgLFbZWxEM6Ygi_LFCCTLmH89Q@mail.gmail.com>
References: <CALvjV29jozswRtmYxDur2TuEQ=1JSDrM+uWVHmghW3hG5Y9F+w@mail.gmail.com>
 <20240909080200.GAZt6reI9c98c9S_Xc@fat_crate.local>
 <ZuCGkjoxKxpnhEh6@google.com>
 <87jzfhayul.fsf@minerva.mail-host-address-is-not-set>
 <CAODwPW8P+jcF0erUph5XyWoyQgLFbZWxEM6Ygi_LFCCTLmH89Q@mail.gmail.com>
Date: Thu, 12 Sep 2024 18:33:58 +0200
Message-ID: <87mskczv9l.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Julius Werner <jwerner@chromium.org> writes:

Hello Julius,

>> On Coreboot platforms, a system framebuffer may be provided to the Linux
>> kernel by filling a LB_TAG_FRAMEBUFFER entry in the Coreboot table. But
>> it seems SeaBIOS payload can also provide a VGA mode in the boot params.
>>
>> [...]
>>
>> To prevent the issue, make the framebuffer_core driver to disable sysfb
>> if there is system framebuffer data in the Coreboot table. That way only
>> this driver will register a device and sysfb would not attempt to do it
>> (or remove its registered device if was already executed before).
>
> I wonder if the priority should be the other way around? coreboot's
> framebuffer is generally only valid when coreboot exits to the payload
> (e.g. SeaBIOS). Only if the payload doesn't touch the display
> controller or if there is no payload and coreboot directly hands off
> to a kernel does the kernel driver for LB_TAG_FRAMEBUFFER make sense.
> But if there is some other framebuffer information passed to the
> kernel from a firmware component running after coreboot, most likely
> that one is more up to date and the framebuffer described by the
> coreboot table doesn't work anymore (because the payload usually
> doesn't modify the coreboot tables again, even if it changes hardware
> state). So if there are two drivers fighting over which firmware
> framebuffer description is the correct one, the coreboot driver should
> probably give way.
>

That's a very good point. I'm actually not familiar with Coreboot and I
used an educated guess (in the case of DT for example, that's the main
source of truth and I didn't know if a Core table was in a similar vein).

Maybe something like the following (untested) patch then?

From de1c32017006f4671d91b695f4d6b4e99c073ab2 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Thu, 12 Sep 2024 18:31:55 +0200
Subject: [PATCH] firmware: coreboot: Don't register a pdev if screen_info data
 is available

On Coreboot platforms, a system framebuffer may be provided to the Linux
kernel by filling a LB_TAG_FRAMEBUFFER entry in the Coreboot table. But
a Coreboot payload (e.g: SeaBIOS) could also provide this information to
the Linux kernel.

If that the case, early arch x86 boot code will fill the global struct
screen_info data and that data used by the Generic System Framebuffers
(sysfb) framework to add a platform device with platform data about the
system framebuffer.

But later then the framebuffer_coreboot driver will try to do the same
framebuffer (using the information from the Coreboot table), which will
lead to an error due a simple-framebuffer.0 device already registered:

    sysfs: cannot create duplicate filename '/bus/platform/devices/simple-framebuffer.0'
    ...
    coreboot: could not register framebuffer
    framebuffer coreboot8: probe with driver framebuffer failed with error -17

To prevent the issue, make the framebuffer_core driver to not register a
platform device if the global struct screen_info data has been filled.

Reported-by: Brian Norris <briannorris@chromium.org>
Link: https://lore.kernel.org/all/ZuCG-DggNThuF4pj@b20ea791c01f/T/#ma7fb65acbc1a56042258adac910992bb225a20d2
Suggested-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/firmware/google/framebuffer-coreboot.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/google/framebuffer-coreboot.c
index daadd71d8ddd..4e50da17cd7e 100644
--- a/drivers/firmware/google/framebuffer-coreboot.c
+++ b/drivers/firmware/google/framebuffer-coreboot.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
+#include <linux/screen_info.h>
 
 #include "coreboot_table.h"
 
@@ -27,6 +28,7 @@ static int framebuffer_probe(struct coreboot_device *dev)
 	int i;
 	u32 length;
 	struct lb_framebuffer *fb = &dev->framebuffer;
+	struct screen_info *si = &screen_info;
 	struct platform_device *pdev;
 	struct resource res;
 	struct simplefb_platform_data pdata = {
@@ -36,6 +38,20 @@ static int framebuffer_probe(struct coreboot_device *dev)
 		.format = NULL,
 	};
 
+	/*
+	 * If the global screen_info data has been filled, the Generic
+	 * System Framebuffers (sysfb) will already register a platform
+	 * and pass the screen_info as platform_data to a driver that
+	 * could scan-out using the system provided framebuffer.
+	 *
+	 * On Coreboot systems, the advertise LB_TAG_FRAMEBUFFER entry
+	 * in the Coreboot table should only be used if the payload did
+	 * not set video mode info and passed it to the Linux kernel.
+	 */
+	if (si->orig_video_isVGA == VIDEO_TYPE_VLFB ||
+            si->orig_video_isVGA == VIDEO_TYPE_EFI)
+		return -EINVAL;
+
 	if (!fb->physical_address)
 		return -ENODEV;
 
-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


