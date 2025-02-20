Return-Path: <linux-kernel+bounces-522956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 830DEA3D08A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E78177A73CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471E61E3774;
	Thu, 20 Feb 2025 04:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqbB5WL3"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A63FD1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740026701; cv=none; b=SvadE2pns8roiUftFyyF4AdXNE7Xwat/CIuW7Cco6TrgXhwMqcB4G9JFcms97SrHwIYDcj0Gz2DJ28+ZixPxIz19PK5XtjkMhQny6RhDW8Sqj1g/Gu11X9jiqdvsj56e4m0U/0qaXSLzwA2hdn8MFLsgljxuvgIrbRMhbF7cVA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740026701; c=relaxed/simple;
	bh=d+iFZuxJO7eL6REewH1kUH0Ywtv4DV1Yvdltas+I7T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfZV/rJm8cY5jygMmBjy+YBhS7SMKhnn+mOtLtcASoLKeHCCHlD1B7Zps9JF915fl0AOpdIMaRfgyyZlIAmpV0xzJSndUmv5/k42UWLKHtQfUQVSUHWtIcM/TMw8ZHMOkB0RRTGIvTfD4H1POzU9ccIZEIHD8UHkhx4Rd2l0gv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YqbB5WL3; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30797730cbdso4773901fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740026697; x=1740631497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LtYcQ+2FJMDcbUz4z18Px8ZZK4xLqjkYjz2BFlX/9kQ=;
        b=YqbB5WL3sWglGXTy1l0wH01PYt3OzIX+4ZR7fvWbF8hG1O1YzAr3P9n4mIey4DQXX+
         2znfuVY9QBIpCchD5aK5oE8QhjrE7KZu579u40ylM/v4qukhFSqxvCYsU/vD6nIsOy5L
         oK/4tUAtfmZHB3G15A8WyiGL+UL2iLIEy+TP/CKrVgmNI03wC8tBBlI1ggmKYe03WKWU
         ua/jsgDX7TtMLVd5/Np4ZDkUX0ywRWiHKfqQVqzBEU/LlIMeWTNE7SnigfoVjEclliNY
         sCW1Gr4kyL/JjxnsqMEMmBDeYtXI0sV8XT0QGT56rpOGkkQU5LOyDQc0P6NV/SryQHyf
         tjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740026697; x=1740631497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtYcQ+2FJMDcbUz4z18Px8ZZK4xLqjkYjz2BFlX/9kQ=;
        b=r2atsliHef4VO1oMBfRHXxWzX4HLnHSfQQ3oc8FzAL+BNahifV+0hnMeYv/CGT3gZM
         FaGQUo6yPV8THPUCzYRHGoVeMKDsN3P2qozXcoZ/8t8t1BYrZYuExpOdNVdjpiwZjMaz
         VuYGjPfFpN2RTWvjXfl+gEizsyJfxa4M2UycjXiHO8Hi+9coGLrezrZ4tH2kNmBeBxvR
         YxQPzTlCL3ZlDcNa8BkKKllF569LBT5sjVc90jv+WysNYpIw6PfYPf4DmOngVy/Ub3Gb
         qCqbjDcCYkxDsepqOVTLqEKTQwtF5+SGDgUEV2PaECpYTFkIn6HB/TAXh9n54MtHHvhk
         1ePA==
X-Forwarded-Encrypted: i=1; AJvYcCWwl3Q9acOaYd97zCx6L51LhLQHbWnWPjQMEYViHrLVkQki1gJDdSVmmqzCk4m1jXWxTljgYhbINwWheMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMiZu0b9OoU8okDauRbZPGnq+tgjSo1Ljo4KI5MPStePb7qsGg
	Um/9p9cqfLjkpFBn9QYhZFg37wip+mOM0TFtWtGgOOudWLSyeO//4nhtkjY4vtQ=
X-Gm-Gg: ASbGncv3Fl+GeP5yaE5eOozGlFd0zCubtMANw7Jv3BbN3rMJZFEZc4rGUkzqO/qM/oF
	8oCTjq8LC2Us1cCUBCcTh0oz4xnHtLRBByrU227PkZdarPN0rUpfodRZIW6yUnXvG27vrFkoz2l
	0ErUGr052poSYwwyxPnvpm8hVQP/3fWzkjxcmCVf3960Dwzbv8DOz0tFRAwAMTx5rzuY2jUw+Av
	E1wUIziAPMeeEqoBwgonBIs2LGDPPSnMrLmgG08JZ8kz/ONCEsHNc7WHK0j2J0vqepmw+YZBcOx
	Jr28yFXi0+lntW0IKLOinU1lIyjLHRdOxymaE++oH3j1p8Pf86F8+3kZuxckW0FZ2K7Z03I=
X-Google-Smtp-Source: AGHT+IEwZ0li2gmqCbbSb/xDJ0sR4BsPeqpGMzMpoUos8tWg+NSjnr7x/0yyIj4p3yB1OUI7BBnjQQ==
X-Received: by 2002:a2e:965a:0:b0:308:fbd5:9d2d with SMTP id 38308e7fff4ca-30a45062d78mr19375761fa.37.1740026696916;
        Wed, 19 Feb 2025 20:44:56 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309a0b59bf1sm15738491fa.59.2025.02.19.20.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 20:44:56 -0800 (PST)
Date: Thu, 20 Feb 2025 06:44:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: qcm6490-idp: Update the LPASS
 audio node
Message-ID: <kaswrgmgmrgt6uukevi3oon7mcrc4hlfyewx5r3os6j2oyhb7d@izgybktb4fst>
References: <20250220-lpass_qcm6490_resets-v4-0-68dbed85c485@quicinc.com>
 <20250220-lpass_qcm6490_resets-v4-3-68dbed85c485@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-lpass_qcm6490_resets-v4-3-68dbed85c485@quicinc.com>

On Thu, Feb 20, 2025 at 09:52:52AM +0530, Taniya Das wrote:
> Update the lpassaudio node to support the new compatible as the
> lpassaudio needs to support the reset functionality on the
> QCM6490 IDP board and the rest of the Audio functionality would be
> provided from the LPASS firmware.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

