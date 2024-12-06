Return-Path: <linux-kernel+bounces-435117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046CA9E6FE0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955FF1885368
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA9520ADD6;
	Fri,  6 Dec 2024 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ku0pRdJ3"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8B206F25
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733494390; cv=none; b=Bset6noAqJFh9LEIpFVIT0fsyTs9AsT69VILTr/Wzl29T1UNtDmyXdJQbKjl4H4Jdwq1pGKTXqMGgZw+NtrKm6jcGautzaBdC+1RmJSC6dLzdx2wXd3pifWffD8HA6DUA+jFrRa3FudkRCE5knDEfMmamuFitUb7rEnTMGd6VJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733494390; c=relaxed/simple;
	bh=Ky0xTycKUZkk3hyyBC6n4I32KZnP62ZRkFAtoMGnQjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBHK8lcA+pJNw3q4aD/hfZZCI/YMUoF8ZGmSIG+4NiLdUHe4zgRNQCdriykl89VxLT9CWO+7J/Y6Xvyx0oHXC/isVp2Ly6MTiLxIF7sBU8xa36WniFFxiDY7Q6QHzU1T94bkGBuVGP/ZOAbu+oD/yXHSPkF/2Rs5l6JEsWDt/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ku0pRdJ3; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6bf4e3de1so41441585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 06:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1733494387; x=1734099187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSlfzGrYKdsTUt5xgNec45rqOgruZrd85AT5IIIufHE=;
        b=ku0pRdJ3Fw5Hm5DFwlGv7qcQWzpcMw11bFLPOI5smweegKpwEpVmzVigGuKCViKeLv
         vuapzFjxzFOcuXMd09YXG7Vvs+xJySaMihCVqLuPKkaOf24ZcX2z3G6ljZP5PMlrJxmf
         9RJ6rPk8u0T04wuPcYr4mEPUZHLZXm6acaU72k9rvt+c4jN3H4xumlQ6DPG6iWvaTHI9
         TTj5aDiKbUkiHOMF8uULSkLbo6MMZdRnYTg4xo/3Ubn9p5Q2/NGl8oIshHtl+G3KOD0n
         LwWz/TV2ooJM7njkQMAgN54OWOvs6+JT7cwFfgsFvMhXisWVA6JCOKmSpacTa0qNP8m4
         LiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733494387; x=1734099187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSlfzGrYKdsTUt5xgNec45rqOgruZrd85AT5IIIufHE=;
        b=leTR/gsjdZGteNPEKTi14AGpTxrbEFLR9BBvOpQegwxxy1qaFDb7vNXXJUlbQMLm0r
         8Rw2NlQxEm++Fuss6lRVwInZ7Ptr7psQCQsDi+SvfO4Rb1Rl+LlAm3+kS3t5reWJccC4
         PpY//FVjeH1c6Qij0d3lcCty/mixLiOKK9dzFP6Vg3Xm9dVXlq4l1Mkcvo/F9XwvnQoe
         RtHTYrBd7AKq9SJMAEKzx/cje0Q93bC8UQnQ0/YE9OH+SeDMBeZOqfsE3vur9t6RnoOm
         atLtBW4vU/qq5MQC7HUd7W8ppnTRL4KlcuPmIUP2qxWnM0QOuztnqsAYEb+DlfJnfel2
         ZWag==
X-Forwarded-Encrypted: i=1; AJvYcCUBvSe4HokbdpwAPUJBWmGOIFyM1p4nHg0TFXyoFndmM2pHQjM4BzBUxuF/KlNZtm0hioq/aAOGQnYA6WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxj+Y2Apj3Jrn5ll2/DJnBOEO5iJt/BpjsWWIsuk0B753cQ5I
	qqzfhqsdbVHiT3AuW3f6QkLmCwfEo69mqyGfHpCbJ7wzxJS0vVAvuTb3x9DWSw==
X-Gm-Gg: ASbGncvekeyBttwY7j3O9gRTGLzmJBLfmrr8FA7sffvp+sn9jaMtIl7NmzyJyQQtfhf
	w3qWlTDhk3i9pdCVn2Zd60k0971u92leeoIyefg0oXIn6flLgD0ls95oQcAaRiULNCpRtft+Kv/
	wf2XMWTqivKCmFRYNVSykOWQyALlrFbvamY2tcFUBneI4+LEjQqmTuJVp9SUL9Qe0x2wMGtI43o
	KemuvJmIPp64RIUeLDNle7Ndlm+hjGcmGbo6sbOXweyib66J7A=
X-Google-Smtp-Source: AGHT+IE70N2fo5/39zy6vDHU1B5QUupz5J4HOppahroXdi/TPSfnv0dn4woZWOZyAc8PrIqeDQNhGg==
X-Received: by 2002:a05:620a:4144:b0:7b6:7653:edf5 with SMTP id af79cd13be357-7b6bcaf6ac0mr329245085a.29.1733494386825;
        Fri, 06 Dec 2024 06:13:06 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::f39d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a9e348sm175791185a.101.2024.12.06.06.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 06:13:06 -0800 (PST)
Date: Fri, 6 Dec 2024 09:13:03 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wayne Chang <waynec@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] USB: core: Disable LPM only for non-suspended ports
Message-ID: <92e615fb-4d3b-41bb-ab80-b54227c743af@rowland.harvard.edu>
References: <20241206074817.89189-1-kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206074817.89189-1-kaihengf@nvidia.com>

On Fri, Dec 06, 2024 at 03:48:17PM +0800, Kai-Heng Feng wrote:
> There's USB error when tegra board is shutting down:
> [  180.919315] usb 2-3: Failed to set U1 timeout to 0x0,error code -113
> [  180.919995] usb 2-3: Failed to set U1 timeout to 0xa,error code -113
> [  180.920512] usb 2-3: Failed to set U2 timeout to 0x4,error code -113
> [  186.157172] tegra-xusb 3610000.usb: xHCI host controller not responding, assume dead
> [  186.157858] tegra-xusb 3610000.usb: HC died; cleaning up
> [  186.317280] tegra-xusb 3610000.usb: Timeout while waiting for evaluate context command
> 
> The issue is caused by disabling LPM on already suspended ports.
> 
> For USB2 LPM, the LPM is already disabled during port suspend. For USB3
> LPM, port won't transit to U1/U2 when it's already suspended in U3,
> hence disabling LPM is only needed for ports that are not suspended.
> 
> Cc: Wayne Chang <waynec@nvidia.com>
> Cc: stable@vger.kernel.org
> Fixes: d920a2ed8620 ("usb: Disable USB3 LPM at shutdown")
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> ---
> v3:
>  Use udev->port_is_suspended which reflects upstream port status
> 
> v2:
>  Add "Cc: stable@vger.kernel.org"

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/core/port.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index e7da2fca11a4..c92fb648a1c4 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -452,10 +452,11 @@ static int usb_port_runtime_suspend(struct device *dev)
>  static void usb_port_shutdown(struct device *dev)
>  {
>  	struct usb_port *port_dev = to_usb_port(dev);
> +	struct usb_device *udev = port_dev->child;
>  
> -	if (port_dev->child) {
> -		usb_disable_usb2_hardware_lpm(port_dev->child);
> -		usb_unlocked_disable_lpm(port_dev->child);
> +	if (udev && !udev->port_is_suspended) {
> +		usb_disable_usb2_hardware_lpm(udev);
> +		usb_unlocked_disable_lpm(udev);
>  	}
>  }
>  
> -- 
> 2.47.0
> 

