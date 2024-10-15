Return-Path: <linux-kernel+bounces-365935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 963A699EE23
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3681C20B76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77CF1AF0BC;
	Tue, 15 Oct 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/+dY4uM"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E99E170A3A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000207; cv=none; b=iG99N2Zu5k/X4jOXZ/18sCpVMYWfuFpHLcAR5I4fyybjfIrOk78SNAydnYtKCo7Ae2pZRUUkSaTa4k1jAqmuyf5A9j03nHR2+aE04NXagpNjITdG1QbtDvHOnzMdTY/D1lBZf7BHYO0fR3GluyyVsgiHoqoecPpnIV7kJE4EbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000207; c=relaxed/simple;
	bh=H4nUnTC/mdAHJ8whTn4/NoSOHF5aQx8EjvAPFGyij9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP8yUzQCC5h7Zd+3CyNXHIAXYZPPKd0XkSaZrIg/ChOZxKtIqwxMlsnUUOitg8clZ2iBBktLl1p2vqATp8Y4pNDsN5pZi3PPARt1s7i023uy46I1tysaBptp7SAApuQrKhsto9YooJKPW65TnBzwFYs+mwqCVUmjqhIRazZexRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W/+dY4uM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e4b7409fso3159311e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729000204; x=1729605004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FD0iGhVyvSNI4hIlLRLN+1/oqBE9b4I//1UiQGbWTqc=;
        b=W/+dY4uMj7JDg+lelWE516EqBEXuPjblu+Q9KXcqETw3Hu9alLTK6H5lOrYqhRcfuG
         +cZ/ViL4/2P9f80SOQZVWdooIVfU+MyWv+OJvxD/AD2CrznziPymoEO8Zn/cAQaikRFS
         9SdmGVe7uOOqKTrZh+x0JKlBP7dvbFQXB/I7QynbYkhEHXc6rB8zssYWLmphZiqCfLUO
         UHXjfg0szYfhToIG0XX+oj9qNTCMta+k/jAXvtuxdZK0OGWR0H3wPoCxq1DrSZA+IA+b
         ASLcHFJYL9en8s/ZLaXMNjzGHpB6FxLptG8P6OI8NYYHNeeNFF5gtyPV9uQvCKhr776v
         NIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729000204; x=1729605004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD0iGhVyvSNI4hIlLRLN+1/oqBE9b4I//1UiQGbWTqc=;
        b=CdOevkx2Jkw86N27VHorXa1rUqmC4BvtGUX31bSEqnwx5a/I7ikSGfE+7s2zCSOJpS
         DIb4Xt0ekPgFSbHxjZHg2lhe8SxmKhNWQ9Wn8dDKHgJVfoPeDvGotpWRt/wR/gm+OgTV
         hUKBmNLxOSRKbgTagjNi58Dn70Q5TVggX3L1OlBEkrYjVt8RSlP/Wazu311OfqQqp81a
         B6xKg2fUBXzfBMiTqWZ31IF/BFTivbPWVt/kpKkv6fb2X8Jnm3mBXlP+VLuTduRHdBcN
         ZMOerpOMYdKXXSYlWoIZRr0FTaxNVYbcBIQSHNdaEviC1rSHTkiP/8Zw6xluY86IRWBU
         OXCw==
X-Forwarded-Encrypted: i=1; AJvYcCXS1TSlFjk/AJo9Q5mmNLOROMVK5XzPdudM6zkMmgfvx4yUGImCEaj4+PRAhGqd7mfS+ZrGwSayj9zFp3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEXSKaZpsTATVEcKOf0R9vBMq9qz0PGxQfaoQpyw+HTcqpIxlY
	e3xiILu4KKnAZ0pr8haFTZTXH1EXRgIawL2Q0urrJbWsiIK7RfzGpaxPyBG3ZMJn7u0tT+OpEMU
	EtOE=
X-Google-Smtp-Source: AGHT+IHoxE97W7pq98kCNKGan3wyUPPB4piqn0nLwlER2aqV9877/qmvV1C9BfrTXGFUKRAZTXASDQ==
X-Received: by 2002:a05:6512:2311:b0:539:f51d:8273 with SMTP id 2adb3069b0e04-53a03c8fd6emr210613e87.1.1729000203622;
        Tue, 15 Oct 2024 06:50:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffa896bsm174209e87.30.2024.10.15.06.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 06:50:02 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:49:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, fekz115@gmail.com, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [RESEND PATCH v2 1/1] arm64: dts: qcom: sc7280: Add 0x81 Adreno
 speed bin
Message-ID: <jg6fkul5qxq4vcsxk4fky5h2s5mn5lpbf7sgm74ga4sbsibcrl@2evll6msgvkg>
References: <20241014194825.44406-1-danila@jiaxyga.com>
 <20241014194825.44406-2-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014194825.44406-2-danila@jiaxyga.com>

On Mon, Oct 14, 2024 at 10:48:25PM +0300, Danila Tikhonov wrote:
> From: Eugene Lepshy <fekz115@gmail.com>
> 
> A642L (speedbin 0x81) uses index 4, so this commit sets the fourth bit
> for A642L supported opps.
> 
> Signed-off-by: Eugene Lepshy <fekz115@gmail.com>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

