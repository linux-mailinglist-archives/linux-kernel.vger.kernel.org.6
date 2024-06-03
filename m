Return-Path: <linux-kernel+bounces-199141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9D28D82F3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E032819B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8776712D1FF;
	Mon,  3 Jun 2024 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ez+VBXno"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D56E7BAE5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419193; cv=none; b=IyO2artySJPeaPpDWRv1r2MCn8MXY0nTxX8Gn1M7GP51EWw3wRUZtOJnU5DpqrCElvj7feE8MgbdArHIhY8nEWyLjB2qTMCAI80FOaz9gEv4PfjaDFHmsv0/AEwgvNz5tI0vjLQ+erIXMzVRvCPC5Go/mgWWWGIH9aXzYKqEuTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419193; c=relaxed/simple;
	bh=QX4iMKVssxoVyavrTllOasYtXwgAZT/oiXydBXbLzW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON8dSeKDhouPEquMbYOyx9LS/Ng1W3y5+L05CUAWWdABvs7+hTVeLdrCQG0vQj1+M70n5IzblW+PpFgYwb/bMfkeFXNAyG3ErwMsirukHelppoNYfo0iiotkxNvwEJk2LS/T57FFIyS7vc54ek7AdsyZGSPbGW4tr9i/jJpw7uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ez+VBXno; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4212e341818so26757415e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717419191; x=1718023991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9bimdtL/8Yb4rbSFpMqz1UL6qiGEqUPhGsLy+D1hTls=;
        b=Ez+VBXno0jjdT76WqdiNRuzx4L/KRlRH4RvGnoJvTaZ2pFcFBs27atkXHhdVqECERZ
         kr50I1KKC3Ntf2zGLDL7PP3XGAPxpoSREQgQLOxYEwKi967lqZh0ammmBzVYM9WNWsSH
         pJpw9kjjGbZJBFI7wd0CP5ZsCpUphxctHj030JSZNadtshvyNmj8RS379aL0MXR4HR8n
         Ed7l0Ph/t8duPQGBp0UPCnmPIpll6dMseZmXTDkVRJbwUv/+406ngFMx6OE0O1LQCwwB
         0Xfej9P1xuBWgOMvkTUMnnsINd4KdR/kxLmjelkSOsbmTlLxYq8e6ecXJTrY08GmTqfo
         IvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419191; x=1718023991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bimdtL/8Yb4rbSFpMqz1UL6qiGEqUPhGsLy+D1hTls=;
        b=GVzfWwM2oNiX/qDJxrsWC9++qTTB6ThlkO/2rj4JML+AljFSILdlGoOpaishw3ko6F
         /ChGxFcVt3QqUdl1uZJSQJ/eJxDjpe+j4kbePToMm/eCU9SirxdtRUyPlr6dLUHe6WcT
         WhnEWKYY6W0SGriS6I4A+njp+5iuxtLxvhXzZdsRP8X7JCq/S/piYPH6WmPQO4FbAyuU
         ygdHEsS9Vr0iD9mOdVHPYE8iVIhxrqqbjoLYsGB4WO3AwFROZRE36HYXzRmgLSmIOt4C
         I4cxP7sCcrPYMnXRglanfcJInKwCDKqoUluhxrh/pGzxZCrHtuTyddfMJt1wTs2AzAJy
         v+sw==
X-Forwarded-Encrypted: i=1; AJvYcCUFg30gCU5XMFm3O7gL6dW1Uh+icXUaPIx9TIpCrAwuDcyoBAwPDXabUiWh+jc0ZHVsH1NjMSoXf/TziUiDleVexBMuZcfmJ5Pc6VP+
X-Gm-Message-State: AOJu0YyIb5vdz0fBemABED9ibTUHd3ZewTJMRsw08mpBGVmQqXpt7LKG
	lUlk/D7Luy0pvrSwhywmiTRzNQ+oYt0PW0Hvn2jmcTvtXvgetMK1N+Hu6NKE2os=
X-Google-Smtp-Source: AGHT+IGr2qULxcr2ltWgvnytabKWi1pfPCuyLwlDBqb6eNha2uciqvGkQ3OnCBvDSIF3/JuDzfDAZw==
X-Received: by 2002:a05:600c:3510:b0:421:3674:7933 with SMTP id 5b1f17b1804b1-421367479e1mr41938045e9.27.1717419190599;
        Mon, 03 Jun 2024 05:53:10 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e5e3d1902sm1783031f8f.32.2024.06.03.05.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:53:10 -0700 (PDT)
Date: Mon, 3 Jun 2024 14:53:09 +0200
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
Message-ID: <20240603-c4a8257697f83cd3bace6ce5@orel>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
 <7dcd9a154625704cbf9adc4b4ac07ca0b9753b31.1716578450.git.tjeznach@rivosinc.com>
 <20240529-08fd52a8e703418142bdfa84@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-08fd52a8e703418142bdfa84@orel>

...
> > +/* 5.19 Performance monitoring counter overflow status (32bits) */
> > +#define RISCV_IOMMU_REG_IOCOUNTOVF	0x0058
> > +#define RISCV_IOMMU_IOCOUNTOVF_CY	BIT(0)
> > +#define RISCV_IOMMU_IOCOUNTOVF_HPM	GENMASK_ULL(31, 1)
> 
> RISCV_IOMMU_REG_IOCNTOVF* for all above. It looks like this
> got renamed and the header of the spec subsection still has
> the old name, but otherwise the new name is referenced.
> 
> > +
> > +/* 5.20 Performance monitoring counter inhibits (32bits) */
> > +#define RISCV_IOMMU_REG_IOCOUNTINH	0x005C
> > +#define RISCV_IOMMU_IOCOUNTINH_CY	BIT(0)
> > +#define RISCV_IOMMU_IOCOUNTINH_HPM	GENMASK(31, 1)
> 
> RISCV_IOMMU_IOCNTINH* for all above. Same header with old
> name spec issue.
>

Scratch these suggestions. Based on IOMMU spec PR#243 ("Clarification
updates to IOMMU v1.0.0") it looks like the iocnt* names are getting
fixed up to be iocount* names.

Thanks,
drew

