Return-Path: <linux-kernel+bounces-431120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EA39E3928
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23140167B8D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7661AC44D;
	Wed,  4 Dec 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz90akPk"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770131B5823;
	Wed,  4 Dec 2024 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312706; cv=none; b=Pi+tKATd676NEsQJmeXSdRurOrVNzSzbc5i+UsVzoCRi34tINvLFhHsGLZZGINUryFFTWVr3PIVMiQ59qP61OeFgsdk5xncw863uHyNpM6X4u7tOxMCLeVCGgfQ1dhJWs8QqoMtMKl+IsvmiUZfYh2wmalJIZjtM2v94+F7Dsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312706; c=relaxed/simple;
	bh=RovnKJv9VRPyPnU6oCFtT0/JKYl0c6u9fgdt5vqnjFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UW864qbg1OhK00LvapLmjBnrztTn16wGusC/2C8KUDVRQMHoTxte4dFz6iwimtBSU1XNJizlvI6IdX2XdVDd3z12GKLVflceFjv2lYqgcOlqPmEQFBbdRYmLMhWZd9YdpzwysvADPK1giuZW2NMYO/e3Tk8LH/H0mLDBMwCyAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yz90akPk; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-843e9db3e65so28157739f.1;
        Wed, 04 Dec 2024 03:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733312703; x=1733917503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MP1IFoCtUECa7auIxqrxM0e+TZCBmVEADW+5Kskf1Ng=;
        b=Yz90akPkKaXHYw88Y999XmsuzILOOqPWs8HvpG6uEC52z+42LrEPDB9Q8uAux9mQge
         ih4vArCsJ3Cv5LypNzEYa9GCcxNTuFt/w8/Xs4nX5Sz2KZNmgkzSz7z80igy+J1raO6d
         6BEYipjEX7MGouJjCmsZD/fHA1X/nzrMl+m2ALeVlHlOBWfHb9s9Hr5uUZ8f/DHRGdlW
         +dE1ln4bdgf2jzrLThM9KgmkZ6gAACuxCIbK1jbm/tMErqL97B/blONgiF4Vt8TBvKiR
         rYCLzao2vVXU/CmriKSobSq/27wOMWnihicMRwL6b+ccdpGTLjKIuEbkvTiH8HZzXi7/
         G6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733312703; x=1733917503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MP1IFoCtUECa7auIxqrxM0e+TZCBmVEADW+5Kskf1Ng=;
        b=cDgnLfI/RWvCbllEvoRysipzmiXt2FM4SoY8nMUFxmrwJfOxFDSU7WlOGyTbBapWm/
         hIRNC7gr4lhYNaV75TKGi0xMTHm948pEgwHq8Ryo9epFhUE2ySGiMGPf4PZraMYydbpy
         kXHQYjPpsAWAUGy9yKoSjH1Qy6YmiuaMej1saKapE8s2sz+/dC1kNraLPD3wh++L0Qaj
         9spA89V60A67OqdTMkdg0RoJnnC68wZcJD13/Qxiv+mYbnChIl2sMSxzyPYI9WiFJTxi
         5fcXrq92ZNUZUNPM3PlBfe6WKWBbhmaI5kOZCUXKRN0H9Kh14w74lfOa7xPTV+RNukxD
         ljGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHCpxxlSe1odCxToZN/IeoH5xzsSop8TUVu7/Vw+5Ifyv0hTxhCJmIANjAT2sSiGtyzyo6lXomQek=@vger.kernel.org, AJvYcCXVE2ybYktZPxjl5buiyZO5ljE4U56Qpx7zjid07z5YRfb5aN/Ef/uzjnU+N1xjxi/sTKp8Bq2bzITsN5J2@vger.kernel.org, AJvYcCXeXKIziQDPBs0jKLlWd1lg/wsxHfu15dYLQHj3njHcTDAeJTaeSDe76I9KldBSKAR7A1+uWhZefA3ujzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzbC19MZp2mYs8yiWa5PnzHEUIvR6ZTTQDR6fi8DlPQggYeZFk
	4jUAZ/Nk3WSVY3Dd+BTaRnjbUhHXjnmaC8zcq+uqEJNymFGbySGXiz8/w07H0FDl/PUZCwLo2Gs
	Mi0BBOEL5IN4Fs50DDRA1VEwQ7RI=
X-Gm-Gg: ASbGncvAv4uhwpNm2N0FQAqGxRWyQDuu/QJTr6kjdmEp+/lEyRynYzYCQA48yn5GvgM
	bNXTpkUshUQi0MuGD5XgI9lEqTRs=
X-Google-Smtp-Source: AGHT+IEBt7Y3AoZe/E0djwwPsqCvw+zc0j5mZ94vDNVDO8XiK/PLM3XziwSPyrI6XblnANThkNiK/yHMr86Yy1Wou6s=
X-Received: by 2002:a5e:a60d:0:b0:841:9225:1f56 with SMTP id
 ca18e2360f4ac-84401589d4amr2255415639f.3.1733312703542; Wed, 04 Dec 2024
 03:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201034803.584482-1-yanhuoguifan@gmail.com> <20241201034803.584482-2-yanhuoguifan@gmail.com>
In-Reply-To: <20241201034803.584482-2-yanhuoguifan@gmail.com>
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Wed, 4 Dec 2024 12:44:52 +0100
Message-ID: <CAB95QAQLh3mnfWxB9rnsAzNQ+e43=2xZNP3h4HcWY7jYQ8Yi_g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hwmon: (asus-ec-sensors) AMD 600 motherboard add
 support for fan cpu opt
To: Li XingYang <yanhuoguifan@gmail.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, 
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LGTM.

Best Regards,
Eugene

On Sun, 1 Dec 2024 at 04:48, Li XingYang <yanhuoguifan@gmail.com> wrote:
>
> Refer to the LibreHardwareMonitor project, LibreHardwareMonitorLib/
> Hardware/Motherboard/Lpc/EC/EmbeddedController.cs file,
> fan cpu opt is support by amd600 EC.
> the registers are described:
> BoardFamily.Amd600, new Dictionary<ECSensor, EmbeddedControllerSource>
> {
> { ECSensor.FanCPUOpt,  new EmbeddedControllerSource
> ("CPU Optional Fan", SensorType.Fan, 0x00b0, 2) },
> }
>
> now add the FanCPUOpt support for amd600
>
> Signed-off-by: Li XingYang <yanhuoguifan@gmail.com>
> ---
>  drivers/hwmon/asus-ec-sensors.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 9555366aeaf0..381bf117104f 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -250,6 +250,8 @@ static const struct ec_sensor_info sensors_family_amd_600[] = {
>                 EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
>         [ec_sensor_temp_water_out] =
>                 EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
> +       [ec_sensor_fan_cpu_opt] =
> +               EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
>  };
>
>  static const struct ec_sensor_info sensors_family_intel_300[] = {
> --
> 2.47.1
>

