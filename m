Return-Path: <linux-kernel+bounces-204161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018B78FE4F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B0D2874FD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809AD1953AC;
	Thu,  6 Jun 2024 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EzZIQ5FE"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476BC153593
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717672471; cv=none; b=dP4UAYvwgy1XM/89/up8zvxJkQfL0auninAP0dop3NVf6EjH+DuDKRi3aUWTFIBBpsvEIXq9Q0WBjbZnjmcaL9HvmNkjmzTKX67ULs/HFV4qdl0UBixvrnkt0f7Qxwd1xsiOzXHtJrlb9fDWJIGo897T94Gltk5wLH81aWEqkIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717672471; c=relaxed/simple;
	bh=m4HvQNfKfMnGQd5lte0NWm9syqvGy/phmV2IZKjWCkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PS3ZAQxrMxKivdb0jqDj7bfl7gP+X4JGQMjiQp+v4hl691WmDvgKt05STk7MB+9LgHtpC+PyGxfYRMaOchinKDKWvBkwgs3xAykU1ZGi0ZCBLkFiC5cAOx1PAADft0euTCWx+uftYfY+c/m3EXxlDFVumYaV1+VyR6lW7eu8ddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EzZIQ5FE; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52b894021cbso1111789e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717672468; x=1718277268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui4PfReL9mMUWTRJ9WvcJ92QeQmc2UxwHHGckj5cD7Q=;
        b=EzZIQ5FEsfDcTfMS+iCNbwuGzeGkxB0R/QscwO41MlcfebTsZsVe8EHIgYEOcmYe7L
         CflmJjAfYYxFCsTKboBEPVN5oklAdm523jxAZLFpXzWxscRRjlVgO8cNwvOIROALoScd
         e9uJnJKQUMtvSdv5Jbc/sTifDoYO+j+qZPaWoEAVzccXe5rvQieVwZXBOAR3H7MqJLKd
         DEBiTKtel8pivskNhqiuyK880ikz9BoXaGtF61POB1iQP5ZldgPKpX8mAbPqqJ9v5FMl
         yLnJ9cH5PeeIaDPj0jC4n6wRSF9a/cu3D0PkxAcr4q48X3K7ORL5AgdVsugv6FP1bYsJ
         gALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717672468; x=1718277268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui4PfReL9mMUWTRJ9WvcJ92QeQmc2UxwHHGckj5cD7Q=;
        b=P2urHnUl7A81ieoGLoPxr7kEtCCfwF89yTHFvSJzVZtF9x10MHztgrAmdd+tqNnD3+
         2LwSO2xD6rrd9Io3/WpVKsk9RuQxU+eawd9C9+Ejn1ODCB84Zq0+/TELDZP/EJpV9JTe
         MfK2Y4W2GWio978mAFYsuzU/0asGcy+nGnpabm7bakuc450TGZIRFbyLYhr8qdlqthro
         TzCrw5tj3wZAaABNSl7tctowIOHZN823rtzoxbEQ7ijHY9621ItMoj+V+wqbjGCdjDm/
         6wOstIRf/PMfKVYE3xFUtsN9QZo5KJNdyd6vrWKsqwtqdcBOJnnEIgHrczOqb3Z87BM1
         RGag==
X-Forwarded-Encrypted: i=1; AJvYcCW3Nm+HcJ9PTLfo0RyCrFwT0xLBGZrmGChpzdLsw/zKmHMzC9L2rbqOIg8BqM2RfC2qY+pXxmOZT1XQcZRSOOLj6yMZZVeidcFo4XnF
X-Gm-Message-State: AOJu0Yw8odIbV+ESYo4HMIbFkL+smHE7pdADflTnFX98Qk5H9Fd2tI+R
	0GZCiGaE4Tjdg2exzMx6atop6RodK+Lkfe4YHCN6YbtWJPwYhasIGKk+Gdyhipg=
X-Google-Smtp-Source: AGHT+IEzI5txOcVEujaRIOG+YZa6D9ihaqrUtvAFaXO31vun5FvGNaQdGTeak7yW868hKtefFmFJaw==
X-Received: by 2002:a19:2d4a:0:b0:523:90df:a9c6 with SMTP id 2adb3069b0e04-52bab4fa5b2mr3071376e87.50.1717672468464;
        Thu, 06 Jun 2024 04:14:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb433e22bsm165525e87.287.2024.06.06.04.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 04:14:28 -0700 (PDT)
Date: Thu, 6 Jun 2024 14:14:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: x1e80100-crd: Add pmic-glink
 node with all 3 connectors
Message-ID: <rjcpewe33tnwamoml5wrdhwzuy7kiqyx6sf4tzn26zhshmdnni@lf7itoregb66>
References: <20240606-x1e80100-dts-pmic-glink-v2-0-972c902e3e6b@linaro.org>
 <20240606-x1e80100-dts-pmic-glink-v2-2-972c902e3e6b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-x1e80100-dts-pmic-glink-v2-2-972c902e3e6b@linaro.org>

On Thu, Jun 06, 2024 at 01:41:53PM +0300, Abel Vesa wrote:
> Add the pmic-glink node and describe all 3 USB Type-C connectors. Do this
> for USB only, for now. The DP ports will come at a later stage since
> they use retimers.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 122 ++++++++++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

