Return-Path: <linux-kernel+bounces-336073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C380297EECD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A02E1F21D86
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9384219E96A;
	Mon, 23 Sep 2024 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SD3L9b6Z"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711A61FC8
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107403; cv=none; b=RiqwVsTGCyW6wDIlLoyFIT0Sv8nwUod8+61/5e0afOHl6XpsOP+6wZZ7HYR5iT1XNU44Nytua9fJ81wNGhiZ67PyTHD8CD/ZPyQ9fxMT43SvhLoCN+qIi6+xGk/ujqHf6CLRMb9aZTmmh7v8Jg3v8N8yxKSmN1htI7lPj8BG864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107403; c=relaxed/simple;
	bh=QWyOxzMozsVzk92zGB+9ZHVcsZYCCvPloU+QuPQ+5TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pt03fy9fSbE2Q9M8D8JLEuQ/E6eroDQrx1kKANQVb+ellYzqk/r48nx+kYcyC/ARbW9Hpou0j2r667JTQ+OychlxaZQHKVO/Kq0POy0xZF7KPdwlw34uKnRQ9QDJ/xfmYVyIxHzwEd8A/HoOgreCZSiMxCJs+NHis7yN5wCUwz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SD3L9b6Z; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6dffe3fe4fcso21644037b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727107400; x=1727712200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nFSAZfeQOGgqlvh/cZp+dUBXOJn+NGV/+N6DxfYRjUA=;
        b=SD3L9b6ZtaFmoTTmBc/53nOmrOx9QHeAO5bq/Wov0Hxn8QgZ3tr5o4zKTjj4CGXyUC
         FCwl7kGclD2Y4iU/UIclMDPeVmaw7jB0SnStmXgPILtaG59tMgnZDI3GIx7WiZpIx6bR
         oX6gk0myBkVJnruKEwmN2NbaTXBTgGz/O3dTedgp+BiGUswt9PRUYFwU0Oa5zaAsTAer
         sIK9LK9e7VRVQn6vxzivLibjzVb5gwoUQSnVoYl+SRbXQ74dzRixkkmZp1l/d9jx6TcZ
         748RjWDYXh5QmCVbIWWUm32BB2l1sO+E4eeplIDc4BDsQU6KPVgWnAV3v+EdX5O/jn1p
         j56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107400; x=1727712200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFSAZfeQOGgqlvh/cZp+dUBXOJn+NGV/+N6DxfYRjUA=;
        b=jUaIPv1a/zVLNsypEiwTozS4ZrT0SbuFO8Ig7IGPqqSm9T9fzssgHXarqyxqK3nL9o
         v42cjgkcJ9cgiQf8y4lTZJdDogDFAkE6Tr/D2K4hI1/uBpJcIjr6s3PoWB1qj9LEwoZo
         pnPEkPMhlZ0atSvDPcT9fhe+QAU+1X2SCmc1cm/nKwCu7pVeTsXeopHWzjKpF/KtXsmm
         QJydjv7lj61rGoYBEg9E8twbj3kB8usTG85jIMs4fGCoYC8XyrJuBXsxNXLsuYYSFi+G
         L/J/Htm1RtTA57WRH7P43/pZqQ3iaL+lSg0HnUuE35r+tKKnAnkGKaQz34u8joDzcMQd
         wtOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcEVltQkXNYv21NSOC8QHJ2xE9ISEpW0FSyy5yzD5mJKVr+W20SdyoujfxYuU6d19g5MOtMLC8tvIINrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkI07VJ9ExEg24mmJNLAMTuolbQLyDY9BrGbnguToIb5MOZyrm
	OMgyN9gBcUA1YLfR0qLEjPDGVECHQzoYTncRsCCGHIJQT4yXG0o6nrGNKKLJ2ybYjPjFoH749Ep
	tlpymz2n6gZOl7Yder9EZTsjn1XcfxjvdHhlx+Q==
X-Google-Smtp-Source: AGHT+IFPrXfy+6PpqRhQO2rorgn9zoN0ubR6Sl/agGP8MDcDCIz/xVdzmgZbfESiw8xxQL1DsfBUmp+TRap8Xf4vQ0M=
X-Received: by 2002:a05:690c:64c6:b0:6db:cd3c:2273 with SMTP id
 00721157ae682-6dfeed8eb83mr106089997b3.24.1727107400252; Mon, 23 Sep 2024
 09:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-x1e80100-ps8830-v1-0-bcc4790b1d45@linaro.org>
 <20240829-x1e80100-ps8830-v1-2-bcc4790b1d45@linaro.org> <Zta6cBq881Ju7r7H@hovoldconsulting.com>
 <Zthet0QqChgGWJAe@hovoldconsulting.com> <ZvGMCTPqBR0VuHd3@linaro.org>
In-Reply-To: <ZvGMCTPqBR0VuHd3@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 23 Sep 2024 18:03:09 +0200
Message-ID: <CAA8EJpqq9ROYyTnwPwj+mX2T_422vcmcyzPta+QPL53EgtJ6vg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] usb: typec: Add support for Parade PS8830 Type-C Retimer
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 17:41, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 24-09-04 15:20:55, Johan Hovold wrote:
> > On Tue, Sep 03, 2024 at 09:27:45AM +0200, Johan Hovold wrote:
> > > On Thu, Aug 29, 2024 at 09:44:26PM +0300, Abel Vesa wrote:
> > > > The Parade PS8830 is a Type-C muti-protocol retimer controlled over I2C.
> > > > It provides both altmode and orientation handling.
> > > >
> > > > Add a driver with support for the following modes:
> > > >  - DP 4lanes
> > > >  - USB3
> > > >  - DP 2lanes + USB3
> > > >
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> >
> > > > + retimer->supplies[0].supply = "vdd33";
> > > > + retimer->supplies[1].supply = "vdd18";
> > > > + retimer->supplies[2].supply = "vdd15";
> > >
> > > vdd115?
> > >
> > > > + retimer->supplies[3].supply = "vcc";
> >
> > I took a look at the schematics and it seems like all but one of the
> > above supply names are wrong and that some are missing. "vcc" also does
> > not exist in either the binding or dt patches you sent separately.
> >
> > From what I can tell the supplies are:
> >
> >       vdd             1.15 V
> >       vdd33           3.3 V
> >       vdd33_cap       3.3 V
> >       vddat           1.15 V
> >       vddar           1.15 V
> >       vddio           1.8 V
>
> The schematics seem to suggest that vdd, vddat and vddar are all
> supplied by the 1.15V supply. As for the vdd33 and vdd33_cap, their
> seem to be supplied by the 3.3V supply.

Please follow the datasheet when naming the supplies. Some of them
might be supplied by a single rail, but that might be a property of
your platform.

>
> >
> > Also, have you checked that there are no ordering constraints between
> > the supplies?
>
> The documentation seems to suggest that there are some timing as well as
> ordering contrains, yes. I can't tell for sure if that is really needed
> or not.

Again, please follow the datasheet.

>
> Thanks for reviewing.
>
> >
> > Johan
> >
>
> Abel



-- 
With best wishes
Dmitry

