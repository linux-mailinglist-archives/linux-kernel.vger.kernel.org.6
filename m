Return-Path: <linux-kernel+bounces-427240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4BF9DFE80
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F4E281D30
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CAE1FCCF9;
	Mon,  2 Dec 2024 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTioyHDM"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92161FC7FF
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134358; cv=none; b=CPmWjtzMBUcOkp3Ea1BSJnGp6sdjH4kKBVoLxhzM9qICrX48Es9LmEGSKsZVo1VrSN1xtXTvzkzPC/+utLgSsvdkbsuQ27SlAYKGFQ+3niS+EyvpfD/yR3ASNkfrwesFtw4Eqd1A4YTkBkWOYGhioQJtfh597NFIli4TeEeK2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134358; c=relaxed/simple;
	bh=cEz5WCEcvO0LA3NyHkeRpJjFKEfwc7Bb03yBcNKzoGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9n66tf4cDv4/89NWreiuivaNyKzWB0B5IU1mn3Ue/OvAhsc+EDGbJIa2Muky7WDDtKlimUjcMTfrkYPMFUugL2WaQUFpZ1C5gUrtf3vdEAY28YdOylOpMUoT0iirkmNTlwFHvTI2vCyxYnBogUlA/UDNcMn18dpTmCZArjiNxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jTioyHDM; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53ddb99e9dcso3939879e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733134355; x=1733739155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PdrLpX+axI2CPbjnNH3X9noFZkYJRbcHp1c258OKeSY=;
        b=jTioyHDM/gKwYzRH83ICipPzoAfVgg/0SIwxVXVOChYhXA0icuZJDNukrXo2yPaBJV
         OjkWaXDpCgQDMK0d4w0JGEKtVt45gVeM/RKEWNt/YzBQX1Co16Sl00R+IZL9+rnQ+rFt
         IeoLScFYA7+PHsoz7CSORUuidhHKIV0fPWQU2shS/4f1BvyhOwcrc34OdyyEOAf278cp
         MSFAPvDQZbzt8DMHtxZy9j5VCIGQWj6joAtwmvNH5TEycb3o/VNeqq+g3elSpJRDCrcp
         RQAF3foIzsfRJuqhtBD7jmgV5oNO4rEiWnHPK8Lk/Mg/UVhqHoHhi5D4eAbinGqYQT1y
         L8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134355; x=1733739155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdrLpX+axI2CPbjnNH3X9noFZkYJRbcHp1c258OKeSY=;
        b=J4r272mnfHHEfIxGik80hl45GkYNiNujPzb7KSTlbGGPZaO5gM24ihOnTfsigaKLQ4
         YaDC2HacI8CcDpz2zfV5Ru9q571yQYY8AzmPd1W2FJCJF7Hn5cYGNZHMi+E/blSa5f1x
         wrPUokYa2/7+2hHbuO7/CQohjfLtTk5+J2QQWcmRibESWZY2mR2fqAA5jnTIVYy3HepP
         4bwJG3+RIbgrO1whSD2i6PwAA96J4z1+qnlG35inbgLwqIdgNAIMC/7Sj8dFfp24BgkB
         ka+Rk9j6mEmTG9VJNfvgQWn47Qnj/p0/Qc4nlE+9k5r9NwecNkqUHjvNXJnptbJAjshe
         fUJg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Raf4Lpu9kqgTPm/P4Wc3Pwe3QqtxCx5b17qB3JzAfETqrnEHRNMM2OdhFnMPwj/4A34R/BhD9JPpn7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUNUB/xY2GAfe2iVto3rHBsvPMvKLPqF8z91fyfz9Zdo1fdpcE
	8jTkMDWfcvdXuX21DmIcHeYSyuQ4YCZc7ZWbBvMXWFc2kuswv2IkItQJrY9E5/M=
X-Gm-Gg: ASbGncsZDbNCB8O903hhmBBZ2rdKKV4c1CT9N17kjevX5u9nF67DLKDedel53DNPSNV
	yhgTPfz2mANk94TDbMElsYSUvjMia7IpbpXzlsVUELXXfgRzatmlWS3ImflsS4HSPlgg+a4f191
	m+wzg41TO7DTxf876IdP4tM/HMWxlS9K2VSu7AYYI173VUr+cx+Zrt971UDXijDjHLGHl4YQp55
	8aHbVl0V7JepHARDVmD3Mcyi2F0cuBoecG1zWo8d9i+iVQAJ95suR3cjo9JEJVlV8ibj7+Xdhxm
	WQk1+8vBx5/iKhjmrwzYW10DyqXlJw==
X-Google-Smtp-Source: AGHT+IENA1UtOB2vC+9sMeQjU5RSPscJVa+h3RiiqVEgdoucohrY/p3JAOJdi4XwYr8/MGauEsX3WA==
X-Received: by 2002:a05:6512:400f:b0:53d:a93c:649e with SMTP id 2adb3069b0e04-53df0109024mr12516120e87.35.1733134355114;
        Mon, 02 Dec 2024 02:12:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64968d6sm1380786e87.200.2024.12.02.02.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:12:33 -0800 (PST)
Date: Mon, 2 Dec 2024 12:12:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, 
	kernel@quicinc.com, quic_eberman@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: qcs615-ride: Enable PMIC
 peripherals
Message-ID: <lzmfmo2ll5izofq2pcpv7dkhcdawwijxotw45cqu4vlydt4cle@yta6qyume6e5>
References: <20241202-adds-spmi-pmic-peripherals-for-qcs615-v6-0-bdd306b4940d@quicinc.com>
 <20241202-adds-spmi-pmic-peripherals-for-qcs615-v6-3-bdd306b4940d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-adds-spmi-pmic-peripherals-for-qcs615-v6-3-bdd306b4940d@quicinc.com>

On Mon, Dec 02, 2024 at 05:37:24PM +0800, Tingguo Cheng wrote:
> Enable PMIC and PMIC peripherals for qcs615-ride board.
> 
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

