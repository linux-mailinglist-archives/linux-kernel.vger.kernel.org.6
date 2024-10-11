Return-Path: <linux-kernel+bounces-361196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B14499A4EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F691F24EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B327219484;
	Fri, 11 Oct 2024 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NBj1jV6P"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3735F2185B1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652976; cv=none; b=EUyWZqU8EQboRXx9Jv1Ftt/kd2un8VtyfLOc0zLCPkl6rnaeJaepAzJ1V+5IwfOgtfJz/9ZsgtDcjQVqZ6ncMuw4jK/2Xnuu66h9Hug3VxGZm+LVO40Fe+CoCUJutBj4jKUdmGjPYvJGBWnU5of9i7u2i2klZFp3DdQ108vhSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652976; c=relaxed/simple;
	bh=GKt34GZ1T3+p+//976QoqJmwGFIFvhAgBAjsahriSfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDl1pH7ELBQhq8E9/9YZG6q1V0PixFHXQFGY/9kq8EMBtAHHfRCohjFH6clZsO2WjbX6YJpY9VBS9MOYGP3UsswSwjpnRVp05CyjY2h0PaCpMrZux8hG1jGxQXtgQ6BDGe7Kh7UsES0qb70qKfz1ByVzGtkti/nbOi7cxWpa7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NBj1jV6P; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4603f47b2c8so21745631cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728652974; x=1729257774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j7pTQ6QybW0xHhHwYV/6CeX01mgSlXIVQ3clJp9shcg=;
        b=NBj1jV6PLpp38b7/Llvc+Q5KyqKj3zpe1q0Kv1YSmcucL4sEadPLJm5jEM3bZ19pvu
         PJq+scuPXwxpfLKsM+bF04xtTpWUNV6Rv2yKZbrUQ+ipsHCZpZVygKD3FH7wMdHqYfWR
         LAJ8k8OhkMNO8ta3bnd60m6jmnDIAxm+PFZXeKxLXCHAs+WBwOo8lJsT/FXm+BSggrMp
         FSgz4sZ6PhA0G5BDiBvB2YXcu/xrmXjb5jCCTlVl1jQzL2ofLrbkwKX6Lza3AtZPJO/t
         pYSsOI5tPgUf3WsfjU0nPvfw6bekQ79A9GEJ8IEOlkufbIT61DE1p9lNOOx3WRSCSUHK
         h7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652974; x=1729257774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7pTQ6QybW0xHhHwYV/6CeX01mgSlXIVQ3clJp9shcg=;
        b=X1WeEXyLdHZHpmcBkKgciEM+9b/AqNg57a+i/7mxCpdD7jxXD5eAtnB/j3KQZtbdwz
         M5ZjSgCC7P2y2OJYg9fABnd+ixYZyzDQuuqOSu80lGhCBbmfOLfOk38GOSFDxu1ru8FE
         KgwU79X8va34b7DLfQY9B7fRHyjsV5HW0z7aAdy1wSABVQV/s85QCGm+8B2MY3AjmYmv
         H2ejNvCx/fFOXzWCnfz8B8uOXuHTbBiuujqsu6dL1WIL25Xc5j3cp9CcP0uc9rkk6ZKl
         wpBBYUi4NR72msV91M7NPjyeSIjPhNt9glc3Rwg/YcaJha7FDqK1dUlffjgbp712KB3o
         m9JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvaxN8A9ppCTZ/3Pyv8BZrMwZi1VNPkNaax42ZHTXaru72CR9knAlcbMLq8Vk2vclRiT3u4a1/w4JLK04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTKCkkyTZf+yno6I2oznR5EHE8MRfqGVYoqc8581JxKHCb0H/5
	QNGBoDmhSsjSBzHjmYroE1VHyr2LYXmYEwVh7oCOj/nabHJUt4mEeGARlacwMpQ=
X-Google-Smtp-Source: AGHT+IG/p9n71JYR55kA4MXudqUnjfgmqMBmN7Ts190gYsyypsRk0Lf0RpFEuLXdfiFXh9zf5cZ9KQ==
X-Received: by 2002:ac8:7d05:0:b0:458:1dd3:e3a6 with SMTP id d75a77b69052e-4604bbc8936mr44708121cf.23.1728652974018;
        Fri, 11 Oct 2024 06:22:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427905adsm15187721cf.15.2024.10.11.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:22:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szFbY-006qTP-EG;
	Fri, 11 Oct 2024 10:22:52 -0300
Date: Fri, 11 Oct 2024 10:22:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iommu/vt-d: Add domain_alloc_paging support
Message-ID: <20241011132252.GJ762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-2-baolu.lu@linux.intel.com>

On Fri, Oct 11, 2024 at 12:27:16PM +0800, Lu Baolu wrote:

> +static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
> +{
> +	struct dmar_domain *dmar_domain;
> +	bool first_stage;
> +
> +	first_stage = first_level_by_default(0);
> +	dmar_domain = paging_domain_alloc(dev, first_stage);
> +	if (IS_ERR(dmar_domain))
> +		return ERR_CAST(dmar_domain);
> +
> +	return &dmar_domain->domain;
> +}

With the direction that Vasant's series is going in, I think this
should be skipped and instead your other patch to make
domain_alloc_user (which we will rename) a full functional replacement
is the right thing.

Jason

