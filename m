Return-Path: <linux-kernel+bounces-254538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107293347A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C081C2248D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF4D143C70;
	Tue, 16 Jul 2024 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cMI1fLuJ"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94813CFA3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721171458; cv=none; b=AxYf5JK1lPiKMP+KZOFQVZhZWz51u8KSWBPDG8yKTu7dEILogSHhnRP36GFdQOunspbrg5GZ+tfyOoE1nr9VtUyCgZK60mIn9AjTBYG4nyNlZi7/bMQ7rSNvVe6jB+c0qqEOja1sXodVxwX9Ex/HOWfdvDNrPHyIoRwcDvRkPL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721171458; c=relaxed/simple;
	bh=ACrmCh+iIvhZ8BMv0v1ObXZ51BFBngpVtx+0n2WhBzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seQneVtrQ3+EtVwvA+nVgEdGqJF8a4oPS3QzUFuo/rWxchagjZIzi+QVQhuHExESt8UDw6o53g4T63uinJASrqHlcExpz2kL8F1n2pj5H2A39PNftIoQ0ndJOLmpyc2R7f1YpMU9JqSN0NHk6Ghwz0YyUWmPco8KMAfBJ1TNjSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cMI1fLuJ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-64b29539d86so55084367b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721171455; x=1721776255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mnz8Yur+ctB0OjoR8RPZjZ/sh0WQ6+9cTPLE+h5UQ+U=;
        b=cMI1fLuJCW+lBx6Yglz0QNYDObri45IGWiHuNlUp53y/8fyrVUwnXRg4Pn8MFbC/iE
         J26rduwVXvK956JMjbbleYkdZ7MLbaMTpJKWlaTfeYTRBgN3ryJyK+1B0NXPTSQUJ59d
         0h4FseYVtEfdCvWUCjj6JCKaWRGgNtJKTXVAXiErc3IwP4oYVFgj4aIk/6a38v/yYSYz
         mfqzCWE063qqvflEJ3D6WlbBQGcDxfqyb6TECZaDpuX9faP/saoFT2yvMAqRZty1wjIH
         b9rRrJILueOfLFbIbjul0N3Q/eu3r/4OyXB/FMP8zFIY604Zaok87ct+B+4gM+ddp9mh
         TZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721171455; x=1721776255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mnz8Yur+ctB0OjoR8RPZjZ/sh0WQ6+9cTPLE+h5UQ+U=;
        b=LjBGYI2TSN7lZF+yYoq//DS6+xozlv9Ydq2bqHtnRMLI+lfnK/FzqWLDzCUrw2Ewvg
         O7xqOLemoIa3uRs0tNMvA/tjlzUtIGPXVWbu74rAPlyb8Jdr2RBR8ZKpWPSkAbpcxeY2
         giHFynRVcTLfdVFPGoNxSlgMpJi11hW9RruiYJl0gtXPploz4kxH20gh0x49ezS4hOgT
         Mc9zdaf67eIJdyxXLP9xccS2gIj/ba2PDtOP4DkRSHH2wvHz4o4t9gI6N0IMrtrz+Y/+
         JSYVHIKYHxLmN1Xb0jXasLUyiQClDBAAkJp7D0uM58lqGG7Nc5CKxOEwzshHY2rIscO0
         vapQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkOf5mgE3ZuNRbFpKIwOxrKmp82JKE5Ao2M7fqun8O6DW6NQ1Ki4tQFE3Dx02xmqb8aUYEqNwC8UtTAE1JBnjd0cyzSGglmyPHY7Au
X-Gm-Message-State: AOJu0YzCXb8icclqbg7dvja8EyrbyUcprBvRQTGw/Y/IesclsNQcbDJe
	ppKH1CC32skQVRgaiEGGyC8/8ywQshJqZUyWPpTq23GYU+dTQa9nuN3mw3AZpvd37YH5nWxLfHw
	ApBiF6lng2cOuxp92FvBZKAMzBwIo55DQW8nf5A==
X-Google-Smtp-Source: AGHT+IG5CaNY3HH9LijnECfl6ut/hKInZ3kGI63WniAf8g8W96xXBmAkqYxaOI2F2ymneo+7FsVdA3Bfh3cIMNyAUh8=
X-Received: by 2002:a0d:cd45:0:b0:65f:ca0b:5ad9 with SMTP id
 00721157ae682-664fe73ffdemr723057b3.25.1721171455645; Tue, 16 Jul 2024
 16:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628214848.4075651-1-quic_abhinavk@quicinc.com>
 <20240628214848.4075651-6-quic_abhinavk@quicinc.com> <5isw7c5kkef4kql4qcous3gmwhvgwc53ntgjm4staymqr67ktm@iw3cr2gr2iko>
 <CAF6AEGtVBarvEUqgt7SHzYwXUsjY_rVQS6aMsN00G91Dr1aWAQ@mail.gmail.com>
 <cf8d00cd-6dc6-42b9-be61-93ef48d42b0c@quicinc.com> <CAF6AEGv2H2FQ4wCWEzgboK0Lz3em-0XkG5pe_HwN1rW2iaGVrw@mail.gmail.com>
 <6460042b-a2cb-41fa-9f6f-fb11e20f69aa@quicinc.com>
