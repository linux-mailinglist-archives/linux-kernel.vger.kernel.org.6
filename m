Return-Path: <linux-kernel+bounces-537816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87A7A49143
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54703B7219
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883871C3BF8;
	Fri, 28 Feb 2025 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fhl5q+8f"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71717A2F4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740722430; cv=none; b=OA6myBiVG8YRw0orJgBr23zHogQ+mtEUfOC6g1giyhb+9CC4D97P+mLM6UT4WUXkVVsnpzB1mMdQptfRXYxwUpSGYFNs+hogU9vFDQUb6c/z73C7YTFNzBs4ecDXdYTLdmUVTeKZnmKBr6iIC7km0c10WybVfXBu+6cGDK6GEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740722430; c=relaxed/simple;
	bh=AWvYiQoiMEDKzx0UJ2Y6eQ9AejEWiZPRdpZdb1d0FeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku8aheBPmrU9FaI7fh1rbbOls/lZuJn0xCvDbvviEtr7XNyZRDipRc7NOLNpjuzDT1Sgen8C7+4MuDBexxna6OmqA91mRS8LlX4wEM7PzzaFBsXP27G1YTuvnePBkMGsoDixLClqtdhseK+DF0yLB9rrkeejQbXEzZW/k8n0He0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fhl5q+8f; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5494e7ad57fso493018e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740722426; x=1741327226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PHiWqrIN5nYCcFqaUNMMfDdBtNQ/qJHg5lRmt2lqcUk=;
        b=Fhl5q+8fvuccE8qFszZM/a67mpalbARjcXLFzfWMVEq2HGVYkPr0FqZz+eFUJluRsB
         A08bU5rWlUvpfW0n5XcnXy0wL5Fp749qZicHUxUKwg2jCECDQkzbGHsb5M2splnQGG95
         Zm7iVDalZ5WMcrkT+EP7DRWRtSBHy4LpN6yUXugsaqIqjGeuz3lQNWD5a2uLnJpyGrMz
         zIWrWfs3z0og/OZscRYlW2AnxxA3E05Pw1tq0DCndqg6UmawRZQJRmzx+OS5unW5tCVb
         YxVuDlbRnjYc3Hs2CRZb+PxosT2Vm3In55gloNSYn6vCgDDdZyR4KQpwEQJLiQLeiItH
         4yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740722426; x=1741327226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHiWqrIN5nYCcFqaUNMMfDdBtNQ/qJHg5lRmt2lqcUk=;
        b=e/INtX9jLOGiUoJZ1vPhPDt4fQ1MKLXbpGwWX8ytTUsiOt+vH6fdUR7FxHwlDCsVaJ
         RIR1r8ZbKJo5mPd0KmtHj80rorPbLTKq122ZTUbt2T6UD4dVxKG9xNshv4pjxAGeQCCz
         +R86JazZOC4GiRN1U/1E+FC0xoh6Ncs2qSgNAttD6W+nOV/W1byQ3HdBYmIitYDzGG0X
         b2iRuSvoa5rwhsg2EKDLNE6orDttZHEpSZsODxAre9XPzNDydfb7HQEApKOA6syRgQm4
         PFU8bj5H5OhlSOA2665JtND9MQubjPEtDMd1OtvDSEltWF4Xj+1gXjadrPasJtusW2l/
         aJtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXpz1fSCTaTl1VFBtgBuZEdBxdT/jDMKKmdKvNNQB1IaUXCyoiOT5AXSOmPWVFap7ULOBkYPDhg7B9Hto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdyKQqIFs0ByJCGxItxJwopnXo7Z9NFrHwCndtprZ9oLjOzMyG
	5vBpkuXUieBSPZy5rg3CANjAYgIALT9momq3siBc2KHlDaWNB5r9lnshnwZ3Fyw=
X-Gm-Gg: ASbGncsOXXX3MYWcELHSY+xgyHEluc/MdA7eI1k01Tep/mdGiAZoiIxZP1hobCUVBop
	qp1czk1T8cE/Ab8qkyUzE5xik4KrUhv2LkBneLfZAc9yv8x/Cjkisifz5FR3+XAY+Y02i6+cGp5
	HArf+yeGTaa4M6ZX8n40M9uIqIV4qrswPrUXX6fUtkalyqQIQ+N0r7y6pMTAt5Tj5gGzcsXo8lf
	ySy1zVd9MKIIau2ow5/UI21ZvUPSjmPz+avTwOdakxpf5D4ugC5j4ngO92e8GEq9uKeHXK4CNzD
	tJoKLSbyLqSR358MrNHOUSoUd9m3AWysv/9e8Ckx8ccgz+g2KKky/cWUcGIj5SBHnoHpGhp3IwV
	2VcBxfw==
X-Google-Smtp-Source: AGHT+IEJbAhpdFbd4rtOwGQdCPsbiJf2wgXOzhz7clbflWZVUZhxS3wxngsZE4mhVM5oJfAGvDSH+g==
X-Received: by 2002:a05:6512:2011:b0:549:4def:a24d with SMTP id 2adb3069b0e04-5494defa388mr465403e87.35.1740722426200;
        Thu, 27 Feb 2025 22:00:26 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494417a3absm371442e87.53.2025.02.27.22.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 22:00:24 -0800 (PST)
Date: Fri, 28 Feb 2025 08:00:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: qcom: ipq5424: Enable MMC
Message-ID: <pikuqtpk3mvxc5pdmympzebzi3kvl63mipdenkhgdoy77tb6e2@phflnxgfudum>
References: <20250227094226.2380930-1-quic_varada@quicinc.com>
 <ryfawl6uykry5ds5kovujvepkwffdwitbqltx75wnnrqrbl4b2@i2pjwegs3u4n>
 <Z8FE8nmYm8uqya6k@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8FE8nmYm8uqya6k@hu-varada-blr.qualcomm.com>

On Fri, Feb 28, 2025 at 10:39:06AM +0530, Varadarajan Narayanan wrote:
> On Thu, Feb 27, 2025 at 05:03:10PM +0200, Dmitry Baryshkov wrote:
> > On Thu, Feb 27, 2025 at 03:12:26PM +0530, Varadarajan Narayanan wrote:
> > > Enable MMC and relevant pinctrl entries.
> > >
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> > > index b6e4bb3328b3..252687be9dc3 100644
> > > --- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> > > +++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> > > @@ -69,6 +69,14 @@ &qusb_phy_1 {
> > >  	status = "okay";
> > >  };
> > >
> > > +&sdhc {
> > > +	pinctrl-0 = <&sdc_default_state>;
> >
> > Where is it defined?
> 
> Few lines below [1] in the same dts file.

Ack, I missed it somehow.

> 
> >
> > > +	pinctrl-names = "default";
> > > +	supports-cqe;
> >
> > This property should be a part of the SoC dtsi.
> 
> Will move it.
> 
> Thanks
> Varada
> 
> 1 - https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts#n128
> > > +
> > > +	status = "okay";
> > > +};
> > > +
> > >  &sleep_clk {
> > >  	clock-frequency = <32000>;
> > >  };
> > > --
> > > 2.34.1
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

