Return-Path: <linux-kernel+bounces-327569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3FD9777CC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744752873C5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AC51D31B8;
	Fri, 13 Sep 2024 04:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSnzqgFm"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5E78B4E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 04:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726201046; cv=none; b=H26DGIVrFxlfWw/sgS7Qw3avwoKVPcuw0ZKCQCuN/XkOgzHr9y78a1koN200DZ2QQqqgiTIUJO74k6QPTHnleW+2QPanGyckDXfTseJ5jMAnGTljLZHI7dt8zEiMpEGdk1n3b1k3G8d3BXHuzRR3sM2ATUnm3A7/9l3N1mgKs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726201046; c=relaxed/simple;
	bh=aM2JA62bwsTf/mFEE3ERvJ911Rrl9INEVCFzTU5RMo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flCR9Mi8Nkl+HZAUp+pkFxfBOb2O9BMg3IQ9WLJb4IQO+uK9GXOLU9+xONRp5HlKgw0dJdgfGJlFOTtVcHQYPE5UjC6/vqibCwjlRQfpj+SoUALRTNXpitNxV6BQvl2CqPjlNqYy7DK8mW6V5Lih9Al6zdtt/+s37vt5dhTYYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SSnzqgFm; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53661a131b4so680366e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 21:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726201043; x=1726805843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2VLJt3GjYxxx/2ULy4tfS3vYUKWoTa4Wu7pIKq+KoC4=;
        b=SSnzqgFmY1va/31dRWURYlmGkqGQRCWGYAXRGEvuIc2EX4t9Vfs9jZFhtIGzuy2KhB
         uzFBgL1syNQspQhfExJjxGaO2pkVLciT8A3rROyY789M6kgK7JP7m6EVXJhh3PTkrpcC
         F9ASGyCfRv9JinfsRzijssph9vbaxit+SXC4oocML2AqZWYLWJFZUd2TDsoaNRxguPPs
         kY/5smtnNl87zknpp3DJuiY9g+H+FgY0TUE+baY6uYCMf8XyXBItCmNwCcWVyJ1b28Z8
         LVO5zhsvFCtUPql0IwWtUfJTlzYMMA45/rfJ4ZC/eR2y21Ev9BbAdSkOseZz/T4GcNZx
         M2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726201043; x=1726805843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VLJt3GjYxxx/2ULy4tfS3vYUKWoTa4Wu7pIKq+KoC4=;
        b=joJWyvJcFonw6S9/+TRhAcg3d0mtR+J6weMW7GhICZ6oXR2d3Il6opP+ft2TKkIOPd
         PFLS6ylRMxBUlJYLRexfaKPVBLEQtQEDD1ee/NR1xOtdSSUfq9q8D9sD+mwZ6Cs7kXpS
         0TSXiZrQh90hvwbGR8LzKhu1kM8LfVWBXp/3lKbNRNjeGy755KZsNpgaOrheCV/FOL/Q
         sGZyqNo1nw67uxezdQtvgyoUspSZIq+6gBhVf5lffNFcQbm0bpE08OCFrEtIgJS8R2uC
         0pziuz4YDRdYc4SyCh66+33NUpolNTiZrfA2w4DVBa7mKbT2TYj2wH7Vyx+geeT18Ctk
         gd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5DgqlJeUAQFQ029zL/CxOkBAk1iSof36LVfmlA2TfWnF8bbN9hWr0rqAxQvAT5Wg7dqxFI7pj8GS05NA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1WU1vsqiwYkVF7SzSmTuqUZwjilY9bKC9bZvT5NIfVX8ZTvSd
	I09bukfXgiaTjhXj22uDJCS+bOFZ5Zx+UzIG33tClCXJkKfm5y1O1ZTOqoRZe8s=
X-Google-Smtp-Source: AGHT+IGH8yA1KtIzAhW/xFxsftx+1xAYzqN5yLnfjaIyj9mrJlEqDozfPTmDUZXzB01URaqg+7Cziw==
X-Received: by 2002:a05:6512:10d2:b0:535:d4e9:28ca with SMTP id 2adb3069b0e04-5367ff33836mr839053e87.55.1726201041834;
        Thu, 12 Sep 2024 21:17:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f90404fsm2106513e87.234.2024.09.12.21.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 21:17:21 -0700 (PDT)
Date: Fri, 13 Sep 2024 07:17:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org, todor.too@gmail.com, mchehab@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com, 
	Yongsheng Li <quic_yon@quicinc.com>
Subject: Re: [PATCH 07/13] dt-bindings: media: camss: Add qcom,sm8550-camss
 binding
Message-ID: <laoud3fhqgrcnkbwasij3vrpvz5pqphcslrb3kka6zshiqqlkz@pqt2iotmnz7m>
References: <20240812144131.369378-1-quic_depengs@quicinc.com>
 <20240812144131.369378-8-quic_depengs@quicinc.com>
 <b1b4a866-fa64-4844-a49b-dfdcfca536df@linaro.org>
 <82dd61ab-83c0-4f9c-a2ee-e00473f4ff23@linaro.org>
 <da60cf71-13a4-465d-a0ee-ca2ad3775262@linaro.org>
 <97e4f888-1ed7-4d82-b972-3e0b95610198@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97e4f888-1ed7-4d82-b972-3e0b95610198@linaro.org>

On Thu, Sep 12, 2024 at 04:11:58PM GMT, Bryan O'Donoghue wrote:
> On 12/09/2024 13:44, Vladimir Zapolskiy wrote:
> > > csiphy0
> > > 
> > > vdda-phy-supply = <&vreg_l2c_0p9>;
> > > vdda-pll-supply = <&vreg_l1c_1p2>;
> > > 
> > > This is also the case for csiphy 1/2/4
> > > 
> > > So, I _don't_ believe this is work we need to do, since its the same
> > > regulator for each PHY.
> > 
> > This is board specific, and even if the separation is not needed on the
> > boards
> > you have just checked, still it may be needed on some boards, which are
> > not yet
> > checked/not yet known.
> 
> There is a Power Grid Analysis document which specifies these rails @ the
> SoC level and assumes you've used the Qcom PMIC to power, moreover the PGA
> re-uses the same regulator over and over again.
> 
> You _could_ provide that power from your own PMIC which provides the same
> voltage range as the Qcom PMIC you haven't used. Even if you did provide
> that from your own PMIC you'd have to provide _separate_ rails for the
> various CSIPHYs before it would be required to have a per PHY rail
> requirement on this SoC.
> 
> Are people really powering these SoCs with their own PMICs ?
> No probably not.

Yes, they are.

-- 
With best wishes
Dmitry

