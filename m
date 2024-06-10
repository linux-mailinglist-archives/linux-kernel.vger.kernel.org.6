Return-Path: <linux-kernel+bounces-208648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA359027BA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636731C21ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A721487F1;
	Mon, 10 Jun 2024 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t1YrASoQ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C042B1474AD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040359; cv=none; b=rc3+l56oxWp/ACLe8WeFcaViYrIJ7KPTcpTp3UPtW1+xhqR3hCBKiT1/FejxRwGkdB9BKaaxiqJRPRjeRYPFkFQk00pupy1BRwEzS6sHl83kq/qAIQFcB012neC/iI25XVKiV9HiYlDc3+Z2pWal0FrUZJjSvhzOBnwOgxJ6V2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040359; c=relaxed/simple;
	bh=3m4/S4G2Yh24KJS9ZtKS2EJOg00cUqAvaAz79rtTSWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXflWUcWg/WR11T6AcTaAdl6K7Ko4tsA9vWNFgyJc3cf6WAWLq/Y3i5AJbEoCNmDfaStQL6wOGnNURb+BJDU5r/AkDs33rLXGPVIZz9u9dGbzlAcjDgTtvDfDZKyYHkcg5E7WCcVToMaqmltSxGHlLYWUo7ThCkq7ZNaogrfm0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t1YrASoQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f4a5344ec7so34849975ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718040356; x=1718645156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=abr2ue7yuPh0+wQBY3PyFrKJ/pZr3cN2Ly9RsxIqGXM=;
        b=t1YrASoQzEV04/Jsy5xWnQ7Wp3OKDgt851PCeUvNzJYb3eh2LbF4zuxDcvrVXngB8C
         S4FtvwsjrDo+qKMfYOnlTjT0S/cDVV1cRuIkHgNwlSe9W6n5kZDqTbUhOB2sppZOGium
         9Z9lL8gqF6Zqo/emMWuG8pAwEBOfH4oQc5TP1HjycaIROg4GuzrWVuLK4yND57QAsjCq
         J1cIGoKc8F8ha5rk13SutILtSVR2MY/2nOloAyZWZnXmANeyGBODlM2JHwZ4H6m55XwA
         1ZYvH47utQfZiJ4imZH91xuEYU3C6rK4VdcQvbt8/J/FW5vCvmrK2bwJ7AhzLjE/D5hx
         MGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718040356; x=1718645156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abr2ue7yuPh0+wQBY3PyFrKJ/pZr3cN2Ly9RsxIqGXM=;
        b=DD1hbgJpBDSO2eaYjvkKKweyfU5wTs19z2qCt18S2Fnw/ArPBYJB8mDgbOIyPuVhyQ
         kmJfxpGMS7kkZdAgG+iyofRyHFtlwgi5GSMvlyh+FUa6O1HH9cHnWUqCii0ctAaTkg3g
         aTVKVnDoirLCoerMATFLCPfg8qP0UmQ0ZMQ1D21qrDWAuXtSB74Tk0F73fxv0/T4g6IQ
         nphwGf1m7ViJOEaBMNHFerVGyOuUNnP9zZRIrlIun9LpLoAT4iZCfIfodXClcTF7prP7
         gj+v5NXv3iGVR6QHDLZdqii6uTdIocESJXgHW0IiOivbISjf6HF930C/lb+tbqZ+371j
         x8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXWaKtN3haKi4vvzvBViefYoNekBmCtibBXCwtco2zbmvnRrufgL/wHvjTyIf3us4+afTRbPryXjaAIwX9P/HEPdsa+MWBzo0CkGKOZ
X-Gm-Message-State: AOJu0Yxpl0bHMrm6KuqMDJmoVwOHR8c1mNT39wAj4hKeay3XDWCfO7GD
	q+k4Nilap8mvB9HeWQkznySjDafNfYlcI2PYaSdxrwhdbx1Hwj+y3cCgSq95998=
X-Google-Smtp-Source: AGHT+IGG9+tJMQkgqsvCDc/nEkepy3d2r8n5n6dXzQzqVihO3brF8FWb4ywE8Wcq3W8Wme+D5vSwgg==
X-Received: by 2002:a17:903:230e:b0:1f7:9a7:cd33 with SMTP id d9443c01a7336-1f728792081mr3720315ad.3.1718040355962;
        Mon, 10 Jun 2024 10:25:55 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:9b34:fecc:a6c:e2bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7f7ea0sm86056265ad.270.2024.06.10.10.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 10:25:54 -0700 (PDT)
Date: Mon, 10 Jun 2024 11:25:51 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rpmsg: char: add missing MODULE_DESCRIPTION() macro
Message-ID: <Zmc3H6PN8WPpgXNN@p14s>
References: <20240604-md-drivers-rpmsg_char-v1-1-675453267fc6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604-md-drivers-rpmsg_char-v1-1-675453267fc6@quicinc.com>

On Tue, Jun 04, 2024 at 06:53:44PM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rpmsg/rpmsg_char.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index d7a342510902..73b9fa113b34 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -566,4 +566,5 @@ static void rpmsg_chrdev_exit(void)
>  module_exit(rpmsg_chrdev_exit);
>  
>  MODULE_ALIAS("rpmsg:rpmsg_chrdev");
> +MODULE_DESCRIPTION("RPMSG device interface");
>  MODULE_LICENSE("GPL v2");
>

Applied

Thanks,
Mathieu

> ---
> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> change-id: 20240604-md-drivers-rpmsg_char-02914d244ec9
> 

