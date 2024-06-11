Return-Path: <linux-kernel+bounces-209284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC72190313D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C3D28AD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DA6172BAE;
	Tue, 11 Jun 2024 05:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="MxAgL5J7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZLPgDZSw"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D556433C4;
	Tue, 11 Jun 2024 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083932; cv=none; b=Qi0MxykqKZPbABkmUzy1LFz//mIFSd6Y1M+0gUPVJLXsbwYZQPtOyhg47lhu4Iir5scQwW4qIleBX7ZsLAXOKG4JhKZ3eSeM6fSD3XZpuUGc3ZQm/yAcDiQ4VyaqRXRURkA3LGZuUXonz5MNcNfIXJ/R/tvJANSwohhh+m5/Ed4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083932; c=relaxed/simple;
	bh=u2U/nIsQXihsnyQpm+gt2EBSNlUi/HjRQ5mYzQEGbfQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=FJJFQpIfg+ze3uE7GgK1vn7ZMQaqjo1xYyZZxDqYPxn29CPRvMyhuDbyNzRht6SbuJCqqKyL3xVkw/xrbWVYzg4UlyMScgcudWWSPCWq0VcF4hlK9dXKO3fcaJdAd760oIPl9PkktibatkkSN6QneRu4Jh3HBjpza9TEkSbu8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=MxAgL5J7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZLPgDZSw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6901613800F1;
	Tue, 11 Jun 2024 01:32:08 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Tue, 11 Jun 2024 01:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718083928; x=1718170328; bh=EY2KLqHw7h
	7zEwaWpg4jQ9kWyeLRsbn8gKaf04sD43U=; b=MxAgL5J7BqKfXenzWNzdVTGDXf
	frWnYBRYum9fTTYxpkB33E3eRw+/J4wmZsRrNGgZU88hWOsuoCxoM+JXkqWE6tNG
	6Ti2/32s4yzlbxie2/t2Qfy7tPgXDfGEizKBdRtSV1oKqo2c7yBe/qL5zgce53dq
	hSE3pJd+rNJTgSTnA+VYkApbxcJq6Sj3wUCOPwwNJQmnFQhMIWf3u6NaSG1jbyum
	j7vTDCeEd/WYFAnce6mlJewo2rhxed4lpmnITuHyFHLVQUoQ/vFL7jw1fmQM6RWe
	Ofi96Shr3HnlIhX23tu/xBk94EIJ8khEaeqMEJ5so+BWXl4JK20vDUXH/CLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718083928; x=1718170328; bh=EY2KLqHw7h7zEwaWpg4jQ9kWyeLR
	sbn8gKaf04sD43U=; b=ZLPgDZSw6pLEoCaUgJ3J24ujoyyBX8a/uGBK9i8pQf7q
	6cm6JlftTfCb5DgXNpjbNaFtq+QSwzZkBr1N1VoISYXWdMMLE/li99mQJVVyyi+n
	V8QSz39ksIQWnrWypzFXhqKwY65x7dMa49sgtCo7Rp4HUakdvN9D9n+DIoqE5uk6
	rHOYrD5/IPykgWOeiPkBRI6SJS68KiXsrLHMx6toV6f2dGU52POXzJ7qOwEP+JS+
	1V5sU7c3BHZgKWDCcQGwa2i3PV54TrgUElnPi4IyRyIlhJTESWieNom+2sRFXQyj
	vUUZVhhn2jd4q7OgyNGC3/WFtjaBljUeXHefcrXHeA==
X-ME-Sender: <xms:V-FnZgzPR_FvWqSPFLeiHSHunLzeiFQ705lCaynu6QOK4d87IdDfQQ>
    <xme:V-FnZkQMns67w5xTYKTetmr-czu_RxXjTN_E55_CBryN3kTsfmMAZfry97BABLD3Q
    qDoj-C-ho85rBEdFFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduuddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpedutdelgfdvgeekueeuteevffelfedukeeitedugfdvtdeutdetjeduudeuvdeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:V-FnZiWpYDbGcrzh19yL7f_s8YfrzaYQ1oTHvHFb0qC32xWR5N9Opg>
    <xmx:V-FnZuiuHkiQ0jRmBwYPBmA9voSEOCysIVa0fOdo7EjsZ7tBLc0urg>
    <xmx:V-FnZiCtWPCTEb8fYwmtJ8P_sI3lDPvwFIyyV_CRzR1xELmZTWF9yA>
    <xmx:V-FnZvISs9s7iLOukJh2WzTl9RxEgcT3tt7ecTZYthOe2118hTAZaA>
    <xmx:WOFnZl_fCOJZ5dw_pzZwTqyjtWboH8VU8eqzmBDjQASgkFlvtjvmBwRK>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 30E3B2340080; Tue, 11 Jun 2024 01:32:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9daef2c6-6df4-4f61-966c-239450de7b4e@app.fastmail.com>
