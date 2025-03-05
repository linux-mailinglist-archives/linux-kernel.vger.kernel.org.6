Return-Path: <linux-kernel+bounces-545999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81609A4F500
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB5B3A8F47
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83D91624CB;
	Wed,  5 Mar 2025 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIJppOXQ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0AE45C18
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143518; cv=none; b=XNw9GFeBcQOaB+K6qutpQiS9j+9dcFRYGrnLHzNV246GtpFwH0sNct5x95SJ70tn02fGWrQOMK1N0JJbyNXBPSWYdqgH612LZs7i3ZUTW9FEKKTsnGRv6o/1YR3a/qx4xGExOYCeCiV0dU0DWHlGnn7CWcKoD21gv6axmyCN/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143518; c=relaxed/simple;
	bh=N+nG/bO8D2vXra3mywxjpAtZicuK8zOlM9XvlDtvrXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uY4ghpWemcafuRufULFV4CVEPMOg7fxzTne8gCnv+NhEavjv8JWxdkEYqSlPkipYSScj4Ou1Hm3sLjTHDRfwcdwvpU6dSJ3BYazun3GZjzy8bjzgwGQSN0tMOJ20sU3r04Tb6HZG2DQ6N9wstLy1cA1KXQDEZLx7I8d0n0MUzaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MIJppOXQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5495078cd59so5177365e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 18:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741143513; x=1741748313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmggHW8O01EPS0gGRQXTUF3PRDZeyIapChas5mXt/4U=;
        b=MIJppOXQYQrWaUjhTMcdq4Jn1ZXME97jwIkOSN46m1VigYBgs4tWXdzmJTE6/1N2Y9
         xTFUHJnTWGPfwteg+WByQZNGgRAsHzQNvs6Mspicx8OR9S2FQ4H0JvZ2BFXpF+YAzldA
         s1sLTMXTAIvN3COu0MndytJc02mDOafBkx7YGTGiwKaYbVvTzOlkZxCjsrmnSApCIDAh
         sBxiSkY/EJsCU1Y+S1HLAPHUsHbHwKF5pilUedFQBY/y7O7cs+u57RCbcnGc53M1VDNL
         3qGgNp4Te79y0a72WFtAtJwU1JwRhSPidmjSvcDA4cxRNkciCDFJmnpBUMWGtfIwPhnM
         xdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143513; x=1741748313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmggHW8O01EPS0gGRQXTUF3PRDZeyIapChas5mXt/4U=;
        b=aJzY4E3S8GRlU21imbhGLDdWBToiPYqvm1GEa63J22/BesyB0TKij6tTpIw/Z95ENh
         W6kPqgsq9leudsfKPOSD7++lAeHjjcM/ZTBLrMGxW9Z+CUq3efu+Qw1xlumjIeXBBIm4
         Nvo7b6dUNr0647tMcqUYvYDtGtw+iR7HHcSrYMn1G0Z77Qql6qFGpa/O2rzsRaGkrqkh
         nExlFaPV3dLExZV0qb0MtcFSX+Zo9HWrxi0JHBRBYxLt3LmWCUtQRWG3sFYs5qcj2lqk
         WPOMTHpMoUbuD86wQ7zke554EM9w5oZzra1yq/+ciXL3u3wEbT3iIT76hzERnN8k4Xhx
         pYZw==
X-Forwarded-Encrypted: i=1; AJvYcCW+L1IzZBTh8c4SDREauC9ndUHk1YTfOWHIbiDOOKsz5i48UoJuq9vwuC2jrVqN30Mcvkg6x5thUygFhpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1EyYyA7ZT5BSlSev2T+ktoKORiP0JaZgwrcNV8lv88Eo42BIP
	YqUh9CBrI3gmgmx49eBsJzA94vOUars0oFEj9nHdQNf7SH1IXcSJGFVsuRddyHc=
X-Gm-Gg: ASbGncvYHYEkvUfJnkWUIXQ9yp1nEB1srQZeSZJxGYt3uy7UhDjTcTxtBaXHWCqNuAP
	4CvCzCZl58fXuHJZOF81UDS3kL3JZH2xQYzVZNRiM+/JeO5uxXIESvY0454eSR0OKbH7cb0FDB1
	VfO0bmDSAeVVFEisyot+NJFmXdUtsHYz4akJBVsPKIja4godmWp81XdmJt0MhAhttm0l6Nls3wZ
	i6JKrIVI3HnfbtIXkguk2I1QYEmYOnAfLVRatTBK5sVK8rjw21BDsPsvRRiRTYzEloqeLSMczOp
	DxkOeCt2ZWhRzrLlke5lbmt2tblijT3zdwQkTKii3cd/z2RKKMQnTRQc2rw/tyQRiRPd3ItnvYI
	50diVLPLw4NUYUix0j9km0nbV
X-Google-Smtp-Source: AGHT+IHEi7gu0pTeyCm6UNSNFzowmosNeq+ixhhTaaSaHiD2yIEwbXWQsqiTh1JFRh+rHJ1Tvh3IUw==
X-Received: by 2002:a05:6512:1156:b0:545:2544:6ae2 with SMTP id 2adb3069b0e04-5497d33624dmr555644e87.16.1741143512917;
        Tue, 04 Mar 2025 18:58:32 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549579424e4sm1320182e87.118.2025.03.04.18.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:58:31 -0800 (PST)
Date: Wed, 5 Mar 2025 04:58:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: sm8750: Add USB support for
 SM8750 MTP and QRD platforms
Message-ID: <6msx5eontkkunldl45npigj756b5sst7xjhmomlnummbsmncif@ca3hkdvtdo44>
References: <20250304-sm8750_usb_master-v2-0-a698a2e68e06@quicinc.com>
 <20250304-sm8750_usb_master-v2-8-a698a2e68e06@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-sm8750_usb_master-v2-8-a698a2e68e06@quicinc.com>

On Tue, Mar 04, 2025 at 01:56:41PM -0800, Melody Olvera wrote:
> From: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> Enable USB support on SM8750 MTP and QRD variants.  The current definition
> will start the USB controller in peripheral mode by default until
> dependencies are added, such as USB role detection.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 24 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 24 ++++++++++++++++++++++++

Nit: two separate commits please.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>  2 files changed, 48 insertions(+)
> 

-- 
With best wishes
Dmitry

