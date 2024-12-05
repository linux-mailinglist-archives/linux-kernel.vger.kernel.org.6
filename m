Return-Path: <linux-kernel+bounces-433771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5299E5CD6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E886016BF38
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A7A229B20;
	Thu,  5 Dec 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwiSCTz5"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178557E105
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418951; cv=none; b=rRTqX/Pdb4zGWJGE2iprsfkezPDrLVYQWAX7h+xTxrc5y2iKj1q7Pewo8w+SgawUw0rVTeKV62VoEALOcHIl9iZbM+YTH1WsTXx6gTgJmP9sGY3GTRXTuBfgI+b7bUNe3kqOSawIKxpF0OgOSGiqhHBUQ0m2MI0CJwkJ0fLHbJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418951; c=relaxed/simple;
	bh=rVxdCXnF53bGePiz+b207A98CTZ+XHwr6WSiDwdMXYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ08Xx3aJWrI27brVrtGAyb6J51Rkt2QrQSqC4AIyVMuGLSspV33ZslbKykxqeVCbYXSHXx3p2sTWDNeGfyxQLXa7eYXSndzW2nhMaGG/bG7TulmX3A3i2CBWQX64OlrarVTnJfEfl7nKIoc3nCiVYCAzM28UOsR3mK/ptpoksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KwiSCTz5; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e2ad03bb3so70385e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733418948; x=1734023748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNxP0LFln0zgtOWEPbGccnsmPf7gfq1YwGA1WaBfZX8=;
        b=KwiSCTz5+jhTr+qli+iLMFBa3N49VrXaD6ykqTTnpCT9ZdyEqMO/N4X/sY93zPUbN/
         p6X16lTOsHKhsyaNhMJzky4I1CvJXca7YF02+vVMdp1OnuH9LbUp7ZQfBPauwKM+aiuh
         YfuAgb+k+JRErL3tLad3Erhlu33sV7RHxhMR2o5XPe/gFd3yCVrWsa+ZQXc9pkoVIdGO
         oyGCPYVXAqilVFV4gggXigzldt36KQEGNw0XeWXPVMvHB4bRrkbFFWfEL8z6NZbL+UPQ
         D7eryEcAchTYkvUG9sKx3KMpEujwpTojI0GlO9Vz55Uiin8dOYxucMRmlzQQd/c3ixuw
         KpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418948; x=1734023748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNxP0LFln0zgtOWEPbGccnsmPf7gfq1YwGA1WaBfZX8=;
        b=mPf+vdmUBfs4ZyK546VAj0y7FQQJ+0dsrN2pCFwQOw24+ZP62lV11l0rVqqbxTtXMq
         bALjpslheQ5OaKM4R5DbCEkyQYdSiWFUfBX3GIMmWBGC9eDzSaRn6R99nyRjq208kkZK
         ruJJ4k1yAEFNE4SY1w2xPSo41zVE6YHgO0JyhzetWuAGtA6kQsnBRDkgfUE/MAsY32Go
         lG81gv3PgvF4lqujNuOP0V+07fUk9v6uBw/KFJZctQb7U6IV+0P/7b2I0UcNZqBwxb7l
         hnAfcmyRbvsLyhHdXex61Tt3KN/MX87UpaGk7WJ7Zti87KWy0wMwLRhpHQnMCrGn1blA
         m6tg==
X-Forwarded-Encrypted: i=1; AJvYcCUTAdZoKFruCQWSFjkpknv3xmgd0rFia/lvjaLpmFYXvxgcuSVApKXu+B3SBCM4YVAMGPwT04hTGDc+Sbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTpVAgSkRJiD2IQaiFspG9nR3pOgOOWCVmmogyb1YV/4WHWJoZ
	/NDIJChAjjXMBbqX44ViosQH4lyxd/lmInkfBIlrkRaKCxbtD84ooZSeCMGUYU8=
X-Gm-Gg: ASbGncvktIb/2t/OUeZCRl3sxda+Mg2upuYWgTKE6B1JTp64Wm1dSk6avSJ2BSHIQgW
	n3BSwEr6K2bGUJWrQOsuGzYGbJ4fDDNMY9T7++7MU/Qs//Dx2Pnmu7yXMj09advIcJ/3HcosGT+
	anFrupVr7v4Z4uZx4e2C23y+5b/d8fotPk+MYt0jLN93Y6Ngg99zJysZ5MgqWNM2NlEYv6casPq
	nDvWDiiVUca6QBMNusYTWThzXmtGeMrPL8lEN21+MdiuzPJOeHp4PCBzazqm3aTZAbzu4AraGa7
	kHzfLLoiYLKNjL/HUgJ0pW3OvXI3qw==
X-Google-Smtp-Source: AGHT+IEyfN0BrcIPh71fjjX8E4/Bx32mFLWHQVrIs1Vx7rUsYWJpnXHHPExUIEGLfLu7e/b8DQpJFA==
X-Received: by 2002:a05:6512:3087:b0:53d:ed89:d78d with SMTP id 2adb3069b0e04-53e1b8785eamr3514553e87.5.1733418948210;
        Thu, 05 Dec 2024 09:15:48 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e22947384sm293663e87.45.2024.12.05.09.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:15:46 -0800 (PST)
Date: Thu, 5 Dec 2024 19:15:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: Re: [PATCH v3 2/7] arm64: dts: qcom: Add PMD8028 PMIC
Message-ID: <jnqgccc6penjqmkhursdlbc46xctikvovfa26vlsvttxwqo5zv@uwh7fhixrmrz>
References: <20241204-sm8750_master_dt-v3-0-4d5a8269950b@quicinc.com>
 <20241204-sm8750_master_dt-v3-2-4d5a8269950b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-sm8750_master_dt-v3-2-4d5a8269950b@quicinc.com>

On Wed, Dec 04, 2024 at 03:18:02PM -0800, Melody Olvera wrote:
> Add descriptions of PMD8028 PMIC used on SM8750 platforms.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/pmd8028.dtsi | 62 +++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

