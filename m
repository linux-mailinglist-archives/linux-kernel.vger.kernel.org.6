Return-Path: <linux-kernel+bounces-334762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1084297DBD9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 08:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B31B2164D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 06:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08AC14A0AB;
	Sat, 21 Sep 2024 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="pZpO0Vv/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O4P17CBb"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFBD74BF8;
	Sat, 21 Sep 2024 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726900074; cv=none; b=pLmRjTaWTsUHGhAZ8mReAZ9bSrTeLLPNlBPSVfVyjPdowNxvWTp4BZsJsFdbNRVhApB2m4QQCFo8S3RGpYlMylBii9Hyi23Nnu8d9jp5z0JRWjyufUehy16RmYhxFTHmJPAZmGkfbk03s5unpPXKCPPifz3v0yL7AFPZDtHfYDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726900074; c=relaxed/simple;
	bh=Tjk3DzOnpWkTBgDKcGo9FUnx8vXtlguKr3RMAwVmHk8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rroKUMguCB6DQ20AkLSFGCICxSoESB2/EKXuiTURGO9NQ0qnl1klDflcOvm7PNDqZ+snLDy+9gaMW2y1HDMA4jc1MyBprF1JgVNGOyD5VEYrwS9uk71aYocmqYcLL7xhjlo2D3u6yQVNk/chiDCAPBF1TKc4OoCcYd4SA1536Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=pZpO0Vv/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O4P17CBb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84AA911402C7;
	Sat, 21 Sep 2024 02:27:49 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-08.internal (MEProxy); Sat, 21 Sep 2024 02:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726900069;
	 x=1726986469; bh=r3IMFxWzX2Ta3KaCZRl+oxGVC27/aKgfsXEOsCP5q+w=; b=
	pZpO0Vv/CG/3ng1SNSa3gVO7hFLAO/AkXaM8HtXtoAv7f0rqQwJoD1KJbEJQ6939
	qH7XJ5dMipCMPL1BG0OL+kUNHcJoCe3RxKq9JFDxRro18CyXducmr2/IYTD3Iq0r
	BcmPBOriBRuCYIYJP+j90Dw4wGOeVMQFF728exGD2TV/uUZQJbTSh5HDXFic05f6
	GlT0QXApv5klcEAzKuDfLfzQr0jLP/sP56mVCJKgXm6UmV5qCjVdPCckVRfevRvX
	iYdmjNNSx6f9dXaGIezUWN7nUh1KbceNWqQnYz1mIwCyKJjZshHzyXH8bf+Q9yso
	TrkmaPH/VJL89cJxQjud3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1726900069; x=
	1726986469; bh=r3IMFxWzX2Ta3KaCZRl+oxGVC27/aKgfsXEOsCP5q+w=; b=O
	4P17CBbLGoj7HNhF8ZjyPNArjGq8iRr49CUqCPDW34Hsj1INZp4D6ZOhSZqOYgkn
	B2a7vV5nNd7Qc8HS1RDpazvsZYEIkA/TLCurSEnkIAwnWjJJQ0kc3vDvcPxqwXuI
	dRh9UIEXBiPgrdbHHmF2UPyROXxCo0zGEEWM5L9G2oSvZs4vZzx5orTil02Yybte
	vfvDGfJ7Y8ZqiD7ObV5ClSDDXxAJQVpaJIm0GRjzxpQifrJPkTNKtaJ1RuBHRQYC
	4GW1rVwQwh6FxJ8n62HAFs+IfSUYC0xfb8md00Qvnb4lv1GGwnpjjkypo1fGFwBm
	u5hGQHowLRkiUetX70XXQ==
