Return-Path: <linux-kernel+bounces-224501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AC1912330
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7048DB22477
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1715C172BDE;
	Fri, 21 Jun 2024 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSOTpQYU"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC79D172BC4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968754; cv=none; b=cbly220dAVuPZtGti+ujiiBlpjAUQXqQLAfweLv0fr8DfjPEvFxf9N74Kx9hs3V1qoPyrRIXzjQLnnNk+SIgEdMGE+O/qb/b9kzZk7xssioo2KGJiZfxMPJQgbf7iK/HNrLUAupjVEZbASNUYIKgIxRb86MnCto304gkF2FXu+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968754; c=relaxed/simple;
	bh=7gLON6gE5ukm4T1vEB+8LAyywMsTXIacWeG7y5AX+B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCOugTzkd7r5LWX7nU8gNRvEAjuVPMDvppESfXI0lOTNHimjgeUvy4KKftIOq1v0X4RzPXFBUYH+zO9kXGVBtsVmEWnPLv9Iz1aWCa9YvBsEboI4YmmCHsU3hq2wb3H8zMzmGR1h38TLKUpp5HK7hYcVELz4QVAe/PLJwpcMAcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NSOTpQYU; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dff36345041so1932979276.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718968752; x=1719573552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H5QZgZfdaJY5tt1Kp5T6W2RdnqNcsMEWI2ebReKb6vI=;
        b=NSOTpQYU12atcre7K5tTu2JEl/J34eLKmfZYLyMSALh2RIYaCwD5J55pLqUqt1xuZQ
         Y+bzJZIVJSdUrfSspXdUdkLmu12tPzp6W/iqvjv4x3yhTGawHd6l/oiH186rtJl303u8
         6D1U3TaaU1rY5Sk9HDtwWE8ttpfXgLDflzWo4eizdi6Y8k2IMNEh0fbmIRBjAkSthv7Q
         +wq4YoYT2hy8Xr+tU+1jcBB2n3Ybp+DtEPWkhzgDS+Iu3ccfKDh7J/eMHFqo2mbU3AP4
         S+SA/bC9ScxHxQCA805vYPvHb1i/WGJSfEQZsyN3JVx4EAvTlHAkvXhWrRQvXGBkJ5uZ
         E7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718968752; x=1719573552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5QZgZfdaJY5tt1Kp5T6W2RdnqNcsMEWI2ebReKb6vI=;
        b=b/PLMoeOm57rd5TWZeMyUQjP8FDK6P0cJIKosrcQoy2lIL0lxvxflgmkfS0QbXN2GG
         K/JrzZrMq23Q/3+6Iek7mTwPHk9urpA0Lx9gJxBJwr8DEGVTNf25Dpskb571DQ108WIr
         eMGnItC7lDEdD8uDlIrWk028/THZbKauDW3ZU8zo55qD6tyKE9ghClt9rETR9sTx7o80
         M9mKxk7yTG9jAjSxL8d3ncWut245rZgYnNg9jErZAK1YCwkQpqsg0RnlbZkUNI0j4EGw
         6/0LIuqy2VEmy5k04Fvh1YnAMO1TinuWd5G3PMbAd4IM+Z7FDP2i53/wEcbsI/lYXVeR
         IPRw==
X-Forwarded-Encrypted: i=1; AJvYcCXKab/9gym+dP7qx1MD8vv/PJBlbsvB4/UPQkLL+6i7Gxq8ClIf5UtJ1Ft744bAPzYp4M5TecGRd1IaSnlWXo+tCxTA1w41EOGv9auU
X-Gm-Message-State: AOJu0YzYVMsBK54lq8TXgGvfX7kPNh3CqjHQrplPOAmI4yGOSZY2IrLg
	0Hp9VZCX7X+FYrk8GM58vvMwfJsBXUuG4Ila+Uuyhpk9O5a8e+X2iEbOn/vpBWUTrf+MuvneCKP
	wnlqKdyfzzKcf/hQV2GtYJWztzpIjLBaFRTbFBQ==
