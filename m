Return-Path: <linux-kernel+bounces-376690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA979AB4EA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7ACB22584
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAC41BD4F1;
	Tue, 22 Oct 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIE8mCG9"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AEB1BCA1B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617742; cv=none; b=M3BPGaMoiYUZcLxt7jUCyysVLsGAf6SVfSUXngnxDTNat7YnOhZOpldstmaJl3trnPDPCWTOI44NHe8AXwO3cS45e6lfGUBfEp3TJxcn5SzrrlXOLlR1d0PwUus4YBklGTv9tdqOrzb2fQeQtYVoQp+77abtm2G3YAaQ0TFU1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617742; c=relaxed/simple;
	bh=hXTF6XvFBzImgE6eYsm8hMCOJHEX9FzG4MTyq9sjgFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9EWJ35qR3xrlD30+nW+RxVe+RrIFkyGnUHfNYvMLi1VmTsTwuNZJLiV9i4dOvUPzgfBIInyDRs+UNCzF7YLQSKFa4fygFwF7YZAg1mr//wmI+NBJFQz787kdTHjVBueX6bchoeY9rVvnECYvjC+VUW1gXzkCAfO1nxA/K0TDCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aIE8mCG9; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e5e5c43497so25532877b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729617739; x=1730222539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u3Cz3yuO/5QEEGytqutmYOKW+Pac+2T0WZ1b7xHRYgA=;
        b=aIE8mCG9oB3rkhTNvOsU4O43vSB/AW8mSh5bK8A3s38VaIHIW3fVncl+ry9qQV/Vxl
         qLR3iB7CBBEeBKZPBvkwqMhiQdiSjF7bJ8oKo6hvQDm9f7uH6toN59nPHnwGcpafLiPp
         E6qE5TZirMf7nVMtZNvaqFaLyPXFU5N4RX3YGxKjSdkMT8Y/5a/1Wuw0LKo5EG+P1t2N
         xVX/RmoTtvcrCBcdN2vmXxwOvv14OQaeibtrVGwOqhVOdWPd8B4vzqZq4MLEGFNFCmJn
         QGLokQqrfncg4OoP49xGw+THQEYjZqACZ4IdaNwketkARcZB7Wo5Y9NbSU5dqDVlSh1l
         xWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617739; x=1730222539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3Cz3yuO/5QEEGytqutmYOKW+Pac+2T0WZ1b7xHRYgA=;
        b=w7bf2DQ91iB4zudMS7o3qihUn5W5v0fNBiqa6hQ0wnHOnT0t/drY4JbS2GbT9sj1tk
         l/gPOq8dA7lo++ButfZPOldJHWgSi/r1nRSVpb+FB9or3JmXkPkpL6k4eUzJAw7Ef6vl
         HT/AKsd7UvItC5jkRnPgiwV+Vepv5NuqLlY5p18JMgPCPjUcnD+714HNZ1SNC6u+P9Vh
         zIQIMB4tcC+rvzwvt/mVsWpygEjrvFJFHQOOu8uczerFywD2Gp4BYtUHQgxxEf9hzoFs
         bYn6zCmvewMs9DGVvtzVmZdyT0MoC+IXxc9GlMZoyendxl5WtHqOfYiAyG3IpoUvzCSR
         fa+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaet+zJtlfBNZoYCF/zaEfxbRpdhFJBvoE16U6OzOwYnj2FNGzbs1EH0XsG3bVg306Rt61sleFOlUikD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfmd+XOUQtqnj3WQ2TS90PjbGH5QwaI9nRDsD+WQALwl5ljND2
	/g+5MlyZyH8jbJ5irscb8dhExmjspi9k+y1hTYdeUYjaMxsp1Et5wQl/Yapt8Hm584CP6I6OYEI
	UcJlizpdvE9pjs1yAxWnDIhk6Z35i/q8+s3Y9Zw==
