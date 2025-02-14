Return-Path: <linux-kernel+bounces-514288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC17A35521
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D187A29B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD2D18EA2;
	Fri, 14 Feb 2025 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5ho3Lu6"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF952753FD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739502075; cv=none; b=nZNT3AIREPLc8Gj73gb32c1S8wdjJc4GkdniwmNLUo2zU7hsb81bHgBJ9CQp8QTVXt5iFi9qQ93Fcf6xL7SpdEjb0vsFmhlCJDbeuDOfcjeq5+P/WSl3ayjZEbPxOZ1Mzn1nWlIZUbluU9no2yWClQXu+cvIQ8535HexmLArdiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739502075; c=relaxed/simple;
	bh=KJvJysIsmaf/18xTfixy0CXTPEbocyW1TH3mI92lQS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSJ5hThOcjsaT0EFuq5q/ga0e98mPRQPSQKMf+noiVdZSaRQUyjUEgIL5r+ZeCF1hK5kfmR2vejBSkkMzlb/ry3krPYVDWxaHX3s4qy9Fn1dr3pY/En6MHDC21g7o54+OKpXyD/P05yw4RaQyMH8LqYfU2eiQEy0+jvletYqtms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L5ho3Lu6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54505a75445so1816707e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739502071; x=1740106871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CphyPEj/nIGWcbqF531VSGV3qr1xTmbTkezkMFIl3Eo=;
        b=L5ho3Lu6mXUbTmwggrCtI9W4Px6+JTFFHDPejrJQJvLNHlounyTUVCqYXxzkZY1Ui6
         XfUabC10xhvnwZhXVdNmsjPoylNUYpIJOaqfjZtCAO8sPcfyXl0c49InSk4Dnt0go4XU
         2sMXWorlgcGdERb3lJDkCOFJrZLYGnZH8VwXnixoemyDj7VW7XAkLTdGLtTC0hs0gj6s
         /4lu8khF4QJF3+75oDkLKDz/VFxZ7twb/CO4nTYzWXwucQzkMg+MrmnDDqMZUUJ44iPR
         YDtgS3q3fK2HN44mQpmQsRDEVNl2EGiF1UPASwBFPtr/hlBsqgj2GGOS2cDcQmP85P9R
         wXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739502071; x=1740106871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CphyPEj/nIGWcbqF531VSGV3qr1xTmbTkezkMFIl3Eo=;
        b=h21dS4aan2aHwY2KK/M5h7ZEH65kbO3gvoDx0rF86a8oeR/D3nhkDD3BpwobyJcE3P
         Mop9aQmEUATYKaFeq6e2A/lgZgIxkceKSu7QESzCqtiq+9hHkWtKgvjepdgIhLcCGWBJ
         C45LctWc2JIr5RbBvc3vNafY2hR28lOTs9ngxeno7JlKc13UbUKLJLjESSpDDa51ZxVO
         n63f4cAWdmRGddzhAYlkjkwi/mN9XeqDZJgOA9mrPLamQCAfg10PdODIlg1VLHHrdeVu
         eNj24Yi2W+CKx9tYJwg1t9+YB7pzfCQQHeu+Ms0mK3pGGXb3ryEihjp5sExtVWDT2Jrz
         7a7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv3hhoCYqrK8QJWT+6WMtu7z1ECD728217HPcuhVZEyFZnyfJuaNx/FLf4Cgj3msOHTpA58j/BqudcLs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKL7VdvvGSiM14LJ17ZAsM/ZCyjn+g/mdtd/TJaiN+YEn3/R1+
	KxEaekvX+X4dM8ZVfJf1YEJDnGre6q15ftboTVAS6ORkb56eUdZaPcRkA7QTLJoJtkpPYilrfwr
	vALIiuA==
X-Gm-Gg: ASbGncuasjfeF5MjOUqv/ppz7dZIab/u0tufl/G8dEfW+/HoOPLeXPuPEa3fMXjBK8L
	yGwVyPzN4fQMt+vb/ewtauqi8QyFY8ZbeY1ZpZ3R4iWhj2OjJrzsIp+PQRV3QcLZZVVr7UFtqBy
	wCoi4d5Nl2mTZ2ICu7amdIrvB1UcsnXQpsxG43LMmZycTwclQDOOruE3jtc/DOkDGKTWWf7vlvc
	qgAT97MQTEgAJcih/M/kbKFKHteA4YqcNnEGmAJ4BRdw6aNc4lHbZtjl4bOA9PN9R7WKxgGVrC2
	J6+wpc0Xr4KSoh2EqchoXuf6Ipqfjoh1ivkXClxxmwGaGNdsuSottMTh38Jg8A0vKJcyaTk=
