Return-Path: <linux-kernel+bounces-410265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647A69CD705
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C944DB21D12
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB2A1862B8;
	Fri, 15 Nov 2024 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFC4fNDi"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B5156C6C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731651801; cv=none; b=tSZiQckkHYhqtTYncYf1ytHY0iAL0ReLa8otNFPolpHozm+Gx/DysN6e7e7CtH4L/Ea+o7B0aDoV8FNVJ5KVmV2NrqYI+B5fVoDSQBpngsPwT/UPloc5iKsaa5XzXgSNxa2ymR7RY7ldmXfvLSShgDbDVz6fBcA/oSt+yU3ouLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731651801; c=relaxed/simple;
	bh=jG8lHdWYMcxY4VtuEgQSaY9EfCc+In8obRiKFVgirDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhzjZw4lkd0W4BbHzMb+q7skaOxYZM3qsK9Vxt1Vcr2tKvKMN3KbTgx7DIHe08E2yZDP1HLzK+snPblFNhFd0RhyEMHmGZSSs6kB932UtHxljQ6iSRqiuQNNKgO9MpGzpeAl20hAL0iCxbK70K2KcHycsQkwPb5wQ3EvIRdkd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EFC4fNDi; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7f8095a200eso1126615a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731651799; x=1732256599; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ol78VBh/D7CSp35yDrIEurbh12ES8TpwH/o75vgdzhw=;
        b=EFC4fNDirbAqzVAusfKHJLU1zpx7o9w/jPQ2FXnnxsf4BeW24qlFLv5RMDYISGe6Lw
         7zf6PxevbAhgU5+0YnCSmeoICdP+LOj2p4FrR/ARIt4ed1lze7J2bZ377XMMmmx38/6n
         A5DxKRkSJYSIrs5XrpBKWZ5t8Kp3CypDKn1mSp6d0sHocrlAAWlw4EsRQ55FcAUjhWve
         9v5PYMf5eIMv84hvvzUVqWpU/KybEOeIAXObhb8edut7sBmZ+gCorgeXP/ysoRVe5d11
         572N7ExmA4XR18E4YpT3deSR9aKx7n7AtK6AdeNA/BzZCjBfUIEH+vuVFm/8csv7tzs0
         QoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731651799; x=1732256599;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ol78VBh/D7CSp35yDrIEurbh12ES8TpwH/o75vgdzhw=;
        b=H+utfWuAFlYhucD4RxoJWNmCdx+Rm9hs3Omy7kJGZaO5gRcSsiKnC+8If8ViJQgCiJ
         VjU+CxSCmccPybnttNgOuDK8mO+SKpsAad6RC1D5abDeSSYjK+LCy2AYBGskMmbTtU+r
         SQtyY2mIjdBV1sTwjIJhrvznHw4Edztven1lMXwL1uUB+xXMtSDiHmrpCFEAX5+zzPy/
         6p7b5E7SzJ1p8P8zt9vFzHGgEyrDvJMOsulEDwDAvDAFu05WgK7ARTiek0aijNHEPc7A
         Y5wqOOck12CSYRNQ3EYQ69DYTy1onzmbMJi8oKsz2nK6ifmOmxw/1GF3e1grLRg3GgNe
         T9Vw==
X-Forwarded-Encrypted: i=1; AJvYcCW0562K4OsNilSbk1gJ8IwlKgh6YmFCABJK7YSolK5yMjp/29sXzVsApAoS9N9IUzlCb4MHXdV8uQFe0Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyErOt06NS1fAeXCiz/7Q3tqls+lvnJqv4VW01j3HcqMgaFFDhy
	LJRHF1NcbWPKiM9kzalJ60CDTAmAc7JNkAD8A9xSu/Y5FbEBvG2GxwfmfYbqBA==
X-Google-Smtp-Source: AGHT+IFsjPgI83lY+/CQYR1fF5tUl/aI/SHyGafNvcTIR62F6ZwmVxmR5O0Z6ZJ2qZDr9Hk5OmaZ8w==
X-Received: by 2002:a17:902:f54d:b0:210:e760:77e with SMTP id d9443c01a7336-211d06cf054mr29524335ad.7.1731651798965;
        Thu, 14 Nov 2024 22:23:18 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f3680dsm5773815ad.146.2024.11.14.22.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:23:18 -0800 (PST)
Date: Fri, 15 Nov 2024 11:53:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mailbox: qcom-ipcc: Add SAR2130P compatible
Message-ID: <20241115062310.lcpbjryojgzckovb@thinkpad>
References: <20241017-sar2130p-mbox-v1-1-906aa78b1358@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017-sar2130p-mbox-v1-1-906aa78b1358@linaro.org>

On Thu, Oct 17, 2024 at 09:17:23PM +0300, Dmitry Baryshkov wrote:
> Document compatible for the IPCC mailbox controller on SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
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
மணிவண்ணன் சதாசிவம்

