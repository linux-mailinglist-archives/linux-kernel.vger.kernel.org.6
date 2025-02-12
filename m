Return-Path: <linux-kernel+bounces-511675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A163FA32E24
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533E6168C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF1325D527;
	Wed, 12 Feb 2025 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VGZHapzR"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29B209663
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383562; cv=none; b=Mgl++DsuKXm176sG6gQfLXoDGszPxKAOcdpjkLsNeWCwLGKP9IReUXXRctWwgFGXhXOSkGxdQu6wEU9YAsA3Lh5kfSS/nM9PXqv075K694a2lHxOBP7erwQetxloHnEZWmZoOr3i2ZRQ259wppaojTrQTctQldmFb4qoCZr0JLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383562; c=relaxed/simple;
	bh=tJnaPVXf7C5zD77/AWLmv25JpFX7qo5ZjH3DvCBibtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UF2+Yq/G1PWRs81ZYaDTXO2WGuG7SNXlTG92uiVNQdTkyGFXfql0/Qw73vEwIR1KwpCv3IeCXn/yrZV5lJmHUqnPpbOtzF0ufPWsi9xAw/y88NqEChvGNdUwbOK1XLCOkDuke9Ro2sG4OKzry2RzU7eaBHInbFkuajBMn0ptk0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VGZHapzR; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-308f141518cso84441fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739383556; x=1739988356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJnaPVXf7C5zD77/AWLmv25JpFX7qo5ZjH3DvCBibtk=;
        b=VGZHapzR5dakUVxwSJk4YdHtSp9/0ly41/aKZ5Wt/SASsG+UFo4g8S2gj5YSCBwHpO
         sUM6+75f0qVhXOo92eNmTcxlyoBzQ6Md/ddyg+XWZ1baKB4Oa5NOcTlXTtX8+nwyVVVM
         3HsPv7kktLuu4aV0qbVGx1tzN8hfLhV5bl5t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739383556; x=1739988356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJnaPVXf7C5zD77/AWLmv25JpFX7qo5ZjH3DvCBibtk=;
        b=VK7j4DA+gRvVhVHlgBsKXWzN8yT5zDoeSIMh1QAj+xHOz4U972XM2nvr4f76ASorK+
         4aqKOaRW7jo2ijPuSQvzsuARZ1OpT5ZaCF5i/IDGQN2f9sjEGKQsz1ZkD39axfYCF5gS
         hbkgKmlFVCfV4C/01cSdWcIdB2BadzAk0AokNcK+m+FZuG2PQcdOR81vqDsDtr3cCGS3
         TxO4K85OYM/zQy05Xr1y3IkUyWGQiTqHGueQFz0j8fmNZmQ0/UGwEyzhpFhXs9YLHMuV
         mxPa2HwG0/nmsAhmof9H2rKj3yYteTAnejg4krVn7jXHbm1Ljguf3Qd/ViQoEmXsmsRx
         UCmg==
X-Forwarded-Encrypted: i=1; AJvYcCWGUHv/jFD7qlafgA45xeFFPH8x1bF9AcwtM+TPOPqrXeA8cg/cR34eAxkM9cP9tD2aDOkY+zZUX/MZVmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY2ojJkO9R8kwJme1ghj33d8/FzD2yfKuCboN7Ijqb1pfsvjRO
	jG7oU7ETQwTYzNSIu4I7oY5BWMeSrezV1UigCV8TX9D5MAz5KwJOM67AZb2/PT6Ey0idkK8fq+W
	TUUH3
X-Gm-Gg: ASbGncvDYTdpPOSVI/ICXoSuKc6lhzKLitdQuuizOqNZGBjJHSHtOdmE8tEyixs0HCs
	HjaZO7WFasjl2QFxbthwxQmK8sdScCsMpGdrhGZZgJBWM+lUbHZdRWixfS+q+BM1QvFinZbzN6f
	DgN+wGaGQSKwC69xYodbmxWnXzV0Hw6HwDO99FschneIULwLvBSFb6zpmlfLibuNH95nLMaOm15
	qdg5W+mvKfAZtQGXJBv7jq9u4d2cnYchl0qF+kvmz3WIA8Ix7utiJDkB37ld7yKM/4gvVbyVZly
	hq7e80cOkQwO6YLGGJuAnCDbA+SfB4aQUL5nr0fmo1FE4x8B4UH4kPU=
