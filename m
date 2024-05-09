Return-Path: <linux-kernel+bounces-174447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D798C0EE3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA861C214AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4557813173B;
	Thu,  9 May 2024 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLJqdM2U"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29907131723
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715254403; cv=none; b=s8sRdA94ukbqP17K/Mtxmi4VssmDKpD65xNbp2RpH6g46eUNG9siFGBPrBFRqQPNTJVHET+pVpISX0+tyhcrKRXV/c1ymGabBv26Q7tD7LQlPlaukYb+F2dkEWOgndgFvXWKALxpOehJF/uoUXrHrw+JnCJkPor22npYgzYjZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715254403; c=relaxed/simple;
	bh=D7puHKjXDTv5CLRZ3bEx0o+8HxlulMS9vgRBINXXqrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjiDTisWCeImNng7R9Nykk+8w8z2Tjszww1ngdQG0WbIxNK4V1ghZ3kkDSPyOwpP8wyBxLx1q9WvTaW4JzcqufNbGB85HmsS8jBx3Evc1BcPumWhNyeK8yadFG2dnrZpb/Kz706WCI1HdBi623DAS1SJFlNcPQ6nTi2waMYvFK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sLJqdM2U; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62050e00cfdso6332137b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715254401; x=1715859201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J580ICpcOc18LR2tYPLoMdkVY56F2qD4SEKK1qAL5yg=;
        b=sLJqdM2UWqAeZGdkFtmSl3wLNDNq7zngJ8r8Xt0q5b7CvcXbqd5MyD7Vmms96aIiuu
         VcpSM7SqVeLZvYtFggs+bvVPt1SWQIJ2e0YsVTctIGG9NN3Ad1IYqqiayC4Jq8P4oRuA
         MOBEbA3KXVVcAV4egUq9jKfHONImo31LrKGHiMsYNbVmsbrBrU3uuOAKNPaghwCkc6zQ
         C771mTzZREStEbdWrT36/M6oXNIu+XGSecc4DH04C4HbwHydfr92h5DL3UINzfOZjKor
         ydizMMhF3NgQrI5BomC9eB2eXsCcecRPDPH7Ha7vap1iSo9A6XpIUCzTBOJ4/h4h8hlI
         ZFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715254401; x=1715859201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J580ICpcOc18LR2tYPLoMdkVY56F2qD4SEKK1qAL5yg=;
        b=vkfD/mjVaaLfV51dZ31lEO94RyMvrLrpyvxZzMjneNt05XlouBDA1ZW0J3cDN5jWEg
         UkJI23te1TdZfABsNe2E+YsYUX3ogxU+Dz+tCb3KMeyRJ7GCfm4WLuvWQzdwyB9gMrvs
         cHSldxi8/nbKigyGxTCfXxNVEmQ3jj4CDr163UjjuLuUWjenx3gt9Rdu6ivaaFlQNRKU
         JN426kExgpWP2uYFlP6EjHucccLVtK9fs/i2xCGacmEGZJUdN+QtQNj1yyA1xVow4jl/
         aFvvTptn2Z3nSmdwZLwowssNYSGy7NHRzjDN7oA3oDSpNZElTP02zG++kkFItrlUcDYU
         shtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+ks6YXoXR2AOGUW7Z02fUCO9BIZCgtSMFZvFRy8n0YWjKNwuaxjL++aIhfR+vXe8/DfKZ9mfT3CdwEMf1bMidGipXKTinoseam4/i
X-Gm-Message-State: AOJu0Yy3wlesxlqSCrGpiQ7RE3kcC5dube3FnoA972+z4hTjtbopUlzp
	7Q3AlnFQbBo06Yc0MHlrSKsJEQN8XcUq3eJDgnbByuIydJE1DxJAEyJTjk6phF3l6+wajqW24pg
	K98fvb6meGwMoKLE2gxrQkbh5X/a3QjjSHQ6pKw==
X-Google-Smtp-Source: AGHT+IEfaCfQubu0abV2NMgYTivyKDCF+wOYcdPXycOmHmsIEbvjKhurZcgORLCZE2y7Zlgc68XyimSEPRYH4Jo0rAQ=
X-Received: by 2002:a0d:df4c:0:b0:614:719a:501c with SMTP id
 00721157ae682-62085c79e1bmr53862627b3.14.1715254399818; Thu, 09 May 2024
 04:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-videocc-sm8150-dt-node-v4-0-e9617f65e946@quicinc.com> <20240509-videocc-sm8150-dt-node-v4-2-e9617f65e946@quicinc.com>
In-Reply-To: <20240509-videocc-sm8150-dt-node-v4-2-e9617f65e946@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 9 May 2024 14:33:07 +0300
Message-ID: <CAA8EJpq91Ouuwg59CJfM62cC6LsmzOB64ee330c7h0+Pmx_JJA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: sm8150: Add video clock
 controller node
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 13:24, Satya Priya Kakitapalli
<quic_skakitap@quicinc.com> wrote:
>
> Add device node for video clock controller on Qualcomm
> SM8150 platform.
>
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8155p.dtsi |  4 ++++
>  arch/arm64/boot/dts/qcom/sm8150.dtsi  | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

