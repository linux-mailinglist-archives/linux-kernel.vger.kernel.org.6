Return-Path: <linux-kernel+bounces-237633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9ED923BDA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE851F21F38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A83158DC8;
	Tue,  2 Jul 2024 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCH66iKa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E734E51004
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917553; cv=none; b=soA3/ikVpGUJAstD+1IPDReZceRrpY+cED2sYZjVeotgFmxpXlQsWpZ6BKBFd+I/25dmsRIvmslW0LsnKokGcT3yHwZWbPYXVeozGnvLevNOGGEfkf+fgh8yQTIUEQ6vOMcYck5eND3aJYgpgGTtBTNmL5gzxW/7KuLGTmY1Nl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917553; c=relaxed/simple;
	bh=7Q8xbz0ss+YODr//H0kU4M//qeFDSYIzUi/DaFmuBCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zgd0R+2iNPtifAzaMnfOm7Q6Zlh9VJQQzrnamA7TlEBUO/GA+/bkKieS00nCM5bUo6pFHI9LH+RNM2JR7rk4oQDTNWjuuohk7KFr7iZ+f0VDrfkwbFPpjbV2Zh2OcZxaEbiUFXzUAmHb2z6BdtuNBo07Y0oZnB1yE5Fo3VpB0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCH66iKa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719917550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7umkcpqXQxwDVTau9fHQ+ZMfOegpHM40k/wLyeqzy0=;
	b=dCH66iKa1oKasLewhAeHbTGY/KhrjT0OUt9rXHAZ9jFoZHbJvhzZX7XkoNRIWDOjQgzPcg
	ZkrM5KoCkXk5ZPShMljLdJK+9Hukr3V50cfhxiISEKa9/M8Y2xQuXCWyrPFDLJrTcCCasF
	JyO2UJWJcx+VJq/bVDEyJAVCKjF84w4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-rpAB2V9eMFySVpaJwBLiWw-1; Tue, 02 Jul 2024 06:52:29 -0400
X-MC-Unique: rpAB2V9eMFySVpaJwBLiWw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a74914bc770so217696966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 03:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719917548; x=1720522348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7umkcpqXQxwDVTau9fHQ+ZMfOegpHM40k/wLyeqzy0=;
        b=VJY9Ko1KZuxjuL9snkpGDbVScmmd2/lgTK9cVUJcFkXIY9w7x/0koAO6lESpp7xdpA
         cVivQXNTu9AWylmfTIrl91wIGnm/dGLptFk0+k21/86I6uR3iLAkh+z3v1c33OWCkLXT
         SxqhZFqWVP6SIQaz3XnZ1O3XYOIIDZ/yWa1PKwW4h5r1co0680qCl9giZCkmh9fAsemx
         lTqCOA3lTsDXlfd0DKwGoCnwA/ZrIoL2Gs555vbvh6jCwDdyjiVab/vFDavRTxo9StiR
         guSpeLT6/UKUyCQa8AIA7IQ7RuMpp5eO8/79Mv5j4YmlrY9D2fDWHHGbaZX/Zv+vWqG7
         tpYg==
X-Forwarded-Encrypted: i=1; AJvYcCVMGP/Bo5FssATphnqrUj7YaPEVAdyY3T9elRHkyQ/3YFPWy1S9vTYRUTxqCCJOqm70Naw/bhYG0+s98ugH/YsBMNqJllcf607gqO7c
X-Gm-Message-State: AOJu0YxgOoFxn38YOsy7iJO1rxPYrI7TE5SNUoY13/G0wDcgmjaskfho
	E/gu9Z1mord6ASpz2LTQdlsG1S3Lcn8PV3ZnDasAvJSixTZ7dgrCGyAVGD1WMamFY8hoJ6ufiQq
	PWoaDo1URiGd9+XQQRtFmL/jWnRbQDLWIfnm9HeUBmtg7Z/Wn9tthV9YUsbqwrQ==
X-Received: by 2002:a17:906:f2d3:b0:a72:7e82:7a15 with SMTP id a640c23a62f3a-a751440e853mr440989966b.23.1719917547861;
        Tue, 02 Jul 2024 03:52:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZtWsHeiQPj+lmpTz5Ow6a0tfLYovX9jqadqN9bEI2PdLe09L12QaY5MfbDIgyA3yWU46vWQ==
X-Received: by 2002:a17:906:f2d3:b0:a72:7e82:7a15 with SMTP id a640c23a62f3a-a751440e853mr440988366b.23.1719917547461;
        Tue, 02 Jul 2024 03:52:27 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab090590sm407518666b.183.2024.07.02.03.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 03:52:27 -0700 (PDT)
