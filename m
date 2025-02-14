Return-Path: <linux-kernel+bounces-514958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D054DA35DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9148188FAB0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4184425A64B;
	Fri, 14 Feb 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YlKgHD08"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D8E1EB5B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537766; cv=none; b=QgJ2WdL7SB3PNNAQjqj93SeNKIUKz6xCAhUG+/c1FBMLJKcVT1mxEMr14BarhCwQ5RV76OCTqc9HxNKYE2yJOeT3fmsFyoIY7ji7QRFRBoS3PqVG0v5lq0pEeNXxUGkM+UVgPkDBc5Hg5iU99U/bOpQ2jYeRAHTjlUjnLGhAnA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537766; c=relaxed/simple;
	bh=+izSO9NS1dvQ44Usea+/PRyoKVzL4dwBWWq0o77ECgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PT3b0sfhn5R2kLvAoP4K8bJEnj+qAWybhIPYH3CTDKdHt7SgmucxVf5POIHFY9U+ktr8E9+cfn23ESHVq3SYPxwi5mQZtzhmAX8KM+H+xfEe5rgoCE8OUqj8x2Py8aOR2pwchEPk4n8Ui/cFFwjp4+sV0QewPGdpmk+E8kMWJSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YlKgHD08; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c07cd527e4so111991985a.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739537762; x=1740142562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FH+3dIVQQni58kSeXATaEmatfH+mLIwTZncYsTQFMPI=;
        b=YlKgHD08n9MwhUITitEEmyru+9ihaGf0T9SPzcrRBW3+Nkbdh110RUhp3IuSIl1cxL
         6p5o4MFNPyCbhBG7sb9rnFH5Jgd7DqHuRAQtzQW2gVVbV1kWjnXBsS8wZPI33/P+5niP
         8jhecUGnvjOZy9sQc/LQkGZXHAFOlmZbvJo779qXwKB3h8uyg/mG0r99p1k6ouPwQWtm
         6a9X5Y1n08cYJFamJbn+OVrQJW/f6+M+tPTzWYGWSyniMMr+mV5uCehNAtZDHn7mC1fI
         27bOgEC5dwWhuZjQrxWxNcOa08BH2/43zA1UlbOsTgcdkj6D8vc+ghbLnK/tt33fGoEE
         /QZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739537762; x=1740142562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH+3dIVQQni58kSeXATaEmatfH+mLIwTZncYsTQFMPI=;
        b=GHzJRRi/ECmIB7QaiBiARhmCou6xO4o/LAzq395tmdq/+AUL7eYLA6Rke8wnl6Revo
         slzq4MpUSQ5wFy1VCDheiVBWkigP5SmiYIWPXUdE+buxiFLDZZVH4SrGygeNQgJO6UL6
         S25fqnblIL1z34+rIQnPmQSBWpSUZs0Rn6Mi3PMbrJthO5CYj08LmYrWMHNP3BoQNwLz
         JMsAz9+qgIm8t04wCVXJVSy6+7XpgqtV24ZP6ucCTbIEyEcEJAfzElHvOUk6eN2J01fQ
         E8bH7eUpxofqTj/afR65IdxM6PtxlgWGZbC8XgSyZQnvSBqaBXSBg3A6BTHX9yXdKejv
         5fKg==
X-Forwarded-Encrypted: i=1; AJvYcCXXP+UpjSy3KJ80sB9RW2Aon+WlEYFqV6yjkulfdWNkueAc0zGd8PW7hs1taN0S5sYJ9oPdWz1Ti1ujGDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfaN7jZN/loIKJPSRb/sm0t64njCNn7/jAjvzrDQ1UYWo5KMz9
	PzFEZyz1wZITSsiUgwIRcJJj01DiynjrKq6vHEusWqxoThMdX2XfnwVxCkdsjog=
X-Gm-Gg: ASbGncsHeH07H8NGpE64Am7U0u/qlNlSNQweEp8R5wro1vBPhdy1NoUDqA3iJPf28B2
	zpzAu1UWCVwrs8rhabFo3nKuxwXMCK+5ucXr0d/34Cs7V2bitlDHb8ZVRSEORCozKuqGyRCKHDh
	RZs5mE7ERbWEIGarOtMU0lZB3DgSmdP1EEmqlWvb3Wa18a1/ew720D7VJrPo1MU8ptz3Juh2YC0
	Nzt+XFBc6mF/BLO9XlrgY+cXwrYuzlZDY5ZH0vH+w8/7u6Do8qSL5v0qzDhcedyQB6CpTeK/+zv
	KSiGtGD3f7I+BZI+QVkREQu76rm4WqOUGiKF8DAuT27W3nc1831TCVdGdnrKQSDA
X-Google-Smtp-Source: AGHT+IGMIC3l7eVX94N3JlHj6ZSg431KPepsQwfE1ziDaH5SNrBWCEEkMlKeHd+rscMrHYshY6NB2Q==
X-Received: by 2002:a05:620a:3d93:b0:7c0:70f3:7ae8 with SMTP id af79cd13be357-7c070f39c3emr1175810885a.35.1739537762217;
        Fri, 14 Feb 2025 04:56:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c5f3560sm202459385a.21.2025.02.14.04.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:56:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tivEe-0000000GisN-3M5g;
	Fri, 14 Feb 2025 08:56:00 -0400
Date: Fri, 14 Feb 2025 08:56:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
Message-ID: <20250214125600.GA3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>

On Fri, Feb 14, 2025 at 04:43:12PM +0800, Zhangfei Gao wrote:
> 3. qemu boot multi device,  test fails, host kernel reports
> [Hardware Error]

More details? Can you bisect?

Thanks,
Jason

