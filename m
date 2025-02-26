Return-Path: <linux-kernel+bounces-533913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8435CA46033
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0863D1703A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD7121ABDF;
	Wed, 26 Feb 2025 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GB1bAkhX"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160743166
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575067; cv=none; b=QsswLo/HXpokxtoXNBtSBIiuVygjV+UzRIB1rLCmdFoHdfvefdIWD+fFjeoI5/SbMC5KmAQG4WPrhLizSdzzXerOx2qWjUtOSob6YS+YX6EXOPp3VlZlruW2DmPnAyXutN5LOtJxdiXufLfUazGibUkNmo1RWWbDIviyQvYoRGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575067; c=relaxed/simple;
	bh=D5ZlC5M0pfwNbiqQwR8fbHoOjPuQ/ClIFXStOmgzmDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tR+CVS9vfqbPreI+jHf8N377EL8Qol31zRoLHTZWKEa+1cXUIWE0wc41JkWeCIBG+gF39uD3yGBsRxykouh7uHXX55BtC4HG+b3EiRK7jg3YP3rCr1ewJxcn1pS6IsPuf7ORc6bFZbUNPjBNdCDfZ5ssf+3UhhKmowYOT9+FWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GB1bAkhX; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dd049b5428so63799226d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740575064; x=1741179864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5ZlC5M0pfwNbiqQwR8fbHoOjPuQ/ClIFXStOmgzmDU=;
        b=GB1bAkhX+0Bj+0sUSU1tTfHww2GVL/Rx73XNR0GG4GQmClVB9oVeqQ09pFMjUbRcm6
         N4NzpHZ2DxJKSkUVgmHZgXbCSscEZBmO0fvuA4MfnzTaLulFhr9QGCyD3oBpuqh8WDqb
         tvzRq3HZoKk0wZACIaWbab+GwhXOrEONKqf7IJLBdBEp552uSOgmGGn9PaY3v+al1ltq
         mNXoE5d8ZbZVfFxnrc4SBnd+ULpkpJYMoHRP4YacjdCLDb1fJS7ShYC7lt8HkpCc6jW1
         7f0q9naiLb+2kndC6/uCuMyjJiBrGcOVFI0wRhEtUzUw4CB+p1+7axu27l5/Mo05bPtB
         Oq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740575064; x=1741179864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5ZlC5M0pfwNbiqQwR8fbHoOjPuQ/ClIFXStOmgzmDU=;
        b=ULnSxrr08HCSHt5+TN4KbVSqDRTTY9kb7Z4Q9GFaNd/+tJJILfRtrqifr6dT2tnv57
         8L+/4CXPOe3OMvcEzx9jA12Cd8xE6Pk/LLpBjtLU7r3i42ojoN2l7ALaHbU7u2MuwjZY
         iaDw7ZyVa1pS1qVUnOudtxe1ZwrpAZdrZ1vgNCEF5SKMVluxlHipn6ffrG3RCfcy1bQa
         itRf8wKmkOFiL4Pofu+rbiTKgEGQRE9+XbFN7yLQ1gmjegyGyOICqZIuNz85LG3WZ6FV
         pP1z0TxUGOvh2kfDuosV5fY/g2KPteMaZ1XGrl+0CMNHoJgg0hJbnkmcMGcdB3ZvxucC
         Zpkg==
X-Forwarded-Encrypted: i=1; AJvYcCVVcgJt25Sbr3E7swSZkKk4LUTXklh4MB6oFli0dWwECfL2fEWNFQxiIDJXmRb5RT1veMlYL7DYl5SeTqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQA5xsndQbrQ//rHfiiV1U6p8c2bQa8FVCnsjskcjfW/CjQ+rU
	jJtRVN/5oLNpVibBKiK3W5KCSPCezzCeYaPnLXX/eYygFORwya+pRjnZuhhZy9c=
X-Gm-Gg: ASbGnct9i1hc69Y9U5RFdRehkB3xuO1SPD8M5g6vBZwwxv6sTupO/a/Sn/3GrH+ytG0
	jyMCCJ6DD3FmwGu5tAGvcUsOchqAu5vtt7ORHj4kZWXoyJkHWm82TyBiB4+fQ1FgV1Y0ogCvUPZ
	HLOT//uRVWHIIf4Qa8Qzfc9596LoWO1WtdrST5KQN5ecIn5GyWMhe2coQOvANQV/3yAwguZk2tA
	tOLhJbdRrMFVbdFIKoCEgHFQ0x69ljBc48JFuj4N8aNIJWpNUmJcEtfPh06urwHAzTfSvugQwET
	2ZJMRXSVzg0Fh6csGWwz53s87N5I0fjDFwaXCREgmS18XRiveh/CrWTou1eNyMh7M6d9SPyqRkk
	=
X-Google-Smtp-Source: AGHT+IGhcywQo9UynmReNgmz8cK5z3uBFN04iFF5tXUNfFAh7UeVZti54hY8rHdrWU7tmvvAXTj/hg==
X-Received: by 2002:a05:6214:212c:b0:6e6:5a42:8560 with SMTP id 6a1803df08f44-6e886899d51mr50000726d6.23.1740575064570;
        Wed, 26 Feb 2025 05:04:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b089bbfsm21751036d6.50.2025.02.26.05.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:04:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tnH5L-000000007It-2YCf;
	Wed, 26 Feb 2025 09:04:23 -0400
Date: Wed, 26 Feb 2025 09:04:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>, dwmw2@infradead.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
Message-ID: <20250226130423.GF5011@ziepe.ca>
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca>
 <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
 <33c4755d-6a0f-4734-88e0-84f0de67b652@linux.intel.com>
 <83039906-77f7-4318-94bf-4c98bb3f0e32@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83039906-77f7-4318-94bf-4c98bb3f0e32@linux.intel.com>

On Wed, Feb 26, 2025 at 01:55:28PM +0800, Ethan Zhao wrote:
> > Provided the system does not respond to those events when this function
> > is called, it's fine to remove the lock.
> I agree.

I think it is running the destruction of the iommu far too late in the
process. IMHO it should be done after all the drivers have been
shutdown, before the CPUs go single threaded.

Jason

