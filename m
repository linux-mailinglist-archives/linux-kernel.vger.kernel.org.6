Return-Path: <linux-kernel+bounces-217756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8881290B3DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAD1288E81
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1118115B542;
	Mon, 17 Jun 2024 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="chZM8bI4"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B315B150
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635164; cv=none; b=j0mRN3E3Pdw0WNc58k6pLlHzEuDDn7VHT/bKny3bhNZJHiKiObAyb0X1Pe53EDE1IabypuRg9ww6oxzdX0ADyxyxMBO76QFZhWGqxT08NbGy0QCjMPvduETTc8ZakefYlHRRgpPTOVl0hft+hJTNu2sTSukCj2vQ4xlChrnHRX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635164; c=relaxed/simple;
	bh=V0ydNrFGcnxQcEaU5sMS6EBIm5WNR4Oj0pZJxqEWp7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXVOVl/mYu1mazzTKS7hhcEbjfIwqABq/GCxnEbJn2o+mdn1yyXH2dQWUh0cm+MauNnSgIJQjmqd8/GKE1hQAQ6OG7oOU9+goSL0BNa+xLoxNgNm0hAqNc1L/5laQP0Xh0Begs1CoBYASarW6BUYPfETSBfGLTmiomnC4pPL+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=chZM8bI4; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f8ef63714cso2645174a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718635162; x=1719239962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0ydNrFGcnxQcEaU5sMS6EBIm5WNR4Oj0pZJxqEWp7E=;
        b=chZM8bI4kq8Wdv7S63n1f5JNtogdAcN4qYwg7XpSpdjJOXKGqpnN4NpP2fn45Rc5y3
         6FaHy5WMB79dWXaM9inu2UUm/UtMWg8OFZTb40MyrBZDuY/nYB7NXZWqpO+caTAQ3tCO
         oEk1IspTFpCi5P7C4adEEXczt8tiUagGJIrCSB6e8clA1a62Ur4yWqqIOevo7w+WCexA
         WvWd/q+i3QXGQQ7GHxSEUKCCwPzx78Vy2IZ4LxL+JbPdGU1JIUKEcZHoUnU3CchmyfCf
         H/wO4Zx6NkDZ8VtpRqDkwTrj0ub87gH6UEhYs7nWPsyGmteLLiRoz6V2B6Ci3NjeKN1J
         B5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718635162; x=1719239962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0ydNrFGcnxQcEaU5sMS6EBIm5WNR4Oj0pZJxqEWp7E=;
        b=NC/VSLBBt6lQrNWyWEQrqozi7LpVdO7QrIM0znYjHAqHvWmXyLg+dEGHAcJ6Ye4qEA
         heJht5XLaSNepbaeCs5QooLnb5WMlDzN3nOkr6HEphICPJfAbAjF9gLT6F0qF0wh4D6j
         3liCw8/i6sgr10VeNPRTFbXX6BrsuiowCbnbJIvzBa4mZGYeGV7fQgGGiYPNHbkz34ol
         7pd81r/cP21qi0+mVIFArSECQ8/zAsL+t//xMnQTohFescmFA1Xo+FKgTbcXtNwAdRZh
         H6OUetD8p/wS0nhENHoVZbTLJ0tT2KNtseGKNzP9S4KSop0BPxcpx244wUaYCCUYpqKu
         uG/g==
X-Forwarded-Encrypted: i=1; AJvYcCVoLTujQ3yGQdoJqdAa2x7wP2104PiYb36Qb3baEez2tu3GzwLuxacw38IJCqVeMJLjVhNdpQIJInehi6klH9CuI8kF/hHlCONnfLbT
X-Gm-Message-State: AOJu0Yy9OvkcDpn3yZuargtNE0d6cogLtu9qiOBNbKAFS1JTaqz+P7eN
	8am+bwtGQR8yuHjr3KaO2ExPknBsxqnFipvAgW55jgFePBAjiRSVFTz3wXTcGNGQAButLZPDC5E
	+
X-Google-Smtp-Source: AGHT+IET1ur2Hbq+9cJMAg5HnRNV4tbPcm/2Ccc2KuGpX71T8/mhLJfk7K1KJMmzd/D0+4LvUiLm7Q==
X-Received: by 2002:a9d:7388:0:b0:6f9:cf25:d6fe with SMTP id 46e09a7af769-6fb939fbe5emr11889679a34.24.1718635161757;
        Mon, 17 Jun 2024 07:39:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c58e31sm56074816d6.72.2024.06.17.07.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:39:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJDVw-008kP7-Ol;
	Mon, 17 Jun 2024 11:39:20 -0300
Date: Mon, 17 Jun 2024 11:39:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, tjeznach@rivosinc.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	kevin.tian@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v2 04/10] iommu/riscv: add iotlb_sync_map operation
 support
Message-ID: <20240617143920.GD791043@ziepe.ca>
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-5-zong.li@sifive.com>
 <a1a99374-dc40-4d57-9773-e660dc33beb2@linux.intel.com>
 <CANXhq0pQuoriKfHF51fXUtrZLkJBNOCe6M8Z6JbDjoRvbe1nWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXhq0pQuoriKfHF51fXUtrZLkJBNOCe6M8Z6JbDjoRvbe1nWg@mail.gmail.com>

On Mon, Jun 17, 2024 at 09:43:35PM +0800, Zong Li wrote:

> I added it for updating the MSI mapping when we change the irq
> affinity of a pass-through device to another vCPU. The RISC-V IOMMU
> spec allows MSI translation to go through the MSI flat table, MRIF, or
> the normal page table. In the case of the normal page table, the MSI
> mapping is created in the second-stage page table, mapping the GPA of
> the guest's supervisor interrupt file to the HPA of host's guest
> interrupt file. This MSI mapping needs to be updated when the HPA of
> host's guest interrupt file is changed.

It sounds like more thought is needed for the MSI architecture, having
the host read the guest page table to mirror weird MSI stuff seems
kind of wrong..

The S2 really needs to have the correct physical MSI pages statically
at boot time.

Jason

