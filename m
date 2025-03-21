Return-Path: <linux-kernel+bounces-571289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1FBA6BB68
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AA33B081B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9E1F8F09;
	Fri, 21 Mar 2025 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKHk6F0i"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2AB21A43C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562324; cv=none; b=puNQDLWsp+Qy++UcmuODN/oiJ8o/urr59F9afSXdnelCe7wsrvLsmXu/u9gkq3YsUG+Bzh8aY3KnNA/LjkbsJE5uqNBCK7uw7XoYVV8GuoHfiCqTMfeL4URQKMAi3fjNyEPuM2njjo9PRqM9JlBFV6Q8Ygeo5IWn4AJ0uwn4n0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562324; c=relaxed/simple;
	bh=6WT71yJoEYEpO+UZc+zcWfwjsjcXPsLX80S9vN8bjjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz4i1T7Ytlviq+2QLzVnSMpaVSTQn5+aVnc37M9LTOOEQXGPK5GQeh/y4XGVnaAy/Lmmdekf6nnRj7CxrR9W3IuOWgLcgFW2UAgDt3Zl/YOe6H/UEETUy766zjMQQpg8otIKsFDJDMHPHuE8q9xcoW7u5RT7WM0o1nskHeX2zkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XKHk6F0i; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2255003f4c6so36608295ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742562323; x=1743167123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sGgl8ZvbquuRJk+BLXwB9YUIkenTH7ZLFyIvKumGdnY=;
        b=XKHk6F0iDKgntX+th1qr8iKtmxBvaqHgSEZ2xA2EoYY9oYeLGM3DB3m2Rucp03SN1t
         aEwQkcJMalk3qIIVdnJtoH8RJsED3SsZ3lVhCGxacz9hFY+H/2wgX5M7eAdYZS64vUFf
         MuPu+SBU4DXMzPG/BBtykXQnDspImzHUczDTOM6iX49e7r/ytTcy+0u6Ey8wjpGsxElG
         nkI9AS6wK52TavbBAOje+PID9+7Q5Mq5NGq+O40xybgSSHOhJMoyWd3GkzoK3l4K1Nrp
         Z5yYEHvSTCh5RiwKgIIj4tQtN3Ga/r1R9nefWw5+ccqDl9Z1FLRWC/lHOKlxoF4mTTNx
         FTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562323; x=1743167123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGgl8ZvbquuRJk+BLXwB9YUIkenTH7ZLFyIvKumGdnY=;
        b=S+/r7eaDThmFybMGMhHC1mE4DU6+c7M1a/l9aOV7jw0980N7FUvT7k8lJYG9ul71p/
         3VDV1P/rHsUN8T805JfPHYTBJE1wPj9O15qpzNCA0IxFPSjmEKCdYGfjTk49cccB76xX
         5MZFlJk/+xPHLkPGIpqb1geEK/A0aLA5ELbhK5DBRcftLG3Xu95K4iXUVp6myjzAOny1
         wFEHxdG9lDvDUsoIhxJ3z+b471bzO3QEC7X88Jk5M2rBt0Ro190PzsFR7j/OGUj0yF1C
         bkKn4j5y15Jhx04IrSL+N8jkei2k3JWEIi+U9EMFtpL8+f2pq+CP38DN3mjvfp/W31iu
         GLlg==
X-Forwarded-Encrypted: i=1; AJvYcCWNI/zYyk0+ipojK8QcgkX5I6yN5F6vPxiXERDHwCVzZs+RnpaotwxyTF4b2ZpdXGRc/JPdLqw49rio0kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySpayhfIHRk7a7GcwwVPyCAQ+MAf5M5xm3vfmizIe39O6Dv0n4
	Xscdwo8cSkG6Gb5QSyVL/XDZVLbiBTBfuswrbgsO51lcHxgMF28PBVlzTgtYDw==
X-Gm-Gg: ASbGnctu86SISPHlSOgK2kiNqAz9rAFg3caHlHFq9ndvt8zxBuTBuOmgFwWa47AhqTd
	Kz2POFG4sSrt7tWAGy4jXg8HUNcpXJUMYCGy7zvyY/GtaGeihxtMRpLT8U79daNPgPHQU7QkW95
	8aknGSs+Ih6cP58GcyPq1c1PRuPtPCS8Z8IWN7FlPowlNWiZoIyyTNf3XYtJszO9zUszHfvjy26
	XIW9xGfLexNVAHPh68TlM4cWzBBoIYArp4gc3HsRoQSGyxbIu/UZEYfPUPTkHham23/fdBtwnhj
	XfILkzxNKEMpkDysl70aEi7r85fNR6UdhgGJAkz2wuuQS36/YX4XiCr+4g==
X-Google-Smtp-Source: AGHT+IHoaNUVQmGThxfs9QNaZ63vmGYvQt1jTAGa9uKQijEtEehKHu87zsGhAOUND8TTE+V0Lk5UtA==
X-Received: by 2002:a17:902:cec8:b0:225:abd2:5e4b with SMTP id d9443c01a7336-22780d7fb22mr49655335ad.16.1742562322314;
        Fri, 21 Mar 2025 06:05:22 -0700 (PDT)
Received: from thinkpad ([2409:40f4:22:5799:90ea:bfc4:b1d2:dda2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f45a7sm15585775ad.223.2025.03.21.06.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:05:21 -0700 (PDT)
Date: Fri, 21 Mar 2025 18:35:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v4 2/4] PCI: dwc: Replace dw_pcie_find_capability() and
 dw_pcie_find_ext_capability()
Message-ID: <20250321130516.7pkvfl5ls7fzgtdf@thinkpad>
References: <20250321101710.371480-1-18255117159@163.com>
 <20250321101710.371480-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321101710.371480-3-18255117159@163.com>

On Fri, Mar 21, 2025 at 06:17:08PM +0800, Hans Zhang wrote:
> Replace duplicate logic code. Use a common interface and provide callback
> functions.
> 

I'd reword the subject and description as:

```
PCI: dwc: Use common PCI host bridge APIs for finding the capabilities

Since the PCI core is now exposing generic APIs for the host bridges to
search for the PCIe capabilities, make use of them in the DWC driver.
```

Patch LGTM!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

