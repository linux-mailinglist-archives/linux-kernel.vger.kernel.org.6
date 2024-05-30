Return-Path: <linux-kernel+bounces-196056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864DB8D569B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D471C243D2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2059186282;
	Thu, 30 May 2024 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/J2OtCG"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76E18398A
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717113180; cv=none; b=Mb8T6BfFY0Wbg87PXto0T4GxBLe5tjg5pVtvUAsanuPNDe0Suf5GfigsQykpekDfsr5wAyQ1CKUw6AnagroWUMv0fwtW+87n8aE5rDmlscMqpw+96BfVheMdwdo/e7BO3YwIdkIwN2YnN5YQbQZ9WnNgWez06K5v2MnmBhuN1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717113180; c=relaxed/simple;
	bh=WNi3/u+gM5pv6zM5jVlqhRZxACAWD8ZrWuKPrDlprgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWmtkX9xN653FulH24RlDbssKStEW2NoogAfNMFMU3WTZLXZG5HO6BYIZM3J546dQGDM5aXubuICh3io/+XiMq6EOu5L9JsdhRkRg1FZ8WDNyo322V86U1lr5vUzUBOR40f0AIpPlfQVsI/xEqnJXFqfeWb4BSPhqbwsWsSF5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O/J2OtCG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ea24dfd508so15004961fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717113176; x=1717717976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8Onul56fdb6n0dzoriel8Ce/xm1MXtP6/fgkQgktDA=;
        b=O/J2OtCGveo9fnzLJqr3b/FzzekNaBHLo6wwTmd9oBl/3Hgw0cze6xS3Wc04luiGIK
         +HfzsTUJ/P5oyaug3ZnQhQYgiE6awWIV6XPHlJSYUiWZShUQxXeV2GpqkIhdUA1b/OBd
         mGar0Nr6oaOq1v3ZQnqCDX0gC4/4Jbz7A9dOdjFD/BWyHLH1eMDtgliFg0JXBKxFsrwP
         G0msgI2lVXmebfuekITNGtQqjp2kZYOloZXw7+CbElajhvxdOc50eK2/FCl8DyI6pVM/
         OMYtT7EsPiy+ECQWk6pZJ7X5BkggfthXJxBsF+fPPVXewmiKvuvpuYHE/cGXeTyLKVUp
         fr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717113176; x=1717717976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8Onul56fdb6n0dzoriel8Ce/xm1MXtP6/fgkQgktDA=;
        b=l1l3IDPTa34KT6stKCkHfxXMpE2bFkGVMcSAkOwqrwrChTGz75bWnnBhYxrl4TWgn4
         eNyl2jGlOZ+lH7qq9Zc9CRHcnUgzrIcZrvLfpANErqnQ/AkJVB+ahLzm2VpXkfIV6a1e
         ZVb4fHRsgzFK7vGxrs5EN364PtkuTZexFY68/5TYjVsTbrag2xZuwoNogQaKpEZ+jVvB
         MqcgEDIsLVRj0ONu7LhcEl7XyJLEW7Dzk/IZLIS/WkO0nwqr+5QOUHS+8iuioyTrsage
         M47n7k4mOzKfTcNW8UcNLC67nQfpp7z1S4oOvqSSciHzhgbzOivV+n9keohPJgOQT6Fe
         g4eg==
X-Forwarded-Encrypted: i=1; AJvYcCXjy8cvsY1xU7niFZue/NeaNxaIqGO14Ujll82qpvIyreXOY07Q7R8P5k+rIaTeqm3KlXthkEdn/1XhU7Ht1WNK9tOk4wJK+ko/dzMC
X-Gm-Message-State: AOJu0YweCrLAXMCRoOTrjtM5sqBegOTNzFXL9Wlyi51OnyHHCsEtaSKr
	1DUAjhPjGGn5cFuzJKnaCrMMwtLeOACb9BqKgE/A8VJFOu75q+UuvonYaRqdazs=
X-Google-Smtp-Source: AGHT+IGgIbHLys+nEyhuOKfKkVv/+ts5JGNIzMvJ115J+XAc/x5LXoHO5tA6f50AF+HVPtmyaWWr2A==
X-Received: by 2002:a2e:be10:0:b0:2e2:1dd3:c521 with SMTP id 38308e7fff4ca-2ea84c0cae9mr11073341fa.1.1717113175631;
        Thu, 30 May 2024 16:52:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91bb4a82sm1202081fa.43.2024.05.30.16.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:52:55 -0700 (PDT)
Date: Fri, 31 May 2024 02:52:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: x1e80100-qcp: Fix the PHY
 regulator for PCIe 6a
Message-ID: <d3vdxydqllegve2zf46o4ubnfytgfpnkls27i7jq57vq3bxwht@luvuw3wprcie>
References: <20240530-x1e80100-dts-pcie6a-v1-0-ee17a9939ba5@linaro.org>
 <20240530-x1e80100-dts-pcie6a-v1-2-ee17a9939ba5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530-x1e80100-dts-pcie6a-v1-2-ee17a9939ba5@linaro.org>

On Thu, May 30, 2024 at 06:43:40PM +0300, Abel Vesa wrote:
> The actual PHY regulator is L1d instead of L3j, so fix it accordingly.
> 
> Fixes: f9a9c11471da ("arm64: dts: qcom: x1e80100-qcp: Enable more support")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

