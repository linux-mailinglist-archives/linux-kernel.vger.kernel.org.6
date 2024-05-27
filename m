Return-Path: <linux-kernel+bounces-189931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0418CF74D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D847C281A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 01:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BC54A29;
	Mon, 27 May 2024 01:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SmPVREhX"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808CA804
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716773807; cv=none; b=iT/UB7yY6BryBOLcv7dMVaSlRtrB5xHvKtocruFTNq20wtSD3aiPiBknEx3JJUOdqd9QAlSxG8rHeovEXuMqFcMBtQlPhFRfT6wFnXkHYuOUtzLSKL/+JiMClNNZ2R2Gp+rHqRXKPN3OEwh1v5NaSEiGofwoayuQWSvosfEa11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716773807; c=relaxed/simple;
	bh=YtnlFOF0QGC/+Mg7mh1Q4ZWmoToYRaiNJ50POwvrxn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXdRiT66BYF3aBCy3ZQhdn9/GfDOg8EXt1wMotqJGsA2AhpdGdS565vSwgSuZwQ+LvHq7cqZt5Z+v08Vid+kOkx1W0p8D5UjKDrG99BB2Sle1joPecomADF0Nd+QMLIRnlNfFm0vET9YdoB6aQpM0Z7zVFfI9mZWyefMhuco3Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SmPVREhX; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e95abc7259so27354891fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 18:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716773803; x=1717378603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zo5IdJlte2J+fKtUwGqjfCwmWS6Byprw3w7YuA0KA6I=;
        b=SmPVREhXaYhbduumTFRPm76JQzycDHFj2WmKbiFtk99MNG8oE8l/QG/uASjSasFaTO
         xDbK9MdRA4U8vjOxDlg5JjKW9XqzVOy2g6XdG2oWb92pOebldr6KLYK8Y0x5LAY60sir
         v/ThySdgmGpcJ87gS9BUrLmqVgxCouM8LxcrA+y8ObivEmSUyCBDEj6FeqW1Ph+sZllP
         Mny3/tXz3rzc90snl6sU6BSIeLAeuTC2YEN0/ZjssCe5w//+YVQh/E3IFcPunBVAk4Xc
         y6W5E1sT2B5x+Bs86dlxQ1iyLzgcEhIXuQxjnYkPal3bi3WmRNqIkGVLwLRBzMc+BKgD
         0cZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716773803; x=1717378603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo5IdJlte2J+fKtUwGqjfCwmWS6Byprw3w7YuA0KA6I=;
        b=EatQm5JRjNCixWb7OwDkJZiR5SQetR2tMspWWPmKGbkRYJk49p0PIneHdD2lEMNiuW
         sv0V/zzHBd47M3h3ktx7r87jmEmyVqb0lPht5uglw/C3euwtlsf6jBIzkaRADDy9e9L2
         /21sDMRpGPAqVFMer/czrU/KFhARYM//A1nZUKtXFduMXP2xC7i0npmC5ghjd3I7Hu0I
         1QQPLHm6oDSb6lR4qz5n7WEQFHDPKy4Ubiw2M0QHL2gzUZsnwTJSChIbAnF48LHu6Wok
         pXDdhh9NaQvjeHgZVlK7aDuYhASs/jLOdpb2HQov/+8hrCrdj+SyKJ7NrbZujXzTlfp3
         yJhA==
X-Forwarded-Encrypted: i=1; AJvYcCWW5I0nFXhKZBUVSJItCCODNNUGqK/nsW+vwCLMGrJQJwJ5txc2XksOYnTQD7KvFhiZivGTL3KLZOZ54eR1RcBR2hEZMl19aQ87/B/1
X-Gm-Message-State: AOJu0YxxjMbRm+VF7AM4KFS8UgxWgnnT2Y4GWXYCvlCWP6U7ORonI6lO
	7fTQbDElD5kHHxkve3QeQHFfx83udiP6MyNO03SUsNmtCrqhIbEm80tKJumGFmQ=
X-Google-Smtp-Source: AGHT+IE1pBCviitcwNaHJGTCWOe7thf+aAwQwOphz0e6MVHW8NiQpkRko6kvQwB9S6CJ8XZ1ZN5Mgg==
X-Received: by 2002:a2e:98c8:0:b0:2e9:5ec3:a781 with SMTP id 38308e7fff4ca-2e95ec3a817mr43873311fa.47.1716773802482;
        Sun, 26 May 2024 18:36:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95be05301sm17267561fa.114.2024.05.26.18.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 18:36:41 -0700 (PDT)
