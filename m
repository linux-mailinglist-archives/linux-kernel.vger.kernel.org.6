Return-Path: <linux-kernel+bounces-188011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DBF8CDBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A791F24948
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD3B127E22;
	Thu, 23 May 2024 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1EJCUoFe"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8543AA3
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499082; cv=none; b=iKiB3OIa21XVSj9qpIfddQ0v2hQguN2tsy7KXnCGgjBfMJn2sgtSeoQj3MswkENBlDFiFFjK+5Pb2Un+pzLIQMXFA5WZIddzvdQBlAOqTexJINdg+WkASGuYTxHrH6hI21gyrD1rcLR0MosH8HPrL+DPjshF16peYzO4jReSOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499082; c=relaxed/simple;
	bh=E60KwS3yfBOzkwDT676+MM7o2Au2xZpAQhVcMH8quk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTxHsp8nCRTNyfDwDU/yzanneTO4yd/0fEf6hTnW4xgOce/rUz/Nb88IbCCVgbHGKJtD3lhOqEnTP8GbQ42e19iUO7w1OWbALeHS9Js1xp/nBrNyFB0vB7HmGidUx01+wo7xL7KaLF/YX26tlrmck+2hAo/qblTZgUyRsc8uB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1EJCUoFe; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6818d68f852so26073a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716499080; x=1717103880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9x2cAYxI0ME8fv/6TArJaYakWUUv/hDKd/KCixzGcGs=;
        b=1EJCUoFean3bnHgKvXUnOX3TLVmm/BBxsxVr07pJaEDNZAzBuXKsLWDTR9Dz7rjiQ0
         XdXHvjvFtYY59M+Mao2Ung4emgC/TxKH2EhTVSz0DbaPz7AvSmM+iACmIa5Y7fvlh8OY
         gzB7gV6nVu194iR8tSgfpglaZgv9K5jR+j5ykpigpLcjQepI/3XGK7nnkiOh/wXT5xde
         jJpRohJ+MkxGrdiih2Lm5yQROq7MwglZc81M8TVMd6yxpYD5TB0/0Pd1s/Iw7gBwlykn
         7vGBVfO447ZHpZwox7YdSYB99lOecRMPbqphwPkOFakffaSICww344Ypf/1GgnRY16Hl
         Fd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499080; x=1717103880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9x2cAYxI0ME8fv/6TArJaYakWUUv/hDKd/KCixzGcGs=;
        b=lSq52Wtg5Xy3S/vk7Aa6hxUnA+XVQOEjLw5GN/sEzuQD2fjecVgXgbxmAd2G+ZEJQg
         VNBrKmtZQ1g8UwuvYRdbjxkAJyX/ql0w6IdLVD6GWk3Wa0uOYWejTJZ2fPQcaubB/58e
         EJXyCwFrI4KbHV8LusdeKVeYy7j2R6mfakQc10ThglSIb0KF+N4oi2971DrVMYNaFAoX
         jdxGzaVR13jmjw0byAET+yJuiKqbhQXbMdK/DoAcXDpelg5+Kqmi/fD4oLfFIcrgspgS
         g58QTecIsU3QoSSVVsK2YyHgvqf57KWkbgxwo7hB0gRQvusHD9yLTE0FE3AWsrVPHun5
         yYhw==
X-Gm-Message-State: AOJu0Yyc6CWIRCoY9H+snSOPEvQHiFGE1zcmGyqnCD8JeFUAs/xV/Znk
	nvAC9Bmq6yWV2CajBrPfPvNc3uabvgQiJPiy1frrEWOVGsqrGQC6AjTFFmoiJdY=
X-Google-Smtp-Source: AGHT+IFPqXNO2VTX9Iyl5b1hKWGjN4iFLAdSovpsW5p3GBc3XUAB5wletIeCTP0MBlktWknbXZLtlw==
X-Received: by 2002:a17:902:e801:b0:1f2:fbc8:643c with SMTP id d9443c01a7336-1f448f2e808mr5711575ad.3.1716499079957;
        Thu, 23 May 2024 14:17:59 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c1::1060? ([2620:10d:c090:400::5:32c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c96f26bsm346775ad.127.2024.05.23.14.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 14:17:59 -0700 (PDT)
Message-ID: <359117d3-20e3-4c1b-a426-8ec1391ffec4@kernel.dk>
Date: Thu, 23 May 2024 15:17:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: invalidating pages is still necessary when io
 with IOCB_NOWAIT
To: Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
 Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20240513132339.26269-1-liuwei09@cestc.cn>
 <20240523130802.730d2790b8e5f691871575c0@linux-foundation.org>
 <Zk-w5n769fyZWTYC@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zk-w5n769fyZWTYC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 3:11 PM, Matthew Wilcox wrote:
> On Thu, May 23, 2024 at 01:08:02PM -0700, Andrew Morton wrote:
>> On Mon, 13 May 2024 21:23:39 +0800 Liu Wei <liuwei09@cestc.cn> wrote:
>>
>>> After commit (6be96d3ad3 fs: return if direct I/O will trigger writeback),
>>> when we issuing AIO with direct I/O and IOCB_NOWAIT on a block device, the
>>> process context will not be blocked.
>>>
>>> However, if the device already has page cache in memory, EAGAIN will be
>>> returned. And even when trying to reissue the AIO with direct I/O and
>>> IOCB_NOWAIT again, we consistently receive EAGAIN.
>>>
>>> Maybe a better way to deal with it: filemap_fdatawrite_range dirty pages
>>> with WB_SYNC_NONE flag, and invalidate_mapping_pages unmapped pages at
>>> the same time.
>>
>> Can't userspace do this?  If EAGAIN, sync the fd and retry the IO?
> 
> I don't think that it can, because the pages will still be there, even
> if now clean?  I think the idea was to punt to a worker thread which
> could sleep and retry without NOWAIT.  But let's see what someone
> involved in this patch has to say about the intent.

Right, the idea is that if you get -EAGAIN, a non-blocking attempt
wasn't possible. You'd need to retry from somewhere where you CAN block.
Any issuer very much can do that, whether it's in-kernel or not.

It'd be somewhat fragile to make assumptions on what can cause the
-EAGAIN and try to rectify them, and then try again with IOCB_NOWAIT.

-- 
Jens Axboe


