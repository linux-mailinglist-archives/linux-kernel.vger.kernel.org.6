Return-Path: <linux-kernel+bounces-391409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB709B8645
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE541F2264C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BF81D0F66;
	Thu, 31 Oct 2024 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nynm8vLk"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A745A1991AB
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414945; cv=none; b=EfQqRKmiw0BPTn1S7iCRds1PjjVIPnfasNOnJdE+1nJ8TCwdrG8vfBhRmoW+ljM5YporaIm9YwHv1GvDfL02LHZ8sD7gfSsBtrIKjzrVlgXV5ANWexISG3mDE0vGOLhdPHZXNEME+FPeG6u6RA96xtZ4FEzlcTEvfGPQSy71c1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414945; c=relaxed/simple;
	bh=YMlzBx+z9aaRa2t9CsTC7J8zOTayJPPNSKPZfiTQhdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9IKR1gS+U/ATGR0qzGfkfydsoUmX+Gc6ix7rFBtxisCNruHyURGcCUe7BP2XpJKi9o3MKHF905UFB+FZijHxZXsIFEf2HQ8IKsd2oq9FRJJFVfJtk6RfvJt4Bloc/dPXqfj8OfSg9AWLEKZEpA2IuRH/Q52DR3hRb04FF+nTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nynm8vLk; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e2e41bd08bso15660847b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730414937; x=1731019737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6qFeMz2fz5TUQHmgzOfA0YHFIKSZWtlwhdHVsEY4Ls=;
        b=nynm8vLkXC4r9VS7uMggot5UJaUMw+R0ysBxOSXqB54O/cY+FeTDHACztW6yuYxgqd
         iFGDI7hIeZvzT6qE53U5jBLeedQPeeEGwMR+I3Qn0I7DMLhf6yId3FzYX71pcTIy/+v9
         wOuPFnlt7T93W2rZg/If55NLfeDAKbb3BAufc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414937; x=1731019737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6qFeMz2fz5TUQHmgzOfA0YHFIKSZWtlwhdHVsEY4Ls=;
        b=ibdO1AOiyNl0hkawgUKnhSdjItILx36Ty5Jn8OjBixkKOSJV/s0Xc0ZOFoHqidsam2
         Rgf9nWM8yWzJE1wMSG9UyOslZoYm12Up6skR53rER1YFS4Kl+Fh/8OZsFCs6iNEw9Zub
         zYHj+6ixdUn3tR78sDvCUV76y0uIkXK6pysi5gdwU8bVjhT8TA7OIjAKblCIiBzOHilQ
         57e2yxSgSXb4pD326cDTko0XltRoD4ozraZSuKpK+0PCSdXAfh/TbxcW/QZGC/lcbyEk
         0PE6nnBQy6BxPg2pCXSKWnuTFGdq+OsXlkVhV/mlZft7us3Q3qDPUCjHj4net8VQyeJa
         xNwg==
X-Forwarded-Encrypted: i=1; AJvYcCXrAhCeLL4B48TChIiUdpqjINXLDrZrmhn4PnbPTuTJF0b/hlq7Ew0Dx0HlLu05ajp2hqG4do20cGDJY1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTQBCXjb75tS0324o5kw17Igj/XU9B91VCEunSsDkL++TKdjzQ
	ahzQIt3Qnzxb6EqObm580v1P8oiI+uyzMHU3+pg3dC9T6QTSXIqREmAeyDbeR9xZfw99p2JMVTb
	XRKHE2wlluFFSbfxVSqUmP3cXJyUvfNe4IaKB
X-Google-Smtp-Source: AGHT+IEeT+MuyLEbw9zpD7r5OibCxa+4DfQKki/EuwTyOa3LAohYFUTmEiVK47uXYyOB48zQ65odB1tWbGP1fgXoPyY=
X-Received: by 2002:a05:690c:883:b0:6e5:e714:3bdf with SMTP id
 00721157ae682-6ea64a9f501mr20113947b3.5.1730414937682; Thu, 31 Oct 2024
 15:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
 <20241030142833.v2.3.I439cffc7bf76d94f5850eb85980f1197c4f9154c@changeid> <ZyOVIKGlrlj7kc9-@kuha.fi.intel.com>
In-Reply-To: <ZyOVIKGlrlj7kc9-@kuha.fi.intel.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Thu, 31 Oct 2024 15:48:45 -0700
Message-ID: <CANFp7mX-DkyFqwoaq_4V1XEDBqK7bj6-nz2aJi7idM=Q2TT49w@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] usb: typec: Auto enter control for alternate modes
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: tzungbi@kernel.org, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, dmitry.baryshkov@linaro.org, 
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 7:33=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Oct 30, 2024 at 02:28:34PM -0700, Abhishek Pandit-Subedi wrote:
> > Add controls for whether an alternate mode is automatically entered whe=
n
> > a partner connects. The auto_enter control is only available on ports
> > and applies immediately after a partner connects. The default behavior
> > is to enable auto enter and drivers must explicitly disable it.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  Documentation/ABI/testing/sysfs-bus-typec |  9 +++++++
> >  drivers/usb/typec/altmodes/displayport.c  |  6 +++--
> >  drivers/usb/typec/altmodes/thunderbolt.c  |  3 ++-
> >  drivers/usb/typec/class.c                 | 31 +++++++++++++++++++++++
> >  include/linux/usb/typec.h                 |  2 ++
> >  include/linux/usb/typec_altmode.h         |  2 ++
> >  6 files changed, 50 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-typec b/Documentation/=
ABI/testing/sysfs-bus-typec
> > index 205d9c91e2e1..f09d05727b82 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-typec
> > +++ b/Documentation/ABI/testing/sysfs-bus-typec
> > @@ -12,6 +12,15 @@ Description:
> >
> >               Valid values are boolean.
> >
> > +What:                /sys/bus/typec/devices/.../auto_enter
> > +Date:                September 2024
> > +Contact:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > +Description:
> > +             Controls whether a mode will be automatically entered whe=
n a partner is
> > +             connected.
> > +
> > +             This field is only valid and displayed on a port. Valid v=
alues are boolean.
>
> So, why can't this be controlled with the "active" property of the
> port altmode instead? That's why it's there.
>
> Sorry if I missed something in v1 related to this question.

There was a bit of discussion around this in another patch in v1:
https://patchwork.kernel.org/project/chrome-platform/patch/20240925092505.8=
.Ic14738918e3d026fa2d85e95fb68f8e07a0828d0@changeid/
And this patch is probably a good place to continue that discussion.

With the way altmodes drivers currently work, they will auto-enter
when probed. So if you have a partner that supports both displayport
and thunderbolt, they will both attempt to auto-enter on probe. I
think I could use the `active` field instead so that the port altmode
blocks entry until userspace enables it -- this would avoid the need
to add one more sysfs ABI. I'll actually go ahead and do this for the
next patch series I send up.

However, the underlying problem I'm trying to solve still exists: how
do you choose a specific altmode to enter if there are multiple to
choose from? I tried to implement a method that first tries USB4 and
then Thunderbolt and then DP but I realized that the altmode drivers
don't necessarily bind immediately after a partner altmode is
registered so I can't just call `activate` (since no ops are attached
to the partner altmode yet). Do you have any thoughts about how to
handle multiple modes as well as how to handle fallback mode entry
(i.e. thunderbolt fails so you try DPAM next)?

>
> thanks,
>
> --
> heikki

