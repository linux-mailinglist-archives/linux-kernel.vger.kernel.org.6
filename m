Return-Path: <linux-kernel+bounces-342019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6060E9889B5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C32B23535
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6696B1C1758;
	Fri, 27 Sep 2024 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTzRxJR6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E0513A3F2;
	Fri, 27 Sep 2024 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727458616; cv=none; b=bW08PIhzG98nM0q4FlME+s6/O5pqINzgn/GNqjlxGrs+owOW6m5gsrR5AB/WXeNc3HGxGhB9k5S0xSpaOAMGqT4uqH2FtLkh2O9oXKfgTb97WunZtZ99mGTX0ym8WRoMr98yNd5NJwIE/CoZiX70WtlU9ghWC4eHkXJuElEiovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727458616; c=relaxed/simple;
	bh=4AV1qyaZqQGzNswF3ZfC0nI8svQB0aLi7ePsr9U2//M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhCgjzmVOPfFegZShLvyUa5qu9/BoEdFJ98hm6zFrvOWoDcOEkR2iwiLyluOqhHD9V7HOnkYMacduSpVcm/FamaBPDiM9k44fy86c08tyvDdw+7+BSk6lkgyVuswHCFLBsy4OU9/EnI6/YwJifeTTg5JVTkfxogRtA8gYzZpwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTzRxJR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BEEC4CECE;
	Fri, 27 Sep 2024 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727458616;
	bh=4AV1qyaZqQGzNswF3ZfC0nI8svQB0aLi7ePsr9U2//M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TTzRxJR6PpAvBGNJ/FRI0cdtrO+z380eLJ27Q0B4q0I8tmj0XIcmxnuGlW8eFlFiL
	 6PCxs2gMg7WKDzAoCEgfdrN0b/kQnMVh+mY7BZ8/xiE7S2g/ZsQGc2RB4Wps+nFLr8
	 v4zDCmvlxTLjahVDXyTcEsbfVUS6I2eVQIDgaelT3fOqWnUzKhPiosMfraqkUL8hRc
	 QPOvDOn9lJCIsxl4c94VexHM0/yxL2fVPdfvPhW1ia2HSV5JVYsM2k3/Mdz//WWt5K
	 AHwg/yQV1HBSC5SVqph0GWP728KxDAEBrkH5tUDPizXdMkmkrpcmqqrL7Vlx0I1V7i
	 4AhEdwbDWjtqQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365aa568ceso3013834e87.0;
        Fri, 27 Sep 2024 10:36:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLXTMj9jn9plGJ0ofPfthx465PnyBvB9atIemL4oXBzJfTeX46UbgOIGWmzpfWidwSGZIiSbG3t4oc@vger.kernel.org, AJvYcCXZ5OTiNNKPbpNJ3QgXnjqgzKamzOL/2OAmiuOTZputtzRBvBMDDe5YPwJ68jpxPfU9iN1gsWVkLHq71ogM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx176yV/nWiQ0CNF9h+lLxEP4e2Jeil6h0lVBV+6HKNEp+d89Z4
	xBUxSr5kJiW1uaebJR26vpwadYuIzgpA22uScykVw4xdzRtUBJM0JzVgvNg/4osGJoUwxhELnNh
	PIi/GEC6KA1UOQfAqyZvQPpjuTw==
X-Google-Smtp-Source: AGHT+IEkT0Cr4HV3qKw4LoLuVsCrCw4Ghn2KGPHuNWdPKaIEM8Vj/4gh7caa8Sp19fPf1sdu1BpsOtMed2CuFeBJd+w=
X-Received: by 2002:a05:6512:eaa:b0:535:6a34:b8c3 with SMTP id
 2adb3069b0e04-5389fc34366mr4395103e87.5.1727458614368; Fri, 27 Sep 2024
 10:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <2024091327-repacking-avatar-ec23@gregkh> <ZulGr8Ul7y0T0NkQ@NAB-HP-ProDesk-600sony.com>
 <26fed82b-7c60-4fda-8951-b22654728743@kernel.org> <2024091747-monorail-unbutton-7ebd@gregkh>
 <ZvVAiVBlBjkMhHMY@NAB-HP-ProDesk-600sony.com> <43447165-37f9-4b35-ace6-8d32760f75a8@kernel.org>
 <ZvbP2e8nZzjXKfVK@NAB-HP-ProDesk-600sony.com>
In-Reply-To: <ZvbP2e8nZzjXKfVK@NAB-HP-ProDesk-600sony.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 27 Sep 2024 12:36:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKLT_H5jMnZYrpaZ246YmDtZHg7eQ6PJVp7sykVi3SG0A@mail.gmail.com>
Message-ID: <CAL_JsqKLT_H5jMnZYrpaZ246YmDtZHg7eQ6PJVp7sykVi3SG0A@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add framework for user controlled driver probes
To: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rafael@kernel.org, yoshihiro.toyama@sony.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 10:04=E2=80=AFAM Nayeemahmed Badebade
<nayeemahmed.badebade@sony.com> wrote:
>
> On Thu, Sep 26, 2024 at 02:34:26PM +0200, Krzysztof Kozlowski wrote:
> > On 26/09/2024 13:07, Nayeemahmed Badebade wrote:
> > >>
> > >>>> not required at the time of booting.
> > >>>> Example: drivers/pci/controller/dwc/pci-imx6.c
> > >>
> > >> Just this one?  I don't see anything obvious that can't turn that in=
to a
> > >> module, have you tried?  What went wrong?
> > >>
> > >
> > > Yes we have tried building it as a module.
> > > This driver currently registers abort handler for pci using function
> > > hook_fault_code() on arm. This function is not exported and marked wi=
th __init
> > > tag. So we can't use it post boot.
> >
> > Then this is something to fix.
> >
> Thank you for the suggestion.
> As per discussion in below link, its mentioned that hooks should be stati=
c and
> should not change during runtime due to locking support not being there.
> So its not safe to export this function to use in modules as per the comm=
ents
> there.
> We would appreciate any suggestions you might have on any possible
> alternatives.
> > > Also from past attempt made to modularize this driver in community, w=
e saw the
> > > hook is not safe to be used post boot.
> > > Reference:
> > >  https://lore.kernel.org/linux-arm-kernel/1454889644-27830-2-git-send=
-email-paul.gortmaker@windriver.com/T/#m8995c6dcc40c54baef0665a7ee16d4209cb=
59655

The hook implementations have no interaction with the drivers other
than being installed by the driver. So move them out of the drivers
and the handler can be built-in with the driver as a module. For
example, see arch/arm/mach-bcm/bcm_5301x.c. Could possibly combine
some implementations. I haven't figured out why imx6 checks 2
different instructions while keystone only handles one. But imx6's
implementation being a superset should work for keystone perhaps.

Rob

