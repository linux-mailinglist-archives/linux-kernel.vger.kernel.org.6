Return-Path: <linux-kernel+bounces-297933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64AC95BF5A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9431F26E72
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFEB15098A;
	Thu, 22 Aug 2024 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LOjtHvXy"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7EA18028
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724356879; cv=none; b=vFyp9LQAMA3BmMKroJxA3kkUcijLgmR6SktOqjbj0M067/P7ESsJ1iI9ctJRNHhDYPgnKKdvVxOznXlGJqRuZsYVhZ0oJXgay643CT3b/l7kVQZVBW5zFhnhr7TCx8e0QnoZZUvhhfvcq62HEsr3bvb/GgnpkMvgSNJk8o8QFQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724356879; c=relaxed/simple;
	bh=QarGgRQr+gI4+f2UfWJ5gh3yFj+scMNLwIR1YGzkv0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIq/Sb6sk7zTddo8/FMNIEhhxPDxsBL6wjswafuHwWnIL4DGDnExnJSEsmV2y+Mvd8JEP4wi6ocNdXhISPBg94S0N5AIWoY9fZevElW07AwrQwtO8CIK28tVoQnRF5Y3jvpRH30tz6NkGznleNJ6ytw8NBB9gganNjlnErkffcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LOjtHvXy; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53345604960so1348826e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724356876; x=1724961676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgHWaDNWmiIFNd4ncEUg8oQiBFdIcEtIv7xdX5ZNjFc=;
        b=LOjtHvXy+rN1UtIpdtm7iR9qPnhFoUQAc9rPis7Ig9k197ufGSCS6fboQq80sLJ/Qy
         2EWQkOUBfZxw1dw1AqXSchqakfiQBK43zHUIuPXTpeP04OvXFGOWyK6bXebGFfflsEvi
         OIG8Lof7+dmaXb6H8pIGpoUQJuao4LqR8/KMR0WjSwhaJ3jS44XFoU7QCkREGrOdz434
         Ea/gsaTZUEVxrRKoyjB02X109OVyvpyNHwoFbCPtJrqO3IetL6dw9UW1AfiU7dNm8Kz/
         h+pZqBpKIGmTyvqIv6zEZYXnsMnRc/iF1YqyOTLLPp8OTWMQEfIpPd5mQZPEhQAqbxX+
         7aiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724356876; x=1724961676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgHWaDNWmiIFNd4ncEUg8oQiBFdIcEtIv7xdX5ZNjFc=;
        b=KyUVF1kSJHL8HP2vMhD9SjLIcjeTqngEGTvDETKeyf3Kaiky2P+A+7kmrqYDvWIBW+
         eMNirJ+NT9+3/CWw7+ye53eTk5HxZQBpBawPth92c/++8gT3VXuP4ViJXJa9XsCMfzA7
         uvuVAnZqJj0Wz6vwTO3ldRHTUtPdda+obn9rfXVaYI0ozAgHaNTO5+vwl2qcrFJeP6D5
         vMYeXc+gpeSpXaYzH+YmIFjYfuS8HMnp7nQlIeg2DREb7H6tuCYhLPO39H24QFnyZcs4
         qAXEYVCgHTjy401HdVzrQavGTMIyLm7Zn8efYJMAunE2E0BRKekKkykGSqB0E+AxJx5Q
         yYWg==
X-Forwarded-Encrypted: i=1; AJvYcCXnQdvKrlAIxRcKoUZ0xc+u8WghTii7axFiejaU9Xm0L8/gtMvAQIFz92Cn6gdUjfLOb11HME9Aw+HDIkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD+vMTTsmXVK/BdK9S+7gfDi0WaRrY/CHrXM8+MhcV++Vqvrdl
	3GumwRPgTF9+d/fPZw9JXO+2FgQc5uUw1Cd+GH8mSe2u1Bnt58HtCn5+EAhKnTdBO8JFpwGHd8t
	c9Fm7uf/mKAT5TQJwKW9m6UQ3u3/br5Fu6tZoRQ==
X-Google-Smtp-Source: AGHT+IGDx6yb2VS9q05wWF0GDGcpEIDi1TSv52Or1xmRG3FDdwv89W2uTgFzK7JYmPGZ3u/3WrZX+wNo4dihHvHt45k=
X-Received: by 2002:a05:6512:ba7:b0:52b:c0b1:ab9e with SMTP id
 2adb3069b0e04-5343875589fmr46511e87.5.1724356875411; Thu, 22 Aug 2024
 13:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMRc=MeWFs+M+2kpotRqmcbPgXx8xCWEa-DqatGxWUAcixQb2g@mail.gmail.com>
 <20240822192838.GA346474@bhelgaas>
In-Reply-To: <20240822192838.GA346474@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Aug 2024 22:01:04 +0200
Message-ID: <CAMRc=Mcrrhagqykg6eXXkVJ2dYAm5ViLtwL=VKTn8i72UY12Zg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] PCI: Change the parent to correctly represent pcie hierarchy
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, andersson@kernel.org, 
	quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 9:28=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Aug 13, 2024 at 09:15:06PM +0200, Bartosz Golaszewski wrote:
> > On Sat, Aug 3, 2024 at 5:23=E2=80=AFAM Krishna chaitanya chundru
> > <quic_krichai@quicinc.com> wrote:
> > >
> > > Currently the pwrctl driver is child of pci-pci bridge driver,
> > > this will cause issue when suspend resume is introduced in the pwr
> > > control driver. If the supply is removed to the endpoint in the
> > > power control driver then the config space access by the
> > > pci-pci bridge driver can cause issues like Timeouts.
> > >
> > > For this reason change the parent to controller from pci-pci bridge.
> > >
> > > Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> >
> > Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Bjorn,
> >
> > I think this should go into v6.11 as it does indeed better represent
> > the underlying logic.
>
> Is this patch independent of the rest?  I don't think the whole series
> looks like v6.11 material, but if this patch can be applied
> independently, *and* we can make a case in the commit log for why it
> is v6.11 material, we can do that.
>
> Right now the commit log doesn't tell me enough to justify a
> post-merge window change.
>
> Bjorn

Please, apply this patch independently. FYI I have a WiP branch[1]
with a v3 of the fixes series rebased on top of this one. Manivannan
and I are working on fixing one last remaining issue and I'll resend
it. This should go into v6.11.

Bart

[1] https://git.codelinaro.org/bartosz_golaszewski/linux/-/tree/topic/pci-p=
wrctl-fixes

