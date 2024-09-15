Return-Path: <linux-kernel+bounces-329866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DF19796D7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1939281D91
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681851C68AF;
	Sun, 15 Sep 2024 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ht1w9fSx"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5367712CDBE
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726407350; cv=none; b=GNGX9AmZ6SP1P86krPSryynK414pRm4tXZOle3QrMCdaBiQp8dG/de8WRoi5hhjsS0rilemL4++jcpZZM/D612e2SfAEIxYI5HNh5hetn7PaDvkDod/lY44Em+wDzK7Q7fNIXWpmvBdUgZybokam6aplC3O5AbBT835oRNOV7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726407350; c=relaxed/simple;
	bh=MFuUzm3zMLV2CZh46NonDUDb1OmZjnpTyIwCOgzIMhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayOPVTS8272gZjsbU91tA1ErRE4N2qVGlsRRP03ucHLhP1O116B3VtmU+RjPeZgN0wK6NlgOK3/GZ8j6pkQHXJVgn+h25gwvXZBvU3E+5g3Sa/XD+1t4fJe5967cbz4/9ojsV6Q0Io6Ci1/3jDxO85/7VglBbb80DEcAmRXaVF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ht1w9fSx; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-456757d8871so20153011cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726407348; x=1727012148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iBZgZQ/X+6st0aH7GdIVp1tBi9c0iIhLFTb6MeWUSec=;
        b=ht1w9fSxNJy0ez9Hqa3Y3Y9wr8zTcW72Qy9d2luxR7133NBWDZ8xRBNrz6Rn3BZnzK
         NKLMBA0qHPBWXpRd3J+wkpW+AKpm86LW0HNcWau91ACzVr4cveZHlzTc37c0CROqOa22
         UtIg49HcdimZ8LLCy1pEcFVhDwQfJ7/6TQ8RuDtjL5gUqZ4eoZzqsb9CVmmBIe5SAu4H
         xfuF7MIkEEgwXvHpo2nt1J9wHi+YXImEW5L/M2lRiGkweiUqgjaQlpoW5UejXEhJ8PTF
         fPubsqs+mpZeogjA7DANoQ09XjoZ/ksNU4sy+xvITJ67UdvGseYFR3wbD9NljJFkZvDq
         pWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726407348; x=1727012148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBZgZQ/X+6st0aH7GdIVp1tBi9c0iIhLFTb6MeWUSec=;
        b=drc60v4Q8tUn0iWK4b9xDSNT7bhupNHMd1yoodql//qu+nyVfuNBCCe5B7cvcgE4Ew
         2jTDSSkMiGpInuhTyiD3p/JHNr+VUy52nBGPJer67+Nwpi3WvoRhxtHSP/NwTYxYvOi3
         hKhZuU3XE0RAwgl7sLRlZIlWbwWWnMn9Uh6diDFqOX/MEYE/NVBlmTXsYzN8mey2z1Jq
         9QsMXQGz4BRK7sHBBIYzNGq5aJ2N17SfPlDpfBqErXQerdh41dHQwCeWrkUY0CFEutor
         Nb5BQk33wNFW8wnZqf3Sn4Sa2WR8wkQUYxvoPE3LO+ffXqJUEkTVV5AXT7oTfegJqY/4
         BxEg==
X-Forwarded-Encrypted: i=1; AJvYcCVJt/XQxfC+fGy7f7Mz5/4tAvlMvI4F99mgK88oEu4RF3ppmGtcoy4X7xFVYRKPaIGWyJVj8Hk2ar740yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCKicauu+G+k1Nwr/J5ZZg7k1/kohXoM/qkdQ+skFdBrlXFmBS
	0lL8FJPdNSPWr5Y14oY/IabtFwm+nD4CYz3twaxbhhwFfzyoT9yeiVenIwsJzGwbuDOIi8H7I8n
	h
X-Google-Smtp-Source: AGHT+IFfd55b1bDIJCVeC7CmAbChsQwmoF/CcF7pxemMMuQO+q6jkx98WdhJWgJxofnNUxtRsST99A==
X-Received: by 2002:a05:622a:1a88:b0:458:4286:6762 with SMTP id d75a77b69052e-458602cae58mr187488141cf.15.1726407348207;
        Sun, 15 Sep 2024 06:35:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aad2363bsm17960661cf.86.2024.09.15.06.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 06:35:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sppPn-007atk-7Y;
	Sun, 15 Sep 2024 10:35:47 -0300
Date: Sun, 15 Sep 2024 10:35:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 for-next 1/2] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
Message-ID: <20240915133547.GB869260@ziepe.ca>
References: <20240905131155.1441478-1-huangjunxian6@hisilicon.com>
 <20240905131155.1441478-2-huangjunxian6@hisilicon.com>
 <ZtxDF7EMY13tYny2@ziepe.ca>
 <d76dd514-aceb-b7cb-705a-298fc905fae3@hisilicon.com>
 <20240911102018.GF4026@unreal>
 <d8015dc6-c65c-2eed-0ffe-0c35a4cd0b2a@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8015dc6-c65c-2eed-0ffe-0c35a4cd0b2a@hisilicon.com>

On Wed, Sep 11, 2024 at 08:38:35PM +0800, Junxian Huang wrote:

> Once hns device is reset, we don't allow any doorbell until driver's
> re-initialization is completed. Not only all existing mmaps on ucontexts
> will be zapped, no more new mmaps are allowed either.
> 
> This actually makes ucontexts unavailable since userspace cannot access
> HW with them any more. Users will have to destroy the old ucontext and
> allocate a new one after driver's re-initialization is completed.

It is supposed to come back once the reset is completed, yes userspace
may need to restart some objects but the ucontext shouldn't be left
crippled.

Jason

