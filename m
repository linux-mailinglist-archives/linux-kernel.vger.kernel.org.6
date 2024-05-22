Return-Path: <linux-kernel+bounces-185897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FBC8CBCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EAC1C20E67
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99097E0F1;
	Wed, 22 May 2024 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gx4EmXa2"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0879949
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365239; cv=none; b=d8ez+sQfz07HHzPOMwk+vWRfS3s5C+6hiDzGNoA6XvYSnYEecb+jQqVyXdfetRE6qvmb92uc5gZ2U/6nYTxMsjau9hU2ZbqOiVz6qy8Mx5cYHsOlmfQHtIGxnzp3CSUi60h5zzRSNfLsvdEUsABxf9NoeBNFdQRjYSTxHPJ0ZI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365239; c=relaxed/simple;
	bh=VrTo7xQk3wunpQg4mIDCXYkOoCzhSbxT4fGAOU8jY1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGCqln9HW3XEwmHfZxVlGMTJUA2pUf+uVnC9Hq7zCTXhJEk5wqaivlDol7ucwkIpnmBt4nKjMUYGc6wvJ8gP1pALtuWfajr/f5yFI1DVo7fgLMToXeiwtk2KLJw1L+om/AHRTO8SfEyqubJaOWOlEmv0K5Izmgo/RB06LDCtL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gx4EmXa2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so13217161a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716365236; x=1716970036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EjJc7AAlreo5EdXOmmG11eZiUCAvljdqIc2K+uOGIsQ=;
        b=gx4EmXa2x77TN3MEWjbD1qbv5nOlStBOykoJnoTY4fK5W3l6/lH+rgTZVUzSCC3KhH
         I9eo19liGA7MZFDpLEmzD+aKp3VgsnWvE+e/h1gnA/rTCSRHf1VJDvCpry2qbh3rc0+n
         3MJdnjLgVTJUTp7PaAqxUvEmnJbaE0lnS/XiSUnA8R5V3C5cxN2p97kN/6heg3Xrz16o
         YRyZlfRvZwDabg7DO7Sbg9+aCl2MnShhHKgKWWDmMzSpBlpDhWKp++BwMlqUa4bQ/Qrq
         pkM+G1At+Ig1G8EnFJ/Ux+Iz7j2/oslc0O83bOVLCSvYJnI1Aardre7l/GVPV9U3Z9lu
         Hnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716365236; x=1716970036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjJc7AAlreo5EdXOmmG11eZiUCAvljdqIc2K+uOGIsQ=;
        b=ShHthZxpR1WFiIjJ6GnXSxp4V2TOXdQsNNhoZO780Mx6xqsfXRbr/FM/9PZp/Uhwaw
         L+dpRtNc0P+urWbowOWbfqIITHLvFNAnd6kqP951IIyoiFdaEC9HSxiJmtbFFRH1O0tF
         TiYRueNj7OmGQA33KOM9gqJbSwgOkLOXmPOTzrNHeUsi/dcTGx8f7kAJoSnpRCJlQeqd
         HsZecX3okfoS9nj6r4lhJA3q96Qghl3yEgz1sJt8IUF4LjZsJcGfo/cANeLAr+mj6etI
         im1Y5W1myw3nVJECNGvyCjwCRc8qgGeOlpwYj45qJHrS8FY7v5XqtBFXJEQv9anr/l3P
         KQqA==
X-Forwarded-Encrypted: i=1; AJvYcCXF6e6SPezyAaL66fV+BYVUEc817yk5EIakt6EeafZcOC63zjXRN1dkG9DliXYgIQrzvim3NN9XqI7FGXxuq5QeBO5jYXUwmjzp9Ril
X-Gm-Message-State: AOJu0YyiVgaOo9eJ1U54z6QvaysGIW+ptllGm1HZAqSwD4390p/NLPtR
	MW5oisY9Bw9Hd/mHDJGEVpZI2XcdNinWA3BkueVj4l6QprfLfVA2jLpnPxe984k=
X-Google-Smtp-Source: AGHT+IFxkk46rQN7LJxAzq5cGNXR84hroJkBlxdzGPSkPpe2syhCs/1Mf1/sjeCOL+ArtyBeWNzrvw==
X-Received: by 2002:a50:ab4b:0:b0:574:ecc4:6b54 with SMTP id 4fb4d7f45d1cf-578329c7ca3mr1206147a12.9.1716365235959;
        Wed, 22 May 2024 01:07:15 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c323887sm18071800a12.89.2024.05.22.01.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:07:15 -0700 (PDT)
Date: Wed, 22 May 2024 10:07:14 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, linux-kernel@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, 
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 7/7] iommu/riscv: Paging domain support
Message-ID: <20240522-b25680db03b547123f1cd59a@orel>
References: <cover.1715708679.git.tjeznach@rivosinc.com>
 <1ddb50a47c86d384157a979a7475b45f807ba81e.1715708679.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ddb50a47c86d384157a979a7475b45f807ba81e.1715708679.git.tjeznach@rivosinc.com>

On Tue, May 14, 2024 at 11:16:19AM GMT, Tomasz Jeznach wrote:
..
> +static int riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
> +				 struct device *dev)
> +{
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +	struct riscv_iommu_bond *bond;
> +	struct list_head *bonds;
> +
> +	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
> +	if (!bond)
> +		return -ENOMEM;
> +	bond->dev = dev;
> +
> +	/*
> +	 * List of devices attached to the domain is arranged based on
> +	 * managed IOMMU device.
> +	 */
> +
> +	spin_lock(&domain->lock);
> +	list_for_each_rcu(bonds, &domain->bonds)
> +		if (dev_to_iommu(list_entry(bonds, struct riscv_iommu_bond, list)->dev) == iommu)
> +			break;

We should wrap this list_for_each_rcu() in rcu_read_lock() and
rcu_read_unlock().

Thanks,
drew

> +	list_add_rcu(&bond->list, bonds);
> +	spin_unlock(&domain->lock);
> +
> +	/* Synchronize with riscv_iommu_iotlb_inval() sequence. See comment below. */
> +	smp_mb();
> +
> +	return 0;
> +}

