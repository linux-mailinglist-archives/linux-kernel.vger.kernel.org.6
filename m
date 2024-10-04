Return-Path: <linux-kernel+bounces-350230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415199901CE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC36C2832E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E364F1487E3;
	Fri,  4 Oct 2024 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sov/Vfnc"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF0146D6F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040123; cv=none; b=GbCs+lD5s/mijM8pzL3yEb0rSEsHaQbP0VzCC7hDuZzqcoggEeuKpop/jFlR4+0AteyV4MkHL8cXtxllnPJ9nJ3jaRZuCOTmZ/8XhIY0wZkoVeI2j9zdNNOYkYxJKavUOReeDlYAypdHq7xJBPLjSDdcTXxcv+CUDVvJlfvCFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040123; c=relaxed/simple;
	bh=lnlqUDuMa2e9Y5GuWRXJKLw9R7bHb40yU9o9HsQPXyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dk5IVgg2ERWDCVBIRRAn39wIHYphs6A93NuDUsxJ50H9vFNZLzYpw6HsOfSIRkG4oWO6SwmXWRA14DLeWESj+y2cg0ONjWn1pVUHAQqqWxJIqrZ3HpNtO7E5EMoCmDSDf9tW7AxEPlqVD6ar32OVr/w4a1JprBmPim/CKP8w3xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sov/Vfnc; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53995380bb3so2464840e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 04:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728040119; x=1728644919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zAv4teiawY0HKbeRkxppY/HvO/+VNGyuZ+Xi9JME9w=;
        b=sov/Vfnc79XzCSLFQVTgjyUUDap/mQbNyrQjTv2Sitoq6MQBKg0qe19ftckwALB+nO
         SjQddi8IOqMJ0aoYXaZ5c9DIEjFEMzB+Fel/gaGrdxuIUlWIjSnnqV7JKWK7qNQ/4oDu
         W1MRpJMr+qTrCGKnpLudfibjB9v3N8lw51dOO8BcB6dy7EwI4KpOtFWKjypyJQFuXowN
         UovV6y4TiDL5DZJExOfAi4vhG42+arGiybFYA2urMKJr2aQHb2RNk9kUieSTGhFe54Yt
         ofbfy+twnVhZD8s4JXg7/4a9kWTEyWU8hf4BzO/zYZWc3RMtlKeQVEvqg+DLQj4reASZ
         SNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728040119; x=1728644919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zAv4teiawY0HKbeRkxppY/HvO/+VNGyuZ+Xi9JME9w=;
        b=pz0UURDCgBUxBpe1OhOV9r+1eCIoqfY++6SExvPbqgmBoCPozRUSoaE59ZjdhiBVqn
         prY7+NGMXQyAsOK3H28ERnvM1SP2O5eWprYGRyuwn9b6yWqnrEg8gDnxMUFXAp5rroXX
         lopPF1li/j/h1+u76Q+eLyHnWek7ti3eLG82d1ZzVylNleAzHKNOm4PM6ncv83ptSYhv
         KOD8IR6b34hSGr6kFnKzNf3YZtkypfFXN5DwrsuyZfZc45OXLlBfsO0/qfcb+EqwE92W
         g/S8kJkbocUGWym9aWSqizyviCQPv9Clvfbu4Frk7570LHScfc9U2UOq0wSlVvky2uWq
         1nnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk1TNIWW+vCloTahEqjQ2pn8Ovugnp2pZlQEWDTXZUv07Zot03fVfOgtkKHyFlhehIpYs+KJcRyGkCxcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZFyA6qeBtfSlDi0PBY+t2vZ9VfeEjY5cY54GrQRKuMpGN+eZ
	BDzoHlDNQKqSK5k4JfiFFW4BEFD6FO8/JZvXCoF7lszJlLW3oWT+6EBiy2+PI602zUpczw2NfWF
	dp5IY8Pv2nQPbJa5eRUfkXKUdrwRa5zkLLX9JQQ==
