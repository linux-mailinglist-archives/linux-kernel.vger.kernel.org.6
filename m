Return-Path: <linux-kernel+bounces-433273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5E89E55D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC46F288C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33448218AB7;
	Thu,  5 Dec 2024 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8myugvj"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87901C3318;
	Thu,  5 Dec 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403063; cv=none; b=m434i9ZJ+Mmv3zfFJb68TZPU/vPPTDI68u8PdpLzpIXTWiVWdKoxFZceMrmdmSsSB3LdWuBolnRetJaroAgnEI1B4XeOl5duq02rSP2i1DyRH9ansjpVC0s64WoCHOW/PMljoPDfYeQVz+mvugKJDEl9P2SKF6yknEUc17HKgiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403063; c=relaxed/simple;
	bh=PG16EEui/P75/srTNAIcysXTJOVGJeTSGFBiT6t2VpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeEFXgUlbDa1OSXN0ERAChj/DR5BrAS5IapoBwOd7NQetsdCC+uVvkWpysBOy6H1FAGZThj7F73mOD2XdDOiEosSGetFSdJ2wj/bT4fNxKeLvHwyBbEIz5vduC44mBQzIqDU3IYgo++mJd7uQC3u3xo1vfM2ISLMIW+5kupKtOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8myugvj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fcc00285a9so952048a12.2;
        Thu, 05 Dec 2024 04:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733403061; x=1734007861; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zgFlyGkNK7F1yu5jXaRpNOXzz31XWNf0nsSJ2Y1xurg=;
        b=b8myugvjgSzj8dO4D23F90Xs6UEukz/oTpOxG1U3CL4+MOfZMoyWaevihhQlmqkQ0h
         PlBivYMmgfW97jGk2kGWw5UyVb2iYGvrtAzMISGwvedQzRUmkoxGiwgE1Zh2pzSNYyrr
         vl8jL9PlhrEo+njd/4EoAEAKzv7zEsjDqoywh+uUZXHMtF3J5n3HoOlgF/7VHwLZdtft
         cXR1YyOaNpEGYbFo4hzJKemdwIEFNVrb6a2iCjmjvUA9u+TUHf4XDvPxowlBlPXij1VD
         33AjFvfKJqSos4oC2P4EZ4yUzHvnAPM3HlokH/LtuSKqlnyZrwpc2FNF5XRfG6wErfmB
         2eEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733403061; x=1734007861;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgFlyGkNK7F1yu5jXaRpNOXzz31XWNf0nsSJ2Y1xurg=;
        b=L0UVCuAWM8R7NbMRn66kz/XkovZLEtAidZutwWMphEsbl7iebZd9esGnTVvkmhqjrv
         LV776tMtcs5rcB2FPoQt4NsklgCtOt0qOZNchr3Num8ecToQlGD3iaYhqV5q7C8ZfT8k
         Yq0r2tf4//KvgW03DCx7Z/ElVdQO9QpQPOUO0l8uL8TZRu+2Bu5ruW/TeWUjBsRMpu73
         86t95ZlACzge9Jif5uxXg9VS8lFAdteo2TkM0suqfnHWMBWFPhiQ9NHDjxy5Z8E0SF13
         DD0ymtodP2NaL4UkfRa0RlHeNBk6yGHS7//VwvPg+/uKALQuHviXt5MfQrHrboRalMWr
         Gipg==
X-Forwarded-Encrypted: i=1; AJvYcCV6dP2D6bu1m33RWb39buXSYBG081q2bc9vKr3MG3Ynvn25OU1t9+j8N8VxfeICxWWwyM0d+kU5mtXzWKU=@vger.kernel.org, AJvYcCW82JEe46vQUUfrYdGqctXsvLyJutlVDjgnfP/f7K3Zp6Ofn2HrhhcfVWjopb451dRpxmXNtkkGgETrrugQkFutZ0ZBlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWvk0T463zyuP39y9ydqPbsC4VD5JQhCzP5/91I0O/UEcNrVfn
	FmJUOc3Yd2DXgokBVkGT9mh9AGH7843MZ2Us5I5BQPqNy8SSL51T
