Return-Path: <linux-kernel+bounces-380577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE409AF2D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DD7282A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9599218B468;
	Thu, 24 Oct 2024 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tm6bl7ev"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078F21CF96
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799216; cv=none; b=B8SucOH3FT4L1U3OQ3fKMV6ZZCNB9SdpYU8AlmjkR7L/oR/AsTE2pz2CTlpuCPHM4fCmavLk+8/pSVx7s2uCNtcE245emDCAh/hCyn36sNipCCgk6QyZxgjPh220OQCpZHdImMttqMW2dhgfiGhBShNLJeWF0bzd65bWq0ewGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799216; c=relaxed/simple;
	bh=+xhS0Xv1G/J6e7Ktie/2UvMbOotjS6zFaMns8T9MYS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqKvf2/zkDlwg8K76hPvBgTWwuj+mWZ6ZujRJVtuaXtgw+ecTCXYMutkY41fH+Emtrgmhf2OH6RZg8KBzEDv9mGjE5PJMF3WFlgvR9tg7rUehKtM4kPu+nGbBR14FeOco9LfTPf7aFUb67YFzBrMV/UtrVx9joppHSEYNDePvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tm6bl7ev; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53a007743e7so1629046e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729799212; x=1730404012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PI3SXZp7iH9LDmA0MnQOo/8B2Evm9XupATLCcVNXC40=;
        b=Tm6bl7ev4IwJjSCp2ygl4V8Zotp5Bs05ryL7FprVCWutNWWc8rQTCCI9mvf1z9WqCd
         TsyV9vA5qrNLmrOlOmyKKh56yS2PecmbgMJ3zOCqJXev9UTG3L//88WGJ2VYz2DmVtV2
         SaVktlU3WgluN68OL8y+G+fkxgT46UlzVrAwzXxSQOPgfifOFGYZ8eO7kQHAYNE1PKA3
         4/3Q++X2ph2ht92nR0VR0TphvwZLVfoYQZ32C4gt1Q68wtHC9008u4C1blrhj3YzzPnZ
         ytG/T7JRgbK3BhTvel5KOhvpIZVzsqt4Akv8qPjxoLH+rc8Fm/3lMINdz6T5JpIyGqgo
         JVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729799212; x=1730404012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PI3SXZp7iH9LDmA0MnQOo/8B2Evm9XupATLCcVNXC40=;
        b=SdN3x4QTH6CjIE23G70RCOj2RToCg7EZiwBwHJIg4b1Hwx+M48NAFOGq7lpk2g8Vdb
         h40SJkPuOVSpUiWFb0xBK6PZwqQOl5kWHTm59oFaTh7B0ikdjuwG+tdhqDZvBGSWqroz
         z+fyEWLaKQOV6baN1XtINO/+Yn1bJ1qSUSHwU7bwD3A4GEy8Ws8aQB9oFDLpQzWjjZsV
         F4MX24LOqHmB0Lw/coSgHbcde6clm9Z7VOkxgxpE+AnDASRhYtzwB7Hey1EskPPWgIn4
         cakjc3QzQIpNjWAueCm44LUhXFWHFOdhWe8zHA6k/XnJ8KEIuKr88nTFMtqGGtU2SH1m
         ++gw==
X-Forwarded-Encrypted: i=1; AJvYcCUoFs3ROuVBPkRmMouatEqIMJkvwtE6XvzKXu7OzAfFHV3B78rZu5uWIhBttYJYjc0OJ2vSdsGoRMVxkv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+q1TbdOVMX5JE2ko2pW378Yu5KA9pzuf+ICQ9WHFKtPFsevM
	MTeXWun4tz/pMDzDLc62yr1XCiM+8mSZ2JFzeHUCpRtwlxepxMOOGmSOVBCPHvU=
X-Google-Smtp-Source: AGHT+IETETXmy3bVlftYj31VETRjI/RZSZyaUXBUvtgU+pcTALquMjFnjAZo0xxjEwQVBqO3LLhmzw==
X-Received: by 2002:a05:6512:b99:b0:539:f37f:bef2 with SMTP id 2adb3069b0e04-53b1a31f29dmr4081545e87.17.1729799212192;
        Thu, 24 Oct 2024 12:46:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a224319b3sm1453550e87.210.2024.10.24.12.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:46:50 -0700 (PDT)
Date: Thu, 24 Oct 2024 22:46:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com, 
	cristian.marussi@arm.com, andersson@kernel.org, konrad.dybcio@linaro.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org, 
	arm-scmi@vger.kernel.org
Subject: Re: [PATCH V4 1/5] dt-bindings: firmware: Document bindings for QCOM
 SCMI Generic Extension
Message-ID: <hc66u4jtl3ncjssmfmkzzxel4bkf74s5srml4ovrm3lrds2mvx@zsb4rfd637dp>
References: <20241007061023.1978380-1-quic_sibis@quicinc.com>
 <20241007061023.1978380-2-quic_sibis@quicinc.com>
 <q2vuiru7sqetwqyitg7azgqg7kge622i2zgq52b55zivwtbev4@4qgzb54xjioq>
 <hxfg6ztpqy7qdsgzhvvapeyh2f55mj7hhuqqkz7si6g5i7nsng@xoyfwztk66aj>
 <3765cf3d-8477-45a7-af0e-b0c78f41eaad@kernel.org>
 <0b297305-0141-208a-e414-fb7dc98317b9@quicinc.com>
 <170597c7-b8aa-4744-a44d-db5585545704@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170597c7-b8aa-4744-a44d-db5585545704@kernel.org>

On Thu, Oct 24, 2024 at 03:29:05PM +0200, Krzysztof Kozlowski wrote:
> On 22/10/2024 09:25, Sibi Sankar wrote:
> > 
> > 
> > On 10/8/24 17:41, Krzysztof Kozlowski wrote:
> >> On 08/10/2024 14:10, Dmitry Baryshkov wrote:
> >>> On Tue, Oct 08, 2024 at 08:49:27AM GMT, Krzysztof Kozlowski wrote:
> >>>> On Mon, Oct 07, 2024 at 11:40:19AM +0530, Sibi Sankar wrote:
> >>>>> +/*
> >>>>> + * QCOM_MEM_TYPE_DDR_QOS supports the following states.
> >>>>> + *
> >>>>> + * %QCOM_DDR_LEVEL_AUTO:	DDR operates with LPM enabled
> >>>>> + * %QCOM_DDR_LEVEL_PERF:	DDR operates with LPM disabled
> >>>>> + */
> >>>>> +#define QCOM_DDR_LEVEL_AUTO	0x0
> >>>>> +#define QCOM_DDR_LEVEL_PERF	0x1
> >>>>
> >>>> I could not find any driver using these. Can you point me to usage in
> >>>> the drivers?
> >>>
> >>> It's well hidden. These are the raw values used for DDR_QOS memory.
> >>
> >> So not a binding? Then these should be dropped.
> > 
> > I am not sure why the term "well hidden" was even considered :(
> > The driver just reads them from dt and passes them along. If you
> > want the dt to list magic numbers 0/1 instead I can do that as well.
> > 
> 
> If these are used by FW, then it's fine, although please document it
> clearly in comment.

If they are used by FW but they are common between all platforms, it
should go to the driver instead of being stuffed into DT.


-- 
With best wishes
Dmitry