X-Google-Smtp-Source: AGHT+IEhD70BJGJX/rdaEE2IpcmjyH6Pzf5WTuQWFOxBcec1CbgF6aGfwLQofAK8+AOYeZfOPc7jurckohcbbI3BO30=
X-Received: by 2002:a05:690c:6c0f:b0:6e3:351f:d757 with SMTP id
 00721157ae682-6e7d82529femr40893047b3.24.1729617738864; Tue, 22 Oct 2024
 10:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA8EJppfzc_dM9c9mHPVWheVxi-1gJxCmaWPvreELijEQDDSyA@mail.gmail.com>
 <20241001101622.ys36slymgjbaz26q@thinkpad> <8459161B-87B8-481F-AE71-3D5156B1CA56@linaro.org>
 <20241001141948.g74rn6777ywvtcmx@thinkpad> <CFF89D4D-8131-47C2-95B8-A0E130A16E46@linaro.org>
 <9c24ba5d-431a-c45e-ce1c-3541eac7d017@quicinc.com> <20241012124334.4gsspgtuud4uudop@thinkpad>
 <7yzjgqitjvfwricftcpelktwjbgwkjuibwkpodjd6x4gwkjkw3@wkeqp6lqwfqv>
 <bbc900f7-eb8f-2664-2144-50a9a6ad8453@quicinc.com> <qevhitaa47fd77jrrs4viv6mctkhedoz5jy33ruqvv62qrb44y@owzfxnxrapvf>
 <20241022151005.g36xnr7lf46p32ha@thinkpad>
In-Reply-To: <20241022151005.g36xnr7lf46p32ha@thinkpad>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 22 Oct 2024 20:22:07 +0300
Message-ID: <CAA8EJppbY+YCesE4R4zV83CpCryyZNzvuzoNpgk+8a8h7mCzqw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Add PCIe nodes
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com, quic_skananth@quicinc.com, 
	quic_parass@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 18:10, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, Oct 17, 2024 at 02:12:00PM +0300, Dmitry Baryshkov wrote:
> > On Wed, Oct 16, 2024 at 10:43:19AM +0530, Krishna Chaitanya Chundru wrote:
> > >
> > >
> > > On 10/14/2024 4:55 AM, Dmitry Baryshkov wrote:
> > > > On Sat, Oct 12, 2024 at 06:13:34PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Fri, Oct 11, 2024 at 05:24:29PM +0530, Krishna Chaitanya Chundru wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > > > The logic here is that the fixed endpoints in the switch will get an unique SID
> > > > > > > > and the devices getting attached to slots will share the same SID of the bus
> > > > > > > > (this is the usual case with all Qcom SoCs).
> > > > > > > >
> > > > > > > > But I guess we would need 'iommu-map-mask' as well. Hope this addresses your
> > > > > > > > concern.
> > > > > > >
> > > > > > > Yes, thank you!
> > > > > > >
> > > > > > Hi dimitry & mani,
> > > > > >
> > > > > > This particular board variant doesn't expose any open slots to connect
> > > > > > a different endpoints like another switch(which might have BDF unknown
> > > > > > to us) so static table should be fine for this board variant.
> > > > > >
> > > > > > I tries to add iommu-map-mask property, the issue with that property is
> > > > > > that the driver is applying the mask to the bdf before searching for the
> > > > > > entry in the table. If I use a mask value which satisfies all the
> > > > > > entries in the table ( mask as 0x718) and if a new bdf is enumerated
> > > > > > lets say 0x600 due to mask 0x718 its value is again 0x600 only.
> > > > > >
> > > > > > Can we skip iommu-map-mask property and use only static table for this
> > > > > > board as we know this board doesn't expose any open slots.
> > > > > >
> > > > >
> > > > > Hmm, I was not aware that it doesn't have open slots. Fine with me then.
> > > >
> > > > It doesn't feature open slots, but it has two PCIe connections on HS2 /
> > > > HS3. Users might attach external PCIe devices.
> > > >
> > > > Krishna, could you please clarify, how those two connections are routed?
> > > >
> > > For this qps615 board to one of the downstream port (pcie to usb) usb
> > > hub is connected and to the other downstream port NVMe will be
> > > connected.
> >
> > The board has two PCIe links routed to the HS2 and HS3 connectors. Are
> > they routed to the PCIe switch?
> >
> > Yes, they are not standard slots, but still the board is expandable and
> > it is possible to connect external PCIe devices. As such it is not
> > possible to have static SID mapping.
> >
>
> Sorry, I think the conversation got deviated. We have concluded that the
> endpoints fixed (soldered) in the board will get a fixed SID (because we know
> what they are) and all other devices going to get connected to HS/LS connectors
> will get shared SID (because we don't know what they are).
>
> Any concern with that?

This is perfectly fine with me.

-- 
With best wishes
Dmitry

