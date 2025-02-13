Return-Path: <linux-kernel+bounces-513999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D56A3512B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AC7188ECF7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D521B26E14D;
	Thu, 13 Feb 2025 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8oiwHZK"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C53266B59
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485466; cv=none; b=nEetgR+HLc2d+NmeYVEuv5rV55pwfen6ZS7DOmyhorbKNM7y1v7nxxhRYAel95NFd0Y2tzMes5WwgBwMR8RrdU5O1PzKNjxzK39KBlpuW+bjx09Sm2Fnwj4x1nXvbueagHii2pi+7e7lNA51G8S4hK46bEUFuWj42s8UY8wECOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485466; c=relaxed/simple;
	bh=7FRfjoGFhfUSUt468TjZa6ZCPVf+awWsq/1VBYfIRuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rr8tOCE2x/ir7eERhbnMnA6d1lWfa6YByt5j8fMG/GZmktP1G5kckzL73p0xIUjViw3kI4ID2nYoOuQy5UQmrdBWnnFQD2wCufiG1REcc/5bSl6fVEONnr0pvOzbfe2TuESn61TNEqNcxlC7qkQCroVFNIUNxC12GZhU/d7hcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y8oiwHZK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54506b54268so1360476e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739485462; x=1740090262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=30VlZ7jh4l0IEP8QnG7/qbFduRo38zLaP6BKsGUzZqw=;
        b=y8oiwHZKt0YgBCbAg5t+SxwG1YA7ts5LGsMlOC5bAan4Gwn3uoDcJre7tIsCvY+Jr6
         AGKJDoKwr/Pe96R0/r9+B+1plf1X26uRsSwSSzIuOzumm3DeWfnxoOBllqgqVC1Vq+co
         pZ3WYgY6H8GIxnnGpp29Z75wSSouVJlnBsu9Jde3N0fBJnEREZ/7Gu8jJuIu4oTjqsiZ
         vJikLet9XSXD/7+wlAOEMxi+Ffu4doCexCUJO1BCiRRH/lNVU2fPB420GDzKA1U/3lz/
         jRG00VODDZyL5an01O1L2VKhelZsqE01TYgEOdxdSpEcSYWyBy19EwqZQ8hUAW0h5bG6
         lN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739485462; x=1740090262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30VlZ7jh4l0IEP8QnG7/qbFduRo38zLaP6BKsGUzZqw=;
        b=cZ1BPLw/61LbnMATqhRslHEFF8f9+TzPXDH0KF0gn85SonGKxS25NJwp0qW3K9Hjcc
         C5pksQOnSKwudZ3uRutycKbdwTlzPdzEg9u3e7tgDkPz6OO2hGzY5RI9jyySodb5Cwci
         MxRVYo7d0TvzD6MQwtYZ9vCTV2DHwWD64yEWSp7YNSGEMcbhuMWU1ihUSKUkpujAvuaf
         mkAP2dcJDIsKlvwOLPEjp6OA11YxyVPz910i/gORROnpOPBE/6ZHniG7UVQiJVrV1/+Z
         SOWYVGbw80L12YR9tCevPsOShNBsFWCuxzuYf4XFLhsAVLPHG9upp700yOSMgsPVxzg5
         USgg==
X-Forwarded-Encrypted: i=1; AJvYcCWMlVjyGbxoxgHMNgTtmfoeNvow7YK1xuLk9HV0Yi0xSfyREsSh3eB42tYkJPc1EiAFnoRrr7T0QhfYyuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgI69ieUUwW6/1zwa7eR81lEq5boVTwm92dQlx/dB6xqioOdoy
	+mW2P/fDrIWzSyk/oziMdafYVmH0oPtRJk+ieqNzl5U2tvruRuIkYU1sjZqx8rA=
X-Gm-Gg: ASbGncvZwc51rIE86gCNrRfuv3tpZRkRwgPkAj4dW1dWUvNjBJNakS0FLVeUS8/sId3
	HHACNlu8gY7Vnpq3tzNFlsUgvqbTTnsx1688n97QqiwxVlTkOq61IGkk95+e86KBc5C4+jRkOPI
	8o+sCxxjOAQgNjctOqbctAD3w6i1Hx3/Wc5JcrSvcFBRXcQgFwaH6rrdUwo1KrdB/YbKVkWH0DL
	lFVbn/+G3bT+qKa1iiCl+knCqo1GLKLu1Bs+U3sJ3J3g5czHdso9KX3fnvOWV4HD5l1UMEZGA3y
	FdMybv323WScu7q2QloN59VvmHWV+gAzdHDSEUZXReBq+fpsUTDgu5POgdyaJwkwKq6Ho2M=
X-Google-Smtp-Source: AGHT+IHuu1+RSvJrrCNOvck4+O9LWm7v9dHEk7GUicB1Vdkhxazd1lrqf+b7glyWor8ZgNaAhVRjGg==
X-Received: by 2002:a05:6512:ea6:b0:545:16f0:6ca2 with SMTP id 2adb3069b0e04-5451ddd6730mr1552626e87.42.1739485462508;
        Thu, 13 Feb 2025 14:24:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f11ecf8sm299005e87.243.2025.02.13.14.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:24:21 -0800 (PST)
Date: Fri, 14 Feb 2025 00:24:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: aruhier@mailbox.org
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] power: supply: qcom_battmgr: abs() on POWER_NOW
 property
Message-ID: <yfbgbdugk4xdjpemozdzcuxczx4xd5aphykuksf3lhn22dsgkf@fcfgddu6gpyt>
References: <20250213-patch-qcomm-bat-uint-power-v1-1-16e7e2a77a02@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-patch-qcomm-bat-uint-power-v1-1-16e7e2a77a02@mailbox.org>

On Thu, Feb 13, 2025 at 05:51:38PM +0100, Anthony Ruhier via B4 Relay wrote:
> From: Anthony Ruhier <aruhier@mailbox.org>
> 
> The value for the POWER_NOW property is by default negative when the
> battery is discharging, positive when charging.
> 
> However on x1e laptops it breaks several userland tools that give a
> prediction of the battery run time (such as the acpi command, powertop
> or the waybar battery module), as these tools do not expect a negative
> value for /sys/class/power_supply/qcom-battmgr-bat/power_now. They
> estimate the battery run time by dividing the value of energy_full by
> power_now. The battery percentage is calculated by dividing energy_full
> by energy_now, therefore it is not impacted.
> 
> While having a negative number during discharge makes sense, it is not
> standard with how other battery drivers expose it. Instead, it seems
> standard to have a positive value for power_now, and rely on the status
> file instead to know if the battery is charging or discharging. It is
> what other x86 laptops do.

Documentation/ABI does not define ABI for the power_now. However for
current_now it clearly defines that it can be positive or negative.

> 
> Without the patch:
>     $ acpi
>     Battery 0: Discharging, 98%, discharging at zero rate - will never fully discharge.
> 
> With the patch:
>     $ acpi
>     Battery 0: Discharging, 97%, 10:18:27 remaining
> 
> ---
> Signed-off-by: Anthony Ruhier <aruhier@mailbox.org>
> ---
>  drivers/power/supply/qcom_battmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

-- 
With best wishes
Dmitry

