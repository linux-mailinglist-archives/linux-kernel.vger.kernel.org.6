Return-Path: <linux-kernel+bounces-561389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 508CAA610C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD241B60594
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F971FE45A;
	Fri, 14 Mar 2025 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X2UdcpvU"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138E11C84DB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954786; cv=none; b=LM+bTnhMynommF1/rTKtsZkwCNLGc2Vcsw0rdMICADLYHcthJSk9jVAgXAZ9Bst05r3+xsLIRC0WeOQ+Rz36iWD5gORYQlPqiYzuOr1WSviJ2SMPVbX31cSmQ0g2svwq5mPq2X3xqfv6oggT45SarBoEfa2TCMyNc2xZWKSud7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954786; c=relaxed/simple;
	bh=h1hX18KbVpNPmbTOpsFY+DB6uWmqCs+Nff2SCawByGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8FvKMym+EI2F/yoHFsJU3FZcR1Bg2gL3n+vdsGFCPQ622PZVzVfVKcIFR6y5sINF6z3q8c7wiULamSYTRuuBpsJQLnsmC6fhlPxoIrMzo4Pb3jWBQQ1JGQq3QDZMz2S5erQrwTMmRVrzprJkgYWg1EDB5WMfDdvfiB2WjbQnwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X2UdcpvU; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-549b159c84cso2023923e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741954783; x=1742559583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1hX18KbVpNPmbTOpsFY+DB6uWmqCs+Nff2SCawByGA=;
        b=X2UdcpvU3tV+9KaBi/l+Xt4/hB7/3u90EX2V1sZjxNzJo46WvoTVhVm0pkA3iXKOeZ
         EJQwHI12qMcTo0/ifdWr/BigsPyfn8OMRCuURggV2lRX4hXHk5vMv70f74wO9Lle29u9
         dD9od1484UZZI6edRDDFjeAK40rVjbpaO1+WpOemRMa9+G0cxF84FVx0ZWJeXi+JPx+k
         tu4IJJ6nuiwxJ5b/u3cj5nNsIyRtBPvny2DIzUoMtBenBMBtF8WBNY1Ak3CXta/32Lo+
         MmX6KaIGpR+kdOrbtKeTWTap/7BHlT0TrEZFxhz5aJgNhFSb7PKgD+0sZHKNn5e0vePB
         CC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741954783; x=1742559583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1hX18KbVpNPmbTOpsFY+DB6uWmqCs+Nff2SCawByGA=;
        b=sMuJCGhIL78KVg+mMir+0rmv9azNbah745bwqY68bu6D9GVXi2OGNxgG0Eeb+IRMW+
         7fFfqp+rOvGXUL0iXeudPAoOJ/hOxXLJ3TReECgKa1RGMmAv//oK/EGOvaZ/+MJgf8/B
         kFJ1u2j1mK1MuYXEu8ZQRNhEAySDHxt1Em2ENCGWV1Ho7XYiMnaOThbwPEieJ0Da6HyF
         BaJ2kUlxY4x7eZFwGSCZzwclwvbdNk5wWEUy8aljZFIEQKaM4VzbPy61JYRrQMhwP5rJ
         zWkxIrQkp2TKk+22sURbtpB9woOl+Zl501k3sD5nrp5aL+W5bLPHuy4HKzb9baG4fhZG
         rf4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWksCZaCmu4yNHYxAAldC1SBwj+dzU1KVlKyQMU7EF0QWnzHgVmQbqQ1uLP8kJ8F2VhFXLHlcZ2Q1Mzxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGI82SQtYbSWipERruut+m1kfvN4SkRGs//QXh1BqNuc591zY+
	ARSxkTfjqQjY6Wbi+5L78ZvS4+SbxyZCcXzljSwdMZTs8gAt7kPBj7Vs9aW2NhXyQX0zXbFN55s
	ZDbSy0DmhiQePwY9y6SPENR4hGT713cXNqTVOEuaFABkks38Y
