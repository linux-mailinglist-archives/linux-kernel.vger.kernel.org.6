Return-Path: <linux-kernel+bounces-172828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CDB8BF73E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDD21C228A0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421E63B798;
	Wed,  8 May 2024 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jXEgbqkf"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C1F2C6B9
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154094; cv=none; b=tmNh1azLd0QK2C5aGiKYe9B5+MTSzyCh7aQ3CJx+ExsV+aCP/5hExoObFwTDQrzqoLr0pwqwNySgGiqCWkmrFgNI9xGfwwRbqcjOZB74Yk9FYEt9Op/zx6dYOiB0+2KbPgsLB5nZ9CbOaet8CZZ/VrqHLuSIYFG73oi21UA29KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154094; c=relaxed/simple;
	bh=gbESP1QETSXIHhn8KYELBw6pMRCJ9N4ypoUb0Pxk4MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUG8uKMboLbvk1TyUR+PM/4SYurc0LqovayQe8KapbsjFJ59m0JUiMdS2S2Qt0ZglXNy6qYSrwIGbgzx7+Vby5NH11ALlw+NFyAqrv310Z3uflSv4dPURYeWk+xcGCexcyXB1P/Wy0GGsib5u0RqmopAflC/avslf6hyZZQRlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jXEgbqkf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ed012c1afbso4698265ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154092; x=1715758892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E0r3IrBqTHQaJKbAMA6Mm9iZI63fDx9y82yERkqABZI=;
        b=jXEgbqkfltTRwy8AQ7Sd8GC0jxl8g9vpCIuxCSgL/hWeNEKmSQxyfwi/GgmNzGWWBU
         hddxQ8eolzUqemwOgD9To4sTqSp7EH4wbvClYh2bZzEdtN3QfYdyH5wpCiyfPfm7QJXi
         6CZsXKovyLuTEJRNL5W08ZVbZWI+FVamsgLIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154092; x=1715758892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0r3IrBqTHQaJKbAMA6Mm9iZI63fDx9y82yERkqABZI=;
        b=JUvNbkr9Cnas7qg0jqXOTt6mFZH43mt2Saj/6gDN5hXChUYlo1z4T3xOWvFePig2E7
         K/EPLseORV9mDCZ3HX8/7amF91rdY3+wzzRPEziDo+chCgc/pObUAotl+3x3j41Q9C3Z
         sHXpqng1/EEzYEUxhe+IC7zKFKxmAcmsuDj8l+S7RuzOlgxMLIGgXUtb0UO1TtDe7j8Q
         l95FY0b19EmH23PomobnODeX2STM039cXNS6MczddMAfszXQMNX1xmWqUoLlFYGnj5F+
         o7aiJLIS0AlkuT+gqxSn2WAOj1z49+99u+1q5QgEy7xGlx077buj/GFea2svkPKdyA7T
         spRg==
X-Gm-Message-State: AOJu0YzQBcjmaGF+KSnkRS/hceOEPm0OmPZnMuiJpc4Je0IW5pygwp2D
	MtGS526QqoAEBi1Z2pWt59ta6jnHtduMu13Rd3H2TKavfttsypaPEzvwTUey0g==
X-Google-Smtp-Source: AGHT+IGGJTY/PIGzQdtKKuV5fOUdLeYQsPqQYivASH6U4VOoA/T0QIDsMdiekFLUtNsr9TSBWXVJ8A==
X-Received: by 2002:a17:902:d4c2:b0:1ea:657f:318f with SMTP id d9443c01a7336-1ee6235c6f3mr77503315ad.0.1715154092630;
        Wed, 08 May 2024 00:41:32 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090311c900b001e944fc9248sm11130369plh.194.2024.05.08.00.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:41:31 -0700 (PDT)
Date: Wed, 8 May 2024 16:41:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2 00/17] zram: convert to custom comp API and allow
 algorithms configuration
Message-ID: <20240508074128.GG8623@google.com>
References: <20240506075834.302472-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506075834.302472-1-senozhatsky@chromium.org>

On (24/05/06 16:58), Sergey Senozhatsky wrote:
> 	This patch set moves zram from crypto API to a custom compression
> API which allows us to tune and configure compression algorithms,
> something that crypto API, unfortunately, doesn't support. Basically,
> this seroes brings back the bits of comp "backend" code that we had
> many years ago. This means that if we want zram to support new
> compression algorithms we need to implement corresponding backends.
> 
>         Currently, zram supports a pretty decent number of comp backends:
> lzo, lzorle, lz4, lz4hc, 842, deflate, zstd
> 
>         At this point we handle 2 parameters: a compression level and
> a pre-trained compression dictionary. Which seems like a good enough
> start. The list will be extended in the future.
> 
> Examples:
> 
> - changes default compression level
>         echo "algo=zstd level=11" > /sys/block/zram0/comp_algorithm
> 
> - passes path to a pre-trained dictionary
>         echo "algo=zstd dict=/etc/dictionary" > /sys/block/zram0/comp_algorithm

I'll send v3 shortly, which adds pre-trained dictionary support to
lz4 and lz4hc compression backends. Apparently lz4/lz4hc can use
dictionaries pre-trained with zstd --init, just like zstd.

