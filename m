Return-Path: <linux-kernel+bounces-435602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A57079E7A04
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F061887DE3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FDA1FFC5F;
	Fri,  6 Dec 2024 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2cuIrSp"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD04083A17
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733516899; cv=none; b=G4OGcNgpNs6HxMlcGYpK1XnDrYFm3/pHwrIcLGZ43oOc5dKJ1VKRjcoBmGQ1i+pxu3Fyugt/Od2vhmFxYQMZTBD9X7gvx3/FycqX1L8geti9tHYW5092ZQF43hgaM3ovSCvxSqhqMs73t0THBfcNLuz+RGpAdaWEEPAKrL/5lo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733516899; c=relaxed/simple;
	bh=BwakpNluTynsNNSAFGekdUFcnrj8QO9XmxqzY/IkSxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrgmzTxilolmC1+4JJyyLH/2BmFQ+bjvtNLMwpa+QUFQKWJjprdNzCCwGiu6W9op8KYdaRE+1rqROZSAoetjPHdQfbjlm86ueSqG7TFFpsxFpOhceucoNhByvU4HMnz594j03p4OoigwzjNIKYkQfolNWe0m4QpBGsdBGW5u6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z2cuIrSp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43497839b80so16454915e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 12:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733516895; x=1734121695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQaVE4xma2mfyf9DwEGfyp+l3xlEQFu3UABAOXDY/f0=;
        b=z2cuIrSp+8eZvWg94gMGQaeykK7e8zZ4y5JwC2e35/4mWnX1Q9n49cU5+G+VPPk/da
         NNDAKixylATtc9feCFpEwQi9dc1S5ud1brANGJCndRpPtzPlpOBjBz6b05HWRBXsdlDr
         xoQwxeYGwHpl7DWYqv7rbf2UjBdLHBT3mj5PdCL7N93vuASqULx5u6kB9v8YF4KZd/DL
         UblTLK50nMQ1S9l3snPaITbj+NrqCcpx9wkWgjGp3iySpkXtIis+5b+j5j5BMXIGPOAV
         xSZLm4B8e2VRjlSgeT3Xc7JVVetOJhoIV1w7AlsEhoTf0+N1kLFq032bOEb1Tk4xytI/
         I53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733516895; x=1734121695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQaVE4xma2mfyf9DwEGfyp+l3xlEQFu3UABAOXDY/f0=;
        b=dy78MOhoJvjbxKNFypozBPo3W7PiR8b607HD2MF2wSnP3NO+wAiZ5ZJwChQa5ZOLq6
         WY6cJSQ5hfQ+5u2N5cqGFwrLMq72SPQk9nwEh5WGsYRPwjUQIVczHLj7Jr5SVeAJG+hs
         UxQ8ijTJLHqMnH2hCf3tOmq+gywyCnqSjNmXTHRS15mbtlkSCv/kxLpFavClQpcGfi+j
         FEXWaHP0ygNq7Eo2GKqWPnQQ1jewegTwQf3nvsPpiSgk944nQ3haIYakLNEwwMb/KcGl
         OeKtOyDNYJmyMJ+GqKDbv4uRvH5YbWtyP1z35OawOkgf6HSOo9bKXKPVbW21DB0Ftm0z
         +7Xw==
X-Gm-Message-State: AOJu0Yyw35gaxDB28RexZL1xMwiVGY9XWpBb1gOdJlRL1FQ61lOghI1F
	HeF9KSmR02jCfe7jeTGZZ/P6+A8O0GIGJ/uy1EKr5SdtpRiqqX2SBFrxQfIBbLc=
X-Gm-Gg: ASbGnctSYWKpPQ7E89o07TxaVzYJuQwLbPpcVG5uH9cEWo8PlhVupC7jaANK9WTP0a3
	V0S+o8z52PoqhT3udlCatAHGqY0yZrL3p9Q1/Xafuy+pjF15TIK+Qi8hdkGcTR6mPBpMqEvAAGg
	r1Bp+hp/+62NaHgm+NsvM2jRkOStJuGE9hqIjpjvQTyQDSGbwYAe6hjB/lTlQW6YZYacsaL2/b+
	WRvZaKocg0hivDQKTxprLyPxU8pYULWjXvNJXSa0EHdiPJ5P808r4M=
X-Google-Smtp-Source: AGHT+IGekqBUH4G61NmWpwsXhLA6y8516RqskqF/tq8JR1N/a6IKQ5CbI54DTrqFonQGIY9zzCX1sg==
X-Received: by 2002:a5d:5f8c:0:b0:385:f38e:c0c3 with SMTP id ffacd0b85a97d-3862b33eda1mr3932008f8f.6.1733516895327;
        Fri, 06 Dec 2024 12:28:15 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d26a3sm67425945e9.1.2024.12.06.12.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:28:14 -0800 (PST)
Date: Fri, 6 Dec 2024 23:28:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Etienne Carriere <etienne.carriere@foss.st.com>
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: round rate bisecting in
 discrete rates
Message-ID: <7fe840af-d56d-4cb6-8d82-d42631409b2a@stanley.mountain>
References: <20241203173908.3148794-1-etienne.carriere@foss.st.com>
 <20241203173908.3148794-3-etienne.carriere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203173908.3148794-3-etienne.carriere@foss.st.com>

On Tue, Dec 03, 2024 at 06:39:08PM +0100, Etienne Carriere wrote:
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index 09ccd6cea7f2..7bbb2ee55f4f 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -61,13 +61,20 @@ static long scmi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>  	struct scmi_clk *clk = to_scmi_clk(hw);
>  
>  	/*
> -	 * We can't figure out what rate it will be, so just return the
> +	 * In case we can't figure out what rate it will be when the clock
> +	 * describes a list of discrete rates, then just return the
>  	 * rate back to the caller. scmi_clk_recalc_rate() will be called
>  	 * after the rate is set and we'll know what rate the clock is
>  	 * running at then.
>  	 */
> -	if (clk->info->rate_discrete)
> +	if (clk->info->rate_discrete) {
> +		ftmp = rate;

No need for this assignment.

> +		if (scmi_proto_clk_ops->round_rate &&
> +		    !scmi_proto_clk_ops->round_rate(clk->ph, clk->id, &ftmp))
> +			return ftmp;
> +
>  		return rate;
> +	}
>  
>  	fmin = clk->info->range.min_rate;
>  	fmax = clk->info->range.max_rate;

regards,
dan carpenter

