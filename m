Return-Path: <linux-kernel+bounces-433506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC219E5954
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F7B284FF9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A2221C177;
	Thu,  5 Dec 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="LpUB63CH"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3C218AC2
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411179; cv=none; b=iXryqJbM7bX4o827ruG0bgyTHmHYgukXCIhnR9LQNeTqupq10B8fwZxhxdcJ5ekCjmXfE4sL10Zy3FtC+yqY2vlDM5Ld44KZsXHzF6niLCdoCvWfNMVMO49NwjmPpZRO5Y8WSr8rc7kvCAivOA4QCSx++NyIu8FhzpA6koMwMu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411179; c=relaxed/simple;
	bh=Qzir4cDqPRP4uUW2o+bZZjYGkwQV4zqZ/0NH7WgT0Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oc0Wy9++UX6RDVdckGW4hPhLiCbr86sencMxIxP41dqInhXK24Fv0+w4Q+qTjuJdV5McK/8skE3hcWagf1In7/mNaeSlba8LwNPbFQkLwPP6wE+Ar72Sd9AQUT3UMGNd/py+2nvxTuY/sZNIv0sUmhPIgy44OZGAQBeTgTJrO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=LpUB63CH; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4669eecd88dso6993511cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1733411176; x=1734015976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OqFlGhtdoPqBAsBXUfK8GHOXS7I6sc2ExEvs4W8qdcs=;
        b=LpUB63CHePfNhu7LMSRJoypvIjGDXxcCPCa8wejwug23BKfQhRso4hTggL9CKB9+3C
         Cp/IWj//v4RXev7DbZehoKO2U4LKdlsR+jMebhIptDcJ5NJ4pMzqn+PWVdK7JxzYbtln
         dK+kgeEYej5kdEDeFd7GRmRm3dI5/8i+wWGaxWbupewwku9nW/qwYmWHOLuGzVbw1SDu
         5UAt5/80kViLmIs5DRNhc2z6k/A9a+k7ks6gOxcqVFEqs9NOMfYeuZKG/Tyfl1q4zocP
         HTHvkDLCGOCQkLrsWDjpDJhlsQdFktYAU8a96gZbtusa68JBerXtAh6x9hxDGzl4LTGh
         TzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411176; x=1734015976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqFlGhtdoPqBAsBXUfK8GHOXS7I6sc2ExEvs4W8qdcs=;
        b=qmgOiiybFLqt8VG3OPYKZsQ38esb6dFAogCl0qEBVvTx1LwRvZMB5OX3mEbZjtvL9w
         DCED5pg9yLIuaAJ1ZXSwJoemB4D2t1lpuQwBrCQU7XLE3H5o3ZAq2PtRGX72E7GcrfZd
         VF+a2wqtzWkpMA4bw5R1zuvI1DlYnXSlWiri2u0dyv8k4CR9xqr294uPnjKJ3GctopAK
         Xm6jvUOnzDAA9qEvMKS+uMPA9HwkKbuIgwFt6FG7btnHnCvAF6k3IdFXl7NaNSywUOMO
         IbqXwVpK1rfFnrK2AO5gy29fAY+RLFELOcCqvmF1//ZaEdVNFfIkw2xbnAnTX9kU8hQf
         OQXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRwCGHdTAZblZmWmMTXiDrEyxw+JUoRyk81duBGKkJ6CBYbuQRSv2YbBAcQnJIA6wK/Y3e9HWdAymP+TY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/swqdwFir3Yzrb90gjkbC0yZ+DJbws4IBylc8HRodn6ylvSF
	Umk8zHuzDbmT9WyUyGsfCsXqnfRn+7YR6kFnJZU2HAaaoKC4WparRwZwNyxEPg==
X-Gm-Gg: ASbGncsof6BEpqetnb1z4OibxZUsrBpdxLBQMhlmda2HWNdjCAIAIxS/Yxieh2+id8a
	D+hrSFKt8ErUQLmuL7XSwoDaouPCXaG9l5Ff5jFMZibs/WM1/KFtaRVi8b21s0U0RRu6/sjEEPx
	qfgghLr24tICXYFS+hRmg25hCHXOuY7Y8gkX2p7ch9/EfOIbHrj+UVvMNf6bvSNacpFClEn2NRl
	S3WlTRK1XfyAr2p4lXLzlrdYlbPuxtxorXjOEOSYQGdcxUX8EQ=
X-Google-Smtp-Source: AGHT+IELmQdNT+1hsoXFGPSm28f9agdhcrSIwOgp6I2ewJudqY4XKJvMxXYV2ThqzvhMJRi9RwHfOQ==
X-Received: by 2002:ad4:5d43:0:b0:6d8:7fe2:8b1e with SMTP id 6a1803df08f44-6d8b7455674mr157979416d6.48.1733411175790;
        Thu, 05 Dec 2024 07:06:15 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::d4d1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a9e7d6sm67378685a.119.2024.12.05.07.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:06:15 -0800 (PST)
Date: Thu, 5 Dec 2024 10:06:11 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wayne Chang <waynec@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] USB: core: Disable LPM only for non-suspended ports
Message-ID: <a9f767eb-2196-4273-ba1a-19b07ccdafd8@rowland.harvard.edu>
References: <20241205091215.41348-1-kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205091215.41348-1-kaihengf@nvidia.com>

On Thu, Dec 05, 2024 at 05:12:15PM +0800, Kai-Heng Feng wrote:
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
> v2:
>  Add "Cc: stable@vger.kernel.org"
> 
>  drivers/usb/core/port.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index e7da2fca11a4..d50b9e004e76 100644
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
> +	if (udev && !pm_runtime_suspended(&udev->dev)) {

Instead of testing !pm_runtime_suspended(&udev->dev), it would be better 
to test udev->port_is_suspended.  This field records the actual status 
of the device's upstream port, whereas in some circumstances 
pm_runtime_suspended() will return true when the port is in U0.

Alan Stern

> +		usb_disable_usb2_hardware_lpm(udev);
> +		usb_unlocked_disable_lpm(udev);
>  	}
>  }
>  
> -- 
> 2.47.0

