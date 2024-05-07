Return-Path: <linux-kernel+bounces-171230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701388BE174
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0ABA1C22091
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B633158A31;
	Tue,  7 May 2024 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eiiT/8ah"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850A215747E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082958; cv=none; b=RfALbQlevwJiiY41+Mit0CIhnywEoSwkwL1J1wCIEbZp79k/WO2UCAbG8hu043RA8w17B44q2VgdFo5fLTcxGkvml+WnFoeksZp6awQhbqtrJfkUw3GEPqtU6ao+xC4/YVBYKOngBFirN6Ic5Kj+mICw5pFpZ+arsxKBG3wXO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082958; c=relaxed/simple;
	bh=UEi9x9olAWyIw4Y3dEkosSNpqBSK5ax3cAPFMnIeVYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4vyaSuOzDALYeF4Gk5YjV4kCVEaCOn1le+fEOt7+Hpb7fJYtEtDP7LVChCE9XrdlSX33URg7THbDhthKEOPv95MrmOOlOp6qGS/am+TpWJSWqyXI1ORoqgGPZz9u5qVsWsVsl2mdWO9fpBRY6CvkZYKkbyWjpVNT1DNZzjgkXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eiiT/8ah; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so2922337276.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 04:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715082956; x=1715687756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+pGkFUViosNbBwj85G0vrmVhdnEjrRiE3lfdvk1nPvw=;
        b=eiiT/8ahvrwt0g2otN4xst5wYFMpA5tOeZMIZ0FKC61oJ7g2px+6HG3Bs6n5YI32Cr
         UtdNvCiXTX1aXrCLo5/rhwd9Pi+5jB/w+Gjc8p07s81Eyl3Wo7uPYGO/gc9vlr5ZRyaX
         dxK92IkA8hMeYqwlmjoNliLkgI0qggJFLOiJ1L3e4+sSz9S8knvekTli/1KQm0krRUZd
         vArTDDJwqnbr/MjcLzryEHJb6tQFcHdAGMp/fjW+uwqeMJXVOkjJ7PoEk4ITn01HpdhG
         uy4EKh0OY0Evm9126SUuxzLlrIZu8OE8z+We7rjHY0Is3ZqIuLrNiNKfZW4dcnYFWnd1
         WVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715082956; x=1715687756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pGkFUViosNbBwj85G0vrmVhdnEjrRiE3lfdvk1nPvw=;
        b=Q1SFG5XI1XWZ2Y+qr12qR+bFubNy/5BUJiPLSfUPVqOoOkAjL4IqHbXAp3QAhYziGh
         z/JQhNPQFlPu44VWAhqdNMCbDho9XK7P4x6r039l1cbWGNH0GuFxuN78LXq6CA5peabK
         TlEI+BXZyRs4XTnzCYOngUG0W63nQrKPJx9iflZb5ZVBJBnMT5PenotbUaDu2TMp8nk3
         XgofwE/J1umMHp92GWZn1IZI0IXuNJeId6xz7N+IEIvvQcdYr43/ywYN/1eOBeu4IPB4
         diUdU0LeEB/k0WgHZ/TRjEaiH+2dhdHDVNHdEPFNIT3i0RNo97akY8GmLPMr3Du/knAx
         AFgw==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZWUZNucxaW4bwh9sSK3VdSTmfji2mcOXDcC0EAb06kE/ikDxPtGnIPliVOb8HMhYjTuunLI1V8rOEpUS1TLdjbSVQrnl2Vj4/Oyn
X-Gm-Message-State: AOJu0YwBjciJmEcy1UcnyK+qPciXiQaGqpxU+z285gHCtRS94t7wugc3
	ZF3FKtp2gvHPoEbp0/ivQN5MEa7k1kpihJ6ji5Bf53Weaj9vogO645Q2E7gxv2u4sfDDJcXZ0Qq
	HnHqzS3DnjtW4dEC346fC7i1uMIIa4bzMozgZTQ==
X-Google-Smtp-Source: AGHT+IFjjy/JkHojT8EtUSY1sz+DG0YV+wEmy+k/TPQ1lX5kK3s31xaoFvKEbuasOExcuTi6OPxZ9GDQ6NlEAbyEDBY=
X-Received: by 2002:a25:f621:0:b0:dd1:3cc1:5352 with SMTP id
 t33-20020a25f621000000b00dd13cc15352mr11210499ybd.15.1715082956486; Tue, 07
 May 2024 04:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502123312.31083-1-quic_ugoswami@quicinc.com>
 <CAA8EJppeQTadmny=hcs4xCQDXHwXEBHXjeecvZCUVcSXmwBTgg@mail.gmail.com> <90a5b641-af5b-4640-b2ad-85dbbab523bf@linaro.org>
In-Reply-To: <90a5b641-af5b-4640-b2ad-85dbbab523bf@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 7 May 2024 14:55:45 +0300
Message-ID: <CAA8EJpoWWXvJabcVqp+YSa8arQbLPC=v+XkvPZe6nwH7aaKnfQ@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom-snps-femto-v2: Add load and voltage setting for
 LDO's used
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Udipto Goswami <quic_ugoswami@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 14:43, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 5/2/24 15:12, Dmitry Baryshkov wrote:
> > On Thu, 2 May 2024 at 15:33, Udipto Goswami <quic_ugoswami@quicinc.com> wrote:
> >>
> >> The Femto phy depends on 0.88/ 1.8/ 3.3V regulators for its operation.
> >> If one of the regulators is not voted to the required minimum voltage
> >> for phy to operate, then High speed mode of operation will fail.
> >>
> >> On certain targets like (qcm6490_rb3gen2) where the minimum voltage
> >> of the regulator is lower than the operating voltage of the phy.
> >> If not voted properly, the phy supply would be limited to the min value
> >> of the LDO thereby rendering the phy non-operational.
> >>
> >> The current implementation of the regulators in the Femto PHY is not
> >> setting the load and voltage for each LDO. The appropriate voltages and
> >> loads required for the PHY to operate should be set.
> >
> > Please move min/max voltages to the DTS. There is no need to set them
> > from the driver.
> >
> > Also, is there any reason why you can't use `regulator-initial-mode =
> > <RPMH_REGULATOR_MODE_HPM>;` like other boards do?
>
> The point is to aggregate the values and switch to HPM if a threshold is
> crossed (or stay in LPM otherwise)

I see that other boards use regulator-initial-mode for the USB PHY
regulators. Are we going to change all of them too?
Also note, that while the combo QMP driver sets the loads, the pure
USB QMP PHY driver doesn't set the loads. This way we can end up with
the undervolted PHY.

-- 
With best wishes
Dmitry

