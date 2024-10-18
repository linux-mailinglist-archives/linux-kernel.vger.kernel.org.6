Return-Path: <linux-kernel+bounces-371518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A5B9A3C34
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A85282C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFCB2022DC;
	Fri, 18 Oct 2024 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wlpu/tI8"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5214B201026
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248720; cv=none; b=fMobwaVPX1+Er2cxsPqOpXPk3GDuaFhNmVfUJBTmCcHZfTFy3/nGs3l56lF43BdgUzFivKRmBIGNwXVzkoV2FMmbuvualslUb5hEnjyhbc8IuVnqEyVWBmDVT6GrVTm2CT0kFGxnZOrquxHR3oTqGFwRYCL76bYor8EG6EkPkcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248720; c=relaxed/simple;
	bh=13RJL78aQDntwPZ4PtUlARuj1xajjStPJh26trgJ86Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wa7xZPrgqbQ3jBYiahs7BOKcHexmLZpZ6h+GxqVzRgNP2AgkrKx/tEps07XeL9oEX2H26AhTCVXmEMXT+HzXuo3QaCXMOla3EyW0eUZvOeSRPLGEw6qABE8ohY8pMWazKcYmJQlrZC2AZCKUs/ZHTtNzISyWVKjVu4VvCWZWDYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wlpu/tI8; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so20269041fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729248716; x=1729853516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E4mQ6eh72Pp3VjxoRxuIsZprFLvY0i0ybat0S6qmaPc=;
        b=Wlpu/tI8AbReFGXG15UbdIxZLYiCgGqIwDTRfUMG0PNA3Ww0VbdZDwuqsqpWaPeh85
         pMK4CBJYBgP/GNbYFyIbRQcSic1wKbQckjQlX/USMzFYafZL80GEbY+9D/iy47MnQmla
         LVmSOJASKGVOq5loY8sefnX4/eosyuYHluOkF1NBc6JJOc1cUgyhL5h3Gqk9OiBjLMit
         bMx3eV0t7c4+NbhPiwdolJSQmcrpJOBZC2XlLgDCLDMEnG4r3F3bFT4ohbyPvTBk0ve2
         5aK04QaKEfURMDqT+pkEFhzhWA/uKH38+UOj6Mm+cXDJSTqV1955C8XeI+wQo2Iy3Qgd
         cGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248716; x=1729853516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4mQ6eh72Pp3VjxoRxuIsZprFLvY0i0ybat0S6qmaPc=;
        b=AIWdG4hB9ewNUyw0FDntLOEyfvpESiNqxEgfi5pDTiWqFVoveR23BOE+MskqYrewZX
         YJxy/D8HNeFapSh5oxfgDjOnkHbG8jJXm/zNuC9QzFVL6Ad532rEyjiLEerYIcnJCBK/
         TUE1UKo+AzPdQFcQ0fTpP/bLGeGKgEiMJmZx9h26nPj3gfHn+/yBrTFSRJjVamkDaOmy
         S+4yB95JTO4cVsD7rkzhM9ICWG7qyUSXQY1Zo9CWc6WPjlmqqfVawM0z11FDlZ9eloQe
         uJlGIq5ixcPSPxShRExTQSqHJT2is6SW1IXyS4tqx0Mj2QE4pzD0Vnctjh2bQTC8FCBN
         mXow==
X-Forwarded-Encrypted: i=1; AJvYcCXIgTKhlBdkUk/4GsaZCCvjfgt6qI2ZuPiAcbi/jtBVsDe9yHcVnZ9ePG4TzFuw94g1mZZ67WsS8/G8Xmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvEvfmCJBXbUAHG2G0BAOxMcRE0XNd8fbeCzxKiHR3oRuwazGg
	nNg3rfxCIOYisoPqA7GFN0Z6hWG4pO/RTcLQqQjoo7w+v7POcK/eGgjwmUU2zxE=
X-Google-Smtp-Source: AGHT+IECcngN0+7c78hOzshVlovF6OLXcd+ee0flemVjcZCCn6f3Yr8ycO5q+1WZZwd4Q6yeAMfmQw==
X-Received: by 2002:a05:651c:1543:b0:2fb:30d5:669a with SMTP id 38308e7fff4ca-2fb82da59camr8775201fa.0.1729248716388;
        Fri, 18 Oct 2024 03:51:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb80a235d6sm1856161fa.129.2024.10.18.03.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:51:55 -0700 (PDT)
Date: Fri, 18 Oct 2024 13:51:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Shivnandan Kumar <quic_kshivnan@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: qcom,cpucp-mbox: Add sc7280
 cpucp mailbox instance
Message-ID: <mxc6jsm5k3l5jc3txmltchja2yn6e7vmwo5i6bw5l5jcj6lzoo@tcb5f5qgqxz3>
References: <20240924050941.1251485-1-quic_kshivnan@quicinc.com>
 <20240924050941.1251485-2-quic_kshivnan@quicinc.com>
 <20240924232526.GA563039-robh@kernel.org>
 <2d4e47fd-0aaf-4533-a96f-95ada853d9a0@quicinc.com>
 <kzlhhovfffvg227oxbpl3nv6q2lyn53pz2fyqis22brkd4bkkz@vqprudcdfunb>
 <7bf56716-886d-4e2c-9a90-e31b0bfa4a89@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf56716-886d-4e2c-9a90-e31b0bfa4a89@quicinc.com>

On Thu, Oct 17, 2024 at 10:48:32AM +0530, Shivnandan Kumar wrote:
> Thanks Dmitry for reviewing the patch
> 
> On 10/6/2024 10:41 PM, Dmitry Baryshkov wrote:
> > On Thu, Oct 03, 2024 at 11:13:02AM GMT, Shivnandan Kumar wrote:
> > > thanks Rob for reviewing this patch.
> > > 
> > > 
> > > On 9/25/2024 4:55 AM, Rob Herring wrote:
> > > > On Tue, Sep 24, 2024 at 10:39:39AM +0530, Shivnandan Kumar wrote:
> > > > > sc7280 has a cpucp mailbox. Document them.
> > > > 
> > > > And is different from the existing device how?
> > > 
> > > It is different with respect to the register placement.
> > 
> > Register placement in the global map or the internal register structure?
> 
> the register placement varies both internally and globally as well.

Please mention in the commit message that internal regiter map is
different.

> 
> > 
> > > 
> > > Thanks,
> > > Shivnandan
> > > 
> > > > 
> > > > > 
> > > > > Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> > > > > ---
> > > > >    .../devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml         | 5 +++--
> > > > >    1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
> > > > > index f7342d04beec..4a7ea072a3c1 100644
> > > > > --- a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
> > > > > +++ b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
> > > > > @@ -15,8 +15,9 @@ description:
> > > > > 
> > > > >    properties:
> > > > >      compatible:
> > > > > -    items:
> > > > > -      - const: qcom,x1e80100-cpucp-mbox
> > > > > +    enum:
> > > > > +      - qcom,x1e80100-cpucp-mbox
> > > > > +      - qcom,sc7280-cpucp-mbox
> > > > > 
> > > > >      reg:
> > > > >        items:
> > > > > --
> > > > > 2.25.1
> > > > > 
> > 

-- 
With best wishes
Dmitry

