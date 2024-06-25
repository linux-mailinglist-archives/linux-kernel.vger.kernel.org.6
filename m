Return-Path: <linux-kernel+bounces-228386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69833915F25
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F9328454B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8581465A5;
	Tue, 25 Jun 2024 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ppy5c9v3"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D521459E5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298647; cv=none; b=qozZ7CqzUL2kgbXKBcr55aLDX+oy27AiL5b86EsyCmTR0mVLDlJVXL4uOMZHyxiRrwnOMxz0k4U1otEut7//5HFmFuwUAs5Futlke39VMQxvlIKq8WE/oUjMay0MDgVFlu//gXhiLz0FkOE8EpxJsltFH2wHulRoqUt9txpuJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298647; c=relaxed/simple;
	bh=9bwQGGR/wyIdfMAsvGQ9dzDTbZwlGTht+mu4n+QPefg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2MMr2fmnToMmcakzZjzbBSy3eLOeVGMrrr0JU3pEZGKOIQ07pQuOjlKgv/ceHIJ/YtgaJ2Rhgk/aGCtSk2DMjMOYsRbOlDGEV/npluEkzUnUxAiQ98D3aG1SegfRbAHF4HV/QRSTqKWejGos3RnLk+mdKIECMWz7L+TxwYQGsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ppy5c9v3; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dff02b8a956so4593080276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 23:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719298644; x=1719903444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDmIfuJcogCN48ne3+t+LsUj7I8L6ToirSOH5B1KCCI=;
        b=Ppy5c9v3UDf7dNKdkMc5NtogPQkRL5tKCY+76M0n48wyds0x41+35aG5s6QgbjEGwk
         9CA2qdHLx7tEXmwHFORWItwR5boD7bbtuFpXFrBxJs0R3rVUAK208zCpzxNd7HVpKetn
         Mn9gvw5NOuCUDMxyKbBfr0vHIWLB238YTy0Rn2ZcUn9LeO2IVWaCfWYNAUKYMbWfqqx7
         l1jpSgeSQ/ym191DPmz+P5CdcmN6o+dUwljB4YixrVI5QKjebsvPzOD2uwVvlDbs0c0A
         EiX6MqWlSfpxR0pADmnStBVXFm3dEVuhxp0JtOFEkAa9tjyynJ4KuaTOrlo3O7fQMjzi
         Afww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719298644; x=1719903444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDmIfuJcogCN48ne3+t+LsUj7I8L6ToirSOH5B1KCCI=;
        b=GSUzpvvsTqDbtt6DybpXSP6lej2ubhzQY50og0yKMBGCUvoGvRjK4IKzhiQrBn9PUy
         eD8GLkaDBk/K+IWZY6hvX/koKc5AKCtHukkPeevUYclIgaB37Bj+VF/rX1qapLwhIZiO
         4wG+d8+HY5ij7JrqsqQlKxWAuiaamZ2G+sBtAs0bzW/eSJbGmQ2gu8awgEZfMOXrhhRL
         uQosKfl7BeB6YDAH+zm2S+FRP7bUUe18LKTmtNvfFffrUek9/cxsV9YMDB8HODxu2RbF
         fq+NKgF9UAS+Kdiqf6lAbaC493WdpSxr+O531FCs9v2XIa44UZZLaLU/BtqW0NOeOOXY
         VbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS9IxOvtT8kP7ACzRCEhSPfbqQyFOfHexK+1LfdP9nEpAgtlM44QVYNwcQv2cnn1lqDoSpG5092GmLTx2xWHNj0WTDdhfYAfMXgcRF
X-Gm-Message-State: AOJu0YwPLMMRQTLQc32/ZFj7X4t43icX8PWOg8tJdcHxzRokGfrcrW+y
	+m9+9eJuUEOTVizHhhk4zLwJcKqmq0MI51Hl9JB0yYBf1s9gOKktQHg2m6InMjj2We1SVv3qk0r
	UP5SBgKp78uVtC8B4YKix1iVQ32d0DDkxmKtTn54osVqwuuWzzF0=
