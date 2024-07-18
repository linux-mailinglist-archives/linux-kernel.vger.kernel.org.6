Return-Path: <linux-kernel+bounces-256384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27FB934D62
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4BAB23450
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7A613C83C;
	Thu, 18 Jul 2024 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSpR1CVz"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCCC12EBE7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721306760; cv=none; b=M3RINP1+vPe6WBtNXEk4yHunDyrp7ztmIvYthWGXb62rJA5UoO8BB+vIqeh+Zj7049PdYBjL7Qg1mIdw2ICdGiBTn1jmxYtIkfWdb/ZLboawN1HEI8SZwa+C5mV4shHr3y6/M0QpidnH+3mqtGcpwZx3ogNrIuBkFCr4v3BwqcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721306760; c=relaxed/simple;
	bh=9EkC4Y5reZOqGEwXo/XAYzvN7EsXW/1Qn73Ue5CWPCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpH63s0l6Zvoa3WcBM6NpeJX93W/ygVBpPR7D2lGkXpYKdwA5kK8U57MIND6DNwmBc1GpJpyKrsJ47aRLbkNpaTOJQavKY8rtRutZUwc1qrTY3/eqbVqVQIYvqp9KdiAwoBfzBRt9SK9sK/ePnqpazwNcGBKfUKPzRNx8okanMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bSpR1CVz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368557c9e93so319891f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721306757; x=1721911557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MdmnyZnfUhA2Ic4iucAkOeo7YUGK4QOuvHImS1K8o8=;
        b=bSpR1CVz1xIfgkxZ0HcGTS3E1hhjTGwYXBXNxNUhBwjhd/toU1eEdQefSh5gwIMdNI
         PDopZYzVTUbHwMnSY9otyr0NAZ1Mi+XHyQK2gGHg4dQqglKEEJb/14fHYswmsfHFOCAt
         U8Wah+mO3m6ndvasihdqWf/Ioeyw7QLnkUpJjpqMGye4ONEaLRnyoUkwptzvqQ+lzwzN
         N/5oYgfOCyp7p3+qStyvMTLNYTqzK2JPQAOxbMM5nqAE0jl4nMWAqJZRuXa203SXcnpp
         YK7+AR7//2bsR+yjypakrKfZOYaKOUzgCk4guOYOMiMlfEMt92NhNpUjo1nQz8Emwb7c
         AKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721306757; x=1721911557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MdmnyZnfUhA2Ic4iucAkOeo7YUGK4QOuvHImS1K8o8=;
        b=MvbQEvM7YcPd7N2pB1LpIbjfngVVe4+Ta9qEDahw9qBFIx2G7E2dRCp3mNXTL2WujS
         FoibdJglqA3T0rdMF1QFIa9zlpKxNvRMm+lUYtlfzz0DVblJzWo4t/c3tqvZ6trs9ODR
         q0D2VY4Q4pVo7QsH+7No25SbldXReu0Eu+qJ1+PEkCN7bi+WVsgJHq5eulFdqvoqIOsu
         1xWjr3MZtdC4depXeNZ0JqagMGccak3KVS/Ai53DxPTEhxdwxXMW8OiZmucxZ8Z7dKnu
         Vuy+j0MaV6+8PZubYkoRbtf8PV/Cv3MDS+SFeB6VAwIHXhFRVdIo4jIkeQmagWGr03KU
         s7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDzaKgXQSMFEqkQU154/u0Axu9tbE4m3Gxbyh2uShmMwy0OhvDuF2MbsEpuDjpg2nCojaSZrCbT5MHY1IQhTNh6IH1+tbT7RiOnbLE
X-Gm-Message-State: AOJu0Yws2ZnJG8uy6RNoRq1iO5zvZOCAA3ENBjtl9hEu0ioPXshUudkO
	lWvrhgnd9dwo9CJZpjBwykB40R84Cp75JkV1gbKNdW2o9rZMOQXKSZGUYUt8HsuQmsXYhEZrgwS
	g
X-Google-Smtp-Source: AGHT+IGpdpSlqF0FcyNm8OlJ/OzhdT5JYlmAnK+2NFyNfELonQ9MBQznw2VdGOJxj+w1ctbPhUh5tg==
X-Received: by 2002:adf:e6c4:0:b0:35f:208e:6172 with SMTP id ffacd0b85a97d-3683164d06amr3417658f8f.27.1721306756745;
        Thu, 18 Jul 2024 05:45:56 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3685834365asm1432209f8f.64.2024.07.18.05.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 05:45:56 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:45:54 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: Add Broadcast_AND region in
 LLCC block
Message-ID: <ZpkOgpGCKp/w13la@linaro.org>
References: <20240718-x1e80100-dts-llcc-add-broadcastand_region-v1-1-20b6edf4557e@linaro.org>
 <39df7ff4-7f22-4715-a0f7-eb2475bd7b55@linaro.org>
 <Zpj8cWfcqYj8rUOP@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zpj8cWfcqYj8rUOP@hovoldconsulting.com>

On 24-07-18 13:28:49, Johan Hovold wrote:
> On Thu, Jul 18, 2024 at 01:20:37PM +0200, Konrad Dybcio wrote:
> > On 18.07.2024 12:20 PM, Abel Vesa wrote:
> > > Add missing Broadcast_AND region to the LLCC block for x1e80100,
> > > as the LLCC version on this platform is 4.1 and it provides the region.
> > > 
> > > This also fixes the following error caused by the missing region:
> > > 
> > > [    3.797768] qcom-llcc 25000000.system-cache-controller: error -EINVAL: invalid resource (null)
> 
> Please say something about this error only showing up in linux-next,
> which has 055afc34fd21 ("soc: qcom: llcc: Add regmap for Broadcast_AND region"
> region")).

Hm, now that I think of it, maybe I should drop the fixes tag
altogether, as it fits more into the "new support" category strictly
because of that commit you mentioned.

> 
> > > Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > 
> > Please fix the commit title
> 
> And that.

Yep. Will do.

> 
> Johan

