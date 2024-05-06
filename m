Return-Path: <linux-kernel+bounces-169275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526ED8BC62D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 05:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09681F20F8D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 03:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB53D962;
	Mon,  6 May 2024 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QHI2pWvz"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDBA42062
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 03:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714965734; cv=none; b=fELGmX7hYT3AdPDAI04lYBZbhhZW5VAj3otQHoy/5KG1C9q8sMlFx02Z9i0Gw2jbzI3NUpVj4ApHBX3G+1wu24F1UduLbWPsIvM5PVrgskAGJSwFpJXt26uHmwLPmSey+a/WDVHqwXr3oZXmZ5fi5aK0Xikids9NXb4+fj4771U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714965734; c=relaxed/simple;
	bh=jDX8ASW2qvZ6KlbWPKGaSk28mv6B6mlsXMCBys2++Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2SyBnzjZh4rvUaun71ulzknu/nGSbpmTcYSd6AX79rRMLVr0P2hFyjVAZNoYz1ag2ueBg0rFeXXO6sz0nOUEiRzbaTJDxMWyU1PzdORz67F8lpLax01Nnd2UnaSIeMg871UeTzkaXGsDom3ZAGxwps6zVQPavn1l1H3OUk39mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QHI2pWvz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so14413635ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 20:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714965733; x=1715570533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLj2W08/AlPxLeXkCP61XrllXdJOfYp00hdT7d+0hkI=;
        b=QHI2pWvziVZi+K8ZQplusfpOnfzn0r91HNLtyjHO7OrPWj2VADftUxIywNK67qQqud
         qNEiMy2BwuyYZjMU24SBqL/SHQAVlkToVFDMZwOXr7KixGUqlPIyVrIM0tgRWrx1vquH
         P/RidO5HwkpVFuBl/8qC8LmfCDwhLzqda250w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714965733; x=1715570533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLj2W08/AlPxLeXkCP61XrllXdJOfYp00hdT7d+0hkI=;
        b=fJC+qxeCojsRGJ3R1HdVwXLYQMzDvNAHanZ2hRToFCKZlwCqmJTPaAuaz/dWEBtDki
         rgi2AULOVDsZuzSqtmKdwxjh3k8GwvOlcOtZ+dee+8toa1uOiHaQZVJvGYoS04lXjzSW
         XHKgF7ojWyq0uGgSgY8hCFaRWOL9wz9YPeiK3cKOUhcYyKIpHBf7NTgx4eO9bHXkCd3j
         YVM1TOoUTPr6wdsZcxD5jIwAQUKkcIPj35lVps+b2uA5YYGrDmzbzxIOYN6BzoiLNTk/
         JashbP4qYm4YFf7GhvG5ILdQnQUTugIsprg0bSb0tla1dxNUZrvMfeNNLKIhhOIPIRAR
         DVDA==
X-Forwarded-Encrypted: i=1; AJvYcCUR/LM+3dSoaVDFL8K+YjlEz2L5XTFpAUJpJZaD1idVB1x5piH5SEShVaBn/lWNBUZf/UGSllmItyIY2YzeqAJ1LdxbKfOJo+sUmkLx
X-Gm-Message-State: AOJu0YyBbox9oDQum7H/spaZqt/KkGoisbfg0Ua6DaTDuPSS0oulzfiT
	HWUOrfJOIVSJPaz40R+XSZ9wVWuI/317KSvs5CmfKKTlsUETejn0V0GKtJIrdQ==
X-Google-Smtp-Source: AGHT+IHdGPyGQrnvWR5Admmi4idMQxhyP5nB96L+iNkf96/MgdQqtZ5qsVJTxOQ1cKRQu2U3zrqpXw==
X-Received: by 2002:a17:903:8d0:b0:1eb:7ba:a4c3 with SMTP id lk16-20020a17090308d000b001eb07baa4c3mr16253443plb.48.1714965732789;
        Sun, 05 May 2024 20:22:12 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8263:3b89:bcee:2ed4])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902d4c700b001e249903b0fsm7134459plg.256.2024.05.05.20.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 20:22:12 -0700 (PDT)
Date: Mon, 6 May 2024 12:22:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kbuild@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, Minchan Kim <minchan@kernel.org>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 08/14] zram: check that backends array has at least one
 backend
Message-ID: <20240506032207.GD8623@google.com>
References: <20240503091823.3616962-9-senozhatsky@chromium.org>
 <202405041440.UTBQZAaf-lkp@intel.com>
 <20240504071416.GH14947@google.com>
 <20240504161004.f5a0aab5e5aa1033d4696c20@linux-foundation.org>
 <20240505043957.GA8623@google.com>
 <20240505051305.GB8623@google.com>
 <20240505064832.GC8623@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505064832.GC8623@google.com>

On (24/05/05 15:48), Sergey Senozhatsky wrote:
> On (24/05/05 14:13), Sergey Senozhatsky wrote:
> > On (24/05/05 13:39), Sergey Senozhatsky wrote:
> > [..]
> > > > I guess just pick one if none were selected.
> > 
> > How do I pick one if none were selected? Does Kconfig support
> > something like that?
> 
> This triggers Kconfig error:
> 
> config ZRAM_EMPTY_BACKENDS_FIXUP
>        bool
>        depends on ZRAM && !ZRAM_BACKEND_LZO && !ZRAM_BACKEND_LZ4 && \
>                !ZRAM_BACKEND_LZ4HC && !ZRAM_BACKEND_ZSTD && \
>                !ZRAM_BACKEND_DEFLATE
>        select ZRAM_BACKEND_LZO
> 
> 
> drivers/block/zram/Kconfig:17:error: recursive dependency detected!
> drivers/block/zram/Kconfig:17:  symbol ZRAM_BACKEND_LZO is selected by ZRAM_EMPTY_BACKENDS_FIXUP
> drivers/block/zram/Kconfig:52:  symbol ZRAM_EMPTY_BACKENDS_FIXUP depends on ZRAM_BACKEND_LZO
> 
> 
> I'm a little surprised by this - EMPTY_BACKENDS_FIXUP does not depend
> on ZRAM_BACKEND_LZO, it depends on NOT ZRAM_BACKEND_LZO.
> 
> Let me Cc linux-kbuild. Kbuild folks, how do I workaround this?

Is this how one does it?

config ZRAM_BACKEND_LZO
       bool "lzo and lzo-rle compression support"
       depends on ZRAM
       default y if !ZRAM_BACKEND_LZ4 && !ZRAM_BACKEND_LZ4HC && \
               !ZRAM_BACKEND_ZSTD && !ZRAM_BACKEND_DEFLATE
       default n
       select LZO_COMPRESS
       select LZO_DECOMPRESS


User still can select N and then we'll have empty backends, but
at least default is Y if none of the algorithms were selected.
Is it good enough?

