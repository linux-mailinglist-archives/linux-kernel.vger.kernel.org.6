Return-Path: <linux-kernel+bounces-223465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B92991137E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0E91C21FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1D96EB58;
	Thu, 20 Jun 2024 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ar5S0DyH"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254658AA7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916097; cv=none; b=T1Fo2ObXJrdyOvGGfjMRkCzd8LhE9lQrSW6VupHg5/AMc5ulx+zQXkUhVkxThr7wjUHbsrTPZIugdXWhFJO50SNylWeoTrhkhKIsl4l1YEWMKBN1awAUx3J82hbCLGr9f4DAnhtlOjVyCJ5EsUrkQZBkZ3Fr3O35IxqObaTMlSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916097; c=relaxed/simple;
	bh=2lIMOBJxjBjlymtZO165R4grfQZNjtqE3aYINUR4ZJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVjcFkLLKmpBmoXwY8TyfVxPIawpWOzbgyY4XMzeZLMyqW6jep4MxmJzIkeoQlnA2gj0N1gOTBQg+z+LIyyvsBTiyzrBKdRTRax9s0cBmjficv026Xc2AbPqwtFMCLI+e4va+UHZ9L68Oto7LdIJ2TsLzChmP9+FYG2FRWKAm4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ar5S0DyH; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so14071621fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718916093; x=1719520893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+D9bWZAmbvvtL0R9+aH2lAWS38iCecRNx21UjIGuCjo=;
        b=ar5S0DyHSEKbSWzFDONUquQSG3mhMvxK6VM6dMl5D8inOX4qrzCRIEccHuJacbI2Yq
         MH9aDE0/KjtBH6dKEq+SgdB1FgELbqmCbajGU3p6n+IJq1AyjB1G/6ELw+fcJ9p9Pwoe
         pYWKU2Y1pmcUggUTtLWW4PQ42uyaxeq0hiNinGKBgQt7+N+lcNXyLuA8yQaBhU8qTyKo
         8xrQTVRTl2L10E/RS+1OyqIh6VHUBKZvtwznm3Y5d++/SI7o9uY4hIyvlqqpm3IE1Cpn
         eodOfYqdikzLg175JiE6lZK4cyai5Z2S5o/nGWKGMrV0XDD2r5Sr4PWm5+ucx5FOlgv1
         us/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718916093; x=1719520893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+D9bWZAmbvvtL0R9+aH2lAWS38iCecRNx21UjIGuCjo=;
        b=vSXL/z4jrQvxZgkM9DK55v3gZYeR3NZuA8o3trF9Jq9tAHtJIHM9t4oloAIG97c3CG
         S8IltJWvcw55Fl2RnBkKMaMCjjiXURbQxGsFr6c7RDEmAR8y4OonpFPOjNZDKN2O7vX0
         2VxVM+3k8/L1mTm8kosUJ1fTwwBjVYPAfymN5kT39rsYm34bdJKszT+5O9P75fynRKUE
         E7m7RnP1A872LMZRXWzClxZin1rgzbxZ05AgVqHtt9pD+g4MfJrHmOf2/bKrF4+QVgfP
         EmgR+mbM6WIB6UmhPLgvQyH9DDwMWOxELtyCQyCJaME+iv83XkF2abEinUg3K7aAxx0z
         2FGg==
X-Forwarded-Encrypted: i=1; AJvYcCXoyxFngkKJsO8dAfQ3LSg3quqWzg2BbDH24h3tTpMBfTDaN0F0kNlcztHNXzw4+9MWSOJIfLwXWfNp1CK9bCJErEaCJ3AVh1N3NFaF
X-Gm-Message-State: AOJu0Yz8jhLKV70jDQTu0ZZyQuan2ebUCqcrOzdrMZGQ13SSw1gjCv9e
	aHguHvcOChzDUu+Zvt0MpRfdHk/OzH1DhMBFi6E6pE3UY8lPNX3pYXWYEZca/w0=
X-Google-Smtp-Source: AGHT+IHaRDFmm5LZS1LZkl428UXOCdgdnrRr/tiZbdfQNN6V380iko6RqPbH6gqRZXosJvgaPteSdQ==
X-Received: by 2002:a19:5f52:0:b0:52c:8fc8:4411 with SMTP id 2adb3069b0e04-52ccaaa2577mr3309475e87.63.1718916093457;
        Thu, 20 Jun 2024 13:41:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28720acsm2168948e87.146.2024.06.20.13.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:41:33 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:41:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: qcom: msm8916: Use mboxes in smsm node
Message-ID: <dgx4s5fxmcsktzysyc7hnswro7ywvjkslmxb4ei3zdsuk5zpue@wvp2i5wo53h7>
References: <20240619-smsm-mbox-dts-v1-0-268ab7eef779@lucaweiss.eu>
 <20240619-smsm-mbox-dts-v1-2-268ab7eef779@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-smsm-mbox-dts-v1-2-268ab7eef779@lucaweiss.eu>

On Wed, Jun 19, 2024 at 06:42:28PM GMT, Luca Weiss wrote:
> With the smsm bindings and driver finally supporting mboxes, switch to
> that and stop using apcs as syscon.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

