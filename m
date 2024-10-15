Return-Path: <linux-kernel+bounces-365953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3067B99EE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAC9281DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FE01B21B0;
	Tue, 15 Oct 2024 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgRtZkr4"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC651B218C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000679; cv=none; b=XC48HFbzw549pJoCw9LpkaxO4ajctS71n96NafzVkDdCjdOMZYZvi1nBV1t5GhQ1zoHrcdBFeyE6y10XPVeUUzlGUtLG77WnxO3WzAeIDUkvwDYPQbARSiydQ1f246oqgO7ksK7TKR+R+WbhY22X+GT+pvxdvxEu+TpZ05iHolQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000679; c=relaxed/simple;
	bh=u2mCihuTvpleeF6Wc8xqnOwQ2XtbUfQFjtxEvNderdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBGjsPVgPFXuhnxq/2VBiUNeysRm10h/MuLr8dSVOrni9DINGJUw6Gu70V+PxY1IqQUh3K+FVITxYR/Co3AAXy2y+ynGZGxUiwFTesyfO3LHKSY76J6jQRIJXdQ9pJxVsi/FO/sy/G//Y8nOPf5XM/+I76S+V7R67YwuvNm5ODQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EgRtZkr4; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e2918664a3fso3254858276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729000677; x=1729605477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2mCihuTvpleeF6Wc8xqnOwQ2XtbUfQFjtxEvNderdI=;
        b=EgRtZkr4dAxpi6fzuYZsXi0VIzi0Pa9cWlbPD12UVPa5eD/sJGWiH1QaOq45FUot9S
         leoEVyUvo8XkDxVLfgLUzzyUwPCjlhH3Q31LdnNhJ+SG0SXkS+mzfe5uN+rTWl++fSYd
         f+9cgMbnIcajYQw1jI5yxdOqBeZ420V0EEqCQcl0R94wIYKDYHokmHloWNQb+PbJoilW
         1bfcnExyP/jL5EzUZ4xl37D5zmQ93yka+cUBjQoVy1Ix+xDyRyXTFv66mrvcnREsglun
         nmfMFg35zuaLmwM9LlwymaEdmzcT7nbEGwwVcWlPfWhyQMOBDP3TJv3BEPnP29YcakH2
         nQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729000677; x=1729605477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2mCihuTvpleeF6Wc8xqnOwQ2XtbUfQFjtxEvNderdI=;
        b=TDl1oUkROF84wTOc8QxWQiEFmnzMcE4rYTUZpKtzAAnqW1OG+R6AavlBcSWryzzwbR
         A7XfLfzxdbiMXjpmaXD3wb/2QAfXSQJFtvTH7j0/GMScnC5Y3IK/3jZLEH6zJS+ei6a/
         RvdU8N6llKjTlPP6BLxeO4x7d/cjgCpRnTQf4GnBWoJsa+FLYChWsHO9le+JuWeN4EpH
         k2YapTBYXm5vlemZGp/Si/HiJVDSQwU0GckJxgvU8MF8VUPC7SDKCAezAEXNrYiUypP/
         t3J258Pcf4yAMJQxzovUnm1STNz1tTEIWB12WPWcdxmjW0YuL478nIuSyYk04CjgTYGk
         owBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUokl5HdwaNelB+Y1Xk6SHheCgNiEaTS7nkJgJpNQTQw0UMpt1+g1JRTr7qOHIGHLNsPn7JXdgdeIAlCVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2D3zHaeevX52on6TJGeFBSSb1eIwXPeZdG+vJVZVoQ2p+zXB
	Bv1Hl3PBYNSCc5N92UoIEfFaNIc4raczQybWA78Uic/kdDZJH64x0lqiBPs5uySxn21BbeXhmSk
	RBx7aoOX7U5icYsu3/8HRxMZ9htZ15Dvuxo+7MA==
X-Google-Smtp-Source: AGHT+IH+wdRwHX4jXkd5jbgY6RxIoOl7B6iZsFw2tckIVDtnpgDd20m+ArGtOdAV8MMt8x8cJaYXcykSNwRf8LiLooI=
X-Received: by 2002:a05:6902:1603:b0:e28:c6be:4ce6 with SMTP id
 3f1490d57ef6-e2918427d8dmr10356808276.28.1729000676977; Tue, 15 Oct 2024
 06:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911073337.90577-1-quic_sibis@quicinc.com>
 <20240911073337.90577-3-quic_sibis@quicinc.com> <pt4wtycddqhcvw2iblaojmzsdggmlafft4vu6lg5j2vstbhbqj@acenyi5k3yeq>
 <eqy4yicgeqlgaytgzybnitvbrdr7jmjjk5k2swmadad6scwk77@ubaf7a2kgmdm>
 <1BBC34CC-92D9-4F6E-8DFA-1F2DA36D545A@linaro.org> <20241001085105.iglzp3art5ysli2d@thinkpad>
 <b1d982c1-f800-97eb-1be3-e77e04a8e81d@quicinc.com> <20241006180146.m6xvpwbvkiy7obpx@thinkpad>
 <20241015135114.kbiyvymng4e6dmvb@thinkpad>
