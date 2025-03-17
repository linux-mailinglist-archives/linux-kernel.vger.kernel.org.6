Return-Path: <linux-kernel+bounces-564948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ED1A65D67
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7508189A220
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745AB1E51EF;
	Mon, 17 Mar 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuTCvLgM"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED01E1E02
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742238000; cv=none; b=tiAOjow7DfePoO1n72BUb3CCmbVNBf/3agkxdB3xkw4zmeAw4MoRFN9bP4LvS56KqMmTwi1FEbrDcbUHVwCKxgOcPHyIHX6U3ag7a+E24gTFOvH2sXsGfZkoUei1wSmUTB7tKYY7/QgdcbkxsTCy1V6EjpumTDqPw05h4LKZwlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742238000; c=relaxed/simple;
	bh=pX225uXGVkAghWGBd+3tEfc1RLklNoyG7i5BFjEc+OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHH5pmtrmcsUQcsnyPZqEDBhGx2+BjCUsPanaDHtxRDx/TxlhdwjE7R5TwWk7mfXen1qa8jF4iD02KG6ZvYfzmBa/vT2pIHsfg9BYa/7IE100VFwEH3GjFSS9R7zMV1SEObFM4TMv1W0HfLcmshvr9jQ4FazcO+5VKT38gZUBvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuTCvLgM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abec8b750ebso887734666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237997; x=1742842797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQDBp5VUuXQxeHvKepRV8hD89886c1C3X6r4opw27cM=;
        b=cuTCvLgMDvgRdKsoy0Z1Aa6RQ4Lq4haRw03GwXm7ZjvwGjidg+CJHRXt19pcAwEKLQ
         HQpxUhBt7voLBqVoNodDOY7RQ7dfVvbrhx2DckL5YozxO6t1Os1nNer+fuBmXbq4r7JB
         hr33fpZA0ia/IoPQCRsuyYYnk6F0vRgjWIP3na4M5CkIRLolPb9EswV64DzNkFlctdCL
         javFctWNbwehxnMH3yiqJijIzr991c82/UV7HA/cFyRQWTa7b5+oIwNj/Uub6NHgFEzi
         Ma81JXs9PV3N5/mjJxB8q6iygHbgWvbZjJk22mCL2+8xHGLqKLvoXX/sO3Cj9B/ncFWB
         NQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237997; x=1742842797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQDBp5VUuXQxeHvKepRV8hD89886c1C3X6r4opw27cM=;
        b=dLidF/GkL/ZUCqnOsnSSnli9m2PQnINaXXKVjsq+cIrdOlkNCoeBO94cNluYShNtLj
         QS5ycV9cYroS2rU0d6OVPAzffIMo9zNsW9RXMOYuJCoffwiEy48O+f/NB8TyoM7OPCzQ
         CVogaTOr6xu0wCzAo1kS4QMPYhd/Fp4M5eZAtBUy6Ffw/d6gddNUBiWTp3GIJ3dl0KMI
         Sq3HGqFxLCqSlk/BcOmoYoKFAD6/L689C+zXjHq/vj/4uYFIPHejS+gDSN/NPnJE52Zf
         mJ4E/8A4XQsJ9zUD3oZ0Y6Eh4c9tT2wCVncenWgKA+bcTSkywELnVmhujEzHNUj3N+R1
         qVtw==
X-Forwarded-Encrypted: i=1; AJvYcCU3E47c/sVgH1BSnPWblRf/ppyqvNYxzgMSosMeBULwqMf0hilRFIT6vbmaO0GUfKHBGyCOuWzWSUxGpP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKio86GMpFj5bjHuGNLVEylnL/W4eWiMXZ4Pp6yioZuFGom28
	nE71DXKbezloW+8zy1z4vNq+WRaLOWTp8CSbZCEJ0RXzyIa+0NL6KALJ9A==
X-Gm-Gg: ASbGncshpRf+dMPoqeir/rnjshMZ8xSZP1l2kYHbkUCVK0d93a2HEjdFA2n4a4edb+w
	SNEqDawvpPrCiJMGtsz0aunImP3yas2Q9dqYiQZOyQchiP59jKoWShP6CQLb2pgXrr0tpUh+FZT
	H63TZP20OAHAT+BdUeM9a43OuQfj/K+o4gNVFD/760y1eVTnc7f4z64d6jPpBUlRLyJXoF3a/6z
	wvD+xZnwytmCfaQw+4rH+x9PCQc4Os8CNekHXwXgxjxJz6cO4KzCx3MM7gmZ9p4QkteUfVmby1M
	r6UEljHlMESfNA5m/mZJUHspc6S4Ab9c8iqeBsJzSRI/S8sZif7h5YfNLVR71uuY5pu9DLruYUk
	h5nIlKYTOjYBiCN4Aw0zIFgj2zVOBS0fo5gSqtoWwduM=
