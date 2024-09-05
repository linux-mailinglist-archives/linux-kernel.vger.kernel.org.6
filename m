Return-Path: <linux-kernel+bounces-317158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 938D396DA29
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A541C24728
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B4A19D891;
	Thu,  5 Sep 2024 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMulNgST"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FF119D07B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542585; cv=none; b=fRaC0MEwHMJFE5YNV+cUMG1xipIWKy0UuBNTLeA/v6f4GctDC/yxFuHxuGIg37eWi06JRw97lQa+mj0t9+butXwh+frbH6BdPLURaDdq+ExrEXukuu3yu5WZZEcOS/gaiRvYvIcN4NqsHjhWbTHDNBF6yIVYS8zsiuxdlBKLwXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542585; c=relaxed/simple;
	bh=kidWxzS9Q95Q5dbm7Dd7JdsGGV+Dkyu2kbgsrCl8iIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNU5cdrE0gR/10pEHUEI1VUhaQB82kUYr/omf0dO7OZN/nG7Kf8yvErMvukHulBfwcuMyA+Owrwa3h6et9PhQ2K1FqkuJpf9OtT9WgcPIZm2wkVBsLlv/7IkU976f3sJAXpeOBCXBoGnPXWG9m7bZCap0NBO8OxVoH5D8wD46YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HMulNgST; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5356bb5522bso1012240e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 06:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725542581; x=1726147381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgOzNn37XJnh9r05Bul3VVmu7PlnqW66dmTY+HEc/b0=;
        b=HMulNgSTSPhvxAw82bJ6ERuONzU2gTBC2gV1uuYVoECMLGDtJetnC2SWHiQbxrzKHp
         NmjI0kCvX9YxCwHv/ah+7/BEt0lr3qRQX18IhTAqaOGCyCzd/ESjvAr2zOOL3C2MGv8I
         u/3uOFr+wmasRiW7eybnx9U5rwyDbF0fhxu/rbPHYEqnhobEPC04RwB7huzKFDetCpyL
         wy7TFDXiKKlxs9yck721nXiS58SAM39phSBIpqRhCPsDkqMQKe4wOaO2zB9fmqGtedHb
         f/qpF0EyZSeX5GgR7ZSw2KTEDC1QzBdYBeErTlMDrxz30ztkhs3Z92z38OWrhGpw2HpS
         KWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725542581; x=1726147381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgOzNn37XJnh9r05Bul3VVmu7PlnqW66dmTY+HEc/b0=;
        b=eLJW5YVh6XVsjmTdLUodK/VgkxdiXbyG4kpBXxNMnZUlKk85FJjFxz8WFNyHaXn28b
         OBqy+ciQMvqKxEUwNOTyjPAGDfTcoeko06GpQi+SgPR9SMBHWbgfzQS/vz0Y7utrYsfy
         P/sy3AetvnLQomsaAv4KAY9hq1ui5TxBXPNznfKpTlF9RlpyN35L+scUem9iMemdl9JZ
         D1yD3zKjJloRLGLMR+blFtvhuLGR5p0OVbwGquw0gBTU2H8GgyYcnzs0xJqj6UW7Bv+1
         feWKFkOo7KTdN8zq3bZVPOs+uXKWJfnxuWrTG2C2hocLzLgohx351jJlf69rAWZyJsjs
         u9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUALW3fxu+5cdLaGFG8H5WQ1XEkm1kVCGX5W6Vq5B7kFVmC6RVB3z0Yy3pMSF5Qu90+M7s2EmjeUVv8HuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJ+9h+Eo8o26tnN9kF4+r01m5QUw3R4K33wb1UZC+m2tB05iw
	h1yLEnKtp6B67ieRudtQfAetPghynPfbmfzrjduIU1RIbtbNZ8Z3oNQun71cY08=
X-Google-Smtp-Source: AGHT+IFQNXuLaQLGzDvCoIvfmxCmDxrL6iOajkCgUhh3bCEud0vFaRWrE+nDSh1i5VB6t3aa0vfOqg==
X-Received: by 2002:a05:6512:2c90:b0:535:698e:6e2e with SMTP id 2adb3069b0e04-535698e718dmr3322918e87.18.1725542579933;
        Thu, 05 Sep 2024 06:22:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535681cfa59sm434490e87.187.2024.09.05.06.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:22:59 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:22:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org, 
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, viresh.kumar@linaro.org, herbert@gondor.apana.org.au, 
	davem@davemloft.net, sudeep.holla@arm.com, andi.shyti@kernel.org, tglx@linutronix.de, 
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jassisinghbrar@gmail.com, 
	lee@kernel.org, linus.walleij@linaro.org, amitk@kernel.org, 
	thara.gopinath@gmail.com, broonie@kernel.org, cristian.marussi@arm.com, 
	rui.zhang@intel.com, lukasz.luba@arm.com, wim@linux-watchdog.org, linux@roeck-us.net, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, iommu@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel@quicinc.com, quic_psodagud@quicinc.com, 
	Praveen Talari <quic_ptalari@quicinc.com>
Subject: Re: [PATCH v2 16/21] dt-bindings: spi: document support for SA8255p
Message-ID: <vk2jiq2rjgz7fdoq65qdhxdx37lbkoe4uq2c2fmu7aiu3c5pmn@l5skg7xvogun>
References: <20240828203721.2751904-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-17-quic_nkela@quicinc.com>
 <66458a5c-5054-44ac-914f-e66281ee43a9@kernel.org>
 <9394ce8b-9a43-485b-8d7f-33930251ccac@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9394ce8b-9a43-485b-8d7f-33930251ccac@quicinc.com>

On Wed, Sep 04, 2024 at 05:49:40AM GMT, Nikunj Kela wrote:
> 
> On 9/4/2024 12:48 AM, Krzysztof Kozlowski wrote:
> > On 04/09/2024 00:02, Nikunj Kela wrote:
> >> Add compatible representing spi support on SA8255p.
> >>
> >> Clocks and interconnects are being configured in firmware VM
> >> on SA8255p platform, therefore making them optional.
> >>
> >> CC: Praveen Talari <quic_ptalari@quicinc.com>
> >> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> > Also this is incomplete - adding compatible without driver change is not
> > expected. It cannot even work.
> >
> > Best regards,
> > Krzysztof
> 
> Link for CLO branch is provided in I2C patch series. The driver changes
> will soon follow.

So, what's the point of posting the dt-bindings without corresponding
driver changes?

-- 
With best wishes
Dmitry

