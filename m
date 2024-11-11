Return-Path: <linux-kernel+bounces-404180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4FC9C405A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058481F212A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBC219E994;
	Mon, 11 Nov 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q3snAF8R"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93115A85A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334119; cv=none; b=Wd7v0JMVHnPlCdIfey4G5KITy1oZSWHV8ldaHsi2lk5wvmtoWXXlUSozT8U0Wq0SBaliWNhkP1ultVU98ujw9PjRYrf2feu1gG0dTLvlbjEQd7/jO8y+K6nqXnR7F12K2mLrvP+ZDOTiSA9QRLHasi3RbR2/E0OmTki6YXm9Apc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334119; c=relaxed/simple;
	bh=E8tHW6Lnm5Agt1nj4Y9Sm2FExVqtqCc30XCaxizWhIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBhfrdhofp0c277Z8FvTEIIOYOTI/ZK/YqKedhTe3yZbd4ytoVlDNxm25MwXgr0PVh+QyEcM0sYDTaoM5H/cPeic4EL2zZ9yMtEVVWf/o/7MxtLS4PYzPxex9RdFrMA2c+P4zxPBk7Pg+sC0U4GhOagn6rhHlhG2wFM/U4qI/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q3snAF8R; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2891055c448so1872415fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 06:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731334115; x=1731938915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmDn4fmT+hcwgS51qhVcBXpxC2DgB/s2ZMPiu9nNnjA=;
        b=Q3snAF8RqTO3ffAg9BOa+p/PcIuRcWG0ifbTaS56duy7UuQ/j9VBZBy1uGrIBq3aMQ
         HrvRRHVo9kPD5K5U+H0OCD4x+PC31ExIUZhc0udUsK7rU+iXRO2NboV1UNAYUasgiTZI
         ubpneZ+yPqcjcyMa4bZEgIWXuyL+FophYu/hj4Hp+E2YAI4TzHNIDKG5tj5ue9pncl0f
         X6CUukwIOcpq/ddwO88BQJ6/kldtssTSLcuJSo4isiNkE0TkifEBnsdb/yw9IuZslXQs
         mTKd9jL8WDcuNL6jGOsM2En9O+rXR6446/PF8vN4TeblxUegcomqdhK4Bk2lMNbx2E6w
         SsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731334115; x=1731938915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmDn4fmT+hcwgS51qhVcBXpxC2DgB/s2ZMPiu9nNnjA=;
        b=Pxm73DPmQfMPhwJ55qb3mIoT9ThvUsnUgSsuAQhs45c96mdGytfVCOn7TGKlsNLf0L
         dhwiGQWiwu7OcohpXmUrfWHyxyJztQ5yOenI4n7XA73RL+SWPRvRZcJq8cx1yIX7FD39
         rxoor5ddc4SjxMM0JmDDGoeh1QZ4Wjpx8dmntecmk7n7a4MaJ2r8sAgNABPl7gAaSOmx
         2NNAtoqwQOd4XZZ+hXKoRNIK11zu3OqILK89EnmlbiJwvRakisc76Y7UPs/Gus3gBsni
         6QsOHjdf9S39kNBijYYr8tnbSUbVgIKx4pPIzoTz+7lMKWRpEPAuXBhcAGJ6SL37xnBH
         k1bA==
X-Forwarded-Encrypted: i=1; AJvYcCXfoL/ESeqtaYMi73T7uUath1RporEdSW7Z2TmmhgrOO7J4l6fVtQG7HeRNhUQ7KejW3FTHAFsKRECA5Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6B9vHigl7Mt1lmDI7Pc/RumFfSd4VU+c68KKRjUV0fd1ZnZB
	blqibocedoXatuBj6lrX5q67HkwX+vNOjCv6LPyp9UWc2GQUWRKFFV/eSSfelPI=
X-Google-Smtp-Source: AGHT+IGdcCxlTJ6oOmUoz2nOosPJA727x85N6SHkCMBCewWNWdgUVALhVXS8gvGZ6CBRqRCpqZFcAw==
X-Received: by 2002:a05:6870:e6c6:b0:25d:f0ba:eab7 with SMTP id 586e51a60fabf-295600bf475mr10068218fac.18.1731334114914;
        Mon, 11 Nov 2024 06:08:34 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546eddb89sm2817619fac.34.2024.11.11.06.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 06:08:33 -0800 (PST)
Message-ID: <00c51f80-7033-44a0-b007-ca36842e35a5@kernel.dk>
Date: Mon, 11 Nov 2024 07:08:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v4] Uncached buffered IO
To: Stefan Metzmacher <metze@samba.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <63af3bba-c824-4b2c-a670-6329eeb232aa@samba.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <63af3bba-c824-4b2c-a670-6329eeb232aa@samba.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 5:55 AM, Stefan Metzmacher wrote:
> Hi Jens,
> 
> I'm wondering about the impact on memory mapped files.
> 
> Let's say one (or more) process(es) called mmap on a file in order to
> use the content of the file as persistent shared memory.
> As far as I understand pages from the page cache are used for this.
> 
> Now another process uses RWF_UNCACHED for a read of the same file.
> What happens if the pages are removed from the page cache?
> Or is the removal deferred based on some refcount?

For mmap, if a given page isn't in page cache, it'll get faulted in.
Should be fine to have mmap and uncached IO co-exist. If an uncached
read IO instantiates a page, it'll get reaped when the data has been
copied. If an uncached IO hits an already existing page (eg mmap faulted
it in), then it won't get touched. Same thing happens with mixing
buffered and uncached IO. The latter will only reap parts it
instantiated to satisfy the operation. That doesn't matter in terms of
data integrity, only in terms of the policy of uncached leaving things
alone it didn't create to satisfy the operation.

This is really no different than say using mmap and evicting pages, they
will just get faulted in if needed.

-- 
Jens Axboe

