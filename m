Return-Path: <linux-kernel+bounces-297102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E1795B31E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AB11F217CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE31183CA7;
	Thu, 22 Aug 2024 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="3B338vkQ"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD614A0B8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724323414; cv=none; b=rlxdPLX9TjdBrKCy1MyvnODJIV3LaiStedK6vlIE2nmS0jwlgOKx3RX/RW9UAc9gMOo7Ci0yzaDo9ONO0V8+QHI82FHcjKibHcy6sawbzR/hpeMCv4Yd4IyOYzmbyp4Yi93UFMLCiO6kvYmAkvzwTpMocbJfIbHHivbmIZvGzoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724323414; c=relaxed/simple;
	bh=kJVJcT56IR1V30lqnrDg7zs6+KFy6e0tsOjefDV4t/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YntX88hkIAAP71oIP+kFMskYsy85h9P60i2I68/bzeO+s8jfFS8NWExm7HWBhkSss1KePHC3CZiOGgGSr0EfGp4hbhet4GGxL2y/eFSEsuVdE0MxsMwqE6yOXWxDxUNZyom/SZDr/qR309AwMKLEU1R4uqb6CazJSkP9bIE5pGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=3B338vkQ; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a86933829dcso60212066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1724323409; x=1724928209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X7qXZjqbuxQ9UKFGGhuhFlxmK80Nt9TZndrNm3jf7CY=;
        b=3B338vkQBIjZn4dXxKCb7G8mp/YuuHxCHY/gcOjd1QMhRLZX7YQVVpOS6rza7AxZf1
         g8lDByw3XcUjLuq0eayWgiJVUoltpNQOMqVu3lZxgkYgDFMcZvPedNJvLNZFb7+CnS52
         /4DoVg0bXveUYkfo4Ih8fTFtTLTjCSJOAh0nqwUkZDefNakq3ixvxBVXT20ffnJQopLv
         VHLU224etv/qmeOEA0Z9jHGWJkqTt1wao7WVyowjlT2fiUTuLhyOP0Q51/ne1TZmVTuq
         1AqQdJN/+mhyY2Hh4C5Qi04A5npspIc3qUEfIxA9lkjg0ZxybP7pkGyBkas/6H86hiHw
         j2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724323409; x=1724928209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7qXZjqbuxQ9UKFGGhuhFlxmK80Nt9TZndrNm3jf7CY=;
        b=SiRpUi5W5/7GQ2vrgrUibfEtN8qLUCnHV7CUHgRW5dSFpEtM8cY6aWwsyrp0EHcow7
         e/LF1PPV/kNXaS3MxvJfgmhajYaBM3/RM3AV0xaSWG8UtmZslI+8fxh6l9ez7WatJsuy
         lqc0Y6wq8gZ3PAnXiZfnsH6Sm6S2AIFFgvT9l+RKCj9m7Zq8WFPGzcsrKDTO41CzUlTH
         2byjUWDi+KWLKWf1FMd3KDoNd3GPRfFOy47lBkrwaia7Vvwd3k/S4FWzKbyEgYueUH9y
         Qj36yPTiS+gwQpgdrm4HoCVGTSjnRT/AtCnghFygxZQ0PTHN65yMlC7OOXLoauP/QJw2
         oh/w==
X-Forwarded-Encrypted: i=1; AJvYcCXjWX+f3RX0cNFU5g+cSdxCMHaBjdxUvq+shSWbh6mwx6MIsaUZSBbvU6cBTCqrG3dnCX1TAPC145q0XH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBF+fQJ7062hF9PS7HZ++9CDkIQ2zaOoQmvrg8WYO+WsiEKEX0
	SYpA5K17euyHSZHxufWvsQNtLxaigIJsD7hPBdnEunXjmFnVJfMMawMqy8idkGI=
X-Google-Smtp-Source: AGHT+IGLUcOLrcDhsIdscaTc8L4/bE4ASSmhaWE1xcO0wkYTT+gt/llVeQdB26M68gg+TPo6R4zcbg==
X-Received: by 2002:a17:907:9406:b0:a7a:a5ae:11b7 with SMTP id a640c23a62f3a-a866f902e67mr383193566b.49.1724323409181;
        Thu, 22 Aug 2024 03:43:29 -0700 (PDT)
Received: from localhost ([2a02:8071:8280:d6e0:e324:b080:c95e:f348])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f62f1sm101025366b.218.2024.08.22.03.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:43:28 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:43:23 +0200
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, riel@surriel.com, zhaoyang.huang@unisoc.com,
	yuzhao@google.com, david@redhat.com, leitao@debian.org,
	huangzhaoyang@gmail.com, bharata@amd.com, willy@infradead.org,
	vbabka@suse.cz, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] Revert "mm: skip CMA pages when they are not available"
Message-ID: <20240822104323.GA315708@cmpxchg.org>
References: <20240821193506.1525996-1-usamaarif642@gmail.com>
 <9060a32d-b2d7-48c0-8626-1db535653c54@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9060a32d-b2d7-48c0-8626-1db535653c54@gmail.com>

On Wed, Aug 21, 2024 at 03:53:21PM -0400, Usama Arif wrote:
> From 1aae7f04a5cb203ea2c3ede7973dd9eddbbd7a8b Mon Sep 17 00:00:00 2001
> From: Usama Arif <usamaarif642@gmail.com>
> Date: Wed, 21 Aug 2024 20:26:07 +0100
> Subject: [PATCH] Revert "mm: skip CMA pages when they are not available"
> 
> This reverts commit 5da226dbfce3a2f44978c2c7cf88166e69a6788b.
> 
> lruvec->lru_lock is highly contended and is held when calling
> isolate_lru_folios. If the lru has a large number of CMA folios
> consecutively, while the allocation type requested is not
> MIGRATE_MOVABLE, isolate_lru_folios can hold the lock for a very long
> time while it skips those. For FIO workload, ~150million order=0
> folios were skipped to isolate a few ZONE_DMA folios [1].
> This can cause lockups [1] and high memory pressure for extended periods
> of time [2].
> 
> [1] https://lore.kernel.org/all/CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com/
> [2] https://lore.kernel.org/all/ZrssOrcJIDy8hacI@gmail.com/
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I think this is the right move for now, until there is a robust
solution for the original issue.

But hould b7108d66318abf3e060c7839eabcba52e9461568 be reverted along
with it? From its changelog:

    No observable issue without this patch on MGLRU, but logically it make
    sense to skip the CMA page reclaim when those pages can't be satisfied for
    the current allocation context.

Presumably it has the same risk reward profile as it does on
conventional reclaim, with long skip runs while holding the
lruvec->lock.