X-Gm-Gg: ASbGncuMPTVa6qRjRAstBkULQYaDJYFUHlZPLjaEhQLJZMs9Us6BYa0uGB4qK7mArqM
	YxT0tPrwvdhAXd3YgYFCUrgb/bpR57mHdRa+bxyxACPb4beaBufolSPcf290+yTMKMHtOdZs64Y
	TFogZH7mNH8eM70KhHwbSVC9pCPoCea5u7Enh5QiKI+eQFIoPtdBkpgRFoTA==
X-Google-Smtp-Source: AGHT+IHUlazwgUqlZgFfrZNU11dRALAC2f4jB8FB+3YipRbXUqsYKKBJIph8mnoYZoKAXAmHTbx2wTkl6nphw9smOAw=
X-Received: by 2002:a05:6512:2387:b0:549:4e7b:dcf7 with SMTP id
 2adb3069b0e04-549c38f5976mr919503e87.3.1741954783089; Fri, 14 Mar 2025
 05:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9ded85ef-46f1-4682-aabd-531401b511e5@molgen.mpg.de>
 <CAMRc=McJpGMgaUDM2fHZUD7YMi2PBMcWhDWN8dU0MAr911BvXw@mail.gmail.com>
 <36cace3b-7419-409d-95a9-e7c45d335bef@molgen.mpg.de> <CAMRc=Mf-ObnFzau9OO1RvsdJ-pj4Tq2BSjVvCXkHgkK2t5DECQ@mail.gmail.com>
 <a8c9b81c-bc0d-4ed5-845e-ecbf5e341064@molgen.mpg.de> <CAMRc=MdNnJZBd=eCa5ggATmqH4EwsGW3K6OgcF=oQrkEj_5S_g@mail.gmail.com>
 <CACRpkdZbu=ii_Aq1rdNN_z+T0SBRpLEm-aoc-QnWW9OnA83+Vw@mail.gmail.com>
 <Z78ZK8Sh0cOhMEsH@black.fi.intel.com> <Z78bUPN7kdSnbIjW@black.fi.intel.com>
 <CACMJSevxA8pC2NTQq3jcKCog+o02Y07gVgQydo19YjC9+5Gs6Q@mail.gmail.com>
 <Z78jjr8LMa165CZP@smile.fi.intel.com> <dd9d62d5-54fc-4e7e-8508-1b8e22ac28d5@molgen.mpg.de>
In-Reply-To: <dd9d62d5-54fc-4e7e-8508-1b8e22ac28d5@molgen.mpg.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 14 Mar 2025 13:19:32 +0100
X-Gm-Features: AQ5f1Jpc8BQLbO5f_ziXu7q9Ni5SWD-3N0tS5a8gYVuR7dGbfwA8ldlQAZqteb0
Message-ID: <CAMRc=Mez_3F0NifXLb18_XNH+-Q7D47HVOrYNt37EWsO9z0zgg@mail.gmail.com>
Subject: Re: Linux logs new warning `gpio gpiochip0: gpiochip_add_data_with_key:
 get_direction failed: -22`
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-pci@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 12:54=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
> >>>
> >>> Brief looking at the error descriptions and the practical use the bes=
t (and
> >>> unique enough) choice may be EBADSLT.
> >>
> >> In any case, I proposed to revert to the previous behavior in
> >> gpiochip_add_data() in my follow-up series so the issue should soon go
> >> away.
> >
> > Yes, I noted. The above is a material to discuss. We can make that sema=
ntics
> > documented and strict and then one may filter out those errors if/when
> > required.
>
> I am still seeing this with 6.14.0-rc6-00022-gb7f94fcf5546. Do you know,
> if the reverts are going to be in the final 6.14 release?
>

linux-next should probably be a better point of reference. I'm about
to send out my PR to Linus so it'll be in 6.14-rc7 alright.

Bartosz

