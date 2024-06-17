Return-Path: <linux-kernel+bounces-218023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C2190B820
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8052DB25528
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C702185E50;
	Mon, 17 Jun 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eemRY1f9"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E69185E43
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645608; cv=none; b=gyla8YE6co93bLWssmtE7WExuqHm7Px67Ue/YbPx/Kp+lJNDpyXbAeOMMJvCNtUxze0jNVkTNpj8XJHWuXixRsQ2OPL8wNxDuh37ttUTaEyhtYb7xRy9wNCs2XTWyzj1J8SPW+HUhZeU11idofyCgBoUCewV8otF/3wqDxqW1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645608; c=relaxed/simple;
	bh=PG3BCj9R30OdLhZZyfrDaoTTRFm41wylvyZJx2O0h7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvtTCl0IzXZ+Spu6LXmHWMdjDUSaeCKPtwZsT9h4eEUMAYCd/NiEctIVBgrlovsl5a2v2yuwd1BltKI76aSEu0Kcy2MXo4U1CIy0KjAr5tT/NMZz0WbSl82F+BDL8yrb/5r2vMMLS8zuz1P1MuJbYU8dei3LCKg3YT/f8fNV2W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eemRY1f9; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bbdc237f0so5159903e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718645605; x=1719250405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFQCWRaqmBJq8+m4mF5hIPHwI1FBZDEXFQrG/Y1yGWA=;
        b=eemRY1f91RGS4plsryR4G48mZYcM/u3ovmFRhDeqyKlDEZ9eRJ1eePQgRqck8D5XK7
         O3alz5IWKZJ2dSECt2gC4BuTCIpldwv9sv2IJlgCHHj5Y3x3DomKE/0vOq9XpOKmby1/
         OcqBhff9ysPeG0kz+93LThbz6FnjSpsTw0BySAflJ14pvYArOzBP19X7/nTKAWgboOBr
         Ja7vUY4xWmP8rQYWshuD2r7gCJRnnoGwnJBZb1x++JIvZV0tFaqnh+ki4w1VUBbYEBmf
         8lop1fy27a/x66K2rRbp9WAGkQUuoJbrVmnboY3U7QhYTIuGt5qfFZvmB+sl6JoiFNiq
         j5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718645605; x=1719250405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFQCWRaqmBJq8+m4mF5hIPHwI1FBZDEXFQrG/Y1yGWA=;
        b=f3PdaKFW/xNC6NsQdGz4yQOQ9MMg2z8X7CTLsIR6PtsM8q/kHSsjV61ofomNFWHmD5
         Xl2mrSScpp7oAwT5YBuCcjz1jnjy6orcqfe7ZA0D5uUfc1ZF2OJnxO5npibbgXS9pUhE
         lywpYjvGGJEqIyIjt+9GSxrbu4W8ZJ/b1TO9cssbYUdpQuXZSo7IUSNOUdkW/2Pn6S2L
         un5Udp431D7HzFqGkJwbVYBsVTiwdGnas/RvUprHweYQmlsY0ZGQ4iyLPgGP7S1BtYPL
         GQBqY43TqAhIzxxt4a8NPY+KR5jzDaWs3hDSkV6jzKYD/8q3c70eW2wuw55aGlbKlOsR
         4BCg==
X-Forwarded-Encrypted: i=1; AJvYcCVkmTyyfncUNUVbL2nxLZXtzqY/2dSnKRrDqS6OmO6T2w77MW4wJ7/pSzXUvg74kjr7M0lkJWfTeRsge79xzceZL7+MxSU1OogPa1jl
X-Gm-Message-State: AOJu0Yw6bOuVCfxXSFuY5LiSduE92UFKehN9akCKexstWRaDX8a8TDV7
	PuszYqH5DLc3WQNBwDZr7/YqC1E3TEIs7v/lI8zO91Zx/FkF+ktp1y44CF1arfc=
X-Google-Smtp-Source: AGHT+IGZ0XGwW8+FJ9oSqx6R/jJKEbazLowEP92ZnnjcgIC15UcSwHMBJpzMR4oEGE/iPCzK3fqrvA==
X-Received: by 2002:a19:f60d:0:b0:52c:82bd:bc6f with SMTP id 2adb3069b0e04-52ca6e563ebmr6789043e87.11.1718645605467;
        Mon, 17 Jun 2024 10:33:25 -0700 (PDT)
Received: from ?IPV6:2a00:f41:cb2:a9df:20fa:cfbe:9ea6:1fe8? ([2a00:f41:cb2:a9df:20fa:cfbe:9ea6:1fe8])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2825863sm1283308e87.55.2024.06.17.10.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 10:33:25 -0700 (PDT)
Message-ID: <a31a2f94-d125-48fa-8e57-7aedee98063e@linaro.org>
Date: Mon, 17 Jun 2024 19:33:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: sdx75: add missing qlink_logging
 reserved memory for mpss
To: Naina Mehta <quic_nainmeht@quicinc.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, manivannan.sadhasivam@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240617093428.3616194-1-quic_nainmeht@quicinc.com>
 <20240617093428.3616194-4-quic_nainmeht@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240617093428.3616194-4-quic_nainmeht@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/17/24 11:34, Naina Mehta wrote:
> The qlink_logging memory region is also used by the modem firmware,
> add it to reserved memory regions.
> Also split MPSS DSM region into 2 separate regions.
> 
> Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
> ---

The commit message is very misleading.. You're not adding
qlink_logging, you're renaming qdss@8800000 to qlink_logging.

Then, you add qdss_mem @ 88500000 and split the dsmharq_mem into two
and shrink mpssadsp_mem.

Please rewrite the commit message.

Konrad