X-Google-Smtp-Source: AGHT+IGripGlc3e99ZcQ7A/cB5i8DPUq0WPOuQjyoddclsAtiju4Lk8yaZqQa5u8RSMpSSF6OCkcO3tGgbtiw1qoIu8=
X-Received: by 2002:a25:a029:0:b0:dfb:812:af06 with SMTP id
 3f1490d57ef6-e0300eef36bmr6622618276.10.1719298644096; Mon, 24 Jun 2024
 23:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
 <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
 <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com> <CAMRc=MeX6crenUhC1dqp08W+ss5YksUaaemr4PFFM95SHeED2g@mail.gmail.com>
In-Reply-To: <CAMRc=MeX6crenUhC1dqp08W+ss5YksUaaemr4PFFM95SHeED2g@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 09:57:11 +0300
Message-ID: <CAA8EJpr3OPi=EhpfXWghFoF0rgYwuZ8Xw-EzybOzqzftq-GhaA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jun 2024 at 09:50, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, 24 Jun 2024 23:19:55 +0200, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> said:
> > On Mon, 24 Jun 2024 at 23:47, Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> >>
> >> On Mon, Jun 24, 2024 at 10:17=E2=80=AFPM Dmitry Baryshkov
> >> <dmitry.baryshkov@linaro.org> wrote:
> >> >
> >> > On Mon, 24 Jun 2024 at 22:45, Bartosz Golaszewski <brgl@bgdev.pl> wr=
ote:
> >> > >
> >> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >> > >
> >> > > We unnecessarily fallthrough the case for QCA6390 when initializin=
g the
> >> > > device and hit the condition where - due to the lack of the enable=
-gpio
> >> > > - we disable power management despite using the power sequencer. W=
e don't
> >> > > need to look for clocks on this model so it makes more sense to ju=
st
> >> > > register the hci device and break the switch.
> >> > >
> >> > > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> > > Fixes: 4029dba6b6f1 ("Bluetooth: qca: use the power sequencer for =
QCA6390")
> >> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org=
>
> >> >
> >> > Is this going to break the QCA6390 as present on M.2 / PCIe cards? O=
r
> >> > the older DT which didn't have pwrseq entries?
> >> >
> >>
> >> Neither of these has clocks that need to be driven by linux. The only
> >> user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't exist
> >> before so no commitment was ever made.
> >
> > This might make some laptop users unhappy. But anyway, restarting the
> > hci0 now gives:
> >
> > [   24.387344] Bluetooth: hci0: setting up ROME/QCA6390
> > [   24.387439] qcom_geni_serial 998000.serial: serial engine reports 0
> > RX bytes in!
> > [   24.554349] qcom_geni_serial 998000.serial: serial engine reports 0
> > RX bytes in!
> > [   24.562056] arm-smmu 15000000.iommu: Unhandled context fault:
> > fsr=3D0x402, iova=3D0xfffd1080, fsynr=3D0x750013, cbfrsynra=3D0x5a3, cb=
=3D3
> > [   26.914225] Bluetooth: hci0: command 0xfc00 tx timeout
> > [   35.042619] Bluetooth: hci0: Reading QCA version information failed =
(-110)
> > [   35.049721] Bluetooth: hci0: Retry BT power ON:0
> > [   37.539492] Bluetooth: hci0: command 0xfc00 tx timeout
> > [   45.539519] Bluetooth: hci0: Reading QCA version information failed =
(-110)
> > [   45.546667] Bluetooth: hci0: Retry BT power ON:1
> > [   48.035863] Bluetooth: hci0: command 0xfc00 tx timeout
> > [   56.034783] Bluetooth: hci0: Reading QCA version information failed =
(-110)
> > [   56.041901] Bluetooth: hci0: Retry BT power ON:2
> > [   58.532174] Bluetooth: hci0: command 0xfc00 tx timeout
> > [   66.531928] Bluetooth: hci0: Reading QCA version information failed =
(-110)
> >
> >
>
> How do you reproduce it because it works fine for me:

Hmm, most likely I had a dirty kernel version somewhere. With the
current linux-next it works for me too.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # RB5

Thank you!

--=20
With best wishes
Dmitry