In-Reply-To: <6460042b-a2cb-41fa-9f6f-fb11e20f69aa@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Jul 2024 02:10:44 +0300
Message-ID: <CAA8EJprmi9zxEipq=0LyBi4nJ59BrLgN1sL+3u7-n9kJ3yQcRg@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/msm/dpu: rate limit snapshot capture for mmu faults
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, freedreno@lists.freedesktop.org, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	quic_jesszhan@quicinc.com, swboyd@chromium.org, dianders@chromium.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jul 2024 at 01:43, Abhinav Kumar <quic_abhinavk@quicinc.com> wro=
te:
>
>
>
> On 7/16/2024 2:50 PM, Rob Clark wrote:
> > On Tue, Jul 16, 2024 at 2:45=E2=80=AFPM Abhinav Kumar <quic_abhinavk@qu=
icinc.com> wrote:
> >>
> >>
> >>
> >> On 7/15/2024 12:51 PM, Rob Clark wrote:
> >>> On Mon, Jul 1, 2024 at 12:43=E2=80=AFPM Dmitry Baryshkov
> >>> <dmitry.baryshkov@linaro.org> wrote:
> >>>>
> >>>> On Fri, Jun 28, 2024 at 02:48:47PM GMT, Abhinav Kumar wrote:
> >>>>> There is no recovery mechanism in place yet to recover from mmu
> >>>>> faults for DPU. We can only prevent the faults by making sure there
> >>>>> is no misconfiguration.
> >>>>>
> >>>>> Rate-limit the snapshot capture for mmu faults to once per
> >>>>> msm_kms_init_aspace() as that should be sufficient to capture
> >>>>> the snapshot for debugging otherwise there will be a lot of
> >>>>> dpu snapshots getting captured for the same fault which is
> >>>>> redundant and also might affect capturing even one snapshot
> >>>>> accurately.
> >>>>
> >>>> Please squash this into the first patch. There is no need to add cod=
e
> >>>> with a known defficiency.
> >>>>
> >>>> Also, is there a reason why you haven't used <linux/ratelimit.h> ?
> >>>
> >>> So, in some ways devcoredump is ratelimited by userspace needing to
> >>> clear an existing devcore..
> >>>
> >>
> >> Yes, a new devcoredump device will not be created until the previous o=
ne
> >> is consumed or times out but here I am trying to limit even the DPU
> >> snapshot capture because DPU register space is really huge and the rat=
e
> >> at which smmu faults occur is quite fast that its causing instability
> >> while snapshots are being captured.
> >>
> >>> What I'd suggest would be more useful is to limit the devcores to onc=
e
> >>> per atomic update, ie. if display state hasn't changed, maybe an
> >>> additional devcore isn't useful
> >>>
> >>> BR,
> >>> -R
> >>>
> >>
> >> By display state change, do you mean like the checks we have in
> >> drm_atomic_crtc_needs_modeset()?
> >>
> >> OR do you mean we need to cache the previous (currently picked up by h=
w)
> >> state and trigger a new devcores if the new state is different by
> >> comparing more things?
> >>
> >> This will help to reduce the snapshots to unique frame updates but I d=
o
> >> not think it will reduce the rate enough for the case where DPU did no=
t
> >> recover from the previous fault.
> >
> > I was thinking the easy thing, of just resetting the counter in
> > msm_atomic_commit_tail().. I suppose we could be clever filter out
> > updates that only change scanout address.  Or hash the atomic state
> > and only generate devcoredumps for unique states.  But I'm not sure
> > how over-complicated we should make this.
> >
> > BR,
> > -R
>
> Its a good idea actually and I would also like to keep it simple :)
>
> One question, is it okay to assume that all compositors will only issue
> unique commits? Because we are assuming thats the case with resetting
> the counter in msm_atomic_commit_tail().

The compositors use drm_mode_atomic_ioctl() which allocates a new
state each time. It is impossible to re-submit the same
drm_atomic_state from userspace.


--=20
With best wishes
Dmitry

