Return-Path: <linux-kernel+bounces-194028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF518D35A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4751F25A09
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3919717F39A;
	Wed, 29 May 2024 11:37:00 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D3013DDB1
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716982619; cv=none; b=p05SCWQjoX5SFuz+YolAeI6u6OVPHuT9BkTwftqrlSiIdmx5+COU/QzRoG3R9asx9JBphau4/4QWTU9SJBqAol1mhV0tavDC7+kyL9VGpuULLnKNjOR83jVvpZOEeW9B27h97PsNN4mCeYYsaIyvJUhY1eVtSX2Kl3FF40QBKY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716982619; c=relaxed/simple;
	bh=iShmSxtXMPEhTX4ponozTRBBflmhDnZSE0hptLtsa6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3bZDVwhLqcww47Fm5Zw0JO5XVUH9LKfAwiK3Yu/YXAuc3dYbRVf3YDhxTS6UIB40Fwbk7EQRSWejdCE0JZ92sPBbMcAWbHPK3oNuPScqnwtITVxcjvqjetXDbxsXOG0HYCdSRb3ZJ5XOMp3IZj9B3Wmd0NEJNElL0Qz8DkgOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62a08b1a81bso18143257b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 04:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716982617; x=1717587417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAcy5LwIEmEVGAqzGqE9HEuOYHbjFDuBNtLO4xPGjiM=;
        b=mMupJzsASVG3ZZZq1ZZEapvx0DyRQIGmbyKvXyiuBNsphC5nu8aFovY2icPqHd0jcz
         6+87YGPxhCEdrzFLKZPXEFJk2xRGj0TzD/VJywBA6FWrcgGZlSCXaQRP24/TqK9Q7hi+
         bCQyLAmFI2FJaXW08MgEki89XzxDYX8WcW1WD1n+Jjz7MhXuMFmI9wmmKdoMoECs7acs
         0UiwTAi4gJpSOgByrZ68fJzYM85DLK/SeTsxfvDoGk4ZrsoGXyavWsIcXZZSrFdeTl/e
         E6xjeXrzQUNU9xxpAPphxbBLZAi4oHE9rasYOfKTuPcQzKE6f1BjQ7RBKMeP8wXOs5B/
         us7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKPUhZV/WAPi9GMlR0Bfbt48ak1ulBbz9l5uaQapQcfye2BWrVSOPBRXMB321c18yMgfK5lBygbfKgH/u0k71Gdcn65hxzrWDPJpHA
X-Gm-Message-State: AOJu0Yy8nEL2umIfxbeb+qNcTSsBeHTQ3SzwdXdgBCaeVV5WVHYFMRUV
	55lOSwMWeGo2a5jAT1IKpgjlsn+8ekFEIHjT1b88GTcuh1/V3L1Rdp5TgnupHaY=
X-Google-Smtp-Source: AGHT+IF4B/i16JVgjvn9Gq3AMZ6xwnJfhnnJ/T89UQd5PVzaSEKNvWZ8UT1ysVkPHfHhor4MZFfZgw==
X-Received: by 2002:a0d:d644:0:b0:617:cfb8:4e50 with SMTP id 00721157ae682-62a08d86a9bmr156046657b3.17.1716982615693;
        Wed, 29 May 2024 04:36:55 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a3bfeb3sm24055037b3.38.2024.05.29.04.36.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 04:36:55 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-df7713445d3so2147464276.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 04:36:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdPXln+mEOBYiar1Ytk26DdjUtpe6oqFuvRRYkNTstIcR5aiMsaOXZBcIES6cqD5NeyKxBS4oR7B8pv39vNezbdmtkUxdt0K2A8q/w
X-Received: by 2002:a25:bccc:0:b0:df7:8291:d109 with SMTP id
 3f1490d57ef6-df78291d1dcmr12179009276.59.1716982614980; Wed, 29 May 2024
 04:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e00498fccf6dcbcf63bd24a137bfc7abd1b98345.1716967720.git.geert+renesas@glider.be>
 <Zlb_txl4CqCfxWZz@pluto>
In-Reply-To: <Zlb_txl4CqCfxWZz@pluto>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 May 2024 13:36:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUyW_RxfUaxnyWVzPsdXQWqCQbgZ+avHskinXkrSFqhtw@mail.gmail.com>
Message-ID: <CAMuHMdUyW_RxfUaxnyWVzPsdXQWqCQbgZ+avHskinXkrSFqhtw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: ARM_MHU_V3 should depend on ARM64
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cristian,

On Wed, May 29, 2024 at 12:13=E2=80=AFPM Cristian Marussi
<cristian.marussi@arm.com> wrote:
> On Wed, May 29, 2024 at 09:30:45AM +0200, Geert Uytterhoeven wrote:
> > The ARM MHUv3 controller is only present on ARM64 SoCs.  Hence add a
> > dependency on ARM64, to prevent asking the user about this driver when
> > configuring a kernel for a different architecture than ARM64.
>
> the ARM64 dependency was dropped on purpose after a few iterations of
> this series since, despite this being an ARM IP, it has really no technic=
al
> dependency on ARM arch, not even the usual one on ARM AMBA bus, being thi=
s a
> platform driver, so it seemed an uneeded artificial restriction to impose=
..
> ...having said that, surely my live testing were performed only on arm64 =
models
> as of now.

For that, we have COMPILE_TEST=3Dy.

> So, I am not saying that I am against this proposed fix but what is the
> issue that is trying to solve, have you seen any compilation error ? or
> is it just to avoid the user-prompting ?

I did not see a compile error (I didn't enable it on any non-ARM
platform).

But it is rather futile to ask the user about (thousands of) drivers
for hardware that cannot possibly be present on the system he is
configuring a kernel for.

> > --- a/drivers/mailbox/Kconfig
> > +++ b/drivers/mailbox/Kconfig
> > @@ -25,6 +25,7 @@ config ARM_MHU_V2
> >
> >  config ARM_MHU_V3
> >       tristate "ARM MHUv3 Mailbox"
> > +     depends on ARM64 || COMPILE_TEST
> >       depends on HAS_IOMEM || COMPILE_TEST
> >       depends on OF
> >       help

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

