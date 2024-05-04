Return-Path: <linux-kernel+bounces-168761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A855C8BBD4D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 18:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652E728212F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 16:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4125CDE6;
	Sat,  4 May 2024 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGu+ImQq"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390EF3D971
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714841691; cv=none; b=JPDFotcShlBYjorwDk2LtkuHrDL1/u0QwZbQqaH5tB8VaRCbFv7c9wI4zlN9302WoFJ5Rl8kq4WavowOqJ6S5U4XKkhxLLvM0CZsbNwi5/2P2eTCH9hO+UroBpN+n7lyuIUn6fdGM1/bDiHHBbzzWy/klKQKiyfy4n43YQmPEqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714841691; c=relaxed/simple;
	bh=zo0FuvvheiYFFNT9SiYqO5W3uBgSTGVpZYuFn4XhiwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WG5MMntZBOFvw12oT2ncleMFtgbVArjHxB5H0VjrW668nPXGq4fKs0EuKAQ42Rz+mE+XzL/fps9Ckp5EJJrqatwUDmhfw27Y8iqo6v3fyB/wyAV2tzNOv6EYreYmoSEe6qoNbz/sSGcHl/NENK2zOyHW4hhUJHZuJXq8T1HAkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EGu+ImQq; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de60380c04aso832480276.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714841689; x=1715446489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tgIbTlJhI5M2gVvaXjd3+8gvJ0cygD+QTOHA6KrM33U=;
        b=EGu+ImQq15C9oAXQMirzbB13CaAuAjcp36h3Ab+vThGiRCqP6NCx/SefeqBzjyBt/q
         /C1yRaqsJ6e1BjHG33CQYR0xp8QTGYRXMQkuHPuJpviA9K5Va3/lAJIWq1hQ5JNLBey8
         rM6Ei7/uk7oOxSVdsPZIVNzI7UCUBq9d8n8iDV7IigaGK5XMYVUuXRjTxknMxjyfOm4N
         gRrWEEbIVtPXP/YOA0cs0Ko25/Si2rPktG4vEJaKdmJ49C/fauOXN4KU9Zs88G0MpG5W
         +G55UO6tuc4bXANSi3feXp3JG98Pi5UvhLFVg/ayKlrTo8VHoDjyiQo0VPl3/ElU9Hoe
         aIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714841689; x=1715446489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgIbTlJhI5M2gVvaXjd3+8gvJ0cygD+QTOHA6KrM33U=;
        b=WydAzUJNwgJz7WhQOoKJ2sLVci84RhTwjtBpimnIqo6FF6DmPrYpbs+Pld8b5TS6St
         oOLoycuSvQY2/nWh96eUrPzRX0CnB9ykPy5UrrLSVJuTTdlH40OYm8GVkvhU1HyMxI2b
         K4aJlf/VqootvUkxCb6/XDVXN5CvigongrUQQO3BLIfQY+eWtrbD+kGxWY5lLTj04cQ2
         oKHH0ImVzwDzD07TM8wWCfIaKRiX2mpOH5gk1gCKuSizeYaos7AcZnxkIMwIjTdzKkkd
         F7DXdWx0ZncYUtxiZw5Ruq74AGtfXw5QKL9Dj1M9JW6zAx9oF2dfPf9QH0Ze+stoEMUA
         DhKA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Ibuce2WW7ymyDJcwBAlUohmzmfpjn3LPHtxx26QJFMebqjSBRTy1uYxdFepQP61f9dLZlbHAWeDH/mwihsr2sZ9pf7gypJ6DeNJN
X-Gm-Message-State: AOJu0YwsKHwt6ovoiCzFSyyr53QtOgIdzhowna752lzLj+qRq0PcpBAC
	PL1eCv/qs2cRONCQdNbWRW6AnmZ2beHjzTCZtQhBAWy0yiBI4ozYqNBMfAMPcvKjGOO4XuPmO+H
	F8T5HL8CpjrgKTuy4dAnPr6HHXNzHwI0iUeGpkQ==
