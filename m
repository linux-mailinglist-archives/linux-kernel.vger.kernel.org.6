Return-Path: <linux-kernel+bounces-365005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9F999DC20
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAC62833F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B9D166F32;
	Tue, 15 Oct 2024 02:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4gD5wU2"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E29721364;
	Tue, 15 Oct 2024 02:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728958505; cv=none; b=HRPwgxWCtJsM+O+lOw9eZ22OtGGOzRPOjX0pXcWHCsYM0/TC9rD0cJv8B/9+ld0V3cnRORLo+aDEANbMCNWL+CvAySqIW9UfmZTio28u62zXQ3p4zz9umRNyPh0I4xUe9+QsaPRlPHwkGAZj9VkUmP9HLfP774tdYQSQd8dd0Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728958505; c=relaxed/simple;
	bh=cvPwE7Ccm3dtNT8yv++QYNX7qSCy12SZIh02AvYmv40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpbMgmJbAK3zHfYKHfTDpNAy/G7DlyE5NwS1MH9ToaSUFx8t6HuOf8BAPi3OnhBjzmiwBE+h6NyMt7JAzGehOm1C7X08kBX7tcVvqCZbc3HXfHi+7DrqzqWbsGeo8ytQXhN/GYIB2NnYOo9Yzu+qeS9mF1n0dY3+5yczrMED6J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4gD5wU2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c693b68f5so48997375ad.1;
        Mon, 14 Oct 2024 19:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728958503; x=1729563303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1r9Bc90Xo2DPDhdR1f1BgFICZEW/Z+12gs6EtdMifJU=;
        b=Q4gD5wU2mI3Ir9wkFEldd8TK+SiNuxtS2U7lGaK2OSUrmcdWwCUpd8GJL7xCNxv7oh
         w5zvFV4n2raPU3SFXlEq4eI2xLnK1NsDmun7d2IE1SPuHkSjitnmwo6/r5LXP4P4+KhI
         wyGoa0CRFDBFoQe3d37vmJ90yyDO3dSbnErpXhN0T9ul5UHa1wQnKT5Vm8q8M6T3LkeH
         /E2Hr1GvBiw08jkjCX+UQWINJJ6riLR/9XtwRKmnotlfbw+oEBuqtOn4964dHWUolNO0
         ZQWaNp9HonJ7Pm4ZmHbVfBdO8K1T+VikagN/qmZ69pWJDwrK3Dm/io3EU5/7hQmf5QWU
         5U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728958503; x=1729563303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r9Bc90Xo2DPDhdR1f1BgFICZEW/Z+12gs6EtdMifJU=;
        b=icvtVooh51c7TkijYCxGWN0Hy3lHdAfakfpJNpOuiIw182Ycyuj4/46knUDjfPlR9p
         ju6pxnhcofVYtHkNZc/kjhasOHO5d8z0a7INUXTRF8iHLAr6fgjj9O3zreuitpShkZ/+
         OW3WlZMA838hjhcTpQrD14zQ0SziFuf4OgWxN5zSIofH3U4NLw/LjdK9U1GA9qOTdCw7
         ISRh47mcVDYEqamdHb+QPqq+Ec7PSXd+M+LV9DG/Jy/AkQo4llsvwZKAqOQGmhF5bgPq
         dBe6EYYYsf6M2Xv6fWLQHZY8DjkOA1VLFO9AHlMfFdqqZUu9doliyQrOGZlUW319vdYR
         G4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUEbDEBl2zA+IUtG2MsZJbKnZbe7FVhlpX9H6dFjL/QEllLJYermS2Z1dd+Mc3a0oYUgixjEPIp6Od8tAw=@vger.kernel.org, AJvYcCWv8Om3ooNw67nMNYWFvusVWlpIU1Y+Xgx5URZzkCGC0p4nXOD2mZ7Br73Aewb/o+O1MV6W9SDXeAGJNNjJNDpJYrRWAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/Lv7qwzCT75CBeeBglrmNpkC65/sZcMAQAjBnBNzEeTpyqwU
	dAS10Fy1vPmSr2LvrX+diRWrkwqXcILq1JBN8D++BNZjhtjCP6nOYdvT1Hxm
X-Google-Smtp-Source: AGHT+IF3tlHNcfBq9Fz+V3k11ANwPeKVPuG8BxlwslfsWz4R4JcW1jPgX4DM8SDq4KOudWru5D2URA==
X-Received: by 2002:a17:902:d4ca:b0:20b:7a46:1071 with SMTP id d9443c01a7336-20ca13f7200mr198919415ad.4.1728958503240;
        Mon, 14 Oct 2024 19:15:03 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1803627bsm2074185ad.151.2024.10.14.19.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 19:15:02 -0700 (PDT)
Date: Mon, 14 Oct 2024 23:14:58 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 2/4] alienware-wmi: alienware_wmax_command() is now
 input size agnostic