X-ME-Sender: <xms:ZGfuZtNmzSO-xaaDmMHTztRkAW6-pS_mpSS88PMbLRfOFffDbZLINw>
    <xme:ZGfuZv91UNWsATafWdWN3tlV-BoXYQDWTordMxPt0iW7wJNblOLcWzjUstGLNuhT1
    Szp04mpw6KZGrrfxO0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelgedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfnuhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdrug
    gvvheqnecuggftrfgrthhtvghrnhepgfeiffehtdfghfettdeiuddtfeekvdejgfevhefh
    ffevtdfhjeelgeefffekvdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtih
    gvlhhlohesrghmugdrtghomhdprhgtphhtthhopegtohhrvghnthhinhdrtghhrghrhies
    ghhmrghilhdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuh
    igrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZGfuZsSvuf3y51IDtdkCrK4qjekflV1euiAbSCFeeUFcJi3_bKGPiQ>
    <xmx:ZGfuZptajSEMyTG6ZBRFqywp2bgNos9M6gBVm6OwTVTr-wAZcymdxw>
    <xmx:ZGfuZleavnVJqzT6dVENEplkMoXftiyAQHKmK8fZnzf4mSoinUkP-A>
    <xmx:ZGfuZl197Js16-1tdKwkSerxgavHvmmnEDIfoybrRCqrI_qrPrft4g>
    <xmx:ZWfuZs5TPJoZjLZ4wn0jMrENNdQ-vgKSGgl0S8fvqFWUycLi48Wmhspi>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A2AF3336007E; Sat, 21 Sep 2024 02:27:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 21 Sep 2024 18:27:27 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Mario Limonciello" <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 corentin.chary@gmail.com
Message-Id: <c6fd6cd4-e6c6-4730-a1cc-8928f08df640@app.fastmail.com>
In-Reply-To: <f521c423-62fd-4c03-91d3-3bf292ad1714@amd.com>
References: <20240918094250.82430-1-luke@ljones.dev>
 <20240918094250.82430-6-luke@ljones.dev>
 <f521c423-62fd-4c03-91d3-3bf292ad1714@amd.com>