X-Google-Smtp-Source: AGHT+IF59bAUfACzdR9OjFr2GdrYrTAff9rnPLvDIfFSwtr3tADvLMXbak08INwh5+o50DTBVNOh9veiJsd4i7LlEZI=
X-Received: by 2002:a05:6512:e88:b0:539:8ad5:5093 with SMTP id
 2adb3069b0e04-539ab88ce30mr1670088e87.35.1728040118901; Fri, 04 Oct 2024
 04:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930103041.49229-1-brgl@bgdev.pl> <20240930103041.49229-4-brgl@bgdev.pl>
 <Zv565olMDDGHyYVt@hovoldconsulting.com> <CAMRc=Mc9jMe=hSXmcRLLX61abUjetCRZVeOK3G31vdx5JQNNMQ@mail.gmail.com>
 <CAMRc=Mde8rGT+81ViTX0Qj2sDrD59dkLHeUZd1xkWO_H=QvC0Q@mail.gmail.com> <Zv_Lok1BT1Hg13dC@linaro.org>
In-Reply-To: <Zv_Lok1BT1Hg13dC@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 4 Oct 2024 13:08:27 +0200
Message-ID: <CAMRc=MdXRj0oOxmn_tVKmtVQqKS0H_CGgMBhb6rAOmXz7Qxahg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sc8280xp-x13s: model the PMU of
 the on-board wcn6855
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 1:04=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> On Thu, Oct 03, 2024 at 05:16:59AM -0700, Bartosz Golaszewski wrote:
> > On Thu, 3 Oct 2024 13:38:35 +0200, Bartosz Golaszewski <brgl@bgdev.pl> =
said:
> > > On Thu, Oct 3, 2024 at 1:07=E2=80=AFPM Johan Hovold <johan@kernel.org=
> wrote:
> > >>
> > >> Without this patch I'm seeing an indefinite probe deferral with
> > >> 6.12-rc1:
> > >>
> > >>         platform 1c00000.pcie:pcie@0:wifi@0: deferred probe pending:=
 pci-pwrctl-pwrseq: Failed to get the power sequencer
> > >>
> > >> Can you please look into that and make sure that the existing DT
> > >> continues to work without such warnings.
> > >>
> > >
> > > Ah, dammit, I missed the fact that X13s already has this node defined
> > > so PCI pwrctl will consume it and try to get the power sequencer
> > > handle. I'm wondering how to tackle it though... It will most likely
> > > require some kind of a driver quirk where we check if we have the PMU
> > > node and if not, then don't try to set up power sequencing. Any other
> > > ideas?
> > >
> >
> > This is untested but would it make sense?
> >
> > diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> > b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> > index a23a4312574b..071ee77c763d 100644
> > --- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> > +++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (C) 2024 Linaro Ltd.
> >   */
> >
> > +#include <linux/cleanup.h>
> >  #include <linux/device.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> > @@ -87,7 +88,31 @@ static struct platform_driver pci_pwrctl_pwrseq_driv=
er =3D {
> >       },
> >       .probe =3D pci_pwrctl_pwrseq_probe,
> >  };
> > -module_platform_driver(pci_pwrctl_pwrseq_driver);
> > +
> > +static int __init pci_pwrctl_pwrseq_init(void)
> > +{
> > +     /*
> > +      * Old device trees for the Lenovo X13s have the "pci17cb,1103" n=
ode
> > +      * defined but don't use power sequencing yet. If we register thi=
s
> > +      * driver, it will match against this node and lead to emitting o=
f
> > +      * a warning in the kernel log when we cannot get the power seque=
ncing
> > +      * handle. Let's skip registering the platform driver if we're on=
 X13s
> > +      * but don't have the PMU node.
> > +      */
> > +     if (of_machine_is_compatible("lenovo,thinkpad-x13s")) {
> > +             struct device_node *dn __free(device_node) =3D
> > +                     of_find_compatible_node(NULL, NULL, "qcom,wcn6855=
-pmu");
> > +             if (!dn)
> > +                     return 0;
> > +     }
> > +
> > +     return platform_driver_register(&pci_pwrctl_pwrseq_driver);
> > +}
> > +
> > +static void __exit pci_pwrctl_pwrseq_exit(void)
> > +{
> > +     platform_driver_unregister(&pci_pwrctl_pwrseq_driver);
> > +}
> >
> >  MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
> >  MODULE_DESCRIPTION("Generic PCI Power Control module for power
> > sequenced devices");
> >
> > X13s is the only platform that would use one of the compatibles support=
ed by
> > this driver before power sequencing so it should be a one-off quirk.
> >
>
> I'm guessing the pci17cb,1107 node in x1e80100-lenovo-yoga-slim7x is
> also affected?
>
> Maybe you can check if the node has one of the -supply properties and
> return -ENODEV from pci_pwrctl_pwrseq_probe() otherwise?
>

Yeah, that may be a better solution I suppose.

Bart

