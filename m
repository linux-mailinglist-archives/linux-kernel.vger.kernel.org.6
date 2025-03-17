Return-Path: <linux-kernel+bounces-564855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE629A65BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A937A2AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0351B0F23;
	Mon, 17 Mar 2025 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJXba/ZC"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8411A840A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234644; cv=none; b=UgVZnD0VhuaOZ39iJweZjNxysvkqiOzvlV2i9oj1MqZe3IJe/8zi03f3e8Pv3iOO83bZOh8fxMITKKbfthMBEyZ07NsNWZ+JZvDJOm4do7Jwn5iaXFu0I6gsj8u4W+306zNP2x64YaxYRsxel+oDkMLlMWZq7qinqLU070wTnuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234644; c=relaxed/simple;
	bh=awgPAnbrbkaZkPs7TRo9ZTe/vWz9ohJbUh9GSIfTsRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPSrxItoH4rq8Eud02AdJUXc+3hZaHjQCtJccCuNNKikWePQsbITe3743pA2lduq+wCF9iryAps8gQzrYK4/rFYZzTVijv/habso2Y8bYdEx5S4IVYHOTa+34DbhIQ6WznvjthOfPlZBIg9hrbHVBLTHVIGhnnJRH7kXVXlCtkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJXba/ZC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2ed007aacso942335666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742234641; x=1742839441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMs0KQ2xoYfGwipz0GcDyzvKZDx/2Bps5YmVJfONNew=;
        b=EJXba/ZCO66ATx803MBlGwRaZxtxopTxIUS29nO9v63Jux87Avu+u07TksKGwwuNrs
         YGB3m+7yuqHPM3mMlpkgWP7peK813v26FM5tm/7zMupgXdbReUqEADMtF7gqPAG5IArW
         tRAyC75DnGVC8Op6fekVRO1tKReq3fgiJhsc22fXVo/w/dgiS5XnJjtlfRusGW/oNP3a
         90voKuHvWSyu2R7DC30wg3HQBJYVo17/4C339294WkqnH4M68yVyDQ2jaX4TNa3yVqAs
         xuKthDE/lFnKP07ZAH1caHVi3ITHw6s/nNaLvgnbp9XRsaztzZT8UC7urNabyYnxmZpT
         R/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742234641; x=1742839441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMs0KQ2xoYfGwipz0GcDyzvKZDx/2Bps5YmVJfONNew=;
        b=g7BYMB+nB40qPPf8r/Dijx0H8mcIaWddnCwbp78MQt1+FLW+6p3mxbKp5vFbStTJDq
         jDGGBY9DzkbegzN1whg5sAbCrSxqakV0goO7LMOjoMXC+0Bmo/AhtBSTfxGQAznHcyjj
         DnLhxF/ObR/vBNDIue5X5rK//k5cERlCe77q6/tTTSj32QMJaFUfCbEDqKYDzhMozUaq
         vIedOucHYdib+FwnucZeR5gWB+mwjJgE9sbJjMJ+vdxMWN0xaK3a2FLfPBLbQXGXQg96
         GyKaww3pxRO2DS3mD0CK+j0tMM6d+j7xD39jxolJ9Qf1QpIVhE5OXtCCgh4WYa5Tk5rJ
         sYuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR8cED+ka6xI+1yzXj+BxNMbNVaz8NNPMHIm0IGj8dAz6BOBqznaJiVYeNPENx9keX9gDMtvX1aiNu3u4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn2HN+4gbOBEqiQ8Z9WPpcgupCXho6hHXjDihZMD8EulFx0dTk
	qZ7KHBbzNBpA/EIkCxtF3Ph0ptpwRK0DNmwtl0ySKWWTVb50rc0X