Subject: Re: [PATCH v3 5/5] platform/x86: asus-wmi: deprecate bios features
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024, at 3:50 AM, Mario Limonciello wrote:
> On 9/18/2024 04:42, Luke D. Jones wrote:
> > With the existence of the asus-bioscfg module the attributes no-longer
> > need to live under the /sys/devices/platform/asus-nb-wmi/ path.
> > 
> > Deprecate all those that were implemented in asus-bioscfg with the goal
> > of removing them fully in the next LTS cycle.
> > 
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >   .../ABI/testing/sysfs-platform-asus-wmi       |  17 +++
> >   drivers/platform/x86/Kconfig                  |   8 ++
> >   drivers/platform/x86/asus-wmi.c               | 134 ++++++++++++++----
> >   3 files changed, 129 insertions(+), 30 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > index 28144371a0f1..765d50b0d9df 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > @@ -63,6 +63,7 @@ Date: Aug 2022
> >   KernelVersion: 6.1
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Switch the GPU hardware MUX mode. Laptops with this feature can
> >   can be toggled to boot with only the dGPU (discrete mode) or in
> >   standard Optimus/Hybrid mode. On switch a reboot is required:
> > @@ -75,6 +76,7 @@ Date: Aug 2022
> >   KernelVersion: 5.17
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Disable discrete GPU:
> >   * 0 - Enable dGPU,
> >   * 1 - Disable dGPU
> > @@ -84,6 +86,7 @@ Date: Aug 2022
> >   KernelVersion: 5.17
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Enable the external GPU paired with ROG X-Flow laptops.
> >   Toggling this setting will also trigger ACPI to disable the dGPU:
> >   
> > @@ -95,6 +98,7 @@ Date: Aug 2022
> >   KernelVersion: 5.17
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Enable an LCD response-time boost to reduce or remove ghosting:
> >   * 0 - Disable,
> >   * 1 - Enable
> > @@ -104,6 +108,7 @@ Date: Jun 2023
> >   KernelVersion: 6.5
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Get the current charging mode being used:
> >   * 1 - Barrel connected charger,
> >   * 2 - USB-C charging
> > @@ -114,6 +119,7 @@ Date: Jun 2023
> >   KernelVersion: 6.5
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Show if the egpu (XG Mobile) is correctly connected:
> >   * 0 - False,
> >   * 1 - True
> > @@ -123,6 +129,7 @@ Date: Jun 2023
> >   KernelVersion: 6.5
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Change the mini-LED mode:
> >   * 0 - Single-zone,
> >   * 1 - Multi-zone
> > @@ -133,6 +140,7 @@ Date: Apr 2024
> >   KernelVersion: 6.10
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   List the available mini-led modes.
> >   
> >   What: /sys/devices/platform/<platform>/ppt_pl1_spl
> > @@ -140,6 +148,7 @@ Date: Jun 2023
> >   KernelVersion: 6.5
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Set the Package Power Target total of CPU: PL1 on Intel, SPL on AMD.
> >   Shown on Intel+Nvidia or AMD+Nvidia based systems:
> >   
> > @@ -150,6 +159,7 @@ Date: Jun 2023
> >   KernelVersion: 6.5
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Set the Slow Package Power Tracking Limit of CPU: PL2 on Intel, SPPT,
> >   on AMD. Shown on Intel+Nvidia or AMD+Nvidia based systems:
> >   
> > @@ -160,6 +170,7 @@ Date: Jun 2023
> >   KernelVersion: 6.5
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Set the Fast Package Power Tracking Limit of CPU. AMD+Nvidia only:
> >   * min=5, max=250
> >   
> > @@ -168,6 +179,7 @@ Date: Jun 2023
> >   KernelVersion: 6.5
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Set the APU SPPT limit. Shown on full AMD systems only:
> >   * min=5, max=130
> >   
> > @@ -176,6 +188,7 @@ Date: Jun 2023
> >   KernelVersion: 6.5
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Set the platform SPPT limit. Shown on full AMD systems only:
> >   * min=5, max=130
> >   
> > @@ -184,6 +197,7 @@ Date: Jun 2023
> >   KernelVersion: 6.5
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Set the dynamic boost limit of the Nvidia dGPU:
> >   * min=5, max=25
> >   
> > @@ -192,6 +206,7 @@ Date: Jun 2023
> >   KernelVersion: 6.5
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Set the target temperature limit of the Nvidia dGPU:
> >   * min=75, max=87
> >   
> > @@ -200,6 +215,7 @@ Date: Apr 2024
> >   KernelVersion: 6.10
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Set if the BIOS POST sound is played on boot.
> >   * 0 - False,
> >   * 1 - True
> > @@ -209,6 +225,7 @@ Date: Apr 2024
> >   KernelVersion: 6.10
> >   Contact: "Luke Jones" <luke@ljones.dev>
> >   Description:
> > +        DEPRECATED, WILL BE REMOVED SOON
> >   Set if the MCU can go in to low-power mode on system sleep
> >   * 0 - False,
> >   * 1 - True
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index d13c4085c228..01f780d53793 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -301,6 +301,14 @@ config ASUS_WMI
> >     To compile this driver as a module, choose M here: the module will
> >     be called asus-wmi.
> >   
> > +config ASUS_WMI_BIOS
> 
> Elsewhere in the kernel they add _DEPRECATED to the Kconfig name.  Thoughts?

I've adjusted to suit. Seems wise.

> > + bool "BIOS option support in WMI platform (DEPRECATED)"
> > + depends on ASUS_WMI
> > + help
> > +   Say Y to expose the configurable BIOS options through the asus-wmi
> > +   driver. This can be used with or without the new asus-bios driver as
> 
> Isn't it asus-armoury?

Yes, fixed.
 
