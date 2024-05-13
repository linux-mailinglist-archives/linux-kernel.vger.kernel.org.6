Return-Path: <linux-kernel+bounces-177487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C6F8C3F76
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025481C20FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC0514B076;
	Mon, 13 May 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJIFPuX9"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B585514BFAB
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715598446; cv=none; b=nqUNFrhWvuzHp+aRLJrsrLWbKsIW6kgiJBXN4VB+X6DJdVwdzldDL+f6bk8tMWK9Tu8frSgx5M5Zqoii3VUszRG76A4CCsQxPOfSwAshDd2J09oMwkPl+NsYnZxHLz+uVOwQYulTb3FvTuXSOL2oT0gGOVNfBuQLJ0y5B5t0rto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715598446; c=relaxed/simple;
	bh=yGixI+iHGX3TPfXml7qxn2htJP1ksYMKCpPrGRjCsgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqbrAb7TmuP6PqBJN3OZhoVRGhjfzgz3JSQfFQi4zkqmTBUPaIL+gg5vgv6bJ/WyZcKpZ0eauRZs+Lp0wA860VMOnKVMv27EKhGwbKRFElyEQ/aA+M4pGQ6oNKQzNvd9WvxSDCbD0iJu/xha4W0uPT0jc1pQftbNLXcB3teb960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJIFPuX9; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7e1e0939cbdso28362939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715598443; x=1716203243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGQJNn0vnDN7oHpQ2fYIvhBcLWv6XEpScm6BqxW6Gn4=;
        b=uJIFPuX9cC2kYiYBjXoyDCvDY5ovFnwkR8xHk8ZCZbyV907cCW6MgRDL3b1gMq4O81
         TYyeqt+kMHIWJrjrtOYr7NfgQcf7ICLTTY7bi2NCGcBsctVtgKNzxgtTHNAQHDzxu8kq
         azannFIZVjcwBThJ5xHlVKmTgwCUd8kaEHsv28IdAVSCpcnJeo6TUQ4cpe+RkgRGXnoR
         Y/zC7GdEZSdgb+khJHBStnoImadGDaclt5GXnQm7KLwEpf6q00LjJzeFjjrvdv7+DRnm
         f2RR18wFbCyi6cvTa94QrKfcaWrABul5PElHg8u6qcjoFcGn70AIkDuiXhCgMS3oqQb/
         mUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715598443; x=1716203243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGQJNn0vnDN7oHpQ2fYIvhBcLWv6XEpScm6BqxW6Gn4=;
        b=ikdCYVwNbjoz/19tq+7UrKnNIbyAUZoNFH6r6XUHCzwRriq58+Zkum2ljz2lgzoUch
         bfl8/5pRpYn5grRtebJJbhsT1vzpKObiMGn31sSoICpjYWIvVtS7/nfB54yNIaj63YSq
         AsM4ZMd0MjrzwqotDdV0pyJJ81jDyo/qazdmj5IXdefNRSa/yiQFgqP+iDAbT2cknHqw
         bMckksUHuA5h4KDLdDPWVldzs2C/zMaLPRT6wkzi129e+5ZuCUwjbCgivHNmHRwBFQE4
         5vAhyhBHY9L7FyqQWlo6szAX3PzuW0aye9bEOjycmldOAT2JWtwmLF/5BoTI7vL10WAk
         DWnA==
X-Forwarded-Encrypted: i=1; AJvYcCXJt9IrgdVtbR92dFtJ7IEEZc9yCVIZ3bUP5bh9akHcOqH1a5kVODZ5q2ClSZPE8G975k4reEa/+H4TqApF5Zfgh3noYBS/UMeJWhOA
X-Gm-Message-State: AOJu0YywPqBTfJv6Ty/+EUbH76Eoxg4r7dBMQXb+JkjSisqQxhXoxU1s
	e9thEAuC/gmA7TFvGmv/1OOqWGc4NEsOYB5FPNO4cfynYdgDiRWqeAUwm0uK7VZTMbrp9Z5oApZ
	Yfh8k/vQiP2Sj053uR1S6/FFtelK7FpgAzZck
