Return-Path: <linux-kernel+bounces-545585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD97A4EEDF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D0D1893751
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BED2641D5;
	Tue,  4 Mar 2025 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBUSB3JN"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7B1FC103
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121739; cv=none; b=MyAyD49BWOp5bEyXlGOisYJ3aiS+pJrtoAnekkqtOpbNuFaM+h1VOL4qY6KxaqlcRcf34dIXPeGINDa4hKLvOE3aVEhXQpY+M09dyro1+kvZd3PltS8cRYia/NAWXnJvGnnBfgMlT8lUQy1q3uBvw01rjL7Y7kvc7BmNiYZhitw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121739; c=relaxed/simple;
	bh=NSNt9Id4lXxpJ93KsFSenjzsktLV4E4jeRdB9AxjTdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qH3Y09WVQ5e9AfQzMPXh08EMzlOIID39cjzFdcSs3UFgmDkOWjvxv+59n7e0nIGz66yDjnw+0y+SbH4NrTCaRK8NRM6vZwA36/btNkwN3HNN5h44USDa9h4SfFxkUr0kTFciF+fJjJ8BHET4GPHPI9U18jtX3leEO2kbv1x9We8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TBUSB3JN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-549644ae382so3238619e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741121736; x=1741726536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zlnut3W9WMDFb8LsQDCStS5e+lluNoYb/y0OfzkgWag=;
        b=TBUSB3JNOYb7BZUCA/zt0FRsICNG5GXpiwgpTfqfwwi71LeajB/CHyB4mwAmD95LP6
         ElSy0COPGzhSBQDIb4/maxmLSr39HA+OJTXL3eLzm3uC3KFQBW+UHbot0fn84qGS5Ja6
         UfE22bC8Ek0tSdmN7OZgdXvgBGRowIlWxOS6mE7VRq+owzo7ib8LTS/1hXiPHR5RvI99
         Ah7cJOFH/3EjKDFuNHuInNAmfXuiEkGcSaP448qWYPB3F3FhCG7mAAq20bGQjhgnp92f
         tvejK1GubQK4SyB+U0aBcMPJk6V4NDMqyO4EzP1SIpeXGJ8cjPYf651pg7tJlzlf1Guv
         KWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121736; x=1741726536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zlnut3W9WMDFb8LsQDCStS5e+lluNoYb/y0OfzkgWag=;
        b=TEu76urQj9ssFA30l+dI9dg0gmS/ZfS+OUlKNfmaOoEmot2tqjZZlIXjMQy7v2QTlx
         MKxvPZdH12+Q1S28lYblhIKFtkz9Srk/XPWOX0DrCZStwZSYeeR2kDBIrsDM7VUgaNhq
         m4v1VEp7Dl9HWqI/xuzWkQNehFqbE0aodWi4JviII8GYKWJapGoSpckPv4eGtno4w33T
         W4I6Fuentu4Vxayo56P0y9Z1DEBWe3SJdAmTNZk6IRR9TCNL68YHAPWkETdWWkoFGX2d
         9YqC1m5th/Wb5u1CMEqs7/9ei45iByy2EP0+3SYXw3sFQkVBZtV0GWWj+Nw166pR/UMv
         ju7w==
X-Forwarded-Encrypted: i=1; AJvYcCV0VUms3JMIX2ilm4vGZfjCgYSe+CDrOHv2rR2scN4mwfZno9WCJbX39VKOI5qICMenjfKk0YuPcXoWeH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW5jj1X5SfNLTkzKvntuvH3x5XqYx4IHHn5kH8eusqqSiJhT8s
	x/zPVGLgpbEAWm3kBm31LZrxbmhiysdTGRDw1WSj6rtP1CMSUOKHug02GaYXlmk=
X-Gm-Gg: ASbGnctzwGqhQbE9N+fKcdzTYF5ikXCVmIBGdT5Vqrfbx9cIHZgulgSr32E8htEZsnP
	DCz1xxo/jlv+Rh9Z9jcQN1T5SDUhtzT7F/zFGUwN67lh8VP8MdNgWgvqsi7h434gf7IU2zBAunc
	8laUcDVm5Gg9rkG4dfGkPEH5zh57vn2MPMgmdlp+PQghR6AGbu1RidrHZQrRkxwvrB30fW152GI
	Y7eDsehGB1DgcAaD7xhK3Eirfdge9KQ/RLSHb9rQDYRMzda4B1vDYcdE8yYw7Ki6hnz2IQKJ7sh
	L2JQINlz+UNumm2JagQRrczfHpgNTaIn7+NggWPnMNo4iwuGotCEroUwWOgfpOdfBYrqnPB2T0g
	fvOJe+eHciYZ6/eMiq90NoT1D
X-Google-Smtp-Source: AGHT+IEIFo+QJ3gjvVNTH+uDIO5F147DYqk0crHu9Qb2qxeLZA30uWfc69h6oFKSES/bityKAXb6aQ==
X-Received: by 2002:a05:6512:33c4:b0:545:381:70a with SMTP id 2adb3069b0e04-5497d3368cfmr244970e87.15.1741121735864;
        Tue, 04 Mar 2025 12:55:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495c9d3307sm1006543e87.81.2025.03.04.12.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:55:34 -0800 (PST)
Date: Tue, 4 Mar 2025 22:55:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 7/8] arm64: dts: qcom: sc8280xp: Add Venus
Message-ID: <cvbunupn64syfeomju3rb4n2xfri6zdjm4dfo67osbt2esrwuo@7g3ji5hnt5bc>
References: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
 <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-7-279c7ea55493@linaro.org>
 <77475c23-c173-4512-b257-d7b01fa2054d@kernel.org>
 <d4d658a3-e276-4e0f-ae71-5efd077e8a12@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d658a3-e276-4e0f-ae71-5efd077e8a12@oss.qualcomm.com>

On Tue, Mar 04, 2025 at 05:41:27PM +0100, Konrad Dybcio wrote:
> On 4.03.2025 3:02 PM, Krzysztof Kozlowski wrote:
> > On 04/03/2025 14:07, Bryan O'Donoghue wrote:
> >> From: Konrad Dybcio <konradybcio@kernel.org>
> >>
> >> Add the required nodes to enable Venus on sc8280xp.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > 
> > 
> > SoB and From do not match.
> 
> .mailmap breaks this
> 
> I previously worked around this by kicking the relevant entries from the
> file, but that in turn broke base-commit in the cover letter

You can override that by using 'b4 --edit-deps'

-- 
With best wishes
Dmitry