X-Google-Smtp-Source: AGHT+IGas8108vTEmDl4sEKFFTKnVpl5R5NBfMLQH3mhDRcxgPA6rZImG+SqWw4u3LxjJ3511SnHWw==
X-Received: by 2002:a05:6512:31d3:b0:545:271d:f85 with SMTP id 2adb3069b0e04-545271d119fmr268944e87.29.1739502070997;
        Thu, 13 Feb 2025 19:01:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105c9dsm361169e87.121.2025.02.13.19.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 19:01:09 -0800 (PST)
Date: Fri, 14 Feb 2025 05:01:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: aruhier@mailbox.org
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] power: supply: qcom_battmgr: abs() on POWER_NOW
 property
Message-ID: <p5tszocxa7mcazgxsnt3gnv547m523gde2hj2yekiuoimm6rsy@pzofvxngb4ul>
References: <20250213-patch-qcomm-bat-uint-power-v1-1-16e7e2a77a02@mailbox.org>
 <yfbgbdugk4xdjpemozdzcuxczx4xd5aphykuksf3lhn22dsgkf@fcfgddu6gpyt>
 <ioiy4ixlvx5gxl3f4pqshwxz35ktrqghju2circpnd3qicgemc@oohazfsfvuag>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ioiy4ixlvx5gxl3f4pqshwxz35ktrqghju2circpnd3qicgemc@oohazfsfvuag>

On Fri, Feb 14, 2025 at 02:36:17AM +0100, aruhier@mailbox.org wrote:
> On Fri, Feb 14, 2025 at 12:24:18AM +0200, Dmitry Baryshkov wrote:
> > On Thu, Feb 13, 2025 at 05:51:38PM +0100, Anthony Ruhier via B4 Relay wrote:
> > > From: Anthony Ruhier <aruhier@mailbox.org>
> > >
> > > The value for the POWER_NOW property is by default negative when the
> > > battery is discharging, positive when charging.
> > >
> > > However on x1e laptops it breaks several userland tools that give a
> > > prediction of the battery run time (such as the acpi command, powertop
> > > or the waybar battery module), as these tools do not expect a negative
> > > value for /sys/class/power_supply/qcom-battmgr-bat/power_now. They
> > > estimate the battery run time by dividing the value of energy_full by
> > > power_now. The battery percentage is calculated by dividing energy_full
> > > by energy_now, therefore it is not impacted.
> > >
> > > While having a negative number during discharge makes sense, it is not
> > > standard with how other battery drivers expose it. Instead, it seems
> > > standard to have a positive value for power_now, and rely on the status
> > > file instead to know if the battery is charging or discharging. It is
> > > what other x86 laptops do.
> >
> > Documentation/ABI does not define ABI for the power_now. However for
> > current_now it clearly defines that it can be positive or negative.
> >
> > >
> > > Without the patch:
> > >     $ acpi
> > >     Battery 0: Discharging, 98%, discharging at zero rate - will never fully discharge.
> > >
> > > With the patch:
> > >     $ acpi
> > >     Battery 0: Discharging, 97%, 10:18:27 remaining
> > >
> > > ---
> > > Signed-off-by: Anthony Ruhier <aruhier@mailbox.org>
> > > ---
> > >  drivers/power/supply/qcom_battmgr.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --
> > With best wishes
> > Dmitry
> 
> I see. But as it breaks existing tools when power_now is negative, should we
> change the behavior of these tools or adapt the driver?
> 
> As it does not seem common that power_now and current_now are negative in
> other drivers, tools using these values rely on the status anyway. I'm
> wondering if it provides anything to keep this behavior.

I think it is a problem of the 'acpi' tool. At least 'upower -d' uses
fabs internally since the initial commit in 2008.

-- 
With best wishes
Dmitry

