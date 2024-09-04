Return-Path: <linux-kernel+bounces-315502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D78096C362
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421FB1F21AAA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C361DEFEA;
	Wed,  4 Sep 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Fkr0MA3S"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF751DC735
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465903; cv=none; b=t/7UmaxO7+B3gIHCbbFyzrN/HzQi4f5Phvdua9Ocgx2wsem8bsO+M7uLe/e1owfVzOj3a+KnEA3lT5lezFN9KwaI+Mwn4f8kt7HPE0mhMmqCfPVvbvmNATCTlSqWhJqcGN7/V30edcUIDkI2X/ioJjjMw/DlYQucKiFUGcyjz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465903; c=relaxed/simple;
	bh=DvLfTv5X8abSMYa7gU+hARytb8ZhyJi6DaoaNLUA+bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tcswg5+NFAD/B9dzX4mjjbRyizVdqH6MpyYrtiLLwpPQFxupM5r53Ho1dK0VxEYISsq1saFf46ff8JSDhFVWT/x1tEts5z2dbsiFa+KYHLmkDSen7bKkFwEO5djDLcvW6JUHrqTC4xxko6NM3s2cg9klNIkZCh9x5Qg+gw4PGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Fkr0MA3S; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bf8a662467so34808826d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725465900; x=1726070700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9YeCpUy4sVnINWC6Xk3yK4/LX4CcZsc10wOEHsII+8k=;
        b=Fkr0MA3SNxfj08T5z6oxJ0pUIDXR5BNYdocreBLOoMFhxmvTYNn5wVqfqhQACvrnmb
         jKtPb7TFbx7WfBpHv0uFXYnHD7GpfwbsOKx2DgtHx/vPLB9bvx+l1lY7fU+sYLFxKqVQ
         79sQ4wwcDifdAFJGAN4udW6bhhYdHwsTrJx9mdlSFgDtjBf70gjucT2lHkkyHxfUhGYX
         fhdYibdmoyHYaq6gQToj50JNfvFHiCIc4de8rRjNNUXaMoETd4Kh482vVIA2slGCPsR/
         m1iqKmXlUSRstdWasRiIUV6YFyjd34BnR1bcvcMVsNRZGiD1jGja33qoh7PNAFOVQg0/
         CZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465900; x=1726070700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YeCpUy4sVnINWC6Xk3yK4/LX4CcZsc10wOEHsII+8k=;
        b=rMmYgdTNnaCPNZrd1xXVL8puDXYyCQDBf0m5uzX8qkHK1mdUqvhmjfESSCvjc6S5TT
         Efgl6oRA+1uJmM+3jCSK1jCY0Jp4FwH0aFDiOiVqiDZ4YuHDC9a7ro80FT/qx8E5m6HN
         HhzADdZ0TKh2o9FiDfXrkHc5mFmujNLOjaZ2hxkSmbaO7X8hHrfGcYnGzhNO1QlDpHDV
         DCExNS55LwuQHoIp62LRqx/wkEl3EBM+/AY/LqJCO8fxRcW8j5X0IIHNlrZQq/JKg9gb
         ApNlBUR69dWJUr2w+Nyhf5VybesWu95r7fU3N95VOAlPkdh2HM6GmnigZ0Ua6AjfG9vF
         9ZHw==
X-Forwarded-Encrypted: i=1; AJvYcCVgp8P5xarM4/X3nU0Gjc0dJtYQ8xhEorXoiuQsOvEzr1mCw5ePmqAN3E9SNfEPiCqoQ7rDHKHjz0e97LM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2h8TnXPCgsbPsvMc3Kxj7tJc0ylU2oc0rfKtnN5FqOvgP4KEC
	4KKxEf2/gHBJsFeFIZ8ZBiEXFxjAax2N3LxA/eyTigdB9rXS2njUS8zB07YV9TU=
X-Google-Smtp-Source: AGHT+IFz5XTr3EIROtIPpFoKHylvL1QdVJcWXNO7nykeyPKX/xmocaToBUHmUscO0mtRSXqS4prCDA==
X-Received: by 2002:a05:6214:2e44:b0:6bf:79e5:b129 with SMTP id 6a1803df08f44-6c3554a7863mr160315666d6.49.1725465900182;
        Wed, 04 Sep 2024 09:05:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c3a6a2sm64790326d6.58.2024.09.04.09.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:04:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1slsV8-004iPn-SJ;
	Wed, 04 Sep 2024 13:04:58 -0300
Date: Wed, 4 Sep 2024 13:04:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 for-next 1/2] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
Message-ID: <20240904160458.GB1909087@ziepe.ca>
References: <20240828064605.887519-1-huangjunxian6@hisilicon.com>
 <20240828064605.887519-2-huangjunxian6@hisilicon.com>
 <20240902065726.GA4026@unreal>
 <e999d699-b764-5a58-c1ec-6f53e0e8521d@hisilicon.com>
 <20240903070922.GI4026@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903070922.GI4026@unreal>

On Tue, Sep 03, 2024 at 10:09:22AM +0300, Leon Romanovsky wrote:

> > The original thought was that ib_uverbs_mmap() reads ufile->disassociated while
> > uverbs_user_mmap_disassociate() writes it, and there might be a racing. We tried
> > to use atomic_t to avoid racing without adding locks.
> 
> atomic_t is never a replacement for locks. It is a way to provide
> coherent view of the data between CPUs and makes sure that write/read is
> not interrupted.

Yes, add a lock, like I said

Jason