In-Reply-To: <20240609144849.2532-2-mohamed.ghanmi@supcom.tn>
References: <20240609144849.2532-1-mohamed.ghanmi@supcom.tn>
 <20240609144849.2532-2-mohamed.ghanmi@supcom.tn>
Date: Tue, 11 Jun 2024 17:31:46 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Mohamed Ghanmi" <mohamed.ghanmi@supcom.tn>,
 "Hans de Goede" <hdegoede@redhat.com>
Cc: corentin.chary@gmail.com,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] platform/x86: asus-wmi: add support for vivobook fan
 profiles
Content-Type: text/plain



On Mon, 10 Jun 2024, at 2:48 AM, Mohamed Ghanmi wrote:
> Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
> to adjust power limits.
> 
> These fan profiles have a different device id than the ROG series
> and different order. This reorders the existing modes.
> 
> As part of keeping the patch clean the throttle_thermal_policy_available
> boolean stored in the driver struct is removed and
> throttle_thermal_policy_dev is used in place (as on init it is zeroed).
> 
> Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> Co-developed-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
> drivers/platform/x86/asus-wmi.c            | 125 ++++++++++++---------
> include/linux/platform_data/x86/asus-wmi.h |   1 +
> 2 files changed, 76 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 3c61d75a3..2e3d8d8fb 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -97,6 +97,12 @@ module_param(fnlock_default, bool, 0444);
> #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST 1
> #define ASUS_THROTTLE_THERMAL_POLICY_SILENT 2
>  
> +#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO 0
> +#define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO 1
> +#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO 2
> +
> +#define PLATFORM_PROFILE_MAX 2
> +
> #define USB_INTEL_XUSB2PR 0xD0
> #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI 0x9c31
>  
> @@ -293,8 +299,8 @@ struct asus_wmi {
> u32 kbd_rgb_dev;
> bool kbd_rgb_state_available;
>  
> - bool throttle_thermal_policy_available;
> u8 throttle_thermal_policy_mode;
> + u32 throttle_thermal_policy_dev;
>  
> bool cpu_fan_curve_available;
> bool gpu_fan_curve_available;
> @@ -3152,7 +3158,7 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
> int err, fan_idx;
> u8 mode = 0;
>  
> - if (asus->throttle_thermal_policy_available)
> + if (asus->throttle_thermal_policy_dev)
> mode = asus->throttle_thermal_policy_mode;
> /* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
> if (mode == 2)
> @@ -3359,7 +3365,7 @@ static ssize_t fan_curve_enable_store(struct device *dev,
> * For machines with throttle this is the only way to reset fans
> * to default mode of operation (does not erase curve data).
> */
> - if (asus->throttle_thermal_policy_available) {
> + if (asus->throttle_thermal_policy_dev) {
> err = throttle_thermal_policy_write(asus);
> if (err)
> return err;
> @@ -3576,8 +3582,8 @@ static const struct attribute_group asus_fan_curve_attr_group = {
> __ATTRIBUTE_GROUPS(asus_fan_curve_attr);
>  
> /*
> - * Must be initialised after throttle_thermal_policy_check_present() as
> - * we check the status of throttle_thermal_policy_available during init.
> + * Must be initialised after throttle_thermal_policy_dev is set as
> + * we check the status of throttle_thermal_policy_dev during init.
>   */
> static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
> {
> @@ -3618,38 +3624,13 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
> }
>  
> /* Throttle thermal policy ****************************************************/
> -
> -static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
> -{
> - u32 result;
> - int err;
> -
> - asus->throttle_thermal_policy_available = false;
> -
> - err = asus_wmi_get_devstate(asus,
> -     ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> -     &result);
> - if (err) {
> - if (err == -ENODEV)
> - return 0;
> - return err;
> - }
> -
> - if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
> - asus->throttle_thermal_policy_available = true;
> -
> - return 0;
> -}
> -
> static int throttle_thermal_policy_write(struct asus_wmi *asus)
> {
> - int err;
> - u8 value;
> + u8 value = asus->throttle_thermal_policy_mode;
> u32 retval;
> + int err;
>  
> - value = asus->throttle_thermal_policy_mode;
> -
> - err = asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> + err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
>     value, &retval);
>  
> sysfs_notify(&asus->platform_device->dev.kobj, NULL,
> @@ -3679,7 +3660,7 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
>  
> static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
> {
> - if (!asus->throttle_thermal_policy_available)
> + if (!asus->throttle_thermal_policy_dev)
> return 0;
>  
> asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> @@ -3691,7 +3672,7 @@ static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
> u8 new_mode = asus->throttle_thermal_policy_mode + 1;
> int err;
>  
> - if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> + if (new_mode > PLATFORM_PROFILE_MAX)
> new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>  
> asus->throttle_thermal_policy_mode = new_mode;
> @@ -3730,7 +3711,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
> if (result < 0)
> return result;
>  
> - if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> + if (new_mode > PLATFORM_PROFILE_MAX)
> return -EINVAL;
>  
> asus->throttle_thermal_policy_mode = new_mode;
> @@ -3747,10 +3728,56 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
> return count;
> }
>  
> -// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> +/*
> + * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> + */
> static DEVICE_ATTR_RW(throttle_thermal_policy);
>  
> /* Platform profile ***********************************************************/
> +static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus,
> +   int mode)

Given the internals of this function I'm still not sure if this naming makes sense. Perhaps "maybe_platform_profile_to_vivo()"

> +{
> + bool vivo;
> +
> + vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> +
> + if (vivo) {
> + switch (mode) {
> + case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> + return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
> + case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
> + return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
> + case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
> + return ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
> + }
> + }
> +
> + return mode;
> +
> +}
> +
> +static int asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus,
> +   int mode)

Same as the last function.

> +{
> + bool vivo;
> +
> + vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> +
> + if (vivo) {
> + switch (mode) {
> + case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO:
> + return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> + case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO:
> + return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> + case ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO:
> + return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> + }
> + }
> +
> + return mode;
> +
> +}
> +
> static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> enum platform_profile_option *profile)
> {
> @@ -3758,10 +3785,9 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> int tp;
>  
> asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
> -
> tp = asus->throttle_thermal_policy_mode;
>  
> - switch (tp) {
> + switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
> case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> *profile = PLATFORM_PROFILE_BALANCED;
> break;
> @@ -3775,6 +3801,7 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> return -EINVAL;
> }
>  
> +
> return 0;
> }
>  
> @@ -3800,7 +3827,7 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> return -EOPNOTSUPP;
> }
>  
> - asus->throttle_thermal_policy_mode = tp;
> + asus->throttle_thermal_policy_mode = asus_wmi_platform_profile_to_vivo(asus, tp);
> return throttle_thermal_policy_write(asus);
> }
>  
> @@ -3813,7 +3840,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
> * Not an error if a component platform_profile relies on is unavailable
> * so early return, skipping the setup of platform_profile.
> */
> - if (!asus->throttle_thermal_policy_available)
> + if (!asus->throttle_thermal_policy_dev)
> return 0;
>  
> dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
> @@ -4228,7 +4255,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
> if (code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_TTP) {
> if (asus->fan_boost_mode_available)
> fan_boost_mode_switch_next(asus);
> - if (asus->throttle_thermal_policy_available)
> + if (asus->throttle_thermal_policy_dev)
> throttle_thermal_policy_switch_next(asus);
> return;
>  
> @@ -4436,7 +4463,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
> else if (attr == &dev_attr_fan_boost_mode.attr)
> ok = asus->fan_boost_mode_available;
> else if (attr == &dev_attr_throttle_thermal_policy.attr)
> - ok = asus->throttle_thermal_policy_available;
> + ok = asus->throttle_thermal_policy_dev != 0;
> else if (attr == &dev_attr_ppt_pl2_sppt.attr)
> devid = ASUS_WMI_DEVID_PPT_PL2_SPPT;
> else if (attr == &dev_attr_ppt_pl1_spl.attr)
> @@ -4745,16 +4772,15 @@ static int asus_wmi_add(struct platform_device *pdev)
> else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
> asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
>  
> + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
> + asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY;
> + else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO))
> + asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> +
> err = fan_boost_mode_check_present(asus);
> if (err)
> goto fail_fan_boost_mode;
>  
> - err = throttle_thermal_policy_check_present(asus);
> - if (err)
> - goto fail_throttle_thermal_policy;
> - else
> - throttle_thermal_policy_set_default(asus);
> -
> err = platform_profile_setup(asus);
> if (err)
> goto fail_platform_profile_setup;
> @@ -4849,7 +4875,6 @@ static int asus_wmi_add(struct platform_device *pdev)
> fail_input:
> asus_wmi_sysfs_exit(asus->platform_device);
> fail_sysfs:
> -fail_throttle_thermal_policy:
> fail_custom_fan_curve:
> fail_platform_profile_setup:
> if (asus->platform_profile_support)
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 3eb5cd677..982a63774 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -64,6 +64,7 @@
> #define ASUS_WMI_DEVID_SCREENPAD_LIGHT 0x00050032
> #define ASUS_WMI_DEVID_FAN_BOOST_MODE 0x00110018
> #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
> +#define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
>  
> /* Misc */
> #define ASUS_WMI_DEVID_PANEL_OD 0x00050019
> -- 
> 2.44.0
> 
 
If Hans and Ilpo don't have any requirements then:

Signed-off-by: Luke D. Jones <luke@ljones.dev>


