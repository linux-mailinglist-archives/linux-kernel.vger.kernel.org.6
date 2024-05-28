Return-Path: <linux-kernel+bounces-191655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 481CD8D1226
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 997DEB21364
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF91094E;
	Tue, 28 May 2024 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="o8JdtkU5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iJJmpoCY"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136789450;
	Tue, 28 May 2024 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716864041; cv=none; b=ZWBvrzgm11GPj8yHZmsmqca+ySvQU/l0C3ETXVNXei1aqjrZCJk/h7qBa4NmKCI0FabUkrzbrQ6ZwGzfxiJctIxnerX1jU6T9VspkY0kmzuV/ZJMsyzoRGFwAaUt5yprKQ0Cfp3JLcgZdNtq7gvZzbsXJIImPke0OkGEXEiF898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716864041; c=relaxed/simple;
	bh=ewfBrueWLzV+N3bVPD/YYNaAozgn/nzEyTFsuRpWHkM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=guWpYlbRI7VZNFIADK9F/Ke+UmD3o84m+G5f8ltiABgReN7kGGBcKEeSFrsl6mgNwGHZ52sep2wecPDopRTKvsyMmVNnBS61TpzP7otKN6asRO/1tDgwK1ys4o330fTtPy2zwP/3FOXBhe5zqwZrful1QX4QcXEWsninq6BiYkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=o8JdtkU5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iJJmpoCY; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0C03E138013F;
	Mon, 27 May 2024 22:40:37 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Mon, 27 May 2024 22:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1716864037; x=1716950437; bh=Z1aE0lr7Zh
	HwLd6CortI1ST4aAF2DsoLetuYiDvFoPs=; b=o8JdtkU57gexH94gcepXGbEyLP
	JRS9NBvOTHTwe2uiRtTdjZeS2to6yPzGU2Nh/BpyNILK81SONobmltR7MnZvqW9f
	Ab3baRHV0+GLtE2qzcM/lnyN2Nlm+qI9ThtAPABQBYqe2I9lFapApNfdD/rX+h0w
	IqlfKb4Iuxuu+Y2jOXiYYmXb77ct+JUlOLad60IWaj+vKQby5YRSXho8dxwSlCdC
	1md12HVhU+16JBjt1E08DJLIcbsJh4zbn0QHNNYCTevKJlD8pd6GG62c3Pv4CTAC
	oW08fwLl67o+LfAU8WX9CeYt2E11mDg+cS7T2oOG4bdZ28cSo+f0lUa0IY1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716864037; x=1716950437; bh=Z1aE0lr7ZhHwLd6CortI1ST4aAF2
	DsoLetuYiDvFoPs=; b=iJJmpoCYer33+39XX5UYbUX6hRPyhnZBeIOUQfHVF89K
	oBL0hlzUGpJk0BYWMPtLCKosLRk4rHWCEqCjNu4TqJ8B8e6kNyCaCemrXJfamxM9
	OUsqv5YJxs5q/J+benU3iLT7LJVnk7MJJk1lCSPwg4kXE1+MPSofFXvqHVjg0q3b
	yiUBu3aaGFbmTWhrODXVoufY+/AnZ2UYTH9pKF/vazaAfrWZQypcIA/ynzBac2bg
	wwbwkQgZjCS/m4lcnjz9Y/URniRVvVisp3kKVZpSsBweHLMX03KraHJJ5XcLi2nZ
	HTeAHsX75W2Q9pU/68aWR3fiCdVFgs3eFEkhvSpZsw==
