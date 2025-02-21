Return-Path: <linux-kernel+bounces-525893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3561AA3F6F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C377AB874
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B5A20F073;
	Fri, 21 Feb 2025 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1dXC+xm"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C720E6FB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147261; cv=none; b=MpD+/iRh9KYFbbptSsqCvxFYaYnsEutSp4hsw+0MwD7ogYQuHM7c4xL9Puhv2VJF0hqpgMP8m+p+sBMvUtWFX0ppKTJfye9mN+7EPQMYmRBYA9bDTmejGGPAT1f6lt6UWWCQ9GKnKcg5ySbkwlVa4m+2ht8MTjIqZYUZewb84X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147261; c=relaxed/simple;
	bh=8R1ntMvdxgNOKHWq3nr/j34/07DXc1wBynfM1J+M5UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEDu+gDm+n0s6Y0pBV5MV6LWMbBZPUUclgbDBWsR4QBWipT+hdcAvWsuCx6O+Y65F4k1Frq18VWrrnBxSjSPLZdbOyfcG+ny/tivStScfhXiyngJ3oNv4UGqxJn1r2P23FRPK96PqTsSCc9tm4bBOr9Spp7eGboIHoFIHp0Jgz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H1dXC+xm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a303a656aso21462741fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740147257; x=1740752057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjc5mojYE3t4OSrHJVJCVcArh6fCjBoE/KbptrPihx4=;
        b=H1dXC+xm8xwCUrggGtHs/j+pHuuJfcs/GrE8Ohv9Ovv3T2hVzQUaZ/TzSIqeTNN4yb
         4VcPgCyvNHhRVI7EGLpDvpFifDZkT6AeQOCPdA5I4KbZiXuqYE16My0AMA/iFk6JrB1o
         aTPYN3JmOxHR5swrNAK+Rby+EE0SsD9tcoDq/MiaR71/YYE8mz7lbrUQfDbY265FKsFZ
         Jk5fh0uoQK2CN4pzmuQubNO4U70wRHcWPnt3othhntAWEPImafRXc8aRyfbwsMbVnJK0
         4C5OEb87m6i+a83jCCdyPoZPeHqepidDGV/2mHfTrPiRusk0F83I9D7RzG4R8eC/T6tw
         e1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740147257; x=1740752057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjc5mojYE3t4OSrHJVJCVcArh6fCjBoE/KbptrPihx4=;
        b=pCJWzp4PzF8zRrBJ5a01K9f00WU9HgdgQLM4Di1UpXBHTtcuAOoaNjCNXTD1G2K5Ld
         LhktJmnsEUirxQZfDaSYANiS0ra7Pip3QNkuriieI4lgdpRQceokVlXHgXDQefGKp8Qx
         CM94FAvwpiGHBtHvc+zhyvGq42cB8lBE/COf9waLgXpaH2uVZy9L32XN1e9l8cIKXil2
         Nu9xrMCbggj7hnCYCla2mlEVQ2clZkn2zeFIbDSi1GJkYpgqFSJQ3a1VWRCOHCeUVIMe
         eT4yk9ettu1wZIZ3pP+lUcSJTWh6bbI/UeFIVsnddRjgQlGeMTnjZ3iX8j1SYUx2jEnF
         fcGA==
X-Forwarded-Encrypted: i=1; AJvYcCW56exen4fk2PmvWdz+8w67wPHmQLOvMoZ/g0CkrpTn+A0IxT/vu1EA4Vul3EYYbOJog+GSg1Q932GTql0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2rE2kw+g6qFrhZeKukFfm5KBZCPr5QngKndmtYa8FKDVSh9Uv
	YRvOEEiXfC7TxrUpqC08Uf/tY7WZJx/Mj4H1q+GVePMbMsHZKhjLFXNp2v+Z/nY=
X-Gm-Gg: ASbGncsHzV2EcviSc4n1X9CYDwKul3VAQg10HRoLrsvADcywjj2DJR2AVPxasomaoBH
	9cRlvrSNCY+i1nM95Vt3Mj5pSDUtZ8p4IPVf2WTivmc0mVzRCBNwz+Uip4RW3b9BOpV8YKR1Cp9
	4dRXlb6h7Op86mc8pZgpayn0RqbvS05B60b1ou8GpUdd/R15BQdmUYhkAn9i1C0fGKaOouIZjZ7
	X8ee4hH7oYOB+POI20SZqkWAzUmlQJUxeDwlaGPCdtaAFCl0AXPBFHhtNsh5KjRRONderPEyvNT
	uEMqjZba7LMNhodsUuSI8kzt8En8Tm/sweKbpMGf6LiAUbONSYPRo6MYajfmzehbHzbEehlDbwH
	TTwSIog==
X-Google-Smtp-Source: AGHT+IGE3i7E5NeJLGZxn4+JQpuFC+AkpZ8fzRpeljlxc9T2QsR4EDahxkpiTqdExMPqOpBH1TyfSQ==
X-Received: by 2002:a05:6512:3a89:b0:545:2a96:34fc with SMTP id 2adb3069b0e04-5483914820dmr1344462e87.31.1740147257524;
        Fri, 21 Feb 2025 06:14:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545280ec98dsm2394749e87.42.2025.02.21.06.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:14:16 -0800 (PST)
Date: Fri, 21 Feb 2025 16:14:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 04/10] dt-bindings: clock: Add Qualcomm QCS615 Display
 clock controller
Message-ID: <5f5nt4g3fy7446gxnjg53n4uir57hm62ewgusekls5sbmadwez@pfxmhrkck3zi>
References: <20250221-qcs615-v5-mm-cc-v5-0-b6d9ddf2f28d@quicinc.com>
 <20250221-qcs615-v5-mm-cc-v5-4-b6d9ddf2f28d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-qcs615-v5-mm-cc-v5-4-b6d9ddf2f28d@quicinc.com>

On Fri, Feb 21, 2025 at 02:50:15PM +0530, Taniya Das wrote:
> Add DT bindings for the Display clock on QCS615 platforms. Add the
> relevant DT include definitions as well.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I don't remember responding with it, nor does lore find such an email.
I'm totally confused, what is going on?

> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  .../bindings/clock/qcom,qcs615-dispcc.yaml         | 73 ++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,qcs615-dispcc.h     | 52 +++++++++++++++
>  2 files changed, 125 insertions(+)

-- 
With best wishes
Dmitry

