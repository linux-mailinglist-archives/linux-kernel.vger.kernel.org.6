Return-Path: <linux-kernel+bounces-201672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB05D8FC19F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB17285040
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E822D4EB37;
	Wed,  5 Jun 2024 02:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l87G/C95"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E080F1EB36
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 02:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717553828; cv=none; b=roM8sEtFDz04ePjICoe9AA1GZRHZ47gNlW7rVH+ZOUCWyd2zAAvwjUn3i6iswiESuvXJpT5mwo9tcfmaRbcld7GM58YhAhwgVQZl2Ge2HN8q6G58xD17XVyBCaNddOypEwqwgFrBJYk/cPqepgkmEengpqg5AJq6Nuhgyfgxi/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717553828; c=relaxed/simple;
	bh=MLfPfaoRWzUtkJbb03QMNFwwSc4Jj5l8BHZun+Zm9tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npLqqPBHAY1IUPfPrCokFniXzWA0DewAVi96j1zVoKl3j47WZbgsib8VKx2ipqduiGe9zyQPx/rGh/A1CWEn3z7F3qzcotzr0qmghLwsQSe4Pw0r1J3XV5VeXzCszjTooTCVWlC+PUBahjxXeqfTDhzftc5MKd79HQtb1k3CvYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l87G/C95; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6c5a6151ff8so1403804a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 19:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717553826; x=1718158626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mmUqGT6R1ALyKLT05MMVBNync2sESvjPRIFmm8CcRyI=;
        b=l87G/C95InJSUvSyfWONXhMOKgPY/3LUnMn8iG52nRdPrWeh+ARSF1VSbfSNCFT1/S
         gIPepG8JpCNsj48tbNFpAgjGmUBQso9lm7GWVEImNo5F/9dMmXw2wVE4x/etSsle4yav
         lx3o/PG/pSefS5pAHoxt0iXnDh4qRMowT8nUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717553826; x=1718158626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmUqGT6R1ALyKLT05MMVBNync2sESvjPRIFmm8CcRyI=;
        b=DWCTYDyCyV9qSSIm5U/D9dEyHQ0iN5CotRg+p0EofVRTiCLTavR7298GoQV5WDpnPb
         X+ysKbH+6f+oPT8aIzVb740ZQaIpjD+hL7bau5p7jLTYdMuN+55LlY+u2Id2R0aUFpn3
         XKVcMwhkbXoKcjYKUQhFVZAD7zrlde8m639wYmdMlcqGuhhge6SzTEVriD18NYbusp09
         cZGQZ6uo/8yb4/AdZId7bpMZ4GC4o6mfabcxo+MjH68qZuleh2p44qr4cNKc7vmiDsOf
         tNFL7RFJ9WpHTUZqB2vUVUozm5waODYj4O5roUQiaYkSFGR+le3Vn0A5pNs63iuqweI1
         qKTw==
X-Forwarded-Encrypted: i=1; AJvYcCVJY+YdOLFLbT2POtPkn02hAZBBLZKdOJcOOYGOkZINfxP0ygDz2nbJuG+JMvMu4ugCltPBtduWSXwO5L/eIAmgaip+ragkmjHnTxJn
X-Gm-Message-State: AOJu0YxlRFZc3raRAFpTOSO0g5/lBjWSnyt5USdvxSHv6vfH0DNw+/S+
	X0JLxtKoGr71wSodY3O7+3QjhrxIu3BWSXZQ0XiuR5KgWd32DSN1rcxNOzW+zg==
X-Google-Smtp-Source: AGHT+IHMmAk8/qxOtTT8yRi3dQLozZNnAXY3KVFXiLbMylIWGljhiXvbuvAbtK5cf8CRLuS4ZWveRQ==
X-Received: by 2002:a05:6a20:7348:b0:1af:f8e7:76d4 with SMTP id adf61e73a8af0-1b2b6ed9cbemr1830288637.18.1717553826123;
        Tue, 04 Jun 2024 19:17:06 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:72fe:f923:2f3c:6cd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd73esm90373315ad.158.2024.06.04.19.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 19:17:05 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:17:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Rientjes <rientjes@google.com>,
	Christoph Lameter <cl@linux.com>,
	Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zsmalloc: share slab caches for all zsmalloc zpools
Message-ID: <20240605021701.GB11718@google.com>
References: <20240604175340.218175-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604175340.218175-1-yosryahmed@google.com>

On (24/06/04 17:53), Yosry Ahmed wrote:
> Zswap creates multiple zpools to improve concurrency. Each zsmalloc
> zpool creates its own 'zs_handle' and 'zspage' slab caches. Currently we
> end up with 32 slab caches of each type.
> 
> Since each slab cache holds some free objects, we end up with a lot of
> free objects distributed among the separate zpool caches. Slab caches
> are designed to handle concurrent allocations by using percpu
> structures, so having a single instance of each cache should be enough,
> and avoids wasting more memory than needed due to fragmentation.
> 
> Additionally, having more slab caches than needed unnecessarily slows
> down code paths that iterate slab_caches.
> 
> In the results reported by Eric in [1], the amount of unused slab memory
> in these caches goes down from 242808 bytes to 29216 bytes (-88%). This
> is calculated by (num_objs - active_objs) * objsize for each 'zs_handle'
> and 'zspage' cache. Although this patch did not help with the allocation
> failure reported by Eric with zswap + zsmalloc, I think it is still
> worth merging on its own.
> 
> [1]https://lore.kernel.org/lkml/20240604134458.3ae4396a@yea/
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Makes perfect sense, thanks.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

