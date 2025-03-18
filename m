Return-Path: <linux-kernel+bounces-566460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AF0A6784A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EE41789FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569FA20F079;
	Tue, 18 Mar 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjzqoH4O"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575C120E71C;
	Tue, 18 Mar 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312973; cv=none; b=eIQmy5GnmqmQd2t+DNmqpmOD6cknhaMDuenR5x3Bj95NTsPuvqnluTHcOGhS8MF8p4WykiPZPlh46Gs69VwWuKaxMyPXL4hcFHwgVULmEfWDCnfwipcs7rtzV3UZ2c+62aRP+bV5l6DKerhVKGErft5hD/WC+GQpXjSZpwj6Huc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312973; c=relaxed/simple;
	bh=9IcPCCGUZr/pvJFEOPTdZu3qhFBek7e24MNCUdrqCbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQCXcdTViT12lvqkCN2bn9drduE9eiReKvapvY2Y5/FV7AWzy8tcOgo4eg3C701IIkVFMsfYJgq84JM/r5SYumhUljtPYugNtCN0w3QsxK0Cgg9G3TkTl6KrcveiA4/9qgdmI1Bw9wbdEpLO2y8rg09YBmoxMT/5opTxL3tXFTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjzqoH4O; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so834915766b.1;
        Tue, 18 Mar 2025 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742312966; x=1742917766; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L6Ipmc6ilCbSYurjtaIb/33JjbYe+per91vNl3/7Nh8=;
        b=NjzqoH4OySOUz7t/2J9uXN7Cn/zP0J77EDjrEEZoRqNDWL4co4hFCJ8i5Jkk7uHUpV
         jx1FN0UrWEDdUo93pkQEXEMfrasVPyfcdCff1zYJoBwTI/QKQlIxMO7WJs50HXq0qayY
         LW0gaG/5gEvk1VJTICLRjDfzGEDmDhY/cyfhZVaD7+4KNx7m85dadLRLet2QV9ErAzrw
         Mncia0bx3TL+4YrV1YHR3P+j6cDsirodqvPmAsgxcFLxjQl+boGi+jvcCzdkMF1T52a/
         QeXaGZc8+C6MuUT1TAsqq1EC56afjBcwM7ajTP0oeFEoqg3bfS0X5J0B+g70G4gjgO6U
         xLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312966; x=1742917766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6Ipmc6ilCbSYurjtaIb/33JjbYe+per91vNl3/7Nh8=;
        b=eA32db1chsd3xRbDQG8m/mwrxXUX8VsOQlCmLHQ3PV16p8iHCVuE5g+sP+WA+xCc61
         1Ibjr+23QChEpPeY6S3rkdKqDhasDqiM9ues8ZJaJtugQMv01mq4IQLq8tR2q/HyMsic
         DdqYGYqezyDFo01CN/GdbhYMsF7wMm2eoPX8KRpvS3p7Kddi22OXO+OBiZxJ+LU6FUu5
         ia8Es8KDMvfEn6lfrPavbkeqwHJKmvMKKKUjSO6MngntSHo8J9OmVJzPqtPYHLmzMv2s
         P9sHJHXrEFEJT1WhBZtVhveiHXZ2rf4YxtBe/JZ7/d5aEWWFBWr3AoUI569Idavgwxu+
         PLPg==
X-Forwarded-Encrypted: i=1; AJvYcCUnieYIEDL0g0MRaojmcXMAh6itih24NFkmvm81jZVFJMcsXztrIiNP5eB0IVqaHTt78l2UIGzzBlsO0nli@vger.kernel.org, AJvYcCXb+tlUjP+/m2u3Lc+0tZrvWSkDXCOR0OEKeLEU3FURtqhvoWnl4rbkQuI/wbg7VmaMr1PPUqoHbHGs@vger.kernel.org
X-Gm-Message-State: AOJu0YwqwIFsKBYKp7+Eerc4Oh05mWuGQdMMvpr1NIIy7jxGLfB2qvw5
	HI5zF/HE7zWGhbPrsbfwZ+Q5E8yPR2V9xILVOo32w+uaGt8iC8zB
X-Gm-Gg: ASbGncufvtv3LqRJ0YJszmEObTQMV8qGEUM3S2OMw/W9O1rtCLwhAO7Lxm93Ebd/qkv
	3UKXDtOWIJfKAr7xMkbZD+YwamLrJ1qtYbgQSObZs0D7vuL1i6Tn94awXiUJ6AVLWEpEShEkrpI
	uRz8VlxYzZ5cKlo68uGi2a4rNwNthmxQ/UV3fYnMqEJyoho493V5g3Q5LnITJxejGOOpztd81fD
	1YTL29VK6eqj19E4EyeFgbMlgfRL0ZJhEXlYRO7ZSuOLArGyxXRtGPWcDshgYyl4a7XJHoMknI6
	lH7XH+4p/CPomuSpjUUkTmkZA5Q5vrJ4SXDrFmPuP8rPOqxD/XNVSG3phfA93i4simaONxA7VCb
	ZlEGwAKUNG9T2Z6dqoBgS9OPK07b8zAnRfX6K6mlvZqztqw==
X-Google-Smtp-Source: AGHT+IHMLkaV8uHFQVg2vHrzXkQR9/w+ti4OyBuv1b8SAJBLiHJR2w6USAKnVcw7fN1kQSv+zr3g9g==
X-Received: by 2002:a17:906:da8c:b0:ac1:e332:b1f5 with SMTP id a640c23a62f3a-ac38d552e43mr506689066b.37.1742312966212;
        Tue, 18 Mar 2025 08:49:26 -0700 (PDT)
Received: from alb3rt0-ThinkPad-P15-Gen-1 (host-95-251-108-181.retail.telecomitalia.it. [95.251.108.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147f0f5dsm885226766b.63.2025.03.18.08.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:49:25 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:49:23 +0100
From: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH] arm64: dtsi: imx93: add alias id for bbnsm_rtc
Message-ID: <Z9mWA5ldMDqZcVf5@alb3rt0-ThinkPad-P15-Gen-1>
References: <20250306193014.490091-1-Frank.Li@nxp.com>
 <116096172.nniJfEyVGO@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <116096172.nniJfEyVGO@steina-w>

On Fri, Mar 07, 2025 at 11:19:13AM +0100, Alexander Stein wrote:
> Hi,
> 
> Am Donnerstag, 6. März 2025, 20:30:14 CET schrieb Frank Li:
> > From: Joy Zou <joy.zou@nxp.com>
> > 
> > Add rtc0 alias to set bbnsm_rtc as the default rtc.
> > 
> > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx93.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> > index 56766fdb0b1e5..7d9aa15ebf5d0 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> > @@ -34,6 +34,7 @@ aliases {
> >  		mmc0 = &usdhc1;
> >  		mmc1 = &usdhc2;
> >  		mmc2 = &usdhc3;
> > +		rtc0 = &bbnsm_rtc;
> 
> IMHO this is a board property, not SoC property.
> 
> Best regards
> Alexander
> 
> >  		serial0 = &lpuart1;
> >  		serial1 = &lpuart2;
> >  		serial2 = &lpuart3;
> > 
> 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
> 
> 
> 
I agree with Alexander, furthermore if we look to others dtsi we don't
create this relationship at soc level even if we have rtc there, is not?

for example:
arch/arm64/boot/dts/freescale/imx8mp.dtsi
arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi

Regards,
Alberto

