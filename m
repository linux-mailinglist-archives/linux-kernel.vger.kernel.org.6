Return-Path: <linux-kernel+bounces-570010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420DAA6AABA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B60F16C3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE07F1EB9F6;
	Thu, 20 Mar 2025 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I15WQL+z"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F9821C187
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486933; cv=none; b=r4NQ4DpG/VSBgPbJ64bDEy3EEVJZEUPsNKqpSmuiSqOb26MNRtduRl68twBd63N+ALsO/h3u9AU7dWi6uzxL+nZzKjU5GMyDEZO2F+kiIPMLO/vgEwocbpcRZ/OxKaesPN0jmCyR05l+s21lzG/szgtl20LwNTTJRwKH0HXO2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486933; c=relaxed/simple;
	bh=z84sso7f3UfJQQ/31OsOx2FNEB5xtG36UftFfRP7B8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXy+O26kGSEnKSWfQDDglvlo6CyOEaUFtfPUT9rsgBroVyzzBsfUltKOLwJ3fTsIXwAnzkroUmVC9+lfVwkvf6uzpbyQwIFUhpcGKXv7ojXFLkMI8M0TlUH7XUIADJDhlCsZhAs32SFT3SaYay7e4qnyG+puxgrnPEkFqH6fV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I15WQL+z; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3996683dd7bso129750f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742486929; x=1743091729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kHa60JIYKX9PlEg/V64hxswvAVtVGYMyVrVKFBfiB0=;
        b=I15WQL+z42+lJ28g7mTs90ZQWyiHemkkhySDP86hqkOMQ2Qf1VVS4tjPMAy75GZ9Jb
         pVkHf3i6lylfZCr17gZKr/qgWy2tAzVCyT1PPHWqdUlgDj4iqxnY6LwLFiixX3Rc72P0
         VCvayJee/TwqtAs7rQt99KsGCCpSQQzFvTtThMOg25PlYM65wzjryNBvFNKZ+eDSX774
         xr4X/e+6xDrBfYDEsgUjrzTm019nLNHeAZn8AvqfPN4CrY8CAXwTlJc4fOdDXVOpbiKL
         PnJBh8WqfD+bs00oCPjeO65aihd1yiVU0hsnkK7d24+JbXN391wxIF2GK1dcLvdXOZ/F
         BacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742486929; x=1743091729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kHa60JIYKX9PlEg/V64hxswvAVtVGYMyVrVKFBfiB0=;
        b=WZD+iFK4OP+QZzDZ/UNMYViyqsEFOlk0yOhNnQWk+a2bZd5Pk3ekTsn2EXUwo7ji2W
         Ja4/QLQtU8t7JlJqe0JQs4JVoNHsmSMAtHJ2Y9qMQKnRz+YleLyHLBVmr6g8GUXPjiNZ
         SPKwMCRSbVeP1ZosXn4QnAbDWHOK7l22+923QPMX+h0g7lsmrTx5OaYYRCxjUpugpaTa
         foPf2nW8ne3g3YurVfpaq2+6BOyhHD5S6LwqRmWPkHtLBNIIO5iPdIrQZnUp1b9eEXNv
         ezQeOMHqs0L1ozGRts9Bt/3LS9DromMa2ureOXNBoj83funC1TvtwrK1P3kQWC3CXoWT
         t4Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVYlUNjihEBuNCU9Cu4J8pea0lABMgQvxnuj0SeqDt4ZFBa+GIZDrSERtVzTXvSPxM1YVKlm3nvQRbgrl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7rU2WAgw58h3yoQDOV2JGm/nvjQZyrVi8dDttIj9GXHm3J9fe
	2+e/7dmmcoYsdV8BlHFKMaSRvCcbwVsS3kELm6te849nIab5NBxE8iZgjgJ8Y9E=
X-Gm-Gg: ASbGncuVDggM1Sn6VX12fQQkzqRVNh/SzCDfwuTRTCszHm+z+17KhS1GbEfWk8Y6ToP
	0Sy6E61eQzLtnPq3OJfzpQSRD4ls1eo09g+hQQ/v1LjlMEa8YyXsdLMgQ64cXCybBNdKTNbKb9q
	ZJNM3vxHsQ9avspmqBwG53GLqtbhuqOimxyrrRpFLIY9C1e03ypi2s7ETy4dPsIwoenZKcUTdpG
	GND1JoiwH3jJyleRn+/3NvWfLwi6PsLp8GuBg8tnwB3Mmpk7dlt/U6ucOCdko6ivWcCBbasRnrq
	7KLnelPMvxL9x4zwOeET/2b8YS6ijXrx297fNOivJz1KU4XNyLf5tvQEhgO2Exj8QHW8PjZUwD1
	8lw1WEDLJ5msCmiWfvNLK/s+QkEuen2aEy2U3rOKWt7WHLpXEWA==
