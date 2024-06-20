Return-Path: <linux-kernel+bounces-223469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E391138A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091F41C21F61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5627C6EB;
	Thu, 20 Jun 2024 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGOqHizD"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E978C8C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916122; cv=none; b=gTsadOh8OJmnNNmGnM5ITjpDa3E+1a84xxbrTWBx7OwcjSWGdXRxF/lTWzGekKONjyQtDH7dRXpp2GqnVlv65ZyP+sof7etObnotXCaujtiDDSOY7Kq+k+F69Qaj53q5auNlzAqChW6zyBdJZB19oeicbM5lGrogiEw+AleBHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916122; c=relaxed/simple;
	bh=STh/90eMk3NBXI2lNFEtFDudfXdIZLwimllATDz1Snw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT7CZezjUavtB1Nz6FMCnrNgWIFaRuwKgmao8LJSJyOo5Q1khXdjdj5qC0iabRs+b1SOz0sMW9RQb+4eaLmoBXifTR0U7XY7hskHSuYwYMf3O90gOdDyxEU3D1QVjJbfnkNSNm3VY7y9bW7f9pUh15qIOseOGtwzLyubYXrQXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pGOqHizD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so13558991fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718916119; x=1719520919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0UDba+xJOloimcJU8oqa5SsgqIPBhxJOEST2VwSWACs=;
        b=pGOqHizD+8IyF2CDvSZvWam4F+yi77z0oG6UJVMRE2LBzFevcAwCYKytnWZNjPa+kX
         4ZVXKHDRBzDITl7P+oVDZRAhq1BgTSrNZzHwLp0+sDeqKfSLqIFgMgKVf6Fl6huL8jN4
         3CP0NWaa7QpsZl526MtdA6svs0v189ms3SqdXBK6NbGAwwvnYkuN37b7UkC8gvKyYPz/
         CdS41E9cAMeFrJDnqBxthVHvYeg8ktDTfCvxIMNwAVlqQPBBaqfb2usoaiWZ3pcsq+fK
         9haD7di8+6O2JcHUTKLEBs0VAKve3QSn8nyUdB/JCRhceMIZ49itWiAzyNu1CrNLudo2
         Jv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718916119; x=1719520919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UDba+xJOloimcJU8oqa5SsgqIPBhxJOEST2VwSWACs=;
        b=h/BvIae1OHg4ksbKnQBwzbAPDjRgG6D3Oh7zGZymxzH81gny2visO2m/1imWy3cNVZ
         NsmmxKX4hXKyrj+gD3F+lvwdBaIWiUirGtWUJmEZYARMubVml6ry09JY71DwMtL/I7kl
         IQHTfM87qUqvfir+qRWeotsE8SrjosSTYZkjAqsf6/0j76PDtb2UD1LUkrEtq3ARLd1G
         K0V48rXqgdY1CnWqx2w5s7gWAIQJ7VvpIz9rfWwNKA2Go9YtkKJ/D1og210icGku1MP+
         AcrXSK9/9Rfv+tI1DtKiW+tJQl6oRl1+IFJmFrXPnTIgxkt6t+1l7M8CDCxquLBWd6QO
         5ncw==
X-Forwarded-Encrypted: i=1; AJvYcCVEIPv1f6PkLPRtfWZxxcvZDbHbjFMp2pZIV5bNkOnKSNBcXOksyzOh8Q2qSRR5MSUu66oYkRaAhxyy14dwGBdN7cld9jcb3Q9YBVws
X-Gm-Message-State: AOJu0YwPci0B35gQJ+UPhd1jjyxpY4cG1TuuNrI2NtqhJ/H9OBVNsF/+
	b0ZR0IMF/YuRKBf63XcKEG5Eg9v6L6U3TixDhcy2uguVGEtaZRoM5K01XzESQW8=
X-Google-Smtp-Source: AGHT+IFvDEBziAChv29W9y+hlbHpRWjQtdeBZlkVSappPVb9YfmbDmaebeCTAlFW7AujfRDaP7GPgQ==
X-Received: by 2002:a05:6512:3b23:b0:52c:ce28:82d2 with SMTP id 2adb3069b0e04-52cce28854fmr3654990e87.23.1718916118870;
        Thu, 20 Jun 2024 13:41:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca779db82sm1912644e87.176.2024.06.20.13.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:41:58 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:41:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: qcom: msm8953: Use mboxes in smsm node
Message-ID: <tx5hi7sb5t2lrn5g2atp3pugusaumifnqateu44h42funftybq@nnfsim7c4xkp>
References: <20240619-smsm-mbox-dts-v1-0-268ab7eef779@lucaweiss.eu>
 <20240619-smsm-mbox-dts-v1-4-268ab7eef779@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-smsm-mbox-dts-v1-4-268ab7eef779@lucaweiss.eu>

On Wed, Jun 19, 2024 at 06:42:30PM GMT, Luca Weiss wrote:
> With the smsm bindings and driver finally supporting mboxes, switch to
> that and stop using apcs as syscon.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

