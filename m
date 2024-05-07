Return-Path: <linux-kernel+bounces-171952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B818BEB1D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF62D1F267F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C5216D30C;
	Tue,  7 May 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tb8jg9/2"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9B16C698
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105182; cv=none; b=p+nZKoLS0X4A6E04ElAfIjZf7nrbx3gBo12KlXzIPShKhMgph8VPQjYNjTqFMt5XZWsn8RMVl+1BV19dLsnSdYJutrkFykWrXAPz0fAyq2skWRpLMDCC5n3Oq5swpOK+/OHEkp27z0x2bpt481fv0Zx6ffNXzC9CY1XItxQM3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105182; c=relaxed/simple;
	bh=E2TuhU3e0c8V6Q+6qTHneY935SxAAlV/m20/4e0S8MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jy4QUluAA0sDuJH18gU6i/OPMCJE0qlTHlWEdMbjpaPcWmhUuvVvhv/6pg9OXv/s4mescJGQmB7JRQW5dxOf2dE2XEZBmhm64iKR+ENg63pNuoraQjP191FsV22BrsLexXhUqXh2MP98RXfe1lxm4Ab0NiMHpvTv3sfTT3dWbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tb8jg9/2; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4df1f44bf0cso1623e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715105180; x=1715709980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=spiwNIuQ3zIJqOpK/ff2kBzfi+usHGy3s6oJXm0A698=;
        b=Tb8jg9/2M79rSKdoqBye/yjKjMJ5+gp/BPHaTygwu7q2gwZXlfE6frNsgjFR2I2SWs
         CNSTZS5kXiXJw10iO1m7Ubw8R1Kx5wk0E6GdHkytEqU8c5BCh7v01nACv8LZMCWFV9SD
         2haoz3iHRQK6RbQbK10oPY6hITQoOXY6fSKW8AgN5brmZ9btJcqNUQ/cvvo04l2WKIJ9
         n0a5y4Bw/F+1D2J3k4gy3dYUXLZLm+r1N0eBQXlKWnU2KvPr+H8Vfs2dT3E7AhaRlD/V
         hKs1iwe/pDIPHz/m0OGWgL5IPHgPu3DohNsZkd/CAR3rUXnygF95jqLPlNs3ppa+6Txk
         LoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105180; x=1715709980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spiwNIuQ3zIJqOpK/ff2kBzfi+usHGy3s6oJXm0A698=;
        b=NAkyWlWRMXviRgjRxABs3IZ+NTSl614yJFhywcrhIJztCgWbgwaHycxI4IFovWKs4W
         xkesv5r1VbhGmTL4CnqiZ7Dki4mNLUzPPWAOhXytHKRBNhTbBYt/0WDKZX8DhdW2z8ar
         GQJauOPl7r/Pwk5a0L5qdW3FvzZpf8WtU09ScdAchTiYRF3mi7MeH25E027ALfEjmrGJ
         IBI7SP4HA9IDcbSEMysQ/fClDoUVovwUenU9LIioIR/nArk4IV7mSuZWy8RQjMWNvOSW
         1SYP/caC68U7jgidwiVjtWpYDhydNjBH7IbBBB9EogPLUrITG0x65MKfDKFxXXta7N8H
         Nn+w==
X-Forwarded-Encrypted: i=1; AJvYcCWEddj3QAKdItzSaA9ep7pxAIogIKNOHc6oz2hNB+VLo3nU0OT/+CYLu5iCEJOKCwjBW6Aiu5br+mHU0ORAI8XAVJR6wxbtSNXjert9
X-Gm-Message-State: AOJu0YxQBZPIVkX2whX2gcmy+ao9Lhq+pvYVeNLvY+JfAy7FZ2EXbYRZ
	Ob2L5efQlhU2mU9Dsez+WzK6B+4WksUJnKExUX38Nxzrp+3nLxOuxM/Ca1jl/m7H0bLc7Udte3l
	h4wTXfbox5x96DUxPlT/1MSPeeHjpEdcQfV/Juw==
X-Google-Smtp-Source: AGHT+IH/4l2qRfgjYe+x0/frCqmCjhdR/F2pbYL7AThqf2M3JY+DMMtoC/ObpM30/DFd92hLI/7RGHkJ5fejcdSoQNk=
X-Received: by 2002:a67:cd06:0:b0:47c:362f:4c47 with SMTP id
 ada2fe7eead31-47f2b9f7029mr3230226137.14.1715105178333; Tue, 07 May 2024
 11:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs1ZN2K=UHOjrwRR2JNE-M0nf9iW_Q-YPzVgmW+9daU4Q@mail.gmail.com>
 <CA+G9fYs1F=kO11-+DtAOsNwZGEd8mmojXEfXfg431JG=Spubcg@mail.gmail.com> <CAA8EJpoMwy2w3a9VF3ejGkcxFK905DCczZOdD4k-cd7ouKHYcA@mail.gmail.com>
In-Reply-To: <CAA8EJpoMwy2w3a9VF3ejGkcxFK905DCczZOdD4k-cd7ouKHYcA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 7 May 2024 23:36:06 +0530
Message-ID: <CA+G9fYuGLz76C9F=onq6u2hk9_YYHhyjT+bvwXmeN8U6bhejNQ@mail.gmail.com>
Subject: Re: arm64: defconfig: gcc-8: failed: AttributeError: module
 'argparse' has no attribute 'BooleanOptionalAction'
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, lkft-triage@lists.linaro.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 20:58, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 7 May 2024 at 16:13, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Tue, 7 May 2024 at 17:13, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > The arm and arm64 with gcc-8 builds failed on Linux next-20240507 tag
> > > with gcc-8 due to following warnings / errors.
> > >
> > > arm64 and arm:
> > >   defconfig - gcc-8 - failed
> >
> > Anders bisected this build problem and found the first bad commit:
> >
> > 07a2f8716c41 drm/msm/gen_header: allow skipping the validation
> >
> > Steps to reproduce:
> > -----
> > # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
> > --kconfig defconfig
>
> What is the python version on that platform / system?

# python --version
 Python 3.7.3

> --
> With best wishes
> Dmitry

- Naresh

