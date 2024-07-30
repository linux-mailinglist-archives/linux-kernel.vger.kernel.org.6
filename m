Return-Path: <linux-kernel+bounces-267565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4479412DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202EB1F22F36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C965519EED5;
	Tue, 30 Jul 2024 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Qw7Az58T"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1FD1993BD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345252; cv=none; b=aw5rLgyI0wo6zyh5oxS934iVtxaKnMVw4BNOczVPLResSFfMCo+TTI4ub6JnRLuI71zSbDzWdi7H48n2PrwXvAMrJzojVNtnobQ5ps/hW0NKdOCS2xTUKpvXWb8s/28zBLdvD5fX5Bt38XxSYn5sTxDm2GZPXyfvau0YSTn9gxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345252; c=relaxed/simple;
	bh=7nmLyiiZmSqCQ/CKXCfqPn5m6vkHCPvfU0etj1salOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsI/U8ndF5qtTgS0qTLaoLo35oEYydLqV0CsXDlM5pcAgVF+TFi44GPphVyl7tuTUUxsgbor5Q3jeFOoG3p3z6n80tJDcg3dplCpKY0SqmmAg/nfvyk4AbBA2QmFPLi4SsS9L0CTWHcvBOe7BMf0tEY5iXQoW1Ux17q2dYgh5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Qw7Az58T; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3db1270da60so3260239b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722345248; x=1722950048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3BdzZ42XevRdgs1HlIK+v9ADIdsvkrZfCAlsfSAxkNE=;
        b=Qw7Az58Tvg6LZrBBm3C1UA1A3QzPXlo2TpmK4o6kNzrwYvpViz3pe3DGbayW6X09Uk
         imeg/AiX6JD864pTfhU93MRhGxvXtIHwYGoCT/CcVcV2HZk2hScMYZn/n/nWqnzceSaz
         4nWaoofYPhyniTGqbjqeRwInL/EinPJ3FjC8/YXNNBdkolbNudAKfPJc/nCcyuoeLoDg
         ZzcsNRlOGPvv4dqR0ygFqbRZrvHfAg9bw0+Dn3Fk5tw7ZKbX5MqD7fX126gLbRvAAX4Y
         ZcFQ3bjcg0jeCNCdsKEYNVMvnNYFcN9xxEYMJyeL/BBqgrv91ZU+XL8RAatLWlTvOhJc
         RzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722345248; x=1722950048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BdzZ42XevRdgs1HlIK+v9ADIdsvkrZfCAlsfSAxkNE=;
        b=LD5uhLrkKJIF3y6LAG22p+vj2MqOZhlBdivPiM8AaVrqzAPcvOSuZjV8PBumHR9h74
         uGiv8K6DNPolz/kqIoXWcHz7ZM/TwFFUngcFW8mK6Oo+CHiOfyBi/JjOcrw8/O/d3VSV
         2a+DwAaSdfJoSsTRLk/PBl2C0VXxRQbYnh/OEG1lp8bvYp81nKR/OKWG6c6RrkpaKK6H
         M/Kj32e0q9uVLuoWqfFFL1JUi/RAImC5pE462gKVLmll7pWXWpMa6wcbW8XftR60eMW+
         9T2UYjsN3ngOpyUs5TL3ZifzGyAtXTsTW2/GBHf0wxY+yV2u8KMsF+6kuRudRSMtIlnx
         uO/g==
X-Forwarded-Encrypted: i=1; AJvYcCWiIPOz8NmjmX8bJWFKNKuHKrK9NKmS7uYrTC0CYKCMecVnHnmg+BKmywMYlgWR+ja/GTj6fxhGS/b0SlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa8UoEKAcgjEEfaDNEk42/NZzLsvOnZSwUuhAkkxmFsbcfcVz0
	KFXYDZ5qvJwTCxWDoIvCihzqcCESZoLCaQEXKfLBT7EKNq2q6kmSnq0t1e/xR7A=
X-Google-Smtp-Source: AGHT+IF2b9X0EqP9ZetfyjkLgGCQCByPlxOTBVJOvusfPUfRQURMoMpWLfBuLqGVsMLijBvxX8UbwQ==
X-Received: by 2002:a05:6808:1495:b0:3da:bc74:e9d3 with SMTP id 5614622812f47-3db23a89bc1mr15982671b6e.17.1722345248318;
        Tue, 30 Jul 2024 06:14:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f943a30sm62633986d6.74.2024.07.30.06.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 06:14:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sYmg2-002OHg-P2;
	Tue, 30 Jul 2024 10:14:06 -0300
Date: Tue, 30 Jul 2024 10:14:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux@treblig.org
Cc: alex.williamson@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Remove unused struct 'vfio_pci_mmap_vma'
Message-ID: <20240730131406.GB3030761@ziepe.ca>
References: <20240727160307.1000476-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727160307.1000476-1-linux@treblig.org>

On Sat, Jul 27, 2024 at 05:03:06PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'vfio_pci_mmap_vma' has been unused since
> commit aac6db75a9fc ("vfio/pci: Use unmap_mapping_range()")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

