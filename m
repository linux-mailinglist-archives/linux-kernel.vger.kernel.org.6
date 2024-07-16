Return-Path: <linux-kernel+bounces-254015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAE0932A35
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A82EB21ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE3619DF94;
	Tue, 16 Jul 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dn8L3TNZ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB32B9B3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143014; cv=none; b=Aki1rsyRA15bCLqcOvs/z5i4LdeuVXnWyhRE4Dyu304BgB9Vavc7mtIC5rlYIKIe+iRkeYXt3Pc/kdDFsnbZzcjMZ6ijVpmQWoZCo68Q0DqnkQ3rtZ7UWmHdTnIMMvmH2jecVgrBBuYTahQ8u6CEi1V12n39Uswkox1wVmBgWJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143014; c=relaxed/simple;
	bh=QdugAtkkmtyw1j2n4aC/U95y3fRjs/Qu67PPL3gShUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqcp1DP1c6EsjspJAKcWE0Z+BmD7LI7V1frHaKXHruF5mfiS/gXlOnWyUGt7r6dvBsIm2hmu9pKY1GasGhSGU/abVmzAIkhhkoxZ7OMMdcDiIz5Kzo3hhe9IKy4C7GEvF7knyvQWMqKF5OW/2NxAj8CuG5ssy2EbYYOgfrXf9FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dn8L3TNZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70af8128081so3818171b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721143012; x=1721747812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q+oBquCC6Yqm7bL0Kr3aJX57Dgk/RB3bFu+I79pPnBY=;
        b=Dn8L3TNZ+4GGHpZzyY6vTKGmsQrmp6593yYDWGI+s/3GXs4bR/n9muz4eFXLl4OtJZ
         SbX5ID/EbzALM0A5dWt1+faK8GtoKVEoZ5D88z1p/G6b6alCgKeVc3EdMy20SHW/kBmH
         K6yG2wkNVcQmB3vWAR4H+wANKzc7agRoRQvB2lxkPdX8bUA28b3bRS9cq/rR2XT2Bhb8
         cWSDvQqxS4Za8Az0kMSNlEISoW8C21H3egfBB2l4SjDoC3BcWn2lX+OO46L+cNLqWEp+
         abL3BKZXG85hzW71VgUZdKk6CvCOKDNdj355ZYA4wqudoHychEdMtCD3Iu+vRBW2KHFt
         2Ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721143012; x=1721747812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+oBquCC6Yqm7bL0Kr3aJX57Dgk/RB3bFu+I79pPnBY=;
        b=TBb2BCN3L8mrUsrL2ZshS9rPNSRz/PdGDF8sYmQjeihuhK72p8PWkbNswzLi841pxk
         FY2SJ9rjFNdBIowZ2+7qi+LRQoO4u3yvheWAktl6xq0VmzM35JcgzMXC9h6ju7d2LA6b
         glvPPyyyoVH40h42fTXJH0HaoWN6HlQNtUNKSwZr7vLlyXWRpJ5q2Ptr1nS7+6UYBGeH
         u0UNKt3sq6wPaTzTPT3k1e/uz/1HZOda6NO/N/YyhYXqrYOll9bivdYJduZS1bf6OFdY
         dbAlQQs5iolBXLIC/k0Wkc7dquKhQROBWKSWsdxV5+QoLyscLBE95XgSJraAka1y7ld4
         7PPg==
X-Forwarded-Encrypted: i=1; AJvYcCXdzmheg8by9/3b9zwhK6KQEFw1GYJUrGs6fpr0xeKgNRWDuNMitCHoKw2Ffyr8wvw5JImmuh4KrTFIA+MdlAcZ0ADYpx7qExwouJ8t
X-Gm-Message-State: AOJu0YwgG2HGBRoMCJ+QRXO6cALZeeXC6xjqhU5Am9mfzOLIAac6sHWW
	iWvDu0/BfYoQtPGm+mhhVyBULOOpTZuYorIhEW6YLCoN2f0Sy5VDRoISh2Ml7uo=
X-Google-Smtp-Source: AGHT+IHK38fZflwQZj+0YBMxhcUoqsY5qUO9G0uXW0RmTRimetE4YldMaHWfupwsPvdp5aX1P8Rc/w==
X-Received: by 2002:a05:6a00:238c:b0:6ec:f2e7:21a8 with SMTP id d2e1a72fcca58-70c2e9942e1mr3475412b3a.21.1721143011828;
        Tue, 16 Jul 2024 08:16:51 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5d01:167d:9cf4:148e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7da19sm6413009b3a.133.2024.07.16.08.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:16:51 -0700 (PDT)
Date: Tue, 16 Jul 2024 09:16:48 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, marex@denx.de,
	iuliana.prodan@nxp.com, daniel.baluta@nxp.com
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, Terry Lv <terry.lv@nxp.com>
Subject: Re: [PATCH 1/6] remoteproc: imx_rproc: correct ddr alias for i.MX8M
Message-ID: <ZpaO4FDEYoA0cpae@p14s>
References: <20240712-imx_rproc-v1-0-7bcf6732d328@nxp.com>
 <20240712-imx_rproc-v1-1-7bcf6732d328@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712-imx_rproc-v1-1-7bcf6732d328@nxp.com>

Good morning,

On Fri, Jul 12, 2024 at 04:34:54PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The DDR Alias address should be 0x40000000 according to RM, so correct
> it.
> 
> Fixes: 4ab8f9607aad ("remoteproc: imx_rproc: support i.MX8MQ/M")

This commit was merged more than 3 years ago...  I don't see how such a blatant
mistake could have survived this long without causing problems or being noticed.
On top of things checkpatch gives me a warning.

> Reported-by: Terry Lv <terry.lv@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 144c8e9a642e..3c8b64db8823 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -210,7 +210,7 @@ static const struct imx_rproc_att imx_rproc_att_imx8mq[] = {
>  	/* QSPI Code - alias */
>  	{ 0x08000000, 0x08000000, 0x08000000, 0 },
>  	/* DDR (Code) - alias */
> -	{ 0x10000000, 0x80000000, 0x0FFE0000, 0 },
> +	{ 0x10000000, 0x40000000, 0x0FFE0000, 0 },

Without access to HW or the documentation there is no way for me to assess the
validity of this patch.  Marek, Iuliana and Daniel - please review and test this
patch.

Thanks,
Mathieu

>  	/* TCML */
>  	{ 0x1FFE0000, 0x007E0000, 0x00020000, ATT_OWN  | ATT_IOMEM},
>  	/* TCMU */
> 
> -- 
> 2.37.1
> 

