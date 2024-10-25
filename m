Return-Path: <linux-kernel+bounces-381559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 656539B00E1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29726284298
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736B31CFEB5;
	Fri, 25 Oct 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJg7F/El"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E6D1DD0C7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854379; cv=none; b=DosSNvnFSvc5zLgHItbZM+6DEMkRdXOYnILS4eyPVPd2vz8NXaHwxT3nUp7rykGBAwNx68MPFL7ptg+4CIUmdzeB/V2iImHNP7OCS/hJh7x3se3d1KRuiAXzTuy1EaSfOqLgaXHO7DTOqgsFGSVkk85qpbyvFC1KUHW/eLj2s/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854379; c=relaxed/simple;
	bh=jtaPclHrmNUj0OOQtmFmi0d/L5BXAUDlUF8D6hLtdhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOiFZ0nNpyvNnX0bt4ydpO6fHtgkb8vaoViOBaBUGfwFJwOBfENsY4AJ+QyYp/aFxq65G2pwvRhmVLqA2LF6OogQM/mMi+VNNZuPDIue1+GxHVXhkrjDYaAXtvUrnXRnOSkJdfBt4m941jMCzT1R5PgbD68cEYHmag1JxDnGc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fJg7F/El; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so18549931fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729854376; x=1730459176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ408GkSv6FKcDj3LbYcJBQXIjGsLP11MfIJYKrpseo=;
        b=fJg7F/El7QAV2JDxNQcGYtHpXwVz/E48TX+oDrpQ+s+wADPqQ8Vysygm0Kv9cnP01h
         epA5ZzD7LdChEjtAMh3FZpiswXmAAMX1bplpHGU+f3McOpcPxC9r+bvqjrQMdynWCZ0m
         udbALjFuCNnWCN8fmecKllWXnRIjk4bMpPE/yXG6iwv2ElEzkjEirjiANFefEqcqSEdk
         8Qn+BbaO4nFmbsCoz9Y6ld22Mp6X9WbfB+LbyJ4tnivo2NnvV4MyxE1s+bI5Xwq3Q+ui
         YvNG++quHYdGH7uc4HGSL2zNFdVPtEgwC4jRY0iYs78Yi/B4scBcV5Z9KE9vhu/qrUj9
         sghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729854376; x=1730459176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ408GkSv6FKcDj3LbYcJBQXIjGsLP11MfIJYKrpseo=;
        b=Y6UAOUDRYfvOkF4TwL/Y6sGEp46GWa3CULIGvpE7KBsunlpMjFDBtzPOqFPQjOiIaI
         Ia6AWkNIb0tBUWdPQUYmh7TQTX6lhudjVHcZ1MINQBkXMRS0icZtofCxngkqEswV4keN
         OFQURgtxM5pRYIfjVBRVla6KCbIDOVZqNUJz8XFGefI7LGqF1Erh4++RyVyiZie2BO/y
         yRY8nt7nnD01Tue0Q0yDnIBo5TwhkYn7u+SYZcW5rZNd4TQsU7LstH4+FK0XYSKr0i7R
         Op+n+iRPsrq+aRXgoS7k9Rwrd+tgtHYdqVD/2qgFded4EGzZOqEOBia4Jodkq2L1/Ov8
         Bs1A==
X-Forwarded-Encrypted: i=1; AJvYcCXovcUqTHUMQezQ7uXK5UiFae/p/QKut999adWHtH9Sr+V4vbPSpyKn+EAq3PWYbR91iSmp8dzMQs1dZ5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXPMoB9COTPo4ckmWdm/1p1U4eNyP1xjY7ZwUPSOzBG94mk2zK
	WXDdIZgEVbLPPuQ+MifqODRHvWy7U9hshqL41vSequh6bUXmYSTCMAqNwNulq9GKnZgVECtWT2m
	h
X-Google-Smtp-Source: AGHT+IF+VxvbiEWOkVh7f/0HfI+Gnuj/Q5Tm25LhUJRLQVlSwMKKkXkucoVkGr+79kTD4Fupo5kr7A==
X-Received: by 2002:a2e:4612:0:b0:2fb:5a7e:5072 with SMTP id 38308e7fff4ca-2fca825b992mr24918301fa.34.1729854375895;
        Fri, 25 Oct 2024 04:06:15 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb45d19c1sm1449371fa.82.2024.10.25.04.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 04:06:14 -0700 (PDT)
Date: Fri, 25 Oct 2024 14:06:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Qingqing Zhou <quic_qqzhou@quicinc.com>, andersson@kernel.org, 
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	robimarko@gmail.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: qcs615: add the APPS SMMU node
Message-ID: <zsphor7rpbwx4km6uxpepky2h7atbgjn2435puygmpssfc36mc@wkquqxud2yij>
References: <20241025030732.29743-1-quic_qqzhou@quicinc.com>
 <20241025030732.29743-5-quic_qqzhou@quicinc.com>
 <8a60b729-b312-4afc-835b-a18060ad3f03@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a60b729-b312-4afc-835b-a18060ad3f03@oss.qualcomm.com>

On Fri, Oct 25, 2024 at 10:54:24AM +0200, Konrad Dybcio wrote:
> On 25.10.2024 5:07 AM, Qingqing Zhou wrote:
> > Add the APPS SMMU node for QCS615 platform. Add the dma-ranges
> > to limit DMA address range to 36bit width to align with system
> > architecture.
> > 
> > Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> > ---
> 
> You probably also want to mark it `dma-coherent` (see e.g.
> x1e80100.dtsi)

Is it? I don't think SM6150 had dma-coherent SMMU, at least it wasn't
marked as such.

-- 
With best wishes
Dmitry

