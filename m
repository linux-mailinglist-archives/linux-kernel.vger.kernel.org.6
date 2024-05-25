Return-Path: <linux-kernel+bounces-189523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928E08CF132
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 22:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1211C208D1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AB112839A;
	Sat, 25 May 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bMoZnpY9"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5433D0
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716667854; cv=none; b=u/mf3/k0fRcHkC26Cr1SqWLBJeTdJaCRt0uzA8l16Faeencpcc9fo5I1UqM/BQG/lfyvFqkRklFrHnZXAUesZsGWBji8CjYPikhELKZdAnGoacIomp3DDo/j1Fui+R5nTrkpaUnRuU1X8Y1UgU1CL5ex3oTZnPmtbU5L3prS5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716667854; c=relaxed/simple;
	bh=e/SqsMrQ9q0SfIyPEwKs25/TzKjlnC/zHcUIC17p6aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKvVaKYN3d+EyhsBGgLDyRolwCJUVjJKb9HFm1HDwWtkONFXtCsMXek7XLFckC1FZPG6H7xnGXy0WVrAxUJtvFt8KZJWX0t/2k6XqfiYUAHg9SMAeUcj1RkIhnhfCHegtknh4c/IbS9TujTHWaKFs9utU/8W8tMY/kb8MfVwxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bMoZnpY9; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e73359b979so68417171fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716667850; x=1717272650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hay1dQxWlyajud/Uox2lrtdjKK8bbHNkgB0DvkOyyo4=;
        b=bMoZnpY9R671hsx3NlQGiK9jXGw+I/LKb54rwwpOktCtoRjQ1nP38fzHrBXHKitO5a
         LXNO5hVYlAkqty0UujD3aBjnBaCfu6ko1vJLXy7OvyKXsbvujIpH/BhIUc7EA/C8cA5y
         7CdGhqx/0Z8aKX7+ZdY/IjrJ9pjxMj+CEG/qc8uzttvevcEjw59irkCGJMRLyonE6vFI
         ze4tB+Q2bfvVHHk3c55oxkKK5cgTeiMW7J2h8CLDiiwPfwQpPhhM3Qs/dl+Jy3dHAnDp
         JZZ+2he5X+lOKAMMt+QvDSHsKbwyaN5vZ5e0jvAIvrYjDEt6QN33NF4Bvcox3JRRSzqp
         vZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716667850; x=1717272650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hay1dQxWlyajud/Uox2lrtdjKK8bbHNkgB0DvkOyyo4=;
        b=v92dto03nEd5MhxFSh9aJ2kcWDAQiXZ5qqoak8c2CbzGO0d7RD08LdMu1H1ctBJ/ak
         PF0v6BUeSy/Y4P1oDDxmU0SSAIwTxfeipWGBq1Y0wWLH2qLQw9wcr3ZHKUihqLWVbH8a
         vJGvstDsjULMtjpvxicy7prfOu0+WwM8u9FJ+aRdx2s+/2r2KPHXcQNroTRGjcan59fG
         ZuLeDMtE6AlgdF7/Va16gh03MuZsDXWiLzAMRsk0ZJsJzlEu3WBWAvg0afzD7ceVGM/8
         FRcd+9WUgXpIBPNOTdpndKKwAGAiWy0KH3LOn2X5SHryvMH4wWe//3oRmixp8xTbqgU4
         liEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIZb8utPn1DIKzVCoeaEm0H4gPlcpk0c1XTMmI2BhIINfs+rSjLeSRvtkwILDibXsxHr5mZmyrJD6EUMX8AQ7pmdFaWpdSHIo9MFe9
X-Gm-Message-State: AOJu0YwuD6+64MH6C1Wl/Ql7TO8UzWuAGhFHKpwlSvDrjTTYtw0vWtfF
	VTPdKHgg93878FlQxxWvYZhj2/zFU+3AjWS50nPLvec0KMYZwoq4Ctu/Vh+kMmg=
X-Google-Smtp-Source: AGHT+IGTic3xlNUhfOJl2SaWSAmP8JtysqkrRSUBGy/UQ+3NdA+Ph+fMfzB/slWuwtwSwhMgkJOMZQ==
X-Received: by 2002:a2e:a9ac:0:b0:2e9:5b89:dc6a with SMTP id 38308e7fff4ca-2e95b89de87mr40099391fa.39.1716667849736;
        Sat, 25 May 2024 13:10:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95be009d3sm8493621fa.102.2024.05.25.13.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 13:10:49 -0700 (PDT)
Date: Sat, 25 May 2024 23:10:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: Fix LLCC reg property again
Message-ID: <chsvdomhzn3zsncjk4v6inwign4tjzooaxoto2lriltu6pqfb7@vrvqwwe3fsrh>
References: <20240525-sc8180x-llcc-reg-fixup-v1-1-0c13d4ea94f2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525-sc8180x-llcc-reg-fixup-v1-1-0c13d4ea94f2@quicinc.com>

On Sat, May 25, 2024 at 10:44:11AM -0700, Bjorn Andersson wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> Commit '74cf6675c35e ("arm64: dts: qcom: sc8180x: Fix LLCC reg
> property")' transitioned the SC8180X LLCC node to describe each memory
> region individually, but did not include all the regions.
> 
> The result is that Linux fails to find the last regions, so extend the
> definition to cover all the blocks.
> 
> This also corrects the related DeviceTree validation error.
> 
> Fixes: 74cf6675c35e ("arm64: dts: qcom: sc8180x: Fix LLCC reg property")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

