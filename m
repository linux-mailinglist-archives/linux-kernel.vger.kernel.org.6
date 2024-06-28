Return-Path: <linux-kernel+bounces-233556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CD491B968
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EF81C23052
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C0C145A1F;
	Fri, 28 Jun 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AqEK5PJ2"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E62014389A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561910; cv=none; b=b76ujAVYhsjOHQmucEcLb8Ep5YJsFmTLNuPF77oc2SK745Gpo6NGJUFyClkIEg0jCgCWaH5NfLUbgCWAM4kCHbeKBpjQ1h3w70IxcVnjCbVX0/0Co4Qw/ZmYtfcwDBrEqtcAjFME+Twg3QIddSEiJi/Cy2lmtN9PJJW/LD+cu5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561910; c=relaxed/simple;
	bh=JzJrqoFrrLlYjlFvyfWzcuywlzt232DBEfu3youbBSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTX2wfLCN+rVmHkRTL/YMlsw+hgQMLjCl2kt5d3YDmluxfGZs6BWo6ulZVhyKaxOEQPzdbHSmiidiqVsaOm4F6CmwXBX/+amiUtBtmFDTLDkGOR0tTIfXpQRBCz8n9DulehSwN4tCRi32tsFAktimuenbkRifieAiYtPHv5P0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AqEK5PJ2; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b52eb2ee2eso1713996d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719561907; x=1720166707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JzJrqoFrrLlYjlFvyfWzcuywlzt232DBEfu3youbBSY=;
        b=AqEK5PJ2rxoIIIVQwXxRwNtPUpvxZNTbk3bFdnjTil6t4j9gHmOO9f6sn6LomA1z73
         2If5fklFrF6ABz0j9aH8I+qYOdcIV9Ny9JHROITlwzF3UqtzcsTTjRfUPgl/DASBPTgf
         L/eMf0v/jdf8UYw+9NiH/V4Yy1xyqDuFwpBBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719561907; x=1720166707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzJrqoFrrLlYjlFvyfWzcuywlzt232DBEfu3youbBSY=;
        b=lJrZg334o3ceiviUs5SIqCTlGxQCtco/svUb8PrUWUbpONefUiqqlhmHRJOBVC3wXV
         flTQkQ7KMtz/Un//H+M91wFtnGTAY0yb6/ZO5j4qmpeb/244KNxVuSVfSEUA4Epd9Fuv
         akviEub6tnHoDOTwD3mLll8i3xU4OGPdkPLt7z+sa6gvm2vpBCOiaE1XdwkZoIOu9M0R
         iUlhM8Swq92ZAT/GZ7p6mEbwoARXIoH028QJbQKanR207GCRT7t44YaelPnHCfO+CvG0
         0MA9UZiWH50yQwBhJ2WEbZHQyXrWuHgPbmP+Ay5NCdRQi3iX737WxKX7Fg6p2BFc8cJu
         kI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0D4Teq68JtnK3RX0Qj30UKysDMU2BCy+a2XvJsDSxSVwK5RI2YmYv2zo7piVRCCWkl9qk9lMrb6OQQSKBzW+ZGaFfXlhJ4eLH6YdM
X-Gm-Message-State: AOJu0Yzjf7wZcDK8/VoWveimEurOoB54X1rLOJ1ujmllIJvc/RQ/3ZOz
	1V5m79Eeo97c1m3RGkyLo9FJDbCB+0ma/DCcymERy7OcPJd+PoqvgDIdyeZAxxMap6lGeL7/LQV
	anRfvQxMWwNA8TC2968zuMZ+VwwG+v0wXzJTQ
X-Google-Smtp-Source: AGHT+IF0otSsDTnS1XWFIT01k1cgVlGvDRjEaZz815q/WnFkdlw4tS8NYw01YMmeU5bEvep9bbqcDylPNPoaN8d4UEU=
X-Received: by 2002:a0c:f10b:0:b0:6b5:4b10:7849 with SMTP id
 6a1803df08f44-6b54b107986mr143489446d6.1.1719561907384; Fri, 28 Jun 2024
 01:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521-board-ids-v3-0-e6c71d05f4d2@quicinc.com>
 <CAFLszTjexpNEjo1sGVs67L0CAgGZLNkyn9RGfHRD7iHak_mtmg@mail.gmail.com>
 <20240605100246481-0700.eberman@hu-eberman-lv.qualcomm.com>
 <CAFLszThbe_aUAq_5rCCiPV-bj60oq9UCc=vdDHwM3i6t44ohLw@mail.gmail.com>
 <20240621142054973-0700.eberman@hu-eberman-lv.qualcomm.com> <CAFLszThO1doxsXSYTrTTPy9QCW4hrBb07k0VdSNWip=4MKtTnA@mail.gmail.com>
