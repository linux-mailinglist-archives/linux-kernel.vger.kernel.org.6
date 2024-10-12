Return-Path: <linux-kernel+bounces-362147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BA299B18F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75418282A57
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7313C9D9;
	Sat, 12 Oct 2024 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdFhtjPC"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCD313C9C0
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728718418; cv=none; b=iYPdJTDJnNHzDeGb69Et1Juo/ozvn8mOcohQPDYkv0sB7LWRiJ1rVfeEaDZQQSLCrEofol7tArykt+yfVwunUoI2rP3mLJKEHO5vJlrixbHcof4RsDRqa7vl3z78XbdRfXATvPpeXabuqOVEjczu5WPTy1lTP8uQ1pE3Whgg32U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728718418; c=relaxed/simple;
	bh=XpkD6PjpGuMLKRRIelZOF4WU1zEBhCUk3dVVAmMMKN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4f2RlvhVPgGAPSFGjVQBdDLrZSUj4zzDNb4yGNgbAgcZxEWIiHwMlclf8l0adxmFyW3nj9mfGk5uwKKpo18u4PKcWCp1exip3Bd8N1zjSc328L1s+10/fgSvVd5ahW+1ChRIzNPnkgJyu4tMZElmHoy334sN1Ks09dnO3AIJGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CdFhtjPC; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fac787f39fso30167551fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728718414; x=1729323214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/HxH5wdzzYhATwK4YbdIT0t+B3UnxhMUOLH9SZSIajk=;
        b=CdFhtjPCbfGBw6G0IN8HA72ttLh3xu3eXD78VaffOjYpcJSKtWiwKwKJvFRhGx5Keh
         yJyoon0mmWO8xXQcVF08ThhAVA1qYdqJp0INDOjJfHES2l6vokETSbT4OE0pbCvvKawR
         7tmJNTEOJrZf1wm2eGLjkbcz8oFYDX90UDGWFbgqKbpTz5PWI4EHovpWehtWJDmIL84S
         uwcWzEThwE57CcG3x2VHWL3IwrCYEPgjT1CXWGTFjTyx0qgTbryCXIMn7Nrq0y20/qee
         Z1xKSMLOYuX/0QdillkvLdRJJhxL0cxnC4st9EWs+mNEdosqmoKxRzLtXp2uUDx0qiwE
         1nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728718414; x=1729323214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HxH5wdzzYhATwK4YbdIT0t+B3UnxhMUOLH9SZSIajk=;
        b=doEGLDvTtqKCaVDWphIvss6YTLaU4t5oT32XYxM3GkHXfi9NnFnRjFBcYP/BXPtpmZ
         j0gF8ut/2yxdI1T95YRnOMoV30J/Rp4SpF25S8YWXHxVmk0njZBuPNgtFjcpGACkzXhL
         3q2obuIqKpgZqwrblvV9Nmb2UTR4P/H4PCqe+oqmr1GVJeQIFiKYJ4Nbf/HB4Q1sv+qG
         XY+WwoprKfh/cAuKFMS62yt24jyIiL7ow/pjOV5CNJFYxCAIHJTYtymE/wsVBRlvsDYL
         cTPhrWZ/b2rg7JBG4HRp86tEOWDTjiTA6Tik7E7Tv+vkQAp0CvOEPSEaEe0hxpAsbkZp
         SP6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXE+OkJP/0TpSKQ/9QTZCFTO45/YfgZ3/C4SZ8/UTyZRXHW9oQ0QwXV7mbeEXgXb++5znV5ZCCXZqhprEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpMO8tJ46OKSFx5UVOhkkCl323DqLvozRlY0UM8S2nkWe0HJfd
	b27DOqxFVx0VGNbqRZ1lgah+84snPvBCV/Pp1Aog6jYk3Cfd/F/bbIUKiGfcbd4=
X-Google-Smtp-Source: AGHT+IHy04luOQ5N31Y8h7T44ACeH2SV/eM1h6QEEfVLa/G/QNFeE1H9wyjUiEaXrCKjKx7jotKsmA==
X-Received: by 2002:a2e:b889:0:b0:2f7:51e3:fe2f with SMTP id 38308e7fff4ca-2fb3270b0aemr21112811fa.13.1728718414445;
        Sat, 12 Oct 2024 00:33:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb24590c17sm7156081fa.39.2024.10.12.00.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 00:33:32 -0700 (PDT)
Date: Sat, 12 Oct 2024 10:33:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: x1e80100-crd: enable otg on usb
 ports
Message-ID: <vln325xaz2sgshikl4lytdqjlra56khz5q4jp3vzmk3xojrdu4@w3thwqwpgqqh>
References: <20241011231624.30628-1-jonathan@marek.ca>
 <20241011231624.30628-2-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011231624.30628-2-jonathan@marek.ca>

On Fri, Oct 11, 2024 at 07:16:22PM -0400, Jonathan Marek wrote:
> The 3 USB ports on x1e80100-crd are OTG-capable, remove the dr_mode
> override to enable OTG.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 12 ------------
>  1 file changed, 12 deletions(-)

I can not verify this on the CRD, but at least it matches the
data-role="dual".

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

