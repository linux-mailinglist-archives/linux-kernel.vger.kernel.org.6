Return-Path: <linux-kernel+bounces-237698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D9A923CCF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117541F21BF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFB815B14E;
	Tue,  2 Jul 2024 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="k2kfU3xi"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FB012FB02
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920894; cv=none; b=qDQskHmXdY31F4bLVkrm0kzHtzbLAiBBPSdECbzldNdsOibk04NORQH73l3fLOJNyRVZieKil1dIfuIRmyFWPFnM6dodL9ha1sszRZMiiCZUZW1WWZYGF8PXM98ucNoPVF6vdfd6wkK7D76fGfkbp1cF1XPo4LWHQU16QR+2c/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920894; c=relaxed/simple;
	bh=J+IFH/UAtx0MadyzuFPkt42kK2cdz7LHsWds9tSV8Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGfBCZ4QK3NzUc7UnCKMu0W6MY26Xwyk97Td1EsfuO1KYLDSZtue9Abilde2am5M7vhr4HJ14I3ITzGVeZtf1ybHIBvuI07SRwlasZXUHR8wPBga//XqJA47tPaItEDwlCh16X1bp3sfEQYogAszO6Gp4K+X+7DMzjGXzOywD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=k2kfU3xi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec4eefbaf1so42772851fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719920891; x=1720525691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+IFH/UAtx0MadyzuFPkt42kK2cdz7LHsWds9tSV8Ac=;
        b=k2kfU3xikfYi1UDFshkUsg42cOuzIpcklVFzdpdG/4MLc9TYYy1PhqiJtL4pvjrD2G
         NPx+ntX9mfRgZFUtdUhMVb8/fcpdakiGDswo8+8xTD8ezgRHGccosoRItdYX2Vlt6NOt
         rNBQJCDbtQd2QfCNxGLx1ylFrJNx5v4OdWd4jL4bZpIEH1uD1kVTqlMJuKuXn5GI9T5X
         4dEnfNL/Smt8Cojkbb5rP1UtHWwMKT+JqhooOCyPUlYPft87lW4TqnZQf+DMWIIvQFZL
         NyK+scHXFwV8iFbj+SSc/JCe/pqTFGxKfJJkh7edn9uegHRpljo9i4iDDCEkUYoBDlAW
         cSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719920891; x=1720525691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+IFH/UAtx0MadyzuFPkt42kK2cdz7LHsWds9tSV8Ac=;
        b=bzS0gj1zxAJH7Xy54NYCkGoc+f7qzVM3FMxoIE+b+aw/mdsZFWs0G4E7UuS1KqDy6z
         9DD2hUsnc7JMW6ZHVbHoFcfF6+KaGrLw1/qQovQy4Pb3ORbzDzsypBzQJ9Sq2m7aKQ+R
         Ucndjj9tx96H1pIMWUpN6hu347INa62mM5t3BLHuqxeEwFY+Cnayb94VtE7bNh5XpDUh
         h8GafGHHx/Fp7oTCSS1HfjOi1WfWQg64UB6PpvNkNooRU3ctox2bUqgvC01N8Ohv9qt0
         bByofe5iM8MsdiFB5BNAQ9q6RCCQXFWlB8BJXoL4dDQRfRwnRi7suAQDTTNIyY8i0wTw
         hKoA==
X-Forwarded-Encrypted: i=1; AJvYcCV5O6iZekhkl/EZ41g6xigybff44oFsMqWuWpt9LePIcz+9xPBQaFp1nuX4VSP5jlfCjJGm8EAHax9Yd0AtzmFgNL8smBhvrgpt+5Hg
X-Gm-Message-State: AOJu0YyKBMx561s0NHk3radmdeF0XZOuOBs7LSh1y5HaXYoebmCdApg7
	HEFi5ppsD7RS2i+hGSdFwq9bJVSFxLyd+knjOr6PO+HjLDMVed2KDXctQOS+sY4adV8bL2+J9QO
	RZLopIiCFfBrbrcGXx191TSLk+pfgylI2gQlnsQ==
X-Google-Smtp-Source: AGHT+IGYlnBmWEqJp+GJI605I3OI/Z/NbtE8viKRB4pNaGMzYRQDjSTGWfLQ7W+EGMfmgv9q+2mq30gnD2xwey5TD5M=
X-Received: by 2002:a05:651c:1509:b0:2ec:5603:41a with SMTP id
 38308e7fff4ca-2ee5e345927mr55982491fa.2.1719920890946; Tue, 02 Jul 2024
 04:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702114103.16068-1-brgl@bgdev.pl> <CAA8EJppo4X1KmeeTRz9n7+9S0fGWE4AD1O1cCc_aPHTWPUGVvw@mail.gmail.com>
In-Reply-To: <CAA8EJppo4X1KmeeTRz9n7+9S0fGWE4AD1O1cCc_aPHTWPUGVvw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 2 Jul 2024 13:48:00 +0200
Message-ID: <CAMRc=McVo364EruPtBCkLdR86=PfvSQFztTC_HUO0RPRCayAxQ@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: qcom-wcn: don't request BT enable
 GPIOs for wcn7850
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Amit Pundir <amit.pundir@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 1:42=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 2 Jul 2024 at 14:41, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Due to having many existing users of wcn7850 in the kernel, conversion
> > of the hci_qca driver to using pwrseq exclusively must be done
> > carefully. Right now, the Bluetooth driver requests and controls the BT
> > enable GPIO and so the PMU pwrseq driver must not do it or we will run
> > into problems depending on the probe ordering.
> >
> > Add a flag that tells the driver not to request the BT-enable GPIO. We
> > will remove it once the conversion of the Bluetooth driver is complete.
>
> This will not prevent the pinctrl conflict if both PMU and BT devices
> declare pinctrl for the BT_EN pin.
>

Hmm... So maybe we'll need to modify the BT driver after all. Should
we see if we have the enable-gpios property in hci_qca and - if not -
try to use the power sequencer? Or prioritize the sequencer first and
if it doesn't match, then fall-back to the current mode of operation?

Bart

