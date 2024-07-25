Return-Path: <linux-kernel+bounces-261882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B682393BD59
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87161C21716
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868D616F8EF;
	Thu, 25 Jul 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SxT1EaO2"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F315FA72
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893794; cv=none; b=SqOTmpI/W1bb1Y85KthO/KBjs7w+pKTmtpNWXvp1fOa6/TsdLuMF8XElaarfXjwnMBz6hnVFfk+APjn9Ge6U7BztwPyE/GXn/6AVznO4OZv0loAVpVSTUdOWMAzZI6ACu771zriCGb4y6TF4awC6UxevHbdvNw0Or2A7uZsjXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893794; c=relaxed/simple;
	bh=H2rNgRhzf31FBzgPY5x5LfdD81vL0O+y+3XLP88w4do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVXaTXvID74bpL2TPtB0xDjPBf5SvH36j+NAZ23crd05DzKJhtbgCluGyTCcHw+rKKqpnGi/dTdU3CTDKe80Nb+xYdWIwmQ9hxK+uznCx2uZA7CcycxL6+IcP5bND6MF1DcPoPXxNbzzjpn6V8QvPLXmyKqXYPk3nO/3IvoH3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SxT1EaO2; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-651da7c1531so6460007b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721893792; x=1722498592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=14PpgL0nDIIZje2MJv6LV3SXJsBvOcIkpFVxna5H/Q4=;
        b=SxT1EaO2GmxMI5L/0l6e4z0WOzTObfy4ljbyO61GRVx5pNzwOQ4I2z6lwA7GmYQ9QH
         0ArWl6K8nzRYSstnyyeLhkz3x5FrxZIWQ7ZekpqPbVJQPX5a3IvZE1xg2aex4Sckx05X
         r7kBbdJPxXqFkZaY2i3sW4iT44De2w+bmt6AYfTkMgyUFrv25Hqw5srCiaPKIthJ7hMk
         nH/M6OkuXoxb0AY36uLuhoRnO0IjsbgqMEZkUvLRYVfpE8pzkladACWcIj3pI8XVPfda
         Hfdculd+VLK8Pq8Egx25jNfyPLm+wxX9C0nvPsA+X5PA3Pd36U8nBoLbWWIx6kaYCAkP
         YB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721893792; x=1722498592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14PpgL0nDIIZje2MJv6LV3SXJsBvOcIkpFVxna5H/Q4=;
        b=aqIWttOCPoiZiLQ4QLY7cgLqH2N97DWDyT0k2hfxLib3TdMqtkDpwmrou09EZuDWzl
         LllqQjd7o29yXrvDZncZEq1B3gnjTnoNn1mmMWD5VZae3/28CTNoMMAt91BvjIYkmuWz
         NU/u65JsGoeoKDl2YDOUlo5xSe4Jgj/aRoaKyu+zqIWVJaP6k7M12Y2DVBc65SAaLJgV
         xZoceHTqaNmGeRWTUNTDTRwZBV+XT40IXpCPZPOt20BZFP2EtG0sLG09zbt3TuXur1nq
         Km2qpcsij3/3q2hRqd5tJSxY4dGqw5zSR1WHqTLa6q4R7GbAlwqYM407mlJfr7g+ufug
         nvFg==
X-Forwarded-Encrypted: i=1; AJvYcCXGvBwxcN9r0wI5pC+3Kex1w4e2cBuREHKBdWeNaG5GnlkD7Tttu5cjolYkcw5T/QasEtIGVMv66zrWIlHptzTIGw4Hxth0miD2TyrK
X-Gm-Message-State: AOJu0Yyxsm0j50gVvfkPjkt2ltNpb2k17Adr8vsj0Gvt0BGFMocV6SHa
	tl2jH9QPjojBl+FsXk+DKw2swZh/kQ3yCKrDm5Qim71y/BfiKZG/fE4vGXofajmOVYKx58KOLo8
	pJkZh2hs1yIeR5asj1N9cwnnwPYU0TKL3QrzDPQ==
X-Google-Smtp-Source: AGHT+IEEO2Y9dCHc9TltOTf6xrUYwwSebJ7kZgk0XuvYjcPUkbjkYUqxVr7OBrj7XmjXJg+b/yv7C09i2HuBi7P5XYI=
X-Received: by 2002:a05:690c:ec5:b0:664:66d8:634f with SMTP id
 00721157ae682-675b7e6def7mr11811137b3.44.1721893792416; Thu, 25 Jul 2024
 00:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723151328.684-1-johan+linaro@kernel.org> <nanfhmds3yha3g52kcou2flgn3sltjkzhr4aop75iudhvg2rui@fsp3ecz4vgkb>
 <ZqHuE2MqfGuLDGDr@hovoldconsulting.com>
In-Reply-To: <ZqHuE2MqfGuLDGDr@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Jul 2024 10:49:41 +0300
Message-ID: <CAA8EJppZ5V8dFC5z1ZG0u0ed9HwGgJRzGTYL-7k2oGO9FB+Weg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Allow 'vddpe-3v3-supply' again
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 09:17, Johan Hovold <johan@kernel.org> wrote:
>
> On Wed, Jul 24, 2024 at 08:22:54PM +0300, Dmitry Baryshkov wrote:
> > On Tue, Jul 23, 2024 at 05:13:28PM GMT, Johan Hovold wrote:
> > > Commit 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to
> > > dedicated schema") incorrectly removed 'vddpe-3v3-supply' from the
> > > bindings, which results in DT checker warnings like:
> > >
> > >     arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb: pcie@600000: Unevaluated properties are not allowed ('vddpe-3v3-supply' was unexpected)
> > >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
> > >
> > > Note that this property has been part of the Qualcomm PCIe bindings
> > > since 2018 and would need to be deprecated rather than simply removed if
> > > there is a desire to replace it with 'vpcie3v3' which is used for some
> > > non-Qualcomm controllers.
> >
> > I think Rob Herring suggested [1] adding the property to the root port
> > node rather than the host. If that suggestion still applies it might be
> > better to enable the deprecated propertly only for the hosts, which
> > already used it, and to define a new property at the root port.
>
> You seem to miss the point that this is just restoring status quo (and
> that the property has not yet been deprecated).

You are restoring it for all platforms. However in my opinion it's
better to follow Rob's suggestion and to add new property to the
device where it actually belongs, rather than hacking up the PCIe host
device. More importantly with the arrival of the power sequencing
subsystem we can handle powering up PCIe devices properly.

> I assume you've already read my reply to Rob's bot, but here it is for
> reference for others:
>
> Link: https://lore.kernel.org/lkml/Zp_LPixNnh-2Fy5N@hovoldconsulting.com/
>
> Johan



-- 
With best wishes
Dmitry

