Return-Path: <linux-kernel+bounces-424707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7219DB857
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FE3163A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29911A2C04;
	Thu, 28 Nov 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3WAHrHm"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B271A08B5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799508; cv=none; b=Rsi2A4MIiWffU2xHSzeDHeEsr94VDILYoREfZRl7YJH2eWfveNwh8ItQunH/fUSsKK8XUwat2kRw308A91Vh3WhD144j2cn0hyXv0GyuIgupZkZCMzoHgd+zj6z06Tiyb0Tni1L/Nssx7ROaXXnJDSbDByjc/Aluid3E09ucZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799508; c=relaxed/simple;
	bh=AwAAXcVxCiHLyktN94ldFA9g6gNEaV+e4+HKqMAxMog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUHrf6HOz7xJAUWBZh2KDyePpZEKUE8EevxVjW51iPwVIejBUx1i7yyptapTkaDGmLQdYdRoIPrWrIZWFdu6CfK4ovzT6NICmuL4x/AiRYmcENQAPQwL8uFhCcoehMoJ8pmjQnAWFWtu6/z+4tBwHajT8I12t+XcTiZ8g1CCBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U3WAHrHm; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so13044821fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732799505; x=1733404305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPbk5rhV91aF3IvatwJOVn64gj4oSvW2resxKBeQMZk=;
        b=U3WAHrHmLLLkFR9Io/cldCBrDNFauMtpU2xIlN6S27/QlSFHELCaaieq2X3lO1+T+u
         k1OwGp4v46WzR+ailSIl96gZqHC82a+DjILMSebjQU1mDa/5WJKdgnYdiWdRkgGv/ang
         wcyUTijqe4E+Z0hxT5KNGpDcvC8XHwTDS/kmeY4+yJdve0vUSmt8V7c3zFrwGr0j/8DW
         jEXZvKv2vTZ2DxtoMxA/ODnuoPvY851C0eI+RcHfwI6VNWczY7CkHaZAMxfT7qZ2vkiK
         LwKkUtwucszaGTS4lFQtsoKtCC4fLoZhcW8XYMgvK8q99x4EVNeFF8Nls6eXJMgeklnV
         U+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732799505; x=1733404305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPbk5rhV91aF3IvatwJOVn64gj4oSvW2resxKBeQMZk=;
        b=kNXwTQyrdViXOK3T7nUIKduhHCbQIy3Wk/fjqjResUokEhMt/qU6CnJ9TFnOxT1exV
         2WuEMc8qrQ0+fBhaIZm20wmhIION3Rr9QSowk4+JHKqrS5i1D0x0MYEmGJsNW6JWvaqK
         5LzLO/ddpW8rxxdI3+xkhXTpzyfedZf6lmpEQbgI/YEPeZlQEFyaljF1DRdyBGRwIgVN
         W2A3BYAwUJAfK2Chcxg3TK8XJFC6PffA323BI8xXBPxdNMVfu5+MgrKYsmvYQovS1vZT
         DU2J2H/tXcYuHqnoP6YpSswuMxkMGUulAszYyUyt6iaJVtw5l5g/4m4gniUxxgoPZktt
         69Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXe7qP9vs/05jLQbSQJta/aEoKsNa9TRaFOJyi2/4WAE99QL5/YD9/lVv2+TcgiSSHR6UshjL/8cXdv/MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjqDWUhuKbaHI9KzyWE4wer3u6bGyRv4NQ3DxI6A0/Uqc9sDCJ
	MJivol4qWrLK1Ub6p+U6lqObQUmaaxPe+cOw/RQcJwKNz1Cpe5DYAJBLUl5se4s=
X-Gm-Gg: ASbGncvHjMqH3M48bCduQ7GEBi0MuTnooAxVf2+1zCA1vkrbqLjJK09LFCpKoke0NaM
	Xl/g76dzXe4w6R1hhGAnUqzZTwcC5CvdboT52Y5iA7N5yJIlcIa7/BuT98rI2sJCw0IpQ/gd59j
	emEJnBstcRxaW1H3FhhfDQ5QW173+U1j+SqXFcJdOVSS0Y04fjS/j7jxLpV6/ekkbYmniVB0Muu
	QO1xe9ofazh+fHa25cyg01b3j+di79SOUH70ZOf8By2bJFqRXRcp9Qom6LlffOpBg2IAt8XxbTB
	FM7CnigpOvkhN9BhopmhbW/MRphpyA==
X-Google-Smtp-Source: AGHT+IHZn+eHpkDk6+N7ur+GKoJQEReZTg7lVnI/e2QDxtl3PhOP/4nRD1I7pB/02VDWpNXcNMAVMA==
X-Received: by 2002:a2e:ab0a:0:b0:2fb:3df8:6a8c with SMTP id 38308e7fff4ca-2ffd604aa06mr55308261fa.23.1732799504621;
        Thu, 28 Nov 2024 05:11:44 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffe1daba82sm1270761fa.0.2024.11.28.05.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:11:44 -0800 (PST)
Date: Thu, 28 Nov 2024 15:11:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, 
	kernel@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: qcs8300-ride: Enable PMIC
 peripherals
Message-ID: <qakds5f4xwoh7tu3u7ritxppdmxf7ppawsm3nfmn7sjetcxwos@7lext4qea6oq>
References: <20241128-adds-spmi-pmic-peripherals-for-qcs8300-v2-0-001c0bed7c67@quicinc.com>
 <20241128-adds-spmi-pmic-peripherals-for-qcs8300-v2-2-001c0bed7c67@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-adds-spmi-pmic-peripherals-for-qcs8300-v2-2-001c0bed7c67@quicinc.com>

On Thu, Nov 28, 2024 at 05:40:17PM +0800, Tingguo Cheng wrote:
> Enable PMIC and PMIC peripherals for qcs8300-ride board. The qcs8
> 300-ride uses 2 pmics(pmm8620au:0,pmm8650au:1) on the board, which
> are variants of pmm8654au used on sa8775p/qcs9100 -ride(4x pmics).
> 
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

