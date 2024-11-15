Return-Path: <linux-kernel+bounces-410335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A8D9CDA13
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448681F220F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3586E188724;
	Fri, 15 Nov 2024 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cptDjmE/"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3299189BAC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731657114; cv=none; b=WeEM5aI+frYLpUE2WgIX+s0rxKaV2ni8jJPtgIo9AXZLv9tjkqpFKyBxnxYLr62BOZe0BbnWtOrBOhKvKUW/Vo7fXfNMG6UpISB9ooLNibDuQL1REMaRTbE8SKwBvCj34oSAcF0Njybg6x1kLP+apJhDrCNl1KywS9hLQqMX9gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731657114; c=relaxed/simple;
	bh=2nCYfVUsaK0oWwdibzyqYCBP8hc/L0UKlkeyhaOyjPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDxI1y/2GLnN7rHWuaXO2qLKhodJ9LPq+Ak9sBbPRTkMKYQS5enrbNs4b2NhB4Q2JMeC34WtnSL6mjCTzpWo16HyJqKrM4otUme50WOmbO8RV1YO67kX5vtFMEcL/E+CQK9Zr3nfWlD3GDyI2sr7FSDHkGjS+cB8BMfkjH2lgg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cptDjmE/; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53da24e9673so1506899e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731657111; x=1732261911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6uR4lmCvfAJMXeBWCQe7Avlz3fYotI9j6ue3VQ0LhA=;
        b=cptDjmE/iwan+zsRVmKvtSOtYIzh1HJzQkUYKBIFF7V70rA61oYc4YhNr4e5Kk04p/
         xRzuwJpeRZhjOUJly6aYVncmfjxhEqwcryxzWr+gwVY0UKFPCZqGvhs/BB7H2nunMllT
         WfyZsxagRaFsEUtb8QeJWF0r9Wz9Oe3nUFJaWvAc4UKHS01VtNe5Qe668W77x9hpffct
         GkI7U3igRBV3GTT1BQdaHcqfQ1lYT+n1eb5KGaUbgxDZtr1/FdksOsreZ6Yeb4GuwkSX
         aOYHaFdSZqNk/oq3t6vDXDxW6JCSDRmfUmd82uBBkfzwMtVsG99b7F8EYHURALHEUY60
         QuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731657111; x=1732261911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6uR4lmCvfAJMXeBWCQe7Avlz3fYotI9j6ue3VQ0LhA=;
        b=M7FdmMeBZtf4sR/WUyR+W1erOWamlsmP1Y3+XQ8DcenWz8FfUWlZ14kWAsRqfS6HTC
         3IRUoDjlyvAIPWaok40UsRJGIyta4OOIUFSK5UZ7rAqg4chLefCYTH3Mce1kj8VUZuJ7
         2062nKSDqRx7Xo/Uf3IgLGDw4QW5SNt75gUvZHNbZx6RluGYtpcApNVoxB5szuroK3Qx
         IGwdwWA3/AeyG2FwBNNRyFshIqaPMCdOLuvPrbdc2Trq880nCQhv/JyP/aJhLqhj9G4B
         Qa5g0y5cqOJqllciWk58+78FeKs1YWHyx+V4LuriSVSYxTvrziLcKVWQ+JLN/2PCfQ7N
         yr4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXw9bBzazDPqnrZENDZACt4Gp+Dn4b3puAq7JvxQCGKZzsMCdxKCwp7Q3HroT8R4D8+ZAYgNLy669Z9Azw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyClR4+ImQGyzVw2fv7Vx7LvaiIcSZ93ekP2hn+Mp2VAbi5x1AM
	MworFrx05NvHm+tANQazFnOeU3jNaPGmtQDV/pir2d0RsLYf/Bs6qzwbYN5wC6A=
X-Google-Smtp-Source: AGHT+IHx4r8PoVffYMSAz6mfCWHjXqVCW3WZr8poXG0AFZMf8cQWXtIMW+eBeMRIXBHDvf9eGOH6rA==
X-Received: by 2002:a05:6512:3b1f:b0:539:f7ba:c982 with SMTP id 2adb3069b0e04-53dab2a8571mr764772e87.33.1731657110866;
        Thu, 14 Nov 2024 23:51:50 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da65000f9sm470266e87.71.2024.11.14.23.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:51:49 -0800 (PST)
Date: Fri, 15 Nov 2024 09:51:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mailbox: qcom-ipcc: Add SAR2130P compatible
Message-ID: <ef5gdymsyeh32jvar6ee4jgjtue6xxnsbvn3ff5kkxfwvl75s5@pmfrcff2krch>
References: <20241017-sar2130p-mbox-v1-1-906aa78b1358@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-sar2130p-mbox-v1-1-906aa78b1358@linaro.org>

On Thu, Oct 17, 2024 at 09:17:23PM +0300, Dmitry Baryshkov wrote:
> Document compatible for the IPCC mailbox controller on SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
>  1 file changed, 1 insertion(+)

Jassi, the patch is trivial, is has been reviewed by the DT maintainers
almost a month ago, but it is still not a part of the -next.

We are past -rc7, so we should not expect new patches coming into the
for-next branches.  The mailbox/for-next tree has been updated 7 weeks
ago. Are there no pending patches for the mailbox tree?  It is expected
that the kernel tree is at least a bit tested before the trees get sent
for -rc1. I see that it is a typical cadence for your tree, the patches
get picked up after one of the last -rc releases. Can we help you
somehow in order to improve it?

Even putting the testing / conflicts / linux-next point of view aside,
being unsure until the last -rc whether the patch gets accepted or not
is not that nice from the developer's point of view.

> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> index 2d66770ed3612fd4bf9e28c334b273033e13684f..ecb4ec1e0a82856581f16391813b3c533c4f6f90 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> @@ -28,6 +28,7 @@ properties:
>            - qcom,qdu1000-ipcc
>            - qcom,sa8255p-ipcc
>            - qcom,sa8775p-ipcc
> +          - qcom,sar2130p-ipcc
>            - qcom,sc7280-ipcc
>            - qcom,sc8280xp-ipcc
>            - qcom,sdx75-ipcc
> 
> ---
> base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
> change-id: 20241017-sar2130p-mbox-1ff72d8eb5c8
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

