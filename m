Return-Path: <linux-kernel+bounces-226976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F610914699
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96479B22D01
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B79813248E;
	Mon, 24 Jun 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgvfWOkm"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D811474413
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719222331; cv=none; b=MjO2ExMNaHjOtgkObKXAZrU/esCUM3QsiC4mVUBC0ApF0qyP+mIx4Csi3tLVKjpnHtDLL1JdKcD8MnHEz5ag0O/7cr/7IEHK/L/T1zLu92MJLtxyxax4UjvmGSd4i81Nh9s6MDg2MXwuaqpNTbLfNkN8b5J2KW1HGiN6t/uBhec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719222331; c=relaxed/simple;
	bh=KN6Xy95DA/76ttyjaLKHOHB4qSMJ672x9Oas7+ljqL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKItaX8U65cp3RZ5H+85P5Oz/j6GSobNcsx1yOqxRE4dep1XuSRjlM1kunln3I1utKVHkmVtfnJ00nPPAgK3UwLZyVkFw6/MmKksc1XRZA3M/KhpOdCXBk5ZAvphpuQXJrxZANj6x2f+MXM+e1LsJJ0VzUVBBTHKot1xJxrFyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NgvfWOkm; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cdbc20faeso2702236e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719222328; x=1719827128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R2T+vB30li/O7omHwMEYULiIVM5Yoc0a3cav+xwX2TM=;
        b=NgvfWOkmDjCsKMcGA3jmGKn850a8PJWa3z17+DFU7VGRRj8a7S3WOaNFYf4qfAugxH
         EcgHYwYvfFA+flOgytHVOPhnFTRFtq6cd7/OlWfIRyDjJuyIhuwhgGU4XVlBfGhpEDVs
         djv47AzgB2d4LhfyoqxMOE2Hj9Hc47lQsq5irMCshUkjSSCZJyjMnZUPMp6VqmSY6Pw4
         DGqlvupucKVTBfypvlB1nvLy9XrhTzaY6jcs1X5uqj4N3yfdLKqZi9tKoIM00Qlk1rCr
         DDio7ksusP7cJJf8sKvh4Js8ZowZDMkJBQjUBiiEIuhPjZVR/8lYdGD5yCRfbx83sniv
         L6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719222328; x=1719827128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2T+vB30li/O7omHwMEYULiIVM5Yoc0a3cav+xwX2TM=;
        b=aQLgbzCyu4xhhMUNCzgUAEuA9Xuj5tXQTy0dIcmi3yE1YqEKlsOimk07KtdXwxAC+N
         ZtbeVEnUT1Fi7xWD916B6hxvB2CFlZltqL0wLYf7ikhaLoEWOG7Q2DMTj/zHKGd3Vm2W
         j3xJymTOWQDyQgvExbI0ZrThIxxQSk21Dh/+mb4iW62BfG1oK9jNUe3p7UAaZ7tSDeUI
         qlErX50gV3iacZpIsilfCsJWh2ZnhXNNgshVHvT75GBkjRQZCZjkS7KQR1bPha9x8smS
         fLaz5XTTXJdVYbNr16Ikm9hdeSHZy3d+nfP6Yy5LrMtPg7KPHkaw6r4NQRh3eqvvEijI
         ontA==
X-Forwarded-Encrypted: i=1; AJvYcCU0GEGjQ3BZ8qpt2R5uALePlVe5vjLyBIW0T3T6e29P5LJrJ1tj8jt5Ft+Eb6gOwqtxK90BkgC5fFbrTzaMk7ohaFUlkdeOg2QD0+5G
X-Gm-Message-State: AOJu0YzFopPo3+MPf35dO3pC2XAVVlTEicRwO63DXn71qrK3LoIVp6Kd
	RNneD2hNDfc5gLghVm8gb+MfeS4RPHp80fKhE6QG/OP9cHBCaBjXeCsbWxhn6NQ=
X-Google-Smtp-Source: AGHT+IGs0sNNK7EbrMz9guyDVqQqxo6nu9BzMy8MfIzoVO8+KKxTpquIJqx9InsStNttCSY2VbCeIQ==
X-Received: by 2002:ac2:4c86:0:b0:52c:deae:b8fa with SMTP id 2adb3069b0e04-52ce18321afmr2477186e87.3.1719222327875;
        Mon, 24 Jun 2024 02:45:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ceb804334sm42225e87.183.2024.06.24.02.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:45:27 -0700 (PDT)
Date: Mon, 24 Jun 2024 12:45:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, quic_rgottimu@quicinc.com, 
	quic_kshivnan@quicinc.com, conor+dt@kernel.org, abel.vesa@linaro.org
Subject: Re: [PATCH V3 3/4] soc: qcom: icc-bwmon: Allow for interrupts to be
 shared across instances
Message-ID: <qld47ryqxciamnz6jmdqtad4s4cemcl2r6kpsd5gst5ccwa5ma@4ej2gzk2vce7>
References: <20240624092214.146935-1-quic_sibis@quicinc.com>
 <20240624092214.146935-4-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624092214.146935-4-quic_sibis@quicinc.com>

On Mon, Jun 24, 2024 at 02:52:13PM GMT, Sibi Sankar wrote:
> The multiple BWMONv4 instances available on the X1E80100 SoC use the
> same interrupt number. Mark them are shared to allow for re-use across
> instances.
> 
> Using IRQF_SHARED coupled with devm_request_threaded_irq implies that
> the irq can still trigger during/after bwmon_remove due to other active
> bwmon instances. Handle this race by relying on bwmon_disable to disable
> the interrupt and coupled with explicit request/free irqs.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

