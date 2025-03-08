Return-Path: <linux-kernel+bounces-552806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0FAA57E89
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 22:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D1718907EA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 21:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937331FF61A;
	Sat,  8 Mar 2025 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izeiSPZP"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80B1E25F7;
	Sat,  8 Mar 2025 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741469034; cv=none; b=uQQGAm/mC30PQJcnGAzpGsTq9WZLLsQFl0GS+5dhlAZ5nY/1wgRIlbm0UZxYfaNfiX1alaXr6EQZTyi7bDI+lsXeeoCJC6xcmcOsoqgu0SPUth5NT9WAtC/heWhgHBvFJIsU5Rbh5a8oC72yA/irVqPIopvUQAsP3mr8A4XymJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741469034; c=relaxed/simple;
	bh=nnRyVm3jckaAhm89vTOA3wn9jLtsidaicok1+1dCXJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5y5ruTMJ7I1yQtggLcQoym2kKiEXIrhXQ/wvFa831yNz/oWeED5mVwwxqpstmTIMr61/WV/O4F5XRQOSt+GqoRKDEYrfG3e9YLNAOk8htWWyuivIc4MgrVAiuynRYgpxlFGFnb4qd+78X7TZcGjeJzG8XTF0xWMP5z4XbC67Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izeiSPZP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2232aead377so62623485ad.0;
        Sat, 08 Mar 2025 13:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741469031; x=1742073831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6Nv2d+XPXBq87X7aQ/dMW4rebzwRjEiP2qC4BmukNkI=;
        b=izeiSPZP1BOWr7go2zLpS1SrxZUS74RlFCxoXWMNvg6LKlv567xaKl7r0qxoeJ1CkI
         vteuWK7uv75hm24uzT+fwFDI862yvzs+H9y1KZlG231IWKf6gqK92aNcRsLKnVbj46yl
         eo705//iPUPkAWAiBl1Oa1BMDFndpjjp1361tXfPeI0swnrkMuQB24cAvRWxsGBEKY1K
         4pllVEhhXtvxUsNzMQKxgQZMhztytIGEoMDpmlTiSoBLaFU+pbDiq6enZovIwxopnxvm
         KrCsdyOpYLQbC38OKiu9B2RSzdrB6k6OiDH/OZ/F7Xo87elVSM7T+ANhpL3Ss7I9Zziy
         v1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741469031; x=1742073831;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Nv2d+XPXBq87X7aQ/dMW4rebzwRjEiP2qC4BmukNkI=;
        b=Jy0qqUHWMuSnVDa2eOg4j0f+9uUCfsJH1qwKMDlnsaZ+0zFKluZJ/ruojXxvutdMMX
         NIqPPcPVxV7HhE4z4XEkmxFaTjxsbqjfyO8jXex8URRFm1KJoraEDN4lGsUd6Lw5wUEY
         1quh9gqPNBzXjndNXqrnQbX6QRazjILC7yoyGLDU2qF4eHou33FTKmrc2d+ICPitAg9d
         YuzP9uySHUbOLj9rO6joIcwSr0iZR4dPBjpqT7FrTbaXpu4YOBlnyb7TT0sQfJz9AYbf
         6Pf6k4W6YRUfpKqehmQ3EfKjfIbd3S6ltBh1wOS04ww4fvG4lOfawXdTQlG0booiBxK0
         Yh5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCI0CvQ1VIsvgJYGct4NDocuIk74N95fCE+0ppFr72DDIg+seiMvwuK+IutTXGt1F2JB4wG06aqoxJVA==@vger.kernel.org, AJvYcCUhV1y3e/62djpqfWJs5BWwkljJMNCvqnlqMQkp0/lUIN5G+rgWFJ+Ju9kYui5daoQlIuEi2wMY2kmwY8Pv@vger.kernel.org, AJvYcCWBhQEaogjeKs0vcQv7WZ2x7qILrAyd6jrN2PA8wjx/fD6BhTEGY9RB6kZVqknVJb8tRgqunXTkaGXlwMJIxhof19179Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIDXcTn5RGiaT5XFtVN1+vsEKBotxXEba9SkUh7UJw42zMU6f
	tRHbWSLHQ140CKwGUI4p3LkStsRMh302zRiq436hujm7bMnFAfxO
X-Gm-Gg: ASbGncvoHZNhGHHzZBuVdCNIjqnohgUtvKSCw9K8xKN8SOq7LBMSx3wnUnzNAbencjv
	E3KjSKlVS54EfRoEK0E0bUmYNUgKaFmgt173xNZEW02UaeRb3dyLONFAxDlpDfVNM9uOOzzjjK0
	U134yLj4sR95ziOu3qoRguLnudS6KVi+m/rDVot5e2MKh7LIx/2DfQyUaQ5dzTHzYbiSykxSkQL
	AK5mSWUqAVOQfG70+hrsII2WGI9p8zi8QBBxdBhi9Ie8op8+MxG0FRZQCaVKMURkYokM5Ky5hoN
	0Gy/vVyzBXLJeed+vbsbyv5xlLpNWUyasWpSxaiPzBd7njghaXOe5AYX/LN05vWBMUFJpKRKwRl
	WL5/hBYOcDTKyH55MKQ==
X-Google-Smtp-Source: AGHT+IEwfbi/bKabPqVt72mWK0qQVvFFJV3yIQq74r65RqIvBltwB0PrxEmwnTSA5pw5tnryo6uLjQ==
X-Received: by 2002:a05:6a00:14d1:b0:730:8ed8:6cd0 with SMTP id d2e1a72fcca58-736aaadf579mr11560849b3a.16.1741469031301;
        Sat, 08 Mar 2025 13:23:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736984f6f8fsm5446208b3a.119.2025.03.08.13.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 13:23:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a5a159ee-5623-454f-8b27-352603c5d1e8@roeck-us.net>
Date: Sat, 8 Mar 2025 13:23:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] platform/x86: alienware-wmi-wmax: HWMON support
 + DebugFS + Improvements
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 Bagas Sanjaya <bagasdotme@gmail.com>
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/25 12:23, Kurt Borja wrote:
> Hi all,
> 
> This set mainly adds hwmon and manual fan control support (patches 7-8)
> to the alienware-wmi driver, after some improvements.
> 
> I have a question for anyone that may know how to solve it. In version 2
> of these series the kernel test robot found a build error
> 
> 	https://lore.kernel.org/platform-driver-x86/202503051819.bQ9P70Og-lkp@intel.com/
> 
> I think this happened because
> 
> 	CONFIG_ALIENWARE_WMI=y
> 
> while
> 
> 	CONFIG_ACPI_PLATFORM_PROFILE=m
> 	CONFIG_HWMON=m
> 
> How should I Kconfig to avoid this?
> 

If hwmon is considered to be mandatory, you'll need
	depends on HWMON=y

Alternative would be to use
	depends on HWMON=y || HWMON=n

and use IS_ENABLED(). Something like

	if (IS_ENABLED(CONFIG_HWMON) && awcc->hwmon) {
		ret = awcc_hwmon_init(wdev);
		if (ret)
			return ret;
	}

Using IS_REACHABLE() would be another option.

The CONFIG_ACPI_PLATFORM_PROFILE problem is probably similar. You can not
have CONFIG_ALIENWARE_WMI as boolean depending on code which can be built
as module.

Guenter


