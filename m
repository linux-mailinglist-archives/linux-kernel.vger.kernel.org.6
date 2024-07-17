Return-Path: <linux-kernel+bounces-255142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0124D933CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70ABBB209C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E029C180038;
	Wed, 17 Jul 2024 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ifEEHh9g"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D99517F38D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721217397; cv=none; b=ASnxT7RVVw/4h7fY/NnmFeYq9Cm+F0ybTl1g/90OyQe1z0GRWYo9jNkaqRgXGuGI5HPSNSW6PeWt39JIelWJGbV95lgtst6cjyEN0kS6/e7w0Oh+IWESooFDkbnVfgl4D4vY0rfnt0h189q8wXgV85gnONUGVlnuIJJo1FuqpX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721217397; c=relaxed/simple;
	bh=WElkakyy4B3dqTGhkHumOe7VtwvtJDMdwvAuHtPPYZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MISSg5c+8WM+WWKMbmRiYhL3yBytwRjVwJHssI4EAW2jbKG3Wp5rftiKLJ7RvXs9xpgBNSqWqkLSRAFNQn5CGQfwe4blwEhdI0gLE/x0tH07eLUrVn/idNEBo8k10+3goSpHp2Ccb5pTto/2BDTheJsZyHVZ8Dgc4YsY7e/2t+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ifEEHh9g; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-449f23df593so36648621cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1721217394; x=1721822194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WElkakyy4B3dqTGhkHumOe7VtwvtJDMdwvAuHtPPYZ4=;
        b=ifEEHh9gYWF+pguC5HORoPi+42HNCnZBF7lRhpgxiK48YXSe8fvJUIwe0lYvjOb79V
         WkdAMutYB5QXEaq9Gau9FN22BG6EwdC7slaFLjbP4wRSMRcAyyJqvq+EwNC4ckbHJSm2
         32BeA+Wcoq0fvg6V5o+++vM4l/OctkJAx4b1f+63PBSQ4PWAPdbs4oWLuPCEXOgXaCES
         PQ8QUuP0jFmTxAveXM/Z4rluCibp49iIXyfxN+0RyCRz7/BdmZCd2Iosb4eDr6WKA5Hb
         tEXvt3mjRDZemHiV5nuUXnZcLKB+FuVMb0CXkUzAA6WQiHuzaJXlmp+r5psxk75V+GWw
         drJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721217394; x=1721822194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WElkakyy4B3dqTGhkHumOe7VtwvtJDMdwvAuHtPPYZ4=;
        b=okcZ3PpKN0JAxgwXgKHFA9KwXABE51IO9GNVDKvsdV2tQ+tvSjyAfqWOj+FAIIQ3k5
         lB96pt3E/5y3dQX6CiMrPqgQNJdlVjujYGOfGmKAgE7oQuSBk8HVhF7QgL4gj7rI9NRR
         WH53wn/Y2j1hnfJMtb8yRKAz6rmLLmyjeFABMH9zC3hkvaLDzNpsx63GdphcFpNOIIFl
         6V2iSgs5JrKQW+4jpnqfF4gXWy3YayWmyJxHKCbAD9JXyIrk2D1YXpqGiVs+Oca6HE9M
         kPK95KyBF0dVIMvtBe9GYzcH2R75ijA1nokrzb4xnUg4KKIQp1q0Ct04aN+I5OOTu/jf
         CfSw==
X-Forwarded-Encrypted: i=1; AJvYcCVp2/uHMZnUk9ZGNz8Ed8RuC2T2HW75pMltkfWA3iEdi1NqSMU2FbyJWi3Xi6k4+CtsuklcXoplV5qOWQr2GDsYAv1dT7OFTLQKdl4v
X-Gm-Message-State: AOJu0Yxrq9hNktKycjtt+4zTQVr4oJarw2vLbQKJ4VUNNMidCQWVroFA
	xRbQfLOyrVlLvAp+k0ZOIwAXiEgB0rf5A92O6kMmHOewOqbcbbUr3r4MFfWWjmI=
X-Google-Smtp-Source: AGHT+IE/0Q/uXWsCRcJjxaWZkCF7Tdmfn9zPWdjtndHQVv5k5JZIMW+N7JiwOE20cY8Olz6fQuWeGw==
X-Received: by 2002:a05:622a:1b9e:b0:447:e40a:f61a with SMTP id d75a77b69052e-44f86194b15mr17153611cf.18.1721217394254;
        Wed, 17 Jul 2024 04:56:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7f0e7asm46534311cf.40.2024.07.17.04.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 04:56:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sU3Gr-00FTFD-12;
	Wed, 17 Jul 2024 08:56:33 -0300
Date: Wed, 17 Jul 2024 08:56:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Leon Romanovsky <leon@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 11/15] RDMA/hbl: add habanalabs RDMA driver
Message-ID: <20240717115633.GH14050@ziepe.ca>
References: <20240618125842.GG4025@unreal>
 <b4bda963-7026-4037-83e6-de74728569bd@habana.ai>
 <20240619105219.GO4025@unreal>
 <a5554266-55b7-4e96-b226-b686b8a6af89@habana.ai>
 <20240712130856.GB14050@ziepe.ca>
 <2c767517-e24c-416b-9083-d3a220ffc14c@habana.ai>
 <20240716134013.GF14050@ziepe.ca>
 <ca6c3901-c0c5-4f35-934b-2b4c9f1a61dc@habana.ai>
 <20240717073607.GF5630@unreal>
 <2050e95c-4998-4b2e-88e7-5964429818b5@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2050e95c-4998-4b2e-88e7-5964429818b5@habana.ai>

On Wed, Jul 17, 2024 at 10:51:03AM +0000, Omer Shpigelman wrote:

> The only place we have an ops structure is in the device driver,
> similarly to Jason's example. In our code it is struct
> hbl_aux_dev. What

No, hbl_aux_dev is an 'struct auxiliary_device', not a 'struct
device_driver', it is different. I did literally mean struct
device_driver.

Jason