X-Google-Smtp-Source: AGHT+IF+n4/125DWwRd4QO/E8Ib23KmYraVt8CqKURPcw7uagoIh6m4BUkg4QsmBHaueqHPBc4Swww==
X-Received: by 2002:a5d:6da1:0:b0:38d:d371:e03d with SMTP id ffacd0b85a97d-3997f8ee224mr36284f8f.3.1742486928898;
        Thu, 20 Mar 2025 09:08:48 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f81sm9920f8f.35.2025.03.20.09.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 09:08:48 -0700 (PDT)
Date: Thu, 20 Mar 2025 17:08:46 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Robin Murphy
 <robin.murphy@arm.com>
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is
 DMA safe
Message-ID: <20250320170846.64db4a4d@mordecai.tesarici.cz>
In-Reply-To: <9ac953ec-fba3-41a7-8e5d-b867abc1566f@sirena.org.uk>
References: <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20130205142128.2E28D3E1265@localhost>
	<20250320124330.480d652d@mordecai.tesarici.cz>
	<ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
	<b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
	<20250320153536.44774a74@mordecai.tesarici.cz>
	<9ac953ec-fba3-41a7-8e5d-b867abc1566f@sirena.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 15:34:42 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Mar 20, 2025 at 03:35:36PM +0100, Petr Tesarik wrote:
> 
> > CC'ing Robin Murphy, because there seem to be some doubts about DMA API
> > efficiency.  
> 
> Or possibly just documentation, the number of memory types we have to
> deal with and disjoint interfaces makes all this stuff pretty miserable.

I have to agree here. Plus the existing documentation is confusing, as
it introduces some opaque terms: streaming, consistent, coherent ...
what next?

I volunteer to clean it up a bit. Or at least to give it a try.

> > > > The whole goal there is to try to avoid triggering another copy to do
> > > > the DMA so just reverting rather than replacing with some other
> > > > construct that achieves the same goal doesn't seem great.  I think
> > > > possibly we should just not do the copy at all any more and trust the
> > > > core to DTRT with any buffers that are passed in, I think we've got
> > > > enough stuff in the core though I can't remember if it'll copy with
> > > > things allocated on the stack well.  I'd need to page the status back
> > > > in.    
> 
> > No, I'm afraid kernel stack addresses (and many other types of
> > addresses) cannot be used for DMA:  
> 
> > https://docs.kernel.org/core-api/dma-api-howto.html#what-memory-is-dma-able  
> 
> Right, that's what I thought.  Part of what spi_write_then_read() is
> doing is taking the edge off that particular sharp edge for users, on
> the off chance that the controller wants to DMA.

Thanks for explaining the goal. It seems that most subsystems pass this
complexity down to individual device drivers, and I agree that it is
not the best approach.

If we want to make life easier for authors who don't need to squeeze
the last bit of performance from their driver, the core DMA API could be
extended with a wrapper function that checks DMA-ability of a buffer
address and takes the appropriate action. I kind of like the idea, but
I'm not a subsystem maintainer, so my opinion doesn't mean much. ;-)

> > > From what I found, there are two scenarios that may depend on
> > > GFP_DMA today:  
> 
> > >  a) a performance optimization where allocating from GFP_DMA avoids
> > >     the swiotlb bounce buffering. This would be the normal case on
> > >     any 64-bit machine with more than 4GB of RAM and an SPI
> > >     controller with a 32-bit DMA mask.  
> 
> > I must be missing something. How is a memcpy() in spi_write_then_read()
> > faster than a memcpy() by swiotlb?  
> 
> spi_write_then_read() is just a convenience API, a good proportion of
> users will be using spi_sync() directly.

Got it.

> > I still believe the SPI subsystem should not try to be clever. The
> > DMA API already avoids unnecessary copying as much as possible.  
> 
> It's not particularly trying to be clever here?

Well, it tries to guess whether the lower layer will have to make a
copy, but it does not always get it right (e.g. memory encryption).

Besides, txbuf and rxbuf might be used without any copying at all, e.g.
if they point to direct-mapped virtual addresses (e.g. returned by
kmalloc).

At the end of the day, it's no big deal, because SPI transfers are
usually small and not performance-critical. I wouldn't be bothered
myself if it wasn't part of a larger project (getting rid of DMA zones).

Petr T

