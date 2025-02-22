Return-Path: <linux-kernel+bounces-527348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF549A40A21
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B97A3AFB08
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D4F200B98;
	Sat, 22 Feb 2025 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIRYPTfz"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B26200105
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242454; cv=none; b=XtajAwtYxatM1n9nZC1eT/BafGGlobQlJQ/xRxz/VRxRe0x3FlaRZFyeDA/EN3KtcXQTWWP0uRiXHUiGA7UuSLEi9QTH0Y1iLuTyXs77Mn0lxk73uC0zfD3hwG3puRxhprUrenSamE0e5+JY+1Ya8kQyB37DJ9kkDXHXg6SwTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242454; c=relaxed/simple;
	bh=RlG6dofeQhSMbUCrjzCISW4dWW3PiiUkCHVSzb3s/xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQUFrGbvJTx7mEo6rqjDN7X7RScAwG+/Txm09nev7YUsoZ6fPtzdHp0c5QIHsUO1PQCKVjTsIPxAZagoJUZ0uXjJN+IcJ4IZh8NBCZg2ywLj5Oy9j8SsZLEIOY6EeMZt63ETNoe1OjcFCIy7OskiZBvrP7Ucz5zwksq8SVtfcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bIRYPTfz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-221057b6ac4so59001305ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 08:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740242452; x=1740847252; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q7SmUkU0wkGg93tuHuPQ8+F/dJahpuQFSIUY8F9FZz8=;
        b=bIRYPTfziicSN4R6DPcO+t1f1rSmIKZIrj0dVlbd8dmQBumHFtiUdY9Ip3MojqxjvG
         clpWg12Vk1H19eqMVJP6CjHRxHLiw6OyFjtofxU+wxg2GRHrh3gE+y3oPB+TrYQthH/p
         NVESAxtyGxbBIv03MTNPsQb+7kp2kXeILzl+n2c/mEg2DPx/GNaCAUpAPxZqKJ+ANvqP
         Qc8W5K5M6V4ZwbTaT0XmPmUMB59ROFv9n/HuZgJabjFTh1bG0ni/44A+mRK7ACY6vHud
         B7kTjJT7xoeU1I4SD25MqMbrIPNMdVTdMqu0RFTI7sqRlj560MsfBXNbo2VIZtB1aSSB
         Jr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740242452; x=1740847252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7SmUkU0wkGg93tuHuPQ8+F/dJahpuQFSIUY8F9FZz8=;
        b=T/zCUKhk8B8kYQcMQBLHT23oySdbcF8Lm5gLpF5tMQYXiHc2kCizG87uwn47B+zvUZ
         eKleqbjIF9NsrzW5LLwkfI43oeRyaMl3yWoe5xpIoSyXXdYsA7kgpXQxMzR0L+HN38gd
         3BxtWvSOT54YlxhOpUCphvSdc9r6D5GrEbC2kIGnI+2gavke2/7Fulvmpprj7FUE/xK8
         W2sGs7xZcx3DHDVNvfy9Y7q0HMjVfmntyoF+44oTvr+Sdha5tiuDhK0ie19upQ69AuI+
         9bYkVUQDepZApd4uBWkzUcMIm6ew+4DCfVqTs3mo6xpIJqnLF2+N6wPVHZ1qFdbQ1Ffb
         /xtA==
X-Forwarded-Encrypted: i=1; AJvYcCVSaz+Qs3jdOqJMH0gEegFm9p4wwKUVATWFn+wT6zZDdJp9Z4ZlKXBws++0hEBuBOWU/sGhsWhN8K1pM6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSSj9NwtBqjRYvuPywQ3ZS9nMNPEw9/xc2w8D3zOC+eDg3fAC8
	kO2/6RZ+Jw8i4lBUx1KXGssv2sfpRa5Vczbrc1gonHMu+b5YreBULQUAlP7ZHA==
X-Gm-Gg: ASbGncusnlBmkgRUVq/bnUvC+47SPlfc0WFszYmSs5ZWiXXrTf65NfTWXxnMwFSgUUy
	BX68R0kJ9u8FP8juVmyQYGpX3sj8XLuEsVGs105BVlq4OjaMWKCXFvCUd0R7PYOJ+1ZQ6mH6Y5h
	oCAERGvw6KvvOQLhklNLrV+8om6vSAZ6in2A/QDFlL3/XHU19l8ODX3q6YgW42yvWYGkgBdTTLX
	2Ms2ZShIrTMcW0YaIZu0eKlR7F9f9cCY50NP5XLORq7jQqj4Vo2PJbCZ0s0PPpCwWLvOwevaCys
	8ZNFf8ExyW9ZVOwhicAn0HQ3cVDku/zVtZqspg==
X-Google-Smtp-Source: AGHT+IFEDHZtuniMfOeDjLrVBa5hGySK9NWCQAT8oNjTSS7bMd12a1VSSCxQNJaxtxTV8J/i8HbMHw==
X-Received: by 2002:a05:6a00:4615:b0:732:5651:e892 with SMTP id d2e1a72fcca58-73426ce7667mr11977154b3a.14.1740242452204;
        Sat, 22 Feb 2025 08:40:52 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324276171fsm18225136b3a.144.2025.02.22.08.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:40:51 -0800 (PST)
Date: Sat, 22 Feb 2025 22:10:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Hans Zhang <18255117159@163.com>, jingoohan1@gmail.com,
	shradha.t@samsung.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [v4] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
Message-ID: <20250222164046.b7itpksdlmchrnby@thinkpad>
References: <20250222143335.221168-1-18255117159@163.com>
 <20250222145432.GB3735810@rocinante>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250222145432.GB3735810@rocinante>

On Sat, Feb 22, 2025 at 11:54:32PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > +What:		/sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
> > +Date:		February 2025
> > +Contact:	Hans Zhang <18255117159@163.com>
> > +Description:	(RO) Read will return the current value of the PCIe link status raw value and
> > +		string status.
> 
> The description could be refined a bit to make it easier to read.  But this
> is not a blocked and the changes otherwise look good.
> 
> Thank you Niklas for testing!
> 
> I will pick this up if there are no objections.
> 

Not yet. This patch has the dependency with Shradha's debugfs series:
https://lore.kernel.org/linux-pci/20250221131548.59616-1-shradha.t@samsung.com/

- Mani

-- 
மணிவண்ணன் சதாசிவம்

