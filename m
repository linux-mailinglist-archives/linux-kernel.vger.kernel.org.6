Return-Path: <linux-kernel+bounces-225250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49609912E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A171C222D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3418417B4F1;
	Fri, 21 Jun 2024 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnqAdrUR"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECBF12B169
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718999321; cv=none; b=l7jSp2q+7WdHx/7tO9Dfow0A3mUwB+FJANgL8F2XfC6H8CQvBcU5YqNS2Lomy4lw68gXsckMFJxzODBsA1Uf3ruGZlddxxPOnnSkCgWIBLmYAwGUTiV00hmWUUKXlFPIQCe8K8eSFmMIbz0fXF1zDPIyWQpjoHA1yhHOIw5oJok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718999321; c=relaxed/simple;
	bh=8LS+B4TJzrSUFzU9GSEIAKTPmujsOf5ACBaxrf9HeIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoZSYAhqsJRPNRK/WVxG7XnOtb78BtiQ2mp59MBS7h5wFBP6wpw1Cl+CSsDg147UQqdTjGK6MoThgWn5mgMvIbWevzlYNEJEfkZXWWNOUezmVdcfO/V4e3LAyhqMqTlipinFdkthkuvCfYZKL7AJQBvGifQggPpkndT+TBPM7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LnqAdrUR; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62a2424ecb8so27328697b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718999319; x=1719604119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/c8cghJ6uMh9jC1Qg2cHE9CahIR6DPBACZ2TcXW56A=;
        b=LnqAdrURw6j4VZyaBnjJ4VdP/yDHiUaz00gAMNzTXumIJdG3ACz0T724vIo2asi9Dc
         BpYITd+TSU2fWLcX4T4O/VEyEFI08KPFgGMMWLavE0+zO7RKEAOarFOxyuEMo56aT1Jh
         J+iT3zBpCGVaIYclmyQPhYcXWO1M1wYbq376iSfpVknVYgnQQBEjt9xEse0kCwccqCgm
         3huGY/wkL6Va2UfRBXXN6XZu27K2zrw9rwLOEFtrF26itwUoI/Qba11FT0ZScFoBQdPA
         ew9qE7vrNtx2QoUHiVDA7ppBMZZEIXr6odFf4FkUGMJ8Tvt69CtCUHB6FGAU6ZPGU79z
         lFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718999319; x=1719604119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/c8cghJ6uMh9jC1Qg2cHE9CahIR6DPBACZ2TcXW56A=;
        b=R0Qzr4rv2sCHAsXV/Cb3nHZjFefHwy1NUI24v/agZ6z3fCF/V48txW58BCShJo/uJZ
         UH2FDY82bfcf00gPEpCkofDzTqj6Q1Y0baEFvNjyPzlKFPzDA6vX3IHlNEDBbtp43fke
         3kQXGhbS/BdsWovO2jacEv8sHOvi6+6idn6xbS/LRaKmgPERLAKw4jeOD3PT0rnCMn+b
         tPDS9yCIvWk4U3gOSAaDFTvVfXxVuPMoIGdK281K9C55fjoVUlvAW3M1Fr9LK4YXINc1
         ZJ8RnZZFZrU6OvhTDRUKT4u7oItLAm8LLQcAUeIG8M20LpuzmWbTp22iaOWxzwg2OfnZ
         aKKA==
X-Forwarded-Encrypted: i=1; AJvYcCVhZ8FJQ+l/egBGzB4c8OysygT7qGNovOLlElpXIyog38sLQ6FmtTRbw6ZqgkVSDRop63bPpmtG9W7btsU7lBxPvMb9a3HP8y+zMxW1
X-Gm-Message-State: AOJu0Yx67ruw50pz/ldVUgN0CagzL8eNYKGVFrFSc/aBYjoIwMikGHKW
	MMkgdwcam+Jcov59Ksy2ZyCwAhlMyqSmnmH2hkx/KC3+Nq31M8ycsM6Y0WUMYbwzRhvbK0pgYlw
	01wYcYUqzEt6p/YMF8s/D7NVSisnY1zEBtm2pWA==
X-Google-Smtp-Source: AGHT+IFvOw/kHfTfZo+OrqgAX4CDfPljUrETGvD6Moa3aTJuLqtsXuUSv/1M4m37lNwuXK/7MTl9DPjJyvK+nqkQaqI=
X-Received: by 2002:a0d:d48d:0:b0:622:c901:950b with SMTP id
 00721157ae682-63a8fddc9d9mr103318627b3.43.1718999318614; Fri, 21 Jun 2024
 12:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612064731.25651-1-quic_ekangupt@quicinc.com>
 <zbpia232dh4ojfsvhcqxrp6cwfygaalu5cycdrs47pqmnrisvk@dq24nww26gkm>
 <z6g5ool5vomkudiroyaxh532rhlfu5x4i3l5xoqrsho2sxv4im@v5ghemjkpc3v>
 <CAA8EJprgCJKOnZo7Q31KZV3SA3NqWxcMmoUxuqnVF+8cQW5ucg@mail.gmail.com>
 <6f59552d-d7a3-5e05-3465-e707c1b7eaf2@quicinc.com> <ZnWhwJtTXS32UI9H@phenom.ffwll.local>
