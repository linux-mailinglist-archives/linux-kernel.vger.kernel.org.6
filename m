Return-Path: <linux-kernel+bounces-180566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295998C703F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17971F21656
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE394436;
	Thu, 16 May 2024 02:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CUcvsj5s"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9EC139F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715826077; cv=none; b=WOlU7dkWwlCFoYSMQ2n0HFd4sCyIyn3jQzdrZ5L4tGMm+tm5ejvfTf+ahpR4F/dDMaKvWKsq8s7uPsAtqVWVUc0vR3HegP/KV7ssD1MbFPsiipCE6wo3+fF8wsLkLlyLoXxC9r1IO1JIDO0yS/Uc4dWNYw4eEabTViZmiDQmP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715826077; c=relaxed/simple;
	bh=+nqrNVmYmohfUrprPzD9C57d3zHyTeg7Lioodc9p4g4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fiqIWe5myy+yIYLdThAPFegDVIMu78T9+zcuTAIowyFnQjIwaYtFQ6TKZxkbQarYnzZugVifga4JX6GijZgikW2aPmyjvYKtYoH9IgEyY2Hgbx+L5Bz8nHivOaXJQEyyGU23WsRF7eYbzrMCBYHTXngI0vB0opoAXDdNo6O/mhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CUcvsj5s; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c9b5776fbfso381315b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715826075; x=1716430875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXSD811bYryV9ebSAntCLnwE4mJzzmb6s7DeS7yDo6M=;
        b=CUcvsj5sonSvj7lF7ElggVjGiNhtZN6I94+ShduIWD8EI9vcHl33AMM4pu6K2UaIhW
         AavsrkqmmlfEeKGaDcpvVlO71jdpZv9oeGpAOVcx3b1YXazjwXmCsL9u4tUNE7W21qED
         /8+OOhWWjSBHfoMi15vSSsGwKi62gmoGv96SI1Nu7DuMGZoPmHYWszzSLEvkzecGsMtM
         YH2DcK9W4i4YkwIYhUAwDk2gxuI0LQPA/OZwiOqbhcirwRCJ//jl7CPkFZztpxr80Mh0
         T+q8+4PoyuyePihpv+3jJ7QTgJnW/9hoKdfS6iBF0w3itT8DkzO3HS2S5jFCp5BmygJE
         gyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715826075; x=1716430875;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXSD811bYryV9ebSAntCLnwE4mJzzmb6s7DeS7yDo6M=;
        b=MspiREOjQLNda8C4azrQTieVaNG4w7a4mdTkT8LVq9MfbV/waFQ2B/2HmT0ENINpQZ
         8xsMDtgOdAbmq9m41g8evFd0fLmhf7lkW0URMyStQ3wecmP/dyHpIrdwllfX+IpkU2cX
         IiwcKQHLzmHscZizGiVRYk+ZmxYjG+fl9zTrZlI7vK5zKbEqInk4iz2alTqOFaHXTshW
         QFd+AT2HPi19Oymc33PEadObty6xDSFGHKWmwP7WF3N9dltmrWvzuvrzvm3VnwvAt8K2
         3C8jNP1bkDtAWkCMdSJax/9gZ6ySTgSooMr4bXZKR0VyZNhQFRyfNuvGJPStBXj91k8f
         AeXA==
X-Forwarded-Encrypted: i=1; AJvYcCXoRIgk6lmkVFGO4F9VC8+bbWGjEJ/OdYImIESVogLlsJ8Yjn09xby3BYUM6VVAf45IxFhepuLUg02QBHXWIHpMuw+7plaRe5XsY4EL
X-Gm-Message-State: AOJu0YwDXxuPBul6Myl0YfvyqMhT6419N4rKvNc/bjClXrZrFaLYF4//
	NjpxnSojkPYFYmyzK2yWtp5bypmBjRhRmdzcja8nazoZGNCJ7U44SePJtNYPvIw=
X-Google-Smtp-Source: AGHT+IE3ahqmTSWsWI6SW0+bQ2oqoZ8kOwwhZn9lRGyp4StkWsHF4AWWVqRGdIlz+iKka73bNy5xEQ==
X-Received: by 2002:a05:6830:14cd:b0:6f0:e2aa:ea49 with SMTP id 46e09a7af769-6f0e92ce674mr20305110a34.3.1715826075518;
        Wed, 15 May 2024 19:21:15 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634024a3eb4sm12257551a12.0.2024.05.15.19.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 19:21:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Waiman Long <longman@redhat.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Schatzberg <schatzberg.dan@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20240515143059.276677-1-longman@redhat.com>
References: <20240515143059.276677-1-longman@redhat.com>
Subject: Re: [PATCH] blk-cgroup: Properly propagate the iostat update up
 the hierarchy
Message-Id: <171582607425.11025.1197820625337989209.b4-ty@kernel.dk>
Date: Wed, 15 May 2024 20:21:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 15 May 2024 10:30:59 -0400, Waiman Long wrote:
> During a cgroup_rstat_flush() call, the lowest level of nodes are flushed
> first before their parents. Since commit 3b8cc6298724 ("blk-cgroup:
> Optimize blkcg_rstat_flush()"), iostat propagation was still done to
> the parent. Grandparent, however, may not get the iostat update if the
> parent has no blkg_iostat_set queued in its lhead lockless list.
> 
> Fix this iostat propagation problem by queuing the parent's global
> blkg->iostat into one of its percpu lockless lists to make sure that
> the delta will always be propagated up to the grandparent and so on
> toward the root blkcg.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: Properly propagate the iostat update up the hierarchy
      commit: 9d230c09964e6e18c8f6e4f0d41ee90eef45ec1c

Best regards,
-- 
Jens Axboe




