Return-Path: <linux-kernel+bounces-377712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766BA9AC2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0381F21D88
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE15D158533;
	Wed, 23 Oct 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="e9nHDv9z"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AEC1581F2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674217; cv=none; b=C1B3pvYPLoudRZqLYKq0Ms/RDNAAN+eOH4fP0mIM2JXVI/GMLfe97qOqFIHvXWhtkyrk5jZTPZYv7WaxsZ1oy6y8iIxlEm6ZwijC7fJKG+SHAMpQj7cpL1+5iZ7AjdBH0Upt7zbHeh0YkttTR2xLFbiEs2nvyGM2JtfKQxGDilg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674217; c=relaxed/simple;
	bh=QvFXcl2GGa+veoOPQlIdxPmI+G4TCcpYQrnSdGupX2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sn9rVZ76JCbGzVNH6fWdUFVzxPirjfOTdBgdQhHNRqqnQMbCYE4vBJu6ioEQDs3W9j6HIBC8noRMTpFUZ1h6YwrSBWzC1xCUs/25jUfmM9FUGsN14D3o6G94NC1t1pKqdaTyJ4miTGb1JJm3IPAx8kwXn736Y9kIjMiBrik3Kgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=e9nHDv9z; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e690479cso7016277e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729674214; x=1730279014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvFXcl2GGa+veoOPQlIdxPmI+G4TCcpYQrnSdGupX2U=;
        b=e9nHDv9zoPvfe7r5HKpLYAhdye/lqmWAeGaER9an309NB3qeXcEHl6t1S/je3f+LKB
         OLZwPEHNOBoPLWxgVfugnmvRui/k849A3cCUHgItRMxTbhnyirnI/13OCyshL0+D2X8P
         kGW37dzkW1rTVvyozH+FxndejR8W1dMXCkfmGq19sRsR33YDhje9ZDK+EXXhK87i3MWG
         GlS1AnGvjFND2V9TQIG4KxnUIb/SHjNy12pwHh2A37MXHxq1UBcnJ3vlt2+Tr0e3FOM/
         Z1bwuO15/wloxBV2XGB+1ViALZeITOqcWgLop8UfCDhb+cYQwJIubBc40x4GgjXORpGW
         M3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729674214; x=1730279014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvFXcl2GGa+veoOPQlIdxPmI+G4TCcpYQrnSdGupX2U=;
        b=AflT8kIYyTEC45WWbkPxt6IxfDUQHwVhvE4twaXQpN9QIxGp97QuwcOmuby37ApjTB
         n5hCyYw1LK1lZXngz9BFJK9IqxrD1iqZ949zbo7Z/MtcralICo9P+p8mjeSzD0Qv8Vt3
         F6TV5rWSpWhhh3YUHUV6N9tANljIXRymampaL+hfw/yDCilkEiFNmnEXM1iFYZ4dfr6K
         gqS1VHNpJyzWfwr6P0kpicc1uMbqPBgL9ZCVAsESzYRQvjQ+k2A2JGynyxzrlrHsxdGk
         eImsmZ4sZi1Id9pg2DvB26htgbz1V3Y5bh70HkiB5VTlgRVz9EAUqNxucL+CI+uAq2va
         EfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/ua1j9Ysf3QV6UXqHTA9JDevjF0HcZriqDInlwsjJaW4tuAgYU17jvX64V0skZeat/YkYhsm9L4FCSrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+gW3Cx6ro3RRGaRyKUToGaUa7GkYlaW2+x+7jkw9KwraoIup
	QgQ/olhe0Eo69r6Avd6tk2l31ZWXLB5NYY0SdsxnWXJQPSNwXJu7ChWUFBP5272/MVxytyYLIkq
	2OguUNtD353Li6BgkjhbEhzQvXPGH805Cn4Fpqw==
X-Google-Smtp-Source: AGHT+IFD5laevTuDyUBfuQbJDuOlYCbjcvR7CBksOf9DPv2HcOtedvdJuBMvxu2Mj8O9hcpNQb3nRu5g/5EpQQgJQAc=
X-Received: by 2002:a05:6512:3b8f:b0:53a:1a:cb58 with SMTP id
 2adb3069b0e04-53b1a36b850mr858329e87.44.1729674213517; Wed, 23 Oct 2024
 02:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007092447.18616-1-brgl@bgdev.pl>
In-Reply-To: <20241007092447.18616-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 23 Oct 2024 11:03:22 +0200
Message-ID: <CAMRc=MdWNTkLbRJ9YTi2T4B=2FRCrn2M2TZs+DxqQKxrqjpJ7A@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/pwrctl: pwrseq: abandon QCom WCN probe on
 pre-pwrseq device-trees
To: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:24=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Old device trees for some platforms already define wifi nodes for the WCN
> family of chips since before power sequencing was added upstream.
>
> These nodes don't consume the regulator outputs from the PMU and if we
> allow this driver to bind to one of such "incomplete" nodes, we'll see
> a kernel log error about the infinite probe deferral.
>
> Let's extend the driver by adding a platform data struct matched against
> the compatible. This struct will now contain the pwrseq target string as
> well as a validation function called right after entering probe(). For
> Qualcomm WCN models, we'll check the existence of the regulator supply
> property that indicates the DT is already using power sequencing and
> return -ENODEV if it's not there, indicating to the driver model that
> the device should not be bound to the pwrctl driver.
>
> Fixes: 6140d185a43d ("PCI/pwrctl: Add a PCI power control driver for powe=
r sequenced devices")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/all/Zv565olMDDGHyYVt@hovoldconsulting.com=
/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Hi Bjorn (Helgaas),

It's been over two weeks with no feedback but this patch fixes a
regression on at least two ARM64 platforms. Could you also pick it up
into v6.12?

Thanks!
Bartosz