X-ME-Sender: <xms:JERVZvrnpv0--6f9rJMqV9oCvQfh-F2NG5y22bglEkJL2lkLifHkOw>
    <xme:JERVZpp96eJ1dPmOeyu_oe3Ir76sZdBEDHGBVcshA4KcGx4OtRyaV-BnfTdQZi-Va
    gMDNi6x2t1uGsAbZ2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpedutdelgfdvgeekueeuteevffelfedukeeitedugfdvtdeutdetjeduudeuvdeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:JERVZsMum7HChN6whCzfxxgntJyNya0LbU5JXQlGMJwrJcEgnKF4dQ>
    <xmx:JERVZi6HvYW6LfHLF4NXp4Dfvo72qaqln2jz6RpRSDVc0KRBRNy7PQ>
    <xmx:JERVZu6m0ffMXuL4w8RjT6JVbewc235Fsqfx1YeaZqDlWW9G4uJgxQ>
    <xmx:JERVZqiDjKgsEtUEN4xcdTQjWCrYaiLLj9rtqKMb6ddl8WC1CVmVgQ>
    <xmx:JURVZp3SXM8KZ1INgvBfge3BTHmDpuFQQ5US5BQRlAmfbEyzLqaQVboM>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 96FF52340080; Mon, 27 May 2024 22:40:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4d6b9171-7248-4937-87de-7e921ed8e507@app.fastmail.com>
In-Reply-To: <6f4bc109-00d0-47b0-a581-b96a6152545c@amd.com>
References: <20240528013626.14066-1-luke@ljones.dev>
 <20240528013626.14066-9-luke@ljones.dev>
 <6f4bc109-00d0-47b0-a581-b96a6152545c@amd.com>
Date: Tue, 28 May 2024 14:40:16 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Hans de Goede" <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] platform/x86: asus-wmi: add apu_mem setting
Content-Type: text/plain



On Tue, 28 May 2024, at 2:19 PM, Limonciello, Mario wrote:
> 
> 
> On 5/27/2024 8:36 PM, Luke D. Jones wrote:
> > Exposes the APU memory setting available on a few ASUS models such as
> > the ROG Ally.
> > 
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >   .../ABI/testing/sysfs-platform-asus-wmi       |   8 ++
> >   drivers/platform/x86/asus-wmi.c               | 109 ++++++++++++++++++
> >   include/linux/platform_data/x86/asus-wmi.h    |   3 +
> >   3 files changed, 120 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > index ac881e72e374..d221a3bc1a81 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > @@ -245,3 +245,11 @@ Description:
> >   Show the maximum performance and efficiency core countin format
> >   0x[E][P] where [E] is the efficiency core count, and [P] is
> >   the perfromance core count.
> > +
> > +What: /sys/devices/platform/<platform>/apu_mem
> > +Date: Jun 2024
> > +KernelVersion: 6.11
> > +Contact: "Luke Jones" <luke@ljones.dev>
> > +Description:
> > + Set the maximum available system memory for the APU.
> > +   * Min=0, Max=8
> 
> What is the unit?  It seems like multiples of something?

It's GB, looks like I didn't save my work when I did a rebase and update of this patch. I'll add to my todo list for next version

> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> > index f62a36dfcd4b..4b5fbae8c563 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -855,6 +855,112 @@ static DEVICE_ATTR_RW(cores_enabled);
> >   WMI_SIMPLE_SHOW(cores_max, "0x%x\n", ASUS_WMI_DEVID_CORES_MAX);
> >   static DEVICE_ATTR_RO(cores_max);
> >   
> > +/* Device memory available to APU */
> > +
> > +static ssize_t apu_mem_show(struct device *dev,
> > + struct device_attribute *attr, char *buf)
> > +{
> > + struct asus_wmi *asus = dev_get_drvdata(dev);
> > + int err;
> > + u32 mem;
> > +
> > + err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_APU_MEM, &mem);
> > + if (err < 0)
> > + return err;
> > +
> > + switch (mem) {
> > + case 256:
> > + mem = 0;
> > + break;
> > + case 258:
> > + mem = 1;
> > + break;
> > + case 259:
> > + mem = 2;
> > + break;
> > + case 260:
> > + mem = 3;
> > + break;
> > + case 261:
> > + mem = 4;
> > + break;
> > + case 262:
> > + mem = 8;
> > + break;
> > + case 263:
> > + mem = 5;
> > + break;
> > + case 264:
> > + mem = 6;
> > + break;
> > + case 265:
> > + mem = 7;
> > + break;
> > + default:
> > + mem = 4;
> > + break;
> > + }
> > +
> > + return sysfs_emit(buf, "%d\n", mem);
> > +}
> > +
> > +static ssize_t apu_mem_store(struct device *dev,
> > +     struct device_attribute *attr,
> > +     const char *buf, size_t count)
> > +{
> > + struct asus_wmi *asus = dev_get_drvdata(dev);
> > + int result, err;
> > + u32 mem;
> > +
> > + result = kstrtou32(buf, 10, &mem);
> > + if (result)
> > + return result;
> > +
> > + switch (mem) {
> > + case 0:
> > + mem = 0;
> > + break;
> > + case 1:
> > + mem = 258;
> > + break;
> > + case 2:
> > + mem = 259;
> > + break;
> > + case 3:
> > + mem = 260;
> > + break;
> > + case 4:
> > + mem = 261;
> > + break;
> > + case 5:
> > + mem = 263;
> > + break;
> > + case 6:
> > + mem = 264;
> > + break;
> > + case 7:
> > + mem = 265;
> > + break;
> > + case 8:
> > + mem = 262;
> 
> Is case 8 a mistake, or intentionally out of order?

Do you mean the `mem = <val>`? Those aren't in order, and I thought it was easier to read if the switch was ordered.

> 
> > + break;
> > + default:
> > + return -EIO;
> > + }
> > +
> > + err = asus_wmi_set_devstate(ASUS_WMI_DEVID_APU_MEM, mem, &result);
> > + if (err) {
> > + pr_warn("Failed to set apu_mem: %d\n", err);
> > + return err;
> > + }
> > +
> > + pr_info("APU memory changed, reboot required\n");
> 
> If you're logging something into the logs for this, I'd say make it more 
> useful.
> 
> "APU memory changed to %d MB"

Agreed. There's probably a few other spots I can do this also.

> 
> > + sysfs_notify(&asus->platform_device->dev.kobj, NULL, "apu_mem");
> 
> So this is a case that the BIOS attributes API I mentioned before would 
> be REALLY useful.  There is a pending_reboot sysfs file that userspace 
> can query to know if a given setting requires a reboot or not.
> 
> Fwupd also uses this attribute to know to delay BIOS updates until the 
> system has been rebooted.

Oh! Yes I'll queue that as an additional patch. There's at least 2 or 3 other spots where that would be good to have.

> > +
> > + return count;
> > +}
> > +static DEVICE_ATTR_RW(apu_mem);
> > +
> >   /* Tablet mode ****************************************************************/
> >   
> >   static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
> > @@ -4100,6 +4206,7 @@ static struct attribute *platform_attributes[] = {
> >   &dev_attr_panel_fhd.attr,
> >   &dev_attr_cores_enabled.attr,
> >   &dev_attr_cores_max.attr,
> > + &dev_attr_apu_mem.attr,
> >   &dev_attr_mini_led_mode.attr,
> >   &dev_attr_available_mini_led_mode.attr,
> >   NULL
> > @@ -4176,6 +4283,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
> >   else if (attr == &dev_attr_cores_enabled.attr
> >   || attr == &dev_attr_cores_max.attr)
> >   ok = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CORES_SET);
> > + else if (attr == &dev_attr_apu_mem.attr)
> > + ok = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_APU_MEM);
> >   else if (attr == &dev_attr_mini_led_mode.attr)
> >   ok = asus->mini_led_dev_id != 0;
> >   else if (attr == &dev_attr_available_mini_led_mode.attr)
> > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> > index 5a56e7e97785..efe608861e55 100644
> > --- a/include/linux/platform_data/x86/asus-wmi.h
> > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > @@ -121,6 +121,9 @@
> >    /* Maximum Intel E-core and P-core availability */
> >   #define ASUS_WMI_DEVID_CORES_MAX 0x001200D3
> >   
> > +/* Set the memory available to the APU */
> > +#define ASUS_WMI_DEVID_APU_MEM 0x000600C1
> > +
> >   /* MCU powersave mode */
> >   #define ASUS_WMI_DEVID_MCU_POWERSAVE   0x001200E2
> >   
> 

