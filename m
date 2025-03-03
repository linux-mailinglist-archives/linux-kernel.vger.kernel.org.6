Return-Path: <linux-kernel+bounces-542543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A1DA4CAF3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19707174F90
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986F322D7A7;
	Mon,  3 Mar 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="m1iAWyyw"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990CF218AB0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026393; cv=none; b=tFMHBWmBGnOBH5qHz4JoRejMAWa9ZHSnhKIxcLd8wiYbv+4OIqYg4kZ93IyzZ7uKK5houKXB3Z99pwqEJsoaXQDAXesT6ii9krE+CxguUGZQpkZxUJaAyhvxVgSfCnrKDULkFHAbmQq+UG5ObVTuRkwZFtPa8hJcssQB2azfOWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026393; c=relaxed/simple;
	bh=ZC4tlA2vNihT6P1/LNSQISGA8y015oz0KZ6dDXi8Fq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Plj27c4RfFTee3uNh0Na+LSGblf+xn85sHFNUV5UMofLt++uN/Tx/ZAQgyx1QMrmDCgdxx9B840Bxo9Cd1naZ/weFRympTVrXnCX1AgDzyoOiZTNsikf10IxkH4pYo8Piel5Ume5yBmdyQUB+z+yRNLHlNsh++cAVcpD1LRtyWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=m1iAWyyw; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c07b65efeeso436927285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741026390; x=1741631190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8P3c1f/2WglsHSb31TjBEda9T69Y4xomID9q8JyMtZo=;
        b=m1iAWyywqh1ACPnznrwC8TJkn35hCU6w7kmoXeyb51Zt3KA9OErvy1EcT6NqVXmHMM
         wFlauBgxG5KSL+WjQS3ajUPl+ht29pDKD5le0ylfh+9PhWP34cMDs1XexJUlZ1ofZKvH
         f8iWroKfzQ1eIrb7XiH7m3aLkn9TQ6mpy5zW22qY+J2pHaTgRXjUurhGwdmsYQIXth9p
         RoTZjflB0npOZQ1JUqFMgUcSkIXN+R6fWP/B/p9laTJymoFzcsosCzoShUhsxcpo3qr8
         KXNFA2tvX9IL8AhqxUfIeY0PuMJje1pOVKyr2byKgQmzsojLAiKXbV01Wnsl0bL+mcV4
         3yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741026390; x=1741631190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8P3c1f/2WglsHSb31TjBEda9T69Y4xomID9q8JyMtZo=;
        b=cfyWwzfNHtv4jSluNt9/gGf5cSTBXF6lh8BkqaPi9eLTKvDS6St5jq7+e5EWVUs2Jh
         r2s8XqbP+c3iEf5y/R86GLu/X7gfiuaGaUXBcaNnacOGofaFpnO9Fd9L/OuiMmz2mmrf
         xNwz1vCHZQcPb0syLfZUhAcKtdjzwP0xNO5fxkLh3ZZ7sIKD197oD0FXrUgGiFo0Rx0U
         nF09VKhpchfgzVlqhINxBz2zDyQcPj0+0Xfg+rFA2sbIwhq/MUxIcUozrRZBiAgHdrxH
         p0wVF5Z8RLgxCmo7Q8PqRjIUJfwRuqm7Y6KbNEMgRjfDMto5J8uiSn+zy2i+KU/KnwPU
         ACaA==
X-Forwarded-Encrypted: i=1; AJvYcCWg4J6jEN5GhsmxG/sUPdll6IH1G80lRkFSLSucXExmoK99ch1xDnI6KTxLUXgZwc5tM7Ba9bZwH2TlN3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyY+rSiu+t8xYm9ycQEtM6i7P8zfviqzVzjCIvnfmgnMesc0/B
	Fb/gS4WejuuladpSDGneagQzl9piAVkMecwVFugL6QtNWjr86d9TFqXYxzNCrI0=
X-Gm-Gg: ASbGnctIcWTe6tMSZQYb3Uvcazio684FcVugn4AJQ7LglZVrbYNRaCOCCJqRK/adtM8
	VpBUfcBpvgM2xwJ/84lz7CS7daGcKAZSKHxdLmQRPuAFLq1pc4zNpTosQ42hBkktor6aXeWD7Ml
	2LNzYvI2uwQzibbmaXIrPcL064r5SD0zPhtYFr0V7THt8fMjoB7REjigtVsemoq1TuJjtfRhKIh
	FjjeJL7bg7kDx7w9s5kb+EmFtoq+Uu8eLv3RwoJs/LVOSjwWcvAX3mTLlpUEwvLBhYpQyuNXfR0
	m6QWcZjKvWQ9m9bFKoyXdD60XlNya2aexDPwG2RooduWIBnmiQt+6ZLmsc/VIQ5d72+bQWJSwUY
	Gk4sgJHMMcbhAsTHz1w==
X-Google-Smtp-Source: AGHT+IE66gglyyQ2xKgSQXIbdA8WBFQ6IzfR/o102BpGE3gMonp/Wrali1UCV/qGdLX6c68bqdZobQ==
X-Received: by 2002:a05:6214:4113:b0:6e6:9c39:ae51 with SMTP id 6a1803df08f44-6e8a0d85f8dmr193980056d6.33.1741026390548;
        Mon, 03 Mar 2025 10:26:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8c91fbf79sm16019446d6.33.2025.03.03.10.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 10:26:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpAUn-00000000qHb-2ItX;
	Mon, 03 Mar 2025 14:26:29 -0400
Date: Mon, 3 Mar 2025 14:26:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, leon@kernel.org,
	bcm-kernel-feedback-list@broadcom.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Unwired pvrdma_modify_device ?
Message-ID: <20250303182629.GV5011@ziepe.ca>
References: <Z8TWF6coBUF3l_jk@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8TWF6coBUF3l_jk@gallifrey>

On Sun, Mar 02, 2025 at 10:05:11PM +0000, Dr. David Alan Gilbert wrote:
> Hi,
>   I noticed that pvrdma_modify_device() in
>    drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
> isn't called anywhere; shouldn't it be wired up in pvrdma_dev_ops ?
> 
> (I've not got VMWare anywhere to try it on, and don't know the innards
> of RDMA drivers; so can't really test it).

Seems probably right

But at this point I'd just delete it unless pvrdma maintainers say
otherwise in the next week

Jason

