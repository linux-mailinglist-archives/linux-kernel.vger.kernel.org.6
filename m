Return-Path: <linux-kernel+bounces-525889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508CEA3F6E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8993B269D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3D020E00D;
	Fri, 21 Feb 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wL1U4wty"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C520E02F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147078; cv=none; b=a0cnrn5fjfyNxz2gvXnktV58dc31c/ch6kCUFwRbWL5foUOZqqiluJydVpMxbESAG7veGOtt5d0s/acVn9/X9/2sQTrK3vQ1gaF1fKrN+rDyF9L8YUs9OljLzrwSSDLA+08Yy6kRXT3edJIYyWT3y9CHNMhyra7anVCdCE7qgx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147078; c=relaxed/simple;
	bh=do6kcs4VaPfIUQ4XmVGLCf5JoEMWdQCupCtvTEi3S3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+5NhqUK5QEsbpjCPe26kjHkdjixKmx8kWaa2FFvH2QoUDsCnzIBAj0cRBjHkUa2Z4Y24p7eWRVFxmHzUZmfAcDovcbQPFC4vXYQBYqINWo4cTmfOcOnwZQaVbqtMZqU9758tuYZU1GkURmW0Igc59iclDACV1mid+/4M7FQuMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wL1U4wty; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3061513d353so22415501fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740147074; x=1740751874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hY7q6HQ4FQaZazAg7YSbphco7l3aJQzJCtoIpLMsi3M=;
        b=wL1U4wtya6qYKibQKOux2flP/Bg1V5rUVdUF4O1fKqQuN0Qg1TD4ASdQLj3uuUOexf
         xKjcjzaK3my1TwFT2hfjeUg4O2zjRUs94WtO73opBGSGyBqlv77yZNGCP9i0TdLN81SR
         ZoxroCsZmF3ZNuv4T9LG2VgHdOgFkocDmVtbrjZRFZT939BdKVNpHsBPIqyxsTTJi5km
         6e/l/g+ZgqnKbQM+M4Llci2HbW6sy6TClvGyBUumVPXhtf3iJHROaRUAJMew3Tkd/IDH
         JVC4asgE15HzAOodofBHJEm+segKyvYZcKXDUpWSpOEe/noYpX1iCsx5jjFRd+/kRFKH
         4cTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740147074; x=1740751874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY7q6HQ4FQaZazAg7YSbphco7l3aJQzJCtoIpLMsi3M=;
        b=trmSDannFCH9SUzD0tLKSjWazROdqFSt20gvc1Nwy0WMjBT5Olof9d+F9wDuBBj4tT
         XVdmGL+lp9shvE2K9kQMMuvyLy01BQMX28SLpAo/r4pgG2d8uMs/zRacN2sWz/gEPkop
         le0Iiq5p3OVFteL+2TqSJa5s5VFFNSrPUgpSOBupIMGNoucQqmTRbgxDFKqdjXa2qoZS
         rgbfbm6p9Z1QQY2houlyiwjvUNwF2Cq5BkobasEIbaIAd6LGc+toXybC0avKRTdc73sp
         phkE4YHDazhGHh60VNtpwwi5n0UmGaUNNDmzH7Db+Trx2COwgfTkwaGC35Afy8dhNtCm
         wrfg==
X-Forwarded-Encrypted: i=1; AJvYcCXd61/GWBlTMC3LZWhQyff4rzmfudfnfvRzJt4vQXT7HYgnUMBU1+k13w+zZG26qOOiHtqwq0nAkAGYV5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNs8Rqf/GVnaHV3yLGrCn2zpKkfISgC+5RD+8a8VO9gibxKBV2
	Yi15Cvs/vj+TFIRd9f3lU+RApRVDPIfni5kHznWksf6gM3tESInaSmJvXNMnLmA=
X-Gm-Gg: ASbGncvHH3e1VR5fXRXriXc5WbWtstKzPvJqXjEQOUrA3vMMNPXiPwbt2sOCfOQ1eEk
	IRUzNQTPN4Yc2KXxmt12M1Csu56ksiShUgSEoE2ZpJHtzjl/nv+zmsppB8pMd4q59Io7wjDDBLx
	UCUY+rJ8cTHpqG/qdkAlXzIRuHMbqYh0oDPhLgg/2/gjbqK4f5ry0XCfOue4ZZhpsby8MY5taFW
	G2eWxYxCRqbxA6Okw6gtS5iCyfaMIIOVPSqFnU+CkDQN4UYfH2+9U1xsKzo7oKetDuqZyQpAM65
	YN9aYnvRNvOOv/ddEtbObgJOZYQGJm/GRfMn6FfQyTeaA76JlzJIChdr4FSMYmMmn4InE5PXpLH
	xRsZQNQ==
X-Google-Smtp-Source: AGHT+IF4YOFfa5Kt8R2qRuDLGtHoO3z4a0J1rMxXFbaWLFLtIOV4Chzyik4Qt1FBw4hvpqQhKIqgvA==
X-Received: by 2002:a2e:8202:0:b0:30a:44ca:7e72 with SMTP id 38308e7fff4ca-30a5b20dc6dmr10079311fa.24.1740147074062;
        Fri, 21 Feb 2025 06:11:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a3a6d3dcesm13384331fa.67.2025.02.21.06.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:11:13 -0800 (PST)
Date: Fri, 21 Feb 2025 16:11:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 02/10] dt-bindings: clock: Add Qualcomm QCS615 Camera
 clock controller
Message-ID: <ljfgljuhlpkjvqwomhvq5l6giihqv6h5nzswncaqgelvjycgew@bcxjrgbj3lts>
References: <20250221-qcs615-v5-mm-cc-v5-0-b6d9ddf2f28d@quicinc.com>
 <20250221-qcs615-v5-mm-cc-v5-2-b6d9ddf2f28d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-qcs615-v5-mm-cc-v5-2-b6d9ddf2f28d@quicinc.com>

On Fri, Feb 21, 2025 at 02:50:13PM +0530, Taniya Das wrote:
> Add DT bindings for the Camera clock on QCS615 platforms. Add the
> relevant DT include definitions as well.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Just noticed. I've never replied with this tag. I've provided a comment
to the v3 of the series, then in v4 this somehow appeared. Could you
please comment, what has happened?

> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  .../bindings/clock/qcom,qcs615-camcc.yaml          |  54 ++++++++++
>  include/dt-bindings/clock/qcom,qcs615-camcc.h      | 110 +++++++++++++++++++++
>  2 files changed, 164 insertions(+)

-- 
With best wishes
Dmitry

