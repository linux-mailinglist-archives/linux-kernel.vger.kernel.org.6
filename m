Return-Path: <linux-kernel+bounces-418613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9839D6377
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B3E288012
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAE31DF742;
	Fri, 22 Nov 2024 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="G8d4pSlO"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51EA14C588;
	Fri, 22 Nov 2024 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297406; cv=none; b=Tdfj+/uQU+FajWOz5pcSxO6s/lbBWEUZuLbokqhJIwFKU3RACar5w752c3/xu29eO1qEDW1Sq2FuzyvF2rZTomx1Qg3zMcleSoXhc0DwBxYNk3cXMq178ufZdJDCFINj5cgyr3j2LuA4dl8kUgMBCazDqb3xhDQONb6cxoGyg70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297406; c=relaxed/simple;
	bh=fFwijfOxlZhyLjC5cvqXE1Ic8nJUU0MnYP3m78oxHic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1fdjil8it9F7urw0eP8+7HbUFLisIYjoH1vxUU2ZEm8gFtilnldC/qH/IrgxvPreAvq7XznHXTE7OJgnwBDG9JPKWNhEF/8chCZESzLXe8WGHvfLnFtmLVGMu4NcEWAHbshq1sTkSmxg1X83xXED7q9JVqw8/LIHs4JuBYGwv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=G8d4pSlO; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3C08B403E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1732297404; bh=8f7TkqLwm2GzCFQWbTk383Q+0EWsnQUJoRH4kQSYV94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=G8d4pSlONfpO5NNa7ozuMAV4AieIakFDb9dq3yd25aTUQMnq27cIwMD4RZjQmuuja
	 Z94gTv0RElkMXIZmukRin+If/W8DPZzuGLCReP/TVx9v1porZC/wdQZ+smJjQcQJ5g
	 42FcjW1FNOT1pYrxoNPlMcRA2RQ0ZQfXfOxgLnT7iOIElxUM6ny+3RfvGhRb1luu4J
	 DDq/5mpvttdvUimUKU3ftCfcLHOsehUQ69theE9tYaOBwgkEHhH1KFHCJfpGYgqWQe
	 VUyAuRpenqGxXkznWqNEgOFa7S9ZDHF1UVsqaBZPy0RNH0TITWMyeo/TGvXEK5H7ih
	 Ywhaf5950AGrw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3C08B403E5;
	Fri, 22 Nov 2024 17:43:24 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Hocko
 <mhocko@suse.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH] docs: core-api/gfp_mask-from-fs-io: indicate that
 vmalloc supports GFP_NOFS/GFP_NOIO
In-Reply-To: <20241119093922.567138-1-ptikhomirov@virtuozzo.com>
References: <20241119093922.567138-1-ptikhomirov@virtuozzo.com>
Date: Fri, 22 Nov 2024 10:43:23 -0700
Message-ID: <87mshr2mh0.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pavel Tikhomirov <ptikhomirov@virtuozzo.com> writes:

> After the commit 451769ebb7e79 ("mm/vmalloc: alloc GFP_NO{FS,IO} for
> vmalloc") in v5.17 it is now safe to use GFP_NOFS/GFP_NOIO flags
> in [k]vmalloc, let's reflect it in documentation.
>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
>  .../core-api/gfp_mask-from-fs-io.rst          | 20 ++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Applied, thanks.

jon

