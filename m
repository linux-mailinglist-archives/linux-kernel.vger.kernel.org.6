Return-Path: <linux-kernel+bounces-553033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD0EA582B5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7198168052
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377401A9B2A;
	Sun,  9 Mar 2025 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMagQJTR"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62941A840D
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741512979; cv=none; b=uWZu2nfgxjtm6VlA9ff2LV0do7n3K87sIT1WKOyBSQnnJ+UyqtwgIsrdbl8Quz7TfNKprx3iyfdL4YllX9sq13dBllbnTQ0Ct4CYUGGxEVl1Beu2JltjxuCIKNuX4fh4MqMF1ok8uA5lbGKHz/z5gcON228quSsUkW9f8FKyarY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741512979; c=relaxed/simple;
	bh=RVfu8DAMzXPHxXwHgpPDG4/bBTmqwuwrt/l5NUmzylc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyTnafTIJdpXCP9HigoPusrlqYe+7g2e9izftt5k9TBZ1vijIs6dbUMIPx+NgFfydd2rzxDs3SjEuiGcUHr65NcGsb4CNwfCLI4bQ07aBcJ+zaHb4ZU2/6ZKOitRMgbKJqL4X8BIrrz+ie+lD0reZ2Nwmnrxm5JacaNrCyC2qWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RMagQJTR; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso18641231fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 01:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741512975; x=1742117775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qv7t9LAWFlrZnh/h1qzmcLb/WgGltOmnbPS1Sywm160=;
        b=RMagQJTRI0VuKI6kR+3xBVVqMfQWa9rJjUQfZlWWZMTzEm0N8Y/wGNpGD+I1aeQNFZ
         o04lA0H4vIX0OHiXZ3IC8vzEcgQli+gWNEsqJd/yII7xDni0BFpXCr7HpnWHhgD2YfcV
         xOiNS2T+GrAD7u78FgXkb5Hb1j69CKz3FSk0APN5lhEQrPhKLFs+Vu9Eivq5D2JxompA
         YFTTsAV9lcKjU1cvsE46Wsy2ZbXm4oy/sJVX8ylg0E70iyGQGL3njhw1SVlkvoecm4Yd
         SFgmjYwI/ggtlpxYLeHTqeg535+3ewLV9KJJrKTTyBV/Z1ORCE8g80cm8K08S+0PHC/S
         L7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741512975; x=1742117775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qv7t9LAWFlrZnh/h1qzmcLb/WgGltOmnbPS1Sywm160=;
        b=Av5AE8BcOsMhppGK+8DvwSHrdgLoLi7DKRAPfekH+jEB30qTuEWIBOnWfWemSn6WEV
         KpiSdGHgCu2m6MUbFIx2J3bb11HuF4FswbDYwBHhK12SGhF4WWF7pZc/Klsfc258z2Cu
         xdQc4xhy32RcDkkBVBbVBXpkZd9GI6x/xssCFuwLJ4IxYJw4KozMATv32Bs9/QhMmArX
         9GfyQt1wT3KbP+Z1xjN9IsnWM+F+XQECDbKfuN1JuqPq2a3+YMkMlQkNLk5YAX/bo5QR
         HkkSK1XR8maq0jJMsnKHJkSXIMMiXqJHV4m9MFdH91mrAUdEHO01t6oizrq56AD6Jdq+
         RsCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLdp2qFxUYu4JildWQcIBQQVhA5mN/A5JPwlsBCb52mL/NL3QH3kwbYZBlvjaKaVuRlegBMlci+hURPoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8jygB07Veh5UbB2dkdgcu8HK5bViBvuwAFiq/RVwI2XwXUsXu
	oVtx/RrDT8uBpokKgXeGdCb6v/kOpJ89irVnX9IUQg+ZYMQ1qVNm6AVCgIDdE7c=
X-Gm-Gg: ASbGncui+uSQsPgzcWDejM1VNwcirXJwTIxRpkT5cWJXz62+F7Uq3+opk6j2NhndYJL
	b1DQQvDzUhYAtWZpw3p+LTVQMExrScEQYgJhJpW9a80Tu7qB7sLd7dzg4UxCBGNquOFTWY+LTgw
	wISfh+koc5amQjjOeIZjMj1YCsaYVtxgDuLDVCiW09ggBzhpnHybpi7K1cvS+1CIkdOCmWlNbtX
	+nwFa7bdIfb45iHRFJhlv4WDKZE2HJfxBLf0KXv3cC1inxdmA8XA0tiJlZ8MMhoFPz3pwBVAr9W
	yIuc8Uq98KF0uAFUVQybnYBSqpHa14VQs5OnLZteDI40vDK76aSRoP3aaI/gAZlUPygijMq877C
	CCriiEPJqZ61it71mRlHWwlrT
X-Google-Smtp-Source: AGHT+IFQyC6l+Pw1P/BVH/g0erUa7GdcnXNOr76Jgy50Rjd/lC1C4UYs/hv4IKjbXl6NI52mEWrsnw==
X-Received: by 2002:a05:651c:1541:b0:30b:d63c:ad20 with SMTP id 38308e7fff4ca-30bf45e28fbmr31911591fa.24.1741512974977;
        Sun, 09 Mar 2025 01:36:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c00e42dbfsm5573811fa.89.2025.03.09.01.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 01:36:13 -0800 (PST)
Date: Sun, 9 Mar 2025 11:36:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: David Heidelberg <david@ixit.cz>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Ivan Belokobylskiy <belokobylskij@gmail.com>
Subject: Re: [PATCH v3] ARM: dts: nexus4: Initial dts
Message-ID: <qu5w56bp5yurdgbhjpeiabn5pvpoov7xfyta5j7djnnrveak42@povbs5bddtsz>
References: <20250309-lg-nexus4-mako-v3-1-1dc2807df296@ixit.cz>
 <l4lv22oi2ktubf7aveqxqtwb7zz7cfrzdayuxxgwdj46ygubfs@qpl6ut37taoe>
 <88da307c-0403-405d-8356-c8baeb18eaba@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88da307c-0403-405d-8356-c8baeb18eaba@ixit.cz>

On Sun, Mar 09, 2025 at 10:17:29AM +0100, David Heidelberg wrote:
> Hello Dmitry!
> 
> Thank you for looking into it. See replies.
> 
> On 09/03/2025 09:33, Dmitry Baryshkov wrote:
> > On Sun, Mar 09, 2025 at 01:45:51AM +0100, David Heidelberg via B4 Relay wrote:
> > > +
> > > +&riva {
> > > +	status = "okay";
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&riva_wlan_pin_a>;
> > 
> > Where is it defined? Also pinctrl-names should come after pinctrl-N.
> 
> definition is kinda aside in qcom-apq8064-pins.dtsi .

Ack, missed it.

> 
> All other suggestions incorporated, if it's OK otherwise, let me send v2

I think this also needs several supplies in the riva device itself and
in the iris subdevice. See qcom-apq8064-sony-xperia-lagan-yuga.dts.

> 
> Thank you
> David
> 
> > 
> > > +};
> > > 
> > > ---
> > > base-commit: 0a2f889128969dab41861b6e40111aa03dc57014
> > > change-id: 20250309-lg-nexus4-mako-da0833885b26
> > > 
> > > Best regards,
> > > -- 
> > > David Heidelberg <david@ixit.cz>
> > > 
> > > 
> > 
> 
> -- 
> David Heidelberg
> 

-- 
With best wishes
Dmitry

