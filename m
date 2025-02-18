Return-Path: <linux-kernel+bounces-519890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46341A3A332
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3794E3A514B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718B522A80F;
	Tue, 18 Feb 2025 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="H3lqZn73";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ns7jMGRP"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F726E658;
	Tue, 18 Feb 2025 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897457; cv=none; b=h0Fw7fKh/obhMgrE83gM123BA9KmDZYZe8ad+qx14a0fC8ay1SggjHoLDhLaskbnO72/A7w1BKsrjjslqyuru5s3O6dPROXQ1wMoH0/wy/DPy7lR6oxjDIUqnyK7ZRAXBfQlaq/TwVIDdt8eKDTYdAC1HocLaFIIb0s4IZyarSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897457; c=relaxed/simple;
	bh=K0dOOSCcf94N/kUXiJglyQYe2jYwQNYoUshwExfewuI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NZWfDaqCHT8JYe8bxBnsJdE7xMEFeCuU1ksorgG+tWUvW3ZgldtAOw32IGgY41f+FaXPxGb8Zv+bpFT+5JpCZBub3wfmQubUpzZ59Rv9s/tyseCWR3ZiEvYUqK3RT/Am5JaGsY6VhOgYTTADJmhTwhJAassi30GmbfQNfEzGyjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=H3lqZn73; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ns7jMGRP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E39013808BC;
	Tue, 18 Feb 2025 11:50:53 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-04.internal (MEProxy); Tue, 18 Feb 2025 11:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1739897453;
	 x=1739983853; bh=p7pvXcz+nJelHwX+jlHgdJlucSENiNqsN9eSnjiFOGY=; b=
	H3lqZn73VbEoh2Z0DGBhKZuAmPfJ+5QuMsL5EGEcHwtJmLkE8DKqXnn2nRw/fyjc
	dcBDsgTZ40faqO5uTn7x7iYw68Fg/lK/VLgN7tuVaZNgz9VqSMB80yLA293id279
	2puoy3SyMqOThgO52N7LB80w3ebaUwoyTzi2UMOUCZDheXYMoDsECat/IrwO0OnU
	T2PyHfBCdJ6bLdc4vB/eQwOL8WyALYb7osQrpXzYDYY6GHGmgIRhPFuz1Ag9b3gp
	SMY++Du4AABp1SqEzRWwQ7do8tB+fHvmzgVm3mmLBgvu4eF2manFrtSjK821G3dZ
	p+E06GoTAUewq0MLTrHnrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739897453; x=
	1739983853; bh=p7pvXcz+nJelHwX+jlHgdJlucSENiNqsN9eSnjiFOGY=; b=N
	s7jMGRPobdgS4aEFzfzaBqiS9ZqCjsyj7XPigoQWcPoXrpJeGwuhW5GHsVZS6dQL
	RwGWShS74AM4RCSEcPWpDzYGZasVpNw0EFMVVx8wAZA++Q7+NxDYZgVZTkKslY3d
	NlXrvPma5X2TSsb7I1xw8jAmkHyYd+2gvK3pbwezwigLdEJOD8xVL+WXKxW88E5a
	GS/VWNwkJXwX9Bfn4lGIaO3THPd8T3USozhL4HdFY4ImD9BQVfIC0fvpiXkrALrb
	Pxdy9UeZ/YLPptpQ+YSE54yHjcRfWfw64YXAadD/0uUvj7JTnJ3StRkVfVNDnAsp
	r4amFw2OCCPCHAKutm+og==
X-ME-Sender: <xms:bLq0Z_TFqWy4luisCgu6g7OFQJaZpLiJRHg5-l-712P753jihdgTGw>
    <xme:bLq0ZwydCCksIpB2soONEf6EAx6s9kwCGn5_Ui778bWM9RPGwAZuIqfL_j9DY5kM-
    EZP3AAnSO-CMT9QXO0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhephfeuvdehteeghedt
    hedtveehuddvjeejgffgieejvdegkefhfeelheekhedvffehnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepkhhuuhhrthgssehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhm
    hheshhhmhhdrvghnghdrsghrpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslh
    hinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehisghmqdgrtghpihdquggvvhgv
    lheslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphhtthhopehhuggvgh
    hovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhlrghtfhhorhhmqdgurh
    hivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bLq0Z03-M1xLYhtyPXO3WYHtckHRmS0IqiRlAwEo6KcEb7ndGUgffA>
    <xmx:bLq0Z_Dge3JsCwLVN07g3g8A_GCYbqI68HDPpO1JIf1BA07QFAe2qQ>
    <xmx:bLq0Z4gqWsR96iWR-tQOaIedAeSTGBz2lp5EKFCdDmZBijrk__fIbg>
    <xmx:bLq0Zzro4EK5bTCbU_Le_BgySoGEWVwNtNULEzWkMlVuZOqs-FRrGw>
    <xmx:bbq0ZzWQpMh-EbHDoGpO14cj1SKPcZkrSxtr4W6jpT5tZemA0DYVTPbP>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3660F3C0066; Tue, 18 Feb 2025 11:50:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Feb 2025 11:50:31 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Kurt Borja" <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <9a98e10c-dd14-45a9-96ec-6ebca8b68616@app.fastmail.com>
