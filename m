Return-Path: <linux-kernel+bounces-199154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608928D831C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9204B1C248F4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C9112D742;
	Mon,  3 Jun 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JeLo/M+t"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD34D12D1E8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419563; cv=none; b=HuU1Of/XbfHonhRKCfXCkhRwJCkxgd4TtKcX29iNZhV6j810ngpO0+Mmf+efFW8tUp5JCt42JxYJk/wjEmRBRRG7+LB2hdQXjxy+pqVQXoFVoONqEDGIExWt5s4FQxPbain+NB2ehmKnUFREKX0vkBcdVruqdQNnM+9IdlTS9Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419563; c=relaxed/simple;
	bh=FyBQj0hG8ss9ZEv8V0JnRplnqLFC/O3chXUnsMv0bk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRUQdqGTFXmSVKSd8Dp9snIs23nSGD9NqFZwA9naUuAswWuIE5mGF115xH4fJrsO71g1SWovBLTXsNvWZMw7J1B4in5kVXJABUQCKZ03jx+ZnZq9s7D1MYUMmOxjYjRYASbk/Avwjh9uE6oyT401bTURANGnycYn55GyhE15/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JeLo/M+t; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a692130eb19so79955366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717419560; x=1718024360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IcEqjvHDHPrKWRNXO1NAMZemLV5LQ0B+lnFn7VKosBA=;
        b=JeLo/M+twDSGb/+JKEc1ziAuPex3mhlraQxyeFJDnRlEYnOe9dFET2OjkDM/OuEYjq
         cAxAtMI/ubK5Q+nt6wgCHg1qV9t/ucAeURl1PCk3SLSlC3ZeODP/o6FSd15Tfnx6WvIC
         lHOnw7DgNoSt2TniBXE16XR3m/B2n7f6Op5plUm/7WN9ITfODxKpPc9IlqhQUHBgTFUh
         Oo8LOAReVvhlw8lAZv5bHZ9JcFv/mgfanQd5MjrdJX3XG/did6lsU1UJgE7J1mu9v/ND
         TTv9a0M47y99aiqTqwBI54VN10SrVk4bq9v3T3gwzfxXOoDs4beGC0Aa1zsYVF+XpiQy
         j3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419560; x=1718024360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcEqjvHDHPrKWRNXO1NAMZemLV5LQ0B+lnFn7VKosBA=;
        b=MkKAvsGHScbAbaKMHqFQDOd2JE042lkkY59193QKXXaDJhBasIpRwpmr8qKwhen9gh
         CwjpoqEgwc5NRu3kX53jrAJ40c9f9hZg6OmkI5daMGQj6hpiUASQ41euKvUFZI0rSIoW
         0L39YxdeHxjbwwabPxUs3PDdpIV1EDayVrm5cDuNYH6NbI4deYa/vILUxpb2nTgWToqF
         Ig7mGOZRCjpk48BCqVUWt8D4bTFTCLl5dMwF7frNIQCzSCdB9CkUhj79t6VtZRYsvmlL
         O+iU5qwasd2OZPkPmYgdAyn8qa+PdxuYYoe5mgFByXLziGTXlzHPE6jLfsnoQiEpDWfc
         IPWw==
X-Forwarded-Encrypted: i=1; AJvYcCXSPYO/2dYPDehfcgZ39dXBX16hRifr2xvbiLhCSxfJj5SLqFRnTNmi+STHyutq/xaVELOYWxV4HZCChM74bVI25WALiqLoaFIFTNJ0
X-Gm-Message-State: AOJu0YzFbATpahPfqlXRYyzO4NQ6838q524HXd8CEKaSo8V4mI7yI3yC
	zmq7DQdSb4mYggn4U3XddVMwnWOlISay1/PcPfZl53yLnWj0jL6O0clv+WqapYE=
X-Google-Smtp-Source: AGHT+IHqmXxSxhfsZ5QLcPFpeXSzCRtTW99BPDOeKz6AZRkFkj434iSsteZACpuRGmGnksN+E2iRiA==
X-Received: by 2002:a17:906:d7ac:b0:a68:bae4:d66f with SMTP id a640c23a62f3a-a68bae4e717mr359112966b.30.1717419560024;
        Mon, 03 Jun 2024 05:59:20 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68b66c0c87sm347330266b.73.2024.06.03.05.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:59:19 -0700 (PDT)
Date: Mon, 3 Jun 2024 14:59:18 +0200
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
Message-ID: <20240603-d622cdac0016f1f854bf2b4c@orel>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
 <7dcd9a154625704cbf9adc4b4ac07ca0b9753b31.1716578450.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dcd9a154625704cbf9adc4b4ac07ca0b9753b31.1716578450.git.tjeznach@rivosinc.com>

On Fri, May 24, 2024 at 12:34:42PM GMT, Tomasz Jeznach wrote:
...
> +static struct platform_driver riscv_iommu_platform_driver = {
> +	.probe = riscv_iommu_platform_probe,
> +	.remove_new = riscv_iommu_platform_remove,

Hi Tomasz,

I think we should also support .shutdown (just turn the IOMMU off?),
otherwise the IOMMU driver reports EBUSY and fails to initialize when
rebooting.

Same comment for the PCI driver.

Thanks,
drew