X-Google-Smtp-Source: AGHT+IEt9LVSBgeKJB0TGRM0UGx6hBWf+ehs1XeTfLSJzks/QJ5xn5QgePdv1YPfN2bT0VpBiqOznAyRWOlU4ZFKPcs=
X-Received: by 2002:a25:f604:0:b0:de5:53a6:24ed with SMTP id
 t4-20020a25f604000000b00de553a624edmr6272638ybd.50.1714841689115; Sat, 04 May
 2024 09:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424-qc-pmic-typec-hpd-split-v4-1-f7e10d147443@linaro.org>
 <CAA8EJppCxfrBcctaR2jOrwPuO8ZFQw9vmi-0CH_sSWBm3ts7JQ@mail.gmail.com>
 <2024050415-retorted-gory-5fa6@gregkh> <2024050416-mandolin-gauging-9342@gregkh>
In-Reply-To: <2024050416-mandolin-gauging-9342@gregkh>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 4 May 2024 19:54:37 +0300
Message-ID: <CAA8EJpo6Gar5W3-2jB4YC1OzGWMauCxxJ9oeRHLgkBjRTqLktw@mail.gmail.com>
Subject: Re: [PATCH v4] usb: typec: qcom-pmic-typec: split HPD bridge alloc
 and registration
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Caleb Connolly <caleb.connolly@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 May 2024 at 19:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, May 04, 2024 at 05:15:45PM +0200, Greg Kroah-Hartman wrote:
> > On Sat, May 04, 2024 at 05:23:20PM +0300, Dmitry Baryshkov wrote:
> > > On Wed, 24 Apr 2024 at 05:16, Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > If a probe function returns -EPROBE_DEFER after creating another device
> > > > there is a change of ending up in a probe deferral loop, (see commit
> > > > fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER"). In case
> > > > of the qcom-pmic-typec driver the tcpm_register_port() function looks up
> > > > external resources (USB role switch and inherently via called
> > > > typec_register_port() USB-C muxes, switches and retimers).
> > > >
> > > > In order to prevent such probe-defer loops caused by qcom-pmic-typec
> > > > driver, use the API added by Johan Hovold and move HPD bridge
> > > > registration to the end of the probe function.
> > > >
> > > > The devm_drm_dp_hpd_bridge_add() is called at the end of the probe
> > > > function after all TCPM start functions. This is done as a way to
> > > > overcome a different problem, the DRM subsystem can not properly cope
> > > > with the DRM bridges being destroyed once the bridge is attached. Having
> > > > this function call at the end of the probe function prevents possible
> > > > DRM bridge device creation followed by destruction in case one of the
> > > > TCPM start functions returns an error.
> > > >
> > > > Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
> > > > Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > > Dependency: https://lore.kernel.org/lkml/20240418145730.4605-2-johan+linaro@kernel.org/
> > > > ---
> > > > Changes in v4:
> > > > - Rebased on top of Johan's patches
> > > > - Link to v3: https://lore.kernel.org/r/20240416-qc-pmic-typec-hpd-split-v3-1-fd071e3191a1@linaro.org
> > > >
> > > > Changes in v3:
> > > > - Updated commit message to explain my decisions (Johan).
> > > > - Link to v2: https://lore.kernel.org/r/20240408-qc-pmic-typec-hpd-split-v2-1-1704f5321b73@linaro.org
> > > >
> > > > Changes in v2:
> > > > - Fix commit message (Bryan)
> > > > - Link to v1: https://lore.kernel.org/r/20240405-qc-pmic-typec-hpd-split-v1-1-363daafb3c36@linaro.org
> > > > ---
> > > >  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > A stupid gracious ping. It would be nice to fix the issue in 6.10
> >
> > Is this a regression?  If so, what commit does it fix?  Or has it always
> > just not worked?
>
> Oh wait, I need Johan's patches applied first, I was waiting for that to
> happen, so I'll take this next week when that gets into Linus's tree,
> sorry for the delay.

No problem, as long as it has a chance to land at 6.10.
Thank you!


-- 
With best wishes
Dmitry

