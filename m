Return-Path: <linux-kernel+bounces-303279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CCA960A25
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0774C2826D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9C91B5EA4;
	Tue, 27 Aug 2024 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="J+l6ucgX"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B561B5311
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761575; cv=none; b=gatBUcdxW7KbOaFfCmIMP241D0Dsm++QQOVZPqIcxT8vuq3R8FemE7dLxT7kt5xn9lt0MxejXic6fhaWpNF8kPh70nJ4eLDpMTgMwAC8mZ2YPrNdQx5MKdDDSMdeLioXSLNruscD6w9n3nqY11NmXH2ZhaFECjn8ZwxfnnVqySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761575; c=relaxed/simple;
	bh=N8luI6m17f9UGxB1zqffdu5fVSAFGP7sDjStDenGE5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDoIh0zckyzwFb94UodfDTeICD9j8CvttPHdmYY4HaHVN+Us0e5waMiSuS96/Sui3fO+exbB02CDSqACPdnmDl8Fzm9s1tN4zraLV9YZoR8uDisdbdQhGKF7AqdT5qi2pGH5xKl/jAn353uCKdSnCWRG20x1Iv4eKuSdXuqW8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=J+l6ucgX; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-534366c1aa2so4555448e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724761571; x=1725366371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8luI6m17f9UGxB1zqffdu5fVSAFGP7sDjStDenGE5E=;
        b=J+l6ucgXQ9Bi68T8HT0X8eTK0GN6saZ1qMcZaBuiD6us8fnxCstoPtHlUiy6/nVZl4
         oF/7R73S56fjN1Lo07YYPa6BOrzR2WYEszYEmOQyqcwp0Q9Cj7LQrKQ1L+h5a/qOjipH
         txQQrRwkZfVJF3Uwq9pTB/wy8sl3pBd6rzMLyPiuW4fTjKaTrMarHeV7DeE5AhZ0ixJ5
         /n7tSu6RfhmGoviinI8DNRIKCw1yjH1/nOsJT9cbAGH/0iy7Af4UPxY3PfuclZlEqzDd
         y1DEBoSJi8MGldzmWnMk99DF1vPCJyYpqcgL42KXfXWfKwp5cwcKTCOOnXkOuCJahqYz
         j8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724761571; x=1725366371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8luI6m17f9UGxB1zqffdu5fVSAFGP7sDjStDenGE5E=;
        b=hyOahClKt9So7cZgjD//oAe+ucf0t65lrOZ9kGQHIZE079flXTc5TtFvJTmiqFRZ9n
         nilbgytkam06kxM4Jo3w5hDeO9/dpXHIylgykGBA31C0XJHbK4S59MJQMyy2F2Cdpkre
         UjY1F9JBZi00snQ2DYMogJ2w9EQdZISiSuTUyYMr+Kq4ltnZI0CzzwKCUDBZ0ynVNunk
         /wSx5pDAY3j39CZNeIiukJ6YrIbf2meipt9+M/kfnsZEmIwF79ejyuu7W97lpd24u6Yz
         /szsYzanBuArbFhVK38DM5/MLMgYW2Ozd6gB1ZNOHhGu5CimxJXCRxlEdtTfrT3rm54O
         aWEg==
X-Forwarded-Encrypted: i=1; AJvYcCUwo8MssZqUGinEkoGXvsunaFbbGipfUrh3KfHCZj/2WEvrEFEWMPHjZvJqRW1aQAdedwLI5jmOsWdxHIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcNqnim1sOyZDWoE3q+HeJ2S7PR6emD8J/q/psiQQB/BLo+gxM
	jcEmS9Ogh4wGwDxPmVVm/esXut/KmAHVqEiEHuqhSQx8aOjs+4vlWlkn1u9rsN28FfxPpdnjAax
	uuH8sYY9M6JdK2cKNRbJ9FgQiogzkXd6HoTnBpg==
X-Google-Smtp-Source: AGHT+IGo8I6lkFpmzVs/WSLJJyIYmtHBUkiVnpQ0LCHAI677pSb1r7klQMhowNn1vb9+UzmURuvd/q8rYc415hB5bYc=
X-Received: by 2002:a05:6512:39c4:b0:52c:9e25:978d with SMTP id
 2adb3069b0e04-5343885f5d8mr9249284e87.45.1724761570408; Tue, 27 Aug 2024
 05:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823093323.33450-1-brgl@bgdev.pl> <20240823093323.33450-2-brgl@bgdev.pl>
 <20240827084012.rjbfk4dhumunhaaa@thinkpad>
In-Reply-To: <20240827084012.rjbfk4dhumunhaaa@thinkpad>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 27 Aug 2024 14:25:58 +0200
Message-ID: <CAMRc=Mfd08i0NFsuf=igJRJszDNfLyHf+bf6ExjNYxX41CMdWA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: don't rely on of_platform_depopulate() for
 reused OF-nodes
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:40=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> + Rob
>
> On Fri, Aug 23, 2024 at 11:33:22AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > of_platform_depopulate() doesn't play nice with reused OF nodes - it
> > ignores the ones that are not marked explicitly as populated and it may
> > happen that the PCI device goes away before the platform device in whic=
h
> > case the PCI core clears the OF_POPULATED bit. We need to
> > unconditionally unregister the platform devices for child nodes when
> > stopping the PCI device.
> >
>
> It sounds like the fix is in of_platform_depopulate() itself and this pat=
ch
> works around the API issue in PCI driver.
>
> Rob, is that correct?
>
> - Mani

of_platform_depopulate() has more issues than just that. For one: it's
asymmetric to of_platform_populate() as it takes a struct device as
argument and not a device node. This causes issues for users like TI
aemif that call of_platform_populate() on nodes without the compatible
property that are never consumed by any device. AFAIK there's
currently no way to depopulate them.

In this particular case I think that the OF_POPULATED bit should not
be set when the PCI device is created but only when the platform
device is.

However I'm afraid to change the semantics of of_platform_depopulate()
et al for all users so I'm more inclined to have this fix in v6.11 to
avoid releasing non functional code (pwrctl devices not being removed)
and then possibly introduce a new variant of of_platform_depopulate()
that would work slightly differently.

Bart