In-Reply-To: <CAFLszThO1doxsXSYTrTTPy9QCW4hrBb07k0VdSNWip=4MKtTnA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Jun 2024 09:04:56 +0100
Message-ID: <CAFLszTiACk98KaqA4Aa65d8ck9iJZevQyeFfq90JjsyZhx_HjA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/9] dt-bindings: hwinfo: Introduce board-id
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Amrit Anand <quic_amrianan@quicinc.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Andy Gross <agross@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>, 
	Julius Werner <jwerner@chromium.org>, "Humphreys, Jonathan" <j-humphreys@ti.com>, 
	Sumit Garg <sumit.garg@linaro.org>, Michal Simek <michal.simek@amd.com>, 
	boot-architecture@lists.linaro.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Jun 2024 at 08:33, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Elliot,
>
> On Fri, 21 Jun 2024 at 23:40, Elliot Berman <quic_eberman@quicinc.com> wrote:
> >
> > Hi Simon,
> >
> > On Thu, Jun 06, 2024 at 10:00:54AM -0600, Simon Glass wrote:
> > > On Wed, 5 Jun 2024 at 11:17, Elliot Berman <quic_eberman@quicinc.com> wrote:
> > > > On Wed, Jun 05, 2024 at 07:17:35AM -0600, Simon Glass wrote:
> > > > > Hi Elliot,
> > > > >
> > > > > I am just picking up the discussion here, which was started on another thread.
> > > > >
> > > > > I can't see why this new feature is needed. We should be able to use
> > > > > compatible strings, as we do now. I added a 'usage' section to the FIT
> > > > > spec [1] which might help. I also incorporated the board revision and
> > > > > variant information and some notes on how to add to the available
> > > > > suffixes.
> > > > >
> > > > > Does that handle your use case?
> > > >
> > > > -rev and -sku don't fit the versioning scheme for QTI devices, so this
> > > > isn't a generic enough approach. Patch 5 in this series describes the
> > > > versioning scheme for us.
> > > >
> > > > In the other thread, we had talked about using some regex based approach
> > > > for matching the root node compatible. I haven't had chance to work on
> > > > that proposal and will try to get to it in the next couple weeks.
> > >
> > > OK, I look forward to it. Please do check the FIT best match approach
> > > and see how it might be extended to handle your requirements. So far I
> > > have not seen a need for regexes, but it is certainly a possibility.
> > >
> >
> > I spent some time collecting feedback from the team on using compatible
> > strings + regex-style approach and we're not able to add a regex library
> > into firmware, so this approach unfortunately won't work for us.
> > Because we have more axes of board identification than chromebook, using
> > FIT's compatible strings isn't a scalable solution for us. I don't think
> > we have incompatible problems, we only have more than 2-3 axes of
> > information.
>
> I understand that. I assume that you have a lot of devices that use
> the same SoC but different PMICs, displays, etc. Some of these can be
> handled in the bootloader, e.g. by detecting hardware and applying an
> overlay, or enabling/disabling a node in the DT. It can be useful to
> have a hardware-readable ID to indicate things which cannot be probed,
> e.g. with GPIOs or ADC + resistors.
>
> Another option is to give names to your projects, so that machines
> with the same SoC but major hardware differences end up with a
> different name (see rk3399-xx.dts for examples).
>
> I'm sure you are already doing some/all of these things. I still feel
> (so far) that you don't need to invent something new here.
>
> Re "FIT's compatible strings isn't a scalable solution for us", how is
> what you are doing different from other vendors? Is it the sheer
> number of variations, or something else?

Here I am referring to the actual number of separate boards which
appear in the wild, not the multiplication of the number of axes which
produced them.

