Return-Path: <linux-kernel+bounces-373244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29609A5446
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88291C20D35
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6852B192D89;
	Sun, 20 Oct 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRZyw5aJ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6145B674
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729430160; cv=none; b=sK9SJVUcVVjLwHmYAKdhBGzeah2HohgwgnGf3HMaUbnimcsrafbB3Cvrbnkh0e5uc3Xp1vQvgSW2G9Svg+kjiznM8rQVw14P/X/rmx5M9OVmhllaiqX0OOVr5K3XptKcwlhPABqjJtIVS0MKdaD+KdOxW+9CdcvhlAHPckbhm+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729430160; c=relaxed/simple;
	bh=uKgjva+0ctCwkivt4M+aYeVvXG0QvbFTOwa82+8Ezoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwIpF3XFBr1Va5N3nPjrI7fqZJJsDFcMi5m0xywTOF3IaaQC8r3LQqjs4GE50mlWetGgo0u/gy1ir2RnIoZTO3zzqjC2vPlroI3uH/TIr5WmWe/5FODC5vYS3pGvY2rb5KGHP1E9bNl6bwZrPPh9ylFYuLk2pmpelxNg7PWF5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRZyw5aJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f7606199so3889588e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729430156; x=1730034956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYwZIeGEIc7VnkIRXpz4d+bHytScBmaxexHgM4ooyL4=;
        b=SRZyw5aJZwxgCJteX331J+Ygei7AymiR84aR8o5Q7YN5BGBacHK88kqyr5ieXzFx+s
         GKb5nMNlUYnw+nNs4GgIkY1mp52Zt+J3HhYPDvjB3+NKW4VBg9GTeLDl2p7j+xTxuN+c
         5LvREnzVK8DDp5X3biwTPEs45WqYUpRoglTr/z3OPyZw4v0L3t4OxypzvIKQjMJC2VmS
         7InkRCQ7CLwckxh1xlQJJbKoNL0mhdlwblfhXe6RxkKU/4A0IuDQDaOrdYWfqr7PxK/z
         EdUB2kEHtB0JVJCsMk4LCwNuhF9hEZDPRpuH1PiWwR+ZXq92v3mjtckhGFwwM8PFNOKv
         P1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729430156; x=1730034956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYwZIeGEIc7VnkIRXpz4d+bHytScBmaxexHgM4ooyL4=;
        b=UtGtp//LhiVE86nBEs03iYYuT8SRtWCCWybfxQxzXI/ejFGfcemHaY1x01xs64AiRF
         L2pOcVHfHqSkGJdZnSh+FDxB9U7kI0D7902qMCQ3f7dmxHl1KCT28Mx1zKzQpsynjDir
         HOCNt+1iD49m2Bh0fFBKDU2if3jpxbo1lrod1KOaaCvlWUth3SL71Bs+jThWc9iRZwaT
         m/Itdh3NzcC+IhLC6D57Jp8ZuljCWkl/u8TSnBqBBbEmdQ3ihJy234QgpUKzlszkoE0L
         +z6lgDrTeG9JIVGodwXNhRNY0bWG/JHIQSODDIcZg8/zB2e8lygDE0z00NndLk5IzFpj
         IMZA==
X-Forwarded-Encrypted: i=1; AJvYcCX+iEuklJKny3UTCvshkTJtQejDOXGXP9GFUAaBvn6+fj22f6vW0VW2hcmT40nCQGduUI45fFdOL9c/5D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8Cl2wwcRH4kAKnpoNYbppTOlcRY6RYlMgsxtltEtDkaplMEb
	AFy6y3lUz+g20SWh9z48wofTjdwZCB3EVfINch9jf4aRSE/pi/FRAvccA+HOhsU=
X-Google-Smtp-Source: AGHT+IELxOsBj0URcEerkg6VeNl2eSHEE8fsdZdOVwEJm1At+CtbZCT/15/LMiNV6gF6vzcZLfV0qA==
X-Received: by 2002:a05:6512:2399:b0:539:f7de:df6a with SMTP id 2adb3069b0e04-53a15459fc3mr4475921e87.52.1729430155912;
        Sun, 20 Oct 2024 06:15:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e55f5sm220175e87.34.2024.10.20.06.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:15:54 -0700 (PDT)
Date: Sun, 20 Oct 2024 16:15:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: qcom-pmic-typec: fix missing fwnode
 removal in error path
Message-ID: <hw2m5c5wakwm4jcihammegpuydm3cbhxyzaln4p57w6ybkaaea@fx6thktwjuty>
References: <20241020-qcom_pmic_typec-fwnode_remove-v2-0-7054f3d2e215@gmail.com>
 <20241020-qcom_pmic_typec-fwnode_remove-v2-2-7054f3d2e215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020-qcom_pmic_typec-fwnode_remove-v2-2-7054f3d2e215@gmail.com>

On Sun, Oct 20, 2024 at 02:56:35PM +0200, Javier Carrasco wrote:
> If drm_dp_hpd_bridge_register() fails, the probe function returns
> without removing the fwnode via fwnode_handle_put(), leaking the
> resource.
> 
> Jump to fwnode_remove if drm_dp_hpd_bridge_register() fails to remove
> the fwnode acquired with device_get_named_child_node().
> 
> Cc: stable@vger.kernel.org
> Fixes: 7d9f1b72b296 ("usb: typec: qcom-pmic-typec: switch to DRM_AUX_HPD_BRIDGE")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

