Return-Path: <linux-kernel+bounces-531612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05C6A442AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393463B8769
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA92526A1BC;
	Tue, 25 Feb 2025 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cWTu6Ji6"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A326A0DE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493575; cv=none; b=AGB2NaM9Zrq91idRSVO2cgqI8KVLHvBI0pUmNHMGt0op/KAzYVQ5rz1AWRHooVMkdB7dzoOzyIqi0fxSfLGD/beem30x70BjsQ6mNtUBgxMuPtYkmuYOQMljQPEfzc5oewH27oUo2GAljZZnoaSVNVuLquSMe5x2hkHgcuJBJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493575; c=relaxed/simple;
	bh=Plm3zhceI2EsfgR0QC5YmTkIcALi4hgt2KqwRV6YhxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsu4xl+i0tDxK7klK3QPVIP4/j7FQ+5d+XDvgB4lWkDrSUCvjJfzK5riB7so1htbuUVA0+OPitS0hLY9umSK4pz9WVClgxZRM/1QO4QDEUimw7jRDNBJlw0zvPnmkSsbT/kcUj4kGvKyDhhT+vgjyk60WPKpPWwS/x+RObF3H6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cWTu6Ji6; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-471fabc5bf5so30953011cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740493572; x=1741098372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k4i0Vgd5RfbJH8MJ8ai1ZPYpkgJMwx/lYshgGsgkxWc=;
        b=cWTu6Ji6CzU80wB2gqCiFq13z8HT6jciD7Qo5tLiI64qWTmYPWoSnHWkHfCV1BJb+S
         r7Kw5cJzD+AI7m0hNKdPxaGxzotj5zCn7ztAn450ZcshgP+u3fhU1PR8BcytF2JLnrmM
         k9DtgWuZBHJQQ3oP0YDF6tVXgYmPgehPFcvroS9RyKObpOwGbFxRlNacuChYTP46fPfd
         4M5IrJe9dLQ5Wbe7rsTL94yT0u8V2WH65szkcJzTnJ7Z6s3QSAxxHa3Vy2vC0XlNaFBe
         O22q5TY8AA8EcVq80ySAciauDL8j0nxb9Rj4aIW6BmlH7ksZRaY/lECoR8PPH6k0HDEM
         GxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493572; x=1741098372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4i0Vgd5RfbJH8MJ8ai1ZPYpkgJMwx/lYshgGsgkxWc=;
        b=jv7v06ZL1ryXnkivZCQIX1ni0wMZKMmi0LAS/nRMamiPO54w9s7uCtQR5MVTvV1+pn
         vJXacJf2E1JWHDKtVBOrc6et9FF8QPwYs0/IvUzsfSIGrXBHlhS70o2ADB4jVDEBnyUD
         kBKJOj9ZH/up+ZiPZ0G/SYqNKUZH8yJfaEB+hnWk3yLcS+w6mRGRPJi0ID0w0pf/k3QZ
         qvQ8RWjfbRzEsTsm9md1+18Ay1u0dhJoElWPsW/lKjUWa0jRNeOA5fSQ0FN8Zi+6KzRS
         uOhY0ah/PwKYkKzJscIjGV3sQVJhH4+5UHg/bxpGPweErcMprgMmikVQa7suxtdmwjZh
         I3bw==
X-Forwarded-Encrypted: i=1; AJvYcCVbnDD7vaQtcsRlfQvxM+0cSiNojVzoh3zZezHyYH/5Qad1egQM/DXdWRWksX9uh35lqylFHcFcgZSBYqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI4Z48ykmkkhyAHo8Z1D9WZuNTasZ87pmkFpIrPCuaPSXZASPW
	oQm/XiN54CLxCkr1SamlyczzxZuBSOY6199yjg45NK0VqJBornP6L+Bpb0uIlhA=
X-Gm-Gg: ASbGncvPhRFdH5JtEC9nMGA+U3l9NYqj/EP6mKSyYMgmbOyVLf/Dqw+YWDptv5EEonB
	2MvKZDN41E4rs2OSTI2uIeEKDn0ePO8vnAocicBQuh3jArTJiyXFvh/LF3ZUoeNaRoQlkqV4kqq
	qX69eR3PdvRGISZ9IVXQGGn1HLXA8RM1BddqHiKGTslEtEAL2yKfOlXlnL1p+caFqWc4I08dJtD
	wdvKVjshaM76UTpM+El5fqyNz3QXO9LT30u+twe6BsntHDS9iX+489eIeGYGeIq1ET/e30yKKYI
X-Google-Smtp-Source: AGHT+IHgdn2BGwPZLyzqvQVUbs/cFzFmDkgeqEMG0KDyXW3S8CcuC7D8hSNeNQK7BC7I60PEYyZD0Q==
X-Received: by 2002:a05:622a:1394:b0:471:f869:8d4c with SMTP id d75a77b69052e-4722295ded2mr175422951cf.48.1740493572264;
        Tue, 25 Feb 2025 06:26:12 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e19aa4sm10461611cf.32.2025.02.25.06.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:26:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tmvsw-00000002T1K-3qkO;
	Tue, 25 Feb 2025 10:26:10 -0400
Date: Tue, 25 Feb 2025 10:26:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>, dwmw2@infradead.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
Message-ID: <20250225142610.GB545008@ziepe.ca>
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>

On Tue, Feb 25, 2025 at 04:54:54PM +0800, Ethan Zhao wrote:
> > On 2025/2/25 14:48, Yunhui Cui wrote:
> > > We found that executing the command ./a.out &;reboot -f (where a.out
> > > is a
> > > program that only executes a while(1) infinite loop) can
> > > probabilistically
> > > cause the system to hang in the intel_iommu_shutdown() function,
> > > rendering
> > > it unresponsive. Through analysis, we identified that the factors
> > > contributing to this issue are as follows:
> > > 
> > > 1. The reboot -f command does not prompt the kernel to notify the
> > > application layer to perform cleanup actions, allowing the
> > > application to
> > > continue running.
> > > 
> > > 2. When the kernel reaches the intel_iommu_shutdown() function, only the
> > > BSP (Bootstrap Processor) CPU is operational in the system.
> > > 
> > > 3. During the execution of intel_iommu_shutdown(), the function
> > > down_write
> > > (&dmar_global_lock) causes the process to sleep and be scheduled out.

Why does this happen? If the kernel has shutdown other CPUs then what
thread is holding the other side of this lock and why?

> > > 4. At this point, though the processor's interrupt flag is not cleared,
> > >   allowing interrupts to be accepted. However, only legacy devices
> > > and NMI
> > > (Non-Maskable Interrupt) interrupts could come in, as other interrupts
> > > routing have already been disabled. If no legacy or NMI interrupts occur
> > > at this stage, the scheduler will not be able to run.

> > > 5. If the application got scheduled at this time is executing a
> > > while(1)-
> > > type loop, it will be unable to be preempted, leading to an infinite
> > > loop
> > > and causing the system to become unresponsive.

If the schedular doesn't run how did we get from 4 -> 5?

Maybe the issue is the shutdown handler here is running in the wrong
time and it should not be running after the scheduler has been shut
down.

I don't think removing the lock is a great idea without more
explanation.

Jason

