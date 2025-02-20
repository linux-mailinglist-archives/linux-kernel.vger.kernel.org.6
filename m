Return-Path: <linux-kernel+bounces-524444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43362A3E333
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F04D17D4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4002135A2;
	Thu, 20 Feb 2025 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ogDnOG4W"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CD41C8FCE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074409; cv=none; b=SoujsCRYxmMsv/JLIi8DC/85sE+FS1hu61MrDKixN8VaLX4RfS4UrrsckiGibc9f+wew7/cvIi0u03Z7bc/gga+FX+TK/EnwYZcmmEwfGfWyJC0W4WPB9MGSKPOmL8zOzrwJXB+lhfk4V9zJosZhclUZtfYMhQ4Yv2PXDqb1H2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074409; c=relaxed/simple;
	bh=eSZ1FTDl17sy/1gqD/+wlyeyEdUOzIKAubEl/bdPJvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0HbFGwnw5O5Vyq1szRtBR4Antjgq62jc0+qQQ0e2m7mzCexddnsuICJFIMzB7dfV9G46hW93vgjHmwuJLGjmuiMWj760JRbKoxmrIG2b6hQWJFTPGtMZN7d2hecBiZ5ZH9SAHq/sXrU12gIV+aEHFjWOsEDoqWoVGhJVaN5h9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ogDnOG4W; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c08fc20194so212572585a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740074406; x=1740679206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqfOIw71GSnlOakkatpEUx/UlJU6cK2rQ1RtMvMbUys=;
        b=ogDnOG4Wc65DT+RlXCNxW8Kbry0X/Ov+U865cshnVUwg/TgRZEfnJGBqZh6RYOtugD
         +7MDzCZxfO/w2DsSdwnzZLq4nQBzP0aM7bTPpsvuW33w8nsOPOOr72eYMIKrjTtHjawy
         yAT/lhgeaUYij0S1Rep3uB4GcEP7Fzd6NYm0uxS9N8rgydvXq+EYD2tN4NiWdXnnJNhQ
         KabHHiuytpsikYVoMarXhczOAIEtqQXNMkdjLIzEAy2TwRUZdEIrqUfGyx2BMgatMeTJ
         iZDK79/873oQx24valR7Z7g+76hNKctB2uVwAiCoh80tuQ34azPMtzSUTb84QTvSm61e
         GxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074406; x=1740679206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqfOIw71GSnlOakkatpEUx/UlJU6cK2rQ1RtMvMbUys=;
        b=klf26R/hljGLfkTffrjg9FQmCcEPiRnB1q+ywr8T0Ks6BfVzjPpXdbLH2oWXll2n4l
         5Pa+RQp30taFYm8d/EZDZ6Qh9n0ux1GTUIhmmi+LC1Ff9WnkXlAobbynMuvNiZWGJJRT
         1b/CyBhgSumczlvB2GVch1tyfbWe490QG3NlrNhoM8Aw0l9kTb47gLe9jCatPg8MSM99
         XYJFVcp/GQNnJKrCQCeYBRN28dMclKpnHu5/GgJhLP1MvRSL9W6t3APFSRM/LxVHFnxG
         3N6dtEj66ZuUeL44GWWcVtw7uVvfl4U2//G6SUdHFUsNNhxREN1EGEpIa/h4b3SBPEVg
         yJ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUFFhiggLEXrLjXBDhpyLR0PhLF/Zw8KBQrdZwayJ7SuM93P1f3jD3o+xXtpibIRZjtMazsgREkozgMZp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUGm6+crItm8O7OHmQ4qPBRSX23Mg47bUGS68ZHHQvoLhqsyvY
	YesYk1w3mGcQFerYkYCnas6iaR8+F+FJpNd07p/zLXB6x8+ySuy6ZJh3Uf8XcnU=
X-Gm-Gg: ASbGncuRWX8zKH5MvUJBy0kCbGZL7Rcr1VNWhKkAg9VSf78y8hBI/iPene5whYxDJ9r
	yM61Vj2l2Vr6c4pT549ZNGJgocd8CHYspD8PPmqE4WMJPsacFgWIb+H5Px+4pb0aqcqP05g3jH+
	HfVJsy7hSfYxOHQ4PsnDm5C62P2gXCf0p+yXixNr52YZGVSqMjXXf6JLvVwKFpGV3w4rdAu7phD
	0ahbn/ozESyWGQ/X3xOlIk7FRkyQbVm16zQP5tvDdS9NBbQFzdKKN1Bkwi4zRHHLKjBfc2/ghwE
	TrGTmMZ4DjoGCrB7Gj+pM+JINicyIMgxEbu0gpXD63g1SHGqTuVC7BZFwSk/ql1j
X-Google-Smtp-Source: AGHT+IHDKGAnl6DU9pk9/XM2fUS5ajQw/PBjTEaCphng7uBZ47O872Lj2r9xrDJ2GgiUB2EAVoAsaw==
X-Received: by 2002:a05:620a:8084:b0:7c0:c24a:ccab with SMTP id af79cd13be357-7c0cef0b032mr24535785a.28.1740074406291;
        Thu, 20 Feb 2025 10:00:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0c0e771e7sm145931885a.101.2025.02.20.10.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:00:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tlAqC-00000000Ik4-30cu;
	Thu, 20 Feb 2025 14:00:04 -0400
Date: Thu, 20 Feb 2025 14:00:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] iommufd/selftest: Put iopf enablement in domain
 attach path
Message-ID: <20250220180004.GX3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-9-baolu.lu@linux.intel.com>
 <20250220010250.GQ3696814@ziepe.ca>
 <d93c8cc9-77a5-4b78-85d2-6b4601f52266@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d93c8cc9-77a5-4b78-85d2-6b4601f52266@linux.intel.com>

On Thu, Feb 20, 2025 at 03:03:21PM +0800, Baolu Lu wrote:
> On 2/20/25 09:02, Jason Gunthorpe wrote:
> > On Fri, Feb 14, 2025 at 02:11:00PM +0800, Lu Baolu wrote:
> > > @@ -197,11 +201,19 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
> > >   	if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
> > >   		return -EINVAL;
> > > +	return mock_dev_enable_iopf(dev, domain);
> > > +}
> > 
> > This isn't going to work for a replace type operation? Maybe like:
> > 
> > if (old_domain->iopf_handler && !domain->iopf_handler)
> > 	return mock_dev_disable_iopf(dev, domain);
> > if (old_domain->iopf_handler && domain->iopf_handler)
> >          return 0;
> > return mock_dev_enable_iopf(dev, domain);
> > 
> > ?
> 
> The iommufd mock device driver appears not to support replacement.

That's not technically a choice the driver gets to have ..

> The
> replacement operation on this driver is likely handled as follows:
> 
> - attach domain_a attach blocking_domain attach domain_b

Nothing actually does that though?

Jason

