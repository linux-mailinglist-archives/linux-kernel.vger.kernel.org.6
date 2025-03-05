Return-Path: <linux-kernel+bounces-547854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBF9A50E64
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B5C16CC0D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54413266573;
	Wed,  5 Mar 2025 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST8tafEE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B172620FE;
	Wed,  5 Mar 2025 22:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741212863; cv=none; b=qA+hncjgM7ENF9zXDrY8TVYyPd8cmKPJQoIK4FTbWjSNXlPtri6252SaT5+qPs7AeCmgRor/KitLS4NjIWhW/eJ4QisWWbsHTRMu5if99lKlcxPTSfcgtdGKwXoudANtrkIgo54Fy6gasf3+A6hBugu0oj+n2JF7cuEZvHm1J1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741212863; c=relaxed/simple;
	bh=Zx5GE+9URX3cZR5gaEQ2H19HnShyope1WOKnvdJpFQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6b6Gi5HERrFfDCfjEwgLoc5gdftywQ7F7K6noJu55Qjwg1J84VVZp2EnZfLGhJD+15z81jFn4DZbbsxx77uo85WOtrN7OVOlIDJz1Kt9tU+teXWubWAd/G+mVJOJLpEtDbUbWzyI0ADesRzpVB8qyA4moCcyrg8biIQRwrcVfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST8tafEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08ACDC4CEE8;
	Wed,  5 Mar 2025 22:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741212863;
	bh=Zx5GE+9URX3cZR5gaEQ2H19HnShyope1WOKnvdJpFQg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ST8tafEEsyDf7uOWGSEVaYRQNBETT99JiRalWB9kIGEfq+wUCVwx7xzVB4zKrAAMp
	 cTHu+AdEv6uq4dZ71wXKrPmibAZnA0R1zXifHZU3RjvObojY/rzWvrgfqY5RFQdl+D
	 ZUgwlU06jU050v2w8P0Tr2mnmJuiuoRhtdz4CePwKiX61ndMMnV+YdejoaT6XJCSzV
	 zZwRzWktYc6Ea45b24WVy0/KXOm5/MN1wAm4tUVKRW1ptCSqeUrDQVSypgoOToCvay
	 KMKA2UjOVHq1qiPNn9xmVyCqE3v/sIzUrYBtRG35PBAz0+q/PL/TS/30Zm/64Jkzd9
	 PS2YFgPqrXjYg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso1257188a12.1;
        Wed, 05 Mar 2025 14:14:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWArkSDidjZPZ6vcTAzLvRw61ZANr93/HmYov8TLsoFM38XEHZI0Vd+Yh970mYoXpmjoYs9LmRMAFSjC7SF@vger.kernel.org, AJvYcCXTUwgqsthkEujJ1slhhr03FGYPlfi6sjRl1Z4cdzp4KWz7QgV1idDeYkJvTr+Xcp6E1L9NBkIQ53KU@vger.kernel.org
X-Gm-Message-State: AOJu0YyqRWOvq2z9GAKjjQSrgJUpYfr4NH/dSpTio0TdryBNWeAO/NaJ
	MCe49y4WUUtVv8cX1LL74E8XmvgNVNGyN32Wb3xGMLq2hbqZi/J+RBGm8jPLUvcqG3G6IPZ+B4p
	hCWcCLdUpec6CWpNTza5EZtZ4Ow==
X-Google-Smtp-Source: AGHT+IGYDfNLXYfg6BSzNVuGARy79Tn1tTyoaWjPku6CKaUdhh2vjVg+1b7zISM2D5ggr+aAEfJU6dBDoLxoEAchZz0=
X-Received: by 2002:a17:907:7211:b0:ac1:ff43:82ad with SMTP id
 a640c23a62f3a-ac20d844185mr498713566b.12.1741212861452; Wed, 05 Mar 2025
 14:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304102306.2977836-1-c-vankar@ti.com> <20250304102306.2977836-2-c-vankar@ti.com>
 <20250304153959.GA2654372-robh@kernel.org> <66283781-69d6-4d0a-ada4-3a6bf4744a37@ti.com>
 <CAL_Jsq++DUv5_LHg7sPNXDJZ84JtS94Rwr-WAb9hDWp6rJqZLQ@mail.gmail.com> <11982b12-a359-467a-a6fc-e39adccca413@ti.com>
