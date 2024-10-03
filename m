Return-Path: <linux-kernel+bounces-348946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA1298EE51
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDEA1C21568
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFEE1552ED;
	Thu,  3 Oct 2024 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="m1K/TLI9"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D9154C17
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727955529; cv=none; b=Er3/MHHkp+QQnFFAaHAQbCExUHWYV40YTk5k85utx0GbYhAv59JT0u8EWWkWp1XIi+i7W0qR9pWmr0BtMLluzNiZF0L88uO7JliVmkM9+CEiAtCio4k9QiwTK2OH2JPasxk2bw4330E45+FqUsM4pWz3porvsXBFcO3KCYgfpus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727955529; c=relaxed/simple;
	bh=g6EvByoZPG/MdDyUnJMG5QMQON5GyIySoBJxBHHh9uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+pubocNKQN35brMl42Gz/EaIozcoWTlj7fA0IpFfySbYrrS1m6p55QHtuSmvzIk6QMUjjw0w4S6zVY6t0CB8Vo0i7+R41DHwPGVGm81UsEeOQoKL9VhA3AyVG7ytWmyn+nwMisGKZF+/zcC9Z/O9Vr5vw00osIOEs0Z+b9/wUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=m1K/TLI9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5399651d21aso727659e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 04:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727955526; x=1728560326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ial+kNUxVlagTAh5OXNTJXCmDuirvWQeTBwxkbQ8bdw=;
        b=m1K/TLI9L+JdlMuAGbyh89sUHSfVMOyOtwjRoB8aBJflvh6RdqrZC5XL6uxd/Uja06
         CmVFDaJNKBVp1tDnyhdcwQiBu455Ld5oVTKRp9NAnPslp2XoquKnvvmHVfXlnHWqslFD
         BqiVMUde2qy5rONXv5FtX4WwCn2L/g83xeP8/F9N1cVbuHqvlSg9RmnDEsYl8ldvlftA
         2PFceWgPWpX74oYs5q+RBFIAm9696r75IjVMwrnD1zT5eb4hD35eM2JqtALL7RS74v33
         I9jLVz3dAdRMxdptIrqe5bdF97V24Xz4GL7OXUXypQjlUlXSpebK6OyLg/blHJp65alS
         AODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727955526; x=1728560326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ial+kNUxVlagTAh5OXNTJXCmDuirvWQeTBwxkbQ8bdw=;
        b=UQzJp2oLnBRt7fxInVH1GcUWejMpycZdKiz/dFPmKjeEcE9F+KGUMv26TtIYNFgqHY
         AtDAzQ5RmDXtLtLrH8SyhlCgkxMkgw5XJqnnluWJU2iev4wO6aKoe0dau+nzmaoZLl68
         l1Wzi0VKsZon0Tt/B6z/284RrzGw8htqtRn6tig7I3DY4XQ80WLlEoAJIfj8ylkQJRst
         KyeDFje8gefK1tHPG6bhpXdijEaeTaavXKymW+RAdi+hMwO3m/PQAkKDz2K+gZEaY7Q/
         v00DFoveCYrOW4tAXq7jdidRcdIQdiSpgLSwNXyABpSV4U1v3f+fsjm1PCGjNT6JH/lW
         tKIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvjq56gHTywm/TqLl3NZ48qC8B625ER3kcxVvCDV9AA1sp15j3SLQXRSNREaRadFlsk6x8tg1xevfkYMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznKXW/j2w8Q/gGD1MSBYicIPwWyEV1en7J/KQhl6LQrgsxEYEi
	TxtgH3q3H4M9xbwHhUYR/EdRLl/rNM8PS49Tl7p+FoYWj6ntyhfFT4ZInN977WddIi/6qWrUomN
	gLYE5UxcTtfnuxix5lcol5CswZs76OxqXMccggg==
X-Google-Smtp-Source: AGHT+IG2QJvSQ9kJ0Om0FLnVDouU3+iqMLBkxIekUgOC4DtsH1W6E4j1MFhH/9hsel0xtvam5zeR+i8StX9Pud2sywI=
X-Received: by 2002:a05:6512:2312:b0:533:cf5a:eb32 with SMTP id
 2adb3069b0e04-539a066595dmr4032156e87.19.1727955525941; Thu, 03 Oct 2024
 04:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930103041.49229-1-brgl@bgdev.pl> <20240930103041.49229-4-brgl@bgdev.pl>
 <Zv565olMDDGHyYVt@hovoldconsulting.com>
In-Reply-To: <Zv565olMDDGHyYVt@hovoldconsulting.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 3 Oct 2024 13:38:35 +0200
Message-ID: <CAMRc=Mc9jMe=hSXmcRLLX61abUjetCRZVeOK3G31vdx5JQNNMQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sc8280xp-x13s: model the PMU of
 the on-board wcn6855
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 1:07=E2=80=AFPM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Mon, Sep 30, 2024 at 12:30:39PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a node for the PMU of the WCN6855 and rework the inputs of the wifi
> > and bluetooth nodes to consume the PMU's outputs.
> >
> > With this we can drop the regulator-always-on properties from vreg_s11b
> > and vreg_s12b as they will now be enabled by the power sequencing
> > driver.
> >
> > Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Without this patch I'm seeing an indefinite probe deferral with
> 6.12-rc1:
>
>         platform 1c00000.pcie:pcie@0:wifi@0: deferred probe pending: pci-=
pwrctl-pwrseq: Failed to get the power sequencer
>
> Can you please look into that and make sure that the existing DT
> continues to work without such warnings.
>

Ah, dammit, I missed the fact that X13s already has this node defined
so PCI pwrctl will consume it and try to get the power sequencer
handle. I'm wondering how to tackle it though... It will most likely
require some kind of a driver quirk where we check if we have the PMU
node and if not, then don't try to set up power sequencing. Any other
ideas?

> > -
> > -             enable-gpios =3D <&tlmm 133 GPIO_ACTIVE_HIGH>;
> > -             swctrl-gpios =3D <&tlmm 132 GPIO_ACTIVE_HIGH>;
>
> What about swctrl? You're just removing this pin from DT now without any
> comment on why you think that is the right thing to do.
>
> Should this one also be an input to the PMU block?
>

I recently added it to the bindings as an optional property. It's
technically an output of the PMU to the host indicating the state of
the clock supply to the BT module. We're not really using it but I can
keep it here if you prefer.

Bart