X-Gm-Gg: ASbGncuN/l5Ivae3qkmIK4qo2o+EYuy31w3jAl+yZnCImNXJo69fn697XeCci6eUxbC
	Z0LsP+uA4CUt6dzzdPmXPGqCVKbxyDV8Sw7+CQmYXIrYFuiDJL+r/2KgkEG0/Ahv09my1ws49gT
	onY78IqsOVGz3EwFvSSYj85FSWbcU6Z89TlCIM4/ft34vyMDG+e6268xL6JllEDLHJferlh4M5x
	mxhNw9vMwVcp34TojrGXq9ow+vPRApvAkkYrNBy6n3uM7F8ynFYR5J5LMYfHTl8coUqbBi4ruoF
	AoVqeHgYJZt8o0JC7bh4Q41WemB0teLUk/FJ2PU2CLf+iH6Mx0Ep/mO7/yLK1xxp3oHnHcuDITK
	VAM71/McuqmBK3CZdPTR5jyXcKw/BQKwQCuG0dskbAaYA4bWSbHjumA==
X-Google-Smtp-Source: AGHT+IEqHcYMxvD4RWbMqL7gZkeMlgl4L7sidotxxKm051Mjf5HVCCNTwf97wRSQF+aZjoUe1nGS6g==
X-Received: by 2002:a17:906:6a0a:b0:ac2:b414:ba2a with SMTP id a640c23a62f3a-ac330376bb6mr1524996566b.37.1742234641045;
        Mon, 17 Mar 2025 11:04:01 -0700 (PDT)
Received: from alb3rt0-ThinkPad-P15-Gen-1 (host-95-252-211-62.retail.telecomitalia.it. [95.252.211.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cdec8sm705009766b.112.2025.03.17.11.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:04:00 -0700 (PDT)
Date: Mon, 17 Mar 2025 19:03:58 +0100
From: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: shawnguo@kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: OCOTP and DWMAC builtin modules are needed for imx93-11x11-evk
 kernel dev via TFTP and NFS
Message-ID: <Z9hkDqcKG1xOmIB5@alb3rt0-ThinkPad-P15-Gen-1>
References: <Z9fhuVltKwqgHdLp@alb3rt0-ThinkPad-P15-Gen-1>
 <935028c6-ce56-46e0-96ff-46fa91c8f66a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <935028c6-ce56-46e0-96ff-46fa91c8f66a@linaro.org>

On Mon, Mar 17, 2025 at 05:07:26PM +0100, Krzysztof Kozlowski wrote:
> On 17/03/2025 09:47, Alberto Merciai wrote:
> > While playing with linux-next and imx93-11x11-evk via NFS and TFTP
> > I found that the dwmac-imx, nvmem-imx-ocotp-ele drivers by default are
> > not builtin then the I was not able to reach userland. 
> > 
> > The following configs were needed to reach my goal:
> > CONFIG_DWMAC_IMX8=y
> > CONFIG_STMMAC_ETH=y
> > CONFIG_NVMEM_IMX_OCOTP_ELE=y
> > 
> > is that something expected?
> 
> You mean they are disabled or you just did not put them inside your
> initramfs?
> 
> Best regards,
> Krzysztof

Hello,

By default they are enabled as external modules, then until we don't
reach userland they are not loaded thus eth and all the mechanism behind
that are out.

I'm not using initramfs just tftp and NFS as follows:
setenv loaddtb "tftp 0x80400000 imx93-11x11-evk.dtb"
setenv loadkernel "tftp 0x83000000 Image"
setenv netargs "setenv bootargs console=ttyLP0,115200 root=/dev/nfs ip=dhcp nfsroot=192.168.1.3:/tftp/root,v3,tcp"
setenv bootcmd "run loaddtb; run loadkernel; run netargs; booti 0x83000000 - 0x80400000;"

Do you think that initramfs can solve that?

To be honest I was expecting to have a builtin driver for eth by
default, so that NFS and TFTP can be turned on without caring about the rest.
But for sure I'm missing something  there :)

Thanks,
Alberto

