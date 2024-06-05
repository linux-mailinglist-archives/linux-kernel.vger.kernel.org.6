Return-Path: <linux-kernel+bounces-202909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0198FD2D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A2A1F22CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E4515A84D;
	Wed,  5 Jun 2024 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gUDJJQEm"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEEE152DEB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604573; cv=none; b=QDXa6Xi5aW/bnre/t1znD5HnfyY6eiAlQt1WbqmqTRfvyrQedWITIFDNbtXD1AGay+tstGFro7V+WwwOTLXo9nRXpFJTRPsQ5Lo+b3f404jYWX0wOpZMKY8/dOrz3jUdmmPMHueo9sQU+7AmZ84Mdy20qwr69E99ADH5eFrz8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604573; c=relaxed/simple;
	bh=UNK6lxbGj/I4OE8GnjlKxvJzAlzQa9SOSY7DOmujm8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEnbKeR5IT2zDeygN5arQSdcmzSOah35MZDOx9ZTplFnuVfhmBA+OmJYzsOaDUCMGJqhCmneXxmgAL6dBTnkyyZZ2UwNQm/LUaOQxK7SuRaZ56igLZWrCARJUYzWgBiGop2EAaf1K6KQOwjVpcy6VlNCvM3jpQsmL7B1vEGyh38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gUDJJQEm; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-250c0555a63so1872073fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 09:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1717604571; x=1718209371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNK6lxbGj/I4OE8GnjlKxvJzAlzQa9SOSY7DOmujm8k=;
        b=gUDJJQEm7EQHxD0PM2KqpZnAKRMn5bh9byp70cgMSrDblAlLPrGkrUFZ1b06OVmSnU
         GkBnlg3rGm5ZWAPRsL0ebPIm0MzsMGVRziGzdKs/lY4eGxXcd1iSaFtelRUB+0jZq77F
         AoF9K8FOKfaq9M+wdtOgK9RrqYSeUoSjKxlXoLJw+RvPLHAZhN6G/5zOEQI6l1VS2oIe
         N5JygUiHdPvbyRWJMcrmV+xHTDue0E8S3IaawbTwQCVr4rrRT5Yi0CndhLlX9hSKZ56S
         4BOIsJCi+9JPndEMMyJNjhqFkZs36ojmSffcpDblrR4JzVpo7Q2pUYz/hZMDVV0VMPrF
         sg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717604571; x=1718209371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNK6lxbGj/I4OE8GnjlKxvJzAlzQa9SOSY7DOmujm8k=;
        b=RPLusATofGYhU4WrfIA6/QwPYnwh5NMGoPOjgtJyK65LYk6QplYqgpvzSQT0kzH4aW
         0gflsNV8eAiyYFiB+MkuSi5Lt2SVKHPOOIfCIXqbBdt5+7CfEWM2wN0XOpvxbaMbLqbr
         O7xT6Bo/Yskfp6PHwB1SJxiAbfNIs/QmTuqvIAJ2qRzXxRy6EfbAxBe9MtZMsb9rJL1u
         HxrV4uleE0NiRzwbModyFFb3g1DkHnAJj9jIeNeQGZ0pieaRgZOMFZXdu6uGgcn9PO1Y
         +dVcInLnmpLeD/PZzxgve8O+AY9UgokVAszC1/BrP2T5BR2VJlj+nze8ZBilGxLlefRV
         Bi3w==
X-Forwarded-Encrypted: i=1; AJvYcCUuDPc3/XUcjZY/zDfxYiBrfkLjdkHYNrJXScuqOOserumEBxWETOpM3QVcCAiXEUpY//p5m7t1pJiiGokwRkeBpHAcnZMbMFycEXhs
X-Gm-Message-State: AOJu0YxQpgAgccDDlb8//XeQUUFha7SYpCpgrvHl/w24R4tl+BG/eEpI
	Z2WPjT8BW0pj1QUMB1ngYS1juxLzXn/tq/3zO0MOnXE8OvEu74Boo6ctyCqVhRc=
X-Google-Smtp-Source: AGHT+IHVCP9mGNwHWasTmq5z3kZUHSugwMMhnZD4b9AGFgdXW7kK8sC/F2IY2rrnoa0hU7TlmOZk7Q==
X-Received: by 2002:a05:6870:45a4:b0:250:7353:c8f2 with SMTP id 586e51a60fabf-25121ffe4c4mr3403554fac.43.1717604570789;
        Wed, 05 Jun 2024 09:22:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795015bed64sm346687985a.8.2024.06.05.09.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 09:22:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sEtPV-007TNB-Pb;
	Wed, 05 Jun 2024 13:22:49 -0300
Date: Wed, 5 Jun 2024 13:22:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Fred Griffoul <fgriffo@amazon.co.uk>
Cc: griffoul@gmail.com, Alex Williamson <alex.williamson@redhat.com>,
	Yi Liu <yi.l.liu@intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Ye Bin <yebin10@huawei.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfio/pci: add msi interrupt affinity support
Message-ID: <20240605162249.GE791043@ziepe.ca>
References: <20240605155509.53536-1-fgriffo@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605155509.53536-1-fgriffo@amazon.co.uk>

On Wed, Jun 05, 2024 at 03:55:05PM +0000, Fred Griffoul wrote:
> The usual way to configure a device interrupt from userland is to write
> the /proc/irq/<irq>/smp_affinity or smp_affinity_list files. When using
> vfio to implement a device driver or a virtual machine monitor, this may
> not be ideal: the process managing the vfio device interrupts may not be
> granted root privilege, for security reasons. Thus it cannot directly
> control the interrupt affinity and has to rely on an external command.

For a long time I've been beating a drum that people need to stop
using /proc/irq/../smp_affinity, so I like this idea :)

Jason