> > +   the options are the same but the asus-bios driver has more features.
> > +
> >   config ASUS_NB_WMI
> >   tristate "Asus Notebook WMI Driver"
> >   depends on ASUS_WMI
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> > index d265ef0d7aba..edb00485e8c3 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -276,11 +276,12 @@ struct asus_wmi {
> >   u8 fan_boost_mode_mask;
> >   u8 fan_boost_mode;
> >   
> > +
> > + /* Tunables provided by ASUS for gaming laptops */
> > + #if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> >   bool egpu_enable_available;
> >   bool dgpu_disable_available;
> >   u32 gpu_mux_dev;
> > -
> > - /* Tunables provided by ASUS for gaming laptops */
> >   u32 ppt_pl2_sppt;
> >   u32 ppt_pl1_spl;
> >   u32 ppt_apu_sppt;
> > @@ -288,6 +289,9 @@ struct asus_wmi {
> >   u32 ppt_fppt;
> >   u32 nv_dynamic_boost;
> >   u32 nv_temp_target;
> > + bool panel_overdrive_available;
> > + u32 mini_led_dev_id;
> > + #endif
> >   
> >   u32 kbd_rgb_dev;
> >   bool kbd_rgb_state_available;
> > @@ -306,9 +310,6 @@ struct asus_wmi {
> >   // The RSOC controls the maximum charging percentage.
> >   bool battery_rsoc_available;
> >   
> > - bool panel_overdrive_available;
> > - u32 mini_led_dev_id;
> > -
> >   struct hotplug_slot hotplug_slot;
> >   struct mutex hotplug_lock;
> >   struct mutex wmi_lock;
> > @@ -322,6 +323,15 @@ struct asus_wmi {
> >   struct asus_wmi_driver *driver;
> >   };
> >   
> > +#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> > +static void asus_wmi_show_deprecated(void)
> > +{
> > + pr_notice_once("Accessing attributes through /sys/bus/platform/asus_wmi "
> > + "is deprecated and will be removed in a future release. Please "
> > + "switch over to /sys/class/firmware_attributes.\n");
> > +}
> > +#endif
> > +
> >   /* WMI ************************************************************************/
> >   
> >   static int asus_wmi_evaluate_method3(u32 method_id,
> > @@ -720,6 +730,7 @@ static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
> >   }
> >   
> >   /* Charging mode, 1=Barrel, 2=USB ******************************************/
> > +#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> >   static ssize_t charge_mode_show(struct device *dev,
> >      struct device_attribute *attr, char *buf)
> >   {
> > @@ -730,12 +741,16 @@ static ssize_t charge_mode_show(struct device *dev,
> >   if (result < 0)
> >   return result;
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%d\n", value & 0xff);
> >   }
> >   
> >   static DEVICE_ATTR_RO(charge_mode);
> > +#endif
> >   
> >   /* dGPU ********************************************************************/
> > +#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> >   static ssize_t dgpu_disable_show(struct device *dev,
> >      struct device_attribute *attr, char *buf)
> >   {
> > @@ -746,6 +761,8 @@ static ssize_t dgpu_disable_show(struct device *dev,
> >   if (result < 0)
> >   return result;
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%d\n", result);
> >   }
> >   
> > @@ -799,8 +816,10 @@ static ssize_t dgpu_disable_store(struct device *dev,
> >   return count;
> >   }
> >   static DEVICE_ATTR_RW(dgpu_disable);
> > +#endif
> >   
> >   /* eGPU ********************************************************************/
> > +#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> >   static ssize_t egpu_enable_show(struct device *dev,
> >      struct device_attribute *attr, char *buf)
> >   {
> > @@ -811,6 +830,8 @@ static ssize_t egpu_enable_show(struct device *dev,
> >   if (result < 0)
> >   return result;
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%d\n", result);
> >   }
> >   
> > @@ -867,8 +888,10 @@ static ssize_t egpu_enable_store(struct device *dev,
> >   return count;
> >   }
> >   static DEVICE_ATTR_RW(egpu_enable);
> > +#endif
> >   
> >   /* Is eGPU connected? *********************************************************/
> > +#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> >   static ssize_t egpu_connected_show(struct device *dev,
> >      struct device_attribute *attr, char *buf)
> >   {
> > @@ -879,12 +902,16 @@ static ssize_t egpu_connected_show(struct device *dev,
> >   if (result < 0)
> >   return result;
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%d\n", result);
> >   }
> >   
> >   static DEVICE_ATTR_RO(egpu_connected);
> > +#endif
> >   
> >   /* gpu mux switch *************************************************************/
> > +#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> >   static ssize_t gpu_mux_mode_show(struct device *dev,
> >   struct device_attribute *attr, char *buf)
> >   {
> > @@ -895,6 +922,8 @@ static ssize_t gpu_mux_mode_show(struct device *dev,
> >   if (result < 0)
> >   return result;
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%d\n", result);
> >   }
> >   
> > @@ -953,6 +982,7 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
> >   return count;
> >   }
> >   static DEVICE_ATTR_RW(gpu_mux_mode);
> > +#endif
> >   
> >   /* TUF Laptop Keyboard RGB Modes **********************************************/
> >   static ssize_t kbd_rgb_mode_store(struct device *dev,
> > @@ -1076,6 +1106,7 @@ static const struct attribute_group *kbd_rgb_mode_groups[] = {
> >   };
> >   
> >   /* Tunable: PPT: Intel=PL1, AMD=SPPT *****************************************/
> > +#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> >   static ssize_t ppt_pl2_sppt_store(struct device *dev,
> >       struct device_attribute *attr,
> >       const char *buf, size_t count)
> > @@ -1114,6 +1145,8 @@ static ssize_t ppt_pl2_sppt_show(struct device *dev,
> >   {
> >   struct asus_wmi *asus = dev_get_drvdata(dev);
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%u\n", asus->ppt_pl2_sppt);
> >   }
> >   static DEVICE_ATTR_RW(ppt_pl2_sppt);
> > @@ -1156,6 +1189,8 @@ static ssize_t ppt_pl1_spl_show(struct device *dev,
> >   {
> >   struct asus_wmi *asus = dev_get_drvdata(dev);
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%u\n", asus->ppt_pl1_spl);
> >   }
> >   static DEVICE_ATTR_RW(ppt_pl1_spl);
> > @@ -1199,6 +1234,8 @@ static ssize_t ppt_fppt_show(struct device *dev,
> >   {
> >   struct asus_wmi *asus = dev_get_drvdata(dev);
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%u\n", asus->ppt_fppt);
> >   }
> >   static DEVICE_ATTR_RW(ppt_fppt);
> > @@ -1242,6 +1279,8 @@ static ssize_t ppt_apu_sppt_show(struct device *dev,
> >   {
> >   struct asus_wmi *asus = dev_get_drvdata(dev);
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%u\n", asus->ppt_apu_sppt);
> >   }
> >   static DEVICE_ATTR_RW(ppt_apu_sppt);
> > @@ -1285,6 +1324,8 @@ static ssize_t ppt_platform_sppt_show(struct device *dev,
> >   {
> >   struct asus_wmi *asus = dev_get_drvdata(dev);
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%u\n", asus->ppt_platform_sppt);
> >   }
> >   static DEVICE_ATTR_RW(ppt_platform_sppt);
> > @@ -1328,6 +1369,8 @@ static ssize_t nv_dynamic_boost_show(struct device *dev,
> >   {
> >   struct asus_wmi *asus = dev_get_drvdata(dev);
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%u\n", asus->nv_dynamic_boost);
> >   }
> >   static DEVICE_ATTR_RW(nv_dynamic_boost);
> > @@ -1371,11 +1414,15 @@ static ssize_t nv_temp_target_show(struct device *dev,
> >   {
> >   struct asus_wmi *asus = dev_get_drvdata(dev);
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%u\n", asus->nv_temp_target);
> >   }
> >   static DEVICE_ATTR_RW(nv_temp_target);
> > +#endif
> >   
> >   /* Ally MCU Powersave ********************************************************/
> > +#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> >   static ssize_t mcu_powersave_show(struct device *dev,
> >      struct device_attribute *attr, char *buf)
> >   {
> > @@ -1386,6 +1433,8 @@ static ssize_t mcu_powersave_show(struct device *dev,
> >   if (result < 0)
> >   return result;
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%d\n", result);
> >   }
> >   
> > @@ -1421,6 +1470,7 @@ static ssize_t mcu_powersave_store(struct device *dev,
> >   return count;
> >   }
> >   static DEVICE_ATTR_RW(mcu_powersave);
> > +#endif
> >   
> >   /* Battery ********************************************************************/
> >   
> > @@ -2294,6 +2344,7 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
> >   }
> >   
> >   /* Panel Overdrive ************************************************************/
> > +#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> >   static ssize_t panel_od_show(struct device *dev,
> >      struct device_attribute *attr, char *buf)
> >   {
> > @@ -2304,6 +2355,8 @@ static ssize_t panel_od_show(struct device *dev,
> >   if (result < 0)
> >   return result;
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%d\n", result);
> >   }
> >   
> > @@ -2340,9 +2393,10 @@ static ssize_t panel_od_store(struct device *dev,
> >   return count;
> >   }
> >   static DEVICE_ATTR_RW(panel_od);
> > +#endif
> >   
> >   /* Bootup sound ***************************************************************/
> > -
> > +#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> >   static ssize_t boot_sound_show(struct device *dev,
> >        struct device_attribute *attr, char *buf)
> >   {
> > @@ -2353,6 +2407,8 @@ static ssize_t boot_sound_show(struct device *dev,
> >   if (result < 0)
> >   return result;
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%d\n", result);
> >   }
> >   
> > @@ -2388,8 +2444,10 @@ static ssize_t boot_sound_store(struct device *dev,
> >   return count;
> >   }
> >   static DEVICE_ATTR_RW(boot_sound);
> > +#endif
> >   
> >   /* Mini-LED mode **************************************************************/
> > +#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> >   static ssize_t mini_led_mode_show(struct device *dev,
> >      struct device_attribute *attr, char *buf)
> >   {
> > @@ -2420,6 +2478,8 @@ static ssize_t mini_led_mode_show(struct device *dev,
> >   }
> >   }
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "%d\n", value);
> >   }
> >   
> > @@ -2490,10 +2550,13 @@ static ssize_t available_mini_led_mode_show(struct device *dev,
> >   return sysfs_emit(buf, "0 1 2\n");
> >   }
> >   
> > + asus_wmi_show_deprecated();
> > +
> >   return sysfs_emit(buf, "0\n");
> >   }
> >   
> >   static DEVICE_ATTR_RO(available_mini_led_mode);
> > +#endif
> >   
> >   /* Quirks *********************************************************************/
> >   
> > @@ -3792,6 +3855,7 @@ static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
> >   return 0;
> >   }
> >   
> > +#if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> >   static ssize_t throttle_thermal_policy_show(struct device *dev,
> >      struct device_attribute *attr, char *buf)
> >   {
> > @@ -3835,6 +3899,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
> >    * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> >    */
> >   static DEVICE_ATTR_RW(throttle_thermal_policy);
> > +#endif
> >   
> >   /* Platform profile ***********************************************************/
> >   static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus, int mode)
> > @@ -4475,27 +4540,29 @@ static struct attribute *platform_attributes[] = {
> >   &dev_attr_camera.attr,
> >   &dev_attr_cardr.attr,
> >   &dev_attr_touchpad.attr,
> > - &dev_attr_charge_mode.attr,
> > - &dev_attr_egpu_enable.attr,
> > - &dev_attr_egpu_connected.attr,
> > - &dev_attr_dgpu_disable.attr,
> > - &dev_attr_gpu_mux_mode.attr,
> >   &dev_attr_lid_resume.attr,
> >   &dev_attr_als_enable.attr,
> >   &dev_attr_fan_boost_mode.attr,
> > - &dev_attr_throttle_thermal_policy.attr,
> > - &dev_attr_ppt_pl2_sppt.attr,
> > - &dev_attr_ppt_pl1_spl.attr,
> > - &dev_attr_ppt_fppt.attr,
> > - &dev_attr_ppt_apu_sppt.attr,
> > - &dev_attr_ppt_platform_sppt.attr,
> > - &dev_attr_nv_dynamic_boost.attr,
> > - &dev_attr_nv_temp_target.attr,
> > - &dev_attr_mcu_powersave.attr,
> > - &dev_attr_boot_sound.attr,
> > - &dev_attr_panel_od.attr,
> > - &dev_attr_mini_led_mode.attr,
> > - &dev_attr_available_mini_led_mode.attr,
> > + #if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> > + &dev_attr_charge_mode.attr,
> > + &dev_attr_egpu_enable.attr,
> > + &dev_attr_egpu_connected.attr,
> > + &dev_attr_dgpu_disable.attr,
> > + &dev_attr_gpu_mux_mode.attr,
> > + &dev_attr_ppt_pl2_sppt.attr,
> > + &dev_attr_ppt_pl1_spl.attr,
> > + &dev_attr_ppt_fppt.attr,
> > + &dev_attr_ppt_apu_sppt.attr,
> > + &dev_attr_ppt_platform_sppt.attr,
> > + &dev_attr_nv_dynamic_boost.attr,
> > + &dev_attr_nv_temp_target.attr,
> > + &dev_attr_mcu_powersave.attr,
> > + &dev_attr_boot_sound.attr,
> > + &dev_attr_panel_od.attr,
> > + &dev_attr_mini_led_mode.attr,
> > + &dev_attr_available_mini_led_mode.attr,
> > + &dev_attr_throttle_thermal_policy.attr,
> > + #endif
> >   NULL
> >   };
> >   
> > @@ -4517,7 +4584,11 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
> >   devid = ASUS_WMI_DEVID_LID_RESUME;
> >   else if (attr == &dev_attr_als_enable.attr)
> >   devid = ASUS_WMI_DEVID_ALS_ENABLE;
> > - else if (attr == &dev_attr_charge_mode.attr)
> > + else if (attr == &dev_attr_fan_boost_mode.attr)
> > + ok = asus->fan_boost_mode_available;
> > +
> > + #if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> > + if (attr == &dev_attr_charge_mode.attr)
> >   devid = ASUS_WMI_DEVID_CHARGE_MODE;
> >   else if (attr == &dev_attr_egpu_enable.attr)
> >   ok = asus->egpu_enable_available;
> > @@ -4555,6 +4626,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
> >   ok = asus->mini_led_dev_id != 0;
> >   else if (attr == &dev_attr_available_mini_led_mode.attr)
> >   ok = asus->mini_led_dev_id != 0;
> > + #endif
> >   
> >   if (devid != -1) {
> >   ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
> > @@ -4795,6 +4867,7 @@ static int asus_wmi_add(struct platform_device *pdev)
> >   goto fail_platform;
> >   
> >   /* ensure defaults for tunables */
> > + #if IS_ENABLED(CONFIG_ASUS_WMI_BIOS)
> >   asus->ppt_pl2_sppt = 5;
> >   asus->ppt_pl1_spl = 5;
> >   asus->ppt_apu_sppt = 5;
> > @@ -4818,16 +4891,17 @@ static int asus_wmi_add(struct platform_device *pdev)
> >   else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX_VIVO))
> >   asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX_VIVO;
> >   
> > - if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE))
> > - asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE;
> > - else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
> > - asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
> > -
> > + #endif /* CONFIG_ASUS_WMI_BIOS */
> >   if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
> >   asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY;
> >   else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO))
> >   asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> >   
> > + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE))
> > + asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE;
> > + else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
> > + asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
> > +
> >   err = fan_boost_mode_check_present(asus);
> >   if (err)
> >   goto fail_fan_boost_mode;
> 
> 