X-Gm-Gg: ASbGncud8B4jQC342WGZ/Zkhk1/DLCAd1ysP9JJI58H7x7y9SyJzd3hx6fPxNJiHq28
	jC2azKB6KxHehxf+J46PU5qX0oKWULGLN0VO9IYdzZYZVjBwLDUa2MwpKb8vMmMQB5pFoOhdwQ2
	mkz6n2HDM2kYgHGAAyQe8Uqh6aSgawzqq1E8tLKMQmEAczUF+O79yfxDYkrMaLsAjBURqt07AKI
	smkzs3fIppEGhkjPatIVY++BaAJ+KnJWpFVgv47BfVQxo2BTCcjK4S6r1XFnjA5iVPm0lhe7RC1
	9Qi2yRxE
X-Google-Smtp-Source: AGHT+IHTR/p78wMUtCIxNGdA2XPik/hD1PI3JBwFg044AjFCgszCNme5ZdRJuce0UkDAwF3LxWWH+Q==
X-Received: by 2002:a05:6a20:7f8e:b0:1e0:ca95:3cb2 with SMTP id adf61e73a8af0-1e1653a7c1fmr15635584637.8.1733403060985;
        Thu, 05 Dec 2024 04:51:00 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd157e90aasm1201090a12.86.2024.12.05.04.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:51:00 -0800 (PST)
Date: Thu, 5 Dec 2024 09:50:57 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, platform-driver-x86@vger.kernel.org, 
	w_armin@gmx.de
Subject: Re: [RFC PATCH 10/21] alienware-wmi: Add alienfx OPs to platdata
Message-ID: <djj7twl5wvc53ldb7qotz3dnn2eprq3c657t6xleffajugv4qf@gj3advwy3f4w>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
 <20241205004225.2185672-2-kuurtb@gmail.com>
 <b6875a98-6fce-435d-7061-9da7e907b69b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6875a98-6fce-435d-7061-9da7e907b69b@linux.intel.com>