In-Reply-To: <20250215000302.19753-3-kuurtb@gmail.com>
References: <20250215000302.19753-1-kuurtb@gmail.com>
 <20250215000302.19753-3-kuurtb@gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: thinkpad_acpi: Move HWMON initialization to
 tpacpi_hwmon_pdriver's probe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Kurt,

On Fri, Feb 14, 2025, at 7:03 PM, Kurt Borja wrote:
> Let the driver core manage the lifetime of the HWMON device, by
> registering it inside tpacpi_hwmon_pdriver's probe and using
> devm_hwmon_device_register_with_groups().
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 44 +++++++++++-----------------
>  1 file changed, 17 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c 
> b/drivers/platform/x86/thinkpad_acpi.c
> index ad9de48cc122..a7e82157bd67 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -367,7 +367,6 @@ static struct {
>  	u32 beep_needs_two_args:1;
>  	u32 mixer_no_level_control:1;
>  	u32 battery_force_primary:1;
> -	u32 sensors_pdrv_registered:1;
>  	u32 hotkey_poll_active:1;
>  	u32 has_adaptive_kbd:1;
>  	u32 kbd_lang:1;
> @@ -11815,12 +11814,10 @@ static void thinkpad_acpi_module_exit(void)
>  {
>  	tpacpi_lifecycle = TPACPI_LIFE_EXITING;
> 
> -	if (tpacpi_hwmon)
> -		hwmon_device_unregister(tpacpi_hwmon);
> -	if (tp_features.sensors_pdrv_registered)
> +	if (tpacpi_sensors_pdev) {
>  		platform_driver_unregister(&tpacpi_hwmon_pdriver);
> -	if (tpacpi_sensors_pdev)
>  		platform_device_unregister(tpacpi_sensors_pdev);
> +	}
> 
>  	if (tpacpi_pdev) {
>  		platform_driver_unregister(&tpacpi_pdriver);
> @@ -11891,6 +11888,17 @@ static int __init tpacpi_pdriver_probe(struct 
> platform_device *pdev)
>  	return ret;
>  }
> 
> +static int __init tpacpi_hwmon_pdriver_probe(struct platform_device *pdev)
> +{
> +	tpacpi_hwmon = devm_hwmon_device_register_with_groups(
> +		&tpacpi_sensors_pdev->dev, TPACPI_NAME, NULL, tpacpi_hwmon_groups);
> +
> +	if (IS_ERR(tpacpi_hwmon))
> +		pr_err("unable to register hwmon device\n");
> +
> +	return PTR_ERR_OR_ZERO(tpacpi_hwmon);
> +}
> +
>  static int __init thinkpad_acpi_module_init(void)
>  {
>  	const struct dmi_system_id *dmi_id;
> @@ -11964,37 +11972,19 @@ static int __init thinkpad_acpi_module_init(void)
>  		return ret;
>  	}
> 
> -	tpacpi_sensors_pdev = platform_device_register_simple(
> -						TPACPI_HWMON_DRVR_NAME,
> -						PLATFORM_DEVID_NONE, NULL, 0);
> +	tpacpi_sensors_pdev = platform_create_bundle(&tpacpi_hwmon_pdriver,
> +						     tpacpi_hwmon_pdriver_probe,
> +						     NULL, 0, NULL, 0);
>  	if (IS_ERR(tpacpi_sensors_pdev)) {
>  		ret = PTR_ERR(tpacpi_sensors_pdev);
>  		tpacpi_sensors_pdev = NULL;
> -		pr_err("unable to register hwmon platform device\n");
> +		pr_err("unable to register hwmon platform device/driver bundle\n");
>  		thinkpad_acpi_module_exit();
>  		return ret;
>  	}
> 
>  	tpacpi_lifecycle = TPACPI_LIFE_RUNNING;
> 
> -	ret = platform_driver_register(&tpacpi_hwmon_pdriver);
> -	if (ret) {
> -		pr_err("unable to register hwmon platform driver\n");
> -		thinkpad_acpi_module_exit();
> -		return ret;
> -	}
> -	tp_features.sensors_pdrv_registered = 1;
> -
> -	tpacpi_hwmon = hwmon_device_register_with_groups(
> -		&tpacpi_sensors_pdev->dev, TPACPI_NAME, NULL, tpacpi_hwmon_groups);
> -	if (IS_ERR(tpacpi_hwmon)) {
> -		ret = PTR_ERR(tpacpi_hwmon);
> -		tpacpi_hwmon = NULL;
> -		pr_err("unable to register hwmon device\n");
> -		thinkpad_acpi_module_exit();
> -		return ret;
> -	}
> -
>  	return 0;
>  }
> 
> -- 
> 2.48.1

Thanks for doing this.

For the series - all looks good and I tested on a X1 Carbon 12 and confirmed the Thinkpad devices are there under /sys/devices/thinkpad_acpi and /sys/class/hwmon. Didn't find any issues.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

