Return-Path: <linux-kernel+bounces-330662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FA497A26D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A091D28B04B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D89156F36;
	Mon, 16 Sep 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Jqmv/nfq"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97143155C83
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490290; cv=none; b=KuCNdXn3QWSrvuaq2TR4W8YGPZKy3rxGbOKEB2rMA3i8K+agefmjPIsS2/6FtWUgT97uk+KHLr0uRnaYdoMrgaunCR9huIxYTDwaXUm28zmJ8zU1tMSUhJwW8hbaPqh4KsGAeQOSakd3NojfvfuF5HNejizwYXE8Bcro8iXlgU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490290; c=relaxed/simple;
	bh=7EhG9EbVTGqEsiK8x+VNzz9p7fj5lCIpORxLSBcfrP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzoGhppa+KXor3ruzhXsorB8JNV17/HaUu8/x85aed8WNDI03iXAu6w5Q3BhANSn4B7JPZ2TpDvqghnv3dxdxYRM+5ZK7tHH9PQ9uC+gk4zj+tAhxqCXG09bf6gh+0GEa3xaIwwX1603M9coq6EOrOguwLZaPSC2YLwreTyRwyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Jqmv/nfq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d64b27c45so531135166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1726490287; x=1727095087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KNBeOEHGq7Pser7VzvbTspy/A3zYw7bZRrBFbZEGNjk=;
        b=Jqmv/nfqpoO2L99oG2ltOBigQGM4qVA/mZLBR5mir4GfsVpT1NXcdXPfR517WwhlMS
         0zdoO2HUJU6MPwnk+eLaUW2YxD8PxPN8mKjEqf0DoU1mwP5wYHtGRLE67AI+FlDPuQws
         p6BuvD4CzCfG6IO/F+Ul8QdysdDIzmEBzh88JXJTsuCkZbyEfvtHYyFa9C9HZCM/TzNx
         2CfzOqsik9zVHNDVhXtie+F8RZTeAXuCgV9OzhTAiUPKOPpU/q4FMRe74FXApG8qVuvG
         9nrwhNlxU1B1VYIzD01NPjymKACYwEdEa0T45FdgCqNyRAjPUAb3vE0vuhjchAbfXiGY
         ZsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726490287; x=1727095087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNBeOEHGq7Pser7VzvbTspy/A3zYw7bZRrBFbZEGNjk=;
        b=g49ys3nXqXC2uJ8VUeXC6NOzo9U7UxCtk829zVRUcuPvr1LlW3zkfpHfYiwsxQmVRC
         DzT+ckJ8TOvxSo38oyL03Ogu5MAzKZyJv34Vf05sWmRF/XuFWWcS1AoykiiNAP8LqMnk
         CilHK9GOAVq6fEKJFAexvVPAJrVh4Twio4d0K7Bug4IIpqB/N7m9IYgP4RHnd7g8iHzN
         jVLEMBwG2lKyvDznb+QfDR7soOXhxsRQ+FUBGi8V3Yo1wT/qqGIyYWFDPxm3j7C+sD9w
         xqprH2kpp+mn+0Oh+XYPADIYFnGYwTzoUwSu22Iy4SBJwNTCzqPzMDUFQxYJCvC1TW5w
         fpPw==
X-Forwarded-Encrypted: i=1; AJvYcCUiqDPTQ9JmrLASvP2PWfFm9/d0fyb10FJmw7BOIjf3pWwz3i3H0KBfY/2WqK6QkEr+B6GSqhaT1gSSBMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJpWUVjlygN3q979tIHvYUZTJFGZyjpJwS3A//j/6Ke3RWPE2
	dc3HgLkLgt5SdBxC7g+KMw68k4TAaEscfLjhT1cccGpJXIXqxH9farQB0p1InNI=
X-Google-Smtp-Source: AGHT+IGOZcpAXmdIVEV2vYM9IhWJaJecvzLcXzXO10w2tECmYppWvm9paxVvWFyfXx7MUbTlLrDpRQ==
X-Received: by 2002:a17:906:f5a9:b0:a8d:51a7:d5ec with SMTP id a640c23a62f3a-a9047b4af68mr1200972366b.13.1726490286251;
        Mon, 16 Sep 2024 05:38:06 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3a0fsm308834866b.117.2024.09.16.05.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 05:38:05 -0700 (PDT)
Date: Mon, 16 Sep 2024 14:38:04 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: zhouquan@iscas.ac.cn
Cc: anup@brainfault.org, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/2] riscv: perf: add guest vs host distinction
Message-ID: <20240916-6f21ff3d12224f366ccaac6e@orel>
References: <cover.1726126795.git.zhouquan@iscas.ac.cn>
 <c62057d587f075a64442df1038fe27b52b89c997.1726126795.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c62057d587f075a64442df1038fe27b52b89c997.1726126795.git.zhouquan@iscas.ac.cn>

On Thu, Sep 12, 2024 at 04:00:29PM GMT, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> Introduce basic guest support in perf, enabling it to distinguish
> between PMU interrupts in the host or guest, and collect
> fundamental information.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/perf_event.h |  7 ++++++
>  arch/riscv/kernel/perf_callchain.c  | 38 +++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