X-Google-Smtp-Source: AGHT+IFI1RWc9drtLC1fsHugfGd+lXgvlP4qcKYD8ut0s0vnKJhFgSJfeW2USHvPBOFlVUHFJkS8tA==
X-Received: by 2002:a17:906:99c4:b0:ac2:b8ce:90d5 with SMTP id a640c23a62f3a-ac38d514ff5mr69895366b.44.1742237997088;
        Mon, 17 Mar 2025 11:59:57 -0700 (PDT)
Received: from alb3rt0-ThinkPad-P15-Gen-1 (host-95-252-211-62.retail.telecomitalia.it. [95.252.211.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e7f11sm704655566b.42.2025.03.17.11.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:59:56 -0700 (PDT)
Date: Mon, 17 Mar 2025 19:59:54 +0100
From: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: shawnguo@kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: OCOTP and DWMAC builtin modules are needed for imx93-11x11-evk
 kernel dev via TFTP and NFS
Message-ID: <Z9hxKlrrqW4QyzdJ@alb3rt0-ThinkPad-P15-Gen-1>
References: <Z9fhuVltKwqgHdLp@alb3rt0-ThinkPad-P15-Gen-1>
 <935028c6-ce56-46e0-96ff-46fa91c8f66a@linaro.org>
 <Z9hkDqcKG1xOmIB5@alb3rt0-ThinkPad-P15-Gen-1>
 <ef163f08-35f9-4d1d-8082-c826c6cd0aa0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef163f08-35f9-4d1d-8082-c826c6cd0aa0@linaro.org>

On Mon, Mar 17, 2025 at 07:12:55PM +0100, Krzysztof Kozlowski wrote:
> On 17/03/2025 19:03, Alberto Merciai wrote:
> > On Mon, Mar 17, 2025 at 05:07:26PM +0100, Krzysztof Kozlowski wrote:
> >> On 17/03/2025 09:47, Alberto Merciai wrote:
> >>> While playing with linux-next and imx93-11x11-evk via NFS and TFTP
> >>> I found that the dwmac-imx, nvmem-imx-ocotp-ele drivers by default are
> >>> not builtin then the I was not able to reach userland. 
> >>>
> >>> The following configs were needed to reach my goal:
> >>> CONFIG_DWMAC_IMX8=y
> >>> CONFIG_STMMAC_ETH=y
> >>> CONFIG_NVMEM_IMX_OCOTP_ELE=y
> >>>
> >>> is that something expected?
> >>
> >> You mean they are disabled or you just did not put them inside your
> >> initramfs?
> >>
> >> Best regards,
> >> Krzysztof
> > 
> > Hello,
> > 
> > By default they are enabled as external modules, then until we don't
> 
> So everything is as expected...
> 
> > reach userland they are not loaded thus eth and all the mechanism behind
> > that are out.
> > 
> > I'm not using initramfs just tftp and NFS as follows:
> 
> All arm64 platforms are supposed to use initramfs on defconfig with
> necessary modules.
Thanks a lot, I was not aware of that.
Do you have any reference?

> > setenv loaddtb "tftp 0x80400000 imx93-11x11-evk.dtb"
> > setenv loadkernel "tftp 0x83000000 Image"
> > setenv netargs "setenv bootargs console=ttyLP0,115200 root=/dev/nfs ip=dhcp nfsroot=192.168.1.3:/tftp/root,v3,tcp"
> > setenv bootcmd "run loaddtb; run loadkernel; run netargs; booti 0x83000000 - 0x80400000;"
> > 
> > Do you think that initramfs can solve that?
> 
> Yes, that's the entire point of initramfs.
Let's proceed in that way :)

> > 
> > To be honest I was expecting to have a builtin driver for eth by
> 
> No, why? We built as much as possible as modules in defconfig. Otherwise
> it would be impossible to actually boot that image because several arm64
> platforms have limitations of boot partition size.
Cool! Now is clear.

> Best regards,
> Krzysztof

Thanks,
Alberto


