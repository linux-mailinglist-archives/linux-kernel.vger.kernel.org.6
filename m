Return-Path: <linux-kernel+bounces-223459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221AF911365
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0460281C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880243C6AC;
	Thu, 20 Jun 2024 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuDoqGLx"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7EB55880
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915934; cv=none; b=qmmPBd0fXaaUwSjeXJJwyXwASvEQrS0eBJdLzvL7KMriHTQOKLRSB8WTd0+5fwCXkXaBVPFoROvjqN7PuVybU9ze1HH82SDrwlGyWyU8dbnLqdZfRgDgJ6ZQ+GTyfnY05n1yz90dCauxrOEgaiercLRbcQ4bTIJoGzRI8Dsm3rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915934; c=relaxed/simple;
	bh=oGap+EuOGFC5B/6eNk2XEyAmiNddzucnVXUXSsR1hmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgnRNObwiG7Ov4Rvl7iXA9wvT7VDkfscIY+r4d7sejA614wknKvyx23PV8sZZ6s0L3P56/Zc32gg8VSRHBgIYvbKjJrJEnurIEq0Ni/WEUYv/7YdTr7hcDKEpKOzF7KCZhhssx5X+l0SmxsBv91Y85/MtC7OWHeYbUHSWZkYWUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TuDoqGLx; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec4a11a297so7628531fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718915931; x=1719520731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=njLEEuZyMxfG5FyNtjads2hMdYAWqv6cZs0xVoAuq6U=;
        b=TuDoqGLx5g6T2gGcw/SiBxukVf+ffuEn4XSmqfVx3FWCMd4/3bFUS5xQgknv2L9KK5
         z/DaMqVQ4brImS8RmgNjm9skZRQcCGIbnsmNS5Hzl9cJ9FkXVzhIl6b3vofiXJmd2uYL
         7u/cxSdp3R6SQBUAU1HDtGKxyIDGUpQ6v8JetYShJmalQEaMb2gbXN1jb2TUHk0s+fFL
         dFjo8mPyD9lfZ/3p/eaD9ygMGpG0ChiMKOCBzTvbKLmAudx4+e8QGIueXpPdhPduqCQO
         pnv0+R1l8PrDk9WUcmjAy8gP3hoh91sy4j+oNzNtgcecJ8Oh1qiK6QNyEOTatmLalKFd
         rRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718915931; x=1719520731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njLEEuZyMxfG5FyNtjads2hMdYAWqv6cZs0xVoAuq6U=;
        b=ohda53eE+45nZMGKcN3xE5gd+EgHhOE38PC7J5is33nKy5LXtdyUgLTkIxUiMT67GB
         DPlBi7nr7dy/9yl3kQFYXrocqRc8Id8ekLDU0TvfjcS1AM6/4Ayd9rLcHfgzIbnDNHcN
         j/ZzqRPcfcEZUCzBS/QOPi7k62X1gKQUAQG2e4NMJ1atAXYh5XYkFLkxEmLdY370AL2s
         4/kM1rKYcl2iqVPBqguc/IDdtEfrQazheN2xezgU20y7EOEVN6gjWw55IA7R5Wu/0pCg
         cKJyuHKXboyenQhPh9T4lumfIwF0ZeETPmMVEyhJfhZNXFdLAL0g8520T2Tl/xiWSyKf
         r9qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWePuTIuIVRH6ppLsMDVNpLB1RhihDYXYvlwbB3p4j04AUUvRTw/P9Xle4wTKbV2XDtKA/oNVwqRxBMR0O2bb1D1KipNr+4j2gwwv2C
X-Gm-Message-State: AOJu0YwACwNMDKokvYfd/yIETsAeRdmRRQU27Cu7W9bsT12kXjVGPsLi
	Q7NFaG7yWPCzWTVvC4Hgje1Uike1rxUMgDy08kukHOiHh61C+czAOmPXumUnPCE=
X-Google-Smtp-Source: AGHT+IGoVlJFt1tcSG+42UB1lS0RFqpVYqmcQIHJmbgcYNlgSAK09MN3gK92Kpdt1cLgQa/CDhV5Ow==
X-Received: by 2002:a2e:9241:0:b0:2ec:2a7:af46 with SMTP id 38308e7fff4ca-2ec3cffc600mr41397251fa.45.1718915931328;
        Thu, 20 Jun 2024 13:38:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d7090a3sm154351fa.46.2024.06.20.13.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:38:50 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:38:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] ARM: dts: qcom: msm8974: Use mboxes in smsm node
Message-ID: <7irayxs62grsgimv4764ujmrgbj6fepvj3nqa2sjglcozcjasq@yv6b7rn7lyvc>
References: <20240619-smsm-mbox-dts-v1-0-268ab7eef779@lucaweiss.eu>
 <20240619-smsm-mbox-dts-v1-1-268ab7eef779@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-smsm-mbox-dts-v1-1-268ab7eef779@lucaweiss.eu>

On Wed, Jun 19, 2024 at 06:42:27PM GMT, Luca Weiss wrote:
> With the smsm bindings and driver finally supporting mboxes, switch to
> that and stop using apcs as syscon.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

