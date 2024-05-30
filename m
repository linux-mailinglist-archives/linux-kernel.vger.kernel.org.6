Return-Path: <linux-kernel+bounces-195055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A3B8D46ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DECE1F21F63
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035514C5B3;
	Thu, 30 May 2024 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="X4MGssAO"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453ED143746
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057222; cv=none; b=ierLxeRNF8zk3OjuLyJeKjxRm9uuBBeVNUjjDogF4ezJVYq5N0pPQSDKH+yG0YXXbn9nmqPXlTWyM/2kFpX0R2Dtj7iKC8j+GfjgpknUl+oa5BUfnayy/4yTzGngPv++E1q4+DCnyUCMAsocyiNRl0ZYIkmjMIrHoyqzQRBhcO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057222; c=relaxed/simple;
	bh=9hQvbxkraGoQByyfnB/SKIQRAxtxMniFpbudb4R8J+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJbsK4Oi7Wv71mKLx3rgERROoSPTD5IC5ZCYjG/9KTXELZISNjlbO49bAYcRukb4H7bdpIWVR/UNYjMnimI0tBsy7jddNdEJSS7rSuE2C/cJ/QCdxoY1kho+yiF1gul2+KnpynKzCf6cbguCIEQJFY6EEU0MJpG3bkYtO6lQIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=X4MGssAO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-420180b5838so3398955e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717057219; x=1717662019; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xAFqwlnprskdijXg0+qVMxiHshvm9v4VwBvMivw4hqg=;
        b=X4MGssAOpP+ReUDeAySTOFHDO/FubL+QJxHVcC+a5OJ58ZwzkJT342ezkeV7bDetn8
         SVKOa2Is89YHjf8phSxz5TL66YMcs4GmIV2U7LzYpFptW+BZJX5eI36LX9nSCBuA4ofQ
         pRVlIr2VXuD9g7Pr2TWAcPxCZQ4RW7hMysILLojJ4SBHhKgasjYgjVwEsiaEq/1nEYrw
         vCy55gf0GJlHYukEXivVpxZ3Y84qni1uyOiSiK5M6bK+81FkBIPlS/ts+ljn/3N7TMa0
         +2JfLy3MuuetTFjE2Vb6sF49E4WdJ4yqEe7oj5228Pw2x57UHZpMCjEQRYTwYUq/4XGw
         vWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717057219; x=1717662019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAFqwlnprskdijXg0+qVMxiHshvm9v4VwBvMivw4hqg=;
        b=a4J2X4+4o2S6QnP3kd5UIpRv47vnhA6CSCVYT57b5OM1E8zHkVtY4ctRLu1N9X0nN4
         LM74oo5XuUQteEQwhAt/IrPzX6+1/aJEkBsXhPzysBYeWj2gDgbjpCWrIBkX1nVTy13b
         HEfcySka3jQ94mI41Bh2oCMQxp2RNvx/FzI2CdL7B/aCTrrTtsVByep4arwg6/K5M/yF
         jTyXtzc8WW8QDNQ8VnOFeSFDUVE9tOVKq5FKCag9f9a6YqHT6o8EMxrxqJEzvlmvE48W
         1Pc1k2/5XPRdmF5JVypM02WABp2Vzxr0OLLqmZWVyyX/fpdfZpNBFUG0OoqKukSqq2w4
         kVhA==
X-Forwarded-Encrypted: i=1; AJvYcCUeT9MRqqDo1QYQDk/eBcyUgizC5vaUDC1eW9cuNKEoGtCa3+0Xo+Dw7e1zsgct2fOiH80SXj48aMjGP4fImeDxCrnxqzVps5YKfk8B
X-Gm-Message-State: AOJu0YwcfAFU0hlB94OjyMtb9C600tJ3R3j33E8zM4uVozhTE6HRQdha
	sGZoa86bn0GJAH9HF5I9K9Ph2DtluAiSyOK5XK5TPFavxslZIbS1MQ6FSk5c8+o=
X-Google-Smtp-Source: AGHT+IG1keazYzeuDlTEJWYo0DNz5z0le/1L4QF2tlIZz4H3UjAuU4J130ihkcGjOo2htfDSVAmo6A==
X-Received: by 2002:a05:600c:45d4:b0:421:2241:5be3 with SMTP id 5b1f17b1804b1-4212780a865mr16402325e9.5.1717057219466;
        Thu, 30 May 2024 01:20:19 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212708a6fbsm17283305e9.44.2024.05.30.01.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:20:19 -0700 (PDT)
Date: Thu, 30 May 2024 10:20:18 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
Message-ID: <20240530-af20943d2b372faa7b11ed41@orel>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
 <7dcd9a154625704cbf9adc4b4ac07ca0b9753b31.1716578450.git.tjeznach@rivosinc.com>
 <20240529-08fd52a8e703418142bdfa84@orel>
 <CAH2o1u7DmywajQWRnQEW2Zjw95EzruM3_Mb5Z-K4zJChh8pGLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2o1u7DmywajQWRnQEW2Zjw95EzruM3_Mb5Z-K4zJChh8pGLQ@mail.gmail.com>

On Wed, May 29, 2024 at 10:59:58AM GMT, Tomasz Jeznach wrote:
> On Wed, May 29, 2024 at 8:15 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > Hi Tomasz,
> >
> > I reviewed iommu-bits.h to the spec. Most naming matches exactly, which
> > is nice, but I've pointed out a few which don't.
> >
> > Thanks,
> > drew
> >
> 
> Thanks for looking into this a bit boring file.

No problem. I also meant to point out that I checked all bits/offsets as
well. They all looked good to me.

..
> > > +enum riscv_iommu_fq_ttypes {
> > > +     RISCV_IOMMU_FQ_TTYPE_NONE = 0,
> > > +     RISCV_IOMMU_FQ_TTYPE_UADDR_INST_FETCH = 1,
> > > +     RISCV_IOMMU_FQ_TTYPE_UADDR_RD = 2,
> > > +     RISCV_IOMMU_FQ_TTYPE_UADDR_WR = 3,
> > > +     RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH = 5,
> > > +     RISCV_IOMMU_FQ_TTYPE_TADDR_RD = 6,
> > > +     RISCV_IOMMU_FQ_TTYPE_TADDR_WR = 7,
> > > +     RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ = 8,
> > > +     RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ = 9,
> > > +};
> >
> > RISCV_IOMMU_FW_TTYP_* for all above
> >
> 
> I guess RISCV_IOMMU_FQ_TTYP_* to match _FQ_ acronym.

Oh yeah. I guess my eyes had glazed over at this point because I didn't
notice the 'FW' vs. 'FQ'. So, yeah, we want RISCV_IOMMU_FQ_TTYP_* for all
above, including RISCV_IOMMU_FQ_TTYP_PCIE_MSG_REQ.

Thanks,
drew