In-Reply-To: <ZnWhwJtTXS32UI9H@phenom.ffwll.local>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Jun 2024 22:48:27 +0300
Message-ID: <CAA8EJppRP0HdM6AfmL0uga2esDey12LVjuSn=wJZtV4Uz0CgZg@mail.gmail.com>
Subject: Re: [PATCH v1] misc: fastrpc: Move fastrpc driver to misc/fastrpc/
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Ekansh Gupta <quic_ekangupt@quicinc.com>, 
	Oded Gabbay <ogabbay@kernel.org>, srinivas.kandagatla@linaro.org, 
	linux-arm-msm@vger.kernel.org, gregkh@linuxfoundation.org, 
	quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, 
	Dave Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 18:52, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Jun 21, 2024 at 09:40:09AM -0600, Jeffrey Hugo wrote:
> > On 6/21/2024 5:19 AM, Dmitry Baryshkov wrote:
> > > On Fri, 21 Jun 2024 at 09:19, Bjorn Andersson <andersson@kernel.org> wrote:
> > > >
> > > > On Wed, Jun 12, 2024 at 09:28:39PM GMT, Dmitry Baryshkov wrote:
> > > > > On Wed, Jun 12, 2024 at 12:17:28PM +0530, Ekansh Gupta wrote:
> > > > > > Move fastrpc.c from misc/ to misc/fastrpc/. New C files are planned
> > > > > > to be added for PD notifications and other missing features. Adding
> > > > > > and maintaining new files from within fastrpc directory would be easy.
> > > > > >
> > > > > > Example of feature that is being planned to be introduced in a new C
> > > > > > file:
> > > > > > https://lore.kernel.org/all/20240606165939.12950-6-quic_ekangupt@quicinc.com/
> > > > > >
> > > > > > Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> > > > > > ---
> > > > > >   MAINTAINERS                          |  2 +-
> > > > > >   drivers/misc/Kconfig                 | 13 +------------
> > > > > >   drivers/misc/Makefile                |  2 +-
> > > > > >   drivers/misc/fastrpc/Kconfig         | 16 ++++++++++++++++
> > > > > >   drivers/misc/fastrpc/Makefile        |  2 ++
> > > > > >   drivers/misc/{ => fastrpc}/fastrpc.c |  0
> > > > > >   6 files changed, 21 insertions(+), 14 deletions(-)
> > > > > >   create mode 100644 drivers/misc/fastrpc/Kconfig
> > > > > >   create mode 100644 drivers/misc/fastrpc/Makefile
> > > > > >   rename drivers/misc/{ => fastrpc}/fastrpc.c (100%)
> > > > >
> > > > > Please consider whether it makes sense to move to drivers/accel instead
> > > > > (and possibly writing a better Kconfig entry, specifying that the driver
> > > > > is to be used to offload execution to the DSP).
> > > > >
> > > >
> > > > Wouldn't this come with the expectation of following the ABIs of
> > > > drivers/accel and thereby breaking userspace?
> > >
> > > As I wrote earlier, that depends on the accel/ maintainers decision,
> > > whether it's acceptable to have non-DRM_ACCEL code underneath.
> > > But at least I'd try doing that on the grounds of keeping the code at
> > > the proper place in the drivers/ tree, raising awareness of the
> > > FastRPC, etc.
> > > For example current fastrpc driver bypasses dri-devel reviews, while
> > > if I remember correctly, at some point it was suggested that all
> > > dma-buf-handling drivers should also notify the dri-devel ML.
> > >
> > > Also having the driver under drivers/accels makes it possible and
> > > logical to  implement DRM_ACCEL uAPI at some point. In the ideal world
> > > we should be able to declare existing FastRPC uAPI as legacy /
> > > deprecated / backwards compatibility only and migrate to the
> > > recommended uAPI approach, which is DRM_ACCEL.
> > >
> >
> > I suspect Vetter/Airlie need to be involved in this.
> >
> > Its my understanding that accelerator drivers are able to reside in misc as
> > long as there is no use of dma-buf.  Use of dma-buf means they need to be in
> > drm/accel.
> >
> > There is precedent for moving a driver from misc to accel (HabanaLabs).
> >
> > Right now, I'm not aware that fastRPC meets the requirements for drm/accel.
> > There is an open source userspace driver, but I'm not aware of an open
> > source compiler.  From what I know of the architecture, it should be
> > possible to utilize upstream LLVM to produce one.
>
> Yeah so fastrpc is one of the reasons why I've added a dma_buf regex match
> to MAINTAINERS, and given this move has shown up here on dri-devel that
> seems to work.
>
> But also, it slipped through, can't break uapi, so I just pretend it's not
> really there :-)
>
> That aside, going forward it might make sense to look into drivers/accel,
> and also going forward new dma_buf uapi will be reviewed to fairly
> stringent standards. We're not going to impose the dri-devel userspace
> rules on everyone, each subsystem tends to know what's best in their
> ecosystem. But if something just ends up in misc so it can avoid the drm
> or accel rules (and I think media is also pretty much on the same page
> nowadays), then expect some serious heat ...

After discussing this on #dri-devel, I'm going to retract my
suggestion of moving the driver to drivers/accel/, unless there is an
actual interest in moving to drm_accel.h style of uAPI.

It should still be noted that there is a strong recommendation to
start from scratch and to use DRM / accel uAPI, either using the
existing driver for the legacy platforms or dropping it completely.
When the fastrpc driver was started by Qualcomm engineers, there was
no standard method of implementing the accel drivers. Since 1st of
November 2022 we have drm_accel.h.

-- 
With best wishes
Dmitry