Date: Mon, 27 May 2024 04:36:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Komal Bajaj <quic_kbajaj@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, quic_wcheng@quicinc.com, quic_ppratap@quicinc.com, 
	Jack Pham <quic_jackp@quicinc.com>, Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Subject: Re: [PATCH v3 0/3] Add devicetree support of USB for QDU/QRU1000
Message-ID: <zaczfygxrjlkfyrgxo4ec3kjyrbsizrfjxivt5lmz3rgxxrtxn@xyehy3eilgzu>
References: <20240502090326.21489-1-quic_kbajaj@quicinc.com>
 <CAA8EJprPLqj7GQM0vmN25U2+3kDow=NH8=-VC2N-0p92Ub3iCA@mail.gmail.com>
 <km2c2tkd5j3vedrmttpn4nydqpfhhz4bwgtzmngwbok4vic6q6@nshjtqcqmklm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <km2c2tkd5j3vedrmttpn4nydqpfhhz4bwgtzmngwbok4vic6q6@nshjtqcqmklm>

On Sun, May 26, 2024 at 07:28:42PM -0500, Bjorn Andersson wrote:
> On Thu, May 02, 2024 at 12:09:41PM GMT, Dmitry Baryshkov wrote:
> > On Thu, 2 May 2024 at 12:04, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
> > >
> > > This series adds devicetree nodes to support interconnects and usb for qdu/qru1000.
> > > This is based on previously sent driver series[1].
> > >
> > > ------
> > > Changes in v3:
> > > * As per comments on upstream[2], to get role-switch working on QDU/QRU1000, it was recommended to
> > >   use the actual TI switch driver. Since driver doesn't have the functionality to provide role-switch
> > >   based on gpio, thus reverting back USB dr_mode to peripheral and removed the remote end-point nodes
> > >   and usb-conn-gpio based role switch functionality.
> > 
> > This is not correct. The recommendation was to describe hardware properly.
> > Which means adding schema description, adding  ti,your-switch
> > compatible to the usb-conn-gpio.c driver, etc.
> > 
> 
> In addition to wrangling the ti,switch implementation (and binding) into
> something that only deals with the gpios and not actually talks to the
> chip, this would also require us to add support for fishing out
> vbus-supply of the connector and control that from said driver (or from
> dwc3, or from dwc3-qcom...).
> 
> Given that I find it acceptable to pick up the peripheral-only support
> as presented...

If there will be a followup, I tend to agree here.

For the series:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Regards,
> Bjorn
> 
> > > * Link to v2: https://lore.kernel.org/linux-arm-msm/20240319091020.15137-1-quic_kbajaj@quicinc.com/
> > >
> > > Changes in v2:
> > > * Changes qmpphy node name
> > > * Changes dr_mode to otg and added USB-B port USB role switch
> > > * Dropped maximum-speed property from usb dwc3 node
> > > * Link to v1: https://lore.kernel.org/linux-arm-msm/20240311120859.18489-1-quic_kbajaj@quicinc.com/
> > >
> > > [1] https://lore.kernel.org/linux-arm-msm/20240502082017.13777-1-quic_kbajaj@quicinc.com/
> > > [2] https://lore.kernel.org/all/CAA8EJppNZrLzT=vGS0NXnKJT_wL+bMB9jFhJ9K7b7FPgFQbcig@mail.gmail.com/
> > > ------
> > >
> > > Komal Bajaj (3):
> > >   arm64: dts: qcom: qdu1000: Add USB3 and PHY support
> > >   arm64: dts: qcom: qdu1000-idp: enable USB nodes
> > >   arm64: dts: qcom: qru1000-idp: enable USB nodes
> > >
> > >  arch/arm64/boot/dts/qcom/qdu1000-idp.dts |  23 +++++
> > >  arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 120 +++++++++++++++++++++++
> > >  arch/arm64/boot/dts/qcom/qru1000-idp.dts |  23 +++++
> > >  3 files changed, 166 insertions(+)
> > >
> > > --
> > > 2.42.0
> > >
> > >
> > 
> > 
> > -- 
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

