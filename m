Return-Path: <linux-kernel+bounces-568964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56762A69CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488581759C5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA24224250;
	Wed, 19 Mar 2025 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="asVBW0L1"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E19A2222BF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742427866; cv=none; b=j/WSBxZBhGjEECiiOHfNMtIVUqE2vby/+fxGvUwG3bsg/0TeF1GPuUGaetCq2fOjN7k9KozDxiERDs1SQeVt6ZouB+kDqn0Hj3TVM2ZAlQVv1XCAnbtR7KguMRNNh9Eq1E0hg45t+StH7RmDnd9p6rmeQuN6LFvNcRvOlt5Kfm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742427866; c=relaxed/simple;
	bh=Vh55jnJy2grFwLLHr52AS9nQQTqMbkRIqCLV5X+4ptc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct1zr52Q6+EOjy2fgI2evU0G3ZCAJDuFB3Ux7JwsPFpSP8YdikWM6mW90YMt/NJHfAvTOPxFcnJjl8zDqBqoqLV2iLXLFoZWOKYTbDP8ATw/piGuOYdeJFueI/elItUIXUz4CQkkHPCidvtGo4J4Ghl+1XEmF6nrST6Jy4DmXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=asVBW0L1; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476964b2c1dso4396521cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742427864; x=1743032664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vh55jnJy2grFwLLHr52AS9nQQTqMbkRIqCLV5X+4ptc=;
        b=asVBW0L1oJkgEBUPbwv/Iqz9svWBQnPKuz2hJWD7++ubKG3cV54X9jEcJDjn30L49S
         l2UVhkrQ5F1mi+r+JC8n6XHxksFefuS43yhs5uADEiaMIAhIkvuqU04J7tkx6VprDSgF
         nu2Pgxcg94Fq4TFAVb32Pdch1Sp+A3xF/YEuut98ojpozCc0dawIZA/EOGJWlKlmJWWE
         9n057qsZ8OzeHmWE/Stz7stAdjQ45Jt8ROUFqd3EgR0ciVYbO2bL+bu9R6tcHpv/5clO
         xf4LE8qcG7z+8tcfI7Ktv3xcMUBIPiir0X1GsxyRzYR3rlosevqdVpxVefLUX0BiwVqS
         OkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742427864; x=1743032664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh55jnJy2grFwLLHr52AS9nQQTqMbkRIqCLV5X+4ptc=;
        b=WsM5c88gPBxchGzkiDEFcjvvtYVUWzFUvTHAwm7STe51cVXvSc1dCQSYs16XVAdral
         I8NxMujY4lbmHHfwHHblUtUpywhXN+Nf1pypHa+zebS5ypupgnmPgZb5xt58Tf99YP5p
         zexJ9gomYYuamb+/cMql4gCaLVPhBYUTpBozqhIX5CbR2A9PbQqfN4SRIUTyDltyyOHB
         W6Qm9HCjm+9qoB1afG4ea0Xj3Fu9naxQ7/C2G8C3X+l3/GvYdqJOO+3LdZR0YUZevvTU
         iHq6FHFnUvMMYKtA7ZvGfT5RSZ1QZV73jc+RtCk2rx4xF5eTF+jI8ID4mEd929fYnp6Z
         18lg==
X-Forwarded-Encrypted: i=1; AJvYcCWO+2VU+dzQMLxsKqKrnAhtrO24IDd/2ytU0c3hag996oP3nNzs7S1rt8xhZyVp3wAgusFkjpIBQ/o1Myw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1eK7dhM/z87dm0uqcWusxThS+HLnmopIjUnIEKwe8M6WII2Tx
	730dFfCzfU5VH7idPHV40Q3FjV13xTORsMyuR2se9perQL/583ClbuqRb8b7S4c=
X-Gm-Gg: ASbGncudhYPdBEsayu3wn8IfVcUc+Twl5b/OwGnNYz6UUK2/GBHfWY70jT6+KpJzQuL
	Nlha1/cEWPDMMAw4biH/aKfZhX6QO8WWueyQ+nuFcfmKK/WWZB/nCgBFXBrhWSIq3W+fNocmasx
	JkeNhBTEOG0Mb+g2UN/dP6BdJYZ3KG663Q9vytkv3SO0z8D7ZBdFis6JryypGvAyGLcKV9hO3WW
	wNPLugRrnlws/k2mi/liSk5Bzj4mAnWTvxP+UoaoDAMlKKVEU6APa2W1td/XXyb2pdzsZt/1Wup
	a36SjxHVqAf9s5Pwio33xEf7mnc3FG4kn2NKBI7nBg67ZBPwCdePNJudar3OUfi1+jC1CwZvIr3
	to0ppm0NdgDXIEhxWeg==
X-Google-Smtp-Source: AGHT+IF+fj9+38BlQ3egRKwX5axqC8Q6Kq8BwaFO1wbsyUuFXTRy7mG60I78Ff7FJGVMt4lfemVaVg==
X-Received: by 2002:a05:622a:410b:b0:476:bb8e:a90e with SMTP id d75a77b69052e-4770839e2f2mr88068521cf.20.1742427864047;
        Wed, 19 Mar 2025 16:44:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb63cb11sm85166061cf.22.2025.03.19.16.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 16:44:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tv35C-00000000cos-3wix;
	Wed, 19 Mar 2025 20:44:22 -0300
Date: Wed, 19 Mar 2025 20:44:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	linux-integrity@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 3/4] tpm: add SNP SVSM vTPM driver
Message-ID: <20250319234422.GG126678@ziepe.ca>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-4-sgarzare@redhat.com>
 <e4eeaead-2277-1f6f-86eb-f80deae2135b@amd.com>
 <Z9gm9iWhk5Zs2NvI@kernel.org>
 <CAGxU2F7fdAi148rB-4c==-qCOW1SJjwf4AzC2=TUhfPXMhR5pQ@mail.gmail.com>
 <1262fa5b-0822-b8d4-26c5-426ffa4e0265@amd.com>
 <qne5fm44dhkbnwc6ldgff76ljt7ecd3cvtf3b3lhos56yyx2ez@qbcv45zbxlhp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qne5fm44dhkbnwc6ldgff76ljt7ecd3cvtf3b3lhos56yyx2ez@qbcv45zbxlhp>

On Tue, Mar 18, 2025 at 05:18:53PM +0100, Stefano Garzarella wrote:

> I see, thanks for the clarification!
> I saw that with devm_get_free_pages() I can easily allocate a
> resource-managed page, so I'll do that in v4.

As a general note you should just use kmalloc these days, even for
PAGE_SIZE. It is efficient and OK.

Having a struct that is PAGE_SIZE+1 is not efficient and will waste
a page of memory. That should be avoided ..

Jason

