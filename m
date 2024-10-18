Return-Path: <linux-kernel+bounces-371846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE199A4139
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60061F24D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F171EE026;
	Fri, 18 Oct 2024 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FIiPfOjF"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2AD4C69
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261990; cv=none; b=U5yPzLnCAGqhzafeQvGk+4sljfgEMKmm/GlTcadYAXVsM9rqbrEEzcs55aADaWl4/UUB8pazE6TkD1usFlLNgCltJroHQuUEZM4mBUO5n/FIUIZSUiKGgzVu3zeGdyQVDlQvij6XQS5jvykaFd2R1w9fOhahHvA1kvpHr9rVf3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261990; c=relaxed/simple;
	bh=ZsBt8lSxzA+AlE5/dHTYCGZPEvYSA2sH3m2oRztGLPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAj3JZb2ISRZNGWYcOmt3ut4ZVmovw0WU2kT6QpFAZJKoPtaebfhzzgHqWwlKounGcd7XLF3A71mtAoVqIQPukYgMtTP/tar+70Pe6PT1xu5YSulmP1HURYGhJY1nadHdH9YatIbWDquhvwdLZjjTJqMofsWtMjNR4P92puZjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FIiPfOjF; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbf2fc28feso13928216d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729261987; x=1729866787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+9pFFBKupu2d6NLFEvg3/oQA/e9juqrsydZKewjkBU=;
        b=FIiPfOjFgCar+f1Wg19f2HIVLZGiGrbvbM4pQ2uDwXHpzueGgDmXSdVeNQmWPwSxng
         PIGAxaNPGWOYBAbVTCJlOYI36x0eKzIQzgFFoFFq0Ta2La8UJ58FB5F5ruzF1vo4DM5S
         K8kvXiUSVGrt9THWw4uIzh3YPHAwYpejDPouGNl19P8ZGWTPQvZKB+J3d+j9dZSpTfXG
         KHitBH/QvvvV/Y4UYFpDXvPn3oUq5cV175cx1gtE+9ALn9K1Powu2pynQZPyWCfghi6p
         3WsQuoV8/WPWwR7LLEmOw4nUiVExv9yKb3cdZ300bt119B24vVpbKf7ILzGmiulpYr4V
         1HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261987; x=1729866787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+9pFFBKupu2d6NLFEvg3/oQA/e9juqrsydZKewjkBU=;
        b=XCnJQ2laftJIZnnMnOkOCWyq11eSKK0zZ26oXaH6DKnlrp5UVw9/5XlvvGHI9yLa10
         ju8l0eWlC78SXvJ8lQpgsBrhHQIe23afPdQk8hVHGeey8Vm37SMjRo5yZxX2swoO9HSG
         uCFapR2jYCeFB2lWNYve7oz3PAiKOSFKKKz0Uxfk7KyHe7zcpwetzgIi52qSM8tB1mFO
         R1WVIuqLFHJ7Ifw601WUiGgGg9hbAv/PAuqtUrpj2h93DNXmjlF4OoAilRQvkCOEP5/V
         nbVTIrX+maK4LxHLzq9w6u1kQtwb4r22ZcnOQSqpe7E+JZPDCwPomI7i+OCNC1B7qidd
         Iggg==
X-Forwarded-Encrypted: i=1; AJvYcCWT7SzQD/hPTnhYuu5mv8CL3ylrn/DilO9perc52wuT4D28rM+Tyhn+cQrLJ7qJEKkvXSuJwlxVPL5h+EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCWWWRCLrE6prdf8JxwH28X/vDACyr8iDYBoLecOD3OF55HZE5
	y8GiW4LlFUxWXbqz+K9EyzuRCUh0nsU1AKvcUu9k+5Se4Bg89X1tLB4ryoXCUlc=
X-Google-Smtp-Source: AGHT+IEUnvffc5zoOVV9FmS8JNociVSvHRxNtwPJIviTG5dQGue9og+yy0xqzK1+WW1GOz5SrBvicA==
X-Received: by 2002:a05:6214:4605:b0:6cb:e8d2:fef1 with SMTP id 6a1803df08f44-6cde15e2b1dmr56786036d6.39.1729261987343;
        Fri, 18 Oct 2024 07:33:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde1179224sm7408316d6.64.2024.10.18.07.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:33:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1o2M-008F2Q-A5;
	Fri, 18 Oct 2024 11:33:06 -0300
Date: Fri, 18 Oct 2024 11:33:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20241018143306.GN948948@ziepe.ca>
References: <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
 <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca>
 <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
 <20241017130805.GA926121@ziepe.ca>
 <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>

On Fri, Oct 18, 2024 at 09:58:37AM +0800, Baolu Lu wrote:
> On 2024/10/17 21:08, Jason Gunthorpe wrote:
> > On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:
> > 
> > > Yes, you are right
> > >   I am using SRIOV vf and stall feature, so is_virtfn == true
> > > 
> > > Our ACC devices are fake pci endpoint devices which supports stall,
> > > And they also supports sriov
> > > 
> > > So I have to ignore the limitation.
> > I see, so that is more complicated.
> > 
> > Lu, what do you think about also checking if the PCI function has PRI
> > ? If not PRI assume the fault is special and doesn't follow PRI rules?
> > 
> > Or maybe we can have the iommu driver tag the event as a PRI/not-PRI
> > fault?
> 
> This limitation applies to PRI on PCI/SRIOV VFs because the PRI might be
> a shared resource and current iommu subsystem is not ready to support
> enabling/disabling PRI on a VF without any impact on others.
> 
> In my understanding, it's fine to remove this limitation from the use
> case of non-PRI on SRIOV VFs. Perhaps something like below?
> 
> 	if (dev_is_pci(dev)) {
> 		struct pci_dev *pdev = to_pci_dev(dev);
> 		if (pdev->is_virtfn && pci_pri_supported(pdev))
> 			return -EINVAL;
> 	}

Makes sense to me

Thanks,
Jason

