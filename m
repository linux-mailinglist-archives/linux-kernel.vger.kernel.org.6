Return-Path: <linux-kernel+bounces-227954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A78A9158B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C771C22F41
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31671A08C9;
	Mon, 24 Jun 2024 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeKVUeKg"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AB719B5AA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264012; cv=none; b=EGZ1PV+wiGeehZiSxvBx96t3Lb6bzXAaUw/+6dcLznU8QAiJAMDyM+63tgjO3jfPFw8Md8yZ4peObdptsnOrbb1Np3SkZsxprvYGmwRVdGE+aO9YohDG+1fmEExeXJtcvbXU/ebd5rrLF8WZIkYAS63sjqJ9vcK9w4uJMXU1QLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264012; c=relaxed/simple;
	bh=Ywxh3jHKp2J5C17RLeeKrTvFRG0sWKH4+bmBhjCAW8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qn7bI4XoVPCSlATvyI4kbWIAZQz+UNHDmmaEnJRTfd3Ob/FA6+wasTtWX9bdi+oyLZIToH1O7Ml6SfbYwLdm2DQSnisiZDcAmThWAlHFzlUJDlndgyPtxAi1uXa4D26CfEzX1RtKcQ1hloTMiVGDpWTbfozxgZ7ZMXGb/Ju4TLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MeKVUeKg; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62fe76c0a61so43793567b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719264008; x=1719868808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n29kKcAPtdQUAbyq3kUWwiLbnOH1cX8Yo23m4ifTvmI=;
        b=MeKVUeKg5mZl2+2blD9X1xPBnFbIPXocL8TGphWqM2JwS//iUIdXB0yIkKYu4UAEMk
         ksLA3gwJpwDLVZlVlXEOkXzeco5NzcYvCaS7hrj2UToCNVMJy5dPNpvpk4bRn4o+M20S
         Cw9+RwSBB47USW6Yq00/xHSBgi/NZFirgTOqmlfIX5NB/FXyl3QvSp02vjjIeZm8Rj6u
         Oz6CDEqxRdo4lVC//zXM7kl9V30bHVliQSif+Ktn3n7JJZWa5q7ZHOBU4zbJH5lqliIu
         USIzsLMUjOzsr+0t55wvdz2HfOzokeO3jBQD7RcTggOde2vyg5+huecSWCHfe3rx/6NL
         W8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719264008; x=1719868808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n29kKcAPtdQUAbyq3kUWwiLbnOH1cX8Yo23m4ifTvmI=;
        b=D3GviYaKrYb5j9bmQfDd2zeyZF3W7TyFvJuTvttu0fDbtVpp+4YQSZ909rxvYq1Xlp
         lESe8it0KHKcBH88wJhvTsl9BL6Hh3Q3hJdv7AuD3gwiDIUHZVXF5Z9aaIc0Qe7wVOl+
         dUpXjxmRiYGIqRwPe2cRh2psMSPpK64nW7WeQKw2nli1HQP7Z2dDIuDhysV/e18z9z6P
         B03rm5kp3ue6NVOm/BujzJ+z9iWbLbtNsawC0LwErVs4d/6qwizKKG2NTwF3SrKkM5YR
         yxPcapzshIYOz7U8hITbwkCtb1kM4CJ7wJ05b8Qr3hzKwoZMyk65UOjagjt0yHYhLKQS
         CnDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2rv/LDu1BrN2jkfG4DhVEKo8s2gSKnumhrZnZsKvXNUE11Oy5xemlN9HZ9+MPqJF8PNJRzH1eix13abaYIBAr/TmX90OVUOUCwNhA
X-Gm-Message-State: AOJu0Yz6KmUr6mUvVJciM4uaLFctsCM5C8iGbwJLx7Np6aUnbOurGj8k
	jjPw14UKM1n0hgO8ZtkYv1m9cUbD3wXIRDkmXRUC0Tq5n7gbMMZtYu8ZpNK2940Dd9Smn2cN6Yp
	pAyG8c6JCEY0akX4jxrqgnlDUJzd9M9CKMDXGWw==
X-Google-Smtp-Source: AGHT+IGfkE0PbENmDKD6PlrJs150f8byfhtEUip8X0YtUZ/Mio4OSI/c4fOL3gUP49C6cbypdf7Z86ZWf3HHaLi4r5s=
X-Received: by 2002:a81:c905:0:b0:62f:1925:c455 with SMTP id
 00721157ae682-6424a143008mr39277877b3.15.1719264008235; Mon, 24 Jun 2024
 14:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
 <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
In-Reply-To: <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 00:19:55 +0300
Message-ID: <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Jun 2024 at 23:47, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Jun 24, 2024 at 10:17=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Mon, 24 Jun 2024 at 22:45, Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > We unnecessarily fallthrough the case for QCA6390 when initializing t=
he
> > > device and hit the condition where - due to the lack of the enable-gp=
io
> > > - we disable power management despite using the power sequencer. We d=
on't
> > > need to look for clocks on this model so it makes more sense to just
> > > register the hci device and break the switch.
> > >
> > > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Fixes: 4029dba6b6f1 ("Bluetooth: qca: use the power sequencer for QCA=
6390")
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Is this going to break the QCA6390 as present on M.2 / PCIe cards? Or
> > the older DT which didn't have pwrseq entries?
> >
>
> Neither of these has clocks that need to be driven by linux. The only
> user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't exist
> before so no commitment was ever made.

This might make some laptop users unhappy. But anyway, restarting the
hci0 now gives:

[   24.387344] Bluetooth: hci0: setting up ROME/QCA6390
[   24.387439] qcom_geni_serial 998000.serial: serial engine reports 0
RX bytes in!
[   24.554349] qcom_geni_serial 998000.serial: serial engine reports 0
RX bytes in!
[   24.562056] arm-smmu 15000000.iommu: Unhandled context fault:
fsr=3D0x402, iova=3D0xfffd1080, fsynr=3D0x750013, cbfrsynra=3D0x5a3, cb=3D3
[   26.914225] Bluetooth: hci0: command 0xfc00 tx timeout
[   35.042619] Bluetooth: hci0: Reading QCA version information failed (-11=
0)
[   35.049721] Bluetooth: hci0: Retry BT power ON:0
[   37.539492] Bluetooth: hci0: command 0xfc00 tx timeout
[   45.539519] Bluetooth: hci0: Reading QCA version information failed (-11=
0)
[   45.546667] Bluetooth: hci0: Retry BT power ON:1
[   48.035863] Bluetooth: hci0: command 0xfc00 tx timeout
[   56.034783] Bluetooth: hci0: Reading QCA version information failed (-11=
0)
[   56.041901] Bluetooth: hci0: Retry BT power ON:2
[   58.532174] Bluetooth: hci0: command 0xfc00 tx timeout
[   66.531928] Bluetooth: hci0: Reading QCA version information failed (-11=
0)




--
With best wishes
Dmitry