X-Google-Smtp-Source: AGHT+IHNvgD/CLuCJPDEmrMqR6vErGZ956Gg+9FC6uT2K+FAj7cCLW+UCZ1u3hp0iVip8LrBW4sNqfFVjLQjBsohjHE=
X-Received: by 2002:a25:dbd1:0:b0:dff:4a3:2ded with SMTP id
 3f1490d57ef6-e02be13f445mr8358289276.22.1718968751833; Fri, 21 Jun 2024
 04:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612064731.25651-1-quic_ekangupt@quicinc.com>
 <zbpia232dh4ojfsvhcqxrp6cwfygaalu5cycdrs47pqmnrisvk@dq24nww26gkm> <z6g5ool5vomkudiroyaxh532rhlfu5x4i3l5xoqrsho2sxv4im@v5ghemjkpc3v>
In-Reply-To: <z6g5ool5vomkudiroyaxh532rhlfu5x4i3l5xoqrsho2sxv4im@v5ghemjkpc3v>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Jun 2024 14:19:03 +0300
Message-ID: <CAA8EJprgCJKOnZo7Q31KZV3SA3NqWxcMmoUxuqnVF+8cQW5ucg@mail.gmail.com>
Subject: Re: [PATCH v1] misc: fastrpc: Move fastrpc driver to misc/fastrpc/
To: Bjorn Andersson <andersson@kernel.org>
Cc: Ekansh Gupta <quic_ekangupt@quicinc.com>, Oded Gabbay <ogabbay@kernel.org>, 
	srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, 
	linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 09:19, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Wed, Jun 12, 2024 at 09:28:39PM GMT, Dmitry Baryshkov wrote:
> > On Wed, Jun 12, 2024 at 12:17:28PM +0530, Ekansh Gupta wrote:
> > > Move fastrpc.c from misc/ to misc/fastrpc/. New C files are planned
> > > to be added for PD notifications and other missing features. Adding
> > > and maintaining new files from within fastrpc directory would be easy.
> > >
> > > Example of feature that is being planned to be introduced in a new C
> > > file:
> > > https://lore.kernel.org/all/20240606165939.12950-6-quic_ekangupt@quicinc.com/
> > >
> > > Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> > > ---
> > >  MAINTAINERS                          |  2 +-
> > >  drivers/misc/Kconfig                 | 13 +------------
> > >  drivers/misc/Makefile                |  2 +-
> > >  drivers/misc/fastrpc/Kconfig         | 16 ++++++++++++++++
> > >  drivers/misc/fastrpc/Makefile        |  2 ++
> > >  drivers/misc/{ => fastrpc}/fastrpc.c |  0
> > >  6 files changed, 21 insertions(+), 14 deletions(-)
> > >  create mode 100644 drivers/misc/fastrpc/Kconfig
> > >  create mode 100644 drivers/misc/fastrpc/Makefile
> > >  rename drivers/misc/{ => fastrpc}/fastrpc.c (100%)
> >
> > Please consider whether it makes sense to move to drivers/accel instead
> > (and possibly writing a better Kconfig entry, specifying that the driver
> > is to be used to offload execution to the DSP).
> >
>
> Wouldn't this come with the expectation of following the ABIs of
> drivers/accel and thereby breaking userspace?

As I wrote earlier, that depends on the accel/ maintainers decision,
whether it's acceptable to have non-DRM_ACCEL code underneath.
But at least I'd try doing that on the grounds of keeping the code at
the proper place in the drivers/ tree, raising awareness of the
FastRPC, etc.
For example current fastrpc driver bypasses dri-devel reviews, while
if I remember correctly, at some point it was suggested that all
dma-buf-handling drivers should also notify the dri-devel ML.

Also having the driver under drivers/accels makes it possible and
logical to  implement DRM_ACCEL uAPI at some point. In the ideal world
we should be able to declare existing FastRPC uAPI as legacy /
deprecated / backwards compatibility only and migrate to the
recommended uAPI approach, which is DRM_ACCEL.

-- 
With best wishes
Dmitry

