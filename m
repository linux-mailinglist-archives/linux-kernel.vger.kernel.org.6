Return-Path: <linux-kernel+bounces-512120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C6EA33450
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7941889EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD1878F24;
	Thu, 13 Feb 2025 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dBLoyGwr"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0142B9A6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739408275; cv=none; b=KUBGzLvQUq7E7NgdoASboe8GJc0vKmFcugKbwU7PC9z7Bn64nlSYQh63W1/B6U03KdIfPeibbAxodnsUgnmj8aLFWxc7kT4yeA44y2TRMwpBZXN8YMgpoTSxVnI9WOJIXhuqtypHjoFQcqG8IL70McMn1eD0h5Dt+QPIkloUN1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739408275; c=relaxed/simple;
	bh=r6lE2/D9hRfMBup2aHrBvYGCulQVa/mn1P0GfF7t20o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8xP4cP73bByvtkSFi4MmtAZ6aPB5HXF1osqI4UWqTExapv2ktpHRev31ZxGczgCgNiESLYrfCwcjAkvCFjLsqNFLr0QPPUdB8pHLXlwZuOG3n6o6WNyF5w9lP7nTNLhLI7s1cwRwtHIB1RU3e4Ey2Suop+P9moiwQhVNs7VuAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dBLoyGwr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso770999a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739408273; x=1740013073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gWSDWHDBJk4mPKKvXA7cp+JzSNkoJBuCEwXul/Db3Co=;
        b=dBLoyGwrBtDr6NRe4g5WgaSR9klhgmjQF2tfo8uhKeC4wLS8GXOHNspqe4vtxDi2Ob
         DnTTBJnuHM5Dez28aAI1TXB7H6OmlEuLN8H4Ke0bIZV5yg/AMy5efW/t4LmUHrjI2gX3
         k2U2ft3rswzivIe3qH3aYLkehj1gGLMrm0Sa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739408273; x=1740013073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWSDWHDBJk4mPKKvXA7cp+JzSNkoJBuCEwXul/Db3Co=;
        b=rXaPXe3PX1EEzdss3Jpuc673RotyBmGEyibWZt+JryN7BzUzVkJ2uCnbECLw8GfCMN
         75JZF85iOoaaPpCE4cPqOjPKSuO8UcJloBWu3qmvQexxf7la8D3Nbr4TInbhXHp1NTG2
         OxAbEufQQfpzcVdw4sOLHhHWkCf9sDiBGeuHH1wZBiBeGvMkE7aucTG6uJpHIxVK9/s0
         NlBgBCDOta6Znggx/jC9UsjCo8qili2DDOU2tvubD68KsT5IH7HauXrWymD7+T50FaKF
         dqQIAhO49VTo/ongtnIJS97lLs5pR7vG4UngZx9jBHJHuqYwMALA3AmEqptMIaiwlxj7
         OrLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/DewZDUOAWp4tGK0bnaLrFAp3LHFz7SI93KWCEoB6Wt5i/Hm2mFM65hNRrRAKGm5kCy1fNXjY/n6s0uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfnSlyUvt9kOFdTmDZrKZR+P06dNDaFhuX+w8kTk3ATHRsihbt
	DpdjcGtZ8o1nGU5DNqxmaYCbC7jegoKeqkeLaFRgtv6f+yCsB7nL9sqbkmnn+L7o9bRlajP7J5A
	=
X-Gm-Gg: ASbGncuo0dXW32pXfa0yCCyTvan7FH9dWEImzBlaN/o0NaR/Kh/cTeSyG12lP6lTiSq
	dPFSzhVxXNzYJqGckdMYVDUV1AIRe5JDgf1vIQf2l28nLXVjcrTfBvBnixyqYroi0kgmJT+Bxbt
	7wYAsjSNhWK5Su5j1pfOLxGC/kJJMRCU7es64EOXuz8k0Q+Q2G7yZ98pnAak3yX+70nzCEuFBym
	BWZiV8O1XnJ9nJWNbW3sclb67lDvnXA93rgv/UU5sK8QFP85f1Q4PqYUHb2UP1J/4y/+kwE/u1k
	uPcDj6Q0UMcBHZM2gXc=
X-Google-Smtp-Source: AGHT+IGB9KqF9IAMhrqzrI/AeAeLYzqAhbuoryuN4qs2PucLIe47WlIuNI4ci/dGDYV+2TqNbfG+/g==
X-Received: by 2002:a05:6a00:1404:b0:730:74f8:25c8 with SMTP id d2e1a72fcca58-7323c144064mr1950139b3a.11.1739408273477;
        Wed, 12 Feb 2025 16:57:53 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546efcsm76022b3a.23.2025.02.12.16.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:57:53 -0800 (PST)
Date: Thu, 13 Feb 2025 09:57:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/18] zsmalloc: factor out pool locking helpers
Message-ID: <5htndqx74yv2lq2zr2odozrrbi5cz6zizn3vk4uosobn4ceoji@5zuknjmi26f6>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-11-senozhatsky@chromium.org>
 <Z6zJxvLbRQ6pKtue@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6zJxvLbRQ6pKtue@google.com>

On (25/02/12 16:18), Yosry Ahmed wrote:
> On Wed, Feb 12, 2025 at 03:27:08PM +0900, Sergey Senozhatsky wrote:
> > We currently have a mix of migrate_{read,write}_lock() helpers
> > that lock zspages, but it's zs_pool that actually has a ->migrate_lock
> > access to which is opene-coded.  Factor out pool migrate locking
> > into helpers, zspage migration locking API will be renamed to
> > reduce confusion.
> > 
> > It's worth mentioning that zsmalloc locks sync not only migration,
> > but also compaction.
> > 
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> FWIW I don't see a lot of value in the helpers (renaming the lock is
> useful tho).

I want to hide the details, keep them in one place and at some
point *in the future* have the same "locking rules" as for zspage
lock.  Also *possibly* throwing a couple of lockdep assertions.
So I'd prefer to abstract all of these.