X-Google-Smtp-Source: AGHT+IEiadjb+MTc+UlqC6N1rwvvjZDJnAlay8TfzRluxCwQz8iR/sX8wqL+TFk3/kNd86shQakjYT2DoztuTJ1C/LM=
X-Received: by 2002:a05:6602:2992:b0:7da:bc23:ac16 with SMTP id
 ca18e2360f4ac-7e1b520775bmr1054622539f.14.1715598442659; Mon, 13 May 2024
 04:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507155413.266057-1-panikiel@google.com> <20240507155413.266057-6-panikiel@google.com>
 <20240510211613.GA751688-robh@kernel.org>
In-Reply-To: <20240510211613.GA751688-robh@kernel.org>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Date: Mon, 13 May 2024 13:07:10 +0200
Message-ID: <CAM5zL5oBA6Bkk=qAEjx7pvQ5cxa9MFHe9=T3AQMuKskzbjFrzw@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] media: dt-bindings: video-interfaces: Support
 DisplayPort MST
To: Rob Herring <robh@kernel.org>
Cc: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, tzimmermann@suse.de, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 11:16=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Tue, May 07, 2024 at 03:54:08PM +0000, Pawe=C5=82 Anikiel wrote:
> > Add a DisplayPort bus type and a multi-stream-support property
> > indicating whether the interface supports MST.
> >
> > Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
> > ---
> >  .../devicetree/bindings/media/video-interfaces.yaml        | 7 +++++++
> >  include/dt-bindings/media/video-interfaces.h               | 2 ++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/video-interfaces.y=
aml b/Documentation/devicetree/bindings/media/video-interfaces.yaml
> > index 26e3e7d7c67b..7bf3a2c09a5b 100644
> > --- a/Documentation/devicetree/bindings/media/video-interfaces.yaml
> > +++ b/Documentation/devicetree/bindings/media/video-interfaces.yaml
> > @@ -94,6 +94,7 @@ properties:
> >        - 5 # Parallel
> >        - 6 # BT.656
> >        - 7 # DPI
> > +      - 8 # DisplayPort
> >      description:
> >        Data bus type.
> >
> > @@ -217,4 +218,10 @@ properties:
> >        Whether the clock signal is used as clock (0) or strobe (1). Use=
d with
> >        CCP2, for instance.
> >
> > +  multi-stream-support:
>
> If MST is a known term for DP, then perhaps "dp-mst-support" for the
> name. In any case, 'dp' should be in there somewhere.

I tried to keep the name generic, for the use case of some other bus
with a similar feature, e.g. CSI-2 and virtual channels.

>
> > +    type: boolean
> > +    description:
> > +      Support transport of multiple independent streams. Used for
> > +      DisplayPort MST-capable interfaces.
>
> Wouldn't this be implied by the devices at each end of the link?

For the case of the Intel DP receiver, MST support is an IP
configuration option which cannot be determined at probe time, so it
needs to be read from DT. Having learned that the receiver should use
properties from video-interfaces, I decided to put this property here.
Do you think that's a good idea?

> The drivers for each device should really list out features supported for
> the link. The mode used is then the union of those 2 lists with DT
> properties only used when the union is not definitive.

The mode that actually gets used (MST vs non-MST) is negotiated during
link setup as part of the DP protocol - the sink reports to the source
if it supports MST, and it's up to the source's ability to enable MST
or not.

The property I'm adding here is only useful for the driver to know if
the hw supports MST or not (in the case it can't determine it itself).

>
>
> > +
> >  additionalProperties: true
> > diff --git a/include/dt-bindings/media/video-interfaces.h b/include/dt-=
bindings/media/video-interfaces.h
> > index 68ac4e05e37f..b236806f4482 100644
> > --- a/include/dt-bindings/media/video-interfaces.h
> > +++ b/include/dt-bindings/media/video-interfaces.h
> > @@ -12,5 +12,7 @@
> >  #define MEDIA_BUS_TYPE_CSI2_DPHY             4
> >  #define MEDIA_BUS_TYPE_PARALLEL                      5
> >  #define MEDIA_BUS_TYPE_BT656                 6
> > +#define MEDIA_BUS_TYPE_DPI                   7
> > +#define MEDIA_BUS_TYPE_DISPLAYPORT           8
> >
> >  #endif /* __DT_BINDINGS_MEDIA_VIDEO_INTERFACES_H__ */
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >

