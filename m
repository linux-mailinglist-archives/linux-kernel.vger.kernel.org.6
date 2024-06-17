Return-Path: <linux-kernel+bounces-217781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1F690B42A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7868228DECE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD7A168497;
	Mon, 17 Jun 2024 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="okudJPyr"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F06168484
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636124; cv=none; b=H9JJJfNNxfGzBH0JF0cAb55T2SKMODN0nUH8RGNoOQJ6zBz76Trd7U73kr4ThRsvcbXSsjZTqT7+7suCLdXHiB88pc+EuEW/E9gKDATH29W4vCKIY9PMriiRhFOBjsaDp5wiQJrNgQZBzpI/878EDWZIWJdZhtqhPSMLVceiYwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636124; c=relaxed/simple;
	bh=5HBfKtF6Ab+KJXOhi7rjQP1+URKpGlb2u9ENTfEH5XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnLonUTVhLVGy1beffxkmGc4A/McgHQz8HoofdJ5TXeIKz/1djGk864MONcr50Mn+Brs9+kFHT6Lrz/uvhlHlHwX+9WOyRKKGA2IuhrtEnnj7CWVWq9cN9h8AfZ6MmOr6rMXWDr50sLSrSdLOnUOO5wNrePa3iibbebxFkx5Yq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=okudJPyr; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-440609dd118so21266621cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718636122; x=1719240922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gljeJeGxAWnVOsW2sid+gU59meZd1BiHrYVsIx/obU=;
        b=okudJPyrc6lrbW9NpirjjEoJWHwaTfRVqBDcsfWMhl1TGiR0M2nx05mbpwDmySK8FN
         6UkbNDpA1Mw3FsxaJa25Ws8W8y2C8bEfoMIuvVXgW9RzqFtkvOh1gGQqPzX59AchiqSJ
         d1OxC9YzRMznjq57mO36xt7PGWtaZ3DVK355nQuvn26qRfnGqI7G94VCbTliitkwk84y
         SR+FRgbmijbF4M4qTYV8qiuORNvKHHmOBYMF+FHN64Tjl/GdHcBtF5OQVKvllGVfoWTP
         ljCKzEOta6dCOuqHI3yhNCg5NkXQj6txJwwKGNhuX9oEaxT48U9Lfh2B73OvvrQGhHsj
         PWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718636122; x=1719240922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gljeJeGxAWnVOsW2sid+gU59meZd1BiHrYVsIx/obU=;
        b=qsX/8e32/CvkLi9O4klVGDIf9OQdHUYYiE5DDcsmP8dgKjvsm1UJ7ymczve+8/G1wI
         Z6MKwfRVC4b7BGjsxjMZ4z9KxHMeOyTpGSrq4xzD55uw2jq0Oq6NgyRbAVvn+QU3BxrK
         FbgLgoBK6FNpx/NL4XXu2Fi38dIg+F2apmoe4VkF206A4/iuBIWdx135MZoVJUZCqMQP
         pR7uYSrwP+7WMYIb+BzHDHhkzD0t3psgoYSl50+ESH68asjBhtqXaVKXwKWk2dvJw0FQ
         K/WqbywosRAOr0/53pm1+TrCq7gvhjqv+oOtlR3QrtN2+3U+llkEfgWRHLPlWMBdNhqL
         fgmg==
X-Forwarded-Encrypted: i=1; AJvYcCXwOEBmb8q6I3CMD8gkF6sulEaOOOOeLAi5tId9CXUcISDp+gvseIWEoINXCm26pUfgPLiYLkLXq3MTC+BCfcNsn7iNnNR8Po+6IFC3
X-Gm-Message-State: AOJu0Ywu3nKYrXW00oVvxKRshhJ2eReOJ0kkq12ir/xeET5bB1rBRKWz
	8CRlIaaFCFlQX76Mqf4duQxXrJSC9hZ7dVLYD+AhPOO08uBUj0Fyzrb4T7Kj7UQ=
X-Google-Smtp-Source: AGHT+IF2uoGlG3xSUI65+NQXmHPaCbaCWcT/PreTgaYbScCBfAppudiPPRnsNM5lnQZNDfID8Cr2aw==
X-Received: by 2002:ac8:5e07:0:b0:440:5434:d59e with SMTP id d75a77b69052e-442168aae16mr119117071cf.26.1718636121932;
        Mon, 17 Jun 2024 07:55:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef3d89ddsm46912991cf.15.2024.06.17.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:55:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJDlR-008oz2-1P;
	Mon, 17 Jun 2024 11:55:21 -0300
Date: Mon, 17 Jun 2024 11:55:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v2 01/10] iommu/riscv: add RISC-V IOMMU PMU support
Message-ID: <20240617145521.GE791043@ziepe.ca>
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-2-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614142156.29420-2-zong.li@sifive.com>

On Fri, Jun 14, 2024 at 10:21:47PM +0800, Zong Li wrote:
> This patch implements the RISC-V IOMMU hardware performance monitor, it
> includes the counting ans sampling mode.
> 
> Specification doesn't define the event ID for counting the number of
> clock cycles, there is no associated iohpmevt0. But we need an event for
> counting cycle in perf, reserve the maximum number of event ID for it now.

Why is this part of the nesting series?

Jason

