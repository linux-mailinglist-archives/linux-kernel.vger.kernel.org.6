Return-Path: <linux-kernel+bounces-433638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D6F9E5B08
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0266281171
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB7F22144B;
	Thu,  5 Dec 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcE9ZlYJ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2721CA18
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415082; cv=none; b=VqIP87R4tGYAbZQQ8oultyeESegSccm+bFycyXPWlxbRwEnMxsNfsSnE9UtD7OGip/MrmJ1ZvY8gx17BEhhYvzf4Z0zIEwBFY9dQBVypE34SBVNgHSrrUbaVE3/M/0QUYdsBHGbzEX6C00HyLGXWy2omH+7t+tpfjcGwzRbjaHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415082; c=relaxed/simple;
	bh=4cvbUpYGVqBA+5ai/iSMN03QRJijrW6a/ORs1SZ3FJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0dzHdeyV+GW4Blh7nhw7aQrpeUlIVFKFAzzE1xVqtT+8t9VLf+mjLA+LT1HgtoT0IEU0oBEMLpbS/lLqFXY+a/BUw4ydM0in/rkf2ablgo+MEmZcCTTZEImrOYv47vu1vSp+txbr9+CV1OoEvDWCuV8p5djui7hwDmUrOc3rys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YcE9ZlYJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3002c324e7eso2562331fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733415078; x=1734019878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3vAx1ky+XubxvxkSqpCsICGxY0icdOX0ReI1Rb+eWgA=;
        b=YcE9ZlYJ0sHi+Mev5UheCnJwg1rEeLJMovhxUPe79Y/1EEybZKPKLQWA4k306pEqhw
         uLWo5AcK8+SnO1NVr2Qbinzi0dLGX4IjBWcO/Iytr8aABhvmCcyNXasFgYCRbo72ALCF
         +ZnSLYWGc3lTgeQF68uznDyYUgUUc5d3wHeugrBbNGeUZioeLbt5+8357mC/uh+iVDog
         NuZEGtKAgAA5OAWcvxQ2VhmQRdPSFpTJm/750zgkaWGzgE9+m7ZhmLTNe6X7O+ciCcGZ
         qQ3RcekS+b/QkOXlGzAzMP2FINg+dAADhhIfEcSWjwHSsL8mMKQBmuWey5ij/hWQxJo0
         xVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733415078; x=1734019878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3vAx1ky+XubxvxkSqpCsICGxY0icdOX0ReI1Rb+eWgA=;
        b=jKn21gVFQXLF9xdOwEAzd8itHxx16A2Fm9EzPGNmS894iVl2SnqBnTy3KJk2giJ79m
         L9LeVBSeTz2fBciEIrmD6BoHTNxM0RkjThrpKLpjPEEOgFEnKtKqe+KF2CdYLlHEX1O/
         Rz3hBtTKh7yNXNriCm0AB5LfBP5/yzEuZLvfmw3f4+DlRpoT9yEle65EEjQOm2tD00qf
         uEGNYg7Y8AYH5ozPxE65F3BVRWtYyKs0Ol0HGHEM06wFAqu8VVxNL0fkxQX1cwe7Ktmd
         ymaXpSZsctpaMddlzbbZRB+02xnv6kDJCqvyPIw6dxbxhZOdbL2uQTwf++CCwBXONnsy
         CGrw==
X-Forwarded-Encrypted: i=1; AJvYcCVhTMhf6Tigc4wMd8KGqP5UuZAAT+Z/GEvEBxOGwoHOh7hxrPSSjEAS2cwIhJXW3fTImvANM8cBKRVfl/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8hY0AuJMGx/xSSPFcyPVJCWNAzunOwK+VmOi3l/p34vCJrTKT
	VtHSOLWU0DXT4n3nwQeoEGEiYMdEsY1pw5gpCFy6EzlVLXgGM6+6NNSgOCnPhAx2pNcoX4afpOQ
	F
X-Gm-Gg: ASbGncsPgHoqD+H810bqDVl4VKCb/LENe1xCql67zYB0lnYX8DN+4IoGa6hx1gOQvpn
	TIFHsXB7qjxIXtEXoalfgkA+wtnMAgA0vYfbBmrHL7wKtKpYnYfKqv3481GXyX0p2LX9c4TUvg+
	6O6xs5ZKrWPANsorPq80cckgDRXAN6/kj5fw4cLGA+uR4HtN8m4IkDO/Nruh6eoA9F83qWERKUy
	l8BBCPFSGgkYT4tsL0VdDJnzDo/7EUoictFcbY8aVs8y1jvvWxZHhFPxD0S5po=
X-Google-Smtp-Source: AGHT+IGa6a28W61iyTDan8zO3enSWPo6CBbm0HhVWYO80g9pqx5TBN734XHJ16y+KxOFW8ykpVAjnw==
X-Received: by 2002:a05:651c:1614:b0:2fb:5a7e:5072 with SMTP id 38308e7fff4ca-30009cb184fmr75615231fa.34.1733415078119;
        Thu, 05 Dec 2024 08:11:18 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0da461sm28223735e9.20.2024.12.05.08.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:11:17 -0800 (PST)
Message-ID: <0909a2b2-089d-41f3-82e6-f0e05682ce27@linaro.org>
Date: Thu, 5 Dec 2024 16:11:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] dt-bindings: media: camss: Add qcom,sm8550-camss
 binding
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.zapolskiy@linaro.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com,
 Yongsheng Li <quic_yon@quicinc.com>
References: <20241205155538.250743-1-quic_depengs@quicinc.com>
 <20241205155538.250743-12-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241205155538.250743-12-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2024 15:55, Depeng Shao wrote:
> +            iommus = <&apps_smmu 0x800 0x20>;

This iommu list looks a bit spartan.

Here's what I have for X1E:

https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/9686eaf9557c386a2525d6668da6fe24ffd518c4#5b6ff684e5292a4c0b51f6a38631777fafae7561_4749_4874

Could you double check this list ?

---
bod

