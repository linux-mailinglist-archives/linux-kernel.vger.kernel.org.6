Return-Path: <linux-kernel+bounces-437787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E88E9E989D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3683C1884E46
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BDC1B0430;
	Mon,  9 Dec 2024 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WjzmEVol"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847521A2397
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754018; cv=none; b=YC+wQBjaplH2IOSm+z1rHNftlhhBsIlmSgBgh1MZ/GF1ecvKwUtHCVxMv5GQ/TnjsPJ5BmoWRK1CPrI3z457VEYJkDhjBcn+x/Lkkv9viOaFlByFmLEo2QxYLWeWmmUmLTL0nEfl/ohx01XRsObw0QnYWDZGHKezaYewEnkfwcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754018; c=relaxed/simple;
	bh=1IfxwKOe0K+SXDwRfMDias6ZXlgFg4AGO8kVbL4Ta8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou6isDMGqtsnaSUm/buxHOiybk9z5Lg8jYNdM3+EH6RZXJp3JK+cS0BVwgH8AnceBSv3GqerkGzCXWkbg3VD4xSzOtovSHgSZ1wyLv7rN+tIFYJZvWaExwGBKqeB66D0HpK0EeEd8RfQjbL/GoQd+EwWrjTVFwmE/Dx5T0joD/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WjzmEVol; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8878ec049so39339426d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733754014; x=1734358814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nowhEyl5dI6aIIqwammoplLG7dGCizfgN3AwcDBvNB8=;
        b=WjzmEVol2HtqNOHDzn89GOi3ABrc8rbz+u0pvZXwDkalIxZVG2aHhGtjGZ2QkNl9W3
         sbcPg6ZbtF6lwdf9MtUkxlCY7zo2riVzwILSLyWFiQAj/zS48u8EAA70tcMIHvr+Yboi
         KIAKjJuHxV8r5RcCNk8gHU5W8odM481TXKcM7T3CfDUdPZiabn6B+FbVap1K55xq2Ag7
         ZOeC9iUJpzJwU7QIibAm5paWKntWlXlR6ZUQsFJzAnXKerYW20mrhmI8GSyGM1DWkOqi
         wuvwX6nBfBoHr1Ja0aQcz4VtBHK0y4mVIfpmiG3w9lQkJUO7Fwcr8OF1+kOyTrDi+Zpw
         9hbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733754014; x=1734358814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nowhEyl5dI6aIIqwammoplLG7dGCizfgN3AwcDBvNB8=;
        b=AdmHmTlV/JM4lWbhPsuh5y20Q9LL8+wCAexSeO9k2ui+bov3owU/nXOPsHCXw5ayBm
         EDgbEaAq1z6GF3iRuj+GAfKkPwprvaC7GZxcLkvLN+0LB3naaa2OoBnyBSQ7maMCGtGM
         LL7K9zvtDPB/wVFM7Z6rYJm4+qGmCUsX7APYSDh+Yd37SmNZZs6Omk5VnSVHLP3LA40A
         zdFOhzxbzTQJdQWQe31xEjFSPHA7TIZgz5giOMB1CH8nggKX50qEMec4unDk8+yiPDVc
         wqjaXarjgepGdTlFbFl/vM38oNZ9CEDRWek34Nqidm36U8PHjWIok4i2/Pa5qLecwE8F
         x7UA==
X-Forwarded-Encrypted: i=1; AJvYcCUxtspcyo0Fmjo2J//+gFHdhH2+DJBOeU1ts8k2qwRAky0yjBLkQoWPhJlY8GnS1jlbVgULj4ZW8zTXInY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDOQhrOO/2aI+kk1FFWJ9/2VjlkqPyEaD7bUnWWykeuws73Ktw
	fvaQsUMVscwxvtdCfxC6q/dZWUImx+HNWMkxgLx8eD5JhCMem6qk3QaCXbvQNRA=
X-Gm-Gg: ASbGnct66GlrctavbdGEYw44SYb0DJVbCJHMWA38CyMKZn36mQKfEbbZGiSSZnYIujZ
	HFvJidVHpApRQ7f/JGLr28F8uu3EMK8oad7sXxFt8rq7iBSca7sjE0cTgr1w2p0mVPEwpmr5FIR
	Hme6xbJchGdub0yvpNrsy2DjpS54xJfo1PRtO3H44v4HZRJgKucbAdKaWIMRJnvq4ogmj/Xr4SM
	IueqCQMaTEbOLuYXzasVOSI6Ip2+4uA9fnh8mV3sWj2rHHhzMliW5R86KZ17wdf5T3Alu1xc3Ts
	0dOK2OwR08wp9KUSBz9+HM8=
X-Google-Smtp-Source: AGHT+IHoY1ZOiHkAJnpdjYQRkeVDy7sffj3Siw+V0OMHlwsl39yE0CXPuxOPKOgDNwcCNM/wgKH60A==
X-Received: by 2002:a05:6214:1c07:b0:6d8:a76d:b66c with SMTP id 6a1803df08f44-6d8e7170365mr191037006d6.30.1733754014582;
        Mon, 09 Dec 2024 06:20:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6b2291sm48868886d6.58.2024.12.09.06.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:20:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tKecP-00000009sI1-2JGA;
	Mon, 09 Dec 2024 10:20:13 -0400
Date: Mon, 9 Dec 2024 10:20:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] iommu/tegra241-cmdqv: do not use smp_processor_id in
 preemptible context
Message-ID: <20241209142013.GC1888283@ziepe.ca>
References: <Z1L1mja3nXzsJ0Pk@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1L1mja3nXzsJ0Pk@uudg.org>

On Fri, Dec 06, 2024 at 10:01:14AM -0300, Luis Claudio R. Goncalves wrote:
> During boot some of the calls to tegra241_cmdqv_get_cmdq() will happen
> in preemptible context. As this function calls smp_processor_id(), if
> CONFIG_DEBUG_PREEMPT is enabled, these calls will trigger a series of
> "BUG: using smp_processor_id() in preemptible" backtraces.
> 
> As tegra241_cmdqv_get_cmdq() only calls smp_processor_id() to use the
> CPU number as a factor to balance out traffic on cmdq usage, it is safe
> to use raw_smp_processor_id() here.
> 
> v2: Sebastian helped identify that the problem was not exclusive to kernels
>     with PREEMPT_RT enabled. The delta between v1 and v2 is the description.
> 
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Makes sense

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

