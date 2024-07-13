Return-Path: <linux-kernel+bounces-251548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEDD93061F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 17:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97EB81F21D32
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F91613A889;
	Sat, 13 Jul 2024 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9bcQSKj"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419DC54757
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720883647; cv=none; b=OzxMuNn16teU5oX1eivpHg9AdnP0Pwe04++LhtQYln/JBXI85Wnd+dF/U0QzO3Pl59B0IoXlK6PCvVZTNiCFIf2ydK14P2zINEA+P/pZhXPGxEWmrGimYLUg4KHjW5S4f3qXuJXxf+LX/Ds1jNopNPsiHYxtuH+9a4JQ5ohTpE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720883647; c=relaxed/simple;
	bh=0zdSR7l8Y5hdwHCfvdLcTSAk427t9D6VXoB/FLM/PAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUGsXyugX4CcX2/wQYsjhisUxn8KjU8HcV465qt0m2Bql3jwzPDqEz45oyx040rOtb0v0OyCEXt+EBhG1gWIXjKS3f16v6zvbBFMBmkOdmzJSclrHFKW4J+s9Z1Lf7UPMdg1/M85E4bHGJtFDPyf+tQ0lL6aHJiCLwsMiahsYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S9bcQSKj; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ea7bdde68so3182788e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720883644; x=1721488444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYfPVmxm0REv9uCaEdee+9qY1y1tGgOQ3u+6wJAJ6So=;
        b=S9bcQSKjAb3iqv6qARN/wCssAEo9sy3jhN7kOqsxr4ij/kOlePdj96DOygvLy9HKf9
         4jbKlucik9BF14Y3Q164RPOOcuBZamuwrjnOjLB6ZT3UVLaoh9eCY004sQxFtFjOyrSD
         2d2PMrQgEm8lpsv2GqyHirZ9y1oeRk12zz7xAOyQ1sI0uPzxUFBkc1A0D5wszIx+4hLU
         k23B0cmMU7e3Cxs/YTsrFhIgU+b77eoBzl+Y6hl61gDNkk3R32L2+dSOCDMyNZP8J45y
         HvzHwH7rxIhEyoxrDLAzDZ4krbRXlnG5Husqm/hwAwk1zJGQVvDI9oMZBF/07qPALQho
         mZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720883644; x=1721488444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYfPVmxm0REv9uCaEdee+9qY1y1tGgOQ3u+6wJAJ6So=;
        b=Lqv4LAJYa1Vyshx2o1nXeSonJKFrsfq4wEmY+0frXqJX47rxjNGAh3dAPgNVSGReCD
         7oguRZlHh405sFMgMtDaCQTDm60geR08TOp8FPTAn+bSjtXJ0eNlNJKu8M+YFxC9pKD1
         dh/4iJzeEVhDfiqKn++kdaT7AhXk/P+CKNiXs4rxn8kFD0DVQCXuOm2LGo5NdYgLv6ey
         H2Gb0zLTfexY/Xy0HcfluFFVpfR+lK7A4ZbDQYv+00kkc4hNdvikT130o2YW5iJoLW7b
         ApMeNZS/zu/9fedqjy94+pAMd7T0G5C+6rfZcgE0flBwXkI59eEsSDdnK02W46ySaaG3
         y2sg==
X-Forwarded-Encrypted: i=1; AJvYcCV58vAa2FevF93d35/ry3Pb7/jr1XoqCjeeaKpxMOzffnqQwf8V3q9wMNhGYJkC9CMCk7b+hohrfQYzQnhKloruzF6a1msOhcgb5ifJ
X-Gm-Message-State: AOJu0Ywfy0VIMkDQ/yss8jYy0lgM2O7Nv2KpER+3OC6qY/FoOApX1Gnp
	IJ8LBjpUuCOkcKsrUiybJSR+oJFi5G2a53Pdbx/ePUsRLB7m7UJcrocNxpvBXFY=
X-Google-Smtp-Source: AGHT+IEZoAswyQNFfESQdiC11PY4tsA15nguHBt2DDuthdgGYgJGvLQYMpauCZKxWG9fNaC7qkB+AQ==
X-Received: by 2002:a05:6512:3c85:b0:52b:c0cd:7312 with SMTP id 2adb3069b0e04-52eb99d170amr10472300e87.49.1720883644433;
        Sat, 13 Jul 2024 08:14:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24e2ab1sm218986e87.29.2024.07.13.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 08:14:04 -0700 (PDT)
Date: Sat, 13 Jul 2024 18:14:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Naina Mehta <quic_nainmeht@quicinc.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@linaro.org, 
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] remoteproc: qcom: pas: Add SDX75 remoteproc
 support
Message-ID: <c2lf35mlot2z646i3jmbpevanhs3cqa2zx3cqjbzzq4w4d5flj@j2l5avnslsot>
References: <20240709064924.325478-1-quic_nainmeht@quicinc.com>
 <20240709064924.325478-3-quic_nainmeht@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709064924.325478-3-quic_nainmeht@quicinc.com>

On Tue, Jul 09, 2024 at 12:19:21PM GMT, Naina Mehta wrote:
> Add MPSS Peripheral Authentication Service support for SDX75 platform.
> 
> Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