Message-ID: <wqnmzzln5ikostiwbciucqt6rud75igm2uia6kzt5tsaafop3e@jucdbbfjmk6d>
References: <20241012015849.19036-3-kuurtb@gmail.com>
 <20241012020149.19700-3-kuurtb@gmail.com>
 <3fe7c4e0-c24a-4205-a870-0fcc6e76f1af@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe7c4e0-c24a-4205-a870-0fcc6e76f1af@gmx.de>

On Mon, Oct 14, 2024 at 06:30:21PM +0200, Armin Wolf wrote:
> Am 12.10.24 um 04:01 schrieb Kurt Borja:
> 
> > alienware_wmax_command() now takes void * and size_t instead of struct
> > wmax_basic_args to extend support to new WMAX methods. Also int *out_data
> > was changed to u32 *out_data, because new interface specifies u32 as output
> > parameter and all previous callers would pass u32 * regardless.
> 
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> 

Thank you very much.

Kurt

> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >   drivers/platform/x86/dell/alienware-wmi.c | 29 ++++++++++++-----------
> >   1 file changed, 15 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index 16a3fe9ac..b27f3b64c 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -500,15 +500,15 @@ static void alienware_zone_exit(struct platform_device *dev)
> >   	kfree(zone_attrs);
> >   }
> > 
> > -static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
> > -					  u32 command, int *out_data)
> > +static acpi_status alienware_wmax_command(void *in_args, size_t in_size,
> > +					  u32 command, u32 *out_data)
> >   {
> >   	acpi_status status;
> >   	union acpi_object *obj;
> >   	struct acpi_buffer input;
> >   	struct acpi_buffer output;
> > 
> > -	input.length = sizeof(*in_args);
> > +	input.length = in_size;
> >   	input.pointer = in_args;
> >   	if (out_data) {
> >   		output.length = ACPI_ALLOCATE_BUFFER;
> > @@ -541,8 +541,8 @@ static ssize_t show_hdmi_cable(struct device *dev,
> >   		.arg = 0,
> >   	};
> >   	status =
> > -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
> > -				   &out_data);
> > +	    alienware_wmax_command(&in_args, sizeof(in_args),
> > +				   WMAX_METHOD_HDMI_CABLE, &out_data);
> >   	if (ACPI_SUCCESS(status)) {
> >   		if (out_data == 0)
> >   			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> > @@ -562,8 +562,8 @@ static ssize_t show_hdmi_source(struct device *dev,
> >   		.arg = 0,
> >   	};
> >   	status =
> > -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
> > -				   &out_data);
> > +	    alienware_wmax_command(&in_args, sizeof(in_args),
> > +				   WMAX_METHOD_HDMI_STATUS, &out_data);
> > 
> >   	if (ACPI_SUCCESS(status)) {
> >   		if (out_data == 1)
> > @@ -589,7 +589,8 @@ static ssize_t toggle_hdmi_source(struct device *dev,
> >   		args.arg = 3;
> >   	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
> > 
> > -	status = alienware_wmax_command(&args, WMAX_METHOD_HDMI_SOURCE, NULL);
> > +	status = alienware_wmax_command(&args, sizeof(args),
> > +					WMAX_METHOD_HDMI_SOURCE, NULL);
> > 
> >   	if (ACPI_FAILURE(status))
> >   		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
> > @@ -642,8 +643,8 @@ static ssize_t show_amplifier_status(struct device *dev,
> >   		.arg = 0,
> >   	};
> >   	status =
> > -	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
> > -				   &out_data);
> > +	    alienware_wmax_command(&in_args, sizeof(in_args),
> > +				   WMAX_METHOD_AMPLIFIER_CABLE, &out_data);
> >   	if (ACPI_SUCCESS(status)) {
> >   		if (out_data == 0)
> >   			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> > @@ -694,8 +695,8 @@ static ssize_t show_deepsleep_status(struct device *dev,
> >   	struct wmax_basic_args in_args = {
> >   		.arg = 0,
> >   	};
> > -	status = alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STATUS,
> > -					&out_data);
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_DEEP_SLEEP_STATUS, &out_data);
> >   	if (ACPI_SUCCESS(status)) {
> >   		if (out_data == 0)
> >   			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
> > @@ -723,8 +724,8 @@ static ssize_t toggle_deepsleep(struct device *dev,
> >   		args.arg = 2;
> >   	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, buf);
> > 
> > -	status = alienware_wmax_command(&args, WMAX_METHOD_DEEP_SLEEP_CONTROL,
> > -					NULL);
> > +	status = alienware_wmax_command(&args, sizeof(args),
> > +					WMAX_METHOD_DEEP_SLEEP_CONTROL, NULL);
> > 
> >   	if (ACPI_FAILURE(status))
> >   		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",

