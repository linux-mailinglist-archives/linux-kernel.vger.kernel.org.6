Return-Path: <linux-kernel+bounces-571017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CD1A6B7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 784F77A5F54
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D931F09A1;
	Fri, 21 Mar 2025 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AVcq+OYW"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4511F130C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550211; cv=none; b=C8uwMGZdmQ7Q+o7NZP+qIVG8I+Ne4LIvKqTNJZa7y/oy3IKNPM3kBTZR+AjqW+3ScTxl6eDNsQ2iTgQ8p+fkoo4Sgnl//5Ut3yQPqCmD6NkVT+YxtPO6CABZwZo5rBTuB2d4jaLO0rnEw5g2NPTawRiNqPCbgFIHWcNTcmsPiic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550211; c=relaxed/simple;
	bh=DRBplq8aKI0ku9BkKb564kLsXB+P8qItF8OLlfaPMoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drYQUlSIqwBL5KQh9lNfiRsXYw1F5N62cvov5FXHeePrszq/dgrZaQi5yxQlOrHyNdh6+u5c6W3uRV/e7ckIwAx1psTvZSHcHn7SM8H63SOeJNNfOMP1gaC1pCz8rQ2YWKSaktaOthoBCcgAprlIQcVBMutHQWhszGwd02fapS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AVcq+OYW; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54ad1e75f49so1537438e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1742550207; x=1743155007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgGaJaPa/jEPScVXsjWC4390D+TFpvglNfRjMg/X9O0=;
        b=AVcq+OYWi/89Ti7sWHSrHWkZa3upXFtsa/m5545IZ4yJYvzOiwML6YtJXaQ9EJzdB+
         LyBxyAlLqMv8bgggp9x3nOyO5bOb/nwMYNO6x0p/z3TIjLIWWXlnCiZE/7ZVwvMiaybg
         1GSRQamA+vlciqfq+Cr8e8OplikPoSG2nt8WrAZoTA5OOsqlko7aL+UAluwyzKlSiPPo
         zXQ3XDQklNMqpilNXE51Nw7HISdlPQ6OQXNTaR8Jpr+FZ/O6h0i6G8rkzcOHM/ogLlRm
         3VvCOfXLq/e+YNv0rfJ9ZbKCETLGzRdQ4GOJwjHM1C6XZUMCpxkg9qmPCcbRr0wHrhpQ
         OdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742550207; x=1743155007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgGaJaPa/jEPScVXsjWC4390D+TFpvglNfRjMg/X9O0=;
        b=Dbg9KimTGH9Gi7C7mlK3xCK4NLzLBQ/u4XP0x1drTQMm50aQjomr4aDgVG0y/jTI9a
         Le7xfApJKvZYvyp7bVKfrvk2qiBfIxR3lbZh+cwkCFK7xJNNZKSfz2Uw9iUS4xJBWzxk
         gHa1zyyF0SDyaZ6qosYAhDScAtB4GHeiHjS57k9fBznllMyVDHtOUzHmp4Po6UMlOuJB
         bny3cPXpq2YxrfR4PGDb0tB79NwlbTe1El5H/H7z+o+MELm1zr3sigT0rm1Wu9VsaKZw
         YddbLehaVlM9FzHwScZ8aXyrc0uQaonVpCgGLFcXvTumG5i/wBA/qP1Cz+NDSw51xI74
         itxw==
X-Forwarded-Encrypted: i=1; AJvYcCVMj3qa6jdRfJIHxY6TziIY3y+xnhgZWzlDvdoE7D3IRCW8U1lDWabSh8pgA8VRkSp2WX+2Ik6uTCuia6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmpwq1iFe2rWxBsA9e6i25tgEK6KxLwZ/Z0JyWcG81Lphwoz0r
	CIomedrcWhYcoI1x8v7lwfB0h3gkbdIzU2AFgNlPNBr3WGqEB8ka1eEGadcqolpLN3rKbiexBfj
	G6DngIn4VVgtB27Vu9dzxxmXh57bqIW/khD6SZw==
X-Gm-Gg: ASbGncv/SjXhYP9zYcved8ps5aOY+jx1MqHenpd2ijZ9//tgIc5S7PSMb2umJrfX5io
	MO8LbFKpq6kk4mxQagAFti4SSTwbjqmbB2vvrB2LHlBamJjXkTRb3sJcC1WE3nbWqoXGgwBN9ts
	LeWWE/BGVQ2zTMvAybErgRO7YtI6XVxrW+7WIJq9b6dA0ceknTlzBkV4uZdQ==
X-Google-Smtp-Source: AGHT+IEDdJoaJq6teyJiW13G+bIfvvL5/3c4aVZ249NYoi9wkGLc1z6wYCrInzpYKLkQcy/ueE7DfYIIW3z1gg4d79A=
X-Received: by 2002:a05:6512:1314:b0:54a:cbfb:b62e with SMTP id
 2adb3069b0e04-54ad64f6791mr932986e87.35.1742550207212; Fri, 21 Mar 2025
 02:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320055502.274849-1-quic_wenbyao@quicinc.com>
 <20250320055502.274849-2-quic_wenbyao@quicinc.com> <694b6638-92b2-4ac0-a175-bd29aea6cba9@kernel.org>
In-Reply-To: <694b6638-92b2-4ac0-a175-bd29aea6cba9@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Mar 2025 10:43:16 +0100
X-Gm-Features: AQ5f1Jo9naRtRxBQvHi76DCGdYFDD5Qh6BXFBrW4RyaSHcjfJlIGHOXa5xvXdjg
Message-ID: <CAMRc=MfZrRp=VuEOLuMY_04JdyRrD+joGL56LwRFQ-+D-8Z_6w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] arm64: defconfig: enable PCI Power Control for PCIe3
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wenbin Yao <quic_wenbyao@quicinc.com>, andersson@kernel.org, konradybcio@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	quic_qianyu@quicinc.com, sfr@canb.auug.org.au, 
	linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 8:37=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 20/03/2025 06:55, Wenbin Yao wrote:
> > From: Qiang Yu <quic_qianyu@quicinc.com>
> >
> > Enable the pwrctrl driver, which is utilized to manage the power suppli=
es
> > of the devices connected to the PCI slots. This ensures that the voltag=
e
> > rails of the x8 PCI slots on the X1E80100 - QCP can be correctly turned
> > on/off if they are described under PCIe port device tree node.
> >
> > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index 85ec2fba1..de86d1121 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -245,6 +245,7 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=3Dy
> >  CONFIG_PCI_ENDPOINT=3Dy
> >  CONFIG_PCI_ENDPOINT_CONFIGFS=3Dy
> >  CONFIG_PCI_EPF_TEST=3Dm
> > +CONFIG_PCI_PWRCTL_SLOT=3Dy
> Bartosz,
>
> Wasn't the intention to select it the same way as PCI_PWRCTL_PWRSEQ is
> selected?
>
> Best regards,
> Krzysztof
>

For sure. I would expect there to be something like:

select PCI_PWRCTL_SLOT if ARCH_QCOM

in Kconfig and nothing in defconfig.

Bartosz