Message-ID: <60260bb8-ba94-4bd7-8aed-c3bf5b8f4a14@redhat.com>
Date: Tue, 2 Jul 2024 12:52:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: toshiba_acpi: Fix quickstart quirk
 handling
To: Armin Wolf <W_Armin@gmx.de>, coproscefalo@gmail.com
Cc: lkml@vorpal.se, kmal@cock.li, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240701194539.348937-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240701194539.348937-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Armin,

On 7/1/24 9:45 PM, Armin Wolf wrote:
> The global hci_hotkey_quickstart quirk flag is tested in
> toshiba_acpi_enable_hotkeys() before the quirk flag is properly
> initialized based on SMBIOS data. This causes the quirk to be
> applied to all models, some of which behave erratically as a
> result.
> 
> Fix this by initializing the global quirk flags during module
> initialization before registering the ACPI driver. This also
> allows us to mark toshiba_dmi_quirks[] as __initconst.
> 
> Fixes: 23f1d8b47d12 ("platform/x86: toshiba_acpi: Add quirk for buttons on Z830")
> Reported-by: kemal <kmal@cock.li>
> Tested-by: kemal <kmal@cock.li>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes since v1:
>  - add Tested-by tag

Thank you for fixing this, the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I was hoping my pdx86 fixes pull-request last Saturday would
be the last one for this cycle, but I'll prep another one
with this patch sometime this week:

Thank you for your patch/series, I've applied this patch
(series) to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I have added a:

Closes: https://lore.kernel.org/platform-driver-x86/R4CYFS.TWB8QUU2SHWI1@cock.li/

tag whole applying this.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



Regards,

Hans



> ---
>  drivers/platform/x86/toshiba_acpi.c | 31 +++++++++++++++++------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 3a8d8df89186..10d0ce6c8342 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -3271,7 +3271,7 @@ static const char *find_hci_method(acpi_handle handle)
>   */
>  #define QUIRK_HCI_HOTKEY_QUICKSTART		BIT(1)
> 
> -static const struct dmi_system_id toshiba_dmi_quirks[] = {
> +static const struct dmi_system_id toshiba_dmi_quirks[] __initconst = {
>  	{
>  	 /* Toshiba Portégé R700 */
>  	 /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
> @@ -3306,8 +3306,6 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	struct toshiba_acpi_dev *dev;
>  	const char *hci_method;
>  	u32 dummy;
> -	const struct dmi_system_id *dmi_id;
> -	long quirks = 0;
>  	int ret = 0;
> 
>  	if (toshiba_acpi)
> @@ -3460,16 +3458,6 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	}
>  #endif
> 
> -	dmi_id = dmi_first_match(toshiba_dmi_quirks);
> -	if (dmi_id)
> -		quirks = (long)dmi_id->driver_data;
> -
> -	if (turn_on_panel_on_resume == -1)
> -		turn_on_panel_on_resume = !!(quirks & QUIRK_TURN_ON_PANEL_ON_RESUME);
> -
> -	if (hci_hotkey_quickstart == -1)
> -		hci_hotkey_quickstart = !!(quirks & QUIRK_HCI_HOTKEY_QUICKSTART);
> -
>  	toshiba_wwan_available(dev);
>  	if (dev->wwan_supported)
>  		toshiba_acpi_setup_wwan_rfkill(dev);
> @@ -3618,10 +3606,27 @@ static struct acpi_driver toshiba_acpi_driver = {
>  	.drv.pm	= &toshiba_acpi_pm,
>  };
> 
> +static void __init toshiba_dmi_init(void)
> +{
> +	const struct dmi_system_id *dmi_id;
> +	long quirks = 0;
> +
> +	dmi_id = dmi_first_match(toshiba_dmi_quirks);
> +	if (dmi_id)
> +		quirks = (long)dmi_id->driver_data;
> +
> +	if (turn_on_panel_on_resume == -1)
> +		turn_on_panel_on_resume = !!(quirks & QUIRK_TURN_ON_PANEL_ON_RESUME);
> +
> +	if (hci_hotkey_quickstart == -1)
> +		hci_hotkey_quickstart = !!(quirks & QUIRK_HCI_HOTKEY_QUICKSTART);
> +}
> +
>  static int __init toshiba_acpi_init(void)
>  {
>  	int ret;
> 
> +	toshiba_dmi_init();
>  	toshiba_proc_dir = proc_mkdir(PROC_TOSHIBA, acpi_root_dir);
>  	if (!toshiba_proc_dir) {
>  		pr_err("Unable to create proc dir " PROC_TOSHIBA "\n");
> --
> 2.39.2
> 


