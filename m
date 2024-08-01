Return-Path: <linux-kernel+bounces-270773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCBF94450C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA4A1F2833E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E39F647;
	Thu,  1 Aug 2024 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHL1CJmp"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2B12D760
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495644; cv=none; b=LC2TVblWJ6bLwfKS0K7wKE64O6hnqlva2AxvDpBmbQpUb30Lj41R049u837ytoZcpcObNqKN9PQQrDjfnvv+f4W6jaopr+qVeB6bqXcMJvVZrt+IKGjXqJlwh6W8sqpKy8vCh4tZwc/3aGaMsnkTuISyBsByHJ9JGd7u7SC9np8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495644; c=relaxed/simple;
	bh=KSLg0yzqiI4hPE5ov3n8SQ0mekRG7ftBEc5L0sChKyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMmeJfxmOarNIuQnpdQ/2y8ynhbLI73VK8T1txmTlAg2dQxJzkhjMoQM2WcZsEWl1UFzlnX6dtsnOVBnX4jLibYWzS+0BO7YGKp1B7V1Ru3GnDzn0mxrlX2lKTE9GQxgvzRk36ROCx002bsdURDi56hFY8cbmrlWVSiOxoGKbZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AHL1CJmp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70eec5f2401so4004371b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 00:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722495642; x=1723100442; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mnbrn+r8w67xaS4dRlv2WYPfTmOAIm6sgMTn3y+iDAw=;
        b=AHL1CJmp2PcBF3O+ghTSTaylWJyxJ2QkXwhEf3ak5yDUS1nUf5gDQA3av0u9nhQvAd
         hlIG+DjpFmGPjT8wOsoDDNnFbWFcji2zuIUfFUueBOx2Cp3kj8PbsRhh11BoHmawQaTL
         e9t2TGtlDbi02PXckC8U8FFyn94/GgUxk0lZO/g7RXtdkdXpZLvEZWkyM7sXXsc5i0DE
         8R4tw0s1GRsHSlJ/hGBHPL4kASL3W5Rskixgagd7YZqFVbRrmvwqDmKoYwgiWpQq4vnI
         bT8NdP75Ud5E0ZUGADGjXcH6EaExYECfCbxZzGZZdj/Jw4ADeSi9LEchRu5MdIQgSazS
         ccWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722495642; x=1723100442;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mnbrn+r8w67xaS4dRlv2WYPfTmOAIm6sgMTn3y+iDAw=;
        b=tSTEYicQ6Y5UajTSQP2cRfzrd24lcGwO6QcCr6A9fFXbMaeNqEmHDWWKAeYgGqYQV5
         JcBoSM15XnZpbebxUJWDYpJnrMy39ag0gPtq3vGs9j/3SVDFk+EDHLDYpMyiCXgAmY20
         BqDWWseZ2BATtkkMHr7/92NapA1gzrU8F9fMI93OiWCiOuMFTkTd0ZRtKW4r5OlBzXeS
         q51x6iGHHbkmVe4lyRkefeabO/v5sZj+wC3m18N7fdjmA56mGBl2ApanT1hObuCizM/M
         9ROPcweIgij+8pTnojnXqF1IE8ECVqhbIElHeEe6z737VySDKgta/cEOqd8x6miH51Wu
         Twxw==
X-Forwarded-Encrypted: i=1; AJvYcCXAa+5SkwjeZcPwfJc82D59MnW9YKs9hINKM7tHQdMcmgC1cP4j6k+zCnqaxF0J+39n5M1ZgnAbtfWhVeWjpp18G3yYWs971AUF/vTE
X-Gm-Message-State: AOJu0Yxvhs6pMvY6tdDZ5nY97iKOYwYXxOuKr0GenXJQqOF8DBNFws6F
	5TSNhehnno7mAd3ONtK5Kq5NzaWhgbOgZUqFpHwvzSZdC5pIgnR27PqGqu8ALg==
X-Google-Smtp-Source: AGHT+IEaoqcF6Og6OLvQ7ewWaGYFAcW4sjoa1hHGd0TMPSQdLKOqtrUdh28Iv6TE2SdAUU8BvpA24Q==
X-Received: by 2002:a05:6a20:9f0f:b0:1c4:aedd:7b97 with SMTP id adf61e73a8af0-1c68cf632a9mr2147243637.32.1722495642281;
        Thu, 01 Aug 2024 00:00:42 -0700 (PDT)
Received: from thinkpad ([120.60.66.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8834b1sm11302281b3a.178.2024.08.01.00.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 00:00:41 -0700 (PDT)
Date: Thu, 1 Aug 2024 12:30:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: kishon@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v3] phy: qcom: qmp: Add debug prints for register writes
Message-ID: <20240801070026.GB3705@thinkpad>
References: <20240731152548.102987-1-manivannan.sadhasivam@linaro.org>
 <172249532035.256913.2685367794999812971.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172249532035.256913.2685367794999812971.b4-ty@kernel.org>

On Thu, Aug 01, 2024 at 12:25:20PM +0530, Vinod Koul wrote:
> 
> On Wed, 31 Jul 2024 20:55:48 +0530, Manivannan Sadhasivam wrote:
> > These register prints are useful to validate the init sequence against the
> > Qcom internal documentation and also to share with the Qcom hw engineers to
> > debug issues related to PHY.
> > 
> > Sample debug prints:
> > 
> > qcom-qmp-pcie-phy 1c0e000.phy: Writing Reg: QSERDES_V5_COM_SYSCLK_EN_SEL Offset: 0x0094 Val: 0xd9
> > qcom-qmp-pcie-phy 1c0e000.phy: Writing Reg: QSERDES_V5_COM_HSCLK_SEL Offset: 0x0158 Val: 0x11
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] phy: qcom: qmp: Add debug prints for register writes
>       commit: 4e92d504475ea5841716ad775f412342520a3d26
> 

Thanks! Bjorn spotted that it is worth making 'char *name' a const. Can you
please ammend the commit?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