In-Reply-To: <11982b12-a359-467a-a6fc-e39adccca413@ti.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Mar 2025 16:14:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLb5hrYD_-dqW5ELtbXohd8a1UL7nOuP2a9ZhE+3+f=eA@mail.gmail.com>
X-Gm-Features: AQ5f1Jo1GiNn3eAvnrenLvre-nBgvQ7BPHTsGmYES4JgbDO702r5HrT_Ttt03_I
Message-ID: <CAL_JsqLb5hrYD_-dqW5ELtbXohd8a1UL7nOuP2a9ZhE+3+f=eA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] devicetree: bindings: mux: reg-mux: Update
 bindings for reg-mux for new property
To: "Vankar, Chintan" <c-vankar@ti.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Peter Rosin <peda@axentia.se>, s-vadapalli@ti.com, danishanwar@ti.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 3:43=E2=80=AFPM Vankar, Chintan <c-vankar@ti.com> wr=
ote:
>
> Hello Rob,
>
> On 3/5/2025 2:10 AM, Rob Herring wrote:
> > On Tue, Mar 4, 2025 at 1:03=E2=80=AFPM Vankar, Chintan <c-vankar@ti.com=
> wrote:
> >>
> >> Hello Rob,
> >>
> >> On 3/4/2025 9:09 PM, Rob Herring wrote:
> >>> On Tue, Mar 04, 2025 at 03:53:05PM +0530, Chintan Vankar wrote:
> >>>> DT-binding of reg-mux is defined in such a way that one need to prov=
ide
> >>>> register offset and mask in a "mux-reg-masks" property and correspon=
ding
> >>>> register value in "idle-states" property. This constraint forces to =
define
> >>>> these values in such a way that "mux-reg-masks" and "idle-states" mu=
st be
> >>>> in sync with each other. This implementation would be more complex i=
f
> >>>> specific register or set of registers need to be configured which ha=
s
> >>>> large memory space. Introduce a new property "mux-reg-masks-state" w=
hich
> >>>> allow to specify offset, mask and value as a tuple in a single prope=
rty.
> >>>
> >>> Maybe in hindsight that would have been better, but having 2 ways to
> >>> specify the same thing that we have to maintain forever is not an
> >>> improvement.
> >>>
> >>> No one is making you use this binding. If you have a large number of
> >>> muxes, then maybe you should use a specific binding.
> >>>
> >>
> >> Thank you for reviewing the patch. The reason behind choosing mux
> >> subsystem is working and implementation of mmio driver. As we can see
> >> that implementing this new property in mux-controller is almost
> >> identical to mmio driver, and it would make it easier to define and
> >> extend mux-controller's functionality. If we introduce the new driver
> >> than that would be most likely a clone of mmio driver.
> >
> > I'm talking about the binding, not the driver. They are independent.
> > Generic drivers are great. I love them. Generic bindings, not so much.
> >
> >> Let me know if implementation would be accepted by adding a new
> >> compatible for it.
> >
> > Adding a new compatible to the mmio driver? Certainly. That happens
> > all the time.
> >
> > I also didn't say don't use this binding as-is. That's fine too.
> >
>
> Can you please review the following binding:
>
> oneOf:
>    - required: [ mux-reg-masks ]
>    - required: [ mux-reg-masks-state ]
>
> allOf:
>    - if:
>        required:
>          - mux-reg-masks-state
>      then:
>        properties:
>          idle-states: false
>
> required:
>    - compatible
>    - '#mux-control-cells'
>
> I think it won't disturb the current bindings and keep backward
> compatibility with existing implementation.

Wasn't that the case before? There's nothing really different here.

Rob