On Thu, Dec 05, 2024 at 01:05:50PM +0200, Ilpo Järvinen wrote:
> On Wed, 4 Dec 2024, Kurt Borja wrote:
> 
> > Both WMI devices handled by this module specify a distinct interface for
> > LED control. Previously this module handled this by dynamically adapting
> > arguments passed to wmi_evaluate_method() based on the `interface`
> > global variable.
> > 
> > To avoid the use of global variables, and enable the migration to
> > wmidev_* methods, let the WMI drivers present a single interface through
> > this "alienfx operations".
> > 
> > Also define alienware_wmi_command(), which serves as a wrapper for
> > wmidev_evaluate_method(). This new method is very similar to
> > alienware_wmax_command() but is WMI device agnostic and makes use of
> > non-deprecated WMI methods.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >  drivers/platform/x86/dell/alienware-wmi.c | 110 ++++++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index 34fb59a14bc0..043cde40de9a 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -411,8 +411,16 @@ struct alienfx_priv {
> >  	u8 lighting_control_state;
> >  };
> >  
> > +struct alienfx_ops {
> > +	int (*upd_led)(struct alienfx_priv *priv, struct wmi_device *wdev,
> > +		       u8 location);
> > +	int (*upd_brightness)(struct alienfx_priv *priv, struct wmi_device *wdev,
> > +			      u8 brightness);
> > +};
> > +
> >  struct alienfx_platdata {
> >  	struct wmi_device *wdev;
> > +	struct alienfx_ops ops;
> >  };
> >  
> >  static struct platform_profile_handler pp_handler;
> > @@ -421,6 +429,32 @@ static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
> >  static u8 interface;
> >  static struct wmi_driver *preferred_wmi_driver;
> >  
> > +static acpi_status alienware_wmi_command(struct wmi_device *wdev, u32 method_id,
> > +					 void *in_args, size_t in_size, u32 *out_data)
> > +{
> > +	acpi_status ret;
> > +	union acpi_object *obj;
> 
> > +	struct acpi_buffer in = { in_size,  in_args };
> > +	struct acpi_buffer out = {  ACPI_ALLOCATE_BUFFER, NULL };
> 
> Extra whitespace on both lines.

Ack.

> 
> > +
> > +	if (out_data) {
> > +		ret = wmidev_evaluate_method(wdev, 0, method_id, &in, &out);
> > +		if (ACPI_FAILURE(ret))
> > +			goto out_free_ptr;
> > +
> > +		obj = (union acpi_object *) out.pointer;
> 
> The usual style for casts is without space but not an end of the world if 
> you want to have the space there (in any case, it's not explicitly stated 
> in coding style).

Just personal preference, but I'll stick with the usual style!

> 
> > +
> > +		if (obj && obj->type == ACPI_TYPE_INTEGER)
> > +			*out_data = (u32) obj->integer.value;
> > +	} else {
> > +		ret = wmidev_evaluate_method(wdev, 0, method_id, &in, NULL);
> > +	}
> > +
> > +out_free_ptr:
> > +	kfree(out.pointer);
> > +	return ret;
> > +}
> > +
> >  /*
> >   * Helpers used for zone control
> >   */
> > @@ -1178,11 +1212,48 @@ static void alienfx_wmi_exit(struct wmi_device *wdev)
> >  /*
> >   * Legacy WMI device
> >   */
> > +static int legacy_wmi_update_led(struct alienfx_priv *priv,
> > +				 struct wmi_device *wdev, u8 location)
> > +{
> > +	acpi_status status;
> > +	struct acpi_buffer input;
> > +	struct legacy_led_args legacy_args;
> 
> Mostly try to abide the reverse xmas tree order (but if there's 
> dependency, feel free to violate it where it makes sense).

Ack. 

> 
> -- 
>  i.
> 
> > +	legacy_args.colors = priv->colors[location];
> > +	legacy_args.brightness = priv->global_brightness;
> > +	legacy_args.state = priv->lighting_control_state;
> > +
> > +	input.length = sizeof(legacy_args);
> > +	input.pointer = &legacy_args;
> > +
> > +	if (legacy_args.state == LEGACY_RUNNING)
> > +		status = alienware_wmi_command(wdev, location + 1, &legacy_args,
> > +					       sizeof(legacy_args), NULL);
> > +	else
> > +		status = wmi_evaluate_method(LEGACY_POWER_CONTROL_GUID, 0,
> > +					     location + 1, &input, NULL);
> > +
> > +	if (ACPI_FAILURE(status))
> > +		return -EIO;
> > +
> > +	return 0;
> > +}
> > +
> > +static int legacy_wmi_update_brightness(struct alienfx_priv *priv,
> > +					struct wmi_device *wdev, u8 brightness)
> > +{
> > +	return legacy_wmi_update_led(priv, wdev, 0);
> > +}
> > +
> >  static int legacy_wmi_probe(struct wmi_device *wdev, const void *context)
> >  {
> >  	int ret = 0;
> >  	struct alienfx_platdata pdata = {
> >  		.wdev = wdev,
> > +		.ops = {
> > +			.upd_led = legacy_wmi_update_led,
> > +			.upd_brightness = legacy_wmi_update_brightness,
> > +		},
> >  	};
> >  
> >  	if (quirks->num_zones > 0)
> > @@ -1219,11 +1290,50 @@ static struct wmi_driver alienware_legacy_wmi_driver = {
> >  /*
> >   * WMAX WMI device
> >   */
> > +static int wmax_wmi_update_led(struct alienfx_priv *priv,
> > +			       struct wmi_device *wdev, u8 location)
> > +{
> > +	acpi_status status;
> > +	struct wmax_led_args in_args = {
> > +		.led_mask = 1 << location,
> > +		.colors = priv->colors[location],
> > +		.state = priv->lighting_control_state,
> > +	};
> > +
> > +	status = alienware_wmi_command(wdev, WMAX_METHOD_ZONE_CONTROL,
> > +				       &in_args, sizeof(in_args), NULL);
> > +	if (ACPI_FAILURE(status))
> > +		return -EIO;
> > +
> > +	return 0;
> > +}
> > +
> > +static int wmax_wmi_update_brightness(struct alienfx_priv *priv,
> > +				      struct wmi_device *wdev, u8 brightness)
> > +{
> > +	acpi_status status;
> > +	struct wmax_brightness_args in_args = {
> > +		.led_mask = 0xFF,
> > +		.percentage = brightness,
> > +	};
> > +
> > +	status = alienware_wmi_command(wdev, WMAX_METHOD_BRIGHTNESS, &in_args,
> > +				       sizeof(in_args), NULL);
> > +	if (ACPI_FAILURE(status))
> > +		return -EIO;
> > +
> > +	return 0;
> > +}
> > +
> >  static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
> >  {
> >  	int ret = 0;
> >  	struct alienfx_platdata pdata = {
> >  		.wdev = wdev,
> > +		.ops = {
> > +			.upd_led = wmax_wmi_update_led,
> > +			.upd_brightness = wmax_wmi_update_brightness,
> > +		},
> >  	};
> >  
> >  	if (quirks->thermal)
> > 