X-Google-Smtp-Source: AGHT+IFFORG8iIoeVUZnIuXZsskNsbslWsUgTa/6MHp5iRPq8Lf9iiYLLfBpBxIArr4LraWKByoBng==
X-Received: by 2002:a2e:be0d:0:b0:2ff:a928:a23e with SMTP id 38308e7fff4ca-3090509141amr15421111fa.25.1739383556190;
        Wed, 12 Feb 2025 10:05:56 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-308e315007csm14109481fa.28.2025.02.12.10.05.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 10:05:55 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5450f38393aso2999069e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:05:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxjsMnyTgeYr3m+iZN849KyjLgriZi8IGlWHX7gU6HqUYHPAaef4bx0Do1cJ1o1BALWRkhTSZCqPHVHEE=@vger.kernel.org
X-Received: by 2002:a05:6512:23a0:b0:542:29b6:9c26 with SMTP id
 2adb3069b0e04-545184bc10cmr1392880e87.47.1739383553822; Wed, 12 Feb 2025
 10:05:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107200715.422172-1-dianders@chromium.org>
 <20250107120555.v4.2.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid>
 <e6820d63-a8da-4ebb-b078-741ab3fcd262@arm.com> <CAD=FV=WTe-yULo9iVUX-4o8cskPNp8dK-N9pKq6MxqrPX3UMGw@mail.gmail.com>
 <Z6zf3YJq6qqoJQRi@arm.com>
In-Reply-To: <Z6zf3YJq6qqoJQRi@arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Feb 2025 10:05:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XZnb-c+9LVYWmA0EZPTX0enpZQdwokRanKZ78RRQOAzw@mail.gmail.com>
X-Gm-Features: AWEUYZkYpo4ZdBFbmBIkTo_Y8VQo51FzREvP3YsId9scTLFHz9v6oyFYchRiLcQ
Message-ID: <CAD=FV=XZnb-c+9LVYWmA0EZPTX0enpZQdwokRanKZ78RRQOAzw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] arm64: errata: Assume that unknown CPUs _are_
 vulnerable to Spectre BHB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Roxana Bradescu <roxabee@google.com>, 
	Julius Werner <jwerner@chromium.org>, bjorn.andersson@oss.qualcomm.com, 
	Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-arm-kernel@lists.infradead.org, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, Scott Bauer <sbauer@quicinc.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 12, 2025 at 9:52=E2=80=AFAM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Wed, Jan 29, 2025 at 11:14:20AM -0800, Doug Anderson wrote:
> > On Wed, Jan 29, 2025 at 8:43=E2=80=AFAM James Morse <james.morse@arm.co=
m> wrote:
> > > Arm have recently updated that table of CPUs
> > > with extra entries (thanks for picking those up!) - but now that patc=
h can't be easily
> > > applied to older kernels.
> > > I suspect making the reporting assuming-vulnerable may make other CPU=
s come out of the
> > > wood work too...
> > >
> > > Could we avoid changing this unless we really need to?
> >
> > Will / Catalin: Do either of you have an opinion here?
>
> Is this about whether to report "vulnerable" for unknown CPUs? I think
> Will suggested this:
>
> https://lore.kernel.org/all/20241219175128.GA25477@willie-the-truck/

Right. The patch in its current form is in direct response to what
Will requested and then subsequent feedback on the mailing lists from
Julius Werner.


> That said, some patch splitting will help to make review easier. Should
> such change be back-portable as well? I think so, it's not only for CPUs
> we'll see in the future.

Personally, I don't think the patch will be terribly hard to backport
as-is. I would expect it to just cherry-pick cleanly since it only
touches spectre code and I'd imagine all that stuff is being
backported verbatim. I did at least confirm that it applies cleanly to
v5.15.178 (I didn't try compiling though). I guess there are conflicts
back to v5.10.234, though...

While I've had plenty of time to work on this patch in the last three
months since I posted the early versions, recently my assignments at
work have changed and I have a lot less time to work on this patch
series. If breaking this up is blocking this patch from landing then
I'll try to find some time in the next month or two to do it. Let me
know.

-Doug