In-Reply-To: <20241015135114.kbiyvymng4e6dmvb@thinkpad>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 15 Oct 2024 16:57:45 +0300
Message-ID: <CAA8EJpombwmYimszNoQ51m+cfcNs9x+TQ39+-6kXXp+Ziq=d7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add X1E001DE Snapdragon Devkit for Windows
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, konradybcio@kernel.org, 
	krzk+dt@kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	conor+dt@kernel.org, abel.vesa@linaro.org, srinivas.kandagatla@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 at 16:51, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Sun, Oct 06, 2024 at 11:31:52PM +0530, Manivannan Sadhasivam wrote:
> > On Sun, Oct 06, 2024 at 12:33:21AM +0530, Sibi Sankar wrote:
> > >
> > >
> > > On 10/1/24 14:21, Manivannan Sadhasivam wrote:
> > > > On Tue, Oct 01, 2024 at 09:56:30AM +0300, Dmitry Baryshkov wrote:
> > > > > On October 1, 2024 5:42:35 AM GMT+03:00, Bjorn Andersson <anderss=
on@kernel.org> wrote:
> > > > > > On Wed, Sep 11, 2024 at 10:55:05AM GMT, Dmitry Baryshkov wrote:
> > > > > > > On Wed, Sep 11, 2024 at 01:03:37PM GMT, Sibi Sankar wrote:
> > > > > > [..]
> > > > > > > > diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b=
/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
> > > > > > [..]
> > > > > > > > +
> > > > > > > > +&pcie5 {
> > > > > > > > + perst-gpios =3D <&tlmm 149 GPIO_ACTIVE_LOW>;
> > > > > > > > + wake-gpios =3D <&tlmm 151 GPIO_ACTIVE_LOW>;
> > > > > > > > +
> > > > > > > > + vddpe-3v3-supply =3D <&vreg_wwan>;
> > > > > > >
> > > > > > > Please use pwrseq instead.
> > > > > > >
> > > > > >
> > > > > > What benefit is there to wrap a single 3.3V regulator in pwrseq=
 driver?
> > > > >
> > > > > First of all, is it really just a 3.3V? Second, is it actually po=
wering up the host controller (as expressed in the device tree? Is it a pow=
er supply to the slot (in this case, I think, it should be expressed differ=
ently)? Or is it a power supply to the card itself?
> > > > >
> > > >
> > > > Yeah, we should get into the details here. We were not paying atten=
tion till
> > > > now, but with the advent of pwrseq, we should describe the power su=
pply properly
> > > > in DT.
> > > >
> > > > Here I believe the supply is to the PCIe Mini Card connector where =
a modem is
> > > > connected. In that case, 3.3v supply should be connected to 3.3Vaux=
 of the
> > > > connector and we should have a generic pwrseq driver for the mini c=
ards.
> > > >
> > >
> > > Hey Mani, Dmitry,
> > >
> > > The schematics are identical to that of the X1E CRD with
> > > the exception of the pcie daughter card having the rtl8125g
> > > on it. Yes, the 3.3V supply is connected to the card as well.
> > >
> >
> > Is this connected to the 3.3vaux of the card? Please specify the actual=
 rail
> > name as the 'PCI Express Mini Card Electromechanical Specification' spe=
cifies
> > only 3.3Vaux and 1.5v supplies.
> >
> > > Doesn't this mean all other x1e boards out there needs to be
> > > updated with pwrseq as well? Anway will get that addressed in
> > > v3.
> > >
> >
> > pwrseq is the kernel driver abstraction, nothing to do with DT. But for=
 making
> > use of pwrseq, the supplies need to be described in the proper place. I=
n this
> > case most likely under a separate node of PCIe bridge. Then you'd need =
a
> > separate pwrseq driver in kernel to parse the supply and take care of i=
t.
> >
> > I'm currently writing a pwrseq driver for standard slots (x8 for X1E) a=
nd should
> > be able to post it early next week. So you or someone could use it as a
> > reference to add a new driver for m-pcie cards.
> >
> > If no one picks it up, I may just do it.
> >
>
> Hi,
>
> The slot driver is taking more time than anticipated due to the pwrctl re=
work.
> So please go ahead with the current binding and we would switch to pwrseq
> later once the driver is available.

I assume this applies only to the case of the actual 3.3V being used
to power up the PCIe slot? Or to all existing pending items using
vddpe-3v3-supply?


--
With best wishes
Dmitry

